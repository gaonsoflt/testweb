<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#mngEquipRent').parent().parent().addClass('active');
	$('#mngEquipRent').addClass('active');
});	
</script>
      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
          	<i class="fa fa-caret-right"></i>측정기기대여관리 등록 및 관리
            <small>장비를 대여시 대여정보를 등록관리함</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 운영관리</a></li>
            <li class="active">측정기기대여관리</li>
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
                  <h3 class="box-title"><i class="fa fa-tag"></i>측정기기관리</h3>
                </div> -->
                <div class="box-body">
<!--                   <table id="example1" class="table table-bordered table-striped">
                  </table> -->
                  
                  
                  
                  
                  
				<!-- jQuery Plug-Ins Widget Initialization -->
				<p>

				<div style="font-size: 15px;">
				&nbsp;&nbsp;&nbsp;
				관리기관: <input id="in_area" />&nbsp;&nbsp;&nbsp;
				기기종류: <input id="equip_type" />&nbsp;&nbsp;&nbsp;
				모델명: <input id="model_nm" />&nbsp;&nbsp;&nbsp;
				기기상태: <input id="equip_state" />&nbsp;&nbsp;&nbsp;
				사용자명: <input id="in_user"/>&nbsp;&nbsp;&nbsp;
				
				

				<button id="searchBtn" type="button">조회</button>
				</div>

			
				<script>
				var G_AreaCdVal;//조회조건 : 관리기관코드
				var G_AreaIdVal = "${userStore.areaId}";//조회조건 : 관리기관
				var G_EquipTypeCdVal;//조회조건 : 기기종류코드
				var G_ModelNm;//조회조건 : 모델명
				var G_EquipStateCdVal;//조회조건 : 기기상태코드
				var G_UserNmVal;//조회조건 : 사용자명
				
				var G_EquipMentSeq;//마스터에서 선택한 장비SEQ
				
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
					$("#equip_type").kendoComboBox({
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
											CD_ID: "_EQUIP_TYPE_",
											USE_YN: "1"
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						},
						change: function(e) {
							G_EquipTypeCdVal = this.value();
						}


					});
					//초기화
					//var combobox = $("#equip_type").data("kendoComboBox");
					//combobox.value("100710");//달서구 하드코딩...ㅜㅜ
					//combobox.trigger("change");
					
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
					
					/* 기기상태 */
					$("#equip_state").kendoComboBox({
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
											CD_ID: "_EQUIP_STATE_",
											USE_YN: "1"
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						},
						change: function(e) {
							var G_EquipStateCdVal = this.value();
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
				
                $(document).ready(function () {
                	
                	/*************************/
                	/*       splitter        */
                	/*************************/
                	$("#splitter").kendoSplitter({
                		orientation: "horizontal",
                		panes: [ 
							{ 
								min: "150px",
								size: "35%"
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
								url: crudServiceBaseUrl + "/selectMngEquipInfoRent.do",
		            			dataType: "jsonp",
		            			complete: function(e){ 
		            				console.log("selectMngEquipInfoRent...................");
		            			}
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
	                                       SKIP: data.skip,
	                                       PAGE: data.page,
	                                       TAKE: data.take,
	                                        AREA_ID: G_AreaIdVal,//조회조건 : 관리기관코드
											EQUIP_TYPE: G_EquipTypeCdVal,//조회조건 : 기기종류코드
											MODEL_NM: G_ModelNm,//조회조건 : 모델명
											EQUIP_STATE: G_EquipStateCdVal,//조회조건 : 기기상태코드
											USER_NM: G_UserNmVal//조회조건 : 사용자명
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
								id:"EQUIPMENT_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									EQUIPMENT_ID: { 
										type: "string", //data type of the field {Number|String|Boolean|Date} default is String
										editable: false
									},
									EQUIP_TYPE: {
										type: "string",
										editable: false
									},
									RENT_YN:{
										type: "string",
										editable: false
									},
									MODEL_NM: {
										type: "string",
										editable: false
									},
									SERIAL_NO: {
										editable: false
									},
									EQUIP_STATE: { 
										type: "string",
										editable: false
									},
									AREA_ID: {
										type: "string",
										editable: false
									},
									PURCHASE_DT: { 
										type: "string",
										editable: false
									},
									CRE_USR : { 
										type: "string",
										editable: false
									},
									MOD_USR : { 
										type: "string",
										editable: false
									},
									EQUIPMENT_SEQ: { 
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
								url: crudServiceBaseUrl + "/selectMngEquipRentDetailInfoJsonp.do",
		            			dataType: "jsonp",
		            			complete: function(e){ 
		            				console.log("selectMngEquipRentDetailInfoJsonp...................");
		            			}
							},
							update: {
								url: crudServiceBaseUrl + "/updateMngEquipRentInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteMngEquipRentInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertMngEquipRentInfoJsonp.do",
								dataType: "jsonp"
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										EQUIPMENT_SEQ: G_EquipMentSeq	//마스터에서 선택한 장비SEQ
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
								id:"RENT_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									RENT_SEQ: {
										type: "string"						
									},
									EQUIPMENT_SEQ: { 
										type: "string" //data type of the field {Number|String|Boolean|Date} default is String
										//defaultValue: 42,
										//validation: { required: true, min: 1 }
									},
									AREA_ID: {						
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
									},
									RENT_PLACE: {
										
									},
									RETURN_USER_NM: { 
										
									},
									RETURN_DT: {
										
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
								field: "EQUIPMENT_SEQ",
								title: "장비SEQ",
								attributes: {style: "text-align: center;"},
								hidden: true,
								width: 100
							},
							{
								field: "EQUIPMENT_ID",
								title: "장비ID",
								attributes: {style: "text-align: center;"},
								width: 100
								//,footerTemplate: "합계: #: sum # 최소: #: min #",
							},
							{
								field: "EQUIP_TYPE",
								title: "기기종류",
								attributes: {style: "text-align: left;"},
								width: 130,
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
			        										CD_ID: "_EQUIP_TYPE_",
			        										USE_YN: "1"
			        	                            };
			        								return { params: kendo.stringify(result) }; 
			        							}
			        						}
			                            }
									});
								},
								template: "#=fnCodeNameByCd(EQUIP_TYPE)#" 
							},
							{
								field: "RENT_YN",
								title: "대여가능여부",
								attributes: {style: "text-align: center;"},
								width: 110,
							},
							{
								field: "AREA_ID",
								title: "관리기관ID",
								hidden: true,
								attributes: {style: "text-align: center;"}
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
			               //template: "No data. Current page is: #=this.dataSource.page()#"
			               template: "No data."
			            },
			             
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
							
							var grid = this;
						    $(grid.tbody).on("click", "td", function (e) {
						        var row = $(this).closest("tr");
						        var rowIdx = $("tr", grid.tbody).index(row);
						        var colIdx = $("td", row).index(this);
						        //alert(rowIdx + '-' + colIdx);
						        //alert("selected CATGR:"+this.dataSource.get(rowIdx).CATGR);
						        //var data = grid.dataItem(rowIdx);
						        var data = grid.dataItem(row);
						        G_EquipMentSeq = data.EQUIPMENT_SEQ;
						        //alert("data.CD:"+data.EQUIPMENT_SEQ);
						        
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
			                            },
			                            change: function(e) {
				                        	options.model.set("RENT_STATE", this.value());
			                            } 
									});
								},
								template: "#=fnCodeNameByCd(RENT_STATE)#" 
							},
							{
								field: "USER_ID",
								title: "실사용자",
								attributes: {style: "text-align: left;"},
								width: 150,
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
			        										PATIENT_YN: "1",
			        										//USER_ID:"${userStore.username}"
			        	                            };
			        								return { params: kendo.stringify(result) }; 
			        							}
			        						}
			                            },
			                            change: function(e) {
				                        	//console.log("this", this);
				                        	options.model.set("USER_ID", this.value());
			                            	//var selectDate = kendo.toString(this.value(), "yyyyMMdd");
			                            	options.model.set("RENT_USER_NM", this.text());
			                            } 
									});
								},
								template: "#=fnUserNmByUserId(USER_ID)#"
								//
								//사용자 콤보.
								//
							},   
							{
								field: "RENT_CNT",
								title: "수량",
								attributes: {style: "text-align: center;"},
								width: 100
							},
							{
								field: "RENT_DT",
								title: "대여일",
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
			                            	options.model.set("RENT_DT", selectDate);
			                            } 
			                        });
			                    },
								template: "#= (RENT_DT == '') ? '' : kendo.toString(kendo.parseDate(RENT_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"
							},
							{
								field: "EXPIRE_DT",
								title: "만기일",
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
			                            	options.model.set("EXPIRE_DT", selectDate);
			                            } 
			                        });
			                    },
								template: "#= (EXPIRE_DT == '') ? '' : kendo.toString(kendo.parseDate(EXPIRE_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"
							},
							{
								field: "RENT_USER_NM",
								title: "수령자",
								attributes: {style: "text-align: center;"},
								hidden: true,
								width: 100
							},
							{
								field: "RENT_PLACE",
								title: "대여장소",
								attributes: {style: "text-align: center;"},
								width: 100
							},
							{
								field: "RETURN_USER_NM",
								title: "반납자",
								attributes: {style: "text-align: center;"},
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
			                        .kendoDatePicker({
				                        start: "year",
				                        depth: "month",
				                        culture: "ko-KR",
				                        format: "yyyy-MM-dd",
			                            parseFormats: ["yyyyMMdd"],
				                        //template: '#= kendo.toString(options.values), "MM/dd/yyyy" ) #',
			                            change: function() {
			                            	var selectDate = kendo.toString(this.value(), "yyyyMMdd");
			                            	options.model.set("RETURN_DT", selectDate);
			                            } 
			                        });
			                    },
								template: "#= (RETURN_DT == '') ? '' : kendo.toString(kendo.parseDate(RETURN_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"
							},
							{
								field: "REMARK",
								title: "비고",
								attributes: {style: "text-align: center;"},
								width: 200
							},
							{
								field: "EQUIPMENT_SEQ",
								title: "장비SEQ",
								attributes: {style: "text-align: center;"},
								//hidden: true,
								//attributes
								width: 100
							},
							{
								field: "RENT_SEQ",
								title: "대여관리SEQ",
								attributes: {style: "text-align: center;"},
								hidden: true,
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
			                fileName: "측정기기관리.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "측정기기관리.pdf",
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
			 				if (e.model.isNew() && ( dataSourceDetail.at(0).EQUIPMENT_SEQ == null || dataSourceDetail.at(0).EQUIPMENT_SEQ == "") ) {
 								var url = "<c:url value='/dgms/getSequence.do'/>";
								var parameters = {'SEQ_NM': "SEQ_RENT_MNG"};
								$.post(url, parameters, function(data) {
									dataSourceDetail.at(0).set("RENT_SEQ", data.Sequence);
								}); 
								
								var gridMaster = $("#gridMaster").data("kendoGrid");
								var row = gridMaster.select();
								
								var data = gridMaster.dataItem(row);
								if( data == null || data == ""){
									alert("먼저 장비를 선택해주세요!");
									var grid = this;
									grid.cancelRow();
									return false;
								}
								
								dataSourceDetail.at(0).set("EQUIPMENT_SEQ", data.EQUIPMENT_SEQ);
								dataSourceDetail.at(0).set("AREA_ID", data.AREA_ID);
								//dataSourceDetail.at(0).set("CD_NM", "aa");
								
								var grid = this;
								grid.select("tr:eq(0)");

							}
			 				else if(!e.model.isNew()){
			 					$('input[name=USER_ID]').parent().html(e.model.USER_ID);
			 				}
			 				else
			 				{
								/* Disable the editor of the "id" column when editing data items */
								$('input[name=RENT_SEQ]').parent().html(e.model.RENT_SEQ);
								$('input[name=EQUIPMENT_SEQ]').parent().html(e.model.EQUIPMENT_SEQ);

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