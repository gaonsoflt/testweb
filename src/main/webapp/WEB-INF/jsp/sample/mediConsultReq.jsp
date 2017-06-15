<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>
<style>
.notReadyRow {color:#ff1919;}
</style>

<script>
	var userInfoMap;
	$.ajax({
		type: "post",
		url: "<c:url value='/dgms/getUserInfo.do'/>",
		data: {
			'AREA_GB': "${userStore.areaId}"
		},
		async: false, //동기 방식
		success: function(data, status){
			console.log(status);
			console.log(data.rtnList);
			userInfoMap = data.rtnList;
		},
		fail: function(e){
			console.log(e);
		},
		complete: function(){}
	});
	
	function fnUserSeqByName(name){
		var rtnVal = "";
		console.log('fnUserSqByName param: ' + name);
		for (var i = 0; i < userInfoMap.length; i++) {
            if (userInfoMap[i].USER_NM == name) {
            	console.log('fnUserSqByName result: ' + userInfoMap[i].USER_SEQ);
            	return rtnVal = userInfoMap[i].USER_SEQ;
            }
        }
		return null;
	}
</script>
 
 <div id="ex7" style="display:none;">
 	<a id="close" rel="modal:close">CLOSE</a>
    <h3 style="margin-top:40px; border-bottom:1px solid #000; padding-bottom:10px;">설명제목</h3>
    <br /><br />내용을 입력해주십시오.<br />
          내용이 길 때 > 자동 스크롤바 생성<br />
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /> 
  </div>


<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i> 원격상담신청 <small>원격 의료상담을 신청합니다.</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 원격의료상담관리</a></li>
			<li class="active">원격상담신청</li>
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
						<div style="font-size:15px; padding:10px 0px;">
							<input id="in_search" />
							<span id="in_kw_user"><input id="in_keyword_user" /></span>
						    <span id="in_kw_code"><input id="in_keyword_code" /></span>
							<button id="searchBtn" type="button">검색</button>
							  <!-- Link to open the modal -->
							<div style="position:absolute; width:200px; height:40px; line-height:50px; padding-right:15px; text-align: right; right:0; display:inline-block; color:#FF0066;">
								<p><a href="#ex7" rel="modal:open">원격상담 사용방법</a></p>
							</div>
						</div>
						<div id="gridDetail"></div>
<script>
	var G_AREA_GB = "${userStore.areaId}"; 
	var G_TOWN_ID = "${userStore.townId}"; 
	var G_Admin = "${userStore.username}";  
	var G_UserNm = "${userStore.fullname}";
	var G_Search = "";
	var G_Keyword = "";
	
	var searchData = [ 
		{ text: "전체", value: "ALL" },
		{ text: "신청자", value: "USER_NO", ui: $("#in_kw_user") },
		{ text: "진행상태", value: "STATUS_CD", ui: $("#in_kw_code") }
	];

	$("#in_search").kendoComboBox({ 
		dataTextField: "text",
		dataValueField: "value",
		dataSource: searchData, 
		change: function(e){
			console.log('in_search change: ' + this.value());
			G_Search = this.value();
			if(this.value() == searchData[1].value) {
				searchData[1].ui.css("display", "");
				searchData[2].ui.css("display", "none");
				$("#in_keyword_user").focus();
				$("#in_keyword_code").data("kendoComboBox").value("");
			} else if(this.value() == searchData[2].value) {
				searchData[1].ui.css("display", "none");
				searchData[2].ui.css("display", "");
				$("#in_keyword_code").focus();
				$("#in_keyword_user").data("kendoAutoComplete").value("");
			} else {
				searchData[1].ui.css("display", "none");
				searchData[2].ui.css("display", "none");
			}
		},
		select: function(e) {
			console.log('in_search select: ' + this.value());
		},
		index: 0,
		dataBound: function(e) {
			console.log('in_search dataBound');
		}
	}); 
	
	/* 키워드 */
	$("#in_keyword_user").kendoAutoComplete({
		dataSource: {
	    	transport: {
				read: {
					url: "<c:url value='/dgms/getAutoCompleteNew.do'/>",
					dataType: "jsonp"
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					var result = {
						AREA_GB: G_AREA_GB,
						TOWN_ID: G_TOWN_ID,
						TABLE: "TB_USER_INFO",
						TEXT: "USER_NM",
						VALUE: "USER_SEQ",
						USER_TYPE: '5113000000' // 마을주민
                	};
					return { params: kendo.stringify(result) }; 
				}
			}	
	    },
		suggest: false,
		dataTextField: "TEXT",
		dataBound: function(e) {
		},
		select: function(e) {
			G_Search = 'USER_NO';
			G_Keyword = this.dataItem(e.item.index()).VALUE;
			// 무조건 USER_NM으로 검색 됨 
			console.log('in_keyword_user select: ' + G_Keyword);
		},
		change: function(e) {
			G_Search = 'USER_NM';
			G_Keyword = this.value();
			console.log('in_keyword_user change: '  + G_Keyword);
		}
	});
	
	$("#in_keyword_user").keydown(function (e) {
        if (e.which == kendo.keys.ENTER) {
        	doSearch();
        }
    });
	
	$("#in_keyword_code").kendoComboBox({ 
		dataSource: {
	    	transport: {
				read: {
					url: "<c:url value='/dgms/getAutoCompleteNew.do'/>",
					dataType: "jsonp"
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					var result = {
						TABLE: "TB_CODE_MASTER",
						TYPE: "_STATUS_",
						TEXT: "CD_NM",
						VALUE: "CD_ID"
                	};
					return { params: kendo.stringify(result) }; 
				}
			}
	    },
		dataTextField: "TEXT",
		dataValueField: "VALUE",
		change: function(e){
			console.log('in_keyword_code change');
		},
		dataBound: function(e) {
		},
		select: function(e) {
			console.log('in_keyword_code select: ' + this.dataItem(	e.item.index()).VALUE);
			G_Keyword = this.dataItem(e.item.index()).VALUE;
		}
	});

	/* 조회 */
	$("#searchBtn").kendoButton({
		icon: "search",
		click: doSearch
	});
	
	function doSearch(e) {
		var gridDetail = $("#gridDetail").data("kendoGrid");
		gridDetail.dataSource.read();
	};
	
	$(document).ready(function () {
		
		 
		$('a[href="#ex7"]').click(function(event) {
		     event.preventDefault();
		     $(this).modal({
		       fadeDuration: 250
		     });
		   });
		  
		
		
		searchData[1].ui.css("display", "none");
		searchData[2].ui.css("display", "none");
		
		var crudServiceBaseUrl = "/urtown/mediconsult/req";
	    /*** dataSource ***/
		var dataSource = new kendo.data.DataSource({
			transport: {
				read:  {
					url: crudServiceBaseUrl + "/list.do",
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
							AREA_GB: G_AREA_GB,
							TOWN_ID: G_TOWN_ID,
							SEARCH: G_Search,
							KEYWORD: G_Keyword
						};
						return { params: kendo.stringify(result) };
					} else if (type !== "read" && data.models) {	
						return { models: kendo.stringify(data.models) };
					}
				}
			},
			schema: {
				data: function(response) {
					console.log('rtnList: ');
					console.log(response.rtnList);
					return response.rtnList;
				},
				total: function(response) {
					console.log('rtnTotal: ' + response.total);
					return response.total;
				},
				errors: function(response) {
					return response.error;
				},
				model:{//가져온 값이 있음...
					id: "MEDI_CONSULT_SQ",//id 로 insert할건지 update 할건지 판단함.
					fields: {//data type of the field {Number|String|Boolean|Date} default is String
						MEDI_CONSULT_SQ:{ type: "number" },
						AREA_GB: 		{ type: "string", defaultValue: "${userStore.areaId}" },
						REQUEST_NO: 	{ type: "number", editable: false },
						STATUS_CD: 		{ type: "string", editable: true, defaultValue: "500001" },
						STATUS_NM: 		{ type: "string", editable: true, defaultValue: '접수' },
						USER_NM:		{ type: "string", editable: true },
						USER_NO:		{ type: "string", editable: true },
						BIRTHDAY: 		{ type: "string", editable: false },
						CONSULT_REQ_DT: { type: "string", defaultValue: new Date() },
						CHECKUP_REQ_DT: { type: "string", defaultValue: new Date() },
						CHECKUP_NO: 	{ type: "number", editable: false },
						ISSUE_NOTE: 	{ type: "string" },
						REG_DT: 		{ type: "string", editable: false },
						REG_USER: 		{ type: "string", editable: false, defaultValue: "${userStore.username}" },
						MOD_DT: 		{ type: "string", editable: false },
						MOD_USER: 		{ type: "string", editable: false, defaultValue: "${userStore.username}" }
					}   
				}
			},
		    error : function(e) {
		    	console.log('error: ' + e.errors);
		    },
		    change : function(e) {
		    	console.log('change...');
		    },  	
		    sync: function(e) {
				$("#gridDetail").data("kendoGrid").dataSource.read(); 
	        	//상담내용
	        	/*
	        	alert(typeof $(".k-editor .k-content").val());
	        	if( typeof $("#ISSUE_NOTE").val() != "undefined" ){ 
	        		var inData = $("#ISSUE_NOTE").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
		        	if(inData.length < 1 || inData == null){
							alert("불편사항을 입력해주세요.");
				    	   	e.preventDefault();	
			        }else{
						console.log("sync complete");
						//console.log("model.dirty:"+this.schema.model.dirty);//수정되었는지 여부
						this.read();				
						alert("정상적으로 처리되었습니다.");  
			        }//if
	        	}//undefined
	        	*/
			},  
			//serverPaging: true,        // 서버 사이드 페이징 활성화
			//serverFiltering: false,
			//serverSorting: false,      // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
			//autoSync: true,          //     자동 저장
			batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
			page: 1,                   //     반환할 페이지
			pageSize: 15,              //     반환할 항목 수
			skip: 0,                   //     건너뛸 항목 수
			take: 15                   //     반환할 항목 수 (pageSize와 같음)
		});
					
					
					
		/*************************/
		/***    gridDetail     ***/
		/*************************/
		var gridDetail = $("#gridDetail").kendoGrid({
			dataSource: dataSource,
			pageable: true,
			height: 715,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			toolbar: [ 
			    { name: "create", text: "접수등록" },
			    { name: "excel", text: "엑셀출력" }
			],
			messages: {
				commands: {
					canceledit: "취소",
					update: "저장"
				}
			},
			columns: [
				{ title: "관리", width: 180, command: [ 
  					{ name: "edit", text: "수정" },
  					{ name: "destroy", text: "삭제" }
  					], attributes: {style: "text-align: left;"} 
  				},
				{ field: "REQUEST_NO", title: "접수번호", width: 110, attributes: {style: "text-align: center;"} },
				{ field: "STATUS_CD", title: "진행상태코드", width: 80, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "STATUS_NM", title: "진행상태", width: 90, attributes: {style: "text-align: center;"},
					editor: function (container, options) {
						$('<input required name="' + options.field + '" id="' + options.field + '"/>')
	                    .appendTo(container)
						.kendoComboBox({
							dataSource: {
						    	transport: {
									read: {
										url: "<c:url value='/dgms/getAutoCompleteNew.do'/>",
										dataType: "jsonp"
									},
									parameterMap: function(data, type) {//type =  read, create, update, destroy
										var result = {
											TABLE: "TB_CODE_MASTER",
											TYPE: "_STATUS_",
											TEXT: "CD_NM",
											VALUE: "CD_ID"
					                	};
										return { params: kendo.stringify(result) }; 
									}
								}
						    },
							dataTextField: "TEXT",
							dataValueField: "VALUE",
							change: function(e){
								console.log('STATUS_NM change');
							},
							dataBound: function(e) {
							}, 
							select: function(e) { 
								console.log('STATUS_NM select: ' + this.dataItem(e.item.index()).VALUE);
								options.model.set("STATUS_CD", this.dataItem(e.item.index()).VALUE);
							}
						});
					}
				},
				{ field: "USER_NO", title: "신청자번호", width: 80, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "USER_NM", title: "신청자", width: 120, attributes: {style: "text-align: center;"},
					editor: function (container, options) { 
						$('<input required name="' + options.field + '" id="' + options.field + '"/>')
	                    .appendTo(container)
						.kendoAutoComplete({ 
							headerTemplate: '<div class="dropdown-header k-widget k-header">' +
                            '<span>이름</span><span style="float:right;">생일</span></div>',
                            template: '<span class="user_no">#= USER_NM #</span>' +
	                        '<span class="birth" style="float:right;">#= BIRTHDAY #</span>',
	                    	dataSource: {
								transport: {
									read: {
										url: "<c:url value='/dgms/getUserAutoComplete.do'/>",
										dataType: "jsonp"
									},
									parameterMap: function(data, type) {//type =  read, create, update, destroy
										var result = {
											AREA_GB: G_AREA_GB,
											TOWN_ID: G_TOWN_ID,
											USER_TYPE: '5113000000' // 마을주민
		                            	};
										return { params: kendo.stringify(result) }; 
									}
								}
							}, 
							dataTextField: "USER_NM",
							dataBound: function(e) {
								$("#USER_NM-list").css("width", "200px");
							},	
							change: function(e) {
								//console.log('con: ' + container.);
								// editable is true = apply
								options.model.set("USER_NO", fnUserSeqByName(this.value()));
								// get CHECKUP_NO list
								//$("#CHECKUP_NO").data("kendoDropDownList").dataSource.read();
							}							
						});
					}
				},
				{ field: "BIRTHDAY", title: "생년월일", width: 100, attributes: {style: "text-align: center;"}, hidden: true,
					template: "#= (BIRTHDAY == '') ? '' : kendo.toString(kendo.parseDate(BIRTHDAY, 'yyyyMMdd'), 'yyyy-MM-dd') #",
				},
				{ field: "CONSULT_REQ_DT", title: "상담요청일", width: 120, attributes: {style: "text-align: center;"},
					template: "#= (CONSULT_REQ_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(CONSULT_REQ_DT))), 'yyyy-MM-dd') #",
					editor: function (container, options) { 
						$('<input required name="' + options.field + '" id="' + options.field + '"/>')
	                    .appendTo(container)
						.kendoDatePicker({
	                        culture: "ko-KR",
	                        //format: "yyyy/MM/dd HH:mm t",
							//parseFormats: ["yyyy-MM-dd HH:mm"],
	                        format: "yyyy/MM/dd",
							parseFormats: ["yyyy-MM-dd"],
							change: function(e) {
								console.log("consult_req_dt change: " + kendo.toString(this.value(), "yyyy-MM-dd"));
                           		options.model.set("CONSULT_REQ_DT", kendo.toString(this.value(), "yyyy-MM-dd"));
                           		//options.model.set("CONSULT_REQ_DT", kendo.toString(this.value(), "yyyy-MM-dd HH:mm"));
							}
						});
					}
				},
				{ field: "CHECKUP_REQ_DT", title: "건강측정요청일", width: 120, attributes: {style: "text-align: center;"},
					template: "#= (CHECKUP_REQ_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(CHECKUP_REQ_DT))), 'yyyy-MM-dd') #",
					editor: function (container, options) { 
						$('<input required name="' + options.field + '" id="' + options.field + '"/>')
	                    .appendTo(container)
						.kendoDatePicker({
	                        culture: "ko-KR",
	                        //format: "yyyy/MM/dd HH:mm t",
							//parseFormats: ["yyyy-MM-dd HH:mm"],
	                        format: "yyyy/MM/dd",
							parseFormats: ["yyyy-MM-dd"],
							change: function(e) {
								console.log("checkup_req_dt change: " + kendo.toString(this.value(), "yyyy-MM-dd"));
                           		options.model.set("CHECKUP_REQ_DT", kendo.toString(this.value(), "yyyy-MM-dd"));
                           		//options.model.set("CONSULT_REQ_DT", kendo.toString(this.value(), "yyyy-MM-dd HH:mm"));
							}
						});
					}
				},
				//{ field: "ISSUE_NOTE", title: "불편사항", attributes: {style: "text-align: left;"} },
				{ field: "ISSUE_NOTE", title: "불편사항", attributes: {style: "text-align: left;"},
					template: '#=ISSUE_NOTE #',
					editor: function (container, options) { 
						$('<textarea required name="' + options.field + '" id="' + options.field + '" style="width:100%;height:100px;"/>')
	                    .appendTo(container)
						.kendoEditor({
							tools: [
								"bold",
								"italic",
								"underline",
								"strikethrough",
								"justifyLeft",
								"justifyCenter",
								"justifyRight",
								"justifyFull",
								"insertUnorderedList",
								"insertOrderedList",
								"indent",
								"outdent"
							],
			   	        	resizable: {
			   	        		content: true,
			   	        		toolbar: true
			   	        	},
			   	        	encoded: false
						});
					}
				},
				{ field: "CHECKUP_NO", title: "측정번호", width: 130, attributes: {style: "text-align: center;"} }
			],
			dataBound: function(e) {
				//Selects all delete buttons
				$('tr').each(function() {
					if($(this).text().indexOf('500090완료') >= 0) {
						$(this).children().each(function() {
							$(this).children(".k-grid-delete").remove();
							$(this).children(".k-grid-edit").remove();
						})
					} 
// 					else if($(this).text().indexOf('500050대기') >= 0) {
// 						$(this).children().each(function() {
// 							$(this).children(".k-grid-edit").remove();
// 						})
// 					}
				});
				
				invokeUserAuth($("#gridDetail"), 'kendoGrid');
			},
			editable: {
				mode: "inline",
				confirmation: "삭제하시겠습니까?"
			},
			edit: function(e) {//Fired when the user edits or creates a data item
				console.log("edit...");
				var uiConsultReqDt= e.container.find("input[name=CONSULT_REQ_DT]").data("kendoDatePicker");
				var uiCheckupReqDt= e.container.find("input[name=CHECKUP_REQ_DT]").data("kendoDatePicker");
				uiConsultReqDt.value(kendo.toString(kendo.parseDate(new Date(Number(e.model.get("CONSULT_REQ_DT")))), 'yyyy-MM-dd'));
				uiCheckupReqDt.value(kendo.toString(kendo.parseDate(new Date(Number(e.model.get("CHECKUP_REQ_DT")))), 'yyyy-MM-dd'));
 				e.model.set("CONSULT_REQ_DT", kendo.toString(uiConsultReqDt.value(), "yyyy-MM-dd"));
 				e.model.set("CHECKUP_REQ_DT", kendo.toString(uiCheckupReqDt.value(), "yyyy-MM-dd"));
			},
            save: function(e) {//저장전 이벤트
				console.log("save...");
            },
            saveChanges: function(e) {//저장버턴 클릭시 이벤트
            	console.log("saveChanges...");
			},
			mobile: true,
            excel: {
                allPages: true,
                fileName: "원격의료상담신청내역.xlsx",
            },
			noRecords: {
				template: "검색된 결과가 없습니다."
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
            }
		});
		
		//sample
		/*
		function grid_edit(e) {
			if (!e.model.isNew()) { // update
				// Disable the editor when editing data items
			    var numeric = e.container.find("input[name=USER_NM]").data("kendoAutoComplete");
			    numeric.enable(true);
			} else { // new
			}
		}
		gridDetail.bind("edit", grid_edit);
		*/
		
	});//document ready javascript end...
</script>
                  		
					</div>
				</div>
				<!-- box -->
			</div>
			<!-- col-xs-12 -->
		</div>
		<!-- row -->
	</section>
</div>

<style>
	.k-header .k-link{
	   text-align: center;
	}
	#in_kw_user, #in_kw_code, #searchBtn{margin-left:9px;} 
	#gridDetail table th{text-align:center;}
	.blocker{z-index:2000;}
	#ex7{z-index:3000; max-width:900px; height:700px; position: absolute; top:100px; left:600px; overflow-x:hidden; overflow-y:auto;}
	#ex7 #close{display:inline-block; background-color:#999; padding:5px 10px 5px 10px; position:absolute; color:#fff; right:15px; cursor:pointer;}
	.modal a.close-modal{display:none;}
</style>

<%@ include file="../inc/footer.jsp"%>