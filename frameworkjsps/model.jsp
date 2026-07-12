<style>
	.date_field {position: relative; z-index:1000;}
	.ui-datepicker{position: relative; z-index:1000!important;}
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="jspName" value='${requestScope["outputObject"].get("contentJspName")}' />
<c:set var="userName" value='${requestScope["outputObject"].get("userName")}' />
<c:set var="elementsDB" value='${requestScope["outputObject"].get("elementsDB")}' />
<meta charset="utf-8">
<!DOCTYPE html>
<html>
<head>
  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${projectName}</title>
  <link rel="icon" href="https://img.icons8.com/emoji/48/000000/cloud-emoji.png" type="image/png" sizes="16x16">

  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- CSS & LIBRARIES -->
  <link rel="stylesheet" href="css/jquery-ui.css">
  <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <link rel="stylesheet" href="css/site.css">
  <link rel="stylesheet" href="css/richtext.min.css">
  <link rel="stylesheet" href="plugins/toastr/toastr.min.css">

  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

  <!-- SCRIPTS -->
  <script src="js/common.js"></script>
  <script src="plugins/jquery/jquery.min.js"></script>
  <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
  <script src="dist/js/adminlte.min.js"></script>
  <script src="dist/js/demo.js"></script>
  <script src="js/jquery-ui.js"></script>
  <script src="plugins/toastr/toastr.min.js"></script>
  <script src="plugins/datatables/jquery.dataTables.min.js"></script>
  <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
  <script src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
  <script src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600;700&family=Inter:wght@400;500;600&display=swap');

    :root {
      --gold: #C9A227;
      --gold-bright: #E8C547;
      --gold-dim: #8a7220;

      /* Light mode */
      --bg: #FAF7EF;
      --surface: #FFFFFF;
      --text: #241F14;
      --text-muted: #6b6250;
      --border: #E5DCC3;
      --shadow: rgba(36, 31, 20, 0.08);

      --primary-color: #d4af37;
      --primary-soft: #e8c86e;
      --primary-dark: #b89122;
      --secondary-color: #6c757d;
      --background-color: #FAF7EF;
      --text-color: #241F14;
      --navbar-bg: #ffffff;
    }

    [data-theme="dark"] {
      --bg: #14120C;
      --surface: #1E1B12;
      --text: #F3ECD9;
      --text-muted: #A99C7A;
      --border: #33301F;
      --shadow: rgba(0, 0, 0, 0.4);

      --background-color: #14120C;
      --text-color: #F3ECD9;
      --navbar-bg: #1E1B12;
    }

    body, .content-wrapper, .wrapper {
      background: var(--bg) !important;
      color: var(--text) !important;
      transition: background 0.35s ease, color 0.35s ease;
      font-family: 'Inter', sans-serif;
    }

    /* ============================
       NAVBAR
    ============================ */
    .main-header.navbar {
      background-color: var(--surface) !important;
      border-bottom: 1px solid var(--border) !important;
      box-shadow: 0 2px 12px var(--shadow) !important;
      transition: background 0.35s ease, border-color 0.35s ease !important;
    }

    .main-header .nav-link, .main-header .nav-link strong, .main-header .dropdown-toggle strong {
      color: var(--text) !important;
      font-weight: 600;
      transition: color 0.25s ease;
    }
    .main-header .nav-link:hover {
      color: var(--gold-bright) !important;
    }

    /* ============================
       TABLE HEADER
    ============================ */
    table thead th,
    table th {
        background-color: var(--gold) !important;
        color: #fff !important;
        text-align: center;
        font-weight: 600;
    }

    td { color: var(--text); }

    .btn-primary {
      background-color: var(--gold);
      border-color: var(--gold);
      color: #fff;
    }
    .btn-primary:hover {
      background-color: var(--gold-bright);
      border-color: var(--gold-bright);
    }

    .modal-content {
      border-radius: 10px;
      border: 2px solid var(--gold);
      background-color: var(--surface);
      color: var(--text);
    }

    #divTitle {
      color: var(--gold);
      font-size: 1.2rem;
      font-weight: 700;
    }

    /* ============================
       NAV SEARCH BOX
    ============================ */
    #navSearchWrapper {
      position: relative;
    }

    #navSearchInput {
      width: 240px;
      border: 1px solid var(--border) !important;
      background: var(--bg) !important;
      color: var(--text) !important;
      border-radius: 20px;
      padding: 4px 14px;
      font-size: 0.88rem;
      outline: none;
      transition: width 0.3s ease, border-color 0.25s ease, box-shadow 0.25s ease !important;
    }

    #navSearchInput::placeholder {
      color: var(--text-muted) !important;
      opacity: 0.8;
    }

    #navSearchInput:focus {
      width: 300px;
      border-color: var(--gold) !important;
      box-shadow: 0 0 0 3px rgba(201, 162, 39, 0.15) !important;
    }

    #navSearchDropdown {
      display: none;
      position: absolute;
      top: calc(100% + 6px);
      right: 0;
      width: 320px;
      max-height: 360px;
      overflow-y: auto;
      background: var(--surface) !important;
      border: 1px solid var(--border) !important;
      border-radius: 10px;
      box-shadow: 0 10px 24px var(--shadow) !important;
      z-index: 9999;
    }

    #navSearchDropdown.show {
      display: block;
    }

    .nav-search-item {
      display: block;
      padding: 8px 16px;
      font-size: 0.88rem;
      color: var(--text) !important;
      text-decoration: none;
      border-bottom: 1px solid var(--border) !important;
      background: transparent !important;
      transition: background 0.15s, color 0.15s;
    }

    .nav-search-item:last-child {
      border-bottom: none;
    }

    .nav-search-item:hover {
      background-color: rgba(201, 162, 39, 0.08) !important;
      color: var(--gold-bright) !important;
      text-decoration: none;
    }

    .nav-search-item .parent-label {
      font-size: 0.75rem;
      color: var(--text-muted) !important;
      display: block;
    }

    .nav-search-item .child-label {
      font-weight: 600;
      display: block;
    }

    .nav-search-no-results {
      padding: 12px 16px;
      color: var(--text-muted) !important;
      font-size: 0.85rem;
      text-align: center;
    }

    /* No sidebar — content fills full width */
    .content-wrapper {
      margin-left: 0 !important;
    }

    /* Form controls theme adaptation */
    .form-control, input.form-control, select.form-control, textarea.form-control, input[type="text"], input[type="textbox"] {
      background-color: var(--bg) !important;
      color: var(--text) !important;
      border: 1px solid var(--border) !important;
    }
    .form-control:focus, input[type="text"]:focus, input[type="textbox"]:focus {
      border-color: var(--gold) !important;
      box-shadow: 0 0 0 3px rgba(201, 162, 39, 0.15) !important;
    }
    .form-control:disabled, input[type="text"]:disabled, input[type="textbox"]:disabled {
      background-color: var(--border) !important;
      opacity: 0.6;
    }

    /* Global adaptation for containers/cards */
    .card {
      background-color: var(--surface) !important;
      color: var(--text) !important;
      border: 1px solid var(--border) !important;
    }

    /* Automatically override hardcoded inline white backgrounds to respect theme */
    [style*="background-color:white"],
    [style*="background-color: white"],
    [style*="background-color:#fff"],
    [style*="background-color: #fff"],
    [style*="background-color:#ffffff"],
    [style*="background-color: #ffffff"],
    [style*="background:white"],
    [style*="background: white"],
    [style*="background:#fff"],
    [style*="background: #fff"],
    [style*="background:#ffffff"],
    [style*="background: #ffffff"] {
      background-color: var(--surface) !important;
      background: var(--surface) !important;
      color: var(--text) !important;
    }

    /* Automatically override hardcoded dark inline text to respect theme in dark mode */
    [data-theme="dark"] [style*="color:black"],
    [data-theme="dark"] [style*="color: black"],
    [data-theme="dark"] [style*="color:#000"],
    [data-theme="dark"] [style*="color: #000"],
    [data-theme="dark"] [style*="color:#333"],
    [data-theme="dark"] [style*="color: #333"],
    [data-theme="dark"] [style*="color:#495057"],
    [data-theme="dark"] [style*="color: #495057"] {
      color: var(--text) !important;
    }

    /* Table containers and filter bars overrides for dark mode */
    [data-theme="dark"] .table-container,
    [data-theme="dark"] .plan-date-filter-bar {
      background-color: var(--surface) !important;
      border: 1px solid var(--border) !important;
      color: var(--text) !important;
    }

    [data-theme="dark"] .table th,
    [data-theme="dark"] table th {
      background-color: var(--gold) !important;
      color: #fff !important;
    }

    [data-theme="dark"] .table td,
    [data-theme="dark"] table td {
      background-color: transparent !important;
      color: var(--text) !important;
    }

    [data-theme="dark"] .section-divider span,
    [data-theme="dark"] .section-collapse-toggle,
    [data-theme="dark"] .plan-date-filter-row .plan-date-label {
      color: var(--text) !important;
    }

    [data-theme="dark"] .table {
      --bs-table-bg: var(--surface) !important;
      --bs-table-striped-bg: rgba(255, 255, 255, 0.03) !important;
      color: var(--text) !important;
    }

    /* Organization chart overrides for dark mode */
    [data-theme="dark"] .org-box {
      background: var(--surface) !important;
      border: 1px solid var(--border) !important;
      color: var(--text) !important;
    }
    [data-theme="dark"] .org-box:hover {
      background-color: rgba(201, 162, 39, 0.08) !important;
    }
    [data-theme="dark"] .org-role {
      color: var(--text-muted) !important;
    }
    [data-theme="dark"] .org-name {
      color: var(--text) !important;
    }

    /* Dropdown overrides */
    .dropdown-menu {
      background-color: var(--surface) !important;
      border: 1px solid var(--border) !important;
    }
    .dropdown-item {
      color: var(--text) !important;
    }
    .dropdown-item:hover {
      background-color: rgba(201, 162, 39, 0.12) !important;
      color: var(--gold-bright) !important;
    }

    /* Toggle switch */
    .switch {
      position: relative;
      width: 52px;
      height: 28px;
      border-radius: 20px;
      border: 1px solid var(--border);
      background: var(--bg);
      cursor: pointer;
      flex-shrink: 0;
      transition: background 0.3s ease, border-color 0.3s ease;
      display: inline-block;
    }

    .switch .knob {
      position: absolute;
      top: 2px;
      left: 2px;
      width: 22px;
      height: 22px;
      border-radius: 50%;
      background: linear-gradient(135deg, var(--gold-bright), var(--gold));
      box-shadow: 0 1px 4px var(--shadow);
      transition: transform 0.32s cubic-bezier(.4,0,.2,1);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 11px;
    }

    [data-theme="dark"] .switch .knob {
      transform: translateX(24px);
    }
