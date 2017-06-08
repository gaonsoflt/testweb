<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script>
var authMap;
$.ajax({
	type: "post",
	url: "<c:url value='/sm/userauth/getUserAuth.do'/>",
	data: {
		'USER_NO': "${userStore.userseq}",
		'MENU_ID': "${menuId}"
	},
	async: false, //동기 방식
	success: function(data, status){
		console.log('/getUserAuth.do');
		authMap = data.result;
	},
	fail: function(e){
		console.log(e);
	},
	complete: function(){}
});

function fnCodeNameByCdID(code){
	var rtnVal = "";
	for (var i = 0; i < codeModles.length; i++) {
        if (codeModles[i].CD_ID == code) {
        	rtnVal = codeModles[i].CD_NM;
        }
    }
	//return rtnVal;
	document.getElementById("area-id").innerHTML = rtnVal;
}
</script>
  <body class="skin-blue">
    <div class="wrapper">
      <!-- Main Header -->
      <header class="main-header">
        <!-- Logo -->
        <a href="<c:url value='#'/>" class="logo"><!-- <b>의령창조마을</b> --><img src="<c:url value='/resource/images/dalogo.gif'/>" alt="로고 이미지" /></a>

        	<!-- Header Navbar -->
        	<nav class="navbar navbar-static-top" role="navigation">
	        <!-- Sidebar toggle button-->
	        <!-- 사이드 메뉴바 토글 -->
          		<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
		            <span class="sr-only">Toggle navigation</span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
          		</a>
          		<!-- Navbar Right Menu -->
          		<div class="navbar-custom-menu">
            		<ul class="nav navbar-nav">
              			<!-- User Account Menu -->
              			<li class="dropdown user user-menu">
                			<!-- Menu Toggle Button -->
                			<a href="#" class="" data-toggle="">
                			<!-- <a href="#" class="dropdown-toggle" data-toggle="dropdown"> -->
                  				<!-- The user image in the navbar-->
                  				<%-- <img src="<c:url value='/resource/dist/img/user2-160x160.jpg'/>" class="user-image" alt="User Image"/> --%>
                  				<!-- hidden-xs hides the username on small devices so only the image appears. -->
                  				<span class="hidden-xs"><c:out value="${userStore.fullname}"/>님 &lt;<c:out value="${userStore.username}"/>&gt; 반갑습니다.</span>
                  				&nbsp;<a href="/com/login/logout.do" class="btn btn-default btn-flat" onclick="logout();">로그아웃</a>
                			</a>
                			<ul class="dropdown-menu">
                  			<!-- Menu Footer-->
                  				<li class="user-footer">
                    				<div class="pull-right">
                      					<a href="/com/login/logout.do" class="btn btn-default btn-flat" onclick="logout();">로그아웃</a>
                    				</div>
                  				</li>
                			</ul>
              			</li>
            		</ul>
				</div>
			</nav>
		</header>
      
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
          		<div class="user-panel">
		            <div class="pull-left" style="width:100%;padding:20px 0px;">
						<div><!-- <img class="img" style="display:block;margin:auto;" src="<c:url value='/resource/images/main_logo.png'/>" width="135px" height="112px" alt="로고 이미지" /> --></div>
						<div>
							<p id="area-id" style="font-size:150%;text-align:center;">
								<script>/*fnCodeNameByCdID("${userStore.areaId}");*/</script>${userStore.areaNm}
							</p>
						</div>
		            </div>
		        </div>
          		<ul id="menu-body" class="sidebar-menu"></ul>
        	</section>
      	</aside>
      	
      	
<style>
#area-id{display:block; margin-top:132px;}
.user-panel{background:url("/resource/images/main_logo.png") center 15px no-repeat; width:230px; height:214px;}
.user-panel .pull-left{width:100%; height:100%;}

#gridDetail table th{text-align:center;}
</style>
<script>
//alert("${userStore.userType}")
var userType = "${userStore.userType}";
var elderUrl;
var userId = "${userStore.username}";
var userNm  = "${userStore.fullname}";
var temp;


function setMenuId(e) {
	//var menuId = e.closest('li').id; // dose not support closest in explorer
	var menuId = e.name;
	$.get("<c:url value='/urtown/session/setMenuId.do'/>", { menuId: menuId } );
};

function logout() {
	//sessionStorage.setItem("menuId", "");
}

