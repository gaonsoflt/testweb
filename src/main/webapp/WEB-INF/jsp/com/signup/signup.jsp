<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
<link rel="stylesheet" type="text/css" href="<c:url value='/resource/css/espa/assets/skin/default_skin/css/theme.css'/>">
<!-- Admin Forms CSS -->
<link rel="stylesheet" type="text/css" href="<c:url value='/resource/css/espa/assets/admin-tools/admin-forms/css/admin-forms.css'/>">
<!-- Favicon -->
<link rel="shortcut icon" href="<c:url value='/resource/css/espa/assets/img/favicon.ico'/>">

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
			<section id="content" class="">
				<div class="admin-form theme-info mw700" style="margin-top: 3%;" id="login1">
					<div class="row mb15 table-layout">
						<div class="col-xs-6 va-m pln">
							<a href="dashboard.html" title="Return to Dashboard"> 
								<img src="<c:url value='/resource/css/espa/assets/img/logos/logo_white.png'/>" title="AdminDesigns Logo" class="img-responsive w250">
							</a>
						</div>
						<div class="col-xs-6 text-right va-b pr5">
							<div class="login-links">
								<a href="<c:url value='/index.do'/>" class="" title="Sign In"><spring:message code="login.signin" text="default text" /></a> 
								<span class="text-white"> | </span> 
								<a href="<c:url value='/signup.do'/>" class="active" title="Sign Up"><spring:message code="signup.signup" text="default text" /></a>
							</div>
						</div>
					</div>

					<div class="panel panel-info mt10 br-n">
						<form id="signup_form" action="<c:url value='/signup/register.do'/>" method="post" onsubmit="return fn_onsubmit(this);">
							<div class="panel-body p25 bg-light">
								<div class="section-divider mt10 mb40">
									<span>Set up your account</span>
								</div>
								<!-- .section-divider -->

								<div class="section">
									<label for="user_id" class="field prepend-icon"> 
										<input type="text" name="user_id" id="user_id" class="form-control" placeholder="<spring:message code="signup.userID" text="default text" />" required> 
										<label for="user_id" class="field-icon">
											<i class="fa fa-user"></i>
										</label>
									</label>
<!-- 									<div class="clearfix"> -->
<%-- 									<spring:message code="errors.dupID"/> --%>
<!-- 									</div> -->
								</div>
								
								<div class="section row">
									<div class="form-group">
										<div class="col-md-6">
											<label for="password" class="field prepend-icon"> 
												<input type="password" name="password" id="password" class="form-control" placeholder="<spring:message code="signup.password" text="default text" />" required> 
												<label for="password" class="field-icon"> 
													<i class="fa fa-unlock-alt"></i>
												</label>
											</label>
										</div>
										<div class="col-md-6">
											<label for="confirmPassword" class="field prepend-icon">
												<input type="password" name="confirmPassword" id="confirmPassword" class="form-control" placeholder="<spring:message code="signup.confirmPassword" text="default text" />" required> 
												<label for="confirmPassword" class="field-icon"> 
													<i class="fa fa-lock"></i>
												</label>
											</label>
										</div>
									</div>
								</div>
								<!-- end section -->
								
								<div class="section">
									<label for="username" class="field prepend-icon"> 
										<input type="text" name="username" id="username" class="form-control" placeholder="<spring:message code="signup.username" text="default text" />" required> 
										<label for="username" class="field-icon">
											<i class="fa fa-user"></i>
										</label>
									</label>
								</div>
								
								<div class="section">
									<label for="phone" class="field prepend-icon"> 
										<input type="text" name="phone" id="phone" class="form-control phone" autocomplete="off" maxlength="10" placeholder="<spring:message code="signup.phone" text="default text" />" required> 
										<label for="phone" class="field-icon">
											<i class="fa fa-phone"></i>
										</label>
									</label>
								</div>
								<!-- end section -->

								<div class="section">
									<label for="email" class="field prepend-icon">
										<input type="email" name="email" id="email" class="form-control" placeholder="<spring:message code="signup.email" text="default text" />" required> 
										<label for="email" class="field-icon"> 
											<i class="fa fa-envelope"></i>
										</label>
									</label>
								</div>
								<!-- end section -->

								<div class="section-divider mv40">
									<span>Review the Terms</span>
								</div>
								<!-- .section-divider -->

								<div class="section mb15">
									<label class="option block mt15"> 
										<input type="checkbox" name="terms"> 
										<span class="checkbox"></span>
										<a href="#" class="theme-link"> <spring:message code="signup.terms" text="default text" /></a>
										<spring:message code="signup.agree" text="default text" />
									</label>
								</div>
								<!-- end section -->

							</div>
							<!-- end .form-body section -->
							<div class="panel-footer clearfix">
								<button type="submit" id="btn-signup" disabled="disabled" class="button btn-primary pull-right"><spring:message code="signup.register" text="default text" /></button>
							</div>
							<!-- end .form-footer section -->
						</form>
					</div>
				</div>

			</section>
			<!-- End: Content -->

		</section>
		<!-- End: Content-Wrapper -->

	</div>
	<!-- End: Main -->

	<!-- BEGIN: PAGE SCRIPTS -->

	<!-- jQuery -->
	<script
		src="<c:url value='/resource/css/espa/vendor/jquery/jquery-1.11.1.min.js'/>"></script>
	<script
		src="<c:url value='/resource/css/espa/vendor/jquery/jquery_ui/jquery-ui.min.js'/>"></script>

	<!-- CanvasBG Plugin(creates mousehover effect) -->
	<script
		src="<c:url value='/resource/css/espa/vendor/plugins/canvasbg/canvasbg.js'/>"></script>

	<!-- Theme Javascript -->
	<script
		src="<c:url value='/resource/css/espa/assets/js/utility/utility.js'/>"></script>
	<script
		src="<c:url value='/resource/css/espa/assets/js/demo/demo.js'/>"></script>
	<script src="<c:url value='/resource/css/espa/assets/js/main.js'/>"></script>

	<!-- Page Javascript -->
	<script type="text/javascript">
		function fn_onsubmit(e) {
			return true;
		}
		
		$(document).ready(function() {
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
			
			$("input[type=password]").change(function() {
				if($("#confirmPassword").val() != '') {
					if($("#password").val() == $("#confirmPassword").val()) {
						document.getElementById("confirmPassword").parentElement.parentElement.parentElement.className = "form-group has-success";
						if($("input[name=terms]")[0].checked) {
							document.getElementById("btn-signup").disabled = false;
						}
					} else {
						document.getElementById("confirmPassword").parentElement.parentElement.parentElement.className = "form-group has-error";
						document.getElementById("btn-signup").disabled = true;
					}
				}
				return true;
			});
			
			$("input[name=terms]").change(function() {
				if(this.checked) {
					if($("#password").val() == $("#confirmPassword").val()) {
						document.getElementById("btn-signup").disabled = false;
					}
				} else {
					document.getElementById("btn-signup").disabled = true;
				}
			});
		});
	</script>
	<!-- END: PAGE SCRIPTS -->
</body>
</html>
