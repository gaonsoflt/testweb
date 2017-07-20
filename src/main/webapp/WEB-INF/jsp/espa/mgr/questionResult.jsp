<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../inc/header.jsp"%>
<%@ include file="../../inc/aside.jsp"%>

		<div class="topbar-left">
			<ol class="breadcrumb">
				<li class="crumb-active">
					<a href="<c:url value='${menu.menu_url}'/>">${menu.menu_nm}</a>
				</li>
				<li class="crumb-link">
					<a href="#">${menu.main_nm}</a>
				</li>
				<li class="crumb-trail">${menu.menu_nm}</li>
			</ol>
		</div>
		<div class="topbar-right">
			<div class="ib topbar-dropdown">
				<label for="topbar-multiple" class="control-label pr10 fs11 text-muted">${menu.menu_desc}</label>
			</div>
		</div>
	</header>
	<!-- Main content -->
	<section id="content" class="table-layout animated fadeIn">
		<div class="row">
			<div class="col-md-12">
				<div>
					<button type="button" id="list-btn" onclick="fn_list();"><spring:message code="button.list" text="list" /></button>
				</div>
				<table class="mytable" style="width:100%;">
					<colgroup>
						<col width="50%">
						<col width="50%">
					</colgroup>
					<tbody>
						<tr>
							<td>
								<label class="col-sm-3 control-label"><spring:message code="grading.title"/></label>
								<div class="col-sm-6">${depQuesInfo.title}</div>
							</td>
							<td>
								<label class="col-sm-3 control-label"><spring:message code="grading.period"/></label>
								<div class="col-sm-6">${depQuesInfo.submit_from} ~ ${depQuesInfo.submit_to}</div>
							</td>
						</tr>
						<tr>
							<td>
								<label class="col-sm-3 control-label"><spring:message code="grading.group"/></label>
								<div class="col-sm-6">${depQuesInfo.group_name}</div>
							</td>
							<td>
								<label class="col-sm-3 control-label"><spring:message code="grading.language"/></label>
								<div class="col-sm-6">${depQuesInfo.lang_type}</div>
							</td>
						</tr>
						<tr>
							<td>
								<label class="col-sm-3 control-label"><spring:message code="grading.status"/></label>
								<div class="col-sm-6">${depQuesInfo.status}</div>
							</td>
							<td>
								<label class="col-sm-3 control-label"><spring:message code="grading.rate"/></label>
								<div class="col-sm-6">${depQuesInfo.submit_user} / ${depQuesInfo.candidate} (${depQuesInfo.submit_rate}%) </div>
							</td>
						</tr>
					</tbody>
				</table>
				<div id="grid-users"></div>
			</div>
		</div>
	</section>
</section>

<div id="window" style="display:none;">
	<div>
		<button type="button" onclick="fn_closeWindow();" ><spring:message code="button.close"/></button>
	</div>
	<div>
		<div style="width:400px;height:100%;float:left;">
			<h3><spring:message code="grading.dlg.leftTitle"/></h3>
			<div id="grid-answer-his"></div>
	    </div>
	    <div id="panel_detail" style="min-width:700px;height:100%;float:left;">
			<h3><spring:message code="grading.dlg.rightTitle"/></h3>
		    <div id="grid-grading-his"></div>
			<div style="height:100%;">
			    <textarea id="answer" name="answer" class="form-control" style="width:100%;height:100%;""></textarea>
		    </div>
		</div>
	</div>
</div>
  

