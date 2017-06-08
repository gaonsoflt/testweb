<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>
<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i> 화상장비연결 <small>원격 의료상담을 위한 화상장비를 연결합니다. </small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 원격의료상담관리</a></li>
			<li class="active">화상장비연결 </li>
		</ol>
	</section>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<!-- 내용 -->
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
					<c:set var="error" value="${error}" />
					<c:choose>
    					<c:when test="${error eq 'true'}">
							<div>화상장비 연결에 실패했습니다.</div>
    					</c:when>
					    <c:otherwise>
							<div>화상장비 연결에 성공했습니다.</div>
					    </c:otherwise>
					</c:choose>
					</div>
				</div>
				<!-- box -->
			</div>
			<!-- col-xs-12 -->
		</div>
		<!-- row -->
	</section>
</div>
<%@ include file="../inc/footer.jsp"%>