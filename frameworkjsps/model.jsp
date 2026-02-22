<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="jspName" value='${requestScope["outputObject"].get("contentJspName")}' />
<c:set var="elementsDB" value='${requestScope["outputObject"].get("elementsDB")}' />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>${projectName}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap 5.3 + Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    body {
      font-family: 'Inter', sans-serif;
      background:#f7f9fc;
    }

    .navbar {
      background:#fff;
      box-shadow:0 2px 8px rgba(0,0,0,0.05);
      padding:0.75rem 1.5rem;
    }

    #divTitle {
      font-weight: 700;
      font-size: 1.4rem;
      background: linear-gradient(90deg, #2563eb, #7c3aed);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      letter-spacing: 0.5px;
    }

    .search-box {
      position:relative;
      display:flex;
      align-items:center;
      background:#f1f5f9;
      border-radius:8px;
      padding:0.35rem 0.8rem;
      width:260px;
      margin-right:1rem;
      transition: box-shadow 0.2s ease;
    }

    .search-box:focus-within {
      box-shadow:0 0 0 2px rgba(37,99,235,0.3);
    }

    .search-box i {
      position:absolute;
      right:12px;
      color:#64748b;
      pointer-events:none;
    }

    .search-input {
      border:none;
      background:transparent;
      outline:none;
      width:100%;
      font-size:0.9rem;
      color:#111827;
      padding-right:22px;
    }

    .search-input::placeholder { color:#9ca3af; }

    .results-dropdown {
      position:absolute;
      top:110%;
      left:0;
      right:0;
      background:#fff;
      border:1px solid #e5e7eb;
      box-shadow:0 4px 12px rgba(0,0,0,0.08);
      border-radius:8px;
      z-index:1000;
      max-height:300px;
      overflow-y:auto;
    }

    .result-item {
      display:flex;
      align-items:center;
      gap:6px;
      padding:8px 12px;
      cursor:pointer;
      font-size:0.9rem;
      color:#374151;
      border-bottom:1px solid #f3f4f6;
    }

    .result-item:hover {
      background:#eef2ff;
    }

    .no-result {
      color:#9ca3af;
      padding:8px 12px;
    }
  </style>
</head>

<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
  <div class="container-fluid d-flex align-items-center justify-content-between">
    
    <!-- Left: Page Title -->
    <div id="divTitle">${projectName}</div>
    
    <!-- Right: Search + Home + Logout -->
    <div class="d-flex align-items-center">
      <!-- Search -->
      <div class="search-box me-3">
        <input type="text" id="searchBox" class="search-input" placeholder="Search elements..." autocomplete="off">
        <i class="fa fa-search"></i>
        <div id="resultsDropdown" class="results-dropdown d-none"></div>
      </div>

      <!-- Home -->
      <a href="?a=showHomePage" class="nav-link me-3">
        <i class="fa fa-home me-1"></i> Home
      </a>

      <!-- Logout -->
      <a href="javascript:logout();" class="nav-link text-danger">
        <i class="fa fa-sign-out-alt me-1"></i> Logout
      </a>
    </div>
  </div>
</nav>

<!-- Page Content -->
<div class="container-fluid p-4">
  <jsp:include page="${jspName}"/>
</div>

<!-- Logout Modal -->
<div class="modal fade" id="myModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content text-center p-3">
      <div class="modal-body">
        <div id="responseText"><div class="loader" id="loader"></div></div>
      </div>
      <div class="modal-footer justify-content-center">
        <button id="closebutton" type="button" onclick='location.reload()' class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- Scripts -->
<script>
function logout() {
  document.getElementById("closebutton").style.display='none';
  const modal=new bootstrap.Modal(document.getElementById('myModal'),{backdrop:'static'});
  modal.show();
  const xhttp=new XMLHttpRequest();
  xhttp.onreadystatechange=function(){
    if(xhttp.readyState==4&&xhttp.status==200){
      document.getElementById("loader").style.display='none';
      document.getElementById("responseText").innerHTML=xhttp.responseText;
      document.getElementById("closebutton").style.display='block';
    }
  };
  xhttp.open("GET","?a=Logout",true);
  xhttp.send();
}

// ✅ Build searchable list safely



// ✅ Build searchable list safely
const elements=[];
<c:forEach items="${elementsDB}" var="item">
  <c:forEach items="${item.getChildElements()}" var="child">
    elements.push({
      name: '${item.getElementName()} <br> > ${child.getElementName()}',
      url: '${child.getElementUrl()}'
    });
  </c:forEach>
</c:forEach>;

console.log("✅ Elements loaded:", elements);

const searchBox=document.getElementById("searchBox");
const resultsDropdown=document.getElementById("resultsDropdown");

// ✅ Show all or filtered elements dynamically
function renderList(list) {
  resultsDropdown.innerHTML="";
  if(list.length===0){
    resultsDropdown.innerHTML="<div class='no-result'>No results found</div>";
  } else {
    list.forEach(e=>{
      const div=document.createElement("div");
      div.className="result-item";
      div.innerHTML=`<i class='fa fa-angle-right text-primary'></i><span>`+e.name+`</span>`;
      div.onclick=()=>window.location=e.url;
      resultsDropdown.appendChild(div);
    });
  }
  resultsDropdown.classList.remove("d-none");
}

function showResults(query){
  const filtered = query
    ? elements.filter(e=>e.name.toLowerCase().includes(query.toLowerCase()))
    : elements; // show all if empty
  renderList(filtered);
}

// 🟢 Show all when focusing
searchBox.addEventListener("focus",()=>showResults(""));

// 🔍 Filter as user types
searchBox.addEventListener("input",()=>showResults(searchBox.value.trim()));

// Close dropdown when clicking outside
document.addEventListener("click",e=>{
  if(!document.querySelector(".search-box").contains(e.target)){
    resultsDropdown.classList.add("d-none");
  }
});

// Ctrl + K focuses search
window.addEventListener('keydown',function(e){
  if((e.ctrlKey||e.metaKey)&&e.key.toLowerCase()==='k'){
    e.preventDefault();
    searchBox.focus();
  }
});

</script>
</body>
</html>
