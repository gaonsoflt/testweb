<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#mngCode').parent().parent().addClass('active');
	$('#mngCode').addClass('active');
});	
</script>

      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            기준관리
            <small>기준코드를 관리합니다.</small>
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
                  <h3 class="box-title"><i class="fa fa-tag"></i>기준관리</h3>
                </div><!-- /.box-header -->
                <div class="box-body">
<!--                   <table id="example1" class="table table-bordered table-striped">
                  </table> -->
                  
                  
                  
                  
                  
				<!-- jQuery Plug-Ins Widget Initialization -->
				<p>

				<div style="font-size: 15px;">
				코드분류명: <input id="in_catgr" />&nbsp;&nbsp;&nbsp;
				코드: <input id="in_cd" />&nbsp;&nbsp;&nbsp;
				코드명: <input id="in_cdnm" />&nbsp;&nbsp;&nbsp;
				<button id="searchBtn" type="button">조회</button>
				</div>

										
				<script>
				$(function() {
					/* 코드분류명 */
					$("#in_catgr").kendoAutoComplete({ 
						dataSource: {
							transport: {
							read: {
								dataType: "json",
								url: "<c:url value='/dgms/selectMngCodeInfoCombo.do'/>"
							}
							},
							schema: {
								data: "rtnList"
							}
						}
					});
					
					/* 코드 */
					$("#in_cd").kendoAutoComplete({ 
						dataSource: {
							transport: {
							read: {
								dataType: "json",
								url: "<c:url value='/dgms/selectMngCodeInfoCombo.do'/>"
							}
							},
							schema: {
								data: "rtnList"
							}
						}
					});
					
					/* 코드명 */
					$("#in_cdnm").kendoAutoComplete({ 
						dataSource: {
							transport: {
							read: {
								dataType: "json",
								url: "<c:url value='/dgms/selectMngCodeInfoCombo.do'/>"
							}
							},
							schema: {
								data: "rtnList"
							}
						}
					});
					
					/* 조회 */
					$("#searchBtn").kendoButton({
						icon: "search",
						click: function(e) {
							var grid = $("#grid").data("kendoGrid");
							grid.dataSource.read();
						}
					});
					
				});
				
				</script>
				
				</p>
                  
                  
                  
                  	
				<div id="grid"></div>
				<div id="gridDetail"></div>

				<script>

                $(document).ready(function () {
                	
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>",
                    /*** dataSource ***/
					dataSource = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectMngCodeInfoJsonp.do",
		            			dataType: "jsonp"
							},
							update: {
								url: crudServiceBaseUrl + "/updateMngCodeInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteMngCodeInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertMngCodeInfoJsonp.do",
								dataType: "jsonp"
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
							},
							batch: true
						},//transport end...
