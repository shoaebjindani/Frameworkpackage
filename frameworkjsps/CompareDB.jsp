<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="schemaList" value='${requestScope["outputObject"].get("schemaList")}' />


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Schema Comparator</title>
    <%-- swap for your usual head include if you have one --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container py-4" style="max-width: 720px;">
    <h4 class="mb-1">Schema Comparator</h4>
    <p class="text-muted">Compares tables and columns. Generates DDL to bring destination in line with source.</p>

    <form id="compareForm" method="post" action="?a=compareSchemas" class="card card-body shadow-sm">
        <div class="mb-3">
            <label for="sourceSchema" class="form-label">Source schema (staging)</label>
            <select id="sourceSchema" name="sourceSchema" class="form-select" required>
                <option value="">-- Select --</option>
                <c:forEach var="s" items="${schemaList}">
                    <option value="<c:out value='${s}'/>"><c:out value="${s}"/></option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label for="destSchema" class="form-label">Destination schema (production)</label>
            <select id="destSchema" name="destSchema" class="form-select" required>
                <option value="">-- Select --</option>
                <c:forEach var="s" items="${schemaList}">
                    <option value="<c:out value='${s}'/>"><c:out value="${s}"/></option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label for="ignoreTables" class="form-label">Tables to ignore (comma separated)</label>
            <textarea id="ignoreTables" name="ignoreTables" class="form-control" rows="3"
                      placeholder="audit_log, error_log, tmp_import"></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Compare</button>
    </form>
</div>

<script>
(function () {
    var KEY = 'dbComparator';
    var form = document.getElementById('compareForm');
    var src = document.getElementById('sourceSchema');
    var dst = document.getElementById('destSchema');
    var ign = document.getElementById('ignoreTables');

    function hasOption(select, value) {
        for (var i = 0; i < select.options.length; i++) {
            if (select.options[i].value === value) return true;
        }
        return false;
    }

    function restore() {
        var saved = {};
        try { saved = JSON.parse(localStorage.getItem(KEY) || '{}'); } catch (e) { saved = {}; }
        if (saved.sourceSchema && hasOption(src, saved.sourceSchema)) src.value = saved.sourceSchema;
        if (saved.destSchema && hasOption(dst, saved.destSchema)) dst.value = saved.destSchema;
        ign.value = saved.ignoreTables || '';
    }

    form.addEventListener('submit', function (e) {
        if (src.value === dst.value) {
            e.preventDefault();
            alert('Source and destination schemas must be different.');
            return;
        }
        try {
            localStorage.setItem(KEY, JSON.stringify({
                sourceSchema: src.value,
                destSchema: dst.value,
                ignoreTables: ign.value
            }));
        } catch (err) { /* storage unavailable, ignore */ }
    });

    restore();
})();
</script>
</body>
</html>
