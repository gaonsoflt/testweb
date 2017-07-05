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
						<div id="gridList"></div>
					</div>
				</div> <!-- box -->
			</div> <!-- col-xs-12 -->
		</div> <!-- row -->
	</section>
</div>

<div id="window" style="display:none;">
	<div>
		<button id="submit-btn" data-role="button" data-icon="pencil" data-bind="click: submit" style="float:right;margin:10px 10px 0 0;">제출</button>
<!-- 		<button id="submit-btn" data-role="button" data-icon="pencil" data-bind="click: submit" style="float:right;margin:10px 10px 0 0;">제출</button> -->
		<button id="cancel-btn" data-role="button" data-icon="cancel" data-bind="click: cancel" style="float:right;margin:10px 10px 0 0;">취소</button>
	</div>
	<table style="width:100%">
		<colgroup>
			<col width="50%">
			<col width="50%">
		</colgroup>
		<tbody>
			<tr>
				<td>
					<table style="width:100%;">
						<colgroup>
							<col width="20%">
							<col width="80%">
						</colgroup>
						<tbody>
							<tr>
								<th>제목</th>
								<td><input data-role="maskedtextbox" data-bind="value:selected.title" style="width:100%;" readonly="readonly"/></td>
							</tr>
							<tr>
								<th>제출마감</th>
								<td><input id="submit_to" name="submit_to" data-role="datetimepicker" data-bind="value:selected.submit_to" data-format="yyyy-MM-dd HH:mm tt" required style="width:100%;" readonly="readonly"/></td>
							</tr>
							<tr>
								<th>개발언어</th>
								<td>
									<input data-role="maskedtextbox" data-bind="value:selected.lang_type" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<th>제약사항</th>
								<td>
									<div>실행시간 <input data-role="maskedtextbox" data-bind="value:selected.timeout" style="width:50%;" readonly="readonly"/>ms</div>
									<div>프로그램 사이즈 <input data-role="maskedtextbox" data-bind="value:selected.max_codesize" style="width:30%;" readonly="readonly"/>byte</div>
									<div>코드 금지어<p> <input data-role="maskedtextbox" data-bind="value:selected.ban_keyword" style="width:100%;" readonly="readonly"/></div>
								</td>
							</tr>
							<tr>
								<th>제출횟수</th>
								<td>
									<div>
										<div>최대제출횟수 <input data-role="maskedtextbox" data-bind="value:selected.max_submit_cnt" style="width:50%;" readonly="readonly"/></div>
										<div>현재제출횟수 <input data-role="maskedtextbox" data-bind="value:selected.user_submit_cnt" style="width:50%;" readonly="readonly"/></div>
									</div>
								</td>
							</tr>
							<tr>
								<th>문제</th>
								<td><textarea id="question_con" data-role="editor" data-bind="value:selected.question" style="width:100%;height:150px;"></textarea></td>
							</tr>
							<tr>
								<th>입출력</th>
								<td><textarea id="question_io" data-role="editor" data-bind="value:selected.question_io" style="width:100%;height:150px;"></textarea></td>
							</tr>
							<tr>
								<th>예제</th>
								<td><textarea id="question_example" data-role="editor" data-bind="value:selected.question_example" style="width:100%;height:150px;"></textarea></td>
							</tr>
							<tr>
								<th>힌트</th>
								<td><textarea id="question_hint" data-role="editor" data-bind="value:selected.question_hint" style="width:100%;height:150px;"></textarea></td>
							</tr>
						</tbody>
					</table>
				</td>
				<td valign="top">
					<form id="answer_form" action="<c:url value="/question/deploy/answer/submit.do"/>" method="post" enctype="multipart/form-data">
						<input id="deploy_seq" name="deploy_seq" data-bind="value:selected.deploy_seq" type="hidden" readonly="readonly"/>
						<div>답안제출형태</div>
						<div>
							<input type="radio" name="answer_type" value="file" checked="checked"/>파일
							<input type="radio" name="answer_type" id="answer_type" value="editor"/>에디터
						</div>
						<div><input id="submit_file" name="submit_file" type="file" aria-label="files" /></div>
						<div><textarea id="submit_editor" name="submit_editor" placeholder="코드를 입력하세요." data-bind="value:selected.answer" style="width:100%;height:700px"></textarea></div>
