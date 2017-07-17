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
						<div id="deploy-grid"></div>
                	</div>
               	</div>
			</div>
		</div>
	</section>
</div>

<div id="window" style="display:none;">
	<div>
		<button id="delete-btn" data-role="button" data-icon="close" data-bind="click: remove" style="float:right;margin:10px 10px 0 0;">삭제</button>
		<button id="save-btn" data-role="button" data-icon="pencil" data-bind="click: save" style="float:right;margin:10px 10px 0 0;">저장</button>
		<button id="cancel-btn" data-role="button" data-icon="cancel" data-bind="click: cancel" style="float:right;margin:10px 10px 0 0;">취소</button>
	</div>
	<table style="width:100%;">
		<colgroup>
			<col width="30%">
			<col width="70%">
		</colgroup>
		<tbody>
			<tr>
				<th>제목</th>
				<td>
					<input id="title" name="title" data-role="maskedtextbox" data-bind="value:selected.title" style="width:100%;"/>
				</td>
			</tr>
			<tr>
				<th>그룹</th>
				<td>
					<select id="groups" name="groups" data-bind="value:selected.groups" required style="width:100%;"></select>
					<input id="group" name="group" data-role="maskedtextbox" data-bind="value:selected.group_name" readonly="readonly" style="width:100%;display:none;background:#ccc;"/>
				</td>
			</tr>
			<tr>
				<th>문제</th>
				<td>
					<button id="findQuestionBtn" type="button">검색</button>
				</td>
			</tr>
			<tr>
				<th>문제제목</th>
				<td>
					<input id="question_title" name="question_title" data-role="maskedtextbox" data-bind="value:selected.question_title" readonly="readonly" style="width:100%;background:#ccc;"/>
				</td>
			</tr>
			<tr>
				<th>문제언어</th>
				<td>
					<input id="question_language" name="question_language" data-role="maskedtextbox" data-bind="value:selected.question_language" readonly="readonly" style="width:100%;background:#ccc;"/>
				</td>
			</tr>
			<tr>
				<th>제출시작</th>
				<td><input id="submit_from" name="submit_from" data-role="datetimepicker" data-bind="value:selected.submit_from" data-format="yyyy-MM-dd HH:mm tt" required style="width:100%;"/></td>
			</tr>
			<tr>
				<th>제출마감</th>
				<td><input id="submit_to" name="submit_to" data-role="datetimepicker" data-bind="value:selected.submit_to" data-format="yyyy-MM-dd HH:mm tt" required style="width:100%;"/></td>
			</tr>
			<tr>
				<th>최대제출횟수</th>
				<td><input id="max_submit_cnt" name="max_submit_cnt" data-role="numerictextbox" data-bind="value:selected.max_submit_cnt" data-format="n0" required style="width:95%;"/>회</td>
			</tr>
		</tbody>
	</table>
</div>

<div id="result-window" style="display:none;">
	<div>
		<p id="searchArea" style="padding: 10px 0px;">
		검색
			<input id="in_search" /> 
			<input id="in_keyword" /> 
			<button id="searchBtn" type="button">조회</button>
		</p>
	</div>
	<div>
		<div id="result-grid"></div>
	</div>
</div>

<script type="text/x-kendo-template" id="toolbar-template">
	<div id="toolbar" style="float:left;">
		<a href="\\#" class="k-pager-refresh k-link k-button" id="add-btn" title="Create" onclick="return onClick(this);">추가</a>
	</div>
</script>    

