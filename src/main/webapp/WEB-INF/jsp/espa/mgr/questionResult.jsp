<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../inc/header.jsp"%>
<%@ include file="../../inc/aside.jsp"%>
<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i>${menu.menu_nm} <small>${menu.menu_desc}</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> ${menu.main_nm}</a></li>
			<li class="active">${menu.menu_nm}</li>
		</ol>
	</section>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-xs-12">
<!-- 				<div class="box"> -->
					<div class="box-body">
						<div>
							<button type="button" id="list-btn" onclick="fn_list();"><spring:message code="button.list" text="list" /></button>
						</div>
						<table class="mytable" style="width:100%;">
							<colgroup>
								<col width="50%">
								<col width="50%">
							</colgroup>
							<tbody>
								<tr>
									<td>
										<label class="col-sm-3 control-label">제목</label>
										<div class="col-sm-6">${depQuesInfo.title}</div>
									</td>
									<td>
										<label class="col-sm-3 control-label">기간</label>
										<div class="col-sm-6">${depQuesInfo.submit_from} ~ ${depQuesInfo.submit_to}</div>
									</td>
								</tr>
								<tr>
									<td>
										<label class="col-sm-3 control-label">상태</label>
										<div class="col-sm-6">${depQuesInfo.status}</div>
									</td>
									<td>
										<label class="col-sm-3 control-label">응시율</label>
										<div class="col-sm-6">${depQuesInfo.status}</div>
									</td>
								</tr>
							</tbody>
						</table>
						<div id="gridList"></div>
					</div>
				</div> <!-- box -->
			</div> <!-- col-xs-12 -->
		</div> <!-- row -->
	</section>
</div>

<div id="window" style="display:none;">
	<div>
		<button id="cancel-btn" data-role="button" data-icon="cancel" data-bind="click: cancel" style="float:right;margin:10px 10px 0 0;">취소</button>
	</div>
	<table style="width:100%">
		<colgroup>
			<col width="50%">
			<col width="50%">
		</colgroup>
		<tbody>
			<tr>
				<td>
					<table style="width:100%;">
						<colgroup>
							<col width="20%">
							<col width="80%">
						</colgroup>
						<tbody>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<script>
	/* DropDownList Template */
	var questionViewModel;
	var questionModel;
	var wnd;
	var G_Seq = 0;
	
	function fn_list() {
		location.href='${contextPath}/mgr/question/deploy/result.do';	
	}
	
	$(document).ready(function() {
		/*************************/
		/* deatils window
		/*************************/
		wnd = $("#window").kendoWindow({
            title: "제출",
            width: 900,
            height: 800,
            actions: [
				"Maximize",
				"Close"
			],
            modal: true,
            visible: false,
            resizable: true,
            open: function() {
            	console.log("window.open");
        		// read question detail
				questionViewModel.dataSource.read();
				document.getElementById("answer_type").checked = true;
				$("#submit_editor").css({ "display" : "block" });
				$("form .k-upload").css({ "display" : "none" });
            },
            close: function() {
            	console.log("window.close");
        		G_Seq = 0;
        		$("#gridList").data("kendoGrid").dataSource.read();
            }
        }).data("kendoWindow");

		/*************************/
		/* dataSgridListDetail */
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/question/deploy/result";
		$("#gridList").kendoGrid({
			dataSource: {
				transport: {
					read	: { 
						url: crudServiceBaseUrl + "/readGradingResultOfUserList.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("deploy-grid:dataSource:read:complete");
					    	console.log(e);
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
		                   		deploy_seq : "${deploy_seq}"
							};
							return { params: kendo.stringify(result) }; 
						}
					}
				},
				schema: {
					data: function(response) {
						return response.rtnList;
					},
					total: function(response) {
						return response.total;
					},
					errors: function(response) {
						return response.error;
					},
					model:{
						id: "user_seq",
						fields: {
							user_seq		: { type: "number" },
							user_name		: { type: "string" },
							user_id			: { type: "string" },
							submit_dt		: { type: "string" },
							user_submit_cnt : { type: "number" }
						}  
					}
				},
		        error : function(e) {
			    	console.log('deploy-grid:dataSource:error: ' + e.errors);
		        },
		        batch : true,
				page : 1, //     반환할 페이지
				pageSize : 15, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 15
			},
			height: 715,
			resizable: true,  //컬럼 크기 조절
			reorderable: false, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row",
			scrollable: true,
			sortable : true,
			mobile: true,
			pageable : false,
			filterable: true,
            toolbar: false,
			columns: [
				{ field: "user_seq", hidden: true },
				{ field: "user_id", title: "아이디", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "user_name", title: "이름", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "user_submit_cnt", title: "제출횟수", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "exec_time", title: "실행시간", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "score", title: "점수", attributes : { style : "text-align: center;" }, filterable: false },
				{ field : "submit_dt", title : "제출일시", width : 150, attributes : {	style : "text-align: center;" }, filterable: false,
					template : "#= (submit_dt == '') ? '미제출' : kendo.toString(new Date(Number(submit_dt)), 'yyyy-MM-dd HH:mm') #" }
			],
			editable: false,
			noRecords: {
				template: "결과가 없습니다."
            },
            change: function(e) {
				console.log("deploy-grid:change");
				var selectedItem = this.dataItem(this.select());
				G_Seq = selectedItem.deploy_seq; 
				console.log("selected item: " + G_Seq + "(seq)");
                // open window
//         		wnd.center().open();
            },
            dataBound: function(e) {
            	console.log("deploy-grid:dataBound");
            }
		});
	});//document ready javascript end...
</script>

<style>
	.k-edit-form-container {
		width: 100%;
	}
	.k-grid table {
		table-layout: fixed;
	}
	.k-grid td {
	    overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
	.mytable { border-collapse:collapse; }  
	.mytable th, .mytable td { border:1px solid black; }
</style>
<%@ include file="../../inc/footer.jsp"%>