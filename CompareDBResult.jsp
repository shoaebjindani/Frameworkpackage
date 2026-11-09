<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:set var="ddl" value='${requestScope["outputObject"].get("ddl")}' />
<c:set var="inSync" value='${requestScope["outputObject"].get("inSync")}' />
<c:set var="errorMessage" value='${requestScope["outputObject"].get("errorMessage")}' />
<c:set var="sourceSchema" value='${requestScope["outputObject"].get("sourceSchema")}' />
<c:set var="destSchema" value='${requestScope["outputObject"].get("destSchema")}' />





<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Schema Comparison Result</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="mb-0">
            <c:out value="${sourceSchema}"/> &rarr; <c:out value="${destSchema}"/>
        </h4>
        <a href="showDBComparator" class="btn btn-outline-secondary btn-sm">Back</a>
    </div>

    <c:choose>
        <c:when test="${not empty errorMessage}">
            <div class="alert alert-danger"><c:out value="${errorMessage}"/></div>
        </c:when>
        <c:otherwise>
            <c:if test="${inSync}">
                <div class="alert alert-success">Schemas are in sync for the compared tables.</div>
            </c:if>

            <div class="mb-2">
                <button type="button" class="btn btn-primary btn-sm" onclick="copyDDL()">Copy</button>
                <button type="button" class="btn btn-outline-primary btn-sm" onclick="downloadDDL()">Download .sql</button>
                <span id="copyMsg" class="text-success ms-2" style="display:none;">Copied</span>
            </div>

            <textarea id="ddlOutput" class="form-control font-monospace" rows="28" readonly
                      style="font-size: 13px; white-space: pre;"><c:out value="${ddl}"/></textarea>
        </c:otherwise>
    </c:choose>
</div>

<script>
function copyDDL() {
    var ta = document.getElementById('ddlOutput');
    var done = function () {
        var m = document.getElementById('copyMsg');
        m.style.display = 'inline';
        setTimeout(function () { m.style.display = 'none'; }, 1500);
    };
    if (navigator.clipboard && window.isSecureContext) {
        navigator.clipboard.writeText(ta.value).then(done);
    } else {
        ta.select();
        document.execCommand('copy');
        done();
    }
}

function downloadDDL() {
    var text = document.getElementById('ddlOutput').value;
    var blob = new Blob([text], { type: 'text/plain' });
    var a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = 'sync_<c:out value="${sourceSchema}"/>_to_<c:out value="${destSchema}"/>.sql';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}
</script>
</body>
</html>
