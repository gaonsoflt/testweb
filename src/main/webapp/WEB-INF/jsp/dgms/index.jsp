<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"    uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>

<sec:authentication property="principal" var="userStore"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="mobile-web-app-capable" content="yes">
    
	<title>의령창조마을</title>
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<!-- Bootstrap 3.3.2 -->
    <link href="<c:url value='/resource/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons -->
    <link href="http://code.ionicframework.com/ionicons/2.0.0/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="<c:url value='/resource/dist/css/AdminLTE.css'/>" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
          page. However, you can choose any other skin. Make sure you
          apply the skin class to the body tag so the changes take effect.
    -->
    <link href="<c:url value='/resource/dist/css/skins/skin-blue.min.css'/>" rel="stylesheet" type="text/css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    
    <!-- <link rel="stylesheet" href="divLayout.css"> -->
	<!-- <script src="javascripts/lib/jquery-1.4.4.min.js"></script> -->
	
    <!-- jQuery 2.1.3 -->
    <script src="<c:url value='/resource/plugins/jQuery/jQuery-2.1.3.min.js'/>"></script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="<c:url value='/resource/bootstrap/js/bootstrap.min.js'/>" type="text/javascript"></script>
    <!-- AdminLTE App -->
    <script src="<c:url value='/resource/dist/js/app.min.js'/>" type="text/javascript"></script>
    <!-- FastClick -->
    <script src="<c:url value='/resource/plugins/fastclick/fastclick.min.js'/>" type="text/javascript"></script>
    <!-- AdminLTE for demo purposes -->
    <%-- <script src="<c:url value='/resource/dist/js/demo.js'/>" type="text/javascript"></script> --%><!-- 설정 톱니바퀴 -->
</head>

<!--
  BODY TAG OPTIONS:
  =================
  Apply one or more of the following classes to get the 
  desired effect
  |---------------------------------------------------------|
  | SKINS         | skin-blue                               |
  |               | skin-black                              |
  |               | skin-purple                             |
  |               | skin-yellow                             |
  |               | skin-red                                |
  |               | skin-green                              |
  |---------------------------------------------------------|
  |LAYOUT OPTIONS | fixed                                   |
  |               | layout-boxed                            |
  |               | layout-top-nav                          |
  |               | sidebar-collapse                        |  
  |---------------------------------------------------------|
  
  -->
  <body class="skin-blue">
    <div class="wrapper">
      <!-- Main Header -->
      <header class="main-header">
        <!-- Logo -->
        <a href="<c:url value='/dgms/index.do'/>" class="logo"><b>DGMCARE</b></a>

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
              <!-- Messages: style can be found in dropdown.less-->
              <!-- <li class="dropdown messages-menu">
                Menu toggle button
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-envelope-o"></i>
                  <span class="label label-success">4</span>
                </a>
                <ul class="dropdown-menu">
                  <li class="header">You have 4 messages</li>
                  <li>
                    inner menu: contains the messages
                    <ul class="menu">
                      <li>start message
                        <a href="#">
                          <div class="pull-left">
                            User Image
                            <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image"/>
                          </div>
                          Message title and timestamp
                          <h4>                            
                            Support Team
                            <small><i class="fa fa-clock-o"></i> 5 mins</small>
                          </h4>
                          The message
                          <p>Why not buy a new awesome theme?</p>
                        </a>
                      </li>end message                      
                    </ul>/.menu
                  </li>
                  <li class="footer"><a href="#">See All Messages</a></li>
                </ul>
              </li>/.messages-menu -->

              <!-- Notifications Menu -->
              <li class="dropdown notifications-menu">
                <!-- Menu toggle button -->
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-bell-o"></i>
                  <span class="label label-warning">7</span>
                </a>
                <ul class="dropdown-menu">
                  <li class="header">You have 10 notifications</li>
                  <li>
                    <!-- Inner Menu: contains the notifications -->
                    <ul class="menu">
                      <li><!-- start notification -->
                        <a href="#">
                          <i class="fa fa-users text-aqua"></i> 5 new members joined today
                        </a>
                      </li><!-- end notification -->                      
                    </ul>
                  </li>
                  <li class="footer"><a href="#">View all</a></li>
                </ul>
              </li>
              <!-- Tasks Menu -->
              <li class="dropdown tasks-menu">
                <!-- Menu Toggle Button -->
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-flag-o"></i>
                  <span class="label label-danger">9</span>
                </a>
                <ul class="dropdown-menu">
                  <li class="header">You have 9 tasks</li>
                  <li>
                    <!-- Inner menu: contains the tasks -->
                    <ul class="menu">
                      <li><!-- Task item -->
                        <a href="#">
                          <!-- Task title and progress text -->
                          <h3>
                            Design some buttons
                            <small class="pull-right">20%</small>
                          </h3>
                          <!-- The progress bar -->
                          <div class="progress xs">
                            <!-- Change the css width attribute to simulate progress -->
                            <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                              <span class="sr-only">20% Complete</span>
                            </div>
                          </div>
                        </a>
                      </li><!-- end task item -->                      
                    </ul>
                  </li>
                  <li class="footer">
                    <a href="#">View all tasks</a>
                  </li>
                </ul>
              </li>
              <!-- User Account Menu -->
              <li class="dropdown user user-menu">
                <!-- Menu Toggle Button -->
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <!-- The user image in the navbar-->
                  <img src="<c:url value='/resource/dist/img/user2-160x160.jpg'/>" class="user-image" alt="User Image"/>
                  <!-- hidden-xs hides the username on small devices so only the image appears. -->
                  <span class="hidden-xs"><c:out value="${userStore.fullname}"/>님 &lt;Admin&gt; 반갑습니다.</span>
                </a>
                <ul class="dropdown-menu">
                  <!-- The user image in the menu -->
                  <li class="user-header">
                    <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image" />
                    <p>
                      Alexander Pierce - Web Developer
                      <small>Member since Nov. 2012</small>
                    </p>
                  </li>
                  <!-- Menu Body -->
                  <li class="user-body">
                    <div class="col-xs-4 text-center">
                      <a href="#">Followers</a>
                    </div>
                    <div class="col-xs-4 text-center">
                      <a href="#">Sales</a>
                    </div>
                    <div class="col-xs-4 text-center">
                      <a href="#">Friends</a>
                    </div>
                  </li>
                  <!-- Menu Footer-->
                  <li class="user-footer">
                    <div class="pull-left">
                      <a href="#" class="btn btn-default btn-flat">Profile</a>
                    </div>
                    <div class="pull-right">
                      <a href="#" class="btn btn-default btn-flat">Sign out</a>
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
          <!-- Sidebar user panel (optional) -->
          <!-- 노부모 돌보미 로고 -->
