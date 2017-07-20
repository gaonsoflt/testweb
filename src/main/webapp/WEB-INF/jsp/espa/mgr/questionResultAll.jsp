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
				<div id="gridList"></div>
			</div>
		</div>
	</section>
</section>

<div id="window" style="display:none;">
	<div>
		<button id="cancel-btn" data-role="button" data-icon="cancel" data-bind="click: cancel" style="float:right;margin:10px 10px 0 0;">취소</button>
	</div>
	<table style="width:100%">
		<tbody>
			<tr>
				<td>
					<div id="grid-result"></div>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<script>
	$(document).ready(function() {
		/*************************/
		/* dataSgridListDetail */
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/mgr/question/deploy/result";
		$("#gridList").kendoGrid({
			dataSource: {
				transport: {
					read	: { 
						url: crudServiceBaseUrl + "/list.do",
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
							candidate:			{ type: "number" },
							submit_user:		{ type: "number" }
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
                                    url: "${contextPath}/mgr/question/deploy/groups.do",
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
				{ field: "status", title: "상태", width : "10%", attributes : { style : "text-align: center;" },
					filterable: { 
                        dataSource: new kendo.data.DataSource({
                            data: [
								{"status":"마감"},
								{"status":"진행중"}
							]
                        }),
                        multi: true 
                    }
				},
				{ field: "", title: "응시율", width : "10%", attributes : { style : "text-align: center;" }, filterable: false,
					template : "#= submit_user/candidate * 100 #%" },
				{ field: "submit_user", title: "응시자", width : "5%", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "candidate", title: "대상자", width : "5%", attributes : { style : "text-align: center;" }, filterable: false },
				{ field : "submit_from", title : "제출시작", width : 150, attributes : {	style : "text-align: center;" }, filterable: false,
					template : "#= (submit_from == '') ? '' : kendo.toString(new Date(Number(submit_from)), 'yyyy-MM-dd HH:mm') #" },
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
				var seq = selectedItem.deploy_seq; 
				console.log("selected item: " + seq + "(seq)");
				location.href='${contextPath}/mgr/question/deploy/result/detail.do?deploy=' + seq;
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