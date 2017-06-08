<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ include file="../inc/mobileheader.jsp" %> 
<!-- 
DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="keywords" content="Jiransecurity">
</head>
-->
<body> 
	<div class="wrap">
		<article>
			<section>
				<div class="container4">
					<a href="<c:url value='/appinf/mobilefaq.do?user_id='/>${user_id}" target="_self">FAQ</a>
				</div><!-- container2 -->
				
				<div class="container4">
					<a href="#" target="_self">공지사항</a>
				</div><!-- container2 -->
				
				<div class="container4">
					<a href="<c:url value='/appinf/mobilemnginteg.do?user_id='/>${user_id}" target="_self">기기사용내역통합관리</a>
				</div><!-- container2 -->
				
				<div class="container4">
					<a href="<c:url value='/appinf/getMedcInquiry.do?user_id='/>${user_id}" target="_self">문진표</a>
				</div><!-- container2 -->
			</section>
		</article>
	</div> <!-- wrap --> 
 </body>
</html>