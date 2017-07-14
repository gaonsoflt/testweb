<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../inc/header.jsp"%>
<%@ include file="../../inc/aside.jsp"%>
<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i>${menu.menu_nm} <small>${menu.menu_desc}</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> ${menu.main_nm}</a></li>
			<li class="active">${menu.menu_nm}</li>
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
						<form id="question-form" action="${contextPath}/question/save.do" method="post" enctype="multipart/form-data" onsubmit="return fn_onsubmit(this);">
							<div>
								<c:if test="${questionInfo != null }">
									<button type="submit" name="action" value="delete" style="float:right;margin:10px 10px 0 0;"><spring:message code="button.delete" text="delete" /></button>
								</c:if>
								<button type="submit" name="action" value="save" style="float:right;margin:10px 10px 0 0;"><spring:message code="button.save" text="save" /></button>
								<button type="button" id="list-btn" onclick="fn_list();" style="float:right;margin:10px 10px 0 0;"><spring:message code="button.list" text="list" /></button>
							</div>
							<input type="hidden" name="bbs" value="${bbsInfo.bbs_seq}"/>
							<c:if test="${questionInfo != null }">
								<input type="hidden" name="question-seq" value="${questionInfo.question_seq}"/>
							</c:if>
							<table style="width:100%;">
								<colgroup>
									<col width="50%">
									<col width="50%">
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div>
												<c:if test="${questionInfo != null }">
												<label class="col-sm-3 control-label">등록자</label>
												<div class="col-sm-3">
													${questionInfo.reg_usr}
                                       			</div>
												<label class="col-sm-3 control-label">수정일</label>
												<div class="col-sm-3">
													${questionInfo.mod_dt}
                                       			</div>
												</c:if>
											</div>
											<div>
												<label class="col-sm-4 control-label">제목</label>
												<div class="col-sm-12">
                                           			<input type="text" name="title" class="form-control" value="<c:if test='${questionInfo != null}'>${questionInfo.title}</c:if>" required/>
                                       			</div>
											</div>
											<div>
												<label class="col-sm-3 control-label">문제</label>
												<div class="col-sm-12">
													<textarea id="con-question" name="con-question" class="form-control" style="height:200px;"></textarea>
												</div>
											</div>
											<div>
												<label class="col-sm-3 control-label">입출력</label>
												<div class="col-sm-12">
													<textarea id="con-io" name="con-io" class="form-control" style="height:200px;"></textarea>
												</div>
											</div>
											<div>
												<label class="col-sm-3 control-label">예제</label>
												<div class="col-sm-12">
													<textarea id="con-example" name="con-example" class="form-control" style="height:200px;"></textarea>
												</div>
											</div>
											<div>
												<label class="col-sm-3 control-label">힌트</label>
												<div class="col-sm-12">
													<textarea id="con-hint" name="con-hint" class="form-control" style="height:200px;"></textarea>
												</div>
											</div>
										</td>
										<td valign="top">
											<div id="tabstrip">
												<ul>
													<li class='k-state-active'>기본설정</li>
													<li>채점데이터</li>
													<li>테스트코드</li>
												</ul>
												<div>
													<div>
														<label class="col-sm-3 control-label">언어</label>
														<div class="col-sm-10">
															<input id="lang-type" name="lang-type" class="form-control" style="width:100%;" required/>
														</div>
														<label class="col-sm-3 control-label">최대 코드 사이즈</label>
														<div class="col-sm-10">
															<input type="text" id="max-codesize" name="max-codesize" class="form-control" value="<c:choose><c:when test='${questionInfo != null}'>${questionInfo.max_codesize}</c:when><c:otherwise>${default_max_codesize}</c:otherwise></c:choose>"/>byte
														</div>
														<label class="col-sm-3 control-label">실행시간(timeout)</label>
														<div class="col-sm-10">
															<input type="text" id="timeout" name="timeout" class="form-control" value="<c:choose><c:when test='${questionInfo != null}'>${questionInfo.timeout}</c:when><c:otherwise>${default_timeout}</c:otherwise></c:choose>" required/>ms
														</div>
														<label class="col-sm-3 control-label">금지어(, 로 구분)</label>
														<div class="col-sm-10">
															<input type="text" id="ban-keyword" name="ban-keyword" class="form-control" value="<c:choose><c:when test='${questionInfo != null}'>${questionInfo.ban_keyword}</c:when><c:otherwise>${default_ban_kw}</c:otherwise></c:choose>"/>
														</div>
													</div>
												</div>
												<div>
													<div id="gradedata">
														<button id="test-btn" type="button" onclick="startTest()">테스트시작</button>
														<div><span id="exec-msg"></span></div>
														<div id="grid-grading"></div>
													</div>
												</div>
												<div>
													<div id="testcode" style="height:100%;">
														<textarea id="test-code" name="test-code" class="form-control" style="height:100%;"></textarea>
													</div>
												</div>
											</div>
										</td>	
									</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div> <!-- box -->
			</div> <!-- col-xs-12 -->
		</div> <!-- row -->
	</section>
