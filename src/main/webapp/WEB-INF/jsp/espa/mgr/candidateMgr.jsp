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
						<table style="width:100%;height:715px;">
							<colgroup>
								<col width="40%">
								<col width="30%">
								<col>
								<col width="30%">
							</colgroup>
							<tr>
								<th></th>
								<th>미응시대상자</th>
								<th></th>
								<th><span id="deploy_name"></span> 응시대상자</th>
							</tr>
							<tr>
								<td><div id="grid-deploy"></div></td>
								<td><div id="grid-user"></div></td>
								<td>
									<div><Button style="width:50px;height:40px;" onclick="addCandidate();">&gt;</Button></div>
									<p>
									<div><Button style="width:50px;height:40px;" onclick="removeCandidate();">&lt;</Button></div>
								</td>
								<td><div id="grid-candidate"></div></td>
							</tr>
						</table>
                	</div>
               	</div>
			</div>
		</div>
	</section>
</div>
<script type="text/x-kendo-template" id="toolbar-template">
	<div id="toolbar" style="float:left;">
		<a href="\\#" class="k-pager-refresh k-link k-button" id="save-btn" title="Save" onclick="return onClick(this);">저장</a>
	</div>
</script>     
<script>
	var G_SEQ;
	var temp;
	var selectedUser = null;
	var selectedGroupUser = null;
	
	function onClick(e) {
		var id = e.id;
		
		if(id == 'save-btn') {
			var list = {
				'deploy_seq': G_SEQ,
				'candidate': JSON.stringify($("#grid-candidate").data("kendoGrid").dataSource.data())
			};
			$.ajax({
				type: "post",
				url: "${contextPath}/mgr/question/deploy/candidate/update.do",
				data: list,
				async: false, //동기 방식
				success: function(data, status){
					console.log('/update.do');
					if(typeof data.error == 'undefined') {
						console.log(data.result);
						alert("정상적으로 저장되었습니다.");
					} else {
						alert("저장 중 에러가 발생했습니다.");
					}
					refreshUserGrid();
				}
			});		
		}
	}
	
	function addCandidate() {
		console.log("addCandidate");
		if(selectedUser != null) {
			$("#grid-candidate").data("kendoGrid").dataSource.add(selectedUser);
			$("#grid-user").data("kendoGrid").dataSource.remove(selectedUser);
			selectedUser = null;
		}
	}
	
	function removeCandidate() {
		console.log("removeCandidate");
		if(selectedGroupUser != null) {
			$("#grid-user").data("kendoGrid").dataSource.add(selectedGroupUser);
			$("#grid-candidate").data("kendoGrid").dataSource.remove(selectedGroupUser);
			selectedGroupUser = null;
		}
	}
	
	function refreshUserGrid() {
		$("#grid-user").data("kendoGrid").dataSource.read();
		$("#grid-candidate").data("kendoGrid").dataSource.read();
	}
	
	$(document).ready(function () {
		/*************************/
		/*       splitter        */
		/*************************/
	    var crudServiceBaseUrl = "${contextPath}/mgr/question/deploy/candidate";
		$("#grid-deploy").kendoGrid({
			dataSource: {
				transport: {
					read : { 
						url: crudServiceBaseUrl + "/deploylist.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("grid-deploy:dataSource:read");
					    }
					},
					parameterMap: function(data, type) {
						if (type == "read"){
	                       	var result = {
							};
							return { params: kendo.stringify(result) }; 
						}
					}
				},
				schema: {
					data: function(response) {
						console.log(response.rtnList);
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
							deploy_seq:		{ type: "number" },
							question_seq:	{ type: "number" },
							group_name:		{ type: "string" },
							title:			{ type: "string" },
							status:			{ type: "string" },
							lana_type:		{ type: "string" },
							candidate:		{ type: "number" },
							submit_from:	{ type: "string" },
							submit_to:		{ type: "string" },
							max_submit_cnt:	{ type: "number" }
						}
					}
				}
			},
	        error : function(e) {
		    	console.log('grid-deploy:dataSource:error:' + e.errors);
	        },
			pageable: false,
			height: 715,
			resizable: false,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			mobile: true,
			toolbar: false,
			columns: [
				{ field: "deploy_seq", hidden: true },
				{ field: "group_name", title: "배포그룹", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "status", title: "상태", width : 80, attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "title", title: "제목", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "candidate", title: "응시자수", width : 80, attributes : { style : "text-align: center;" }, filterable: false },
			],
			editable: false,
			noRecords: false,
            filterable: true,
            change: function(e) {
				console.log("grid-deploy:change");
				var selectedItem = this.dataItem(this.select());
		        G_SEQ = selectedItem.deploy_seq;
		        document.getElementById("deploy_name").innerHTML = selectedItem.title;
				console.log("selected item: " + G_SEQ + "(seq)");
				refreshUserGrid();
            }
		});
		
		$("#grid-user").kendoGrid({
			dataSource: {
				transport: {
					read	: { 
						url: crudServiceBaseUrl + "/userlist.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("grid-user:dataSource:read");
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
	                   			PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take,
		                   		deploy_seq: G_SEQ
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
						fields: { //data type of the field {Number|String|Boolean|Date} default is String
							user_seq:		{ type: "number" },
							user_id:		{ type: "string" },
							user_name:		{ type: "string" },
							birthday: 		{ type: "string" }
						}  
					}
				},
		        error : function(e) {
			    	console.log('grid-user:dataSource:error: ' + e.errors);
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
			autoBind: false,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			sortable : true,
			mobile: true,
			pageable : false,
// 			pageable : {
// 				pageSizes : true,
// 				messages : {
// 					display : "전체 {2} 중 {0}~{1}",
// 					empty : "출력할 항목이 없습니다",
// 					itemsPerPage : "한 페이지 출력 수"
// 				}
// 			},
			toolbar: false,
			columns: [
				{ field: "user_seq", hidden: true },
				{ field: "user_name", title: "이름", attributes : { style : "text-align: center;" } },
				{ field: "user_id", title: "아이디", attributes : { style : "text-align: center;" } },
				{ field: "birthday", title: "생년월일", attributes : { style : "text-align: center;" },
					template: "#= (birthday == '') ? '' : kendo.toString(kendo.parseDate(birthday, 'yyyyMMdd'), 'yyyy-MM-dd') #" 
				}
			],
			editable: false,
			noRecords: false,
            change: function(e) {
				console.log("grid-user:change");
				selectedUser = this.dataItem(this.select());
				console.log("selected item: " + selectedUser.user_seq + "(seq)");
            },
            dataBound: function(e) {
            	console.log("grid-user:dataBound");
            	selectedUser = null;
            }
		});
		
		$("#grid-candidate").kendoGrid({
			dataSource: {
				transport: {
					read : { 
						url: crudServiceBaseUrl + "/list.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("grid-candidate:dataSource:read");
					    }
					},
					update : { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					create : { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					destory : { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
	                   			PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take,
		                   		deploy_seq: G_SEQ
							};
							return { params: kendo.stringify(result) }; 
						}
						if (type == "update"){
		                   	var result = {
			                   	deploy_seq: G_SEQ
							};
							return { 
								params: kendo.stringify(result), 
								models: kendo.stringify(data.models) 
							}; 
						}
						if (type != "read" && type != "update" && data.models) {	
							return { models: kendo.stringify(data.models) };
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
						fields: { //data type of the field {Number|String|Boolean|Date} default is String
							user_seq:		{ type: "number" },
							user_id:		{ type: "string" },
							user_name:		{ type: "string" },
							birthday: 		{ type: "string" }
						}  
					}
				},
		        error : function(e) {
			    	console.log('grid-candidate:dataSource:error: ' + e.errors);
		        },
		        change : function(e) {
		        	console.log("grid-candidate:dataSource:change");
		        },  	
		        sync: function(e) {
		        	console.log("grid-candidate:dataSource:sync");
					alert("정상적으로 처리되었습니다.");  
					refreshUserGrid();
				}, 
				batch: true,
				page : 1, //     반환할 페이지
				pageSize : 15, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 15
			},
			height: 715,
			resizable: true,  //컬럼 크기 조절
			reorderable: false, //컬럼 위치 이동
			autoBind: false,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			sortable : true,
			mobile: true,
			pageable : false,
// 			pageable : {
// 				pageSizes : true,
// 				messages : {
// 					display : "전체 {2} 중 {0}~{1}",
// 					empty : "출력할 항목이 없습니다",
// 					itemsPerPage : "한 페이지 출력 수"
// 				}
// 			},
			toolbar: kendo.template($("#toolbar-template").html()),
			columns: [
				{ field: "user_seq", hidden: true },
				{ field: "user_name", title: "이름", attributes : { style : "text-align: center;" } },
				{ field: "user_id", title: "아이디", attributes : { style : "text-align: center;" } },
				{ field: "birthday", title: "생년월일", attributes : { style : "text-align: center;" },
					template: "#= (birthday == '') ? '' : kendo.toString(kendo.parseDate(birthday, 'yyyyMMdd'), 'yyyy-MM-dd') #" 
				}
			],
			editable: false,
			noRecords: false,
			save: function(e) {
				console.log("grid-candidate:save");
			},
			saveChanges: function(e) { 
				console.log("grid-candidate:saveChanges");
			},
            change: function(e) {
				console.log("grid-candidate:change");
				selectedGroupUser = this.dataItem(this.select());
				console.log("selected item: " + selectedGroupUser.user_seq + "(seq)");
            },
            dataBound: function(e) {
				console.log("grid-candidate:dataBound");
				invokeUserAuth($("#grid-candidate"), "kendoGrid");
            	selectedGroupUser = null;
            }
		});
		
		$("#grid-user").delegate("tbody>tr", "dblclick", function () {
			var grid = $("#grid-user").data("kendoGrid");
			selectedUser = grid.dataItem(grid.select())
			addCandidate();
		});
		
		$("#grid-candidate").delegate("tbody>tr", "dblclick", function () {
			var grid = $("#grid-candidate").data("kendoGrid");
			selectedGroupUser = grid.dataItem(grid.select())
			removeCandidate();
		});
	});	
</script>	
<style>
	.k-grid table {
		table-layout: fixed;
	}
</style>
<%@ include file="../../inc/footer.jsp"%>