<!--           <div class="user-panel">
            <div class="pull-left image2">
              <img class="img-rounded" alt="대구노인돌보미 로고 이미지" />
            </div>
          </div> -->
          <div class="user-panel">
            <div class="pull-left">
              <img class="img" style="board:0px; 
              background:url('<c:url value='/resource/images/main_logo.png'/>') no-repeat center 20px; width:100%;height:155px; " 
              alt="대구노인돌보미 로고 이미지" />
            </div>
          </div>
          
          <!-- 메뉴 -->
          <ul class="sidebar-menu">
            <li class="header">MENU</li>
            
            <li class="treeview active">
              <a href="#">
                <i class="fa fa-laptop"></i>
                <span>측정결과</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li><a href="<c:url value='/dgms/dashboard.do'/>"><i class="fa fa-circle-o"></i> 메인화면</a></li>
                <li><a href="<c:url value='/dgms/dataMedc.do'/>"><i class="fa fa-circle-o"></i> 복약내역조회</a></li>
                <li><a href="<c:url value='/dgms/dataEcg.do'/>"><i class="fa fa-circle-o"></i> 심전도측정결과조회</a></li>
                <li><a href="<c:url value='/dgms/dataBld.do'/>"><i class="fa fa-circle-o"></i> 혈압측정결과조회</a></li>
              </ul>
            </li>
            
            <li class="treeview">
              <a href="#">
                <i class="fa fa-laptop"></i>
                <span>안전서비스</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li><a href="<c:url value='/dgms/appReq.do'/>"><i class="fa fa-circle-o"></i> 서비스신청</a></li>
                <li><a href="<c:url value='/dgms/myPage.do'/>"><i class="fa fa-circle-o"></i> 마이페이지</a></li>
                <li><a href="<c:url value='/dgms/infoGps.do'/>"><i class="fa fa-circle-o"></i> 위치파악</a></li>
                <li><a href="<c:url value='/dgms/rentFault.do'/>"><i class="fa fa-circle-o"></i> 서비스장애등록</a></li>
              </ul>
            </li>
            
            <li class="treeview">
              <a href="#">
                <i class="fa fa-laptop"></i>
                <span>운영관리</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li><a href="<c:url value='/dgms/mngCode.do'/>"><i class="fa fa-circle-o"></i> 기준관리</a></li>
                <li><a href="<c:url value='/dgms/mngUser.do'/>"><i class="fa fa-circle-o"></i> 사용자관리</a></li>
                <li><a href="<c:url value='/dgms/mngPrescript.do'/>"><i class="fa fa-circle-o"></i> 처방전정보관리</a></li>
                <li><a href="<c:url value='/dgms/mngGrp.do'/>"><i class="fa fa-circle-o"></i> 그룹(무전)관리</a></li>
                <li><a href="<c:url value='/dgms/mngEquip.do'/>"><i class="fa fa-circle-o"></i> 측정기기관리</a></li>
                <li><a href="<c:url value='/dgms/mngFault.do'/>"><i class="fa fa-circle-o"></i> 서비스장애관리</a></li>
                <li><a href="<c:url value='/dgms/monitering.do'/>"><i class="fa fa-circle-o"></i> 기기통합모니터링</a></li>
                <li><a href="<c:url value='/dgms/mngInteg.do'/>"><i class="fa fa-circle-o"></i> 기기사용내역통합관리</a></li>
                <li><a href="<c:url value='/dgms/qa.do'/>"><i class="fa fa-circle-o"></i> Q&A관리</a></li>
                <li><a href="<c:url value='/dgms/notice.do'/>"><i class="fa fa-circle-o"></i> 공지사항관리</a></li>
              </ul>
            </li>
            
          </ul>
          
        </section>
      </aside>
      
      
      
      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            화면명
            <small>소제목</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">화면경로</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
          <!-- 내용 -->
          <div class='box box-default'>  
            <div class='box-header with-border'>
              <h3 class='box-title'><i class="fa fa-tag"></i> 내용</h3>
            </div>
            <div class='box-body'>
              <div class='row'>
                
       
              </div><!-- /.row -->
            </div><!-- /.box-body -->
          </div>
        </section>    
        
      </div>
        
        
        
      <!-- Main Footer -->
      <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 1.0
        </div>
        <strong>Copyright &copy; 1997-2015 <a href="http://www.daegu.go.kr">Daegu Metropolitan City</a>.</strong> All rights reserved.
      </footer>

    </div>
    
    

</body>


</html>