</style>

</head>

<!-- No sidebar classes needed -->
<body class="hold-transition layout-fixed">
<div class="wrapper">

<!-- ========================================================= -->
<!--                         NAVBAR                            -->
<!-- ========================================================= -->

  <nav class="main-header navbar navbar-expand" style="margin-left:0px; background-color: var(--surface) !important;">

    <!-- Left: title -->
    <div class="d-flex align-items-center">
      <div id="divTitle" class="ml-3"></div>
    </div>

    <!-- Right: search + home + user -->
    <ul class="navbar-nav ml-auto align-items-center">

      <!-- NAV SEARCH -->
      <li class="nav-item mr-2" id="navSearchWrapper">
        <input
          type="text"
          id="navSearchInput"
          placeholder="&#xf002; Search menu..."
          autocomplete="off"
          style="font-family: 'Font Awesome 5 Free', 'Segoe UI', sans-serif;"
        />
        <div id="navSearchDropdown"></div>
      </li>

      <!-- THEME TOGGLE -->
      <li class="nav-item d-flex align-items-center mr-3">
        <span style="font-size: 13px; color: var(--text); font-weight: 500; margin-right: 8px;">Dark Mode</span>
        <div class="switch" id="themeSwitch">
          <div class="knob" id="knob"></div>
        </div>
      </li>

      <!-- HOME -->
      <li class="nav-item mr-2">
        <a href="?a=showHomePage" class="nav-link"><strong>Home</strong></a>
      </li>

      <!-- USER DROPDOWN -->
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
          <strong>${userdetails.username}</strong>
        </a>
        <div class="dropdown-menu dropdown-menu-right" style="background-color: var(--surface); border: 1px solid var(--border);">
          <a class="dropdown-item" style="color: var(--text);"><strong>Valid Till (${userdetails.validTillDDMMYYY})</strong></a>
          <a href="?a=showChangePassword" class="dropdown-item" style="color: var(--text);"><strong>Change Password</strong></a>
          <a href="?a=showShortcuts" class="dropdown-item" style="color: var(--text);"><strong>Shortcuts</strong></a>
          <a href="javascript:copyDebugInfo()" class="dropdown-item" style="color: var(--text);"><strong>Copy Debug Info</strong></a>
          <a href="javascript:logout();" class="dropdown-item" id="refLogout" style="color: var(--text);"><strong>Logout</strong></a>
        </div>
      </li>

    </ul>
  </nav>

