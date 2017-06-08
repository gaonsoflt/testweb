<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../inc/header.jsp" %>
<%@ include file="../../inc/aside.jsp" %>
 

      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>접속이력관리
            <small>접속이력을  관리합니다.</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 시스템관리</a></li>
            <li class="active">접속이력관리</li>
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
                  <h3 class="box-title"><i class="fa fa-tag"></i>사용자관리</h3>
                </div> -->
                <div class="box-body">
<!--                   <table id="example1" class="table table-bordered table-striped">
                  </table> -->
                  
                  
                  
                  
                  
				<!-- jQuery Plug-Ins Widget Initialization -->
					<p id="searchArea" style="font-size: 15px; padding:10px 0px;"> 
					검색:&nbsp;&nbsp;&nbsp;&nbsp;<input id="in_search" />
					<input id="in_keyword" /> 
					<input id="in_searchDate" />
					<button id="searchBtn" type="button">조회</button>
					</p>
			
				<script>
				//var G_AreaCdVal;//조회조건 : 관리기관코드
				var G_AreaIdVal = "${userStore.areaId}";//조회조건 : 관리기관
				var G_UserNmVal;//조회조건 : 사용자명
				
				/* DropDownList Template */
				//var codeModles;
				var codelist = "_USER_TYPE_";
				var codeModles="";
				
 
					$.ajax({
						type: "post",
						url: "<c:url value='/dgms/getCodeListByCdIDModel.do'/>",
						data: {"list" : codelist},
						async: false, //동기 방식
						success: function(data,status){
							//codeModles = $.extend(codeModles, data.rtnList);
							codeModles = data.rtnList;
						},
						fail: function(){},
						complete: function(){}
					});
				
				
				
				/*$.ajax({
					type: "post",
					url: "<c:url value='/dgms/getCodeListByCdIDModel.do'/>",
					async: false, //동기 방식
					success: function(data,status){
						codeModles = data.rtnList;
					},
					fail: function(){},
					complete: function(){}
				});
				*/
				
				

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
				
				
				
				
				
				var G_Condition="ALL", G_Keyword;
				
				$(function() {
					var searchData = [ 
						{ text: "전체", value: "ALL" },
						{ text: "접속일", value: "LOGIN_DT" },
						{ text: "접속자 SEQ", value: "USER_SEQ" },
						{ text: "접속자 ID", value: "USER_ID" },
						{ text: "접속자명", value: "USER_NM" },
						{ text: "접속자 IP", value: "LOGIN_IP" },
						{ text: "접속방법", value: "LOGIN_MEHD" }
					];
					

					$("#in_search").kendoComboBox({ 
						dataTextField: "text",
						dataValueField: "value",
						dataSource: searchData,   
						change: function(){
							G_Condition = $("#in_search").val();
							if(G_Condition == "ALL"){
								$("#in_keyword").css({"display":"none"});
								$("#searchArea .k-datepicker").css({"display":"none"});
							}else if(G_Condition == "LOGIN_DT"){
								$("#in_searchDate").data("kendoDatePicker").value(new Date());
								$("#searchArea .k-datepicker").css({"display":"inline-block"});
								$("#in_keyword").css({"display":"none"});
								G_Keyword = kendo.toString(new Date(), "yyyy-MM-dd");
							}else{
								G_Keyword = "";
								$("#in_keyword").val("");
								$("#in_keyword").css({"display":"inline-block"});
								$("#searchArea .k-datepicker").css({"display":"none"});
							}
						},
						index: 0
					}); 
					

					/* 키워드 */
					$("#in_keyword").kendoMaskedTextBox({ 
						change: function(e) {
							G_Keyword = this.value();
						}
					});
					/*검색일자*/
					$("#in_searchDate").kendoDatePicker({
						culture: "ko-KR",
						format: "yyyy/MM/dd",
						parseFormats: ["yyyy-MM-dd"],
						value: new Date(), 
						change: function(e) {
							G_Keyword = kendo.toString(this.value(), "yyyy-MM-dd");
						}
					}); 
					

					/* 조회 */
					$("#searchBtn").kendoButton({
						icon: "search",
						click: function(e) {
							var gridDetail = $("#gridDetail").data("kendoGrid");
							gridDetail.dataSource.read();
							
							//alert("G_AreaCdVal:"+G_AreaCdVal);
						}
					});
					
					
					
					
					
					
					 
					
					/* 사용자명 */
					$("#in_user").kendoAutoComplete({ 
						dataSource: {
							transport: {
								read: {
									url: "<c:url value='/dgms/getAutoComplete.do'/>",
									dataType: "jsonp"
								},
								parameterMap: function(data, type) {//type =  read, create, update, destroy
									var result = {
											TABLE: "TB_USER_INFO",
											COLUNM: "USER_NM",
											//USER_TYPE: "101377",
											//USE_YN: "1"
											AREA_ID: G_AreaIdVal
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						}, 
						dataTextField: "CD_NM",
						dataBound: function(e) {
							// handle the event
						},
						change: function(e) {
							G_UserNmVal = this.value();
					    }
					}); 

					 
					

					
					
				});
				
				</script>
				
				
                  
                  
				<div id="gridDetail"></div>


				<script>
				
                $(document).ready(function () {

					/*************************/
                	/* dataSource gridDetail */
                	/*************************/
                    var crudServiceBaseUrl = "<c:url value='/urtown'/>",
                    /*** dataSource ***/
					dataSourceDetail = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectMngLoginLogJsonp.do",
		            			dataType: "jsonp"
							},
							/*
							update: {
								url: crudServiceBaseUrl + "/updateMngUserInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteMngUserInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertMngUserInfoJsonp.do",
								dataType: "jsonp" 
							},
							*/
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										AREA_ID: G_AreaIdVal,
										CONDITION : G_Condition,
										KEYWORD : G_Keyword
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
							parse: function(response) {  
                            	var list = response.rtnList;

                            	if(typeof list != "undefined"){
                                    $.each(list,function(idx,elem) {
                                    	var loginDate = new Date(elem.LOGIN_DT);
                                    	var year = loginDate.getFullYear();
                                    	var month = (loginDate.getMonth()+1);
                                    	var day = loginDate.getDate();
                                    	loginDate = year +""+ (month > 9 ? month : "0" + month) +""+ (day>9 ? day : "0" + day);
                                    	
                                    	elem.LOGIN_DT = loginDate;
                                    });
                            	}
                                return response;
                            },
							model:{//가져온 값이 있음...
								id:"LOGIN_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									RNUM: { 
										type: "string" //data type of the field {Number|String|Boolean|Date} default is String 
										,editable: false
									},
									LOGIN_SEQ: { 
										type: "string" //data type of the field {Number|String|Boolean|Date} default is String 
											,editable: false
									},
									USER_SEQ: { 
										type: "string",
										editable: false
									}, 
									USER_NM: { 
										type: "string",
										editable: false
									}, 
									USER_ID: { 
										type: "string",
										editable: false
									}, 
									LOGIN_IP: {
										type: "string",
										editable: false
									},
									LOGIN_DT: {
										type: "string",
										editable: false
									},
									LOGIN_MEHD: { 
										type: "string",
										editable: false 
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
							//alert(dataSourceDetail.at(0).USER_SEQ);
                            //if(validator.validate()) {
    							console.log("sync complete"); 
								//console.log("model.dirty:"+this.schema.model.dirty);//수정되었는지 여부
								alert("정상적으로 처리되었습니다.");  
                         //   }
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
					/***    gridDetail     ***/
					/*************************/
					$("#gridDetail").kendoGrid({
						autoBind: true,
						dataSource: dataSourceDetail,
						navigatable: true,
						pageable: true,
						height: 590,
						toolbar: [
								    /* { name: "create", text: "추가" },
								    { name: "save", text: "저장" },
								    { name: "cancel", text: "취소" },*/
								    { name: "excel", text: "엑셀" }
								    /* { name: "pdf", text: "PDF" }, */
								],
						columns: [
                            { field: "RNUM", title:"번호", width: 80
								,attributes: {style: "text-align: center;"}
                            },
							{
								field: "LOGIN_DT",
								title: "접속일자",
								attributes: {style: "text-align: center;"},
								width: 100
                            	,template: "#= (LOGIN_DT == '') ? '' : kendo.toString(kendo.parseDate(LOGIN_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"   
							},
							{
								field: "LOGIN_SEQ",
								title: "로그인 SEQ",
								attributes: {style: "text-align: center;"}, 
								hidden: true
							},   
							{
								field: "USER_SEQ",
								title: "접속자 SEQ",
								attributes: {style: "text-align: center;"},
								width: 100
							},
							{
								field: "USER_ID",
								title: "접속자 ID",
								attributes: {style: "text-align: center;"},
								width: 100 
							}, 
							{
								field: "USER_NM",
								title: "접속자명",
								attributes: {style: "text-align: center;"}, 
								width: 100
							},  
							{
								field: "LOGIN_IP",
								title: "접속자 IP",
								attributes: {style: "text-align: center;"},
								width: 140 
							},  
							{
								field: "LOGIN_MEHD",
								title: "접속방법",
								attributes: {style: "text-align: center;"},
								width: 300 
							}
						],
 						editable: {
							confirmation: "선택한 행을 삭제하시겠습니까?\n저장 버튼 클릭시 완전히 삭제됩니다."
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
			                fileName: "사용자관리.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "사용자관리.pdf",
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
							var uid = dataSourceDetail.at(0).USER_ID;
							var upw = dataSourceDetail.at(0).LOGIN_PWD;
							if( typeof uid == 'undefined' || uid.replace(/ /gi, '').length < 1 ){
								alert("아이디를 입력해주십시오.");
								e.preventDefault();
							}
							/*else if( typeof upw == 'undefined' || upw.replace(/ /gi, '').length < 1 ){
								alert("비밀번호를 입력해주십시오.");
								e.preventDefault();
							}*/
							
							//alert(dataSourceDetail.at(0).USER_ID);
							//for(var i=0; i<dataSourceDetail)
/* 							if (!confirm("변경된 데이타를 저장하시겠습니까?")) {  
								e.preventDefault();
							}   */  	
						},
						edit: function(e) {//Fired when the user edits or creates a data item
							/*
							,
	                        edit: function(e){
	                        	alert(dataUSER_SQ);
								//if(data.USER_SQ == null || data.USER_SQ == ""){
									//alert("처방전 정보가 생성되지 않았습니다. 저장한 후 진행해주세요.");
									//var grid = this;
									//grid.cancelRow();
									//return;
								//}
	                        }
						*/
						
							/*** Key 채번 ***/
			 				if (e.model.isNew() && ( dataSourceDetail.at(0).USER_SEQ == null || dataSourceDetail.at(0).USER_SEQ == "") ) {
 								var url = "<c:url value='/dgms/getSequence.do'/>";
								var parameters = {'SEQ_NM': "SEQ_USER_INFO"};
								$.post(url, parameters, function(data) {
									dataSourceDetail.at(0).set("USER_SEQ", data.Sequence);
								}); 
								
								var grid = this;
								grid.select("tr:eq(0)");

							}
			 				else
			 				{
								/* Disable the editor of the "id" column when editing data items */
								$('input[name=USER_SEQ]').parent().html(e.model.USER_SEQ);

			 				}
							
							
			
						}
			            
					});//gridDetail end...
					
					
/* 					$("#gridMaster").on("click", "table", function(e) {
					    alert("clicked", e.ctrlKey, e.altKey, e.shiftKey);
					});
					 */
					
					 
					
				});//document ready javascript end...
                

				
				

				
            	</script>


                  
                  
					        
					      </div>
					    </div><!-- box -->
					    
					    
					    
					    
					    
					  </div><!-- col-xs-12 -->
					</div><!-- row -->
        </section>    
        
      </div>
<style>
#in_keyword, .k-datepicker{display:none;}
#in_keyword, .k-datepicker, #searchBtn{margin-left:9px;}
.k-grid td{
    white-space: nowrap;
    text-overflow: ellipsis;
}
</style>        
<%@ include file="../../inc/footer.jsp" %>