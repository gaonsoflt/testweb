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
    
	<title>DGMS</title>
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<!-- Bootstrap 3.3.2 -->
    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    
    <!-- <link rel="stylesheet" href="divLayout.css"> -->
    <!-- <script src="javascripts/lib/jquery-1.4.4.min.js"></script> -->
	<!-- Bootstrap 3.3.2 -->
    <link href="<c:url value='/resource/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet" type="text/css" />
    <!-- jQuery 2.1.3 -->
    <script src="<c:url value='/resource/plugins/jQuery/jQuery-2.1.3.min.js'/>"></script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="<c:url value='/resource/bootstrap/js/bootstrap.min.js'/>" type="text/javascript"></script>
   
    <!-- Common Kendo UI CSS for web widgets and widgets for data visualization. -->
    <link href="<c:url value='/resource/mobile/common/css/common.css'/>" rel="stylesheet" />
    <!-- (Optional) RTL CSS for Kendo UI widgets for the web. Include only in right-to-left applications. -->
    <link href="<c:url value='/resource/mobile/common/css/layout.css'/>" rel="stylesheet" type="text/css" />

</head>

  