<!-- ========================================================= -->
<!--              BUILD MENU DATA FROM JSP / JSTL              -->
<!-- ========================================================= -->

<!--
  We emit the menu structure as a JS array so the navbar search can use it.
  Each entry: { parent, child, url }
-->
<script>
var menuItems = [
  <c:forEach items="${elementsDB}" var="item">
    <c:forEach items="${item.getChildElements()}" var="item1">
      {
        parent: "${item.getElementName()}",
        child:  "${item1.getElementName()}",
        url:    "${item1.getElementUrl()}"
      },
    </c:forEach>
  </c:forEach>
];
</script>

<!-- ========================================================= -->
<!--                   MAIN CONTENT AREA                        -->
<!-- ========================================================= -->

  <div class="content-wrapper" style="background:lightblue">
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <jsp:include page="${jspName}"/>
          </div>
        </div>
      </div>
    </section>
  </div>

</div> <!-- wrapper end -->

<!-- ========================================================= -->
<!--                       MODAL                                -->
<!-- ========================================================= -->

<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog modal-lg" style="min-width:100%">
    <div class="modal-content">
      <div class="modal-body" align="center">
        <p id="responseText"><div align="center" class="loader" id="loader"></div></p>
      </div>
      <div class="modal-footer" style="text-align:right">
        <button id="closebutton" type="button" onclick='location.reload()' class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- ========================================================= -->
