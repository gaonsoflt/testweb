<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#mngFault').parent().parent().addClass('active');
	$('#mngFault').addClass('active');
});	
</script>

<style>
/* 
#editForm div label {
    font-weight: bold;
    display: inline-block;
    width: 90px;
    text-align: right;
}

#editForm label {
    display: block;
    margin-bottom: 10px;
} 
*/

    
</style>
      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>서비스장애관리
            <small>사용자가 등록한 서비스 장애내용을 확인하고 신속히 조치결과를 등록함</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 운영관리</a></li>
            <li class="active">서비스장애관리</li>
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
				
				<div style="font-size: 15px;">
				&nbsp;&nbsp;&nbsp;
				관리기관: <input id="in_area" />&nbsp;&nbsp;&nbsp;
				제목: <input id="subject" class="k-textbox" id="subject" />&nbsp;&nbsp;&nbsp;
				내용: <input id="contents" class="k-textbox" id="contents" />&nbsp;&nbsp;&nbsp;
				<button id="searchBtn" type="button">조회</button>
				</div>
				<div style="font-size: 15px;">
				&nbsp;&nbsp;&nbsp;
				<!-- 작성일자: <input id="fromdate" />&nbsp;&nbsp;&nbsp; -->
				접수일자: <input id="fromdate" name="fromdate" />
				~ <input id="todate" name="todate"/>&nbsp;&nbsp;&nbsp;
				
				</div>
				<p></p>

										
				<script>
				var G_AreaIdVal = "${userStore.areaId}";//조회조건 : 관리기관
	
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
					
					$("#fromdate").kendoDatePicker({
                        
                        culture: "ko-KR",
                        parseFormats: ["yyyyMMdd"],
                        // display month and year in the input
                        format: "yyyy-MM-dd"
                    });

					$("#todate").kendoDatePicker({
                        
                        culture: "ko-KR",
                        parseFormats: ["yyyyMMdd"],
                        // display month and year in the input
                        format: "yyyy-MM-dd"
                    });
		
					/* 조회 */
					$("#searchBtn").kendoButton({
						icon: "search",
						click: function(e) {
							var gridMaster = $("#grid").data("kendoGrid");
							gridMaster.dataSource.read();
							
							//초기화
							//var gridDetail = $("#gridDetail").data("kendoGrid");
							//gridDetail.dataSource.read();
							
							//alert("G_AreaCdVal:"+G_AreaCdVal);
						}
					});
				});
				
				</script>

                  
				<div id="splitter" style="height:500px">
					<!-- <div id="gridMaster"></div> -->
					<div id="grid"></div>
					<div id="editForm">
				    	<div id="toolbartest">
                			<button class="k-button btnNew" data-bind="events: { click: newsync }"><span class="k-icon k-add"></span>추가</button>
				            <button class="k-button btnSave" data-bind="events: { click: sync }"><span class="k-icon k-update"></span>저장</button>
				            <button class="k-button btnCancel" data-bind="events: { click: cancel }"><span class="k-icon k-cancel"></span>취소</button>
				            <button class="k-button btnRemove" data-bind="events: { click: remove }"><span class="k-icon k-delete"></span>삭제</button>
                		</div>
                		<!-- 
				        <div class="col-xs-8">
				            <label for="RENT_FAULT_SEQ">RENT_FAULT_SEQ</label>
				            <input data-role="numerictextbox" name="RENT_FAULT_SEQ" data-bind="value: selected.RENT_FAULT_SEQ" required min="1"/>
				            <span class="k-invalid-msg" data-for="RENT_FAULT_SEQ"></span>
				        </div>
				         -->
					    <div style="margin-top :10px;">
					        <div class="row" style="margin-top:10px;margin-left:10px;">
						        <div class="col-xs-5">    
						            <label for="WRITER_ID" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">사용자</label>
						            <input type="text" class="k-textbox col-xs-2" name="WRITER_ID" data-bind="value: selected.WRITER_ID" required validationMessage="사용자 필수입력입니다." />
						        </div><!-- 
						        <div class="col-xs-3">
						            <label for="WRITE_DT">작성일</label>
						            <input id="write_dt" type="text" name="WRITE_DT" data-bind="value: selected.WRITE_DT" required />
						        </div> -->
						        <div class="col-xs-5" >
						            <label for="EQUIP_TYPE" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">기기종류</label>
						            <input type="text" id="EQUIP_TYPE" name="EQUIP_TYPE" data-bind="value: selected.EQUIP_TYPE" required validationMessage="기기종류 필수입력입니다."/>
						            <span class="k-invalid-msg" data-for="EQUIP_TYPE"></span>
						        </div>
						    </div>
					        <div class="row" style="margin-top:10px;margin-left:10px;">
						        <div class="col-xs-5" > 
						            <label for="MODEL_NM" class="col-xs-1 control-label" style="min-width:80px; padding-right:5px;">모델명</label>
						            <input type="text"  class="k-textbox col-xs-2" name="MODEL_NM" data-bind="value: selected.MODEL_NM" />
						        </div>
						        <div class="col-xs-5" > 
						            <label for="SERIAL_NO" class="col-xs-1 control-label" style="min-width:80px; padding-right:5px;">시리얼번호</label>
						            <input type="text" class="k-textbox col-xs-2" name="SERIAL_NO" data-bind="value: selected.SERIAL_NO" required validationMessage="시리얼번호 필수입력입니다." />
						        </div>
					        </div>
					        <div class="row" style="margin-top:10px;margin-left:10px;">
						        <div class="col-xs-5" >
						            <label for="ACCEPTER_ID" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">접수자</label>
						            <input id="ACCEPTER_ID" name="ACCEPTER_ID" data-bind="value: selected.ACCEPTER_ID" required />
						        </div>
						        <div class="col-xs-5" >
						            <label for="ACCEPT_DT" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">접수일</label>
						        	<input id="ACCEPT_DT" type="text" name="ACCEPT_DT" data-bind="value: selected.ACCEPT_DT" />
						        </div>
					        </div>
					        <div class="row" style="margin-top:10px;margin-left:10px;">
						        <div class="col-xs-11" >    
						            <label for="SUBJECT" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">제목</label>
						            <input type="text" class="k-textbox col-xs-2" style="width: 100%" name="SUBJECT" data-bind="value: selected.SUBJECT" required validationMessage="제목 필수입력입니다." />
						        </div>
						    </div>
						    <div class="row" style="margin-top:10px;margin-left:10px;">
						        <div class="col-xs-11" >    
						            <label for="CONTENTS" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">내용</label>
						            <textarea class="k-textbox" rows="5" style="width: 100%" name="CONTENTS" data-bind="value: selected.CONTENTS" required validationMessage="내용 필수입력입니다."></textarea>
						            <!-- <span>Items is discontinued</span> -->
						       	</div>
						    </div>
					        <!-- 
					            <label for="ANSWER_AT">ANSWER_AT</label>
					            <input type="checkbox" name="ANSWER_AT" data-bind="checked: selected.ANSWER_AT" />
					        -->
					        <div class="row" style="margin-top:10px;margin-left:10px;">
						        <div class="col-xs-5">
						        	<label for="RESULT_STATE" class="col-xs-1 control-label" style="min-width:80px; padding-right:5px;">처리상태</label>
						            <input id="RESULT_STATE" type="text" name="RESULT_STATE" data-bind="value: selected.RESULT_STATE" />
						        </div>
						    </div>
					        <div class="row" style="margin-top:10px;margin-left:10px;">
						        <div class="col-xs-5">
						            <label for="WORK_DT" class="col-xs-1 control-label" style="min-width:80px; padding-right:5px;">처리일자</label>
						            <input id="WORK_DT" type="text"  name="WORK_DT" data-bind="value: selected.WORK_DT" />
						        </div>
						        <div class="col-xs-5">
						        	<label for="WORKER_ID" class="col-xs-1 control-label" style="min-width:80px; padding-right:5px;">처리자</label>
						            <input id="WORKER_ID" type="text" name="WORKER_ID" data-bind="value: selected.WORKER_ID" />
						        </div>
						    </div>
						    <div class="row" style="margin-top:10px;margin-left:10px;">
						   		 <div class="col-xs-11">
						            <label for="RESULT" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">처리결과</label>
						            <textarea class="k-textbox" rows="5" style="width: 100%" name="RESULT" data-bind="value: selected.RESULT" ></textarea>
						            <!-- <span>Items is discontinued</span> -->
						       	</div>
						    </div>
					    </div>
					</div><!-- editForm -->
					
					<!-- <div id="gridDetail"></div> -->
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
				
				$("#toolbartest").kendoToolBar({});
				
                $(document).ready(function () {
                	
                	//form
					/* 측정기기종류 */
					/* $("#EQUIP_TYPE_TEMP").kendoComboBox({
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
											CD_ID: "_EQUIP_TYPE_",
											USE_YN: "1"
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						},
						change: function(e) {
							viewModel.set("selected.EQUIP_TYPE", this.value());
							$("#EQUIP_TYPE_TEMP").val(this.value());
							//alert("EQUIP_TYPE_TEMP:"+this.value());
						}
					}); */
					
					/* 처리상태 */
					$("#RESULT_STATE").kendoComboBox({
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
											CD_ID: "_RESULT_STATE_",
											USE_YN: "1"
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						},
						change: function(e) {
							viewModel.set("selected.RESULT_STATE", this.value());
						}
					});
					
					$("#WORKER_ID").kendoComboBox({
						index: 0,
						dataTextField: "CD_NM",
						dataValueField: "CD",
						filter: "contains",
						dataSource: {
							transport: {
								read: {
									url: "<c:url value='/dgms/getUserListByUserID.do'/>",
									dataType: "jsonp"
								},
								parameterMap: function(data, type) {//type =  read, create, update, destroy
									var result = {
											//PATIENT_YN: "1" 
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						},
						change: function(e) {
							//template: "#=fnUserNmByUserId(USER_ID)#"
							viewModel.set("selected.WORKER_ID", this.value());
						}
					});
					
					$("#ACCEPTER_ID").kendoComboBox({
						index: 0,
						dataTextField: "CD_NM",
						dataValueField: "CD",
						filter: "contains",
						dataSource: {
							transport: {
								read: {
									url: "<c:url value='/dgms/getUserListByUserID.do'/>",
									dataType: "jsonp"
								},
								parameterMap: function(data, type) {//type =  read, create, update, destroy
									var result = {
											//PATIENT_YN: "1" 
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						},
						change: function(e) {
							//template: "#=fnUserNmByUserId(USER_ID)#"
							viewModel.set("selected.ACCEPTER_ID", this.value());
						}
					});
					
					
					/* 측정기기종류 */
					$("#EQUIP_TYPE").kendoComboBox({
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
											CD_ID: "_EQUIP_TYPE_",
											USE_YN: "1"
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						},
						change: function(e) {
							viewModel.set("selected.EQUIP_TYPE", this.value());
						}
					});
					
                	//접수일
					$("#ACCEPT_DT").kendoDatePicker({
                        culture: "ko-KR",
                        mask: "0000/00/00",
                        // display month and year in the input
                        format: "yyyy-MM-dd",
                        parseFormats: ["yyyyMMdd"],
                       	change: function () {
                       		alert(kendo.toString(new Date(), "yyyyMMdd"));
                       		var accept_dt = kendo.toString(this.value(), "yyyyMMdd");
                       		var dataItem = grid.dataItem(grid.select());
                       		var index = viewModel.dataSource.indexOf(dataItem);
                       		//console.log("dataItem", dataItem);
                       		//console.log("index", index);
                       		viewModel.dataSource.at(index).set("ACCEPT_DT", accept_dt);
                       		viewModel.dataSource.at(index).set("WRITE_DT", accept_dt);
                       	}
                    });
                	
					//처리일자
					$("#WORK_DT").kendoDatePicker({
                        culture: "ko-KR",
                        mask: "0000/00/00",
                        // display month and year in the input
                        format: "yyyy-MM-dd",
                        parseFormats: ["yyyyMMdd"],
                       	change: function () {
                       		var work_dt = kendo.toString(this.value(), "yyyyMMdd");
                       		var dataItem = grid.dataItem(grid.select());
                       		var index = viewModel.dataSource.indexOf(dataItem);
                       		//console.log("dataItem", dataItem);
                       		//console.log("index", index);
                        	viewModel.dataSource.at(index).set("WORK_DT", work_dt);
                       	}
                    });
					
					
                	
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
                	
                	

                	var validator;
                    
                    var userModel = kendo.data.Model.define({
                    	id: "RENT_FAULT_SEQ",
                        fields: {
                        	RENT_FAULT_SEQ: { validation: { required: true } }, //editable: false, nullable: true
                        	EQUIP_TYPE: { validation: { required: true } },
                        	MODEL_NM: { validation: { required: true } },
                        	SERIAL_NO: { validation: { required: true } },
                            SUBJECT: { validation: { required: true } },
                            CONTENTS: { validation: { required: true } },
                            WRITER_ID: { validation: { required: true } },
                            WRITE_DT: { 
                            	validation: { required: true },
                            	defaultValue: kendo.toString(new Date(), "yyyyMMdd")
                            },
                            ACCEPTER_ID: { 
                            	validation: { required: true },
                            	defaultValue: "${userStore.username}"
                            },
                            ACCEPT_DT: { 
                            	validation: { required: true },
                            	defaultValue: kendo.toString(new Date(), "yyyyMMdd")
                            },
                            WORKER_ID: { },
                            WORK_DT: { },
                            RESULT: { },
                            RESULT_STATE: { defaultValue: "101380" },
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
                            transport: {
                                read:  {
                                	url: crudServiceBaseUrl + "/selectMngFaultInfo.do",
    		            			dataType: "jsonp",
    		            			complete: function(e){ 
    		            				console.log("selectMngFaultInfo...................");
    		            			}
                                },
                				update: {
                					url: crudServiceBaseUrl + "/updateMngFaultInfoJsonp.do",
                					dataType: "jsonp"
                				},
                				destroy: {
                					url: crudServiceBaseUrl + "/deleteMngFaultInfoJsonp.do",
                					dataType: "jsonp"
                				},
                				create: {
                					url: crudServiceBaseUrl + "/insertMngFaultInfoJsonp.do",
                					dataType: "jsonp"
                                },
                                parameterMap: function(options, operation) {
                                	if (operation == "read"){
                                		console.log("read>>>");
                                       	var result = {
                                       		PAGESIZE: options.pageSize,
                							SKIP: options.skip,
                							PAGE: options.page,
                							TAKE: options.take,
                                            AREA_ID: G_AreaIdVal, //조회조건 : 관리기관코드
    		                			    SUBJECT: $("#subject").val(), //조회조건 : 게시물제목
    		                			    CONTENTS: $("#contents").val(), //조회조건 : 게시물내용
    		                			    FROM_DATE: $("#fromdate").val().replace(/-/gi, ""), //조회조건 : fr날짜
    		                			    TO_DATE: $("#todate").val().replace(/-/gi, ""), //조회조건 : to날짜
                						};
                						return { params: kendo.stringify(result) }; 
                					}
                                	
                                    if (operation !== "read" && options.models) {
                                        return {models: kendo.stringify(options.models)};
                                    }
                                }
                            },
                            batch: true,
                            pageSize: 20,
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
                                model: userModel
                            },
                            change: function () {
                                viewModel.set("hasChanges", this.hasChanges());
                            }
                        }),
                        error : function(e) {
                        	console.log(e.errors);
                        	alert(e.errors);
                        },
                        batch: true,
                        selected: {},
                        hasChanges: false,
                        sync: function () {
                        	//this.dataSource.add(this.selected);
                        	console.log("validator.validate():"+validator.validate());
                            if(validator.validate()) {
                                this.dataSource.sync();
                                alert("정상적으로 처리되었습니다.");  
                                $("#searchBtn").trigger("click");
                            }
                        },
                        cancel: function () {
                            this.dataSource.cancelChanges();
                            validator.hideMessages();
                        },
                        newsync: function () {
                        	viewModel.set("selected", new userModel());
                        	this.dataSource.insert(0, this.selected);
                        },
                        remove: function () {
                        	var key = this.selected.RENT_FAULT_SEQ;
                        	var keyData = this.dataSource.get(key);
                        	if(key != null && key != ""){
                        		if(confirm("데이터를 삭제하시겠습니까")){ 
                        			this.dataSource.remove(keyData);
                        			this.dataSource.sync();
                        			grid.select("tr:eq(0)");
                        		}
                        	}else{
                        		alert("삭제 할 데이터가 없습니다.");
                        	}
                        }
                    });
                    console.log("viewModel");
                    console.log(viewModel);
                    kendo.bind($("#editForm"), viewModel);
                    validator = $("#editForm").kendoValidator().data("kendoValidator");
                	
                    var grid = $("#grid").kendoGrid({
                        dataSource: viewModel.dataSource,
                        pageable: true,
                        resizable: true,  //컬럼 크기 조절
						reorderable: true, //컬럼 위치 이동
                        height: 500,
                        columns: [
							{ field: "SUBJECT", title: "제목", width: 150 },
                            { field: "WRITER_ID", title:"작성자", width: 100 },
							{ field: "WRITE_DT", title:"작성일", width: 100
								,template: "#= (WRITE_DT == '') ? '' : kendo.toString(kendo.parseDate(WRITE_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"
							},
                            { field: "ACCEPTER_ID", title:"접수자ID", width: 100 },
                            { field: "ACCEPT_DT", title:"접수일자", width: 100 
                            	,template: "#= (ACCEPT_DT == '') ? '' : kendo.toString(kendo.parseDate(ACCEPT_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"
                            },
                            { field: "WORKER_ID", title:"처리자", width: 110 },
                            { field: "WORK_DT", title:"처리일자", width: 110 
                            	,template: "#= (WORK_DT == '') ? '' : kendo.toString(kendo.parseDate(WORK_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"
                            },
                            { field: "RESULT_STATE", title:"처리상태", width: 110 },
                            { field: "CONTENTS", title: "내용", width: 110 },
                            //{ field: "BBS_NO", title: "게시물번호", format: "{0:c}", width: 110 },
                            { field: "EQUIP_TYPE", title:"기기종류", width: 110 },
                            { field: "MODEL_NM", title:"모델명", width: 110 },
                            { field: "SERIAL_NO", title:"시리얼번호", width: 110 },
                            { field: "RESULT", title:"처리결과", width: 110 },
                            { field: "RESULT_STATE", title:"처리상태", width: 110 },
                            { field: "RENT_FAULT_SEQ", title:"SEQ", width: 110 },
                        ],
                        sortable: true,
                        selectable: true,
                        scrollable: true,
                        dataBound: function(e) {
                        	//console.log("this.dataSource this.dataSource.data()[0]");
                        	//console.log(this.dataSource);
                        	//console.log(this.dataSource.data()[0]);
                            var row = this.tbody.find(">tr[data-uid=" + viewModel.selected.uid + "]");
                            if(row) {
                                this.select(row);
                            }
                        },
                        change: function (e) {
                            var model = this.dataItem(this.select());
                            //console.log("model");
                            //console.log(model);
                            //console.log("model.rtnList");
                            //console.log(model.rtnList);
                            validator.hideMessages();
                            viewModel.set("selected", model);
                            
                            //viewModel.set("selected.EQUIP_TYPE_TEMP", model.EQUIP_TYPE);
                        }
                    }).data("kendoGrid");

                    $("#grid").data("kendoGrid").one("dataBound", function (e) {
                        this.select(this.tbody.find(">tr:first"));
                    });
                
                });
            	</script>
            	
            	<!-- editform script -->
            	<script type="text/javascript">
            	
            	
            	</script>


                  
                  
					        
					      </div>
					    </div><!-- box -->
					    
					    
					    
					    
					    
					  </div><!-- col-xs-12 -->
					</div><!-- row -->
        </section>    
        
      </div>

        
        
<%@ include file="../inc/footer.jsp" %>