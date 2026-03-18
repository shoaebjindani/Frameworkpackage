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

  <!-- CRITICAL: this prevents the page from zooming out on mobile -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

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
  /* ============================================================
     ROOT VARIABLES
  ============================================================ */
  :root {
    --primary-color: #d4af37;
    --primary-soft:  #e8c86e;
    --primary-dark:  #b89122;
    --background-color: #f7f7f7;
    --text-color: #212529;
    --navbar-bg: #ffffff;
    --touch-min: 44px;
  }

  /* ============================================================
     GLOBAL RESET — prevent horizontal overflow
  ============================================================ */
  *, *::before, *::after { box-sizing: border-box; }

  html {
    max-width: 100%;
  }
  /* overflow-x:clip stops horizontal scroll on mobile without creating
     a new stacking context that would clip absolute dropdowns */
  body {
    max-width: 100%;
    overflow-x: clip;
  }

  body {
    background-color: var(--background-color);
    color: var(--text-color);
    font-family: "Segoe UI", sans-serif;
  }

  /* ============================================================
     CONTENT WRAPPER — full width, no sidebar
  ============================================================ */
  .content-wrapper {
    margin-left: 0 !important;
    width: 100% !important;
    min-height: 100vh;
  }

  /* ============================================================
     NAVBAR
  ============================================================ */
  .main-header.navbar {
    background-color: var(--navbar-bg) !important;
    border-bottom: 2px solid var(--primary-color);
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    padding: 0 10px;
    min-height: 50px;
    width: 100%;
    flex-wrap: nowrap;
    /* NOTE: must NOT be overflow:hidden — that clips the search dropdown */
    overflow: visible;
  }

  .main-header .nav-link {
    color: var(--text-color) !important;
    font-weight: 600;
    white-space: nowrap;
  }
  .main-header .nav-link:hover { color: var(--primary-dark) !important; }

  #divTitle {
    color: var(--primary-dark);
    font-weight: 700;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  /* ============================================================
     TABLE / BUTTONS
  ============================================================ */
  table thead th, table th {
    background-color: var(--primary-soft) !important;
    color: #000 !important;
    text-align: center;
    font-weight: 600;
  }
  td { color: #333; }
  .btn-primary { background-color: var(--primary-color); border-color: var(--primary-color); }
  .btn-primary:hover { background-color: var(--primary-dark); }
  .modal-content { border-radius: 10px; border: 2px solid var(--primary-color); }

  /* ============================================================
     SHARED ROUND ICON BUTTON
  ============================================================ */
  .nav-icon-btn {
    background: none;
    border: 1.5px solid var(--primary-color);
    border-radius: 50%;
    width: var(--touch-min);
    height: var(--touch-min);
    min-width: var(--touch-min);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    color: var(--primary-dark);
    font-size: 1rem;
    transition: background 0.2s, color 0.2s;
    padding: 0;
    flex-shrink: 0;
    -webkit-tap-highlight-color: transparent;
    touch-action: manipulation;
  }
  .nav-icon-btn:hover, .nav-icon-btn:active {
    background: var(--primary-color);
    color: #fff;
  }

  /* ============================================================
     DESKTOP SEARCH  (hidden on mobile)
  ============================================================ */
  #navSearchWrapper {
    position: relative;
    display: flex !important;
    align-items: center;
    gap: 6px;
  }

  #navSearchInput {
    width: 200px;
    border: 1.5px solid var(--primary-color);
    border-radius: 20px;
    padding: 6px 14px;
    font-size: 0.88rem;
    outline: none;
    height: var(--touch-min);
    box-sizing: border-box;
    transition: width 0.3s ease;
  }
  #navSearchInput:focus {
    width: 260px;
    border-color: var(--primary-dark);
    box-shadow: 0 0 0 2px rgba(212,175,55,0.25);
  }

  #navSearchDropdown {
    display: none;
    position: absolute;
    top: calc(100% + 8px);
    right: 0;
    width: 300px;
    max-height: 360px;
    overflow-y: auto;
    background: #fff;
    border: 1.5px solid var(--primary-color);
    border-radius: 10px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.14);
    z-index: 9999;
  }
  #navSearchDropdown.show { display: block; }

  /* ============================================================
     SEARCH RESULT ITEMS
  ============================================================ */
  .nav-search-item {
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 10px 16px;
    min-height: var(--touch-min);
    font-size: 0.88rem;
    color: #333;
    text-decoration: none;
    border-bottom: 1px solid #f0e6c0;
    -webkit-tap-highlight-color: transparent;
  }
  .nav-search-item:last-child { border-bottom: none; }
  .nav-search-item:hover, .nav-search-item:active {
    background-color: #fdf5dc;
    color: var(--primary-dark);
    text-decoration: none;
  }
  .nav-search-item .parent-label { font-size: 0.72rem; color: #999; }
  .nav-search-item .child-label  { font-weight: 600; }
  .nav-search-no-results { padding: 14px 16px; color: #999; font-size: 0.85rem; text-align: center; }

  /* ============================================================
     MOBILE  (≤ 600px)
     - Hide desktop search input
     - Show search icon instead
     - Tighten navbar spacing
  ============================================================ */
  @media (max-width: 600px) {
    #navSearchInput         { display: none !important; }
    #navSearchDropdown      { display: none !important; }
    #mobileSearchTrigger    { display: flex !important; }

    /* Title: fill remaining navbar space, never clipped */
    #divTitle {
      font-size: 0.82rem;
      max-width: none;
      flex: 1;
      min-width: 0;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    /* Navbar left side allowed to grow */
    .main-header.navbar > .d-flex { flex: 1; min-width: 0; }
    .main-header.navbar            { padding: 0 6px; }

    /* Icon buttons: visually smaller while keeping touch area */
    .nav-icon-btn {
      width: 34px !important;
      height: 34px !important;
      min-width: 34px !important;
      font-size: 0.82rem !important;
    }

    /* Tighten text links */
    .nav-home-link  { font-size: 0.80rem !important; padding: 0 3px !important; }
    #navbarDropdown { font-size: 0.80rem; padding: 0 3px; }

    /* Tighten gap between nav items */
    .navbar-nav     { gap: 2px !important; }
  }

  @media (min-width: 601px) {
    #mobileSearchTrigger    { display: none !important; }
    #mobileSearchOverlay    { display: none !important; }
    #mobileSearchResults    { display: none !important; }
    #divTitle               { font-size: 1.2rem; }
  }

  /* ============================================================
     MOBILE SEARCH FULL-SCREEN OVERLAY
  ============================================================ */
  #mobileSearchOverlay {
    display: none;
    position: fixed;
    top: 0; left: 0; right: 0;
    z-index: 10500;
    background: #fff;
    border-bottom: 2px solid var(--primary-color);
    padding: 6px 8px;
    align-items: center;
    gap: 8px;
    box-shadow: 0 3px 14px rgba(0,0,0,0.18);
  }
  #mobileSearchOverlay.active { display: flex; }

  #mobileSearchInput {
    flex: 1;
    border: 1.5px solid var(--primary-color);
    border-radius: 22px;
    padding: 8px 14px;
    font-size: 16px; /* 16px prevents iOS auto-zoom on focus */
    outline: none;
    height: var(--touch-min);
    -webkit-appearance: none;
  }
  #mobileSearchInput:focus {
    border-color: var(--primary-dark);
    box-shadow: 0 0 0 2px rgba(212,175,55,0.25);
  }

  #mobileSearchClose {
    background: none;
    border: none;
    color: var(--primary-dark);
    font-size: 1.2rem;
    width: var(--touch-min);
    height: var(--touch-min);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    flex-shrink: 0;
    -webkit-tap-highlight-color: transparent;
    touch-action: manipulation;
  }

  #mobileSearchResults {
    display: none;
    position: fixed;
    top: 56px; left: 0; right: 0;
    z-index: 10400;
    background: #fff;
    border-top: 1px solid #f0e6c0;
    max-height: calc(100vh - 60px);
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  }
  #mobileSearchResults.show { display: block; }

  /* ============================================================
     MENU BROWSER MODAL — Desktop
  ============================================================ */
  #menuBrowserModal .modal-dialog {
    min-width: 88% !important;
    max-width: 1200px;
    margin: 28px auto;
  }
  #menuBrowserModal .modal-content {
    border-radius: 14px;
    border: 2px solid var(--primary-color);
    background: #fdfaf2;
  }
  #menuBrowserModal .modal-header {
    background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
    border-radius: 12px 12px 0 0;
    padding: 14px 22px;
    border-bottom: none;
  }
  #menuBrowserModal .modal-title {
    color: #fff; font-weight: 700; font-size: 1.05rem; letter-spacing: 0.03em;
  }
  #menuBrowserModal .modal-header .close {
    color: #fff; opacity: 0.85; font-size: 1.5rem; text-shadow: none;
    width: var(--touch-min); height: var(--touch-min);
    display: flex; align-items: center; justify-content: center;
    -webkit-tap-highlight-color: transparent;
  }
  #menuBrowserModal .modal-header .close:hover { opacity: 1; }
  #menuBrowserModal .modal-body {
    padding: 0;
    max-height: 76vh;
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;
  }

  /* ============================================================
     MENU BROWSER MODAL — Mobile bottom-sheet
  ============================================================ */
  @media (max-width: 600px) {
    /* make Bootstrap position the dialog at bottom */
    #menuBrowserModal .modal-dialog {
      min-width: 100% !important;
      max-width: 100% !important;
      width: 100% !important;
      margin: 0 !important;
      position: fixed !important;
      bottom: 0 !important;
      top: auto !important;
      left: 0 !important;
      right: 0 !important;
    }
    #menuBrowserModal .modal-content {
      border-radius: 20px 20px 0 0 !important;
      border-left: none !important;
      border-right: none !important;
      border-bottom: none !important;
      max-height: 88vh;
      display: flex;
      flex-direction: column;
    }
    /* drag-handle pill */
    #menuBrowserModal .modal-header {
      flex-direction: column;
      align-items: center;
      padding-top: 10px;
      border-radius: 20px 20px 0 0;
    }
    #menuBrowserModal .modal-header::before {
      content: '';
      display: block;
      width: 40px; height: 5px;
      background: rgba(255,255,255,0.4);
      border-radius: 3px;
      margin-bottom: 8px;
    }
    .mb-header-row {
      display: flex;
      align-items: center;
      justify-content: space-between;
      width: 100%;
    }
    #menuBrowserModal .modal-body {
      flex: 1;
      max-height: none !important;
      overflow-y: auto !important;
      -webkit-overflow-scrolling: touch;
    }
    /* single column */
    .menu-browser-grid {
      grid-template-columns: 1fr !important;
      gap: 10px !important;
      padding: 10px 12px 32px !important;
    }
    /* big tap targets */
    .menu-parent-header {
      padding: 14px !important;
      min-height: 52px;
    }
    .menu-parent-header .parent-name { font-size: 0.97rem !important; }
    .menu-child-link {
      min-height: 48px !important;
      padding: 13px 16px !important;
      font-size: 0.93rem !important;
    }
    #menuBrowserSearch {
      font-size: 16px !important; /* prevent iOS zoom */
      height: 46px !important;
    }
  }

  /* ============================================================
     MENU BROWSER — search bar
  ============================================================ */
  .menu-browser-search-bar {
    padding: 12px 16px 8px;
    background: #fdfaf2;
    position: sticky;
    top: 0;
    z-index: 10;
    border-bottom: 1px solid #f0e6c0;
  }
  #menuBrowserSearch {
    width: 100%;
    border: 1.5px solid var(--primary-soft);
    border-radius: 22px;
    padding: 9px 16px;
    font-size: 0.92rem;
    outline: none;
    background: #fff;
    height: var(--touch-min);
    box-sizing: border-box;
    -webkit-appearance: none;
  }
  #menuBrowserSearch:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 0 2px rgba(212,175,55,0.2);
  }

  /* ============================================================
     MENU BROWSER — grid & cards
  ============================================================ */
  .menu-browser-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 14px;
    padding: 16px 18px 24px;
  }
  .menu-parent-card {
    background: #fff;
    border: 2px solid var(--primary-soft);
    border-radius: 10px;
    overflow: hidden;
    transition: box-shadow 0.2s, border-color 0.2s;
  }
  .menu-parent-card:hover, .menu-parent-card.open {
    border-color: var(--primary-color);
    box-shadow: 0 4px 18px rgba(212,175,55,0.22);
  }
  .menu-parent-header {
    background: linear-gradient(135deg, #fdf3d0 0%, var(--primary-soft) 100%);
    padding: 11px 14px;
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    user-select: none;
    min-height: var(--touch-min);
    -webkit-tap-highlight-color: transparent;
    touch-action: manipulation;
  }
  .menu-parent-header .parent-icon {
    width: 30px; height: 30px;
    background: var(--primary-color);
    border-radius: 6px;
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0;
  }
  .menu-parent-header .parent-icon i { color: #fff; font-size: 0.75rem; }
  .menu-parent-header .parent-name {
    font-weight: 700; font-size: 0.9rem; color: #3a2800; flex: 1; line-height: 1.3;
  }
  .child-count-badge {
    background: var(--primary-color); color: #fff;
    font-size: 0.68rem; font-weight: 700;
    border-radius: 10px; padding: 2px 8px; flex-shrink: 0;
  }
  .menu-parent-header .toggle-icon {
    font-size: 0.8rem; color: #7a5e00;
    transition: transform 0.25s ease;
    flex-shrink: 0; width: 18px; text-align: center;
  }
  .menu-parent-card.open .toggle-icon { transform: rotate(180deg); }

  .menu-children-list {
    max-height: 0; overflow: hidden;
    transition: max-height 0.3s ease;
  }
  .menu-parent-card.open .menu-children-list { max-height: 900px; }

  .menu-child-link {
    display: flex; align-items: center; gap: 10px;
    padding: 10px 14px;
    min-height: var(--touch-min);
    font-size: 0.86rem; color: #333;
    text-decoration: none;
    border-bottom: 1px solid #f5ecd0;
    transition: background 0.15s, color 0.15s;
    -webkit-tap-highlight-color: transparent;
    touch-action: manipulation;
  }
  .menu-child-link:last-child { border-bottom: none; }
  .menu-child-link i { color: var(--primary-color); font-size: 0.75rem; flex-shrink: 0; }
  .menu-child-link:hover, .menu-child-link:active {
    background: #fdf5dc; color: var(--primary-dark); text-decoration: none;
  }

  .menu-browser-no-results {
    text-align: center; padding: 40px 20px;
    color: #aaa; font-size: 0.9rem; grid-column: 1 / -1;
  }
  .menu-browser-no-results i { display: block; font-size: 2rem; margin-bottom: 10px; color: #ddd; }
</style>
</head>

<body class="hold-transition layout-fixed">
<div class="wrapper">

<!-- ============================================================
     MOBILE SEARCH OVERLAY
============================================================ -->
<div id="mobileSearchOverlay">
  <input type="search" id="mobileSearchInput" placeholder="Search menu..." autocomplete="off" />
  <button id="mobileSearchClose" aria-label="Close"><i class="fas fa-times"></i></button>
</div>
<div id="mobileSearchResults"></div>

<!-- ============================================================
     NAVBAR
============================================================ -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light" style="margin-left:0">

  <div class="d-flex align-items-center" style="min-width:0; overflow:hidden; flex:1;">
    <div id="divTitle" class="ml-2"></div>
  </div>

  <ul class="navbar-nav ml-auto align-items-center" style="flex-wrap:nowrap; gap:4px; flex-shrink:0;">

    <!-- Desktop search (hidden on mobile via CSS) -->
    <li class="nav-item" id="navSearchWrapper">
      <input
        type="text"
        id="navSearchInput"
        placeholder="&#xf002; Search menu..."
        autocomplete="off"
        style="font-family:'Font Awesome 5 Free','Segoe UI',sans-serif;"
      />
      <div id="navSearchDropdown"></div>
    </li>

    <!-- Mobile search icon (shown on mobile only) -->
    <li class="nav-item" id="mobileSearchTrigger" style="display:none">
      <button class="nav-icon-btn" onclick="openMobileSearch()" aria-label="Search">
        <i class="fas fa-search"></i>
      </button>
    </li>

    <!-- Menu browser (all sizes) -->
    <li class="nav-item">
      <button class="nav-icon-btn" onclick="openMenuBrowser()" title="Browse menus" aria-label="Browse menus">
        <i class="fas fa-th"></i>
      </button>
    </li>

    <!-- Home -->
    <li class="nav-item">
      <a href="?a=showHomePage" class="nav-link nav-home-link"><strong>Home</strong></a>
    </li>

    <!-- User dropdown -->
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" style="padding:0 6px">
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

<!-- ============================================================
     MENU DATA
============================================================ -->
<script>
var menuItems = [
  <c:forEach items="${elementsDB}" var="item">
    <c:forEach items="${item.getChildElements()}" var="item1">
      { parent: "${item.getElementName()}", child: "${item1.getElementName()}", url: "${item1.getElementUrl()}" },
    </c:forEach>
  </c:forEach>
];
</script>

<!-- ============================================================
     MAIN CONTENT
============================================================ -->
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

</div><!-- /wrapper -->

<!-- ============================================================
     MODAL — generic/logout
============================================================ -->
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

<!-- ============================================================
     MENU BROWSER MODAL
============================================================ -->
<div class="modal fade" id="menuBrowserModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">

      <div class="modal-header">
        <!-- mb-header-row keeps title+close side by side on mobile -->
        <div class="mb-header-row">
          <h5 class="modal-title" style="margin:0">
            <i class="fas fa-compass mr-2"></i>Browse All Menus
          </h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
      </div>

      <div class="modal-body">
        <div class="menu-browser-search-bar">
          <input
            type="search"
            id="menuBrowserSearch"
            placeholder="&#xf002;  Filter menus..."
            autocomplete="off"
            style="font-family:'Font Awesome 5 Free','Segoe UI',sans-serif;"
          />
        </div>
        <div class="menu-browser-grid" id="menuBrowserGrid"></div>
      </div>

    </div>
  </div>
</div>

<!-- ============================================================
     JAVASCRIPT
============================================================ -->
<script>
function navigateToURL(u) { window.location = u; }

/* ---- HTML escape ---- */
function escHtml(s) {
  return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}
function highlightMatch(text, q) {
  var i = text.toLowerCase().indexOf(q);
  if (i < 0) return escHtml(text);
  return escHtml(text.slice(0,i))
    + '<mark style="background:#fff3b0;padding:0">' + escHtml(text.slice(i, i+q.length)) + '</mark>'
    + escHtml(text.slice(i+q.length));
}

/* ---- Build result list into any container ---- */
function buildSearchResults(query, container) {
  var q = (query||'').trim().toLowerCase();
  container.innerHTML = '';
  if (!q) { container.classList.remove('show'); return; }
  var matched = menuItems.filter(function(m){
    return (m.parent+' '+m.child).toLowerCase().includes(q);
  });
  if (!matched.length) {
    container.innerHTML = '<div class="nav-search-no-results">No results found</div>';
  } else {
    matched.forEach(function(m){
      var a = document.createElement('a');
      a.href = m.url; a.className = 'nav-search-item';
      a.innerHTML = '<span class="parent-label">'+escHtml(m.parent)+'</span>'
                  + '<span class="child-label">'+highlightMatch(m.child,q)+'</span>';
      container.appendChild(a);
    });
  }
  container.classList.add('show');
}

/* ---- Logout ---- */
function logout() {
  document.getElementById("closebutton").style.display = 'none';
  $('#myModal').modal({backdrop:'static', keyboard:false});
  var x = new XMLHttpRequest();
  x.onreadystatechange = function(){
    if (x.readyState==4 && x.status==200){
      document.getElementById("responseText").innerHTML = x.responseText;
      document.getElementById("closebutton").style.display = 'block';
      window.location.reload();
    }
  };
  x.open("GET","?a=Logout",true); x.send();
}
$(document).ready(function(){ window.onkeydown = function(e){ if(e.keyCode==119) logout(); }; });
</script>

<!-- Desktop navbar search -->
<script>
(function(){
  var input = document.getElementById('navSearchInput');
  var drop  = document.getElementById('navSearchDropdown');
  if (!input) return;

  input.addEventListener('input', function(){ buildSearchResults(this.value, drop); });
  input.addEventListener('focus', function(){ if(this.value.trim()) buildSearchResults(this.value, drop); });

  document.addEventListener('click', function(e){
    var w = document.getElementById('navSearchWrapper');
    if (w && !w.contains(e.target)) drop.classList.remove('show');
  });

  input.addEventListener('keydown', function(e){
    var items  = drop.querySelectorAll('.nav-search-item');
    var active = drop.querySelector('.nav-search-item.active-result');
    var idx=-1; items.forEach(function(el,i){ if(el===active) idx=i; });
    function activate(n){
      if(active){ active.classList.remove('active-result'); active.style.background=''; }
      if(items[n]){ items[n].classList.add('active-result'); items[n].style.background='#fdf5dc'; }
    }
    if      (e.key==='ArrowDown') { e.preventDefault(); activate(idx+1<items.length?idx+1:0); }
    else if (e.key==='ArrowUp')   { e.preventDefault(); activate(idx-1>=0?idx-1:items.length-1); }
    else if (e.key==='Enter')     { if(active) window.location=active.href; }
    else if (e.key==='Escape')    { drop.classList.remove('show'); }
  });
})();
</script>

<!-- Mobile search overlay -->
<script>
(function(){
  var overlay  = document.getElementById('mobileSearchOverlay');
  var minput   = document.getElementById('mobileSearchInput');
  var mresults = document.getElementById('mobileSearchResults');
  var closeBtn = document.getElementById('mobileSearchClose');

  window.openMobileSearch = function(){
    overlay.classList.add('active');
    mresults.innerHTML = ''; mresults.classList.remove('show');
    setTimeout(function(){ minput.focus(); }, 80);
  };
  function closeMobileSearch(){
    overlay.classList.remove('active');
    mresults.classList.remove('show');
    minput.value = ''; minput.blur();
  }
  closeBtn.addEventListener('click', closeMobileSearch);
  minput.addEventListener('input', function(){ buildSearchResults(this.value, mresults); });
  mresults.addEventListener('click', function(e){
    if (e.target.closest('.nav-search-item')) closeMobileSearch();
  });
  document.addEventListener('touchstart', function(e){
    if (overlay.classList.contains('active')
        && !overlay.contains(e.target)
        && !mresults.contains(e.target)) closeMobileSearch();
  }, {passive:true});
})();
</script>

<!-- Menu browser -->
<script>
function groupMenuItems(items){
  var g={}, o=[];
  items.forEach(function(m){ if(!g[m.parent]){ g[m.parent]=[]; o.push(m.parent); } g[m.parent].push(m); });
  return {groups:g, order:o};
}

function buildMenuBrowserGrid(filterText){
  var grid = document.getElementById('menuBrowserGrid');
  grid.innerHTML = '';
  var q    = (filterText||'').trim().toLowerCase();
  var data = groupMenuItems(menuItems);
  var any  = false;

  data.order.forEach(function(parent){
    var kids = data.groups[parent];
    var vis  = q ? kids.filter(function(c){ return c.child.toLowerCase().includes(q)||c.parent.toLowerCase().includes(q); }) : kids;
    if (!vis.length) return;
    any = true;

    var card = document.createElement('div');
    card.className = 'menu-parent-card'+(q?' open':'');

    var hdr = document.createElement('div');
    hdr.className = 'menu-parent-header';
    hdr.setAttribute('role','button');
    hdr.innerHTML =
      '<div class="parent-icon"><i class="fas fa-folder"></i></div>'+
      '<span class="parent-name">'+escHtml(parent)+'</span>'+
      '<span class="child-count-badge">'+vis.length+'</span>'+
      '<span class="toggle-icon"><i class="fas fa-chevron-down"></i></span>';
    hdr.addEventListener('click', function(){ card.classList.toggle('open'); });

    var list = document.createElement('div');
    list.className = 'menu-children-list';
    vis.forEach(function(c){
      var a = document.createElement('a');
      a.href = c.url; a.className = 'menu-child-link';
      a.innerHTML = '<i class="fas fa-angle-right"></i>'+escHtml(c.child);
      list.appendChild(a);
    });

    card.appendChild(hdr); card.appendChild(list);
    grid.appendChild(card);
  });

  if (!any) {
    grid.innerHTML = '<div class="menu-browser-no-results"><i class="fas fa-search"></i>No menus found for <strong>&ldquo;'+escHtml(filterText)+'&rdquo;</strong></div>';
  }
}

function openMenuBrowser(){
  var s = document.getElementById('menuBrowserSearch');
  s.value = '';
  buildMenuBrowserGrid('');
  $('#menuBrowserModal').modal('show');
  $('#menuBrowserModal').one('shown.bs.modal', function(){
    var isTouchDevice = ('ontouchstart' in window) || (navigator.maxTouchPoints > 0);    
    var isDesktop = window.innerWidth >= 1024 && !isTouchDevice;
    if (isDesktop) s.focus();
  });
}

document.addEventListener('DOMContentLoaded', function(){
  var s = document.getElementById('menuBrowserSearch');
  if (s) s.addEventListener('input', function(){ buildMenuBrowserGrid(this.value); });
});
</script>

<!-- Keyboard shortcuts -->
<script>
window.addEventListener('keydown', function(e){
  if (e.altKey && e.keyCode==76)                              logout();
  if (e.altKey && e.shiftKey && e.keyCode==82)                window.location.href="?a=reloadSession";
  if (e.ctrlKey && e.shiftKey && e.key==='F')  { var n=document.getElementById('navSearchInput'); if(n) n.focus(); }
  if (e.ctrlKey && e.shiftKey && e.key==='H')                 window.location="?a=showHomePage";
  if (e.ctrlKey && e.shiftKey && e.key==='L')                 logout();
  if (e.ctrlKey && e.shiftKey && e.key==='M')                 openMenuBrowser();
});

window.onload = function(){
  var isTouchDevice = ('ontouchstart' in window) || (navigator.maxTouchPoints > 0);
  var isDesktop = window.innerWidth >= 1024 && !isTouchDevice;
  if (isDesktop){
    var n = document.getElementById('navSearchInput');
    if (n) n.focus();
  }
};
</script>

</body>
</html>
