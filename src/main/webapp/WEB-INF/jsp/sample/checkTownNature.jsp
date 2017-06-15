<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 

<style>
/* 
#editForm div label {
    font-weight: bold;
    display: inline-block;
    width: 90px;
    text-align: right;
}

#editForm label {
    display: block;
    margin-bottom: 10px;
} 
*/

    
</style>
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>자연해설판
            <small>자연해설 정보를 확인합니다</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 마을알림안내판</a></li>
			<li class="active">자연해설판</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
        <div class="row">
			<div class="col-xs-12">
				<div class="box"> 
					<div class="box-body">
						<iframe src="https://goo.gl/zPvwxa" style="width:100%; height:9800px" scrolling="no" frameborder="0" id="contentView"></iframe>
					</div>
				</div><!-- box --> 
			</div><!-- col-xs-12 -->
		</div><!-- row -->
    </section>    
	</div>
	<script>
	</script>
<%@ include file="../inc/footer.jsp" %>