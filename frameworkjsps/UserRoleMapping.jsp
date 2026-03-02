<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap + jQuery + Select2 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/@ttskch/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<style>
  body {
    background-color: #eef3f8;
    font-family: 'Segoe UI', sans-serif;
  }

  .card {
    border: 1px solid #dee2e6;
    box-shadow: 0 4px 10px rgba(0,0,0,0.08);
    border-radius: 12px;
    background: #fff;
  }

  label.form-label {
    font-weight: 600;
    color: #333;
  }

  .form-select, .select2-selection--single, .select2-selection--multiple {
    border: 1px solid #ced4da !important;
    border-radius: 6px !important;
    padding: 6px 8px !important;
    transition: border-color .2s, box-shadow .2s;
  }

  .form-select:focus, .select2-selection:focus, .select2-selection--single:focus {
    border-color: #80bdff !important;
    box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25) !important;
  }

  .select2-selection__choice {
    background-color: #007bff !important;
    color: white !important;
    border-radius: 8px !important;
    margin-right: 5px !important;
  }

  .btn-primary {
    background-color: #007bff;
    border: none;
  }

  .btn-primary:hover {
    background-color: #0069d9;
  }
</style>

<c:set var="userList" value='${requestScope["outputObject"].get("userList")}' />
<c:set var="roleList" value='${requestScope["outputObject"].get("roleList")}' />

<div class="container py-5">
  <div class="card p-4 mx-auto" style="max-width: 600px;">    

    <!-- User Selection -->
    <div class="mb-4">
      <label class="form-label">Select User</label>
      <select id="userSelect" class="form-select">
        <option value="">Search or Select User</option>
        <c:forEach items="${userList}" var="user">
          <option value="${user.user_id}">${user.username} - ${user.name}</option>
        </c:forEach>
      </select>
    </div>

    <!-- Role Selection -->
    <div class="mb-4">
      <label class="form-label">Assigned Roles</label>
      <select id="roleSelect" class="form-select" multiple>
        <c:forEach var="entry" items="${roleList}">
          <option value="${entry.key}">${entry.value.roleName}</option>
        </c:forEach>
      </select>
    </div>

    <!-- Buttons -->
    <div class="d-flex justify-content-center gap-3">
      <button type="button" class="btn btn-primary px-4" onclick="saveRole()">Save</button>
      <button type="button" class="btn btn-outline-secondary px-4" onclick="resetPage()">Reset</button>
    </div>
  </div>
</div>

<script>
  if (document.getElementById("divTitle")) {
    document.getElementById("divTitle").innerHTML = "User Role Mapping";
  }

  $(document).ready(function () {
    $('#userSelect').select2({
      placeholder: "Search or select user",
      allowClear: true,
      theme: 'bootstrap-5',
      width: '100%'
    }).on('change', function () {
      const userId = $(this).val();
      if (userId) getRolesForUser(userId);
      else $('#roleSelect').val(null).trigger('change');
    });

    $('#roleSelect').select2({
      placeholder: "Assign roles to user",
      theme: 'bootstrap-5',
      width: '100%'
    });
  });

  function getRolesForUser(userId) {
    fetch("?a=getRoleDetailsForthisUser&userId=" + encodeURIComponent(userId))
      .then(resp => resp.json())
      .then(data => {
        const roleSelect = $('#roleSelect');
        roleSelect.val(null).trigger('change');
        if (Array.isArray(data.lstUserRoleDetails)) {
          const assignedIds = data.lstUserRoleDetails.map(r => String(r.role_id));
          roleSelect.val(assignedIds).trigger('change');
        }
      })
      .catch(err => {
        console.error(err);
        alert("Failed to load roles for user.");
      });
  }

  function saveRole() {
    const userId = $('#userSelect').val();
    if (!userId) { alert("Please select a user first."); return; }

    const selectedIds = $('#roleSelect').val() || [];
    const payload = "?a=addRemoveRole&userId=" + encodeURIComponent(userId)
      + "&listOFRoles=" + encodeURIComponent(selectedIds.join(","));

    fetch(payload)
      .then(resp => resp.text())
      .then(msg => {
        alert(" " + msg);
        getRolesForUser(userId);
      })
      .catch(err => {
        console.error(err);
        alert("Failed to save roles.");
      });
  }

  function resetPage() {
    $('#userSelect').val(null).trigger('change');
    $('#roleSelect').val(null).trigger('change');
  }
</script>
