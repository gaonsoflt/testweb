<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>

		<div class="topbar-left">
			<ol class="breadcrumb">
				<li class="crumb-active">
					<a href="<c:url value='/main.do'/>">대쉬보드</a>
				</li>
				<li class="crumb-link">
					<a href="#">${main.menu_nm}</a>
				</li>
				<li class="crumb-trail">${menu.menu_nm}</li>
			</ol>
		</div>
		<div class="topbar-right">
			<div class="ib topbar-dropdown">
				<label for="topbar-multiple" class="control-label pr10 fs11 text-muted">${menu.menu_desc}</label>
			</div>
		</div>
	</header>
	<!-- Main content -->
	<section id="content" class="table-layout animated fadeIn">
		<div class="row">
			<div class="col-md-12">
				dashboard
			</div>
		</div>
	</section>
<%@ include file="../inc/footer.jsp"%>