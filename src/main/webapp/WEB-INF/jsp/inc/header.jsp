<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"    uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>

<sec:authentication property="principal" var="userStore"/>
<c:set var="contextPath" value="<%= request.getContextPath()%>"></c:set>  

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
 	<meta name="mobile-web-app-capable" content="yes">
    
	<title>ESPA</title>
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<!-- Bootstrap 3.3.2 -->
    <link href="<c:url value='/resource/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <!-- <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" /> -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons -->
    <link href="http://code.ionicframework.com/ionicons/2.0.0/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="<c:url value='/resource/dist/css/AdminLTE.css'/>" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
          page. However, you can choose any other skin. Make sure you
          apply the skin class to the body tag so the changes take effect.
    -->
    <link href="<c:url value='/resource/dist/css/skins/skin-blue.min.css'/>" rel="stylesheet" type="text/css" />
    <!-- fullCalendar 3.0.1-->
	<%-- <link href="<c:url value='/resource/fullCalendar/3.0.1/fullcalendar.css'/>" rel="stylesheet" type="text/css" />
	<link href="<c:url value='/resource/fullCalendar/3.0.1/fullcalendar.print.css'/>" rel='stylesheet' media='print' /> --%>
    <!-- fullCalendar 2.2.5-->
    <link href="<c:url value='/resource/plugins/fullcalendar/fullcalendar.min.css'/>" rel="stylesheet" type="text/css" />
    <link href="<c:url value='/resource/plugins/fullcalendar/fullcalendar.print.css'/>" rel="stylesheet" type="text/css" media='print' />
    
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
    
    <script src="<c:url value='/resource/js/comm/dgms.js'/>" type="text/javascript"></script>
    
    <script src="<c:url value='/resource/js/comm/jquery.modal.js'/>" type="text/javascript"></script>
  	<link rel="stylesheet" href="<c:url value='/resource/css/jquery.modal.css'/>" type="text/css" media="screen" />
    
    <!-- Common Kendo UI CSS for web widgets and widgets for data visualization. -->
    <link href="<c:url value='/resource/kendoui/styles/kendo.common.min.css'/>" rel="stylesheet" />
    <!-- (Optional) RTL CSS for Kendo UI widgets for the web. Include only in right-to-left applications. -->
    <link href="<c:url value='/resource/kendoui/styles/kendo.rtl.min.css'/>" rel="stylesheet" type="text/css" />
    <!-- Default Kendo UI theme CSS for web widgets and widgets for data visualization. -->
    <link href="<c:url value='/resource/kendoui/styles/kendo.default.min.css'/>" rel="stylesheet" />
    <!-- (Optional) Kendo UI Hybrid CSS. Include only if you will use the mobile devices features. -->
    <link href="<c:url value='/resource/kendoui/styles/kendo.default.mobile.min.css'/>" rel="stylesheet" type="text/css" />		
    <!-- jQuery JavaScript -->
    <%-- <script src="<c:url value='/resource/kendoui/js/jquery.min.js'/>"></script> --%>
    <!-- Kendo UI combined JavaScript -->
    <script charset="UTF-8"  src="<c:url value='/resource/kendoui/js/kendo.all.min.js'/>"></script>
    <!-- kendo 엑셀 Excel Export Is Not Working in Internet Explorer and Safari -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.4.0/jszip.min.js"></script>
    <!-- kendo 지역 설정 -->
    <script src="<c:url value='/resource/kendoui/js/cultures/kendo.culture.ko-KR.min.js'/>"></script>
	       
	<!-- Column Header alignment  -->
	<!-- code mirror -->
	<script src="<c:url value='/resource/js/codemirror/codemirror.js'/>" type="text/javascript"></script>
	<script src="<c:url value='/resource/js/codemirror/javascript.js'/>" type="text/javascript"></script>
	<link href="<c:url value='/resource/css/codemirror/codemirror.css'/>" rel="stylesheet" />
	
	<style>
	.k-header .k-link{
		text-align: center;
	}
	</style>      
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
  
  