<!-- 						<div><textarea id="submit_editor" name="submit_editor" placeholder="코드를 입력하세요."></textarea></div> -->
					</form>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<script>
	/* DropDownList Template */
	var questionViewModel;
	var questionModel;
	var wnd;
	var G_Seq = 0;
	var editor;
	
	$(document).ready(function() {
		function setCodeEditorValue(value) {
			editor.getDoc().setValue(value);
		}
		
		function getCodeEditorValue() {
			return editor.getDoc().getValue();
		}
		
// 		editor = CodeMirror.fromTextArea(document.getElementById('submit_editor'), {
// 			lineNumbers: false
// 		});

		$("#submit_file").kendoUpload({
			select: function(e) {
            	console.log("submit_file.select");
            	var files = e.files;
            	$.each(files, function() {
            		var type = this.extension;
                    if (type == ".txt" || type == ".java") {
          			} else {
                        alert("업로드 할수 있는 파일이 아닙니다.\n(가능파일: .txt .java)");
                        e.preventDefault();
                        return false;
          			}
                })
			}
		});
		
		$("input[name=answer_type]").change(function() {
			var radioValue = $(this).val();
			if (radioValue == "file") {
				$("form .k-upload").css({ "display" : "block" });
				$("#submit_editor").css({ "display" : "none" });
			} else {
				$("form .k-upload").css({ "display" : "none" });
				$("#submit_editor").css({ "display" : "block" });
			}
		});
		
		/*************************/
		/* deatils window
		/*************************/
		wnd = $("#window").kendoWindow({
            title: "제출",
            width: 900,
            height: 800,
            actions: [
				"Maximize",
				"Close"
			],
            modal: true,
            visible: false,
            resizable: true,
            open: function() {
            	console.log("window.open");
        		// read question detail
				questionViewModel.dataSource.read();
				$('.k-editor-toolbar').hide();
				$($('#question_con').data().kendoEditor.body).attr('contenteditable', false);
				$($('#question_io').data().kendoEditor.body).attr('contenteditable', false);
				$($('#question_example').data().kendoEditor.body).attr('contenteditable', false);
				$($('#question_hint').data().kendoEditor.body).attr('contenteditable', false);
				document.getElementById("answer_type").checked = true;
				$("#submit_editor").css({ "display" : "block" });
				$("form .k-upload").css({ "display" : "none" });
            },
            close: function() {
            	console.log("window.close");
        		G_Seq = 0;
        		$("#gridList").data("kendoGrid").dataSource.read();
            }
        }).data("kendoWindow");

		/*************************/
		/* dataSgridListDetail */
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/question/deploy";
		$("#gridList").kendoGrid({
			dataSource: {
				transport: {
					read	: { 
						url: crudServiceBaseUrl + "/readDeployedQuestionListByUser.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("deploy-grid:dataSource:read:complete");
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
// 	                   			PAGESIZE : data.pageSize,
// 								SKIP : data.skip,
// 								PAGE : data.page,
// 								TAKE : data.take
							};
							return { params: kendo.stringify(result) }; 
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
					model:{
						id: "deploy_seq",
						fields: {
							deploy_seq:			{ type: "number" },
							group_name:			{ type: "string" },
							title:				{ type: "string" },
							status:				{ type: "string" },
							lang_type:			{ type: "string" },
							submit_from:		{ type: "string" },
							submit_to:			{ type: "string" },
							max_submit_cnt:		{ type: "number" },
							user_submit_cnt:	{ type: "number" }
						}  
					}
				},
		        error : function(e) {
			    	console.log('deploy-grid:dataSource:error: ' + e.errors);
		        },
		        batch : true,
				page : 1, //     반환할 페이지
				pageSize : 15, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 15
			},
			height: 715,
			resizable: true,  //컬럼 크기 조절
			reorderable: false, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row",
			scrollable: true,
			sortable : true,
			mobile: true,
			pageable : false,
			filterable: true,
            toolbar: false,
			columns: [
				{ field: "deploy_seq", hidden: true },
				{ field: "group_name", title: "배포그룹", width: "20%", attributes : { style : "text-align: center;" },
					filterable: { 
                        dataSource: {
                            transport: {
                                read: {
                                    url: "${contextPath}/question/deploy/groups.do",
                                    dataType: "jsonp",
                                    data: {
                                    	field: "group_name"
                					}
                                },
                                parameterMap: function(data, type) {//type =  read, create, update, destroy
            						if (type == "read"){
            		                   	var result = {
            							};
            							return { params: kendo.stringify(result) }; 
            						}
            					},
                           }
                        },
                        multi: true 
                    }
				},
				{ field: "title", title: "제목", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "status", title: "상태", width : "10%", attributes : { style : "text-align: center;" }, 
					filterable: { 
                        dataSource: new kendo.data.DataSource({
                            data: [
								{"status":"마감"},
								{"status":"진행중"}
							]
                        }),
                        multi: true 
                    }
				},
				{ field: "max_submit_cnt", title: "최대제출횟수", width : "8%", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "user_submit_cnt", title: "현재제출횟수", width : "8%", attributes : { style : "text-align: center;" }, filterable: false },
				{ field : "submit_from", title : "제출시작", width : 150, attributes : {	style : "text-align: center;" }, filterable: false,
					template : "#= (submit_from == '') ? '' : kendo.toString(new Date(Number(submit_from)), 'yyyy-MM-dd HH:mm') #" },
				{ field : "submit_to", title : "제출마감", width : 150, attributes : {	style : "text-align: center;" }, filterable: false,
					template : "#= (submit_to == '') ? '' : kendo.toString(new Date(Number(submit_to)), 'yyyy-MM-dd HH:mm') #" }
			],
			editable: false,
			noRecords: {
				template: "현재 진행중인 문제가 없습니다."
            },
            change: function(e) {
				console.log("deploy-grid:change");
				var selectedItem = this.dataItem(this.select());
				G_Seq = selectedItem.deploy_seq; 
				console.log("selected item: " + G_Seq + "(seq)");
                // open window
        		wnd.center().open();
            },
            dataBound: function(e) {
            	console.log("deploy-grid:dataBound");
            }
		});
		
		/*
		 * view model for window data 
		 */
		questionModel = kendo.data.Model.define({
			id: "deploy_seq",
			fields: {
				deploy_seq			:{ type: "number" },
				question_seq		:{ type: "number" },
				title				:{ type: "string" },
				question_title		:{ type: "string" },
				question			:{ type: "string" },
				question_io			:{ type: "string" },
				question_example	:{ type: "string" },
				question_hint		:{ type: "string" },
				lang_type			:{ type: "string" },
				submit_from			:{ type: "string" },
				submit_to			:{ type: "string" },
				max_submit_cnt		:{ type: "number" },
				user_submit_cnt		:{ type: "number" },
				timeout				:{ type: "number" },
				max_codesize		:{ type: "number" },
				ban_keyword			:{ type: "string" },
				answer				:{ type: "string" }
			}
		});
		
	    /*** dataSource ***/
		questionViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: {
						url: crudServiceBaseUrl + "/readDeployedQuestionDetailByUser.do",
		    			dataType: "jsonp",
		    			complete: function(e){ 
		    				console.log("questionViewModel:dataSource:read:complete");
		    			}
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
								deploy_seq: G_Seq
							};
							return { params: kendo.stringify(result) }; 
						}
					}
				},
				batch: true,
				schema: {
					model: questionModel,
					parse: function(response) {
						console.log("questionViewModel:dataSource:schema:parse");
                    	return response;
					},
					errors: function(response) {
						console.log("questionViewModel:dataSource:schema:error");
						return response.error;
					},
					data: function(response) {
						console.log("questionViewModel:dataSource:schema:data");
// 						if(typeof response != "undefined") {
// 							setCodeEditorValue(response.answer);
// 							setTimeout(function() {
// 		            			editor.refresh();
// 		            		}, 1);
// 						} 
						return response;
					}
				},
		        error : function(e) {
		        	console.log("questionViewModel:dataSource:error");
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("questionViewModel:dataSource:change");
		        	console.log("set data(selected)");
		            var _data = this.data()[0];
					console.log(_data);
					if(typeof _data != "undefined") {
						_data.submit_from = new Date(Number(_data.submit_from));
						_data.submit_to = new Date(Number(_data.submit_to));
					}
					questionViewModel.set("selected", _data);
		        }
			}),
			error : function(e) {
	        	console.log("questionViewModel:error");
            	console.log(e);
            },
            change: function(e) {
            	console.log("questionViewModel:change");
            },
            batch: true,
            selected: null,
            hasChanges: false,
            submit: function (e) {
            	console.log("questionViewModel:submit");
//             	console.log(getCodeEditorValue());
				if(confirm("답안이 제출되면 제출회수가 증가하며 취소할 수 없습니다.\n답안을 제출하시겠습니까?")) {
					$('#answer_form').submit();
				}
            },
            cancel: function(e) {
            	console.log("questionViewModel:cancel");
                this.dataSource.cancelChanges();
                wnd.close();
            }
		});
	    
	    // binding data to window
		kendo.bind($("#window"), questionViewModel);
	});//document ready javascript end...
</script>

<style>
	.k-edit-form-container {
		width: 100%;
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