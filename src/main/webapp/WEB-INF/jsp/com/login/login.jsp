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
	<link rel="stylesheet" href="<c:url value='/resource/css/common.css'/>">
	<link rel="stylesheet" href="<c:url value='/resource/css/login.css'/>">
    <script src="<c:url value='/resource/plugins/jQuery/jQuery-2.1.3.min.js'/>"></script>
	<title>LOGIN</title>
</head>
<body>
	<div class="wrap">
		
    <form name="frmLogin" class="form-signin" action="<c:url value="/j_spring_security_check"/>" method="post">
		<article>
			<section>
				<h2>member_login</h2>
				<div class="login_body">
						<fieldset>
							<legend>로그인 입력</legend>
							<label>Username</label>
							<input name="j_username" type="text" value="admin"/>
							<label>Password</label>
							<input name="j_password" type="password" value="a1234"/>
							
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
            
							<label><input type="checkbox" name="chack" /><span class="ch_tx">아이디 저장</span></label>
							<div>
							<button type="submit">LOGIN</button>
							</div>
						</fieldset>
					</div>
			</section>
		</article>

    </form>
    
    
	</div>
	
	
<!-- js placed at the end of the document so the pages load faster -->
<%-- <script type="text/javascript" src="<c:url value="/js/lib/kendoui/jquery.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/lib/bootstrap/bootstrap.min.js"/>"></script> --%>
<script type="text/javascript">
    $(document).ready(function() {
        $("button[type=submit]").click(function() {

            if ($('input[type=text]', '.form-signin').val() == '' || $('input[type=password]', '.form-signin').val() == '')
                return false;
        });
    });
</script>


 </body>
</html>