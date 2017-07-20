<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../inc/header.jsp"%>
<%@ include file="../../inc/aside.jsp"%>

		<div class="topbar-left">
			<ol class="breadcrumb">
				<li class="crumb-active">
					<a href="<c:url value='${menu.menu_url}'/>">${menu.menu_nm}</a>
				</li>
				<li class="crumb-link">
					<a href="#">${menu.main_nm}</a>
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
				제출한 답안의 채점이 완료되었습니다.<br>
				${user_seq}<br>
				결과페이지로 이동 : <Button type="button" onclick="goResultPage();">이동</Button>
			</div>
		</div>
	</section>
</section>

<script>
	function goResultPage() {
		location.href="<c:url value='/class/question/deploy/result.do'/>"; 
	}
</script>
<%@ include file="../../inc/footer.jsp"%>