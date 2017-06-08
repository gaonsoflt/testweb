<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"    uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
  	<meta name="mobile-web-app-capable" content="yes">
    
	<title>대구노부모돌보미</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="keywords" content="Jiransecurity">
<!-- jQuery 2.1.3 -->
<script src="<c:url value='/resource/plugins/jQuery/jQuery-2.1.3.min.js'/>"></script>
    
<link href="<c:url value='/resource/hp/common/css/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resource/hp/common/css/layout.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resource/hp/common/css/sub.css'/>" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="wrap">
<!-- Skip Navigation -->
<nav class="skip_nav">
	<a href="#container">Skip to content</a>
</nav>
<!-- //Skip Navigation -->

<header>
	<div class="header_area">
		<div class="logo_area">
			<a href="<c:url value='/hp/index.do'/>"><h1 class="gti">대구노부모돌보미</h1></a>
			<p class="cti">대구광역시</p>
		</div><!-- logo_area-->
		<div class="navi_area">
		<div class="gnb">
			<a href="#">사이트맵</a>
			<span>｜</span>
			<a href="http://www.daegu.go.kr" target="_blank">대구광역시 홈페이지 바로가기</a>
		</div><!-- gnb -->
			<nav>
				<h2 class="hidden">메인메뉴</h2>
				<ul>
					<li><a href="<c:url value='/hp/gopage.do?f=dgmshp&p=sub_01'/>">서비스 개요</a></li>
					<li><a href="<c:url value='/hp/gopage.do?f=dgmshp&p=sub_02'/>">서비스 이용안내</a></li>
					<li><a href="#" onclick="javascript:alert('준비중입니다.');">안전센터(체험관) 소개</a></li>
					<li><a href="#" onclick="javascript:alert('준비중입니다.');">건강정보</a></li>
				</ul>
			</nav>
		</div><!-- navi_area-->
		
	</div>
</header>
  
  