<!--                  JAVASCRIPT FUNCTIONS                      -->
<!-- ========================================================= -->

<script>
function navigateToURL(theURL){ window.location=theURL; }

function logout() {
  document.getElementById("closebutton").style.display='none';
  $('#myModal').modal({backdrop: 'static', keyboard: false});

  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (xhttp.readyState == 4 && xhttp.status == 200) {
      document.getElementById("responseText").innerHTML = xhttp.responseText;
      document.getElementById("closebutton").style.display = 'block';
      window.location.reload();
    }
  };
  xhttp.open("GET","?a=Logout", true);
  xhttp.send();
}
</script>

<script>
$(document).ready(function () {
  window.onkeydown = function(evt) {
    if (evt.keyCode == 119) logout();  // F8
  };
});
</script>

<!-- ========================================================= -->
<!--                   NAVBAR SEARCH LOGIC                      -->
<!-- ========================================================= -->
<script>
(function () {
  var input    = document.getElementById('navSearchInput');
  var dropdown = document.getElementById('navSearchDropdown');

  function renderResults(query) {
    var q = query.trim().toLowerCase();
    dropdown.innerHTML = '';

    if (q === '') {
      dropdown.classList.remove('show');
      return;
    }

    var matched = menuItems.filter(function(item) {
      return (item.parent + ' ' + item.child).toLowerCase().includes(q);
    });

    if (matched.length === 0) {
      dropdown.innerHTML = '<div class="nav-search-no-results">No results found</div>';
    } else {
      matched.forEach(function(item) {
        var a = document.createElement('a');
        a.href = item.url;
        a.className = 'nav-search-item';
        a.innerHTML =
          '<span class="parent-label">' + escapeHtml(item.parent) + '</span>' +
          '<span class="child-label">' + highlightMatch(item.child, q) + '</span>';
        dropdown.appendChild(a);
      });
    }

    dropdown.classList.add('show');
  }

  function highlightMatch(text, query) {
    var idx = text.toLowerCase().indexOf(query);
    if (idx === -1) return escapeHtml(text);
    return escapeHtml(text.substring(0, idx))
      + '<mark style="background:#fff3b0;padding:0;">' + escapeHtml(text.substring(idx, idx + query.length)) + '</mark>'
      + escapeHtml(text.substring(idx + query.length));
  }

  function escapeHtml(str) {
    return str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
  }

  input.addEventListener('input', function () {
    renderResults(this.value);
  });

  input.addEventListener('focus', function () {
    if (this.value.trim() !== '') renderResults(this.value);
  });

  // Close dropdown when clicking outside
  document.addEventListener('click', function (e) {
    if (!document.getElementById('navSearchWrapper').contains(e.target)) {
      dropdown.classList.remove('show');
    }
  });

  // Keyboard: arrow keys + enter to navigate results
  input.addEventListener('keydown', function (e) {
    var items = dropdown.querySelectorAll('.nav-search-item');
    var active = dropdown.querySelector('.nav-search-item.active-result');
    var idx = -1;
    items.forEach(function(el, i){ if(el === active) idx = i; });

    if (e.key === 'ArrowDown') {
      e.preventDefault();
      var next = idx + 1 < items.length ? idx + 1 : 0;
      if (active) active.classList.remove('active-result');
      if (items[next]) {
        items[next].classList.add('active-result');
        items[next].style.background = '#fdf5dc';
      }
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      var prev = idx - 1 >= 0 ? idx - 1 : items.length - 1;
      if (active) active.classList.remove('active-result');
      if (items[prev]) {
        items[prev].classList.add('active-result');
        items[prev].style.background = '#fdf5dc';
      }
    } else if (e.key === 'Enter') {
      if (active) window.location = active.href;
    } else if (e.key === 'Escape') {
      dropdown.classList.remove('show');
    }
  });
})();
</script>

