package Frameworkpackage;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Collections;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.RequestContext;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

public class MultipartCachingRequest extends HttpServletRequestWrapper {

    private final byte[] body;
    private final Map<String, String[]> params = new LinkedHashMap<>();

    public MultipartCachingRequest(HttpServletRequest req) throws Exception {
        super(req);
        params.putAll(req.getParameterMap());
        body = IOUtils.toByteArray(req.getInputStream());

        final String enc = req.getCharacterEncoding() == null ? "UTF-8" : req.getCharacterEncoding();
        final String ct = req.getContentType();

        RequestContext ctx = new RequestContext() {
            public String getCharacterEncoding() { return enc; }
            public String getContentType() { return ct; }
            public int getContentLength() { return body.length; }
            public InputStream getInputStream() { return new ByteArrayInputStream(body); }
        };

        List<?> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(ctx);
        for (Object o : items) {
            FileItem item = (FileItem) o;
            if (item.isFormField()) {
                String[] old = params.get(item.getFieldName());
                String val = item.getString(enc);
                if (old == null) {
                    params.put(item.getFieldName(), new String[] { val });
                } else {
                    String[] n = Arrays.copyOf(old, old.length + 1);
                    n[old.length] = val;
                    params.put(item.getFieldName(), n);
                }
            }
        }
    }

    @Override
    public ServletInputStream getInputStream() {
        final ByteArrayInputStream bis = new ByteArrayInputStream(body);
        return new ServletInputStream() {
            public int read() { return bis.read(); }
            public boolean isFinished() { return bis.available() == 0; }
            public boolean isReady() { return true; }
            public void setReadListener(ReadListener l) { }
        };
    }

    @Override
    public BufferedReader getReader() {
        return new BufferedReader(new InputStreamReader(new ByteArrayInputStream(body)));
    }

    @Override
    public String getParameter(String n) {
        String[] v = params.get(n);
        return v == null ? null : v[0];
    }

    @Override
    public Map<String, String[]> getParameterMap() {
        return Collections.unmodifiableMap(params);
    }

    @Override
    public Enumeration<String> getParameterNames() {
        return Collections.enumeration(params.keySet());
    }

    @Override
    public String[] getParameterValues(String n) {
        return params.get(n);
    }
}