</div>

<!-- grading popup editor template -->
<script id="popup-editor" type="text/x-kendo-template">
	<div id="popup-editor">
	    <p>채점데이터</p>
	    <table style="width:100%;">
        	<colgroup>
	            <col width="50%">
            	<col width="50%">
        	</colgroup>
        	<tr><th>문제번호</th></tr>
        	<tr>
	            <td colspan="2">
                	<input name="grading_order" data-role="numerictextbox" data-bind="value:grading_order" data-format="n0" data-min="1" data-max="100" required/>
            	</td>
        	</tr>
        	<tr>
	            <th>입력값</th>
            	<th>출력값</th>
        	</tr>
        	<tr>
	            <td>
					<textarea name="grading_input" data-bind="value:grading_input" placeholder="입력값을 입력하세요." style="width:100%;height:200px;"></textarea>
            	</td>
            	<td>
					<textarea name="grading_output" data-bind="value:grading_output" placeholder="출력값을 입력하세요." style="width:100%;height:200px;"></textarea>
            	</td>
        	</tr>
    	</table>
	</div>
</script>

<script>
	var editor;
	var temp;
	function fn_list() {
		location.href='${contextPath}/mgr/question.do';	
	}
	
	function fn_onsubmit(e) {
		var msg; 
		if(e.action.value == "save") {
			msg = "<spring:message code='msg.save'/>";
		} else if (e.action.value == "delete") {
			msg = "<spring:message code='msg.del'/>";
		}
		
		if(confirm(msg)) {
			return true;
		}
		return false;
	}
	
	function setCodeEditor(value) {
		editor.getDoc().setValue(value);
	}
	
	function getCodeEditor() {
		console.log(editor.getDoc().getValue("\r\n"));
	}
	
	function setExecMsg(msg) {
	    document.getElementById("exec-msg").innerHTML = msg;
	}
	
	function startTest() {
		setExecMsg("테스트코드를 실행중입니다. 잠시만 기다려주세요.");
		$.ajax({
			type : "post",
			url : "<c:url value='/question/execute/test.do'/>",
			data : {
				"question_seq" : "${questionInfo.question_seq}"
			},
			async : false, //동기 방식
			success : function(data, status) {
				console.log(data);
				if(data.success) {
	        		$("#grid-grading").data("kendoGrid").dataSource.read();
	            	setExecMsg("테스트를 완료했습니다.");
				} else {
					// TODO: fix error message 
					setExecMsg(data.error.message);
				}
			},
			fail : function(data) {
			},
			complete : function(data) {
			}
		});
	}
	
	$(document).ready(function() {
		$("#con-question").kendoEditor({
			resizable: {
	        	content: false,
	        	toolbar: true
	        },
	        encoded: false
		});
		
		$("#con-io").kendoEditor({
			resizable: {
	        	content: false,
	        	toolbar: true
	        },
	        encoded: false
		});
		
		$("#con-hint").kendoEditor({
			resizable: {
	        	content: false,
	        	toolbar: true
	        },
	        encoded: false
		});
		
		$("#con-example").kendoEditor({
			resizable: {
	        	content: false,
	        	toolbar: true
	        },
	        encoded: false
		});
		
		$("#con-question").data("kendoEditor").value("${questionInfo.con_question}");
		$("#con-io").data("kendoEditor").value("${questionInfo.con_io}");
		$("#con-example").data("kendoEditor").value("${questionInfo.con_example}");
		$("#con-hint").data("kendoEditor").value("${questionInfo.con_hint}");
		
		editor = CodeMirror.fromTextArea(document.getElementById('test-code'), {
			lineNumbers: true
		});
		
		<% pageContext.setAttribute("enter","\r\n"); %>
		editor.getDoc().setValue('${fn:replace(questionInfo.test_code, enter, "\\n")}');
		
		var tabStripElement = $("#tabstrip").kendoTabStrip({
            animation:  {
                open: {
                    effects: "fadeIn"
                }
            },
            show: function onSelect(e) {
            	var showen = $(e.item).find("> .k-link").text();
                console.log("Shown: " + showen);
               	if(showen == '테스트코드') {
               		setTimeout(function() {
            			editor.refresh();
            		}, 1);
            	}
            }
        });
		
		tabStripElement.parent().attr("id", "tabstrip-parent");
//             save: function (e) {
// 				console.log("kendo.observable:save");
// // 				conditionList = $("#gridCondition").data("kendoGrid").dataSource.data();
// // 				questionViewModel.dataSource.data()[0].set("condition", conditionList);
// 				gradingList = $("#grid-grading").data("kendoGrid").dataSource.data();
// 				questionViewModel.dataSource.data()[0].set("grading", gradingList);
// 				questionViewModel.dataSource.data()[0].set("reg_usr", "${userStore.username}")
// 	        	questionViewModel.dataSource.data()[0].set("mod_usr", "${userStore.username}")
// 	        	questionViewModel.dataSource.data()[0].set("lang_type", $("#lang-type").data("kendoDropDownList").value());
// 	        	questionViewModel.dataSource.data()[0].set("test_code", editor.getDoc().getValue());
// 	        	// convert tag for editor
// 	        	if(typeof $("#con-question").val() != "undefined"
// 	        			&& typeof $("#con-io").val() != "undefined"
// 	        			&& typeof $("#con-example").val() != "undefined"){
// 	        		$("#con-hint").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
// 	        		var inData = $("#con-example").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
// 		        	if(inData.length < 1 || inData == null){
// 						alert("예제를 입력해주세요.");
// 			    	   	e.preventDefault();	
// 			        } else if(inData.length < 1 || inData == null){
// 		        		inData = $("#con-io").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
// 						alert("입출력을 입력해주세요.");
// 			    	   	e.preventDefault();	
// 			        } else if(inData.length < 1 || inData == null){
// 		        		inData = $("#con-question").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
// 						alert("문제를 입력해주세요.");
// 			    	   	e.preventDefault();	
// 			        } else {
// 		            	this.dataSource.sync();
// 			        }
// 	        	}
//             },

	    $("#lang-type").kendoDropDownList({
			dataTextField : "text",
			dataValueField : "value",
			dataSource : {
				transport : {
					read : {
						url : "<c:url value='/question/getSupportLanguage.do'/>",
						dataType : "jsonp"
					},
					parameterMap : function(data, type) {
						var result = { };
						return { params : kendo.stringify(result) };
					}
				}
			},
			parse: function(response) {
    			console.log("lang-type:kendoDropDownList:parse");
            	return response;
			},
    		success : function(data, status) {
    			console.log("lang-type:kendoDropDownList:success");
    			return data.rtnList;
    		},
			change : function() {
            	console.log("lang-type:kendoDropDownList:change");
			},
			index : 0
		});
		
		var crudServiceBaseUrl = "${contextPath}/question";
		$("#grid-grading").kendoGrid({
			dataSource : new kendo.data.DataSource({
				transport: {
					read:  { url: crudServiceBaseUrl + "/grading/readList.do", dataType: "jsonp",
            			complete: function(e){ 
            				console.log("grid-grading:grid:datasource:read:complete");
            			}
					},
					update: { 
// 						url: crudServiceBaseUrl + "/grading/update.do", dataType: "jsonp"
					},
					destroy: { 
// 						url: crudServiceBaseUrl + "/grading/delete.do", dataType: "jsonp" 
					},
					create: { 
// 						url: crudServiceBaseUrl + "/grading/create.do", dataType: "jsonp" 
					},
					parameterMap: function(data, type) {
						if (type == "read"){
                           	var result = {
                           		question_seq: "${questionInfo.question_seq}"
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
						return response.rtnList;
					},
					total: function(response) {
						return response.total;
					},
					errors: function(response) {
						return response.error;
					},
					model:{//가져온 값이 있음...
						id:"grading_seq",//id 로 insert할건지 update 할건지 판단함.
						fields: {
							grading_seq: { editable: false, nullable: true },
							grading_input: { type: "string", validation: { required: true } },
							grading_output: { type: "string", validation: { required: true } },
							grading_order: { type: "number", nullable: false, validation: { required: true }, defalutValue: 0 },
							correct: { type: "boolean", editable: false },
							exe_time: { type: "number", editable: false }
						}   
					}
				},
                error : function(e) {
                	console.log(e);
                },
                change : function(e) {
                },  	
                sync: function(e) {
					console.log("grid-grading:grid:dataSource:sync");
				},  
				batch: true               //     true: 쿼리를 한줄로,  false : row 단위로
			}),
			autoBind : true,
			navigatable : true,
            toolbar: [
				{ name: "create", text: "추가" },
				{ name: "cancel", text: "취소" }
            ],
			columns : [
				{ field : "grading_order", title : "번호", width : "10%", attributes : { style : "text-align: center;" } },
				{ field : "grading_input", title : "입력값", width : "20%", attributes : { style : "text-align: center;" }, },
				{ field : "grading_output", title : "출력값", width : "20%", attributes : { style : "text-align: center;" } },
				{ field : "correct", title : "테스트", width : "60", attributes : { style : "text-align: center;" } },
				{ field : "exec_time", title : "ms", width : "60", attributes : { style : "text-align: center;" } },
				{
					width : "90",
					command: [
						{ name: "destroy", text: "" }
					]
				}
			],
			editable: {
				mode: "popup",
	            template: kendo.template($("#popup-editor").html()),
				confirmation: "선택한 행을 삭제하시겠습니까?(저장 클릭시 적용됩니다.)"
			},
			edit: function(e) {
				console.log("grid-grading:grid:edit");
				$(e.container).parent().css({
					width: '900px',
					height: '400px'
				});
// 				if(e.model.isNew()) {
// 					console.log("new");
// 					temp = e.model;
// 					if(e.model.get("grading_order") == 0) {
// 	 					e.model.set("grading_order", Number(this.dataSource.at(this.dataSource.total()-1).get("grading_order")) + 1);
// 					}
// 				} else {
// 					console.log("edit");
// 				}
			},  
			change: function(e) {
            	console.log("grid-grading:grid:change");
			},
			save: function(e) {
            	console.log("grid-grading:grid:save");
			},
			sortable : true,
			scrollable : false,
			mobile : true,
			noRecords : {
				template: "채점 데이터가 없습니다."
			},
			dataBound: function(e) {
				console.log("grid-grading:grid:dataBound");
			}
		});
		
// 		 $("#grid-grading").delegate("tbody>tr", "dblclick", function () {
		$("#grid-grading").delegate("tbody>tr", "click", function () {
			if (!$(this).hasClass('k-grid-edit-row')) {
				$("#grid-grading").data("kendoGrid").editRow($(this));
			}
		});
	});//document ready javascript end...
</script>

<style>
    #tabstrip-parent,
    #tabstrip {
		height: 900px;
		margin: 0;
		padding: 0;
		border-width: 0;
    }
    #tabstrip-1,
    #tabstrip-2,
    #tabstrip-3 {
		height: 100%;
    }
    .CodeMirror {
    	height: 100%
    }
	#in_keyword, .k-datepicker, .k-autocomplete {
		display: none;
	}
	#in_keyword, .k-datepicker, #searchBtn {
		margin-left: 9px;
	}
	.k-grid table {
		table-layout: fixed;
	}
	.k-grid td {
	    overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
</style>
<%@ include file="../../inc/footer.jsp"%>