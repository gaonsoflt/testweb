<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../inc/header.jsp" %>
<%@ include file="../../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#systemMgrUser').parent().parent().addClass('active');
	$('#systemMgrUser').addClass('active');
});	
</script>

      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>사용자관리
            <small>사용자를 관리합니다.</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 시스템관리</a></li>
            <li class="active">사용자관리</li>
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

				<p style="font-size: 15px; padding:10px 0px;">
				사용자 검색:&nbsp;&nbsp;&nbsp;&nbsp;<input id="in_user" />&nbsp;&nbsp;&nbsp;
				<button id="searchBtn" type="button">조회</button>
				</p>
			
				<script>
				var G_UserNmVal;//조회조건 : 사용자명
				var codelist = "_USER_TYPE_";
				var codeModels="";
				
 
					$.ajax({
						type: "post",
						url: "<c:url value='/dgms/getCodeListByCdIDModel.do'/>",
						data: {"list" : codelist},
						async: false, //동기 방식
						success: function(data,status){
							//codeModels = $.extend(codeModels, data.rtnList);
							codeModels = data.rtnList;
							console.log(codeModels);
						},
						fail: function(){
							console.log("error: getCodeListByCdIDModel");
						},
						complete: function(){
							console.log(codeModels);
						}
					});

				function fnCodeNameByCdID(code){
					var rtnVal = "";
					for (var i = 0; i < codeModels.length; i++) {
			            if (codeModels[i].cd_id == code) {
			            	rtnVal = codeModels[i].cd_nm;
			            }
			        }
					return rtnVal;
				}
				
				function fnCodeNameByCd(code){
					var rtnVal = "";
					for (var i = 0; i < codeModels.length; i++) {
			            if (codeModels[i].cd == code) {
			            	rtnVal = codeModels[i].cd_nm;
			            }
			        }
					return rtnVal;
				}
				
				$(function() {
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
							var gridDetail = $("#gridDetail").data("kendoGrid");
							gridDetail.dataSource.read();
						}
					});
				});
				</script>
				
				<div id="gridDetail"></div>
				<script>
				var cancelFalg = false;
								
                $(document).ready(function () {

					/*************************/
                	/* dataSource gridDetail */
                	/*************************/
                    var crudServiceBaseUrl = "<c:url value='/sm/user'/>",
                    /*** dataSource ***/
					dataSourceDetail = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/read.do",
		            			dataType: "jsonp"
							},
							update: {
								url: crudServiceBaseUrl + "/update.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/delete.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/create.do",
								dataType: "jsonp" 
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										G_UserNmVal: G_UserNmVal
									};
									return { params: kendo.stringify(result) }; 
								}
                               
								if (type !== "read" && data.models) {	
									return { models: kendo.stringify(data.models) };
								}
							}
						},//transport end...
						schema: {
							data: function(response) {
								console.log(response.rtnList);
								return response.rtnList;
							},
							total: function(response) {
								return response.total;
							},
							errors: function(response) {
								return response.error;
							},
							model:{//가져온 값이 있음...
								id:"user_seq",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									user_seq: { 
										type: "string" //data type of the field {Number|String|Boolean|Date} default is String
										//defaultValue: 42,
										//validation: { required: true, min: 1 }
									},
									user_type: { 
										type: "string",
										defaultValue: "100025"
									}, 
									user_name: {
										type: "string",
										validation: { required: true } 
									},
									user_id: { 
										type: "string", 
										validation: { required: true } 
									},
									password: { 
										type: "string",
										validation: { required: true } 
									},
									birthday: {
										editable: true,
										validation: { required: true } 
									},
									use_yn: { 
										type: "boolean", 
										defaultValue: true
									},
									phone: {
										type: "string"
									},
									note : { 
										type: "string", 
										editable: true
									},
									cre_usr : { 
										type: "string", 
										editable: false,
										defaultValue: "${userStore.username}"
									},
									mod_usr : { 
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
                        requestStart: function(e) {
                        },
                        requestEnd: function(e) {
                        	//if(cancelFalg){
						    //    var dataItem = dataSourceDetail.at(0);
						    //    dataSourceDetail.remove(dataItem);
                        	//}
                        },
                        sync: function(e) { 
                        	//if(cancelFalg){
					        //	e.preventDefault();
					        //	e.stopPropagation();
					        //	cancelFalg = false;
                        	//}
					        //e.stopPropagation();
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
						height: 712,
						toolbar: [
						    { name: "create", text: "추가" },
						   // { name: "save", text: "저장" },
						   // { name: "cancel", text: "취소" },
						    { name: "excel", text: "엑셀" }
						    /* { name: "pdf", text: "PDF" }, */
						],
						messages: {
							commands: {
								canceledit: "취소",
								update: "저장"
							}
						},
						columns: [
							{
								field: "user_type",
								title: "사용자구분",
								attributes: {style: "text-align: center;"},
								width:120,
								editor: function (container, options) { 
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoDropDownList({
			                            autoBind: true,
			                            dataTextField: "cd_nm",
			                            dataValueField: "cd_id",
			                            dataSource: {
											transport: {
			        							read: {
			        								url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
			        								dataType: "jsonp"
			        							},
			        							parameterMap: function(data, type) {
			        								var result = {
			        										CD_ID: "_USER_TYPE_",
			        										USE_YN: "1"
			        	                            };
			        								return { params: kendo.stringify(result) }; 
			        							}
			        						}
			                            },
			                            change: function() { },
			                            dataBound: function(e) {
		    								$(".k-list-container").css("width", "100px");
			                            }
									});
								},
								template: "#=fnCodeNameByCdID(user_type)#"
							},  
							{
								field: "user_name",
								title: "이름",
								attributes: {style: "text-align: center;"},
								validation: { required: true, min: 1},
								width: 90
							},
							{
								field: "user_id",
								title: "아이디",
								validation: { required: true, min: 1},
								attributes: {style: "text-align: center;"}, 
								width: 110
							},   
							{
								field: "password",
								title: "비밀번호",
								attributes: {style: "text-align: center;"},
								width: 110,
								editor: function (container, options) { 
									 $('<input type="password" class="k-textbox" name="' + options.field + '"/>')
				                    .appendTo(container);
								}
								//,template: "#: LOGIN_PWD == null ? ' ' : '●'.repeat( LOGIN_PWD.length) #"
							},
							{
								field: "birthday",
								title: "생년월일",
								attributes: {style: "text-align: center;"},
								width: 120,
								editor: function (container, options) { 
									 $('<input name="' + options.field + '"/>')
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
			                            	options.model.set("birthday", selectDate);
			                            } 
			                        });
			                    },
								template: "#= (birthday == '') ? '' : kendo.toString(kendo.parseDate(birthday, 'yyyyMMdd'), 'yyyy-MM-dd') #"
							},
							{
								field: "phone",
								title: "연락처",
								attributes: {style: "text-align: center;"},
								width: 140 
								,template: "#= phone == null ? '' : phone.substring(0,3) + '-' + phone.substring(3,7) + '-' + phone.substring(7) #"
							}, 
							{
								field: "user_seq",
								title: "사용자SEQ",
								hidden: true,
								attributes: {style: "text-align: center;"},
								//hidden: true,
								//attributes
								width: 70
							}, 
							{
								field: "note",
								title: "설명",
								attributes: {style: "text-align: left;"},
								width: 300
							},   
							{
								field: "use_yn",
								title: "사용여부", 
								attributes: {style: "text-align: center;"},
								width: 110
							},
							{
								title: "관리",
								attributes: {style: "text-align: center;"},
								command: [
								          { name: "edit", text: "수정" },
								          { name: "destroy", text: "삭제" }
								          ],
								width: 160
							}
						],
 						editable: {
 							mode:  "inline",
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
							if(e.model.isNew()){
                        		var uid = dataSourceDetail.at(0).user_id;
    							var parameters = {'TABLE': 'TB_USER_INFO', 'COLUMN1' : 'USER_ID', 'DATA1' : uid }; 
    							$.ajax({
    								type: "post",
    								url: "<c:url value='/dgms/getDuplicateCount.do'/>",
    								async: false,  
    							    data: parameters,	
    								success: function(data,status){
    									if(data.cnt > 0){
    										alert("동일한 아이디가 존재합니다.");
    								        e.preventDefault();
    								        cancelFalg = true;
    								        dataSourceDetail.cancelChanges(); 
    									}
    								},
    								fail: function(){}
    							});
                        	}//if
						
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
							var uid = dataSourceDetail.at(0).user_id;
							var upw = dataSourceDetail.at(0).password;
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
						edit: function(e) {
						    if (!e.model.isNew()) {
						    	$("input[name=user_id]").attr({"readonly":true});
						    	$("input[name=user_id]").css({"background":"#ccc", "text-align":"center"});
						    }
							/*** Key 채번 ***/
			 				if (e.model.isNew() && ( dataSourceDetail.at(0).user_seq == null || dataSourceDetail.at(0).user_seq == "") ) {
 								var url = "<c:url value='/dgms/getSequence.do'/>";
								var parameters = {'SEQ_NM': "SEQ_USER_INFO"};
								$.post(url, parameters, function(data) {
									dataSourceDetail.at(0).set("user_seq", data.Sequence);
								}); 
								
								var grid = this;
								grid.select("tr:eq(0)");

							}
			 				else
			 				{
								/* Disable the editor of the "id" column when editing data items */
								$('input[name=user_seq]').parent().html(e.model.user_seq);

			 				}
						},
						dataBound: function(e) {
							invokeUserAuth($("#gridDetail"), "kendoGrid");
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
      
<!-- custome style -->      
<style>
	.k-grid td{
				white-space: nowrap;
				text-overflow: ellipsis;
	}

	#gridDetail .k-grid-content{ 
				overflow-x: auto;
	}
	
	#gridDetail table th{text-align:center;}
</style>        
<!-- custome script -->
<script>
	
</script>
<%@ include file="../../inc/footer.jsp" %>