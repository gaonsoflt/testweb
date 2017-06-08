<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#rentFault').parent().parent().addClass('active');
	$('#rentFault').addClass('active');
});	
</script>
      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            기준관리
            <small>소제목</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 운영관리</a></li>
            <li class="active">기준관리</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
          <div class="row">
          	<!-- 내용 -->
          	<div class="col-xs-12">
            
              <!-- table 하나 -->
              <div class="box">
                <div class="box-header">
                  <h3 class="box-title"><i class="fa fa-tag"></i>Hover Data Table</h3>
                </div><!-- /.box-header -->
                <div class="box-body">

                  rentFault
					        
		        </div>
		      </div><!-- box -->
					    
					    
					    
					    
					    
            </div><!-- col-xs-12 -->
          </div><!-- row -->
        </section>    
        
      </div>
        
        
<%@ include file="../inc/footer.jsp" %>