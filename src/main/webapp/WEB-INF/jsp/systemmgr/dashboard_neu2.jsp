<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>

<!--main content start-->
<div class="content-wrapper">
	<!-- Main content -->
	<section class="content">
        <section class="main-content-wrapper">
            <div class="pageheader">
                <h1>대쉬보드</h1>
                <p class="description">${menu.menu_desc}</p>
                <div class="breadcrumb-wrapper hidden-xs">
                    <ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> ${menu.main_nm}</a></li>
						<li class="active">${menu.menu_nm}</li>
                    </ol>
                </div>
            </div>
            <section id="main-content" class="animated fadeInUp">
                <div class="row">
                    <div class="col-md-12 col-lg-6">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="panel panel-solid-success widget-mini">
                                    <div class="panel-body">
                                        <i class="icon-bar-chart"></i>
                                        <span class="total text-center">$3,200</span>
                                        <span class="title text-center">Earnings</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </section>
    </section>
</div>
<%@ include file="../inc/footer.jsp"%>