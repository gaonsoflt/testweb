<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html>
<html>
<head>
<!-- Meta, title, CSS, favicons, etc. -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="HTML5 Bootstrap 3 Admin Template UI Theme" />
<meta name="description" content="AdminDesigns - A Responsive HTML5 Admin UI Framework">
<meta name="author" content="AdminDesigns">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Font CSS (Via CDN) -->
<link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700'>
<!-- Theme CSS -->
<link rel="stylesheet" type="text/css" href="<c:url value='/resource/style/espa/assets/skin/default_skin/css/theme.css'/>">
<!-- Admin Forms CSS -->
<link rel="stylesheet" type="text/css" href="<c:url value='/resource/style/espa/assets/admin-tools/admin-forms/css/admin-forms.css'/>">
<!-- Favicon -->
<link rel="shortcut icon" href="<c:url value='/resource/style/espa/assets/img/favicon.ico'/>">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
   <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
   <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
   <![endif]-->
<script src="<c:url value='/resource/plugins/jQuery/jQuery-2.1.3.min.js'/>"></script>
<title>ESPA</title>
</head>

<body class="external-page sb-l-c sb-r-c">
	<!-- Start: Main -->
	<div id="main" class="animated fadeIn">
		<!-- Start: Content-Wrapper -->
		<section id="content_wrapper">
			<!-- begin canvas animation bg -->
			<div id="canvas-wrapper">
				<canvas id="demo-canvas"></canvas>
			</div>
			<!-- Begin: Content -->
			<section id="content">
				<div class="admin-form theme-info" id="login1">
					<div class="row mb15 table-layout">
						<div class="col-xs-6 va-m pln">
							<a href="<c:url value='/index.do'/>" title="Return to Dashboard"> 
								<img src="<c:url value='/resource/style/espa/assets/img/logos/logo_white.png'/>" title="AdminDesigns Logo" class="img-responsive w250">
							</a>
						</div>
						<div class="col-xs-6 text-right va-b pr5">
							<div class="login-links">
								<a href="<c:url value='/index.do'/>" class="active" title="Sign In"><spring:message code="login.signin" text="default text" /></a> 
								<span class="text-white"> | </span> 
								<a href="<c:url value='/signup.do'/>" class="" title="Sign Up"><spring:message code="signup.signup" text="default text" /></a>
							</div>
						</div>
					</div>
					<div class="panel panel-info mt10 br-n">
						<!-- end .form-header section -->
						<form method="post" action="<c:url value="/j_spring_security_check"/>" class="form-signin" id="contact">
						<article>
						<section>
							<div class="panel-body bg-light p30">
								<div class="row">
									<div class="section">
										<label for="username" class="field-label text-muted fs18 mb10"><spring:message code="login.userID" text="default text" /></label> 
										<label for="username" class="field prepend-icon"> 
											<input name="j_username" type="text" value="admin" class="gui-input" placeholder="<spring:message code="login.input.userID" text="default text" />"> 
											<label for="j_username" class="field-icon">
												<i class="fa fa-user"></i>
											</label>
										</label>
									</div>
									<div class="section">
										<label for="username" class="field-label text-muted fs18 mb10"><spring:message code="login.password" text="default text" /></label> 
										<label for="password" class="field prepend-icon"> 
											<input name="j_password" type="password" value="a1234" class="gui-input" placeholder="<spring:message code="login.input.password" text="default text" />"> 
											<label for="j_password" class="field-icon"> 
												<i class="fa fa-lock"></i>
											</label>
										</label>
									</div>
								</div>
								<c:if test="${not empty param['error']}">
									<c:set value="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}" var="errorMsg" />
									<div>
									    <strong>
								        	<c:choose>
												<c:when test="${not empty errorMsg}">
													<font color="red" size="3">${errorMsg}</font>
												</c:when>
												<c:otherwise>
													<font color="red" size="3">
														<spring:message code="login.error.init.msg" ></spring:message>
													</font>
												</c:otherwise>
											</c:choose>
										</strong>
									</div>
								</c:if>
							</div>
							<!-- end .form-body section -->
							<div class="panel-footer clearfix p10 ph15">
								<button type="submit" class="button btn-primary mr10 pull-right"><spring:message code="login.signin" text="default text" /></button>
								<label class="switch ib switch-primary pull-left input-align mt10">
									<input type="checkbox" name="remember" id="remember" checked>
									<label for="remember" data-on="YES" data-off="NO"></label> <span><spring:message code="login.rememberme" text="default text" /></span>
								</label>
							</div>
							<!-- end .form-footer section -->
							</section>
							</article>
						</form>
					</div>
				</div>
			</section>
			<!-- End: Content -->
	</div>
	<!-- End: Main -->

	<!-- BEGIN: PAGE SCRIPTS -->

	<!-- jQuery -->
	<script src="<c:url value='/resource/style/espa/vendor/jquery/jquery-1.11.1.min.js'/>"></script>
	<script src="<c:url value='/resource/style/espa/vendor/jquery/jquery_ui/jquery-ui.min.js'/>"></script>

	<!-- CanvasBG Plugin(creates mousehover effect) -->
	<script src="<c:url value='/resource/style/espa/vendor/plugins/canvasbg/canvasbg.js'/>"></script>

	<!-- Theme Javascript -->
	<script src="<c:url value='/resource/style/espa/assets/js/utility/utility.js'/>"></script>
	<script src="<c:url value='/resource/style/espa/assets/js/demo/demo.js'/>"></script>
	<script src="<c:url value='/resource/style/espa/assets/js/main.js'/>"></script>

	<!-- Page Javascript -->
	<script type="text/javascript">
		$(document).ready(function() {
			$("button[type=submit]").click(function() {
				if ($('input[type=text]', '.form-signin').val() == '' || $('input[type=password]', '.form-signin').val() == '')
					return false;
			});

			"use strict";
			// Init Theme Core      
			Core.init();
			// Init Demo JS
			Demo.init();
			// Init CanvasBG and pass target starting location
			CanvasBG.init({
				Loc : {
					x : window.innerWidth / 2,
					y : window.innerHeight / 3.3
				},
			});
		});
	</script>
	<!-- END: PAGE SCRIPTS -->
</body>
</html>
