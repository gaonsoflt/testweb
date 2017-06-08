<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#ecrOpin').parent().parent().addClass('active');
	$('#ecrOpin').addClass('active');
});	
</script>
      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>심전도판독소견
            <small>병원의사의 소견을 시스템에 등록함</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 안전서비스</a></li>
            <li class="active">심전도판독소견</li>
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
                  <h3 class="box-title"><i class="fa fa-tag"></i>Hover Data Table</h3>
                </div>/.box-header -->
                <div class="box-body">

				<!-- jQuery Plug-Ins Widget Initialization -->
				<p>

				<div style="font-size: 15px;">
				&nbsp;&nbsp;&nbsp;
				관리기관: <input id="in_area" />&nbsp;&nbsp;&nbsp;
				사용자명: <input id="in_user" />&nbsp;&nbsp;&nbsp;
				<button id="searchBtn" type="button">조회</button>
				</div>

			
				<script>
				var G_UserId;//마스터에서 선택한 사용자ID
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
					
					/* 관리기관 */
					$("#in_area").kendoComboBox({
						index: 0,
						dataTextField: "CD_NM",
						dataValueField: "CD_ID",
						filter: "contains",
						dataSource: {
							transport: {
								read: {
									url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
									dataType: "jsonp"
								},
								parameterMap: function(data, type) {//type =  read, create, update, destroy
									var result = {
											CD_ID: "_AREA_ID_",
											USER_ID: "${userStore.username}",
											USE_YN: "1"
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						},
						change: function(e) {
							G_AreaIdVal = this.value();
							//G_AreaCdVal = this.value();
						}


					});
					//초기화
					var combobox = $("#in_area").data("kendoComboBox");
					combobox.value(G_AreaIdVal);
					combobox.trigger("change");

					
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
											COLUNM: "USER_NM"
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
					

					
					
					
					
					/* 조회 */
					$("#searchBtn").kendoButton({
						icon: "search",
						click: function(e) {
							var gridMaster = $("#gridMaster").data("kendoGrid");
							gridMaster.dataSource.read();
							
							//alert("G_AreaCdVal:"+G_AreaCdVal);
						}
					});
					
					
					
					

					
					
				});
				
				</script>
				
				</p>
                  
                <div id="splitter" style="height:500px">
					<div id="gridMaster"></div>
					
					<div id="splitter2" style="height:500px">
						<div id="gridDetail"></div>
						
						<div class="col-sm-12">
				    		<label>심전도판독소견</label>
				    		<div class="col-sm-11">
								<textarea class="k-textbox" id="opinion-textarea" name="opinion-textarea" rows="5" style="width: 100%" required validationMessage="필수입력 항목입니다."></textarea>
							</div>
						</div>
					</div>
					
					
				</div>
					
                </div>  
                
                

				<script>
				
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
                	
                	$("#splitter2").kendoSplitter({
                		orientation: "vertical",
                		panes: [ 
   							{
   								size: "65%"
   							}, 
   							{ 
   								
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
								url: crudServiceBaseUrl + "/selectMngUserDetailInfoJsonp.do",
		            			dataType: "jsonp",
		            			complete: function(e){ 
		            				console.log("selectMngUserDetailInfoJsonp...................");
		            			}
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										AREA_ID: G_AreaIdVal,
										PATIENT_YN: "1"
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
								id:"USER_ID",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									USER_ID: { 
										type: "string" //data type of the field {Number|String|Boolean|Date} default is String
										//defaultValue: 42,
										//validation: { required: true, min: 1 }
									},
									SEX: {
										editable: true,
										validation: { required: true },
										defaultValue: "M"//남성
									},
									BIRTHDAY: {
										editable: true,
										validation: { required: true }
									},
								    AREA_ID: {
										editable: true,
										validation: { required: true },
										defaultValue: "2229000000"//대구직할시 달서구
									},
									USE_YN: { 
										type: "boolean", 
										defaultValue: true
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
					});//datasource gridMaster end...
					
					
					var validator = $("#opinion-textarea").kendoValidator().data("kendoValidator");
					/*************************/
                	/* dataSource gridDetail */
                	/*************************/
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>",
                    /*** dataSource ***/
					dataSourceDetail = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectEcrOpinDetailInfoJsonp.do",
		            			dataType: "jsonp"
							},
							update: {
								url: crudServiceBaseUrl + "/updateEcrOpinInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteEcrOpinInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertEcrOpinInfoJsonp.do",
								dataType: "jsonp"
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										USER_ID: G_UserId
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
								id:"CHECKUP_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									USER_ID: { 
										type: "string" //data type of the field {Number|String|Boolean|Date} default is String
										//defaultValue: 42,
										//validation: { required: true, min: 1 }
									},
									CHECKUP_SEQ:{
										type: "string"
									},
									CHECKUP_TYPE:{
										
									},
									HOSP_NM:{
										type: "string"
									},
									RELATION_SEQ: {
										editable: true,
										validation: { required: true }
									},
									MEASURE_DT: {
										
									},
									DOCTOR_NM: {
										
									},
									CHECKUP_DT: {
										
									},
									OPINION_WRITER: {
										defaultValue: "${userStore.fullname}"
									},
									OPINION: {
										
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
                        	console.log("e.errors:", e.errors);
                        	alert("e.errors:"+e.errors);
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
								    { name: "excel", text: "엑셀" }
								    /* { name: "pdf", text: "PDF" }, */
								],
						columns: [
							{
								field: "USER_NM",
								title: "사용자명",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "USER_ID",
								title: "사용자ID",
								attributes: {style: "text-align: left;"},
								width: 100
							}, 
							{
								field: "AREA_ID",
								title: "관리기관",
								attributes: {style: "text-align: center;"},
								width: 150,
								editor: function (container, options) { 
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoDropDownList({
			                            autoBind: true,
			                            dataTextField: "CD_NM",
			                            dataValueField: "CD_ID",
			                            dataSource: {
											transport: {
			        							read: {
			        								url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
			        								dataType: "jsonp"
			        							},
			        							parameterMap: function(data, type) {
			        								var result = {
			        										CD_ID: "_AREA_ID_",
			        										USE_YN: "1"
			        	                            };
			        								return { params: kendo.stringify(result) }; 
			        							}
			        						}
			                            },
			                            change: function() {
			                            	options.model.set("AREA_ID", this.value());
			                            } 
									});
								},
								template: "#=fnCodeNameByCdID(AREA_ID)#" 
							},
							{
								field: "SEX",
								title: "성별",
								attributes: {style: "text-align: center;"},
								width: 150,
								editor: function (container, options) { 
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoDropDownList({
			                            autoBind: true,
			                            dataTextField: "CD_NM",
			                            dataValueField: "CD_ID",
			                            dataSource: {
											transport: {
			        							read: {
			        								url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
			        								dataType: "jsonp"
			        							},
			        							parameterMap: function(data, type) {
			        								var result = {
			        										CD_ID: "_SEX_",
			        										USE_YN: "1"
			        	                            };
			        								return { params: kendo.stringify(result) }; 
			        							}
			        						}
			                            },
			                            change: function() {
			                            	options.model.set("SEX", this.value());
			                            } 
									});
								},
								template: "#=fnCodeNameByCdID(SEX)#" 
							},
							{
								field: "BIRTHDAY",
								title: "생년월일",
								attributes: {style: "text-align: center;"},
								width: 100,
								editor: function (container, options) { 
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoMaskedTextBox({
			                            mask: "00/00/00",
			                            //promptChar: " "//defualt "_"
			                            change: function() {
			                            	options.model.set("BIRTHDAY",this.raw());
			                                //this.value = this.raw();
			                            }
									});
								},
								template: "#= (BIRTHDAY == '') ? '' : kendo.toString(kendo.parseDate(BIRTHDAY, 'yyyyMMdd'), 'yyyy-MM-dd') #"
								
							},
							/* 
							{
								field: "USE_YN",
								title: "사용여부",
								attributes: {style: "text-align: center;"},
								width: 100
							},
							{
								field: "LOGIN_PWD",
								title: "패스워드",
								attributes: {style: "text-align: center;"},
								width: 100
								//,footerTemplate: "합계: #: sum # 최소: #: min #",
							}, 
							{
								field: "USER_ID",
								title: "사용자ID",
								attributes: {style: "text-align: center;"},
								//hidden: true,
								//attributes
								width: 100
							},
							 */
							/* 
							{
								command: { name: "destroy", text: "삭제" },
								width: 100
							}
							 */
						],
						sortable: true,
						selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
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
			            /*  
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
			             */
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
						},
						dataBound: function(e) {
							console.log("dataBound..............");
							
							var grid = this;
						    $(grid.tbody).on("click", "td", function (e) {
						        var row = $(this).closest("tr");
						        var rowIdx = $("tr", grid.tbody).index(row);
						        var colIdx = $("td", row).index(this);
						        //alert(rowIdx + '-' + colIdx);
						        //alert("selected CATGR:"+this.dataSource.get(rowIdx).CATGR);
						        //var data = grid.dataItem(rowIdx);
						        var data = grid.dataItem(row);
						        G_UserId = data.USER_ID;
						        //alert("data.CD:"+data.CD);
						        
						        
						        var gridDetail = $("#gridDetail").data("kendoGrid");
						        gridDetail.dataSource.read();
						        
						        $("#opinion-textarea").val("");
						        
								validator.hideMessages();
						    });
						}
			            
					});//gridMaster end...
					
					
					
					/*************************/
					/***    gridDetail     ***/
					/*************************/
					$("#gridDetail").kendoGrid({
						autoBind: false,
						dataSource: dataSourceDetail,
						navigatable: true,
						//pageable: true,
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
								field: "HOSP_NM",//field: "CD_NM",
								title: "병원명",
								hidden: true,
								attributes: {style: "text-align: left;"}
							},
							
							{
								field: "CHECKUP_SEQ",
								title: "검사소견SEQ",
								attributes: {style: "text-align: left;"},
								hidden: true,
								width: 200
							},
							{
								field: "CHECKUP_TYPE",
								title: "검진소견구분",
								attributes: {style: "text-align: center;"},
								width: 100,
								hidden: true,
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
			        								url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
			        								dataType: "jsonp"
			        							},
			        							parameterMap: function(data, type) {
			        								var result = {
			        										CD_ID: "_CHECKUP_TYPE_",
			        										USE_YN: "1"
			        	                            };
			        								return { params: kendo.stringify(result) }; 
			        							}
			        						}
			                            },
			                            change: function() {
			                            	options.model.set("CHECKUP_TYPE", this.value());
			                            } 
									});
								},
								template: "#=fnCodeNameByCd(CHECKUP_TYPE)#" 
							},
							{
								//field: "SORT_NO",
								//title: "정렬순서",
								//format: "{0:n0}",
								field: "MEASURE_DT",
								title: "측정일",
								attributes: {style: "text-align: center;"},
								width: 100,
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
			                            	options.model.set("MEASURE_DT", selectDate);
			                            } 
			                        });
			                    },
								template: "#= (MEASURE_DT == '') ? '' : kendo.toString(kendo.parseDate(MEASURE_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"
							},
							{
								field: "DOCTOR_NM",
								title: "의사명",
								width: 150
							},
							{
								//field: "SORT_NO",
								//title: "정렬순서",
								//format: "{0:n0}",
								field: "CHECKUP_DT",
								title: "검진일",
								attributes: {style: "text-align: center;"},
								width: 100,
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
			                            	options.model.set("CHECKUP_DT", selectDate);
			                            } 
			                        });
			                    },
								template: "#= (CHECKUP_DT == '') ? '' : kendo.toString(kendo.parseDate(CHECKUP_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"
							},
							{
								field: "OPINION_WRITER",
								title: "소견등록자",
								attributes: {style: "text-align: center;"},
								//hidden: true,
								//attributes
								width: 100
							},
							/* {
								field: "OPINION",//field: "CD_NM",
								title: "검진소견",
								attributes: {style: "text-align: left;"}
							}, */
							{
								field: "USER_ID",
								title: "사용자ID",
								attributes: {style: "text-align: center;"},
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
			                fileName: "심전도판독소견.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "심전도판독소견.pdf",
							paperSize: "A4",
							landscape: true,
							scale: 0.75
						},      
			            
			            noRecords: {
			                //template: "No data. Current page is: #=this.dataSource.page()#"
							template: "No data"
			            },
			            /*  
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
			             */
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
         			             $()
						},
						saveChanges: function(e) {//저장버턴 클릭시 이벤트
							if(!validator.validate()) {
								e.preventDefault();
	                    	}
							/* 
 							if (!confirm("변경된 데이타를 저장하시겠습니까?")) {  
 								e.preventDefault();
							}  
 							 */
						},
						edit: function(e) {//Fired when the user edits or creates a data item
							/*** Key 채번 ***/
			 				if (e.model.isNew() && ( dataSourceDetail.at(0).USER_ID == null || dataSourceDetail.at(0).USER_ID == "") ) {
 								var url = "<c:url value='/dgms/getSequence.do'/>";
								var parameters = {'SEQ_NM': "SEQ_CHECKUP_OPINION"};
								$.post(url, parameters, function(data) {
									dataSourceDetail.at(0).set("CHECKUP_SEQ", data.Sequence);
								}); 
								
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
								console.log("data.CD111111111:"+data.CD); // displays "Jane Doe"
								dataSourceDetail.at(0).set("USER_ID", data.USER_ID);
								dataSourceDetail.at(0).set("CHECKUP_TYPE", "101043");
								
								var grid = this;
								grid.select("tr:eq(0)");
								//grid.select("tr:eq(0) td:eq(3)");
								//grid.editCell(grid.tbody.find("tr:eq(0) td:eq(2)"));//loop ㅜㅜ
								//e.preventDefault();
								//e.sender.current(e.sender.tbody.children().eq(0).children().eq(2));
							}
			 				else
			 				{
								/* Disable the editor of the "id" column when editing data items */
								////$(e.container).find('input[name="id"]').attr("readonly", true);
								$('input[name=CHECKUP_SEQ]').parent().html(e.model.CHECKUP_SEQ);
								$('input[name=USER_ID]').parent().html(e.model.USER_ID);
								$('input[name=CHECKUP_TYPE]').parent().html(e.model.CHECKUP_TYPE);
			 				}
							
							
			
						},
						dataBound: function(e) {
							console.log("dataBound..............");
							var data = dataSourceDetail.at(0);
							if (data != null && data != ""){
						        var opinion = data.OPINION;
						        $("#opinion-textarea").val(opinion);
							}
						        
							var grid = this;
						    $(grid.tbody).on("click", "td", function (e) {
						        var row = $(this).closest("tr");
						        var rowIdx = $("tr", grid.tbody).index(row);
						        var colIdx = $("td", row).index(this);
						        //alert(rowIdx + '-' + colIdx);
						        //alert("selected CATGR:"+this.dataSource.get(rowIdx).CATGR);
						        //var data = grid.dataItem(rowIdx);
						        var data = grid.dataItem(row);
						        if (data != null && data != ""){
						        	var opinion = data.OPINION;
							        $("#opinion-textarea").val(opinion);
						        }
						        
						        //alert("data.CD:"+data.CD);
						        
						        
						        //var gridDetail = $("#gridDetail").data("kendoGrid");
						        //gridDetail.dataSource.read();
						    });
						}
						
			            
					});//gridDetail end...
					
/* 					$("#gridMaster").on("click", "table", function(e) {
					    alert("clicked", e.ctrlKey, e.altKey, e.shiftKey);
					});
					 */
					 
					$("#opinion-textarea").change(function() {
						var gridDetail = $("#gridDetail").data("kendoGrid");
						var row = gridDetail.select();
						var rowIdx = $("tr", gridDetail.tbody).index(row);
						//console.log(rowIdx+":111:"+row);
						var data = gridDetail.dataItem(row);
						//console.log("222"+data);
						//console.log(data.OPINION);
						
						if( data == null || data == ""){
							alert("데이터를 먼저 선택해주세요!");
							return false;
						}else{
							
							dataSourceDetail.at(rowIdx).set("OPINION", $("#opinion-textarea").val());
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