/* 						aggregate: [
							{ field: "MAJOR_SEQ", aggregate: "sum" },
							{ field: "MAJOR_SEQ", aggregate: "min" }
						], */
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
								id:"CD",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									CD: { 
										type: "Number", //data type of the field {Number|String|Boolean|Date} default is String
										editable: true,
										validation: { required: true } 
										//defaultValue: 42,
										//validation: { required: true, min: 1 }
									},
									CATGR: { 
										type: "string", 
										editable: true, 
										validation: { required: true } 
									},
									CD_NM: { 
										type: "string", 
										editable: true,
										validation: { required: true } 
									},
									INS_SEQ : { 
										type: "string", 
										editable: false,
										defaultValue: "${userStore.username}"
									},
									UPT_SEQ : { 
										type: "string", 
										editable: false,
										defaultValue: "${userStore.username}"
									}
								}   
							}
						},
                        error : function(e) {
                        	console.log(e.errors);
                        	alert(e.errors);
                        },
                        change : function(e) {
                        	//alert("change...........");
                        	/* var data = this.data();
                        	console.log(data.length);
                        	alert(data.length+"건 처리하였습니다."); */
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
						pageSize: 10,              //     반환할 항목 수
						skip: 0,                   //     건너뛸 항목 수
						take: 10                   //     반환할 항목 수 (pageSize와 같음)
					});//datasource end...

					/*** grid ***/
					$("#grid").kendoGrid({
						dataSource: dataSource,
						navigatable: true,
						pageable: true,
						height: 500,
						toolbar: [
								    { name: "create", text: "추가" },
								    { name: "save", text: "저장" },
								    { name: "cancel", text: "취소" },
								    { name: "excel", text: "엑셀" }
								    /* { name: "pdf", text: "PDF" }, */
								],
						columns: [
							{
								field: "CATGR",
								title: "코드분류",
								//hidden: true,
								//attributes
								width: 100
							},
							{
								field: "CD",
								title: "코드"
								//,footerTemplate: "합계: #: sum # 최소: #: min #",
							},
							{
								field: "CD_NM",
								title: "코드명",
								width: 200
							},
							{
								field: "CD_DESC",
								title: "코드상세"
							},   
							{
								field: "ORD_SEQ",
								title: "정렬순서"
							},
							{
								field: "USE_YN",
								title: "사용여부"
							},
							{
								command: { name: "destroy", text: "삭제" },
								width: 80
							}
						],
						editable: {
							confirmation: "선택한 행을 삭제하시겠습니까?(저장 버턴 클릭시 완전히 삭제됩니다.)"
						},
						sortable: true,
						selectable: true, //selectable: "multiple cell","multiple row","cell","row",
						scrollable: true,
						
						/* columnMenu: {
						    messages: {
						        sortAscending: "오름차순정렬",
						        sortDescending: "내림차순정렬",
						        filter: "필터",
						        columns: "항목설정"
						    }
						}, */
						mobile: true,
						
						//excel, pdf
						excel: {
			                allPages: true,
			                fileName: "기준관리.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "기준관리.pdf",
							paperSize: "A4",
							landscape: true,
							scale: 0.75
						},      
			            
			            noRecords: {
			               template: "No data. Current page is: #=this.dataSource.page()#"
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
							console.log("save...............");
/* 	           			             if (e.values.MAJOR_NM !== "") {
         			               // the user changed the MAJOR_NM field
         			               if (e.values.MAJOR_NM !== e.model.MAJOR_NM) {
         			            	   console.log("e.values.MAJOR_NM:"+e.values.MAJOR_NM);
         			            	   console.log("e.model.MAJOR_NM:"+e.model.MAJOR_NM);
         			            	console.log("e.model.id:"+e.model.id);
         			                 console.log("MAJOR_NM is modified");
         			               }
         			             } else {
         			                 e.preventDefault();
         			                 console.log("MAJOR_NM cannot be empty");
         			             } */
						},
						saveChanges: function(e) {//저장버턴 클릭시 이벤트
/* 							if (!confirm("변경된 데이타를 저장하시겠습니까?")) {  
								e.preventDefault();
							}   */  	
						},
						edit: function(e) {//Fired when the user edits or creates a data item
							/*** Key 채번 ***/
							if (e.model.isNew() && ( dataSource.at(0).CD == null || dataSource.at(0).CD == "") ) {
								var url = "<c:url value='/dgms/getSequence.do'/>";
								var parameters = {'SEQ_NM': "SEQ_CODE_MASTER"};
								$.post(url, parameters, function(data) {
									dataSource.at(0).set("CD", data.Sequence);
								});
							}
							/* Disable the editor of the "id" column when editing data items */
							//$(e.container).find('input[name="id"]').attr("readonly", true);
							$('input[name=CD]').parent().html(e.model.CD);
						      
						}
			            
					});
				});
                
                /* dataSource = new kendo.data.DataSource({
                dataSource: {
					transport: {
					read: {
						dataType: "json",
						url: "<c:url value='/dgms/selectMngCodeInfoCombo.do'/>"
					}
					},
					schema: {
						data: "rtnList"
					}
				} */
                
            	</script>


                  
                  
					        
					      </div>
					    </div><!-- box -->
					    
					    
					    
					    
					    
					  </div><!-- col-xs-12 -->
					</div><!-- row -->
        </section>    
        
      </div>
        
        
<%@ include file="../inc/footer.jsp" %>