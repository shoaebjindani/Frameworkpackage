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
  <link rel="icon" href="https://img.icons8.com/emoji/48/000000/cloud-emoji.png" type="image/png">

  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Existing CSS -->
  <link rel="stylesheet" href="css/jquery-ui.css">
  <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <link rel="stylesheet" href="css/site.css">
  <link rel="stylesheet" href="css/richtext.min.css">
  <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

  <!-- JS imports -->
  <script src="plugins/jquery/jquery.min.js"></script>
  <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
  <script src="dist/js/adminlte.min.js"></script>
  <script src="js/jquery-ui.js"></script>
  <script src="plugins/toastr/toastr.min.js"></script>
  <script src="plugins/datatables/jquery.dataTables.min.js"></script>
  <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
  <script src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
  <script src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
  <script src="js/common.js"></script>

  <style>
    :root {
      --primary-color: #d4af37;
      --primary-dark: #b89122;
    }

    /* ── Kill AdminLTE sidebar offset ── */
    body.hold-transition .wrapper,
    .content-wrapper,
    .main-header {
      margin-left: 0 !important;
    }

    body {
      background: #f7f7f7;
      font-family: "Segoe UI", sans-serif;
    }

    /* ── Navbar ── */
    .main-header.navbar {
      background: #fff !important;
      border-bottom: 2px solid var(--primary-color);
      box-shadow: 0 2px 5px rgba(0,0,0,0.05);
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 1.25rem;
      position: sticky;
      top: 0;
      z-index: 1030;
      width: 100%;
    }

    #divTitle {
      font-weight: 700;
      font-size: 1.3rem;
      color: var(--primary-dark);
      white-space: nowrap;
    }

    /* ── Search Box ── */
    .search-box {
      position: relative;
      display: flex;
      align-items: center;
      background: #f1f3f5;
      border-radius: 6px;
      padding: 5px 10px;
      width: 260px;
      transition: box-shadow 0.2s;
    }

    .search-box:focus-within {
      box-shadow: 0 0 0 2px rgba(212,175,55,0.4);
    }

    .search-box input {
      border: none;
      background: transparent;
      width: 100%;
      outline: none;
      font-size: 0.875rem;
      color: #333;
    }

    .search-box input::placeholder { color: #aaa; }

    .search-box i {
      color: #888;
      margin-left: 6px;
      font-size: 0.85rem;
    }

    /* ── Dropdown ── */
    .results-dropdown {
      position: absolute;
      top: calc(100% + 6px);
      left: 0;
      right: 0;
      background: #fff;
      border: 1px solid #e0e0e0;
      border-radius: 6px;
      box-shadow: 0 4px 14px rgba(0,0,0,0.10);
      z-index: 2000;
      max-height: 320px;
      overflow-y: auto;
    }

    .result-item {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 9px 12px;
      cursor: pointer;
      border-bottom: 1px solid #f3f3f3;
      font-size: 0.875rem;
      color: #333;
    }

    .result-item:last-child { border-bottom: none; }

    .result-item:hover { background: #fdf8e8; }

    .result-item .parent-name {
      color: #999;
      font-size: 0.78rem;
    }

    .no-result { padding: 10px 12px; color: #aaa; font-size: 0.875rem; }

    /* ── Nav links ── */
    .nav-right a.nav-link {
      color: #333;
      font-weight: 600;
      font-size: 0.9rem;
      white-space: nowrap;
    }

    .nav-right a.nav-link:hover { color: var(--primary-dark); }

    /* ── Content ── */
    .content-wrapper {
      background: #f7f7f7;
      min-height: calc(100vh - 57px);
      padding: 0;
    }

    .content-wrapper .content { padding: 1rem; }
  </style>
</head>

<!-- No sidebar class: just hold-transition -->
<body class="hold-transition">
<div class="wrapper">

  <!-- ============================= -->
  <!--           NAVBAR              -->
  <!-- ============================= -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">

    <!-- Left: Title -->
    <div id="divTitle">${projectName}</div>

    <!-- Right: Search + Nav -->
    <div class="d-flex align-items-center gap-3 nav-right">

      <!-- Search -->
      <div class="search-box">
        <input id="searchBox" type="text" placeholder="Search elements..." autocomplete="off">
        <i class="fas fa-search"></i>
        <div id="resultsDropdown" class="results-dropdown d-none"></div>
      </div>

      <!-- Home -->
      <a href="?a=showHomePage" class="nav-link"><strong>Home</strong></a>

      <!-- User Dropdown -->
      <div class="dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" data-toggle="dropdown">
          <strong>${userdetails.username}</strong>
        </a>
        <div class="dropdown-menu dropdown-menu-right">
          <a class="dropdown-item"><strong>Valid Till (${userdetails.validTillDDMMYYY})</strong></a>
          <a href="?a=showChangePassword" class="dropdown-item"><strong>Change Password</strong></a>
          <a href="?a=showShortcuts" class="dropdown-item"><strong>Shortcuts</strong></a>
          <a href="javascript:logout();" class="dropdown-item text-danger"><strong>Logout</strong></a>
        </div>
      </div>
    </div>
  </nav>

  <!-- ============================= -->
  <!--         MAIN CONTENT          -->
  <!-- ============================= -->
  <div class="content-wrapper">
    <section class="content">
      <div class="container-fluid">
        <jsp:include page="${jspName}"/>
      </div>
    </section>
  </div>

  <!-- ============================= -->
  <!--            MODAL              -->
  <!-- ============================= -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg" style="min-width:100%">
      <div class="modal-content">
        <div class="modal-body text-center">
          <div id="responseText"><div class="loader" id="loader"></div></div>
        </div>
        <div class="modal-footer text-right">
          <button id="closebutton" type="button" onclick='location.reload()' class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

</div><!-- /wrapper -->

<!-- Scripts -->
<script>
function logout(){
  $("#closebutton").hide();
  $('#myModal').modal({backdrop:'static', keyboard:false});
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function(){
    if(xhttp.readyState == 4 && xhttp.status == 200){
      $("#loader").hide();
      $("#responseText").html(xhttp.responseText);
      $("#closebutton").show();
    }
  };
  xhttp.open("GET","?a=Logout",true);
  xhttp.send();
}
</script>

<!-- Smart Search -->
<script>
const elements = [];
<c:forEach items="${elementsDB}" var="item">
  <c:forEach items="${item.getChildElements()}" var="child">
    elements.push({
      parent: '${item.getElementName()}',
      child:  '${child.getElementName()}',
      name:   '${item.getElementName()} > ${child.getElementName()}',
      url:    '${child.getElementUrl()}'
    });
  </c:forEach>
</c:forEach>;

const box  = document.getElementById("searchBox");
const drop = document.getElementById("resultsDropdown");

function renderList(list){
  drop.innerHTML = "";
  if(list.length === 0){
    drop.innerHTML = "<div class='no-result'>No results found</div>";
  } else {
    list.forEach(e => {
      const div = document.createElement("div");
      div.className = "result-item";
      div.innerHTML =
        `<i class="fas fa-angle-right" style="color:var(--primary-color)"></i>
         <div>
           <div class="parent-name">`+e.parent+`</div>
           <div>`+e.child+`</div>
         </div>`;
      div.onclick = () => window.location = e.url;
      drop.appendChild(div);
    });
  }
  drop.classList.remove("d-none");
}

function showResults(q){
  const filtered = q
    ? elements.filter(e => e.name.toLowerCase().includes(q.toLowerCase()))
    : elements;
  renderList(filtered);
}

box.addEventListener("focus",  () => showResults(""));
box.addEventListener("input",  () => showResults(box.value.trim()));

document.addEventListener("click", e => {
  if(!document.querySelector(".search-box").contains(e.target)){
    drop.classList.add("d-none");
  }
});

/* Ctrl+K / Cmd+K to focus search */
window.addEventListener("keydown", e => {
  if((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === "k"){
    e.preventDefault();
    box.focus();
  }
});
</script>

</body>
</html>