<!-- KEYBOARD SHORTCUTS -->
<script>
window.addEventListener('keydown', function(e) {
  if (e.altKey && e.keyCode == 76) logout();   // ALT + L
});
window.addEventListener('keydown', function(e) {
  if (e.altKey && e.shiftKey && e.keyCode == 82) window.location.href = "?a=reloadSession"; // ALT+SHIFT+R
});

window.onload = function () {
  const isAndroid = /Android/i.test(navigator.userAgent);
  if (!isAndroid) {
    document.getElementById("navSearchInput").focus();
  }
};

document.addEventListener('keydown', function(event) {
  if (event.ctrlKey && event.shiftKey && event.key === 'F') {
    document.getElementById("navSearchInput").focus();
  }
});
document.addEventListener('keydown', function(event) {
  if (event.ctrlKey && event.shiftKey && event.key === 'H') {
    window.location = "?a=showHomePage";
  }
});
document.addEventListener('keydown', function(event) {
  if (event.ctrlKey && event.shiftKey && event.key === 'L') {
    logout();
  }
});

function getUserRoles(callback) {
  $.ajax({
    url: "?a=getUserRoles",   // backend API you create
    method: "GET",
    success: function(res) {
      callback(res.roles || []);
    },
    error: function() {
      callback(["unknown"]);
    }
  });
}

function getNavigationPath() {
  // basic version (you can improve later)
  return document.title || "Unknown Path";
}