<script>
	/* DropDownList Template */
	var wnd;
	var G_SEQ = 0;
	var editor;
	
	function fn_list() {
		location.href='${contextPath}/mgr/question/deploy/result.do';	
	}
	
	function fn_closeWindow() {
		$("#window").data("kendoWindow").close();
	}
	
	function fn_getUserGrading(submitDT) {
		console.log("fn_getUserGrading");
		$.ajax({
			type : "post",
			url : "<c:url value='/mgr/question/deploy/result/user/grading.do'/>",
			data : {
				"user_seq" : G_SEQ,
				"deploy_seq" : "${deploy_seq}",
				"submit_dt" : submitDT
			},
			async : false, //동기 방식
			success : function(data, status) {
				console.log(data.result);
				var msg = "";
				if(data.result.err_code == null) {
					msg += "<table class='table'><tbody>";
					var th = "<tr><th><spring:message code='grading.questionOrder'/></th>";
					var td_score = "<tr><th><spring:message code='grading.score'/></th>";
					var td_exectime = "<tr><th><spring:message code='grading.exectime'/></th>";
					data.result.grading.forEach(function( v, i ){
						th += "<th>" + (i + 1) + "</th>";
						td_score += "<td>" + v.score + "</td>";
						td_exectime += "<td>" + v.exec_time + " ms</td>";
					});
					th += "</tr>";
					td_score += "</tr>";
					td_exectime += "</tr>";
					msg += th + td_score+ td_exectime;
					msg += "</tbody></table>";
				} else {
					msg += "<strong>ERROR: </strong>" + data.result.err_msg + "(" + data.result.err_code + ")";					
				}
			    document.getElementById("grid-grading-his").innerHTML = msg;
				
				if(data.result.answer != null) {
					editor.getDoc().setValue(data.result.answer);
				} else {
					editor.getDoc().setValue("");
				}
			},
			fail : function(data) {
			},
			complete : function(data) {
			}
		});
	}
	
	$(document).ready(function() {
		/*************************/
		/* deatils window
		/*************************/
		wnd = $("#window").kendoWindow({
            title: "<spring:message code='grading.dlg.title'/>",
            width: 1200,
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
        		$("#grid-answer-his").data("kendoGrid").dataSource.read();
				document.getElementById("grid-grading-his").innerHTML = "";
			    editor.getDoc().setValue("");
            },
            close: function() {
            	console.log("window.close");
        		G_SEQ = 0;
            }
        }).data("kendoWindow");
		
		editor = CodeMirror.fromTextArea(document.getElementById('answer'), {
			lineNumbers: true
		});
		  
		/*************************/
		/* dataSgrid-usersDetail */
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/mgr/question/deploy/result";
		$("#grid-users").kendoGrid({
			dataSource: {
				transport: {
					read	: { 
						url: crudServiceBaseUrl + "/user.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("grid-users:dataSource:read:complete");
					    	console.log(e);
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
		                   		deploy_seq : "${deploy_seq}"
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
						id: "user_seq",
						fields: {
							user_seq		: { type: "number" },
							user_name		: { type: "string" },
							user_id			: { type: "string" },
							submit_dt		: { type: "string" },
							score			: { type: "number" },
							user_submit_cnt : { type: "number" }
						}  
					}
				},
		        error : function(e) {
			    	console.log('grid-users:dataSource:error: ' + e.errors);
		        },
		        batch : true,
				page : 1, //     반환할 페이지
				pageSize : 15, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 15
			},
			height: 710,
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
				{ field: "user_seq", hidden: true },
				{ field: "user_id", title: "<spring:message code="grading.userID" />", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "user_name", title: "<spring:message code="grading.userName" />", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "user_submit_cnt", title: "<spring:message code="grading.submitCnt" />", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "score", title: "<spring:message code="grading.score" />", attributes : { style : "text-align: center;" }, filterable: false },
				{ field : "submit_dt", title : "<spring:message code="grading.submitDT" />", width : 150, attributes : {	style : "text-align: center;" }, filterable: false,
					template : "#= (submit_dt == '') ? '<spring:message code="grading.noSubmit" />' : kendo.toString(new Date(Number(submit_dt)), 'yyyy-MM-dd HH:mm:ss') #" }
			],
			editable: false,
			noRecords: {
				template: "<spring:message code='grading.grid.noRecords'/>"
            },
            change: function(e) {
				console.log("grid-users:change");
				var selectedItem = this.dataItem(this.select());
				G_SEQ = selectedItem.user_seq; 
				console.log("selected item: " + G_SEQ + "(seq)");
                // open window
        		wnd.center().open();
            },
            dataBound: function(e) {
            	console.log("grid-users:dataBound");
            }
		});
		
		$("#grid-answer-his").kendoGrid({
			dataSource: {
				transport: {
					read	: { 
						url: crudServiceBaseUrl + "/user/answer.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("grid-answer-his:dataSource:read:complete");
					    	console.log(e);
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
		                   		user_seq : G_SEQ,
		                   		deploy_seq : "${deploy_seq}"
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
						id: "submit_dt",
						fields: {
							rnum			: { type: "number", editable: false },
							score			: { type: "number", editable: false },
							avg_exectime	: { type: "number", editable: false },
							submit_dt		: { type: "string", editable: false }
						}  
					}
				},
		        error : function(e) {
			    	console.log('grid-answer-his:dataSource:error: ' + e.errors);
		        },
		        batch : true,
				page : 1, //     반환할 페이지
				pageSize : 15, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 15
			},
			height: 700,
			resizable: true,  //컬럼 크기 조절
			reorderable: false, //컬럼 위치 이동
			autoBind: false,
			navigatable: true,
			selectable: "row",
			scrollable: true,
			sortable : true,
			mobile: true,
			pageable : false,
			filterable: false,
            toolbar: false,
			columns: [
				{ field: "rnum", title: "<spring:message code="grading.submitCnt" />", width : 80, attributes : { style : "text-align: center;" } },
				{ field : "submit_dt", title : "<spring:message code="grading.submitDT" />", width : 150, attributes : {	style : "text-align: center;" },
					template : "#= (submit_dt == '') ? '<spring:message code="grading.noSubmit" />' : kendo.toString(new Date(Number(submit_dt)), 'yyyy-MM-dd HH:mm:ss') #" },
				{ field: "score", title: "<spring:message code="grading.score" />", width : 70, attributes : { style : "text-align: center;" } },
 				{ field: "avg_exectime", title: "<spring:message code="grading.avgExectime" />", attributes : { style : "text-align: center;" },
 					template : "#= avg_exectime # ms" }

			],
			editable: false,
			noRecords: {
				template: "<spring:message code='grading.dlg.grid.noRecords'/>"
            },
            change: function(e) {
				console.log("grid-answer-his:change");
				var selectedItem = this.dataItem(this.select());
				console.log("selected item: " + selectedItem.submit_dt + "(seq)");
				fn_getUserGrading(selectedItem.submit_dt);
            },
            dataBound: function(e) {
            	console.log("grid-answer-his:dataBound");
            }
		});
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
	.CodeMirror {
    	height: 550px;
	}
/* 	.mytable { border-collapse:collapse; }   */
/* 	.mytable th, .mytable td { border:1px solid black; } */
</style>
<%@ include file="../../inc/footer.jsp"%>