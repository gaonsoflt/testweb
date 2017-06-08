<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#mngEquipUse').parent().parent().addClass('active');
	$('#mngEquipUse').addClass('active');
});	
</script>
      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>기기사용관리
            <small>현장방문, 교육</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 운영관리</a></li>
            <li class="active">기기사용관리</li>
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
				사용자ID: <input id="user_id" />&nbsp;&nbsp;&nbsp;
				대여상태: <input id="rent_state" />&nbsp;&nbsp;&nbsp;
				모델명: <input id="model_nm" />&nbsp;&nbsp;&nbsp;
				
				<button id="searchBtn" type="button">조회</button>
				</div>

										
				<script>
				var G_AreaCdVal;//조회조건 : 관리기관코드
				var G_AreaIdVal = "${userStore.areaId}";//조회조건 : 관리기관
				var G_RentState;//조회조건 : 대여상태
				var G_ModelNm;//조회조건 : 모델명
				var G_UserId;//조회조건 : 기기상태코드
				
				var G_RentSeq;//마스터에서 선택한 대여SEQ
				
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

					/* 기기종류 */
					$("#rent_state").kendoComboBox({
						//index: 0,
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
											CD_ID: "_RENT_STATE_",
											USE_YN: "1"
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						},
						change: function(e) {
							G_RentState = this.value();
						}


					});
					
					/* 모델명 */
					$("#model_nm").kendoAutoComplete({ 
						dataSource: {
							transport: {
								read: {
									url: "<c:url value='/dgms/getAutoComplete.do'/>",
									dataType: "jsonp"
								},
								parameterMap: function(data, type) {//type =  read, create, update, destroy
									var result = {
											TABLE: "TB_EQUIPMENT_INFO",
											COLUNM: "MODEL_NM"
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
							G_ModelNm = this.value();
					    }
					}); 
					
					/* 사용자명 */
					$("#user_id").kendoAutoComplete({ 
						dataSource: {
							transport: {
								read: {
									url: "<c:url value='/dgms/getAutoComplete.do'/>",
									dataType: "jsonp"
								},
								parameterMap: function(data, type) {//type =  read, create, update, destroy
									var result = {
											TABLE: "TB_USER_INFO",
											COLUNM: "USER_ID"
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
							G_UserId = this.value();
					    }
					}); 
					
					/* 조회 */
					$("#searchBtn").kendoButton({
						icon: "search",
						click: function(e) {
							var gridMaster = $("#gridMaster").data("kendoGrid");
							gridMaster.dataSource.read();
							
							//초기화
							var gridDetail = $("#gridDetail").data("kendoGrid");
							gridDetail.dataSource.read();
							
							//alert("G_AreaCdVal:"+G_AreaCdVal);
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

/* 				$(window).resize(function() {
				    var gridElement = $("#gridMaster"),
				        newHeight = gridElement.innerHeight(),
				        otherElements = gridElement.children().not(".k-grid-content"),
				        otherElementsHeight = 0;

				    otherElements.each(function(){
				        otherElementsHeight += $(this).outerHeight();
				    });

				    gridElement.children(".k-grid-content").height(newHeight - otherElementsHeight);
				}); */
				
				
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
								url: crudServiceBaseUrl + "/selectMngEquipRentDetailInfoJsonp.do",
		            			dataType: "jsonp",
		            			complete: function(e){ 
		            				console.log("selectMngEquipRentDetailInfoJsonp...................");
		            			}
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
	                                       SKIP: data.skip,
	                                       PAGE: data.page,
	                                       TAKE: data.take,
	                                       
	                                       //AREA_ID: G_AreaCdVal,	//조회조건 : 관리기관코드
		                       			   AREA_ID: G_AreaIdVal,
	                                       RENT_STATE: G_RentState,	//조회조건 : 대여상태
	                       				   MODEL_NM: G_ModelNm,		//조회조건 : 모델명
	                       				   USER_ID: G_UserId,		//조회조건 : 기기상태코드
	                       				   
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
								id:"RENT_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									RENT_SEQ: {
										type: "string",
										editable: false,
										hidden: true
									},
									
									RENT_STATE: { 
										type: "string", //data type of the field {Number|String|Boolean|Date} default is String
										//defaultValue: 42,
										validation: { required: true, min: 1 }
									},
									USER_ID: {
										editable: true,
										validation: { required: true }
										//defaultValue: "M"//남성
									},
									RENT_CNT: {
										type: "number",
										validation: { min: 1 }
									},
									RENT_DT: {
										editable: true,
										validation: { required: true }
									},
									EXPIRE_DT: {
										editable: true,
										validation: { required: true }
									},
									RENT_USER_NM: { 
										editable: false,
									},
									RENT_PLACE: {
										editable: false,
									},
									RETURN_USER_NM: { 
										editable: false,
									},
									RETURN_DT: {
										editable: false,
									},
									REMARK: {
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
									},
									EQUIPMENT_ID:{
										type: "string", 
										editable: false,
									},
									MODEL_NM:{
										type: "string", 
										editable: false,
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
                        	
/*                             var selectedRows = this.select();
                            var selectedDataItems = [];
                            for (var i = 0; i < selectedRows.length; i++) {
                              var dataItem = this.dataItem(selectedRows[i]);
                              selectedDataItems.push(dataItem);
                            } */
                            
                            /* var grid = this;
                        	var selectedRow = grid.select();
                            alert("selectedRow:"+selectedRow); */
                            
/*                         	var gview = $("#grid").data("kendoGrid");
                        	//Getting selected item
                        	var selectedItem = gview.dataItem(gview.select());
                        	alert(selectedItem.ShipName); */
                        	
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
					});//datasource grid end...

					
					
					/*************************/
                	/* dataSource gridDetail */
                	/*************************/
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>",
                    /*** dataSource ***/
					dataSourceDetail = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectMngEquipUseDetailInfoJsonp.do",
		            			dataType: "jsonp",
		            			complete: function(e){ 
		            				console.log("selectMngEquipUseDetailInfoJsonp...................");
		            			}
							},
							update: {
								url: crudServiceBaseUrl + "/updateMngEquipUseInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteMngEquipUseInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertMngEquipUseInfoJsonp.do",
								dataType: "jsonp"
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										RENT_SEQ: G_RentSeq	//마스터에서 선택한 대여SEQ
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
								id:"RENT_USE_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									RENT_SEQ: { 
										type: "string",
										validation: { required: true } 
									},
									RENT_USE_SEQ: { 
										type: "string", //data type of the field {Number|String|Boolean|Date} default is String
										//defaultValue: 42,
										validation: { required: true }
									},
									
									VISITER_ID: { 
										type: "string", 
										validation: { required: true } 
									},
									VISIT_DT: {
										
									},
									EDU_YN: { 
										type: "boolean", 
										defaultValue: true
									},
									EQUIP_USE_YN: { 
										type: "boolean", 
										defaultValue: true
									},
									REMARK: {
										
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
								field: "RENT_SEQ",
								title: "대여관리SEQ",
								attributes: {style: "text-align: center;"},
								hidden: true,
								width: 60
							},
							{
								field: "EQUIPMENT_ID",
								title: "장비ID",
								attributes: {style: "text-align: center;"},
								width: 100
							},
							{
								field: "MODEL_NM",
								title: "모델명",
								attributes: {style: "text-align: center;"},
								width: 100
							},
							{
								field: "RENT_STATE",
								title: "대여상태",
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
			        								url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
			        								dataType: "jsonp"
			        							},
			        							parameterMap: function(data, type) {
			        								var result = {
			        										CD_ID: "_RENT_STATE_",
			        										USE_YN: "1"
			        	                            };
			        								return { params: kendo.stringify(result) }; 
			        							}
			        						}
			                            }
									});
								},
								template: "#=fnCodeNameByCd(RENT_STATE)#"
							},
							{
								field: "RENT_CNT",
								title: "대여수량",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "RENT_DT",
								title: "대여일자",
								attributes: {style: "text-align: left;"},
								width: 100,
								editor: function (container, options) { 
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoMaskedTextBox({
			                            mask: "00/00/00",
			                            //promptChar: " "//defualt "_"
			                            change: function() {
			                            	options.model.set("RENT_DT",this.raw());
			                                //this.value = this.raw();
			                            }
									});
								},
								template: "#=fnStrToDateFormat(RENT_DT)#" 
							},
							{
								field: "EXPIRE_DT",
								title: "만기일자",
								attributes: {style: "text-align: left;"},
								width: 100,
								editor: function (container, options) { 
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoMaskedTextBox({
			                            mask: "00/00/00",
			                            //promptChar: " "//defualt "_"
			                            change: function() {
			                            	options.model.set("EXPIRE_DT",this.raw());
			                                //this.value = this.raw();
			                            }
									});
								},
								template: "#=fnStrToDateFormat(EXPIRE_DT)#" 
							},
							{
								field: "RENT_USER_NM",
								title: "수령자",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "RENT_PLACE",
								title: "대여장소",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "RETURN_USER_NM",
								title: "반납자",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "RETURN_DT",
								title: "반납일",
								attributes: {style: "text-align: center;"},
								width: 100,
								editor: function (container, options) { 
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoMaskedTextBox({
			                            mask: "00/00/00",
			                            //promptChar: " "//defualt "_"
			                            change: function() {
			                            	options.model.set("RETURN_DT",this.raw());
			                                //this.value = this.raw();
			                            }
									});
								},
								template: "#=fnStrToDateFormat(RETURN_DT)#" 
							},
							{
								field: "REMARK",
								title: "비고",
								attributes: {style: "text-align: center;"},
								width: 200
							}
							
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
			                fileName: "측정기기대여관리.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "측정기기대여관리.pdf",
							paperSize: "A4",
							landscape: true,
							scale: 0.75
						},      
			            
			            noRecords: {
			               //template: "No data. Current page is: #=this.dataSource.page()#"
			               template: "No data."
			            },
			            pageable : false,
			             
