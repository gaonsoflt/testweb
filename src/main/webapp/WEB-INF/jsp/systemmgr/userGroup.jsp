<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>

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
								<col width="20%">
								<col width="40%">
								<col>
								<col width="40%">
							</colgroup>
							<tr>
								<th></th>
								<th>사용자</th>
								<th></th>
								<th><span id="group_name"></span> 사용자</th>
							</tr>
							<tr>
								<td><div id="group-grid"></div></td>
								<td><div id="user-grid"></div></td>
								<td>
									<div><Button style="width:50px;height:40px;" onclick="addGroupUser();">&gt;</Button></div>
									<p>
									<div><Button style="width:50px;height:40px;" onclick="removeGroupUser();">&lt;</Button></div>
								</td>
								<td><div id="groupuser-grid"></div></td>
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
	var G_GROUP;
	var temp;
	var selectedUser = null;
	var selectedGroupUser = null;
	
	function onClick(e) {
		var id = e.id;
		
		if(id == 'save-btn') {
// 			var users = $("#groupuser-grid").data("kendoGrid").dataSource.data();
			var list = {
				'group_id': G_GROUP,
				'users': JSON.stringify($("#groupuser-grid").data("kendoGrid").dataSource.data())
			};
			$.ajax({
				type: "post",
				url: "<c:url value='/sm/usergroup/update.do'/>",
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
	
	function addGroupUser() {
		console.log("addGroupUser");
		if(selectedUser != null) {
			$("#groupuser-grid").data("kendoGrid").dataSource.add(selectedUser);
			$("#user-grid").data("kendoGrid").dataSource.remove(selectedUser);
			selectedUser = null;
		}
	}
	
	function removeGroupUser() {
		console.log("removeGroupUser");
		if(selectedGroupUser != null) {
			$("#user-grid").data("kendoGrid").dataSource.add(selectedGroupUser);
			$("#groupuser-grid").data("kendoGrid").dataSource.remove(selectedGroupUser);
			selectedGroupUser = null;
		}
	}
	
	function refreshUserGrid() {
		$("#user-grid").data("kendoGrid").dataSource.read();
		$("#groupuser-grid").data("kendoGrid").dataSource.read();
	}
	
	$(document).ready(function () {
		/*************************/
		/*       splitter        */
		/*************************/
		$("#group-grid").kendoGrid({
			dataSource: {
				transport: {
					read : { 
						url: "${contextPath}/sm/code" + "/readDetails.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("group-grid:dataSource:read");
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
	                       	var result = {
								CATGR: "100462" // 100462=_USER_GROUP_
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
						id: "cd",
						fields: { 
							cd		: { type: "string" },
							cd_nm	: { type: "string" },
							cd_id	: { type: "string" }
						}  
					}
				}
			},
	        error : function(e) {
		    	console.log('group-grid:dataSource:error:' + e.errors);
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
			toolbar: [ ],
			columns: [
				{ field: "cd", title: "시퀀스", width: 80, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "cd_nm", title: "그룹명", attributes: {style: "text-align: center;"},
					filterable: {
                        cell: {
                            operator: "contains",
                            suggestionOperator: "contains"
                        }
                    }},
				{ field: "cd_id", title: "그룹코드", width: 100, attributes: {style: "text-align: center;"}, hidden: true }
			],
			editable: false,
			noRecords: {
				template: "검색된 결과가 없습니다."
            },
            filterable: {
                mode: "row"
            },
            change: function(e) {
				console.log("group-grid:change");
				var selectedItem = this.dataItem(this.select());
		        G_GROUP = selectedItem.cd_id;
		        document.getElementById("group_name").innerHTML = selectedItem.cd_nm;
				console.log("selected item: " + G_GROUP + "(seq)");
				refreshUserGrid();
            }
		});
		
	    var crudServiceBaseUrl = "${contextPath}/sm/usergroup";
		$("#user-grid").kendoGrid({
			dataSource: {
				transport: {
					read	: { 
						url: crudServiceBaseUrl + "/readNoGroupUser.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("user-grid:dataSource:read");
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
	                   			PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take,
		                   		group_id: G_GROUP
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
			    	console.log('user-grid:dataSource:error: ' + e.errors);
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
			toolbar: [ ],
			columns: [
				{ field: "user_seq", hidden: true },
				{ field: "user_name", title: "이름", attributes : { style : "text-align: center;" } },
				{ field: "user_id", title: "아이디", attributes : { style : "text-align: center;" } },
				{ field: "birthday", title: "생년월일", attributes : { style : "text-align: center;" },
					template: "#= (birthday == '') ? '' : kendo.toString(kendo.parseDate(birthday, 'yyyyMMdd'), 'yyyy-MM-dd') #" 
				}
			],
			editable: false,
			noRecords: {
				template: "검색된 결과가 없습니다."
            },
            change: function(e) {
				console.log("user-grid:change");
				selectedUser = this.dataItem(this.select());
				console.log("selected item: " + selectedUser.user_seq + "(seq)");
            },
            dataBound: function(e) {
            	console.log("user-grid:dataBound");
            	selectedUser = null;
            }
		});
		
		$("#groupuser-grid").kendoGrid({
			dataSource: {
				transport: {
					read : { 
						url: crudServiceBaseUrl + "/readGroupUser.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("groupuser-grid:dataSource:read");
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
		                   		group_id: G_GROUP
							};
							return { params: kendo.stringify(result) }; 
						}
						if (type == "update"){
		                   	var result = {
		                   		group_id: G_GROUP
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
			    	console.log('groupuser-grid:dataSource:error: ' + e.errors);
		        },
		        change : function(e) {
		        	console.log("groupuser-grid:dataSource:change");
		        },  	
		        sync: function(e) {
		        	console.log("groupuser-grid:dataSource:sync");
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
			noRecords: {
				template: "검색된 결과가 없습니다."
            },
			save: function(e) {
				console.log("groupuser-grid:save");
			},
			saveChanges: function(e) { 
				console.log("groupuser-grid:saveChanges");
			},
            change: function(e) {
				console.log("groupuser-grid:change");
				selectedGroupUser = this.dataItem(this.select());
				console.log("selected item: " + selectedGroupUser.user_seq + "(seq)");
            },
            dataBound: function(e) {
				console.log("groupuser-grid:dataBound");
				invokeUserAuth($("#groupuser-grid"), "kendoGrid");
            	selectedGroupUser = null;
            }
		});
		
		$("#user-grid").delegate("tbody>tr", "dblclick", function () {
			var grid = $("#user-grid").data("kendoGrid");
			selectedUser = grid.dataItem(grid.select())
			addGroupUser();
		});
		
		$("#groupuser-grid").delegate("tbody>tr", "dblclick", function () {
			var grid = $("#groupuser-grid").data("kendoGrid");
			selectedGroupUser = grid.dataItem(grid.select())
			removeGroupUser();
		});
	});	
</script>	
<style>
	.k-grid table {
		table-layout: fixed;
	}
</style>
<%@ include file="../inc/footer.jsp"%>