function invokeUserAuth(e, eType, authType) {
	console.log('auth: ' + authMap);
	console.log('menuId: ' + "${menuId}");
	console.log('etype: ' + eType);
	console.log('authType: ' + authType);
	
	
	switch(eType) {
		case 'kendoEditor':
			if(authMap.AUTH_C == 'false' && authType.toUpperCase() == 'C') {
				$(e.data().kendoEditor.body).attr('contenteditable', false);
			}
			if(authMap.AUTH_U == 'false' && authType.toUpperCase() == 'U') {
				$(e.data().kendoEditor.body).attr('contenteditable', false);
			}
			if(authMap.AUTH_D == 'false' && authType.toUpperCase() == 'D') {
				$(e.data().kendoEditor.body).attr('contenteditable', false);
			}
			break;
		case 'kendoButton':
			if(typeof authMap != "undefined" && authMap.AUTH_C == 'false' && authType.toUpperCase() == 'C') {
				e.remove();
			}
			if(typeof authMap != "undefined" && authMap.AUTH_U == 'false' && authType.toUpperCase() == 'U') {
				e.remove();
			}
			if(typeof authMap != "undefined" && authMap.AUTH_D == 'false' && authType.toUpperCase() == 'D') {
				e.remove();
			}
			break;
		case 'kendoGrid':
			setTimeout(function() {
				if(authMap.AUTH_C == 'false') {
					e.find(".k-grid-add").remove();
				}
				if(authMap.AUTH_U == 'false') {
					e.find(".k-grid-edit").remove();
					e.find(".k-grid-save-changes").remove();
					e.find(".k-grid-cancel-changes").remove();
				}
				if(authMap.AUTH_D == 'false') {
					e.find(".k-grid-delete").remove();
				}
			}, 500);

			break;
				
	}
};


$(document).ready(function() { 
	$(document).on("click", ".treeview", function(){
		$(".active").removeClass("active");
		$(this).addClass('active');
	}); 
	
	function drawMenu() {
		console.log('drawMenu');
		//console.log(menuList);
		
		var menuList;
		$.ajax({
			type: "post",
			url: "<c:url value='/sm/menu/getMenuInfo.do'/>",
			data: {
				'USER_NO': "${userStore.userseq}"
			},
			async: false, //동기 방식
			success: function(data, status){
				console.log('/getMenuInfo.do');
				menuList = data.rtnList;
			},
			fail: function(e){
				console.log(e);
			},
			complete: function(){
				console.log(menuList);
			}
		});
		
		var parentIdx = 0; 
		
		var temp = '<li class="header">MENU</li>';
		for (i = 0; i < menuList.length; i++) {
			
			if(parentIdx != menuList[i].parent_sq) {
				if(parentIdx > 0) {
					temp += '</ul></li>';
				}
				// new
				temp += '<li class="treeview"><a href="#"><i class="fa fa-laptop"></i><span>';
				temp += menuList[i].main_nm;
				temp += '</span><i class="fa fa-angle-left pull-right"></i></a>'
				temp += '<ul class="treeview-menu">';
			}
			// old
			temp += '<li id="' + menuList[i].menu_id + '">' +
				'<a name="' + menuList[i].menu_id + '" href="<c:url value="' + menuList[i].menu_url + '"/>" onclick="setMenuId(this);"><i class="fa fa-circle-o"></i>' + menuList[i].menu_nm + '</a></li>';
			parentIdx = menuList[i].parent_sq;
		}
		temp += '</ul></li>';
		var body = document.getElementById("menu-body");
		body.innerHTML = temp;
		
		elderUrl = $("#checkAloneElder").find("a").attr("href"); 
		$("#checkAloneElder").find("a").removeAttr("href"); 

		mulitCctvUrl = $("#checkMultiCctv").find("a").attr("href");
		$("#checkMultiCctv").find("a").removeAttr("href"); 

		//$("#connectSkype").find("a").removeAttr("href");
	};
	
	drawMenu();
	
	// active menu
	var menu = document.getElementById("${menuId}");
	if(menu != null) {
		menu.parentElement.parentElement.className += ' active';
		menu.className += ' active';
	}
});
</script>      
<style>
.treeview-menu{cursor:pointer}
.nav>li>a{display:inline-block !important;}
.nav>li>a:hover{background-color:transparent;}
.btn-default{border:0px; background-color:transparent; margin-bottom:1px;}
</style>