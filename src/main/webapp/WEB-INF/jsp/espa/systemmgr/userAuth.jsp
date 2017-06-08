<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../inc/header.jsp"%>
<%@ include file="../../inc/aside.jsp"%>

<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i> 권한관리 <small>사용자 권한을 관리합니다.</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 시스템관리</a></li>
			<li class="active">권한관리</li>
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
						<div id="horizontal" style="height:715px">
							<div id="left-pane">
								<div id="tabstrip">
									<ul>
										<li class='k-state-active'>그룹</li>
										<li>사용자</li>
									</ul>
									<div>
										<div id="usergroup-grid"></div>
									</div>
									<div>
										<div id="user-grid"></div>
									</div>
								</div>
							</div>
							<div id="vertical">
								<div id="right-pane">
									<div id="auth-grid"></div>
								</div>
							</div>
	                	</div>
                	</div>
               	</div>
			</div>
		</div>
	</section>
</div>
<script>
	var G_Admin = "${userStore.username}";  
	var G_UserNm = "${userStore.fullname}";
	var G_USER_NO = 0;
	var G_USER_TYPE = 0;
	var G_TYPE = "";
	var temp;
	
	$(document).ready(function () {
		/*************************/
		/*       splitter        */
		/*************************/
		$("#horizontal").kendoSplitter({
			orientation: "horizontal",
			panes: [
				{ collapsible: true, resizable: true, scrollable: false, min: "150px",	size: "20%"	}, 
				{ collapsible: false, resizable: true, scrollable: false, min: "150px" }      
			]
		});
		
		$("#vertical").kendoSplitter({
			orientation: "vertical",
			panes: [
				{ collapsible: false, resizable: false, scrollable: false } 
			]
		});
		
		$("#tabstrip").kendoTabStrip({
			height: 715,
            animation:  {
                open: {
                    effects: "fadeIn"
                }
            }
        });
	
	    var crudServiceBaseUrl = "/sm/userauth";
	    var usergroupDs = new kendo.data.DataSource({
			transport: {
				read : { 
					url: crudServiceBaseUrl + "/readgroup.do",
					dataType: "jsonp", 
					complete: function(e){ 
				    	console.log("usergroupDs /readgroup.do");
				    }
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					if (type == "read"){
	                   	var result = {
		                   		CATGR: '100017' // 100017 = ?
		                };
						return { params: kendo.stringify(result) }; 
					}
					if (type !== "read" && data.models) { return { models: kendo.stringify(data.models) }; }
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
					fields: { //data type of the field {Number|String|Boolean|Date} default is String
						cd		: { type: "string" },
						cd_nm	: { type: "string" },
						cd_id	: { type: "string" }
					}  
				}
			},
	        error : function(e) {
		    	console.log('usergroupDs error: ' + e.errors);
	        }
		});//datasource grid end...
		
	    var userDs = new kendo.data.DataSource({
			transport: {
				read	: { 
					url: crudServiceBaseUrl + "/readuser.do",
					dataType: "jsonp", 
					complete: function(e){ 
				    	console.log("userDs /readuser.do...................");
				    }
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					if (type == "read"){
	                   	var result = {
						};
						return { params: kendo.stringify(result) }; 
					}
					if (type !== "read" && data.models) { return { models: kendo.stringify(data.models) }; }
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
					id: "user_no",
					fields: { //data type of the field {Number|String|Boolean|Date} default is String
						user_nm:		{ type: "string" },
						user_no:		{ type: "string" },
						birthday: 		{ type: "string" }
					}  
				}
			},
	        error : function(e) {
		    	console.log('userDs error: ' + e.errors);
	        }
		});//datasource grid end...
		
		$("#usergroup-grid").kendoGrid({
			dataSource: usergroupDs,
			pageable: false,
			height: 660,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			mobile: true,
			toolbar: [ ],
			columns: [
				{ field: "cd", title: "시퀀스", width: 80, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "cd_nm", title: "그룹명", attributes: {style: "text-align: center;"} },
				{ field: "cd_id", title: "그룹코드", width: 100, attributes: {style: "text-align: center;"}, hidden: true }
			],
			editable: false,
			noRecords: {
				template: "검색된 결과가 없습니다."
            },
            dataBound: function(e) {
				console.log("parentgrid dataBound..............");
				
				var grid = this;
			    $(grid.tbody).on("click", "td", function (e) {
			        var row = $(this).closest("tr");
			        var rowIdx = $("tr", grid.tbody).index(row);
			        var colIdx = $("td", row).index(this);
			        var data = grid.dataItem(row);
			        
			        if(G_TYPE == '') {
				        $("#auth-grid").data("kendoGrid").setDataSource(authDs);
			        }
			        G_TYPE = "USER_TYPE";
			        if(data.cd_id == null || data.cd_id == '') {
			        	G_USER_TYPE = 0;
			        } else {
				        G_USER_TYPE = data.cd_id;
				        $("#auth-grid").data("kendoGrid").dataSource.read();
			        }			
			    });
			}
		});
		
		$("#user-grid").kendoGrid({
			dataSource: userDs,
			pageable: false,
			height: 660,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			mobile: true,
			toolbar: [ ],
			columns: [
				{ field: "user_no", title: "신청자번호", width: 80, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "user_nm", title: "신청자", width: 80, attributes: {style: "text-align: center;"} },
				{ field: "birthday", title: "생년월일", width: 100, attributes: {style: "text-align: center;"},
					template: "#= (birthday == '') ? '' : kendo.toString(kendo.parseDate(birthday, 'yyyyMMdd'), 'yyyy-MM-dd') #" 
				}
			],
			editable: false,
			noRecords: {
				template: "검색된 결과가 없습니다."
            },
            dataBound: function(e) {
				console.log("parentgrid dataBound..............");
				
				var grid = this;
			    $(grid.tbody).on("click", "td", function (e) {
			        var row = $(this).closest("tr");
			        var rowIdx = $("tr", grid.tbody).index(row);
			        var colIdx = $("td", row).index(this);
			        var data = grid.dataItem(row);
			        
			        if(G_TYPE == '') {
				        $("#auth-grid").data("kendoGrid").setDataSource(authDs);
			        }
			        G_TYPE = "USER_NO";
			        if(data.USER_SEQ == null || data.USER_SEQ == '') {
			        	G_USER_NO = 0;
			        } else {
				        G_USER_NO = data.user_seq;
				        $("#auth-grid").data("kendoGrid").setDataSource(authDs);
				        $("#auth-grid").data("kendoGrid").dataSource.read();
			        }			
			    });
			}
		});
		
		var authDs = new kendo.data.DataSource({
			transport: {
				read	: { 
					url: crudServiceBaseUrl + "/readauth.do", 
					dataType: "jsonp", 
					complete: function(e){ 
				    	console.log("authDs /readauth.do");
				    }
				},
				update	: { 
					url: crudServiceBaseUrl + "/updateInsert.do", 
					dataType: "jsonp" 
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					if (type == "read"){
	                   	var result = {
	                        TYPE: G_TYPE,
	                        USER_NO: G_USER_NO,
	                        USER_TYPE: G_USER_TYPE
						};
						return { params: kendo.stringify(result) }; 
					}
					if (type == "update"){
	                   	var result = {
	                        TYPE: G_TYPE,
	                        USER_NO: G_USER_NO,
	                        USER_TYPE: G_USER_TYPE
						};
						return { params: kendo.stringify(result), models: kendo.stringify(data.models) }; 
					}
					if ((type != "read" || type != "update") && data.models) { return { models: kendo.stringify(data.models) }; }
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
					id: "menu_sq",
					fields: { 
						menu_sq		: { type: "string", editable: false },
						main_nm		: { type: "string", editable: false },
						menu_nm		: { type: "string", editable: false },
						menu_id		: { type: "string", editable: false },
						use_yn	 	: { type: "boolean", editable: false },
						area_gb		: { type: "string", editable: false },
						auth_sq		: { type: "string" },
						user_no		: { type: "string" },
						user_type	: { type: "string" },
						auth_c		: { type: "boolean" },
						auth_r		: { type: "boolean" },
						auth_u		: { type: "boolean" },
						auth_d		: { type: "boolean" }
					}  
				}
			},
	        error : function(e) {
		    	console.log('authDs error: ' + e.errors);
	        },
	        change : function(e) {
	        	console.log("authDs change");
	        },  	
	        sync: function(e) {
	        	temp =e;
				console.log("authDs sync complete");
				alert("정상적으로 처리되었습니다.");  
			},  
			batch: true               //     true: 쿼리를 한줄로,  false : row 단위로
		});//datasource grid end...
		
		
		$("#auth-grid").kendoGrid({
			pageable: false,
			height: 715,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			mobile: true,
			toolbar: [ 
			    { name: "save", text: "저장" },
			    { name: "cancel", text: "취소" }
			],
			columns: [
				{ field: "menu_sq", title: "메뉴seq", width: 50, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "main_nm", title: "상위메뉴", width: 100, attributes: {style: "text-align: left;"} },
				{ field: "menu_nm", title: "하위메뉴", width: 100, attributes: {style: "text-align: left;"} },
				{ field: "user_type", title: "사용자구분", width: 100, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "user_no", title: "사용자번호", width: 100, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "auth_r", title: "조회", width: 50, attributes: {style: "text-align: center;" },
					template: '<input type="checkbox" #= (auth_r) ? "checked=checked" : "" # disabled="disabled" ></input>' },
				{ field: "auth_c", title: "생성", width: 50, attributes: {style: "text-align: center;" },
					template: '<input type="checkbox" #= (auth_c) ? "checked=checked" : "" # disabled="disabled" ></input>' },
				{ field: "auth_u", title: "수정", width: 50, attributes: {style: "text-align: center;" },
					template: '<input type="checkbox" #= (auth_u) ? "checked=checked" : "" # disabled="disabled" ></input>' },
				{ field: "auth_d", title: "삭제", width: 50, attributes: {style: "text-align: center;" },
					template: '<input type="checkbox" #= (auth_d) ? "checked=checked" : "" # disabled="disabled" ></input>' },
			],
			editable: true,
			edit: function(e) {//Fired when the user edits or creates a data item
				/*if(e.model.isNew()) {
					console.log("authGrid new");
					var parentGrid = $("#parent-grid").data("kendoGrid");
					var row = parentGrid.select();
					var data = parentGrid.dataItem(row);
					if( data == null || data == ""){
						this.cancelRow();
						alert("먼저 상위 메뉴를 선택해 주세요.");
						return false;
					}
	 				e.model.set("MENU_ORDER", Number(this.dataSource.at(this.dataSource.total()-1).get("MENU_ORDER")) + 1);
	 				e.model.set("PARENT_SQ", G_MENU_SQ);
				} else {
					console.log("authGrid edit");
				}
				//this.select("tr:eq(0)");
				childDs.at(0).set("PARENT_SQ", G_MENU_SQ);*/
			},
            save: function(e) {//저장전 이벤트
				console.log("authGrid save");
            },
            saveChanges: function(e) {//저장버턴 클릭시 이벤트
            	console.log("authGrid saveChanges");
			},
			sync: function(e) {
				console.log("authGrid sync");
				childDs.read();
			},
			dataBound: function(e) {
				invokeUserAuth($("#auth-grid"), "kendoGrid");
			},
			noRecords: {
				template: "검색된 결과가 없습니다."
            },
		});
		
	});	
</script>	

<%@ include file="../../inc/footer.jsp"%>