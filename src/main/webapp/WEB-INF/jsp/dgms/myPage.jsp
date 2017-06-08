<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#myPage').parent().parent().addClass('active');
	$('#myPage').addClass('active');
});	
</script>

<style>

                
</style>

      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
          	<i class="fa fa-caret-right"></i>마이페이지
            <small>사용자는 자신의 정보를 조회 및 수정</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 안전서비스</a></li>
            <li class="active">마이페이지</li>
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
					<div id="example">
                        <div id="tabstrip">
                            <ul>
                                <li class="k-state-active">
                                    사용자관리
                                </li>
                                <li>
                                    초기검진소견
                                </li>
                                <li>
                                    심전도판독소견
                                </li>
                            </ul>
                            <div id="editForm">
	                            <div class="row" style="margin-top:10px;margin-left:10px;">
					            <label for="USER_ID" class="col-xs-2 control-label" style="min-width:80px;padding-right:5px;">아이디</label>
					            <input type="text" class="k-textbox" id="USER_ID" name="USER_ID" data-bind="value: dataSource.view()[0].USER_ID" readonly="readonly"/>
					            <span class="k-invalid-msg" data-for="USER_ID"></span>
					            
						        </div>
						        <div class="row" style="margin-top:10px;margin-left:10px;">
						            <label for="USER_NM" class="col-xs-2 control-label" style="min-width:80px;padding-right:5px;">성명</label>
						            <input type="text" class="k-textbox" name="USER_NM" data-bind="value: dataSource.view()[0].USER_NM" required />
						        </div>
						        <!-- 
						        <div class="row" style="margin-top:10px;margin-left:10px;">
						            <label for="CHK_LOGIN_PWD" class="col-xs-2 control-label" style="min-width:80px;padding-right:5px;">기존비밀번호</label>
						            <input type="password" class="k-textbox" name="CHK_LOGIN_PWD" data-bind="value: dataSource.view()[0].CHK_LOGIN_PWD" required validationMessage="기존비밀번호 필수입력입니다."/>
						        </div>
						         -->
						        <div class="row" style="margin-top:10px;margin-left:10px;">
						            <label for="NEW_PWD" class="col-xs-2 control-label" style="min-width:80px;padding-right:5px;">신규비밀번호</label>
						            <input type="password" class="k-textbox" name="NEW_PWD" data-bind="value: dataSource.view()[0].NEW_PWD" required validationMessage="신규비밀번호 필수입력입니다."/>
						        </div>
						        <div class="row" style="margin-top:10px;margin-left:10px;">
						            <label for="CHK_NEW_PWD" class="col-xs-2 control-label" style="min-width:80px;padding-right:5px;">비밀번호확인</label>
						            <input id="CHK_NEW_PWD" class="k-textbox" type="password" name="CHK_NEW_PWD" data-bind="value: dataSource.view()[0].CHK_NEW_PWD" required validationMessage="비밀번호확인 필수입력입니다."/>
						        </div>
						        
						        <div id="toolbartest" class="row" style="margin-top:10px;margin-left:10px;">
						        	<button class="k-button btnSave" data-bind="events: { click: sync }"><span class="k-icon k-update"></span>저장</button>
						            <button class="k-button btnCancel" data-bind="events: { click: cancel }"><span class="k-icon k-cancel"></span>취소</button>
		                			<!-- <button class="k-button btnNew" data-bind="events: { click: newsync }"><span class="k-icon k-add"></span>추가</button>
						            <button class="k-button btnRemove" data-bind="events: { click: remove }"><span class="k-icon k-delete"></span>삭제</button> -->
		                		</div>
                            </div>
                            <div>
                            	<div id="firstOpin">
			                		<div id="toolbartest">
			                			<!-- <button class="k-button btnNew" data-bind="events: { click: newsync }"><span class="k-icon k-add"></span>추가</button>
							            <button class="k-button btnSave" data-bind="events: { click: sync }"><span class="k-icon k-update"></span>저장</button>
							            <button class="k-button btnCancel" data-bind="events: { click: cancel }"><span class="k-icon k-cancel"></span>취소</button>
							            <button class="k-button btnRemove" data-bind="events: { click: remove }"><span class="k-icon k-delete"></span>삭제</button> -->
			                		</div>
			                		<div class="row">
				                		<div class="form-group" style="margin-top:10px;margin-left:10px;">
											<label  for="HOSP_NM" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">병원명:</label>
											<div class="col-xs-2">
											<input name="HOSP_NM" data-bind="value:dataSource.view()[0].HOSP_NM" type="text" class="k-textbox"/>
											</div>
											<label for="DOCTOR_NM" class="col-xs-2 control-label" style="min-width:80px;width:80px;padding-right:5px;margin-left:30px;">의사명:</label>
											<div class="col-xs-2">
											<input name="DOCTOR_NM" data-bind="value:dataSource.view()[0].DOCTOR_NM" type="text" class="k-textbox"/>
											</div>
				                		</div>
			                		</div>
			                		<div class="row">
				                		<div class="form-group" style="margin-top:10px;margin-left:10px;">
											<label for="CHECKUP_DT" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">검진일:</label>
											<div class="col-xs-2">
											<input id="checkup_dt" name="CHECKUP_DT" data-bind="value:dataSource.view()[0].CHECKUP_DT" type="text"/> 
											</div>
											<label for="OPINION_WRITER" class="col-xs-2 control-label" style="min-width:80px;width:80px;padding-right:5px;margin-left:30px;">등록자:</label>
											<div class="col-xs-2">
											<input name="OPINION_WRITER" data-bind="value:dataSource.view()[0].OPINION_WRITER" type="text" class="k-textbox"/> 
											</div>
				                		</div>
				                	</div>
			                		<div class="row">
				                		<div class="form-group" style="margin-top:10px;margin-left:10px;">
											<label for="OPINION" class="col-xs-2 control-label" style="min-width:80px;padding-right:5px;">초기검진소견:</label>
											<div class="col-xs-11">
											<textarea id="OPINION" name="OPINION" data-bind="value:dataSource.view()[0].OPINION" required rows="5" class="k-textbox" style="width: 100%"></textarea>
											<input type="hidden" name="CHECKUP_SEQ" data-bind="value:dataSource.view()[0].CHECKUP_SEQ"/>
											<input type="hidden" name="USER_ID" data-bind="value:dataSource.view()[0].USER_ID">
				                			
				                			<input type="hidden" name="CHECKUP_DT" data-bind="value:dataSource.view()[0].CHECKUP_DT" type="text"/>  
											</div>
				                		</div>
				                	</div>
			                	</div><!-- firstOpin -->
                            </div>
                            <div>
                            	<div id="ecrOpin">
			                		<div id="toolbartest">
			                			<!-- <button class="k-button btnNew" data-bind="events: { click: newsync }"><span class="k-icon k-add"></span>추가</button>
							            <button class="k-button btnSave" data-bind="events: { click: sync }"><span class="k-icon k-update"></span>저장</button>
							            <button class="k-button btnCancel" data-bind="events: { click: cancel }"><span class="k-icon k-cancel"></span>취소</button>
							            <button class="k-button btnRemove" data-bind="events: { click: remove }"><span class="k-icon k-delete"></span>삭제</button> -->
			                		</div>
			                		<div class="row">
				                		<div class="form-group" style="margin-top:10px;margin-left:10px;">
											<label  for="HOSP_NM_ECR" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">병원명:</label>
											<div class="col-xs-2">
											<input name="HOSP_NM_ECR" data-bind="value:dataSource.view()[0].HOSP_NM_ECR" type="text" class="k-textbox"/>
											</div>
											<label for="DOCTOR_NM_ECR" class="col-xs-2 control-label" style="min-width:80px;width:80px;padding-right:5px;margin-left:30px;">의사명:</label>
											<div class="col-xs-2">
											<input name="DOCTOR_NM_ECR" data-bind="value:dataSource.view()[0].DOCTOR_NM_ECR" type="text" class="k-textbox"/>
											</div>
				                		</div>
			                		</div>
			                		<div class="row">
				                		<div class="form-group" style="margin-top:10px;margin-left:10px;">
											<label for="CHECKUP_DT_ECR" class="col-xs-1 control-label" style="min-width:80px;padding-right:5px;">검진일:</label>
											<div class="col-xs-2">
											<input id="checkup_dt_ecr" name="CHECKUP_DT_ECR" data-bind="value:dataSource.view()[0].CHECKUP_DT_ECR" type="text"/> 
											</div>
											<label for="OPINION_WRITER_ECR" class="col-xs-2 control-label" style="min-width:80px;width:80px;padding-right:5px;margin-left:30px;">등록자:</label>
											<div class="col-xs-2">
											<input name="OPINION_WRITER_ECR" data-bind="value:dataSource.view()[0].OPINION_WRITER_ECR" type="text" class="k-textbox"/> 
											</div>
				                		</div>
				                	</div>
			                		<div class="row">
				                		<div class="form-group" style="margin-top:10px;margin-left:10px;">
											<label for="OPINION_ECR" class="col-xs-2 control-label" style="min-width:80px;padding-right:5px;">심전도판독소견:</label>
											<div class="col-xs-11">
											<textarea id="OPINION_ECR" name="OPINION_ECR" data-bind="value:dataSource.view()[0].OPINION_ECR" required rows="5" class="k-textbox" style="width: 100%"></textarea>
										 
											</div>
				                		</div>
				                	</div>
			                	</div><!-- ecrOpin  -->
                            </div>
                        </div>
                    </div>

            


			<script type="text/javascript">
			
			
			
			var G_AreaCdVal;//조회조건 : 관리기관코드
			var G_AreaIdVal = "${userStore.areaId}";	//조회조건 : 관리기관
			var G_UserNmVal = "${userStore.fullname}";	//조회조건 : 사용자명
			var G_UserId = "${userStore.username}";		//조회조건 : 사용자ID
			
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
			</script>
			
            <script>
                $(document).ready(function() {
                	
                	$("#firstOpin input, #firstOpin textarea").prop("disabled", true);
                	$("#ecrOpin input, #ecrOpin textarea").prop("disabled", true);
                	
                    $("#tabstrip").kendoTabStrip({
                        animation:  {
                            open: {
                                effects: "fadeIn"
                            }
                        }
                    });
                    
                    $("#checkup_dt").kendoDatePicker({
                        culture: "ko-KR",
                        mask: "0000/00/00",
                        // display month and year in the input
                        format: "yyyy-MM-dd",
                        parseFormats: ["yyyyMMdd"],
                       	change: function () {
                       		var checkup_dt = kendo.toString(this.value(), "yyyyMMdd");
                        	viewUserModel.dataSource.at(0).set("CHECKUP_DT", checkup_dt);
                       	}
                    });
                    
                    $("#checkup_dt_ecr").kendoDatePicker({
                        culture: "ko-KR",
                        mask: "0000/00/00",
                        // display month and year in the input
                        format: "yyyy-MM-dd",
                        parseFormats: ["yyyyMMdd"],
                       	change: function () {
                       		var checkup_dt_ecr = kendo.toString(this.value(), "yyyyMMdd");
                        	viewUserModel.dataSource.at(0).set("CHECKUP_DT_ECR", checkup_dt_ecr);
                       	}
                    });
                    
                    
                    
                  	//사용자정보
                	var validator;
               	 
	               	var userModel = kendo.data.Model.define({
		               	id:"USER_SEQ",//id 로 insert할건지 update 할건지 판단함.
						fields: {
							USER_SEQ:{ validation: { required: true } },
							USER_ID: { validation: { required: true } },
							USER_NM:{ validation: { required: true } },
							LOGIN_PWD: { type: "string", },
							//CHK_LOGIN_PWD: { type: "string", validation: { required: true } },
							AREA_ID:{ },
							NEW_PWD:{ validation: { required: true } },
							CHK_NEW_PWD: { validation: { required: true } },
							ADDR_CIGUNGU: { },
							MOD_DT : { type: "string" },
							
							HOSP_NM:{ type: "string" },
							MEASURE_DT: { type: "string" },
							DOCTOR_NM: { type: "string" },
							CHECKUP_DT: { type: "string" },
							OPINION_WRITER: { type: "string" },
							OPINION: { type: "string" },
							
							HOSP_NM_ECR:{ type: "string" },
							MEASURE_DT_ECR: { type: "string" },
							DOCTOR_NM_ECR: { type: "string" },
							CHECKUP_DT_ECR: { type: "string" },
							OPINION_WRITER_ECR: { type: "string" },
							OPINION_ECR: { type: "string" },
						}  
               	    });
                	 
                	var crudServiceBaseUrl = "<c:url value='/dgms'/>";
                	var viewUserModel = kendo.observable({
                		dataSource: new kendo.data.DataSource({
               		  	batch: true,
               		  	transport: {
	               		  	read:  {
								url: crudServiceBaseUrl + "/selectMyPageInfo.do",
		            			dataType: "jsonp"
							},
							update: {
								url: crudServiceBaseUrl + "/updateMyPageInfo.do",
								dataType: "jsonp"
							},
							/* 
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
										USER_ID: G_UserId,
										AREA_ID: G_AreaIdVal
									};
	                               	console.log("G_UserId",G_UserId)
									return { params: kendo.stringify(result) }; 
								}
	                           
								if (type !== "read" && data.models) {	
									//console.log(data);
									//console.log(data.models);
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
	               			  model: userModel
	               		  },
	                      
	                      change : function(e) {
	                    	  viewUserModel.set("hasChanges", this.hasChanges());
	                    	  
	                      },  	
	                    }), //end dataSource
	                    
	                    selected: {},
	                    hasChanges: false,
	               		error : function(e) {
	                      	console.log(e.errors);
	                      	alert(e.errors);
	                    },
	                    sync: function(e) {
	                    	//console.log("validator.validate():"+validator.validate());
	                    	console.log("e:", e);
	                    	//var loginPwd = this.dataSource.at(0).LOGIN_PWD;
	                    	//var chkLoginPwd = this.dataSource.at(0).CHK_LOGIN_PWD;
	                    	var newPwd = this.dataSource.at(0).NEW_PWD;
	                    	var chkNewPwd = this.dataSource.at(0).CHK_NEW_PWD;
	                    	//console.log(loginPwd, chkLoginPwd, newPwd, chkNewPwd);
	                    	
	                    	if(validator.validate()) {
	                    		/* if(loginPwd != chkLoginPwd){
		                    		alert("기존비밀번호가 틀렸습니다."); return;
		                    	}else  */
		                    	if(newPwd != chkNewPwd){
		                    		alert("신규비밀번호를 다시 확인하세요."); return;
		                    	}
	                    		
	                    		this.dataSource.sync();
	                    		alert("정상적으로 처리되었습니다.");  
	                    		viewUserModel.dataSource.read();
	                    	}
							
					  	},
					  	cancel: function () {
                            this.dataSource.cancelChanges();
                            validator.hideMessages();
                        },/* 
                        newsync: function () {
                        	viewUserModel.set("selected", new userModel());
                        	//bbsSeq 
                        	this.dataSource.insert(0, this.selected);
                        }, 
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
                        	
                        }
                        */
				  	
                	});	//viewUserModel = kendo.observable
                	
                	viewUserModel.dataSource.read().then(function (){
                		kendo.bind($("#example"), viewUserModel);
						//console.log(viewUserModel, viewUserModel.dataSource)
						validator = $("#example").kendoValidator().data("kendoValidator");
						//dataSourceDetail.read();
					});
                	
                	
                }); //end ready
            </script>


                  
                  
					        
			    </div>
			  </div><!-- box -->
			    
			    
			    
			    
			    
			  </div><!-- col-xs-12 -->
			</div><!-- row -->
        </section>    
        
      </div>
        
        
<%@ include file="../inc/footer.jsp" %>