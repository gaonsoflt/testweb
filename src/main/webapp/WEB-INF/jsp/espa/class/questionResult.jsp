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
			<!-- 내용 -->
			<div class="col-xs-12">
				<!-- table 하나 -->
				<div class="box">
					<div class="box-body">
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
						url: crudServiceBaseUrl + "/readGradingResultListByUser.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("deploy-grid:dataSource:read:complete");
					    	console.log(e);
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
// 	                   			PAGESIZE : data.pageSize,
// 								SKIP : data.skip,
// 								PAGE : data.page,
// 								TAKE : data.take
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
						id: "deploy_seq",
						fields: {
							deploy_seq:			{ type: "number" },
							group_name:			{ type: "string" },
							title:				{ type: "string" },
							status:				{ type: "string" },
							lang_type:			{ type: "string" },
							submit_from:		{ type: "string" },
							submit_to:			{ type: "string" },
							submit_dt:			{ type: "string" },
							score:				{ type: "number" },
							max_submit_cnt:		{ type: "number" },
							user_submit_cnt:	{ type: "number" }
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
				{ field: "deploy_seq", hidden: true },
				{ field: "group_name", title: "배포그룹", width: "20%", attributes : { style : "text-align: center;" },
					filterable: { 
                        dataSource: {
                            transport: {
                                read: {
                                    url: "${contextPath}/question/deploy/groupsByUser.do",
                                    dataType: "jsonp",
                                    data: {
                                    	field: "group_name"
                					}
                                },
                                parameterMap: function(data, type) {//type =  read, create, update, destroy
            						if (type == "read"){
            		                   	var result = {
            							};
            							return { params: kendo.stringify(result) }; 
            						}
            					},
                           }
                        },
                        multi: true 
                    }
				},
				{ field: "title", title: "제목", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "status", title: "상태", width : "10%", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "score", title: "점수", width : "10%", attributes : { style : "text-align: center;" }, filterable: false },
				{ field : "submit_dt", title : "최종제출일시", width : 150, attributes : {	style : "text-align: center;" }, filterable: false,
					template : "#= (submit_dt == '') ? '미제출' : kendo.toString(new Date(Number(submit_dt)), 'yyyy-MM-dd HH:mm') #" },
				{ field: "user_submit_cnt", title: "제출횟수", width : "8%", attributes : { style : "text-align: center;" }, filterable: false,
					template : "#= user_submit_cnt # / #=max_submit_cnt #"},
				{ field : "submit_to", title : "제출마감", width : 150, attributes : {	style : "text-align: center;" }, filterable: false,
					template : "#= (submit_to == '') ? '' : kendo.toString(new Date(Number(submit_to)), 'yyyy-MM-dd HH:mm') #" }
			],
			editable: false,
			noRecords: {
				template: "현재 진행중인 문제가 없습니다."
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
</style>
<%@ include file="../../inc/footer.jsp"%>