/* 			            pageable: {	
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
			            }, */
			            
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
							G_RentSeq = dataSourceMaster.at(0).RENT_SEQ;
							
							var grid = this;
						    $(grid.tbody).on("click", "td", function (e) {
						        var row = $(this).closest("tr");
						        var rowIdx = $("tr", grid.tbody).index(row);
						        var colIdx = $("td", row).index(this);
						        //alert(rowIdx + '-' + colIdx);
						        //alert("selected CATGR:"+this.dataSource.get(rowIdx).CATGR);
						        //var data = grid.dataItem(rowIdx);
						        var data = grid.dataItem(row);
						        G_RentSeq = data.RENT_SEQ;
						        //alert("G_RentSeq:"+G_RentSeq);
						        
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
								    { name: "excel", text: "엑셀" }
								    /* { name: "pdf", text: "PDF" }, */
								],
						columns: [
							   
							{
								field: "VISITER_ID",
								title: "현장방문자ID",
								attributes: {style: "text-align: center;"},
								width: 130
								//,footerTemplate: "합계: #: sum # 최소: #: min #",
							},
							{
								field: "VISIT_DT",
								title: "현장방문일",
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
			                            	options.model.set("VISIT_DT", selectDate);
			                            } 
			                        });
			                    },
								template: "#= (VISIT_DT == '') ? '' : kendo.toString(kendo.parseDate(VISIT_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"
							},
							{
								field: "EDU_YN",
								title: "교육여부",
								width: 80
							},
							{
								field: "EQUIP_USE_YN",
								title: "장비사용여부",
								attributes: {style: "text-align: center;"},
								width: 110
							},
							{
								field: "REMARK",
								title: "비고",
								attributes: {style: "text-align: center;"},
								width: 100
							},
							{
								field: "RENT_USE_SEQ",
								title: "사용관리SEQ",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "RENT_SEQ",
								title: "대여관리SEQ",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								command: { name: "destroy", text: "삭제" },
								width: 100
							},
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
			                fileName: "기기사용관리.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "기기사용관리.pdf",
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
			 				if (e.model.isNew() && ( dataSourceDetail.at(0).RENT_USE_SEQ == null || dataSourceDetail.at(0).RENT_USE_SEQ == "") ) {
 								var url = "<c:url value='/dgms/getSequence.do'/>";
								var parameters = {'SEQ_NM': "SEQ_RENT_USE"};
								$.post(url, parameters, function(data) {
									console.log("data.Sequence:"+data.Sequence);
									dataSourceDetail.at(0).set("RENT_USE_SEQ", data.Sequence);
								}); 
								
								var gridMaster = $("#gridMaster").data("kendoGrid");
								var row = gridMaster.select();
								console.log("row:"+row);
								
								var data = gridMaster.dataItem(row);
								if( data == null || data == ""){
									alert("먼저 대여장비를 선택해주세요!");
									var grid = this;
									grid.cancelRow();
									return false;
								}
								console.log("data.RENT_SEQ:"+data.RENT_SEQ); // displays "Jane Doe"
								dataSourceDetail.at(0).set("RENT_SEQ", data.RENT_SEQ);
								//dataSourceDetail.at(0).set("CD_NM", "aa");
								
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
								$('input[name=RENT_SEQ]').parent().html(e.model.RENT_SEQ);
								$('input[name=RENT_USE_SEQ]').parent().html(e.model.RENT_USE_SEQ);
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
        
        
<%@ include file="../inc/footer.jsp" %>