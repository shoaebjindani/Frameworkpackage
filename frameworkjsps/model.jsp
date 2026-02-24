<style>
	.date_field {position: relative; z-index:1000;}
	.ui-datepicker{position: relative; z-index:1000!important;}
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="jspName" value='${requestScope["outputObject"].get("contentJspName")}' />
<c:set var="userName" value='${requestScope["outputObject"].get("userName")}' />
<c:set var="elementsDB" value='${requestScope["outputObject"].get("elementsDB")}' />

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
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
    :root {
      --primary-color: #d4af37;
      --primary-soft: #e8c86e;
      --primary-dark: #b89122;
      --secondary-color: #6c757d;
      --background-color: #f7f7f7;
      --text-color: #212529;
      --navbar-bg: #ffffff;
    }

    body {
      background-color: var(--background-color);
      color: var(--text-color);
      font-family: "Segoe UI", sans-serif;
    }

    /* ============================
       NAVBAR
    ============================ */
    .main-header.navbar {
      background-color: var(--navbar-bg) !important;
      border-bottom: 2px solid var(--primary-color);
      box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }

    .main-header .nav-link {
      color: var(--text-color) !important;
      font-weight: 600;
    }
    .main-header .nav-link:hover {
      color: var(--primary-dark) !important;
    }

    /* ============================
       TABLE HEADER
    ============================ */
    table thead th,
    table th {
        background-color: var(--primary-soft) !important;
        color: #000 !important;
        text-align: center;
        font-weight: 600;
    }

    td { color: #333; }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }
    .btn-primary:hover {
      background-color: var(--primary-dark);
    }

    .modal-content {
      border-radius: 10px;
      border: 2px solid var(--primary-color);
    }

    #divTitle {
      color: var(--primary-dark);
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
      border: 1.5px solid var(--primary-color);
      border-radius: 20px;
      padding: 4px 14px;
      font-size: 0.88rem;
      outline: none;
      transition: width 0.3s ease;
    }

    #navSearchInput:focus {
      width: 300px;
      border-color: var(--primary-dark);
      box-shadow: 0 0 0 2px rgba(212,175,55,0.25);
    }

    #navSearchDropdown {
      display: none;
      position: absolute;
      top: calc(100% + 6px);
      right: 0;
      width: 320px;
      max-height: 360px;
      overflow-y: auto;
      background: #fff;
      border: 1.5px solid var(--primary-color);
      border-radius: 10px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.12);
      z-index: 9999;
    }

    #navSearchDropdown.show {
      display: block;
    }

    .nav-search-item {
      display: block;
      padding: 8px 16px;
      font-size: 0.88rem;
      color: #333;
      text-decoration: none;
      border-bottom: 1px solid #f0e6c0;
      transition: background 0.15s;
    }

    .nav-search-item:last-child {
      border-bottom: none;
    }

    .nav-search-item:hover {
      background-color: #fdf5dc;
      color: var(--primary-dark);
      text-decoration: none;
    }

    .nav-search-item .parent-label {
      font-size: 0.75rem;
      color: #999;
      display: block;
    }

    .nav-search-item .child-label {
      font-weight: 600;
      display: block;
    }

    .nav-search-no-results {
      padding: 12px 16px;
      color: #999;
      font-size: 0.85rem;
      text-align: center;
    }

    /* No sidebar — content fills full width */
    .content-wrapper {
      margin-left: 0 !important;
    }
</style>

</head>

<!-- No sidebar classes needed -->
<body class="hold-transition layout-fixed">
<div class="wrapper">

<!-- ========================================================= -->
<!--                         NAVBAR                            -->
<!-- ========================================================= -->

  <nav class="main-header navbar navbar-expand navbar-white navbar-light">

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

      <!-- HOME -->
      <li class="nav-item">
        <a href="?a=showHomePage" class="nav-link"><strong>Home</strong></a>
      </li>

      <!-- USER DROPDOWN -->
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
          <strong>${userdetails.username}</strong>
        </a>
        <div class="dropdown-menu dropdown-menu-right">
          <a class="dropdown-item"><strong>Valid Till (${userdetails.validTillDDMMYYY})</strong></a>
          <a href="?a=showChangePassword" class="dropdown-item"><strong>Change Password</strong></a>
          <a href="?a=showShortcuts" class="dropdown-item"><strong>Shortcuts</strong></a>
          <a href="javascript:logout();" class="dropdown-item" id="refLogout"><strong>Logout</strong></a>
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
</script>

</body>
</html>
