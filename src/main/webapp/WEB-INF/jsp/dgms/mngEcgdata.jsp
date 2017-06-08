<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
  <script src="<c:url value='/resource/js/jquery.form.js'/>" type="text/javascript"></script>
<script>
$(document).ready(function(){
	$('#mngEcgdata').parent().parent().addClass('active');
	$('#mngEcgdata').addClass('active');
});	
</script>
      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>심전도파일관리
            <small>댁내용,활동용 심전도 측정 파일 등록</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 운영관리</a></li>
            <li class="active">심전도파일관리</li>
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
				var G_UserId;//마스터에서 선택한 사용자SEQ
				var G_AreaCdVal;//조회조건 : 관리기관코드
				var G_AreaIdVal = "${userStore.areaId}";//조회조건 : 관리기관
				var G_UserNmVal;//조회조건 : 사용자명
				
				var G_CheckupSeq //디테일SEQ
				var G_testSeq; // test
				
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
					
					<div id="example">
	                	<div id="detl-form">
	                		<div id="toolbartest">
	                			<!-- <button class="k-button btnNew" data-bind="events: { click: newsync }"><span class="k-icon k-add"></span>추가</button> -->
					            <button class="k-button btnSave" data-bind="events: { click: sync }"><span class="k-icon k-update"></span>저장</button>
					            <button class="k-button btnCancel" data-bind="events: { click: cancel }"><span class="k-icon k-cancel"></span>취소</button>
	                		</div>
	                		<form id="ecgform" name="ecgform" method="post" enctype="multipart/form-data" accept-charset="utf-8">
	                		<div class="row">
	                			<label class="col-xs-4 control-label" style="min-width:160px;margin:10px 10px 10px 12px;">댁내용 파일(.ecg)는 파일에 기록되어 있는 측정일시를 사용합니다.</label>
	                		</div>           		
	                		<div class="row">
		                		<div class="form-group" style="margin-top:10px;margin-left:10px;">
									<label for="CHECKUP_DT" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">측정일자:</label>
									<div class="col-xs-3">
									<input id="checkup_dt" name="CHECKUP_DT" type="text" value="${today}" /> 
									</div>
		                		</div>
		                	</div>
	                		<div class="row">
		                		<div class="form-group" style="margin-top:10px;margin-left:10px;">
									<label for="ECG_FILE" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">측정파일:</label>
									<div class="col-xs-3">
									<input type="file" id="file" name="file"/>
		                			<input type="hidden" name="USER_ID" data-bind="value:dataSource.view()[0].USER_ID">		                			
									</div>
		                		</div>
		                	</div>
		                	</form>
	                	</div>
		        	</div>
	
					<!-- <div id="gridDetail"></div> -->
                </div>
                

				<script>
				
                $(document).ready(function () {
                	
					$("#checkup_dt").kendoDatePicker({
                        culture: "ko-KR",
                        mask: "0000/00/00",
                        // display month and year in the input
                        format: "yyyy-MM-dd",
                        parseFormats: ["yyyyMMdd"],
                       	change: function () {
                       		var checkup_dt = kendo.toString(this.value(), "yyyyMMdd");
                        	viewModel.dataSource.at(0).set("CHECKUP_DT", checkup_dt);
                       	}
                    });
                	
                	var validator;
                	 
	               	var Model = kendo.data.Model.define({
		               	id:"CHECKUP_SEQ",//id 로 insert할건지 update 할건지 판단함.
						fields: {
							USER_ID: { validation: { required: true } },
							CHECKUP_SEQ:{ validation: { required: true } },
							CHECKUP_TYPE:{
								defaultValue: '101041',
							},
							HOSP_NM:{ },
							MEASURE_DT: { },
							DOCTOR_NM: { },
							CHECKUP_DT: { },
							OPINION_WRITER: { defaultValue: "${userStore.fullname}" },
							OPINION: { validation: { required: true } },
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
               	    });
                	 
                	var crudServiceBaseUrl = "<c:url value='/dgms'/>";
                	var viewModel = kendo.observable({
                		dataSource: new kendo.data.DataSource({
               		  	batch: true,
               		  	transport: {
	               			read:  {
								url: crudServiceBaseUrl + "/selectFirstOpinDetailInfoJsonp.do",
		            			dataType: "jsonp",
		            			complete: function(e){ 
		            				console.log("selectFirstOpinDetailInfoJsonp.........");
		            			}
							},
							update: {
								url: crudServiceBaseUrl + "/updateFirstOpinInfoJsonp.do",
								dataType: "jsonp",
								complete: function(e){ 
		            				console.log("updateFirstOpinInfoJsonp...................");
		            			}
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteFirstOpinInfoJsonp.do",
								dataType: "jsonp",
								complete: function(e){ 
		            				console.log("deleteFirstOpinInfoJsonp...................");
		            			}
							},
							create: {
								url: crudServiceBaseUrl + "/insertFirstOpinInfoJsonp.do",
								dataType: "jsonp",
								complete: function(e){ 
		            				console.log("insertFirstOpinInfoJsonp...................");
		            			}
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										USER_ID: G_UserId,
										AREA_ID: G_AreaIdVal
									};
									return { params: kendo.stringify(result) }; 
								}
	                           
								if (type !== "read" && data.models) {	
									console.log(data);
									console.log(data.models);
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
	               			  model: Model
	               		  },
	                      
	                      change : function(e) {
	                    	  console.log("change...dsDetail........");
	                    	  viewModel.set("hasChanges", this.hasChanges());
	                      	/*
	                      	alert(data.length+"건 처리하였습니다."); */
	                      },  	
	                    }), //end dataSource
	                    
	                    selected: {},
	                    hasChanges: false,
	               		error : function(e) {
	                      	console.log(e.errors);
	                      	alert(e.errors);
	                    },
	                    sync: function(e) {
	                    	console.log("validator.validate():"+validator.validate());
	                    	/* if(validator.validate()) {
	                    		this.dataSource.sync();
	                    		alert("정상적으로 처리되었습니다.");  
	                    	} */
	                    	var form = $("#ecgform");
	                    	$('#ecgform').ajaxSubmit({
	                            url: "<c:url value='/dgms/uploadecgfile.do'/>",
	                            type: 'post',
	                            async: false,
	                            //data : {'보낼 파레머터 ex> no : no },
	                            dataType: 'text',
	                            success: function (retval) {
	                            	if (retval =="1")
	                            	{
	                            		alert("등록되었습니다.");
	                            	}
	                            	
	                            }, error: function (a,b,c) {
	                                //에러 처리
	                                alert('실패 a : '+ a + " b : " + b + " c : " + c);
	                                //alert("Error!!");
	                            }
	                        });						
					  	},
					  	cancel: function () {
                            this.dataSource.cancelChanges();
                            validator.hideMessages();
                        },/* 
                        newsync: function () {
                        	viewModel.set("selected", new userModel());
                        	//bbsSeq 
                        	this.dataSource.insert(0, this.selected);
                        }, */
                        remove: function () {
                        	var key = this.dataSource.at(0).CHECKUP_SEQ;
                        	var keyData = this.dataSource.get(key);
                        	if(key != null && key != ""){
                        		if(confirm("데이터를 삭제하시겠습니까")){ 
                        			this.dataSource.remove(keyData);
                        			this.dataSource.sync();
                        		}
                        	}else{
                        		alert("삭제 할 데이터가 없습니다.");
                        	}
                        	
                        },
						dataBound: function(e) {
							console.log("dataBound Detail111..............");
						}
				  	
                	});
                	/* 
                	console.log("viewModel");
                    console.log(viewModel);
                    kendo.bind($("#detl-form"), viewModel);
                    validator = $("#detl-form").kendoValidator().data("kendoValidator");
                	 */
               	    
                	/* 
               		dataSource.fetch(function() {
               		  var product = dataSource.at(0);
               		  product.set("UnitPrice", 20);
               		  var anotherProduct = dataSource.at(1);
               		  anotherProduct.set("UnitPrice", 20);
               		  dataSource.sync(); // causes only one request to "http://demos.telerik.com/kendo-ui/service/products/update"
               		});
 */
                	
 					$("#toolbartest").kendoToolBar({});
                	
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
										USER_NM: G_UserNmVal,
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
									},/* 
									CHECKUP_TYPE: {
										
									}, */
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
                        	console.log("e.errors"+e.errors);
                        	alert("e.errors"+e.errors);
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
								editable: false,
								width: 100
							},/* 
							{
								field: "CHECKUP_TYPE",
								title: "검진소견구분",
								attributes: {style: "text-align: left;"},
								editable: false,
								width: 120,
								template: "#=fnCodeNameByCdID(CHECKUP_TYPE)#"
							}, */
							{
								field: "USER_ID",
								title: "사용자ID",
								attributes: {style: "text-align: left;"},
								editable: false,
								width: 100
							},   
							/* {
								field: "LOGIN_PWD",
								title: "패스워드",
								attributes: {style: "text-align: center;"},
								editable: false,
								width: 100
								//,footerTemplate: "합계: #: sum # 최소: #: min #",
							}, */
							{
								field: "AREA_ID",
								title: "관리기관",
								attributes: {style: "text-align: center;"},
								width: 200,
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
			                            }
									});
								},
								editable: false,
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
			                            }
									});
								},
								editable: false,
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
								template: "#=fnStrToDateFormat(BIRTHDAY)#" 
								
							},
							{
								field: "USE_YN",
								title: "사용여부",
								attributes: {style: "text-align: center;"},
								width: 100
							},/* 
							{
								field: "USER_ID",
								title: "사용자ID",
								attributes: {style: "text-align: center;"},
								//hidden: true,
								//attributes
								width: 100
							} */
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
						        var data = dataSourceMaster.at(rowIdx);
						        G_UserId = data.USER_ID;
						        //alert("data.CD:"+data.CD);
						        
						        
						        //var gridDetail = $("#gridDetail").data("kendoGrid");
						        //gridDetail.dataSource.read();
						        
						        //읽기전 key값 없으면 데이터 remove
						        var dsDetail = viewModel.dataSource;
						        dsDetail.read().then(function() {
						          console.log("viewModel", viewModel);
						          console.log("dsDetail", dsDetail);
						          console.log("dsDetail.view()[0]", dsDetail.view()[0]);
					        	  //console.log("total: ", dsDetail.data()[0].total);
					        	  //console.log(view[0].rtnList[0]);
					        	  //console.log(view[0].rtnList[0].OPINION);
					        	 // console.log(dsDetail.at(0).OPINION);
					        	  kendo.bind($("#detl-form"), viewModel);	//view[0].rtnList[0]
					        	  validator = $("#detl-form").kendoValidator().data("kendoValidator");
					        	  
					        	  console.log("total", dsDetail.total());
					        	  
					        	  //데이터 없으면 자동 빈행 추가. 
	                        	  if (dsDetail.total() < 1){
		                        	  dsDetail.insert(0, {});
		                        	  dsDetail.at(0).set("USER_ID", G_UserId);
		                        	  
		                        	  console.log("viewModel22", viewModel);
	                        	  }
					        	});
						    });
						}
			            
					});//gridMaster end...
					
				});//document ready javascript end...
                
				
            	</script>
					        
		        </div>
		      </div><!-- box -->
					    
					    
					    
					    
					    
            </div><!-- col-xs-12 -->
          </div><!-- row -->
        </section>    
        
      </div>
        
        
<%@ include file="../inc/footer.jsp" %>