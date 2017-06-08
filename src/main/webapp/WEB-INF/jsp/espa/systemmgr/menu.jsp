<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../inc/header.jsp"%>
<%@ include file="../../inc/aside.jsp"%>

<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i> 메뉴관리 <small>사이트 메뉴를 관리합니다.</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 시스템관리</a></li>
			<li class="active">메뉴관리</li>
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
								<div id="parent-grid"></div>
							</div>
							<div id="vertical">
								<div id="right-pane">
									<div id="child-grid"></div>
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
	var G_MENU_SQ = 0;
	
	var temp;
	$(document).ready(function () {
		/*************************/
		/*       splitter        */
		/*************************/
		$("#horizontal").kendoSplitter({
			orientation: "horizontal",
			panes: [
				{ collapsible: true, resizable: true, min: "150px",	size: "30%"	}, 
				{ collapsible: false, resizable: true, min: "150px" }      
			]
		});
		$("#vertical").kendoSplitter({
			orientation: "vertical",
			panes: [
				{ collapsible: false, resizable: false }, 
				{ collapsible: false, resizable: false }
			]
		});
	
	    var crudServiceBaseUrl = "/sm/menu";
	    var parentDs = new kendo.data.DataSource({
			transport: {
				read	: { url: crudServiceBaseUrl + "/read.do", dataType: "jsonp", 
					complete: function(e){ 
				    	console.log("parentds /read.do...................");
				    }
				},
				update	: { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
				destroy	: {	url: crudServiceBaseUrl + "/delete.do",	dataType: "jsonp" },
				create	: {	url: crudServiceBaseUrl + "/create.do",	dataType: "jsonp" },
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					if (type == "read"){
	                   	var result = {
	                        TYPE: "PARENT"
						};
						return { params: kendo.stringify(result) }; 
					}
	               
					if (type !== "read" && data.models) { return { models: kendo.stringify(data.models) }; }
				}
			},
			schema: {
				data: function(response) {
					temp = response;
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
						menu_sq		: { type: "string" },
						menu_nm		: { type: "string" },
						menu_id		: { type: "string" },
						menu_url	: { type: "string" },
						menu_desc	: { type: "string" },
						menu_content: { type: "string" },
						menu_order	: { type: "string" },
						use_yn	 	: { type: "boolean", defaultValue: true },
						area_gb		: { type: "string" },
						parent_sq	: { type: "string" }
					}  
				}
			},
	        error : function(e) {
		    	console.log('parentds error: ' + e.errors);
	        },
	        change : function(e) {
	        	console.log("parentds change...........");
	        },  	
	        sync: function(e) {
				console.log("parentds sync complete");
				alert("정상적으로 처리되었습니다.");  
			},  
			batch: true               //     true: 쿼리를 한줄로,  false : row 단위로
		});//datasource grid end...
		
		
		$("#parent-grid").kendoGrid({
			dataSource: parentDs,
			pageable: false,
			height: 715,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			toolbar: [ 
			    { name: "create", text: "추가" }
			],
			messages: {
				commands: {
					canceledit: "취소",
					update: "저장"
				}
			},
			columns: [
				{ field: "menu_sq", title: "아이디", width: 50, attributes: {style: "text-align: center;"} },
				{ field: "menu_order", title: "순서", width: 50, attributes: {style: "text-align: center;"} },
				{ field: "use_yn", title: "사용", width: 50, attributes: {style: "text-align: center;" },
					template: '<input type="checkbox" #= (use_yn) ? "checked=checked" : "" # disabled="disabled" ></input>' },
				{ field: "menu_nm", title: "이름", width: 150, attributes: {style: "text-align: left;"} },
				{ field: "menu_id", title: "아이디", width: 120, attributes: {style: "text-align: left;"}, hidden: true },
				{ field: "menu_url", title: "URL", width: 180, attributes: {style: "text-align: left;"}, hidden: true },
				{ title: "&nbsp;", width: 80, command: [ 
						{ name: "edit", template: "<div class='k-button'><span class='k-icon k-edit'></span></div>" },
						{ name: "destroy", template: "<div class='k-button'><span class='k-icon k-delete'></span></div>" }
					] 
				}
			],
			editable: {
				mode: "inline",
				confirmation: "삭제하시겠습니까?"
			},
			edit: function(e) {//Fired when the user edits or creates a data item
				console.log("parentgrid edit...");
				if(e.model.isNew()) {
					//e.container.kendoWindow("title", "추가");
	 				e.model.set("menu_order", Number(this.dataSource.at(this.dataSource.total()-1).get("menu_order")) + 1);
				} else {
					//e.container.kendoWindow("title", "수정");
				}
 				$('label[for=menu_sq]').css("display", "none");
 				$('input[name=menu_sq]').css("display", "none");
			},
            save: function(e) {//저장전 이벤트
				console.log("parentgrid save...");
            },
            saveChanges: function(e) {//저장버턴 클릭시 이벤트
            	console.log("parentgrid saveChanges...");
			},
			sync: function(e) {
				console.log("parentgrid sync");
				alert("정상적으로 처리되었습니다.");
				parentDs.read();
			},
			mobile: true,
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
			        
			        if(data.menu_sq == null || data.menu_sq == '') {
			        	G_MENU_SQ = 0;
			        } else {
				        G_MENU_SQ = data.menu_sq;
			        }			
			        // 하위 메뉴 로드
			        $("#child-grid").data("kendoGrid").dataSource.read();
			    });
				invokeUserAuth($("#parent-grid"), "kendoGrid");
			}
		});
		
		var childDs = new kendo.data.DataSource({
			transport: {
				read	: { url: crudServiceBaseUrl + "/read.do", dataType: "jsonp", 
					complete: function(e){ 
				    	console.log("childds /read.do");
				    }
				},
				update	: { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
				destroy	: {	url: crudServiceBaseUrl + "/delete.do",	dataType: "jsonp" },
				create	: {	url: crudServiceBaseUrl + "/create.do",	dataType: "jsonp" },
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					if (type == "read"){
	                   	var result = {
	                        TYPE: "CHILD",
	                        MENU_SQ: G_MENU_SQ
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
					id: "menu_sq",
					fields: { 
						menu_sq		: { type: "string" },
						menu_nm		: { type: "string" },
						menu_id		: { type: "string" },
						menu_url	: { type: "string" },
						menu_desc	: { type: "string" },
						menu_content: { type: "string" },
						menu_order	: { type: "string" },
						use_yn	 	: { type: "boolean", defaultValue: true },
						parent_sq 	: { type: "string" },
						area_gb		: { type: "string" }
					}  
				}
			},
	        error : function(e) {
		    	console.log('childds error: ' + e.errors);
	        },
	        change : function(e) {
	        	console.log("childds change");
	        },  	
	        sync: function(e) {
				console.log("childds sync complete");
				alert("정상적으로 처리되었습니다.");  
			},  
			batch: true               //     true: 쿼리를 한줄로,  false : row 단위로
		});//datasource grid end...
		
		
		$("#child-grid").kendoGrid({
			dataSource: childDs,
			pageable: false,
			height: 715,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			toolbar: [ 
			    { name: "create", text: "추가" }
			],
			messages: {
				commands: {
					canceledit: "취소",
					update: "저장"
				}
			},
			columns: [
				{ field: "parent_sq", title: "상위아이디", width: 50, attributes: {style: "text-align: center;"} },
				{ field: "menu_sq", title: "seq", hidden: true },
				{ field: "menu_order", title: "순서", width: 50, attributes: {style: "text-align: center;"} },
				{ field: "use_yn", title: "사용", width: 50, attributes: {style: "text-align: center;" },
					template: '<input type="checkbox" #= (use_yn) ? "checked=checked" : "" # disabled="disabled" ></input>' },
				{ field: "menu_nm", title: "이름", width: 150, attributes: {style: "text-align: left;"} },
				{ field: "menu_id", title: "아이디", width: 120, attributes: {style: "text-align: left;"} },
				{ field: "menu_url", title: "URL", width: 180, attributes: {style: "text-align: left;"} },
				{ title: "&nbsp;", width: 80, attributes: {style: "text-align: left;"}, 
					command: [
						{ name: "edit", template: "<div class='k-button'><span class='k-icon k-edit'></span></div>" },
						{ name: "destroy", template: "<div class='k-button'><span class='k-icon k-delete'></span></div>" }
					]
				}
			],
			editable: {
				mode: "inline",
				confirmation: "삭제하시겠습니까?"
			},
			edit: function(e) {//Fired when the user edits or creates a data item
				if(e.model.isNew()) {
					console.log("childgrid new");
					var parentGrid = $("#parent-grid").data("kendoGrid");
					var row = parentGrid.select();
					var data = parentGrid.dataItem(row);
					if( data == null || data == ""){
						this.cancelRow();
						alert("먼저 상위 메뉴를 선택해 주세요.");
						return false;
					}
	 				e.model.set("menu_order", Number(this.dataSource.at(this.dataSource.total()-1).get("menu_order")) + 1);
	 				e.model.set("parent_sq", G_MENU_SQ);
				} else {
					console.log("childgrid edit");
				}
				//this.select("tr:eq(0)");
				childDs.at(0).set("parent_sq", G_MENU_SQ);
			},
            save: function(e) {//저장전 이벤트
				console.log("childgrid save");
            },
            saveChanges: function(e) {//저장버턴 클릭시 이벤트
            	console.log("childgrid saveChanges");
			},
			sync: function(e) {
				console.log("childgrid sync");
				alert("정상적으로 처리되었습니다.");
				childDs.read();
			},
			dataBound: function(e) {
				invokeUserAuth($("#child-grid"), "kendoGrid");
			},
			mobile: true,
			noRecords: {
				template: "검색된 결과가 없습니다."
            },
		});
		
	});	
</script>	

<%@ include file="../../inc/footer.jsp"%>