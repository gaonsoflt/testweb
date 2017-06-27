<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
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
  						<div id="horizontal" style="height:715px">
							<div id="left-pane">
								<div id="gridMaster"></div>
							</div>
							<div id="vertical">
								<div id="right-pane">
									<div id="gridDetail"></div>	
								</div>
							</div>
	                	</div>
					</div>
				</div><!-- box -->
			</div><!-- col-xs-12 -->
		</div><!-- row -->
	</section>    
</div>
<script>
                $(document).ready(function () {
				var G_CATGR;//마스터에서 선택한 분류코드 값
				
                	
                	/*************************/
                	/*       splitter        */
                	/*************************/
                	$("#horizontal").kendoSplitter({
						orientation: "horizontal",
						panes: [
							{ collapsible: true, resizable: true, scrollable: false, min: "150px",	size: "25%"	}, 
							{ collapsible: false, resizable: true, scrollable: false, min: "150px" }      
						]
					});
					$("#vertical").kendoSplitter({
						orientation: "vertical",
						panes: [
							{ collapsible: false, resizable: false }, 
							{ collapsible: false, resizable: false }
						]
					});
                	
                	/*************************/
                	/* dataSource gridMaster */
                	/*************************/
                    var crudServiceBaseUrl = "${contextPath}/sm/code",
                    /*** dataSource ***/
					dataSourceMaster = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/readMasters.do",
		            			dataType: "jsonp",
		            			complete: function(e){ 
		            				console.log("readMasters...................");
		            			}
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
	                                       SKIP: data.skip,
	                                       PAGE: data.page,
	                                       TAKE: data.take
	                                };
									return { params: kendo.stringify(result) }; 
								}
                               
								if (type !== "read" && data.models) {	
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
							model:{//가져온 값이 있음...
								id:"cd",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									cd: { type: "string", editable: false	},//data type of the field {Number|String|Boolean|Date} default is String
									catgr: { type: "string", editable: false },
									cd_nm: { type: "string", editable: false },
							        use_yn: { type: "boolean", editable: false }
								}
							}
						},
                        error : function(e) {
                        	console.log(e.errors);
                        	alert(e.errors);
                        },
                        change : function(e) {
                        	console.log("change...........");
                        },  	
                        sync: function(e) {
							console.log("sync complete");
							//console.log("model.dirty:"+this.schema.model.dirty);//수정되었는지 여부
							alert("정상적으로 처리되었습니다.");  
						},  
						serverPaging: true,        // 서버 사이드 페이징 활성화
						serverFiltering: false,
						serverSorting: false,      // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
						//autoSync: true,          //     자동 저장
						batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
						page: 1,                   //     반환할 페이지
						pageSize: 15,              //     반환할 항목 수
						skip: 0,                   //     건너뛸 항목 수
						take: 15                   //     반환할 항목 수 (pageSize와 같음)
					});//datasource grid end...

					/*************************/
                	/* dataSource gridDetail */
                	/*************************/
                    /*** dataSource ***/
					dataSourceDetail = new kendo.data.DataSource({
						transport: {
							read:  { url: crudServiceBaseUrl + "/readDetails.do", dataType: "jsonp",
		            			complete: function(e){ 
		            				console.log("readDetails...................");
		            			}
							},
							update: { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
							destroy: { url: crudServiceBaseUrl + "/delete.do", dataType: "jsonp" },
							create: { url: crudServiceBaseUrl + "/create.do", dataType: "jsonp" },
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										CATGR: G_CATGR //선택한 분류코드값
									};
									return { params: kendo.stringify(result) }; 
								}
                               
								if (type !== "read" && data.models) {	
									return { models: kendo.stringify(data.models) };
								}
							}
						},//transport end...
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
							model:{//가져온 값이 있음...
								id:"cd",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									cd: { type: "string" }, //data type of the field {Number|String|Boolean|Date} default is String 
									catgr: { type: "string" },
									cd_nm: { type: "string", validation: { required: true } },
									sort_no: { type: "number", defaultValue: 1,	validation: { min: 1 } },
									use_yn: { type: "boolean", defaultValue: true },
									cre_usr : { type: "string", editable: false, defaultValue: "${userStore.username}" },
									mod_usr : { type: "string", editable: false, defaultValue: "${userStore.username}" }
								}   
							}
						},
                        error : function(e) {
                        	console.log(e.errors);
                        	alert(e.errors);
                        },
                        change : function(e) {
                        },  	
                        sync: function(e) {
							console.log("sync complete");
							//console.log("model.dirty:"+this.schema.model.dirty);//수정되었는지 여부
							alert("정상적으로 처리되었습니다.");
							console.log("save & refresh...............");
                			$("#gridMaster").data("kendoGrid").dataSource.read(); 
						},  
						serverPaging: true,        // 서버 사이드 페이징 활성화
						serverFiltering: false,
						serverSorting: false,      // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
						//autoSync: true,          //     자동 저장
						batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
						page: 1,                   //     반환할 페이지
						pageSize: 15,              //     반환할 항목 수
						skip: 0,                   //     건너뛸 항목 수
						take: 15                   //     반환할 항목 수 (pageSize와 같음)
					});//datasource gridDetail end...
					
					
					
					/*************************/
					/***    gridMaster     ***/
					/*************************/
					$("#gridMaster").kendoGrid({
						autoBind: true,
						dataSource: dataSourceMaster,
						navigatable: true,
						pageable: true,
						height: 715,
						toolbar: [
							{ name: "excel", text: "엑셀" }
						],
						columns: [
							{ field: "catgr", title: "분류CD", hidden: true, width: 60, attributes: {style: "text-align: center;"} },
							{ field: "cd",title: "분류코드", width: 100, attributes: {style: "text-align: center;"} },
							{ field: "cd_nm", title: "분류코드명",	width: 200,	attributes: {style: "text-align: center;"} },
							{ field: "use_yn", title: "사용여부", attributes: {style: "text-align: center;"} }
						],
						sortable: true,
						selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
						scrollable: true,
						mobile: true,
						excel: {
			                allPages: true,
			                fileName: "분류코드.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "분류코드.pdf",
							paperSize: "A4",
							landscape: true,
							scale: 0.75
						},      
			            noRecords: {
			               template: "No data."
			            },
			            pageable : false,
						resizable: true,  //컬럼 크기 조절
						reorderable: true, //컬럼 위치 이동
						save: function(e) {//저장전 이벤트
							console.log("save...............");
						},
						saveChanges: function(e) {//저장버턴 클릭시 이벤트
/* 							if (!confirm("변경된 데이타를 저장하시겠습니까?")) {  
								e.preventDefault();
							}   */  	
						},
						edit: function(e) {//Fired when the user edits or creates a data item
						},
						dataBound: function(e) {
							console.log("dataBound..............");
							var grid = this;
						    $(grid.tbody).on("click", "td", function (e) {
						        var row = $(this).closest("tr");
						        var rowIdx = $("tr", grid.tbody).index(row);
						        var colIdx = $("td", row).index(this);
						        var data = grid.dataItem(row);
								console.log(data);
						        if(data.cd == null || data.cd == '') {
						        	G_CATGR = 0;
						        } else {
							        G_CATGR = data.cd;
						        }
						        // 하위 메뉴 로드
						        $("#gridDetail").data("kendoGrid").dataSource.read();
						    });
							invokeUserAuth($("#gridDetail"), "kendoGrid");
						}
					});//grid end...
					
					/*************************/
					/***    gridDetail     ***/
					/*************************/
					$("#gridDetail").kendoGrid({
						autoBind: false,
						dataSource: dataSourceDetail,
						navigatable: true,
						pageable: true,
						height: 650,
						toolbar: [
							{ name: "create", text: "추가" },
							{ name: "save", text: "저장" },
							{ name: "cancel", text: "취소" },
							{ name: "excel", text: "엑셀" }
						],
						columns: [
							{ field: "cd_nm", title: "코드명", width: 150, attributes: {style: "text-align: center;"} },
							{ field: "cd_id", title: "코드ID", width: 150, attributes: {style: "text-align: center;"} },
							{ field: "cd", title: "코드", width: 150, attributes: {style: "text-align: center;"} },
							{ field: "remark", title: "비고", width: 300 },
							{ field: "sort_no", title: "정렬순서", format: "{0:n0}", width: 100, attributes: {style: "text-align: center;"} },
							{ field: "use_yn", title: "사용여부", width: 100, attributes: {style: "text-align: center;"} },
							{ field: "catgr", title: "분류코드", width: 100, hidden: true, attributes: {style: "text-align: center;"} },
							{
								command: [
									{ name: "destroy", text: "삭제" }
								],
								width: 100
							}
						],
 						editable: {
 							mode:  "incell",
							confirmation: "선택한 행을 삭제하시겠습니까?(저장 버턴 클릭시 완전히 삭제됩니다.)"
						},
						sortable: true,
						selectable: true, //selectable: "multiple cell","multiple row","cell","row",
						scrollable: true,
						mobile: true,
						excel: {
			                allPages: true,
			                fileName: "공통코드.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "공통코드.pdf",
							paperSize: "A4",
							landscape: true,
							scale: 0.75
						},      
						noRecords: {
							template: "검색된 결과가 없습니다."
			            },
			            pageable: {	
			          		//refresh: true, //하단의 리프레쉬 아이콘
			          		pageSizes: true,
			          		//buttonCount: 1  //paging 갯수
			          		//input: true //페이지 직접입력
			          		//info: false //하단의 페이지 정보
			          		messages: {
				           	    display: "전체 {2}개 항목 중 {0}~{1}번째 항목 출력",
				           	    empty: "출력할 항목이 없습니다",
				           	    itemsPerPage: "한 페이지에 출력할 항목 수"
			          	    }
			            },
						resizable: true,  //컬럼 크기 조절
						reorderable: true, //컬럼 위치 이동
						save: function(e) {//저장전 이벤트
						},
						saveChanges: function(e) {//저장버턴 클릭시 이벤트
						},
						edit: function(e) {//Fired when the user edits or creates a data item
			 				if (e.model.isNew()) {
						    	$("input[name=cd]").attr({"readonly":true});
						    	$("input[name=cd]").css({"background":"#ccc", "text-align":"center"});
						    	e.model.set("catgr", G_CATGR);
							}
			 				else
			 				{
								$('input[name=cd]').parent().html(e.model.cd);
								$('input[name=catgr]').parent().html(e.model.catgr);
			 				}
			 				dataSourceDetail.at(0).set("catgr", G_CATGR);
						},
						dataBound: function(e) {
							invokeUserAuth($("#gridDetail"), "kendoGrid");
						}
					});//gridDetail end...
				});//document ready javascript end...
            	</script>
			      
<%@ include file="../inc/footer.jsp" %>