<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#checkNotice').parent().parent().addClass('active');
	$('#checkNotice').addClass('active');
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
            <i class="fa fa-caret-right"></i>공지사항관리
            <small>공지사항을 관리합니다</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 게시물관리</a></li>
            <li class="active">공지사항관리</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
        	<div class="row">
          	<!-- 내용 -->
          	<div class="col-xs-12">
            
              <!-- table 하나 -->
              <div class="box">
                <div class="box-body">
				<p style="font-size: 15px; padding:10px 0px;"> 
					검색:&nbsp;&nbsp;&nbsp;
					<input id="in_search" />&nbsp;&nbsp;&nbsp;
				    <input id="in_keyword" />&nbsp;&nbsp;&nbsp;
					<button id="searchBtn" type="button">검색</button>
				</p>

										
				<script> 
				
				
				</script>

                  
				<div id="splitter" style="height:523px">
					<!-- <div id="gridMaster"></div> -->
					<div id="grid">  
					</div>
						<div class="toolbartest bttb">  
						</div> 
					
					<div id="editForm"> 
						<div style="margin :60px auto auto auto; width:80%;">
							<div class="row" style="margin-top:10px;margin-left:10px;">
								<div class="col-xs-5">    
									<label for="AREA_GB" class="col-xs-1 control-label" style="min-width:100px; padding-right:5px;">지역</label>
						            <input id="AREA_GB" name="AREA_GB" data-bind="value: selected.AREA_GB" readonly required /> 
								</div> 
								<div class="col-xs-5" >
									<label for="NOTICE_SQ" class="col-xs-1 control-label" style="min-width:100px; padding-right:5px;">공지번호</label> 
									<input type="text" id="NOTICE_SQ" class="k-textbox col-xs-2" name="NOTICE_SQ" readonly data-bind="value: selected.NOTICE_SQ" readonly />
									<span class="k-invalid-msg" data-for="NOTICE_SQ"></span>
								</div>
							</div> 
							<div class="row" style="margin-top:10px;margin-left:10px; display:none;">
								<div class="col-xs-5" >
									<label for="REG_USER_SQ" class="col-xs-1 control-label" style="min-width:100px; padding-right:5px;">작성자</label> 
						            <input id="REG_USER_SQ" name="REG_USER_SQ" data-bind="value: selected.REG_USER_SQ" required readonly readonly="readonly"/>
								</div>
								<div class="col-xs-5" >
									<label for="REG_DT " class="col-xs-1 control-label" style="min-width:100px; padding-right:5px;">작성일</label>
									<input id="REG_DT" type="text" name="REG_DT" data-bind="value: selected.REG_DT" required readonly />
								</div>
							</div> 
							<!-- 
							 <div class="row" style="margin-top:10px;margin-left:10px;">
								<div class="col-xs-5" > 
									<label for="START_DT" class="col-xs-1 control-label" style="min-width:100px;  padding-right:5px;">공지시작일</label>
									<input id="START_DT" type="text" name="START_DT" data-bind="value: selected.START_DT" readonly required />
								</div>
								<div class="col-xs-5" > 
									<label for="END_DT" class="col-xs-1 control-label" style="min-width:100px;  padding-right:5px;">공지종료일</label>
									<input id="END_DT" type="text" name="END_DT" data-bind="value: selected.END_DT" readolny required />
								</div>
							</div>  
							-->
							<div class="row" style="margin-top:10px;margin-left:10px;">
								<div class="col-xs-5 w10" >    
									<label for="TITLE" class="col-xs-1 control-label" style="min-width:100px; padding-right:5px;">제목</label>
									<input type="text" id="TITLE" class="k-textbox col-xs-2" name="TITLE" data-bind="value: selected.TITLE" readonly required />
								</div>
							</div>
							<div class="row" style="margin-top:10px;margin-left:10px;">
								<div class="col-xs-11" >     
									<textarea class="k-textbox" rows="25" style="width: 100%; height:300px;" id="editor" name="CONTENT" data-bind="value: selected.CONTENT" required></textarea>
									<div id="fileWrapper"><!-- <input name="files" id="files" type="file" /> --></div>
								</div>
							</div>
						</div>
						<div class="toolbartest bttb2">  
						</div> 
					</div><!-- editForm -->     
					
					<!-- <div id="gridDetail"></div> -->
                </div>


				<script>  
					/*기본 데이터****************************************************************************************************/
					var G_AreaIdVal = "${userStore.areaId}"; 
					var G_Admin = "${userStore.userseq}";  
					var G_UserNm = "${userStore.fullname}";
					var G_Search = "";
					var G_Keword = "";
					

					/*검색 셋팅****************************************************************************************************/
					var searchData = [ 
						{ text: "전체", value: "ALL" },
						{ text: "이름", value: "USER_NM" },
						{ text: "제목", value: "TITLE" },
						{ text: "내용", value: "CONTENT" }
					];

					$("#in_search").kendoComboBox({ 
						dataTextField: "text",
						dataValueField: "value",
						dataSource: searchData,   
						change: function(e){
							G_Search = this.value();
						},
						index: 0
					}); 
					
					/* 키워드 */
					$("#in_keyword").kendoMaskedTextBox({ 
						change: function(e) {
							G_Keword = this.value();
						}
					});

					/* 조회 */
					$("#searchBtn").kendoButton({
						icon: "search",
						click: function(e) {
							var gridDetail = $("#grid").data("kendoGrid");
							gridDetail.dataSource.read();
						}
					});
					

					/*에디터****************************************************************************************************/
        			$("#editor").kendoEditor({
                        tools: [  
                        ], 
                        imageBrowser: {
                            messages: { 
                            },
                            transport: {
                                 read: {
             						url: "/editor/imgRead.do",
                     				dataType: "jsonp",
                                    type: "GET" 
                                 },
                                 destroy: {
                                     url: "/editor/destroy.do",
                                     type: "GET"
                                 },
                                 create: {
                                     url: "/editor/create.do",
                      				 dataType: "jsonp",
                                     type: "GET"
                                 },
                                 select: function () {
                                 },
                                 thumbnailUrl: "/image_thumbnail.jsp",
                                 uploadUrl: "/editor/upload.do", 
                                 imageUrl: "/upload/{0}"
                            }
                         }, 
                        fileBrowser: {
                            messages: {
                                dropFilesHere: "Drop files here"
                            },
                            transport: {
                                read:  {
             						url: "/editor/fileRead.do",
                     				dataType: "jsonp",
                                    type: "GET" 
                                },
                                destroy: {
                                    url: "/editor/destroy.do",
                                    type: "POST"
                                }, 
                                create: {
                                    url: "/editor/create.do",
                     				dataType: "jsonp",
                                    type: "GET"
                                },
                                uploadUrl: "/editor/upload.do",
                                fileUrl: "/upload/{0}"
                                //fileUrl: "/kendo-ui/service/FileBrowser/File?fileName={0}"
                            }
                        },
                        change: function () {
                            console.log(this.value());
                        }
                    });
					
 
					/*툴바 셋팅    ***************************************************************************************************/
					$("#toolbartest").kendoToolBar({});
				 


					$(document).ready(function () { 

                	var validator;
                    
					/*모델  ***************************************************************************************************/
                    var noticeModel = kendo.data.Model.define({
                    	id: "NOTICE_SQ",
                        fields: { 
							AREA_GB: { 
								defaultValue: G_AreaIdVal	 
							}, //editable: false, nullable: true 
							NOTICE_SQ: {  },
							TITLE: {  },
							CONTENT: {  },
							REG_DT: {  
								validation: { required: true } 
								,defaultValue: kendo.toString(new Date(), "yyyyMMdd") 
							},
							REG_USER_SQ: { 
								defaultValue: G_Admin 
							},
							USER_NM: { 
								defaultValue: G_UserNm 
							},
							MOD_DT: { 
								validation: { required: true },
								defaultValue: kendo.toString(new Date(), "yyyyMMdd")
							},
							MOD_USER_SQ: { 
								defaultValue: G_Admin 
							},
							START_DT: { 
								validation: { required: true },
								defaultValue: kendo.toString(new Date(), "yyyyMMdd")
							},
							END_DT: { 
								validation: { required: true },
								defaultValue: kendo.toString(new Date(), "yyyyMMdd")
							}  
                        }
                    });
                    
					/*그리드 데이터   ***************************************************************************************************/
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>";
					var RegUserSQ="${userStore.userseq}", NoticeSQ, fileSQ;
					
					
                    var viewModel = kendo.observable({
                        dataSource: new kendo.data.DataSource({
                            transport: {
                                read:  {
                                	url: crudServiceBaseUrl + "/selectNoticeInfoJsonp.do",
    		            			dataType: "jsonp",
    		            			complete: function(e){ 
    		            				console.log("selectNoticeInfoJsonp...................");
    		            			}
                                },
                				update: {
                					url: crudServiceBaseUrl + "/updateNoticeInfo.do",
                					dataType: "jsonp"
                				},
                				destroy: {
                					url: crudServiceBaseUrl + "/deleteNoticeInfo.do",
                					dataType: "jsonp"
                				},
                				create: {
                					url: crudServiceBaseUrl + "/insertNoticeInfoJsonp.do",
                					dataType: "jsonp",
									complete: function(e){   
    		            				console.log("insertNoticeInfoJsonp...................");
    		            				$("#grid").data("kendoGrid").dataSource.read();
    		    						myWindow.data("kendoWindow").close(); 
									}
                                },
                                parameterMap: function(options, operation) {
    								if (operation == "read"){
    										console.log("read>>>");
    										var result = {
    											PAGESIZE: options.pageSize,
    											SKIP: options.skip,
    											PAGE: options.page,
    											TAKE: options.take,
    											G_AreaIdVal: G_AreaIdVal, 
    											G_Search: G_Search,
    											G_Keword: G_Keword
    										}; 
    										return { params: kendo.stringify(result) }; 
    								}

    								if (operation !== "read" && options.models) {
    										console.log("not read>>>");
    									return {models: kendo.stringify(options.models)};
    								}
                                }
                            },
                            batch: true,
                            pageSize: 15,
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
                                model: noticeModel,
                                parse: function(response) { 
                                	var list = response.rtnList;

                                	if(typeof list != "undefined"){
	                                    $.each(list,function(idx,elem) {
	                                    	//날짜...String만 포맷변경이 KENDO UI 에서는 되므로...하드코딩
	                                    	var sysdate = new Date(elem.REG_DT);
	                                    	var year = sysdate.getFullYear();
	                                    	var month = (sysdate.getMonth()+1);
	                                    	var day = sysdate.getDate();
	                                    	sysdate = year +""+ (month > 9 ? month : "0" + month) +""+ (day>9 ? day : "0" + day);
	                                    	
	                                    	elem.REG_DT = sysdate;
	                                    	
	                                    	
	                                    	var sysdate = new Date(elem.START_DT);
	                                    	year = sysdate.getFullYear();
	                                    	month = (sysdate.getMonth()+1);
	                                    	day = sysdate.getDate();
	                                    	sysdate = year +""+ (month > 9 ? month : "0" + month) +""+ (day>9 ? day : "0" + day);
	                                    	
	                                    	elem.START_DT = sysdate; 
	                                    	
	
	                                    	sysdate = new Date(elem.END_DT);
	                                    	year = sysdate.getFullYear();
	                                    	month = (sysdate.getMonth()+1);
	                                    	day = sysdate.getDate();
	                                    	sysdate = year +""+ (month > 9 ? month : "0" + month) +""+ (day>9 ? day : "0" + day);
	
	                                    	elem.END_DT = sysdate; 
	                                    	
	                                    	//수정자
	                                    	elem.MOD_USER_SQ = G_Admin;
	                                    });
                                	}
 
                                    return response
                                }  
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
                        selected: function(){},
                        hasChanges: false,
                        sync: function () {
                        	console.log("validator.validate():"+validator.validate());
                        	
                            if(validator.validate()) {
                                this.dataSource.sync();
                                alert("정상적으로 작성되었습니다."); 
    							$("#grid").data("kendoGrid").dataSource.read();
    							setTimeout(function(){myWindow.data("kendoWindow").close()}, 100);
                            } 
                        },
						close: function(){ 
							myWindow.data("kendoWindow").close();
							$('#grid').data('kendoGrid').dataSource.read();
							$('#grids').data('kendoGrid').refresh();
						},
                        cancel: function () {
                            this.dataSource.cancelChanges();
                            validator.hideMessages();
                        },
                        newsync: function () { 
                        	viewModel.set("selected", new noticeModel());
                        	this.dataSource.insert(0, this.selected); 
                        } 
                    });
                    console.log("viewModel");
                    console.log(viewModel);
                    kendo.bind($("#editForm"), viewModel);
                    validator = $("#editForm").kendoValidator().data("kendoValidator");
                	
					
					/*그리드    ***************************************************************************************************/
                    var grid = $("#grid").kendoGrid({
                        dataSource: viewModel.dataSource,
                        pageable: true,
                        resizable: true,  //컬럼 크기 조절
						reorderable: true, //컬럼 위치 이동
                        height: 552,
                        columns: [
                            { field: "RNUM", title:"번호", width: 80
								,attributes: {style: "text-align: center;"}
                            },
							{ field: "AREA_GB", title: "지역", width: 400, hidden:true },
                            { field: "NOTICE_SQ", title:"공지번호", hidden:true},
							{ field: "TITLE", title:"제목", width: 400
								,attributes: {style: "text-align: left;"}
                            }, 
                            { field: "START_DT", title:"공지시작일", width: 100
								,attributes: {style: "text-align: center;"}
                            	,template: "#= (START_DT == '') ? '' : kendo.toString(kendo.parseDate(START_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #" 
                            },
                            { field: "END_DT", title:"공지종료일", width: 100
								,attributes: {style: "text-align: center;"}
                            	,template: "#= (END_DT == '') ? '' : kendo.toString(kendo.parseDate(END_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #" 
                            },
                            { field: "USER_NM", title:"작성자", width: 90
								,attributes: {style: "text-align: center;"}
                            },
                            { field: "CONTENT", title:"내용", hidden:true},
                            { field: "REG_DT", title:"작성일", width: 90
								,attributes: {style: "text-align: center;"}
                            	,template: "#= (REG_DT == '') ? '' : kendo.toString(kendo.parseDate(REG_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"  
                            }, 
                            { field: "REG_USER_SQ", title:"작성자", hidden:true },
                            { field: "MOD_DT", title:"수정일",  hidden:true 
                            	//,template: "#= (MOD_DT == '') ? '' : kendo.toString(kendo.parseDate(MOD_DT, 'yyyyMMdd'), 'yyyy-MM-dd') #"
                            },
                            { field: "MOD_USER_SQ", title:"수정자", width: 100  , hidden:true
                           	}
                        ],
                        sortable: true,
                        selectable: "row",
                        scrollable: true,
                        dataBound: function(e) { 
                            var row = this.tbody.find(">tr[data-uid=" + viewModel.selected.uid + "]");
                            if(row) {
                                this.select(row);
                            }
                        },
                        change: function (e) {
                            var selected = this.select();
                            var model = this.dataItem(this.select()); 
                            validator.hideMessages();	
                            
                            //읽기
                            if(selected.length> 0 && model.NOTICE_SQ !="" && model.NOTICE_SQ != null && model.RNUM != null){ 
                          		//삭제버튼 숨김
                          		$(".btnRemove").css("display","inline-block");
                          		
                            	//단순출력
    							var gird = $("#grid").data("kendoGrid");
                           		var dataItem = grid.dataItem(grid.select());
                           		var index = viewModel.dataSource.indexOf(dataItem);
    	                        NoticeSQ = viewModel.dataSource.at(index).get("NOTICE_SQ");
    	                        
    	                      	$("#files").data("kendoUpload").destroy();
    	                      	$("#fileWrapper").empty();
    	                      	
    							//파일정보
    							var parameters = {'NOTICE_SQ': NoticeSQ};
    							$.ajax({
    							    url: "<c:url value='/editor/loadFiles.do'/>",	// 요청 할 주소
    							    async: false, 									// false 일 경우 동기 요청으로 변경
    							    type: 'POST',									// GET, PUT
    							    data: parameters,								// 전송할 데이터
    							    success: function(data) {
    							    	if(data != null && data != ""){ 
    								    	loadFiles = JSON.parse( data );  
    							    	}else{
    							    		loadFiles = "";
    							    	}
								    	createUpload(); 
										/*var str = "";
										for(key in obj) {
											str += key+"="+obj[key]+"\n";
										}

										alert(str);
										*/
			                        	//e.data = { FILE_SQ : e.files.FILE_SQ };
    							    } 
    							});

    							//파일 다운로드 처리
    							$('.k-file').each(function(index){
    							    //alert(index + ': ' + $(this).text());
    							    
    							    
    							    //data 0:FILE_SQ	1:FILE SNAME	2:FILE NAME
    							    var data = ($(this).find(".k-filename").text()).split(',');
    							    var downPath = "<c:url value='/editor/downloadFiles.do?RN=" + data[1] + "&SN=" + data[2] + "' />";
    							    var inData = '<a href="' + downPath + '">'+data[2]+'</a>';

    							    $(this).find(".k-button").attr("fsq", data[0]);
    							    $(this).find(".k-filename").attr("title", data[2]);
    							    $(this).find(".k-filename").html(inData);
    							    
									var obj = $("#files").data("kendoUpload").options.files;
									//for(var i = 0; i<obj.length; i++){
										obj[index].name = data[2];
										obj[index].FILE_SQ = data[0];
							    	//}
    							  });
    							
    							$(".k-upload-status").remove();
    							$(".k-dropzone").css("padding", "0px");
    							$(".k-upload-button").css("display", "none");
    							$($('#editor').data().kendoEditor.body).attr('contenteditable', false);
    							
    							//에디터 출력
								myWindow.data("kendoWindow").open();
								myWindow.parent().css("top", "110px");
								myWindow.parent().css("left", "290px");
								myWindow.parent().css("margin-bottom", "100px");
                            }
	                        viewModel.set("selected", model);  
                        }
                    }).data("kendoGrid");
                    
					/*1.데이터 초기화****************************************************************************************************/
                	
					// 지역
					$("#AREA_GB").kendoComboBox({
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
    										USE_YN: "1", 
											AREA_ID: G_AreaIdVal
		                            }; 
									return { params: kendo.stringify(result) }; 
								}
							}
						}, 
						change: function(e) {  
							var db = $("#grid").data("kendoGrid").dataSource;
							db.at(0).AREA_GB =  this.value();
							alert(this.bindings.value);
						}
					});
					//초기화
					//var combobox = $("#in_area").data("kendoComboBox");
					//combobox.value(G_AreaIdVal);
					//combobox.trigger("change");
                	
					//작성자
					$("#REG_USER_SQ").kendoComboBox({
						index: 0,
						dataTextField: "CD_NM",
						dataValueField: "CD",
						filter: "contains",
						dataSource: {
							transport: {
								read: {
									url: "<c:url value='/dgms/getUserListByUserID.do'/>",
									dataType: "jsonp",
									complete:function(e){  
									}
								},
								parameterMap: function(data, type) {//type =  read, create, update, destroy
									var result = {
										//PATIENT_YN: "1" 
									};
									return { params: kendo.stringify(result) }; 
								}
							}
						},  
						dataBound: function(e){ 
						},
						change: function(e) {  
							viewModel.set("selected.REG_USER_SQ", this.value());
						}
					});
					
					//작성일자 
					$("#REG_DT").kendoDatePicker({
                        culture: "ko-KR",
                        mask: "0000/00/00",
                        format: "yyyy-MM-dd",
                        parseFormats: ["yyyyMMdd"],
                       	change: function () {
                       		var work_dt = kendo.toString(this.value(), "yyyyMMdd");
                       		var dataItem = grid.dataItem(grid.select());
                       		var index = viewModel.dataSource.indexOf(dataItem);
                        	viewModel.dataSource.at(index).set("REG_DT", work_dt);
                       	}
                    });
					
					//공지 시작일자
					$("#START_DT").kendoDatePicker({
                        culture: "ko-KR",
                        mask: "0000/00/00",
                        format: "yyyy-MM-dd",
                        parseFormats: ["yyyyMMdd"],
                       	change: function () {
                       		var work_dt = kendo.toString(this.value(), "yyyyMMdd");
                       		var dataItem = grid.dataItem(grid.select());
                       		var index = viewModel.dataSource.indexOf(dataItem);
                        	viewModel.dataSource.at(index).set("START_DT", work_dt);
                       	}
                    });
					

					//공지 종료일자
					$("#END_DT").kendoDatePicker({
                        culture: "ko-KR",
                        mask: "0000/00/00",
                        format: "yyyy-MM-dd",
                        parseFormats: ["yyyyMMdd"],
                       	change: function () {
                       		var work_dt = kendo.toString(this.value(), "yyyyMMdd");
                       		var dataItem = grid.dataItem(grid.select());
                       		var index = viewModel.dataSource.indexOf(dataItem);
                        	viewModel.dataSource.at(index).set("END_DT", work_dt);
                       	}
                    });
                	

					/*커스텀 버튼****************************************************************************************************/
					var myWindow = $("#editForm"), btnNew = $(".btnNew");	
					
					myWindow.kendoWindow({
                        width: "80%",
                        title: "공지사항",
                        visible: false,
                        actions: [
                            "Pin",
                            "Minimize",
                            "Maximize",
                            "Close"
                        ],
                        close: onClose
                    }).data("kendoWindow").center();					

                    function onClose() {
                    	btnNew.fadeIn();
                    }
                    
    				//[추가] 버튼
                  	btnNew.click(function(){
                  		//삭제버튼 숨김
                  		$(".btnRemove").css("display","none");
                  		
                  		//필드 초기화
                  		$("#editForm input[name=SUBJECT]").val("");
						$("#editForm input[name=WRITER_ID]").val("");
						$("#editForm input[name=SERIAL_NO]").val("");
						$("#editForm input[name=MODEL_NM]").val("");  
						$("#editForm textarea[name=CONTENTS]").val("");  
						$("#editForm input[name=AREA_GB]").val(G_AreaIdVal);

						//DATE 초기화
						var todayDate = kendo.toString(kendo.parseDate(new Date()), 'yyyyMMdd');
						$("#REG_DT").data("kendoDatePicker").value(); 
						$("#START_DT").data("kendoDatePicker").value(); 
						$("#END_DT").data("kendoDatePicker").value(); 
						$("input[name=WRITER_ID]").val("${userStore.fullname}").change();

						//COMBOBOX 초기화 
						$("#REG_USER_SQ").data("kendoComboBox").dataSource.read();
						
						//NOTICE_SQ
						var parameters = {'SEQ_NM': "SEQ_NOTICE"};

						$.ajax({
						    url: "<c:url value='/dgms/getSequence.do'/>",	// 요청 할 주소
						    async: false, 									// false 일 경우 동기 요청으로 변경
						    type: 'POST',									// GET, PUT
						    data: parameters,								// 전송할 데이터
						    success: function(data) {
								NoticeSQ = data.Sequence;	
						    }
						});

                  		//파일업로드 셋팅
                      	$("#files").data("kendoUpload").destroy();
                      	$("#fileWrapper").empty();
                      	 
						//파일정보
						var parameters = {'NOTICE_SQ': NoticeSQ};
						$.ajax({
						    url: "<c:url value='/editor/loadFiles.do'/>",	// 요청 할 주소
						    async: false, 									// false 일 경우 동기 요청으로 변경
						    type: 'POST',									// GET, PUT
						    data: parameters,								// 전송할 데이터
						    success: function(data) {
						    	if(data != null && data != ""){
							    	loadFiles = JSON.parse( data );  
						    	}else{
						    		loadFiles = "";
						    	}
						    	createUpload();
						    } 
						});
						
						//에디터 출력
						myWindow.data("kendoWindow").open();
						myWindow.parent().css("top", "110px");
						myWindow.parent().css("left", "290px");
						myWindow.parent().css("margin-bottom", "100px"); 
						
                    	viewModel.set("selected", new noticeModel()); 
                    	viewModel.dataSource.insert(0, viewModel.selected);
                    	
                  		var grid = $("#grid").data("kendoGrid");
						grid.dataSource.at(0).NOTICE_SQ = NoticeSQ;
                  	});

					function reloadGrid(){	
							$("#grid").data("kendoGrid").refresh();
							$("#grid").data("kendoGrid").dataSource.read();
					} 


					/*파일업로드    ***************************************************************************************************/
					var loadFiles = "";
						/*[
	                  		{name: "file1.doc", size: 500, extension: ".doc", fileSQ: "FILE_SQ1"},	                        	
	                  		{fileSQ: "FILE_SQ2", name: "file2.jpg", size: 600, extension: ".jpg"},	                        	
	                  		{fileSQ: "FILE_SQ3", name: "file3.xls", size: 700, extension: ".xls"}
              			];*/
 
              			
	                	function createUpload(){
              				$('<input name="files" id="files" type="file" />').appendTo("#fileWrapper").kendoUpload({
		                        async: {
		                            saveUrl: "/editor/saveFiles.do",
		                            removeUrl: "/editor/removeFiles.do",
		                            autoUpload: true
		                        },
              				/*
		                        upload: function(e){ 
									var parameters = {'SEQ_NM': "SEQ_TB_FILE_INFO"};
									$.ajax({
									    url: "<c:url value='/dgms/getSequence.do'/>", // 요청 할 주소
									    async: false, // false 일 경우 동기 요청으로 변경
									    type: 'POST', // GET, PUT
									    data: parameters, // 전송할 데이터
									    success: function(data) {
											fileSQ = data.Sequence;
											e.files[0].FILE_SQ = fileSQ;
									    }
									}); 
									
										
		                        	e.data = { REG_USER_SQ : RegUserSQ,  NOTICE_SQ : NoticeSQ, FILE_SQ : fileSQ};  
		                        }, */
		                        success: function(e){ 
		                        	//File Clear
		                            //$(".k-upload-files.k-reset").find("li").remove();
		                            
		                        	/*var files = e.files;
		                            if(e.operation == "upload"){
		                            }*/
		                        },
		                        files: loadFiles
		                    });
	                	} 
              			createUpload();
              			 
	                
					//에디터
					function editorInit(viewFlag){   
						$("#grid").data("kendoGrid").dataSource.newsync;  

						//1.읽다
						if(viewFlag=="read"){
							//단순출력
							var gird = $("#grid").data("kendoGrid");
                       		var dataItem = grid.dataItem(grid.select());
                       		var index = viewModel.dataSource.indexOf(dataItem);
	                        var Nsq = viewModel.dataSource.at(index).get("NOTICE_SQ");

							//파일정보 가져오기
							NoticeSQ = Nsq;
							var parameters = {'NOTICE_SQ': NoticeSQ};
							$.ajax({
							    url: "<c:url value='/editor/loadFiles.do'/>", // 요청 할 주소
							    async: false, // false 일 경우 동기 요청으로 변경
							    type: 'POST', // GET, PUT
							    data: parameters, // 전송할 데이터
							    success: function(data) {
							    	if(data != null && data != ""){
								    	loadFiles = JSON.parse( data ); 
			                        	//e.data = { FILE_SQ : e.files.FILE_SQ };
										//createUpload();
							    	}
							    } 
							});
						}else{			
							//INPUT 초기화
							$("#editForm input[name=SUBJECT]").val("");
							$("#editForm input[name=WRITER_ID]").val("");
							$("#editForm input[name=SERIAL_NO]").val("");
							$("#editForm input[name=MODEL_NM]").val("");  
							$("#editForm textarea[name=CONTENTS]").val("");  
							$("#editForm input[name=AREA_GB]").val(G_AreaIdVal);

							//DATE 초기화
							var todayDate = kendo.toString(kendo.parseDate(new Date()), 'yyyyMMdd');
							$("#REG_DT").data("kendoDatePicker").value(); 
							$("#START_DT").data("kendoDatePicker").value(); 
							$("#END_DT").data("kendoDatePicker").value(); 
							$("input[name=WRITER_ID]").val("${userStore.fullname}").change();

							//COMBOBOX 초기화 
							$("#REG_USER_SQ").data("kendoComboBox").dataSource.read();

							//NOTICE_SQ 획득
							if(viewFlag=="write"){
								var url = "<c:url value='/dgms/getSequence.do'/>";
								var parameters = {'SEQ_NM': "SEQ_NOTICE"};
								$.post(url, parameters, function(data) {
									NoticeSQ = data.Sequence;
			                  		var grid = $("#grid").data("kendoGrid");
									grid.dataSource.at(0).NOTICE_SQ = NoticeSQ;	
								}); 
							}//write
						}//else
					}//end editorInit

	                
					//DATEPICKER
					function dateTimeEditor(container, options) {
					    $('<input name="' + options.field + '"/>')
					            .appendTo(container)
					            .kendoDateTimePicker({
					                format:"yyyy-MM-dd HH:mm:ss",
					                timeFormat:"HH:mm:ss"
					            });
					}
					
					invokeUserAuth($(".btnNew"), "kendoButton", "C");
					invokeUserAuth($(".btnSave"), "kendoButton", "U");
					invokeUserAuth($(".btnRemove"), "kendoButton", "D");
                });
					
				
				var selectType = "";
				
				//%2F를 슬러시로 표기 변경
				$(document).on("mouseup", ".k-tile", function(){ 
					var obj; 
					var pObj = $(this).parent().parent();
					
					if(pObj.hasClass("k-imagebrowser")){
						selectType = "img";
					}else if(pObj.hasClass("k-filebrowser")){
						selectType = "file";
					}
					
					if(selectType == "img"){
						obj = $("#k-editor-image-url");
					}else if(selectType == "file"){
						obj = $("#k-editor-file-url");
					} 
					obj.css({"color":"#fff"}); 
					setTimeout(function(){
						urlStr = obj.val().replace(/%2F/gi, "/"); 
						obj.val(urlStr);
						obj.css({"color":"#000"}); 
					}, 200);
				});
				
            	</script> 
					      </div>
					    </div><!-- box --> 
					  </div><!-- col-xs-12 -->
					</div><!-- row -->
        </section>    
        
      </div>

		<style>
			.box{min-height:678px;} 
			.bttb{margin:35px 0px 10px 10px; text-align: right;}
			.bttb2{margin-top:10px; text-align:center;} 
			.col-xs-5 label{padding:5px; margin-bottom:0px;}
			.w10{width: 800px !important;}
			/*#editForm{position:absolute; display:none; top:0; left:0; width:100%; height:100%; min-height:678px; background-color:#fff;}*/
			div.k-window-content{padding-bottom:50px !important}
			#editForm #TITLE{min-width:450px; width:690px;}
		</style>
        
        
<%@ include file="../inc/footer.jsp" %>