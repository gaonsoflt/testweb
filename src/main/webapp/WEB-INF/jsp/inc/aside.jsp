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
</script>

<body class="dashboard-page">
    <div class="main">
    	<header class="navbar navbar-fixed-top navbar-shadow">
			<div class="navbar-branding">
				<a class="navbar-brand" href="<c:url value='/main.do'/>">
					<strong>ESPA</strong>
        		</a>
				<span id="toggle_sidemenu_l" class="ad ad-lines"></span>
			</div>
			<ul class="nav navbar-nav navbar-right">
			</ul>
    	</header>
    	<!-- End: Header -->
    	
		<aside id="sidebar_left" class="nano nano-light affix">
		<!-- Start: Sidebar Left Content -->
			<div class="sidebar-left-content nano-content">
			<!-- Start: Sidebar Header -->
				<header class="sidebar-header">
					<div class="sidebar-widget author-widget">
						<div class="media">
							<a class="media-left" href="#">
								<img src="<c:url value='/resource/images/user_default.jpg'/>" class="img-responsive">
							</a>
							<div class="media-body">
								<div class="media-author">
									<div class="media-links">
										<a href="#" class="sidebar-menu-toggle">
											<c:out value="${userStore.username}"/><br>
											<c:out value="${userStore.fullname}"/>
<%-- 											 &lt;<c:out value="${userStore.userType}"/>&gt; --%>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
	
					<!-- Sidebar Widget - Menu (slidedown) -->
					<div class="sidebar-widget menu-widget">
						<div class="row text-center mbn">
							<div class="col-xs-4">
								<a href="dashboard.html" class="text-primary" data-toggle="tooltip" data-placement="top" title="Dashboard">
									<span class="glyphicon glyphicon-home"></span>
								</a>
							</div>
							<div class="col-xs-4">
								<a href="#" class="text-info" data-toggle="tooltip" data-placement="top" title="Messages">
									<span class="glyphicon glyphicon-inbox"></span>
								</a>
								</div>
							<div class="col-xs-4">
								<a href="#" class="text-alert" data-toggle="tooltip" data-placement="top" title="Tasks">
									<span class="glyphicon glyphicon-bell"></span>
								</a>
								</div>
							<div class="col-xs-4">
								<a href="#" class="text-profile" data-toggle="tooltip" data-placement="top" title="Profile">
									<span class="glyphicon glyphicon-user"></span>
								</a>
								</div>
							<div class="col-xs-4">
								<a href="#" class="text-danger" data-toggle="tooltip" data-placement="top" title="Settings">
									<span class="fa fa-gears"></span>
								</a>
							</div>
							<div class="col-xs-4">
								<a href="${contextPath}/com/login/logout.do" class="text-logout" data-toggle="tooltip" data-placement="top" title="Logout">
									<span class="glyphicon glyphicon-log-out"></span>
								</a>
							</div>
						</div>
					</div>
				</header>
				<!-- Start: Sidebar Menu -->
	       		<ui id="menu-body" class="nav sidebar-menu"></ui>
				<!-- End: Sidebar Menu -->
			</div>
			<!-- End: Sidebar Left Content -->
	    </aside>
	    <!-- End: Sidebar Left -->
	    <section id="content_wrapper">
			<!-- Content Header (Page header) -->
			<header id="topbar" class="alt">
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
	$.get(
		"<c:url value='/session/setMenuId.do'/>", 
		{ menuId: menuId }
	);
};

function logout() {
	//sessionStorage.setItem("menuId", "");
}

function invokeUserAuth(e, eType, authType) {
	console.log('invokeUserAuth: ');
// 	console.log(authMap);
// 	console.log('menuId: ' + "${menuId}");
// 	console.log('etype: ' + eType);
// 	console.log('authType: ' + authType);
	
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
		var menuList;
		$.ajax({
			type: "post",
			url: "<c:url value='/sm/menu/getMenuInfoByUserAuth.do'/>",
			data: {
// 				'USER_NO': "${userStore.userseq}"
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
// 				console.log(menuList);
			}
		});
		
		var parentIdx = 0; 
		var temp = "";
		temp += '<li class="sidebar-label pt20">Menu</li>';
		temp += '<li class="active"><a href="${contextPath}/dashboard.do">';
		temp += '<span class="glyphicon glyphicon-home"></span><span class="sidebar-title">Dashboard</span></a></li>';
		for (i = 0; i < menuList.length; i++) {
			
			if(parentIdx != menuList[i].parent_sq) {
				if(parentIdx > 0) {
					temp += '</ul></li>';
				}
				// new
				temp += '<li><a class="accordion-toggle" href="#">';
				temp += '<span class="glyphicon glyphicon-duplicate"></span>';
				temp += '<span class="sidebar-title">' + menuList[i].main_nm + '</span>';
				temp += '<span class="caret"></span></a>'
				temp += '<ul class="nav sub-nav">';
			}
			// old
			temp += '<li><a name="' + menuList[i].menu_id + '" href="${contextPath}' + menuList[i].menu_url + '">';
			temp += '<span class="fa fa-desktop"></span>' + menuList[i].menu_nm + '</a></li>';
			parentIdx = menuList[i].parent_sq;
		}
		temp += '</li>';
		var body = document.getElementById("menu-body");
		body.innerHTML = temp;
	};
	
	drawMenu();
	
	// active menu(change css style)
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