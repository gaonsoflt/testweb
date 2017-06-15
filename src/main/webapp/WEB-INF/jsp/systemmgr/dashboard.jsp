<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>

<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i>ESPA
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 대쉬보드</a></li>
			<li class="active">공지사항관리</li>
		</ol>
	</section>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<!-- 내용 -->
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
						<p style="font-size: 15px; padding: 10px 0px;">
							검색:&nbsp;&nbsp;&nbsp; <input id="in_search" />&nbsp;&nbsp;&nbsp;
							<input id="in_keyword" />&nbsp;&nbsp;&nbsp;
							<button id="searchBtn" type="button">검색</button>
						</p>
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