<script>
	var G_DEPLOYSEQ;
	var G_Condition = "ALL";
	var G_Keyword = ""; 
	var wnd;
	var temp;
	
	$(function() {
		var searchData = [ 
			{ text : "전체", value : "ALL" }, 
			{ text : "제목", value : "TITLE" }, 
			{ text : "언어", value : "LANG_TYPE" }
		];
	
		$("#in_search").kendoComboBox({
			dataTextField : "text",
			dataValueField : "value",
			dataSource : searchData,
			change : function() {
				G_Condition = $("#in_search").val();
				console.log("combobox change: " + G_Condition);
				if (G_Condition == "ALL") {
					$("#in_keyword").css({ "display" : "none" });
				} else {
					G_Keyword = "";
					$("#in_keyword").val("");
					$("#in_keyword").css({ "display" : "inline-block" });
				}
			},
			index : 0
		});

		/* 키워드 */
		$("#in_keyword").kendoMaskedTextBox({
			change : function(e) {
				G_Keyword = this.value();
			}
		});
		
		/* 조회 */
		$("#searchBtn").kendoButton({
			icon : "search",
			click : function(e) {
				$("#result-grid").data("kendoGrid").dataSource.read();
			}
		});
		
		/* 조회 */
		$("#findQuestionBtn").kendoButton({
			icon : "search",
			click : function(e) {
				// open result window
				$("#result-window").data("kendoWindow").center().open();
			}
		});
	});
	
	function addNew(e) {
		// invisible delete button
		$("#window .k-multiselect").css({ "display" : "inline-block" });
		$("#group").css({ "display" : "none" });
		$("#save-btn").css("display", "inline-block");
		$("#delete-btn").css("display", "none");
		
		// open window
		wnd.center().open();		
		deployViewModel.set("selected", new deployModel());
		deployViewModel.dataSource.insert(0, deployViewModel.selected);
		return false;
	}
	
	function onClick(e) {
		var id = e.id;
		console.log(id + " is clicked");
		if(id == 'add-btn') {
			console.log("add deployViewModel");
			addNew(e);
		} 
    }
	
	function closeWindow(e) {
		wnd.close();
		G_DEPLOYSEQ = 0;
		$("#deploy-grid").data("kendoGrid").dataSource.read();
	}
	
	function closeResultWindow(e) {
		$("#result-window").data("kendoWindow").close();
		$("#max_submit_cnt").data("kendoNumericTextBox").focus();
	}

	$(document).ready(function () {
		wnd = $("#window").kendoWindow({
            title: "",
            width: 600,
            actions: [
				"Pin",
				"Minimize",
				"Maximize",
				"Close"
			],
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow");
		
	    var crudServiceBaseUrl = "${contextPath}/mgr/question/deploy";
		$("#deploy-grid").kendoGrid({
			dataSource: {
				transport: {
					read	: { 
						url: crudServiceBaseUrl + "/list.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("deploy-grid:dataSource:read:complete");
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
	                   			PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take
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
							deploy_seq:		{ type: "number" },
							question_seq:	{ type: "number" },
							group_name:		{ type: "string" },
							title:			{ type: "string" },
							status:			{ type: "string" },
							lana_type:		{ type: "string" },
							candidate:		{ type: "number" },
							submit_from:	{ type: "string" },
							submit_to:		{ type: "string" },
							max_submit_cnt:	{ type: "number" }
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
			filterable: true,
			pageable : {
				pageSizes : true,
				messages : {
					display : "전체 {2} 중 {0}~{1}",
					empty : "출력할 항목이 없습니다",
					itemsPerPage : "한 페이지 출력 수"
				}
			},
            toolbar: kendo.template($("#toolbar-template").html()),
			columns: [
				{ field: "deploy_seq", hidden: true },
				{ field: "group_name", title: "배포그룹", attributes : { style : "text-align: center;" },
					filterable: { 
                        dataSource: {
                            transport: {
                                read: {
                                    url: "${contextPath}/mgr/question/deploy/groups.do",
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
				{ field: "status", title: "상태", attributes : { style : "text-align: center;" },
					filterable: { 
                        dataSource: new kendo.data.DataSource({
                            data: [
								{"status":"대기"},
								{"status":"마감"},
								{"status":"진행중"}
							]
                        }),
                        multi: true 
                    }
				},
				{ field: "question_seq", title: "문제ID", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "question_title", title: "문제제목", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "question_language", title: "언어", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "max_submit_cnt", title: "최대제출횟수", attributes : { style : "text-align: center;" }, filterable: false },
				{ field: "candidate", title: "응시자", width : 80, attributes : { style : "text-align: center;" }, filterable: false },
				{ field : "submit_from", title : "제출시작", width : 150, attributes : {	style : "text-align: center;" }, filterable: false,
					template : "#= (submit_from == '') ? '' : kendo.toString(new Date(Number(submit_from)), 'yyyy-MM-dd HH:mm') #" },
				{ field : "submit_to", title : "제출마감", width : 150, attributes : {	style : "text-align: center;" }, filterable: false,
					template : "#= (submit_to == '') ? '' : kendo.toString(new Date(Number(submit_to)), 'yyyy-MM-dd HH:mm') #" }
			],
			editable: false,
			noRecords: {
				template: "검색된 결과가 없습니다."
            },
            change: function(e) {
				console.log("user-grid:change");
				var selectedItem = this.dataItem(this.select());
				G_DEPLOYSEQ = selectedItem.deploy_seq; 
				console.log("selected item: " + G_DEPLOYSEQ + "(seq)");
				deployViewModel.dataSource.read();
				if(selectedItem.status == '마감') {
					$("#save-btn").css("display", "none");
					$("#delete-btn").css("display", "none");
				} else if(selectedItem.status == '진행중') {
					$("#save-btn").css("display", "inline-block");
					$("#delete-btn").css("display", "none");
				} else {
					$("#save-btn").css("display", "inline-block");
					$("#delete-btn").css("display", "inline-block");
				}
				$("#window .k-multiselect").css({ "display" : "none" });
				$("#group").css({ "display" : "inline-block" });
                // open window
        		wnd.center().open();
            },
            dataBound: function(e) {
            	console.log("user-grid:dataBound");
            }
		});
		
		deployModel = kendo.data.Model.define({
			id: "deploy_seq",
			fields: {
				deploy_seq			:{ type: "number" },
				title				:{ type: "string", validation: { required: true } },
				question_seq		:{ type: "number", validation: { required: true } },
				group_id			:{ type: "string", validation: { required: true } },
				group_name			:{ type: "string" },
				question_title		:{ type: "string" },
				question_language	:{ type: "string" },
				submit_from			:{ defaultValue: kendo.toString(new Date(), "yyyy-MM-dd HH:mm"), validation: { required: true } },           
				submit_to			:{ defaultValue: kendo.toString(new Date(), "yyyy-MM-dd HH:mm"), validation: { required: true } },
				max_submit_cnt		:{ type: "number", defaultValue: 10, validation: { required: true, min: 1 } }           
			}	
		});
		
	    /*** dataSource ***/
		deployViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: {
						url: crudServiceBaseUrl + "/read.do",
		    			dataType: "jsonp",
		    			complete: function(e){ 
		    				console.log("deployViewModel:dataSource:read:complete");
		    			}
					},
					update: { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					destroy: { url: crudServiceBaseUrl + "/delete.do", dataType: "jsonp" },
					create: { url: crudServiceBaseUrl + "/create.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
		                   	var result = {
								deploy_seq: G_DEPLOYSEQ
							};
							return { params: kendo.stringify(result) }; 
						}
		               
						if (type !== "read" && data.models) {
							// if using kendo.stringify, convert datetime from UTC timezone
							data.models[0].submit_from = kendo.toString(data.models[0].submit_from, "yyyy-MM-dd HH:mm");
							data.models[0].submit_to= kendo.toString(data.models[0].submit_to, "yyyy-MM-dd HH:mm");
							return { models: kendo.stringify(data.models) };
						}
					}
				},
				batch: true,
				schema: {
					model: deployModel,
					data: function(response) {
						console.log("deployViewModel:dataSource:data");
						console.log(response.rtnList);
						return response.rtnList;
					},
					total: function(response) {
						console.log("deployViewModel:dataSource:total: " + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("deployViewModel:dataSource:error: " + response.error);
						return response.error;
					},
					parse: function(response) {
						console.log("deployViewModel:dataSource:parse: ");
                    	return response;
					}
				},
		        error : function(e) {
			    	console.log('deployViewModel:dataSource:error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("deployViewModel:dataSource:change: set selected :");
		            var _data = this.data()[0];
					console.log(_data);
					if(typeof _data != "undefined") {
						_data.submit_from = new Date(Number(_data.submit_from));
						_data.submit_to = new Date(Number(_data.submit_to));
					} else {
					}
					deployViewModel.set("selected", _data);
		        },
		        requestEnd: function(e) {
		        	console.log("deployViewModel:dataSource:requestEnd");
		        	if(e.type != 'read' && e.response.error == null) {
		        		alert("정상적으로 처리되었습니다.");	
		        	} 
		        },
		        sync: function(e) { 
		        	console.log("deployViewModel:dataSource:sync");
     			    console.log(this.data()[0]);
					closeWindow(e);
				},
				dataBound: function(e){ 
					console.log("deployViewModel:dataSource:dataBound");
				}
			}),
			error : function(e) {
            	console.log("deployViewModel:error" + e.errors);
            },
            change: function(e) {
            	console.log("deployViewModel:change");
            },
            batch: true,
            selected: null,
            hasChanges: false,
            save: function (e) {
				console.log("deployViewModel:save");
				var from = $("#submit_from").data("kendoDateTimePicker").value();
				var to= $("#submit_to").data("kendoDateTimePicker").value();
				if(from >= to) {
					alert("제출마감은 제출시작 이전일 수 없습니다.");
		    	   	e.preventDefault();						
				} else {
					console.log(deployViewModel.dataSource.data()[0]);
					deployViewModel.dataSource.data()[0].set("submit_from", from);
					deployViewModel.dataSource.data()[0].set("submit_to", to);
					this.dataSource.sync();
				}
            },
            remove: function(e) {
            	console.log("deployViewModel:remove");
                if (confirm("삭제하시겠습니까?")) {
                	console.log("remove");
                    this.dataSource.remove(this.dataSource.data()[0]);
                    this.dataSource.sync();
					closeWindow();
                }
            },
            cancel: function(e) {
            	console.log("deployViewModel:cancel");
                this.dataSource.cancelChanges();
                closeWindow();
            }
		});
	    
	    // binding data to window
		kendo.bind($("#window"), deployViewModel);
	    
	    $("#groups").kendoMultiSelect({
			placeholder: "배포할 그룹을 선택하세요.",
            dataTextField: "cd_nm",
            dataValueField: "cd_id",
            autoBind: false,
            autoClose: true,
            dataSource: {
                transport: {
					read : { 
						url: "${contextPath}/sm/code" + "/readDetails.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("groups:multiselect:dataSource:read:complete");
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
	                       	var result = {
								CATGR: "100462" // 100462=_USER_GROUP_
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
						id: "cd",
						fields: { 
							cd		: { type: "string" },
							cd_nm	: { type: "string" },
							cd_id	: { type: "string" }
						}  
					}
				}
            }
		});
	    
	    $("#result-window").kendoWindow({
            title: "문제 검색",
            width: 1100,
            actions: [
				"Pin",
				"Minimize",
				"Maximize",
				"Close"
			],
            modal: true,
            visible: false,
            resizable: true,
            open: function() {
            	console.log("result-window:open");
            },
            close: function() {
            	console.log("result-window:close");
            }
        }).data("kendoWindow");
	
	    $("#result-grid").kendoGrid({
			dataSource: {
				transport: {
					read	: { 
						url: "${contextPath}/mgr/question/list.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("result-grid:dataSource:read:complete");
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
	                   			PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take,
								CONDITION : G_Condition,
								KEYWORD : G_Keyword
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
						id : "question_seq",
						fields : {
							question_seq : { type : "number", editable : false }, //data type of the field {Number|String|Boolean|Date} default is String
							title : { type : "string", editable : false },
							reg_dt : { type : "string", editable : false },
							lang_type : { type : "string", editable : false },
							user_name : { type : "string", editable : false }
						}
					}
				},
		        error : function(e) {
			    	console.log('result-grid:dataSource:error: ' + e.errors);
		        },
		        batch : true,
				page : 1, //     반환할 페이지
				pageSize : 15, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 15
			},
			height: 600,
			resizable: true,  //컬럼 크기 조절
			reorderable: false, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row",
			scrollable: true,
			sortable : true,
			mobile: true,
			pageable : {
				pageSizes : true,
				messages : {
					display : "전체 {2} 중 {0}~{1}",
					empty : "출력할 항목이 없습니다",
					itemsPerPage : "한 페이지 출력 수"
				}
			},
            toolbar: false,
            columns : [
				{ field : "question_seq", title : "번호", width : 100, attributes : { style : "text-align: center;" } },
				{ field : "title", title : "제목", attributes : { style : "text-align: center;" } },
				{ field : "lang_type", title : "사용언어", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "user_name", title : "등록자", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "reg_dt", title : "등록일", width : 150, attributes : {	style : "text-align: center;" },
					template : "#= (reg_dt == '') ? '' : kendo.toString(new Date(Number(reg_dt)), 'yyyy-MM-dd') #" }
      		],
			editable: false,
			noRecords: {
				template: "검색된 결과가 없습니다."
            },
            change: function(e) {
				console.log("result-grid:change");
            },
            dataBound: function(e) {
            	var grid = $("#result-grid").data("kendoGrid");
            	console.log("result-grid:dataBound");
            	$(this.tbody).on("dblclick", "td", function (e) {
            		var selectedItem = grid.dataItem(grid.select());
    				console.log("selected item: " + selectedItem.question_seq + "(seq)");
//     				if(confirm("[" + selectedItem.question_seq + "] 를 선택하시겠습니까?")) {
						deployViewModel.dataSource.data()[0].set("question_seq", selectedItem.question_seq);
	    		        document.getElementById("question_title").value = selectedItem.title;
	    		        document.getElementById("question_language").value = selectedItem.lang_type;
	    		        closeResultWindow();
//     				}
			    });
            }
		});
	});	
</script>	
<style>
	.k-grid table {
		table-layout: fixed;
	}
	#in_keyword {
		display: none;
	}
</style>
<%@ include file="../../inc/footer.jsp"%>