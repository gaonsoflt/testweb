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
// 		console.log('/getUserAuth.do');
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

<body>
    <section id="main-wrapper" class="theme-default">
        <header id="header">
            <!--logo start-->
            <div class="brand">
                <a href="index.html" class="logo">
                    <i class="icon-layers"></i>
                    <span>NEU</span>BOARD</a>
            </div>
            <!--logo end-->
            <ul class="nav navbar-nav navbar-left">
                <li class="toggle-navigation toggle-left">
                    <button class="sidebar-toggle" id="toggle-left">
                        <i class="fa fa-bars"></i>
                    </button>
                </li>
                <li class="toggle-profile hidden-xs">
                    <button type="button" class="btn btn-default" id="toggle-profile">
                        <i class="icon-user"></i>
                    </button>
                </li>
                <li class="hidden-xs hidden-sm">
                    <input type="text" class="search" placeholder="Search project...">
                    <button type="submit" class="btn btn-sm btn-search"><i class="fa fa-search"></i>
                    </button>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown profile hidden-xs">
                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">
                        <span class="meta">
                            <span class="avatar">
                                <img src="<c:url value='/resource/style/neuboard/assets/img/profile.jpg'/>" class="img-circle" alt="">
                            </span>
                        <span class="text">Mike Adams</span>
                        <span class="caret"></span>
                        </span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight" role="menu">
                        <li>
                            <span class="arrow top"></span>
                            <h5>
                                <span>80%</span>
                                <small class="text-muted">Profile complete</small>
                            </h5>
                            <div class="progress progress-xs">
                                <div class="progress-bar progress-bar" style="width: 80%">
                                </div>
                            </div>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="javascript:void(0);">
                                <span class="icon"><i class="fa fa-user"></i>
                                </span>My Account</a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">
                                <span class="icon"><i class="fa fa-envelope"></i>
                                </span>Messages</a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">
                                <span class="icon"><i class="fa fa-cog"></i>
                                </span>Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="javascript:void(0);">
                                <span class="icon"><i class="fa fa-sign-out"></i>
                                </span>Logout</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </header>
        <!--sidebar left start-->
        <aside class="sidebar sidebar-left">
            <div class="sidebar-profile">
                <div class="avatar">
                    <img class="img-circle profile-image" src="<c:url value='/resource/style/neuboard/assets/img/profile.jpg'/>" alt="profile">
                    <i class="on border-dark animated bounceIn"></i>
                </div>
                <div class="profile-body dropdown">
                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><h4>Mike Adams <span class="caret"></span></h4></a>
                    <small class="title">Front-end Developer</small>
                    <ul class="dropdown-menu animated fadeInRight" role="menu">
                        <li class="profile-progress">
                            <h5>
                                <span>80%</span>
                                <small>Profile complete</small>
                            </h5>
                            <div class="progress progress-xs">
                                <div class="progress-bar progress-bar-primary" style="width: 80%">
                                </div>
                            </div>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="javascript:void(0);">
                                <span class="icon"><i class="fa fa-user"></i>
                                </span>My Account</a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">
                                <span class="icon"><i class="fa fa-envelope"></i>
                                </span>Messages</a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">
                                <span class="icon"><i class="fa fa-cog"></i>
                                </span>Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="javascript:void(0);">
                                <span class="icon"><i class="fa fa-sign-out"></i>
                                </span>Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
            <nav>
				<ul id="menu-body" style="padding-left: 0px;"></ul>
            </nav>
        </aside>
        <!--sidebar left end-->
<style>
#area-id{display:block; margin-top:132px;}
.user-panel{background:url("${contextPath}/resource/images/main_logo.png") center 15px no-repeat; width:230px; height:214px;}
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
/*
 
 <li class="active">
     <a href="index.html" title="Dashboard">
         <i class="fa  fa-fw fa-tachometer"></i> 대쉬보드
     </a>
 </li>
 <li class="nav-dropdown">
     <a href="#" title="Forms">
         <i class="fa  fa-fw fa-edit"></i> Forms
     </a>
     <ul class="nav-sub">
         <li><a href="forms-components.html" title="Components">Components</a>
         </li>
         <li><a href="forms-validation.html" title="Validation">Validation</a>
         </li>
         <li><a href="forms-mask.html" title="Mask">Mask</a>
         </li>
         <li><a href="forms-wizard.html" title="Wizard">Wizard</a>
         </li>
         <li><a href="forms-multiple-file.html" title="Multiple File Upload">Multiple File Upload</a>
         </li>
         <li><a href="forms-wysiwyg.html" title="WYSIWYG Editor">WYSIWYG Editor</a>
         </li>
     </ul>
 </li>
 */
		var temp = '<h5 class="sidebar-header">Navigation</h5><ul class="nav nav-pills nav-stacked">';
		for (i = 0; i < menuList.length; i++) {
			if(parentIdx != menuList[i].parent_sq) {
				if(parentIdx > 0) {
					temp += '</ul></li>';
				}
				// new
				temp += '<li class="nav-dropdown"><a href="#" title="' + menuList[i].main_id + '"><i class="fa  fa-fw fa-edit"></i>';
				temp += menuList[i].main_nm;
				temp += '</a><ul class="nav-sub">';
			}
			// old
			temp += '<li id="' + menuList[i].menu_id + '">';
			temp += '<a name="' + menuList[i].menu_id + '" href="${contextPath}' + menuList[i].menu_url + '" onclick="setMenuId(this);">';
			temp += menuList[i].menu_nm + '</a></li>';
			parentIdx = menuList[i].parent_sq;
		}
		temp += '</ul></li>';
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