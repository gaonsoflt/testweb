<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
    $("#gridMaster_active_cell input").readOnly = true;
	$('#mngPrescript').parent().parent().addClass('active');
	$('#mngPrescript').addClass('active');
	 
});	
</script>

      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>처방전관리
            <small>환자별 처방전을 등록/관리합니다.</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 안전서비스</a></li>
            <li class="active">처방전등록</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
        	<div class="row">
          	<!-- 내용 -->
          	<div class="col-xs-12">
            
              <!-- table 하나 -->
              <div class="box">
<!--                 <div class="box-header">
                  <h3 class="box-title"><i class="fa fa-tag"></i>기준관리</h3>
                </div> -->
                <div class="box-body">
<!--                   <table id="example1" class="table table-bordered table-striped">
                  </table> -->
                  
                  
                  
                  
                  
				<!-- jQuery Plug-Ins Widget Initialization -->
				<p>

				<div style="font-size: 15px;">
				&nbsp;&nbsp;&nbsp;
				관리기관: <input id="in_area" />&nbsp;&nbsp;&nbsp;
				</i>성명: <input id="in_user" />&nbsp;&nbsp;&nbsp;
				처방일: <input id="in_date" />&nbsp;&nbsp;&nbsp;
				<button id="searchBtn" type="button">조회</button>
				</div>

										
				<script>
				var G_AreaCdVal = "${userStore.areaid2}";//조회조건 : 관리기관코드
				var G_AreaCdVal;		//조회조건 : 관리기관코드
				var G_PRSCUserVal;		//조회조건 : 처방전 환자명
				var G_PRSCDtVal;	//조회조건 : 처방전 처방일
				
				String.prototype.byteLength = function() {
				    var l= 0;
				     
				    for(var idx=0; idx < this.length; idx++) {
				        var c = escape(this.charAt(idx));
				         
				        if( c.length==1 ) l ++;
				        else if( c.indexOf("%u")!=-1 ) l += 3;
				        else if( c.indexOf("%")!=-1 ) l += c.length/3;
				    }
				    return l;
				};
				
				$(function() {

					//관리기관 검색
					$("#in_area").kendoComboBox({
						index: 0,
						dataTextField: "CD_NM",
						dataValueField: "CD",
						filter: "contains",
						dataSource: {
							transport: {
								read: {
									url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
									dataType: "jsonp"
								},
								parameterMap: function(data, type) {//type =  read, create, update, destroy
									var result = {
											//AREA_ID: G_AreaCdVal, 
											CD_ID: "_AREA_ID_",
											USER_ID: "${userStore.username}",
											USE_YN: "1"
									};
									return { params: kendo.stringify(result) }; 
								}
							}
						},
						dataBound: function(e) {
							G_AreaCdVal = this.value();  
						},  
						change: function(e) { 
							G_AreaCdVal = this.value(); 
							//alert("G_AreaCdVal:"+G_AreaCdVal);
						}
					}); 
					var combobox = $("#in_area").data("kendoComboBox");
					combobox.value(G_AreaCdVal); 
					combobox.trigger("change");

					
					/* 처방일 */
					$("#in_date").kendoDatePicker({
                        start: "year",
                        mask: "0000/00/00",
                        depth: "month",
                        culture: "ko-KR",
                        format: "yyyy-MM-dd",
                        change: function () {
                        	G_PRSCDtVal = $("#in_date").val().replace(/-/gi, "");
                        }
                    });
					/*$("#in_date").kendoMaskedTextBox({
                        mask: "0000/00/00",
                        change: function () {
                        	G_PRSCDtVal = this.raw(); 
                        }
                    });*/
					 
					
					

					/* 환자명 */
					$("#in_user").kendoAutoComplete({ 
						dataSource: {
							transport: {
								read: {
									url: "/DGMS/dgms/getAutoComplete.do",
									dataType: "jsonp"
								},
								parameterMap: function(data, type) {//type =  read, create, update, destroy
									var result = {
											TABLE: "TB_USER_INFO",
											COLUNM: "USER_NM"
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						}, 
						dataTextField: "CD_NM",
						dataBound: function(e) {
						},
						change: function(e) {
							G_PRSCUserVal = this.raw();
					    }
					}); 
					
					/* 조회 */
					$("#searchBtn").kendoButton({
						icon: "search",
						click: function(e) {
							G_PRSCUserVal = $("#in_user").val();
							var gridMaster = $("#gridMaster").data("kendoGrid");
							gridMaster.dataSource.read();
							
							G_PrscVal=""; 
								 
							//초기화
							var gridDetail = $("#gridDetail").data("kendoGrid");
							gridDetail.dataSource.read();
						}
					});
					
				});
				
				</script>
				
				</p>
                  
                  
				<div id="splitter" style="height:500px">
					<div id="gridMaster"></div>
					<div id="gridDetail"></div>
                </div>


				<script>
				//등록된 사용자의 목록을 출력하기 위한 코드
				var userCodes;
				
				$.ajax({
					type: "post",
					url: "<c:url value='/dgms/getUserListByUserIDModel.do'/>",
					async: false, //동기 방식
					success: function(data,status){
						userCodes = data.rtnList;
					},
					fail: function(){},
					complete: function(){}
				});
				
				function fnUserNmByUserId(code){
					var rtnVal = "";
					for (var i = 0; i < userCodes.length; i++) {
			            if (userCodes[i].CD == code) {
			            	rtnVal = userCodes[i].CD_NM;
			            }
			        }
					return rtnVal;
				};
				
                $(document).ready(function () {
                	
                	/*************************/
                	/*       splitter        */
                	/*************************/
                	$("#splitter").kendoSplitter({
                		orientation: "horizontal",
                		panes: [ 
							{ 
								min: "150px",
								size: "25%"
							}, 
							{ 
								min: "150px" 
							}
                		]
					});
                	
                	/*************************/
                	/* dataSource gridMaster */
                	/*************************/
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>",
                    /*** dataSource ***/
					dataSourceMaster = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectMyPrescriptInfoJsonp.do",
		            			dataType: "jsonp",
		            			complete: function(e){ 
		            				console.log("selectMngCodeMasterInfoJsonp...................");
		            			}
							},
							update: {
								url: crudServiceBaseUrl + "/updateMyPrescriptInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteMyPrescriptInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertMyPrescriptInfoJsonp.do",
								dataType: "jsonp"
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
	                                       SKIP: data.skip,
	                                       PAGE: data.page,
	                                       TAKE: data.take,
	                                       AREA_ID: G_AreaCdVal,
	                                       USER_NM: G_PRSCUserVal,
	                                       PRSC_STDT: G_PRSCDtVal
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
								id:"PRSC_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: { 
									USER_ID : { 
										type: "string"
										, validation: { required: true } 
									},
									PRSC_STDT : { 
										type: "string" ,
										validation: { required: true, 
											  maxlength: function(input){
													if(input != null &&  input.length > 0){
														var leng = input.val().byteLength();
														if(leng > 11){
							                                input.attr("data-maxlength-msg", "처방시작일의  글자수 최대 길이를 초과했습니다.");
															return false;
														}
													}
													return true;
											  }
										} 
									},
									PRSC_PERIOD : { 
							        	type: "string",
										validation: { required: true } 
							        },
							        AREA_ID : {
							        	type: "string"
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
                        	console.log("change..........."); 
                        },  	
                        sync: function(e) {
							console.log("sync complete");
							//console.log("model.dirty:"+this.schema.model.dirty);//수정되었는지 여부
							alert("정상적으로 처리되었습니다.");  

							G_PrscVal = "";
							$("#gridDetail").data("kendoGrid").dataSource.read(); 
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
					});//datasource grid end...

					
					
					/*************************/
                	/* dataSource gridDetail */
                	/*************************/
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>",
                    /*** dataSource ***/
					dataSourceDetail = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectMyPrescriptMedcInfoJsonp.do",
		            			dataType: "jsonp",
		            			complete: function(e){ 
		            				console.log("selectMngEquipRentDetailInfoJsonp...................");
		            			}
							},
							update: {
								url: crudServiceBaseUrl + "/updateMyPrescriptMedcInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteMyPrescriptMedcInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertMyPrescriptMedcInfoJsonp.do",
								dataType: "jsonp"
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										PRSC_SEQ: G_PrscVal //선택한 분류코드값
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
								id:"PRSC_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									RNUM: { 
										type: "string" //data type of the field {Number|String|Boolean|Date} default is String
										, editable: false 
										, nullable: false
										//defaultValue: 42,
										//validation: { required: true, min: 1 }
									},
									PRSC_SEQ: { 
										type: "string"
										, nullable: false
									},
									PRSCMEDC_SEQ: { 
										type: "string"
										, editable: false 
										, nullable: false
										, validation: { required: true } 
									},
									PRSCMEDC_CD: { 
										type: "string", 
										validation: { required: true
													, maxlength: function(input){
															if(input != null && input.length > 0){
																var leng = input.val().byteLength();
																if(leng > 18){
									                                input.attr("data-maxlength-msg", "의약품코드의 글자수 최대 길이를 초과했습니다.");
																	return false;
																}
															}
															return true;
													  }
												} 
									},
									PRSCMEDC_NM: { 
										type: "string", 
										validation: { required: true
												  , maxlength: function(input){
															if(input != null && input.length > 0){
																var leng = input.val().byteLength();
																if(leng > 30){
									                                input.attr("data-maxlength-msg", "의약품명의 글자수 최대 길이를 초과했습니다");
																	return false;
																}
															}
															return true;
													  }
											} 
									},
									DOSAGE: { 
										type: "number", 
									},
									DOSAGE_ONCE: { 
										type: "number", 
										validation: { min: 1 } 
									},
									DOSAGE_ONCE_DAY: { 
										type: "number",
										validation: { min: 1 } 
									},
									USAGE: { 
										type: "string"
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
				
					
					//grid.addRow();
					
					$(".k-grid-add").on("click", function(){
					});
					/*************************/
					/***    gridMaster     ***/
					/*************************/
					$("#gridMaster").kendoGrid({
						autoBind: true,
						dataSource: dataSourceMaster,
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
								field: "PRSC_SEQ",
								title: "처방전ID",/*분류CD*/
								attributes: {style: "text-align: center;"},
								hidden: true,
								width: 100
							}, 
							{
								field: "USER_ID",
								title: "환자명",
								attributes: {style: "text-align: center;"},
								width: 100,
								editor: function (container, options) {  
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoDropDownList({
			                            autoBind: true,
			                            dataTextField: "CD_NM",
			                            dataValueField: "CD",
			                            filter: "contains",
			                            dataSource: {
											transport: {
			        							read: {
			        								url: "<c:url value='/dgms/getUserListByUserID.do'/>",
			        								dataType: "jsonp"
			        							},
			        							parameterMap: function(data, type) {
			        								var result = {
			        										PATIENT_YN: "1" 
			        	                            };
			        								return { params: kendo.stringify(result) }; 
			        							}
			        						}
			                            }
									});
								},
								template: "#=fnUserNmByUserId(USER_ID)#"
							}, 
							{
								field: "PRSC_STDT",
								title: "처방시작일",  
								width: 90, 
								attributes: {style: "text-align: center;"}, 
			                    format: '{0:MM.dd.yyyy}', 
								editor: function (container, options) { 
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoDatePicker({
				                        start: "year",
				                        depth: "month",
				                        culture: "ko-KR",
				                        format: "yyyy-MM-dd",
			                            parseFormats: ["yyyyMMdd"],
				                        //template: '#= kendo.toString(options.values), "MM/dd/yyyy" ) #',
			                            change: function() {
			                            	var selectDate = kendo.toString(this.value(), "yyyyMMdd");
			                            	options.model.set("PRSC_STDT", selectDate);
			                            } 
			                        });
			                    },
								template: "#= (PRSC_STDT == '') ? '' : kendo.toString(kendo.parseDate(PRSC_STDT, 'yyyyMMdd'), 'yyyy-MM-dd') #"
							},
							{
								field: "AREA_ID",
								title: "관리기관ID",
								hidden: true,
								attributes: {style: "text-align: center;"},
								width: 90
							},
							{
								field: "PRSC_PERIOD",
								title: "처방일수",
								attributes: {style: "text-align: center;"},
								width: 90
							},
							{
								command: { name: "destroy", text: "삭제" },
								width: 90
							}
						],
 						editable: {
							confirmation: "선택한 행을 삭제하시겠습니까?(저장 버턴 클릭시 완전히 삭제됩니다.)"
						},
						sortable: true,
						selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
						scrollable: true, 
						mobile: true,
						
						//excel, pdf
						excel: {
			                allPages: true,
			                fileName: "처방전목록.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "처방전목록.pdf",
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
							setTimeout(function(){$("#gridMaster").data("kendoGrid").dataSource.read(); }, 500);  
						},
						edit: function(e) {//Fired when the user edits or creates a data item 
							if (e.model.isNew() && ( dataSourceMaster.at(0).AREA_ID == null || dataSourceMaster.at(0).AREA_ID == "") ) {
									dataSourceMaster.at(0).set("AREA_ID", G_AreaCdVal);
								
								var grid = this;
								grid.select("tr:eq(0)");

							} 
						},
						dataBound: function(e) {
							console.log("dataBound..............");
							var grid = this;
						    $(grid.tbody).on("click", "td", function (e) {
						        var row = $(this).closest("tr");
						        var rowIdx = $("tr", grid.tbody).index(row);
						        var colIdx = $("td", row).index(this); 
						        var data = grid.dataItem(row);
						        G_PrscVal = data.PRSC_SEQ; 
						        var gridDetail = $("#gridDetail").data("kendoGrid");
						        gridDetail.dataSource.read();
						    });
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
						height: 500,
						toolbar: [
								    { name: "create", text: "추가" },
								    { name: "save", text: "저장" },
								    { name: "cancel", text: "취소" },
								    { name: "excel", text: "엑셀" },
								    {
								      template: '<a class="k-button" href="https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&query=%EC%9D%98%EC%95%BD%ED%92%88%EB%AA%85%EA%B2%80%EC%83%89&ie=utf8" target="_blank">의약품정보</a>'
								    }
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
								field: "PRSC_SEQ",
								title: "처방전ID", 
								hidden: true,
								attributes: {style: "text-align: left;"}
							}, 
							{
								field: "PRSCMEDC_NM",
								title: "의약품명",
								attributes: {style: "text-align: center;"},
								width: 200
							},   
							{
								field: "PRSCMEDC_CD",
								title: "의약품코드",
								attributes: {style: "text-align: center;"},
								width: 150
								//,footerTemplate: "합계: #: sum # 최소: #: min #",
							},
							{
								field: "DOSAGE",
								title: "1회투여량",
								attributes: {style: "text-align: right;"},
								width: 150
							},
							{
								field: "DOSAGE_ONCE",
								title: "1일투여회수",
								format: "{0:n0}",
								attributes: {style: "text-align: right;"},
								width: 100
							},
							{
								field: "DOSAGE_ONCE_DAY",
								title: "총투약일",
								attributes: {style: "text-align: right;"},
								width: 100
							},
							{
								field: "USAGE",
								title: "용법",
								attributes: {style: "text-align: left;"},
								//hidden: true,
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
						mobile: true,
						//excel, pdf
						excel: {
			                allPages: true,
			                fileName: "처방약정보.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "처방약정보.pdf",
							paperSize: "A4",
							landscape: true,
							scale: 0.75
						},     
				        excelExport: function(e) {
				        	alert(e.sender.showColumn(1));
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
						},
						saveChanges: function(e) {//저장버턴 클릭시 이벤트
							setTimeout(function(){$("#gridDetail").data("kendoGrid").dataSource.read(); }, 500); 
						},
						edit: function(e) {//Fired when the user edits or creates a data item
							/*** Key 채번 ***/   
			 				if (e.model.isNew() && ( dataSourceDetail.at(0).PRSC_SEQ == null || dataSourceDetail.at(0).PRSC_SEQ == "") ) { 

			 					var gridMaster = $("#gridMaster").data("kendoGrid");
								var row = gridMaster.select();
								console.log("row:"+row);
								
								var data = gridMaster.dataItem(row);
								if( data == null || data == ""){
									alert("먼저 분류코드를 선택해주세요!");
									var grid = this;
									grid.cancelRow();
									return false;
								}
								if(data.PRSC_SEQ == null || data.PRSC_SEQ == ""){
									alert("처방전 정보가 생성되지 않았습니다. 저장한 후 진행해주세요.");
									var grid = this;
									grid.cancelRow();
									return;
								}
								
								
								console.log("data.PRSC_SEQ:"+data.PRSC_SEQ);
								dataSourceDetail.at(0).set("PRSC_SEQ", data.PRSC_SEQ);
								return;
								
								var grid = this;
								grid.select("tr:eq(0)"); 
							}
			 				else
			 				{  
								$('input[name=PRSC_SEQ]').parent().html(e.model.PRSC_SEQ); 
			 				}
							
							
			
						}
			            
					});//gridDetail end...
					
				});//document ready javascript end...
                

            	</script>


                  
                  
					        
					      </div>
					    </div><!-- box -->
					    
					    
					    
					    
					    
					  </div><!-- col-xs-12 -->
					</div><!-- row -->
        </section>    
        
      </div>
            
<%@ include file="../inc/footer.jsp" %>