function getDebugInfo(callback) {
  $.ajax({
    url: "?a=getDebugInfo",
    method: "GET",
    success: function(res) {

      // 👉 log raw response
      console.log("=== RAW RESPONSE ===");
      console.log(res);

      // 👉 if response is string, parse it
      if (typeof res === "string") {
        try {
          res = JSON.parse(res);
        } catch (e) {
          console.error("JSON parse failed", e);
        }
      }

      // 👉 log parsed response
      console.log("=== PARSED RESPONSE ===");
      console.log(res);

      callback(res);
    },
    error: function(err) {
      console.error("AJAX ERROR", err);

      callback({
        roles: ["unknown"],
        environment: "unknown"
      });
    }
  });
}

function copyDebugInfo(errorMsg = "") {

  getDebugInfo(function(res) {

    const roles = (res && res.roles) ? res.roles : [];
    const env = (res && res.environment) ? res.environment : "unknown";

    const data =
"Login User : \"${userdetails.username}\"\n" +
"Current roles with user : \"" + roles.join(", ") + "\"\n" +
"Exact Navigation Path for the screen : \"" + getNavigationPath() + "\"\n" +
"Issue occured in which environment : \"" + env + "\"\n" +
"Reproducible steps : \n" +
"Date time of error/Problem occured : \"" + new Date().toLocaleString() + "\"\n" +
"URL : \"" + window.location.href + "\"\n" +
"Error : \"" + (errorMsg || "N/A") + "\"\n" +
"Browser : \"" + navigator.userAgent + "\"\n";

    // ✅ logs (keep for debugging)
    console.log("===== DEBUG INFO =====");
    console.log(data);

    // ✅ copy (robust)
    copyToClipboard(data);

  });
}

function getDebugInfo(callback) {
  $.ajax({
    url: "?a=getDebugInfo",
    method: "GET",
    success: function(res) {

      console.log("=== RAW RESPONSE ===", res);

      if (typeof res === "string") {
        try {
          res = JSON.parse(res);
        } catch (e) {
          console.error("JSON parse failed", e);
        }
      }

      console.log("=== PARSED RESPONSE ===", res);

      callback(res);
    },
    error: function(err) {
      console.error("AJAX ERROR", err);

      callback({
        roles: ["unknown"],
        environment: "unknown"
      });
    }
  });
}

function copyToClipboard(text) {

  if (navigator.clipboard && window.isSecureContext) {
    navigator.clipboard.writeText(text)
      .then(() => toastr.success("Debug info copied "))
      .catch(() => fallbackCopy(text));
  } else {
    fallbackCopy(text);
  }
}

function fallbackCopy(text) {
  const textarea = document.createElement("textarea");
  textarea.value = text;
  textarea.style.position = "fixed";
  textarea.style.left = "-9999px";

  document.body.appendChild(textarea);
  textarea.focus();
  textarea.select();

  try {
    document.execCommand("copy");
    toastr.success("Debug info copied ");
  } catch (err) {
    toastr.error("Copy failed ");
    console.error("Copy failed", err);
  }

  document.body.removeChild(textarea);
}

function getNavigationPath() {
  return document.title || "Unknown Path";
}

// Global Theme Switch Logic
(function() {
  const switchEl = document.getElementById('themeSwitch');
  const STORAGE_KEY = 'auric-theme-home';

  function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    document.querySelectorAll('body, .content-wrapper, .wrapper').forEach(el => {
      el.setAttribute('data-theme', theme);
    });
  }

  try {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved === 'dark' || saved === 'light') {
      applyTheme(saved);
    } else {
      applyTheme('light');
    }
  } catch (e) {
    console.warn('Theme could not be loaded from localStorage:', e);
  }

  if (switchEl) {
    switchEl.addEventListener('click', () => {
      const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
      const next = isDark ? 'light' : 'dark';
      applyTheme(next);
      try {
        localStorage.setItem(STORAGE_KEY, next);
      } catch (e) {
        console.warn('Theme could not be saved to localStorage:', e);
      }
      window.dispatchEvent(new Event('themechange'));
    });
  }
})();
</script>

</body>
</html>
