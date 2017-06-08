<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#faq').parent().parent().addClass('active');
	$('#faq').addClass('active');
});	
</script>

      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>FAQ
            <small>자주 묻는 질문과 답변.</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 운영관리</a></li>
            <li class="active">FAQ</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
        	<div class="row">
          	<!-- 내용 -->
          	<div class="col-xs-12">
            
              <!-- table 하나 -->
              <div class="box">
                <!-- <div class="box-header">
                  <h3 class="box-title"><i class="fa fa-tag"></i>FAQ</h3>
                </div> -->
                <div class="box-body">
<!--                   <table id="example1" class="table table-bordered table-striped">
                  </table> -->
                  
                  
                  
                  
                  
				<!-- jQuery Plug-Ins Widget Initialization -->
				<p></p>
			
				<script>
				var G_AreaCdVal;//조회조건 : 관리기관코드
				var G_AreaIdVal = "${userStore.areaId}";//조회조건 : 관리기관
				var G_UserNmVal;//조회조건 : 사용자명
				
				/* DropDownList Template */
				var codeModles;
				$.ajax({
					type: "post",
					url: "<c:url value='/dgms/getCodeListByCdIDModel.do'/>",
					async: false, //동기 방식
					success: function(data,status){
						codeModles = data.rtnList;
					},
					fail: function(){},
					complete: function(){}
				});

				function fnCodeNameByCdID(code){
					var rtnVal = "";
					for (var i = 0; i < codeModles.length; i++) {
			            if (codeModles[i].CD_ID == code) {
			            	rtnVal = codeModles[i].CD_NM;
			            }
			        }
					return rtnVal;
				}
				
				function fnCodeNameByCd(code){
					var rtnVal = "";
					for (var i = 0; i < codeModles.length; i++) {
			            if (codeModles[i].CD == code) {
			            	rtnVal = codeModles[i].CD_NM;
			            }
			        }
					return rtnVal;
				}
				
/* 				///js/comm/dgms.js로 이동함
				function fnStrToDateFormat(str){
					if(typeof str != "undefined" && str != null && str.length >=6 ){
						var year = str.substr(0,2);
						var month = str.substr(2,2);
						var day = str.substr(4,2);
						return year+"/"+month+"/"+day;
					}else{
						return str;
					}

				} */
				
				
				
				
				
				
				

				
				
				
				
				
				
				$(function() {
					
					
					
				});
				
				</script>
				
				
                  
                  
				<div id="gridDetail"></div>


				<script>
				
                $(document).ready(function () {
                	
                	
					
					
					/*************************/
                	/* dataSource gridDetail */
                	/*************************/
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>",
                    /*** dataSource ***/
					dataSourceDetail = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectFaqInfoJsonp.do",
		            			dataType: "jsonp"
							},
							update: {
								url: crudServiceBaseUrl + "/updateFaqInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteFaqInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertFaqInfoJsonp.do",
								dataType: "jsonp"
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
									};
									return { params: kendo.stringify(result) }; 
								}
                               
								if (type !== "read" && data.models) {	
									return { models: kendo.stringify(data.models) };
								}
							}
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
								id:"FAQ_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									FAQ_SEQ: { 
										type: "string" //data type of the field {Number|String|Boolean|Date} default is String
										//defaultValue: 42,
										//validation: { required: true, min: 1 }
									},
									QUESTION: {
									},
								    ANSWER: {
									},
									RNUM: {
										type: "string",
										editable: false,
									},
									
									CRE_USR : { 
										type: "string", 
										editable: false,
										defaultValue: "${userStore.username}"
									},
									MOD_USR : { 
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
							$("#searchBtn").trigger("click");
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
					});//datasource gridDetail end...
					
					
					
					/*************************/
					/***    gridDetail     ***/
					/*************************/
					$("#gridDetail").kendoGrid({
						autoBind: true,
						dataSource: dataSourceDetail,
						navigatable: true,
						pageable: true,
						height: 500,
						toolbar: [
						          	{ template: '<button id="searchBtn" type="button">조회</button>' },
						          	{ name: "create", text: "추가" },
								    { name: "save", text: "저장" },
								    { name: "cancel", text: "취소" },
								    { name: "excel", text: "엑셀" }
								    /* { name: "pdf", text: "PDF" }, */
								],
						columns: [
							{
								field: "RNUM",
								title: "NO",
								attributes: {style: "text-align: center;"},
								width: 50
							},
							{
								field: "QUESTION",
								title: "질문",
								attributes: {style: "text-align: left;"},
								width: 200
							},
							{
								field: "ANSWER",
								title: "답변",
								attributes: {style: "text-align: left;"},
								width: 300
							},
							{
								field: "FAQ_SEQ",
								title: "FAQ_SEQ",
								attributes: {style: "text-align: center;"},
								hidden: true,
								//attributes
								width: 100
							},
							{
								command: { name: "destroy", text: "삭제" },
								width: 100
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
			                fileName: "FAQ.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "FAQ.pdf",
							paperSize: "A4",
							landscape: true,
							scale: 0.75
						},      
			            
			            noRecords: {
			                //template: "No data. Current page is: #=this.dataSource.page()#"
							template: "No data"
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
			 				if (e.model.isNew() && ( dataSourceDetail.at(0).FAQ_SEQ == null || dataSourceDetail.at(0).FAQ_SEQ == "") ) {
 								var url = "<c:url value='/dgms/getSequence.do'/>";
								var parameters = {'SEQ_NM': "SEQ_FAQ"};
								$.post(url, parameters, function(data) {
									dataSourceDetail.at(0).set("FAQ_SEQ", data.Sequence);
								}); 
								
								var grid = this;
								grid.select("tr:eq(0)");

							}
			 				else
			 				{
								/* Disable the editor of the "id" column when editing data items */
								$('input[name=FAQ_SEQ]').parent().html(e.model.FAQ_SEQ);

			 				}
							
							
			
						}
			            
					});//gridDetail end...
					
					
/* 					$("#gridMaster").on("click", "table", function(e) {
					    alert("clicked", e.ctrlKey, e.altKey, e.shiftKey);
					});
					 */
					
					/* 조회 */
					$("#searchBtn").kendoButton({
						icon: "search",
						click: function(e) {
							var gridDetail = $("#gridDetail").data("kendoGrid");
							gridDetail.dataSource.read();
							
							//alert("G_AreaCdVal:"+G_AreaCdVal);
						}
					});
					 
					
				});//document ready javascript end...
                

				
				

				
            	</script>


                  
                  
					        
					      </div>
					    </div><!-- box -->
					    
					    
					    
					    
					    
					  </div><!-- col-xs-12 -->
					</div><!-- row -->
        </section>    
        
      </div>
        
        
<%@ include file="../inc/footer.jsp" %>