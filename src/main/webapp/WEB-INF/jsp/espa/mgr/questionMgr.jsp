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
						<!-- jQuery Plug-Ins Widget Initialization -->
						<p id="searchArea" style="font-size: 15px; padding: 10px 0px;">
							검색&nbsp;&nbsp;&nbsp;&nbsp;
							<input id="in_search" /> 
							<input id="in_keyword" /> 
							<input id="in_searchDate" />
							<input id="in_user" /> 
							<button id="searchBtn" type="button">조회</button>
						</p>
						<div id="gridList"></div>
					</div>
				</div> <!-- box -->
			</div> <!-- col-xs-12 -->
		</div> <!-- row -->
	</section>
</div>

<div id="window" style="display:none;">
	<div>
		<button id="delete-btn" class="k-primary" data-bind="click: remove" style="float:right;margin:10px 10px 0 0;">삭제</button>
		<button id="save-btn" class="k-primary" data-bind="click: save" style="float:right;margin:10px 10px 0 0;">저장</button>
		<button id="cancel-btn" class="k-primary" data-bind="click: cancel" style="float:right;margin:10px 10px 0 0;">취소</button>
	</div>
	<table style="width:100%;">
		<colgroup>
			<col width="25%">
			<col width="25%">
			<col width="50%">
		</colgroup>
		<tbody>
			<tr class="modify">
				<th>등록자</th>
				<th>수정일</th>
			</tr>
			<tr class="modify">
				<td><input id="reg-usr" name="reg-usr" data-bind="value:selected.user_name" style="width:100%;" readonly/></td>
				<td><input id="mod-dt" name="mod-dt" data-bind="value:selected.mod_dt" style="width:100%;" readonly/></td>
				<td>
			</tr>
			<tr>
				<th colspan="2">제목</th>
				<td rowspan="10" style="vertical-align:top;height:100%;">
					<div id="tabstrip" style="height:100%;">
						<ul>
							<li class='k-state-active'>기본설정</li>
							<li>채점데이터</li>
							<li>테스트코드</li>
						</ul>
						<div>
							<div id="baseconfig">
								<table style="width:100%;">
									<tr><th>사용언어</th></tr>
									<tr><td><input id="lang-type" name="lang-type" style="width:100%;" required/></td></tr>
									<tr><th>최대 코드 사이즈</th></tr>
									<tr><td><input id="max_codesize" name="max_codesize" data-role="numerictextbox" data-format="n0" data-bind="value:selected.max_codesize" style="width:90%"/>byte</td></tr>
									<tr><th>실행시간(timeout)</th></tr>
									<tr><td><input id="timeout" name="timeout" data-role="numerictextbox" data-format="n0" data-bind="value:selected.timeout" style="width:90%"/>ms</td></tr>
									<tr><th>금지어(, 로 구분)</th></tr>
									<tr><td><input id="ban_keyword" name="ban_keyword" data-role="maskedtextbox" data-bind="value:selected.ban_keyword" style="width:100%" /></td></tr>
<!-- 									<tr><th>제약조건</th></tr> -->
<!-- 									<tr><td><div id="gridCondition" style="width:100%;height:100%"></div></td></tr> -->
								</table>
							</div>
						</div>
						<div>
							<div id="gradedata">
								<button id="test-btn" type="button" onclick="startTest()">테스트시작</button>
								<div><span id="exec-msg"></span></div>
								<div id="gridGrading"></div>
							</div>
						</div>
						<div>
							<div id="testcode">
								<textarea id="test-code" name="test-code" placeholder="테스트에 사용할 코드를 입력하세요."></textarea>
							</div>
						</div>
					</div>
				</td>	
			</tr>
			<tr><td colspan="2"><input id="title" name="title" data-role="maskedtextbox" data-bind="value:selected.title" style="width:100%;" required/></td></tr>
			<tr><th colspan="2">문제</th></tr>
			<tr><td colspan="2"><textarea id="con-question" name="con-question" data-bind="value:selected.con_question" placeholder="문제를 입력하세요." style="width:100%;height:200px;"></textarea></td></tr>
			<tr><th colspan="2">입출력</th></tr>
			<tr><td colspan="2"><textarea id="con-io" name="con-io" data-bind="value:selected.con_io" placeholder="입출력 내용을 입력하세요." style="width:100%;height:200px;"></textarea></td></tr>
			<tr><th colspan="2">예제</th></tr>
			<tr><td colspan="2"><textarea id="con-example" name="con-example" data-bind="value:selected.con_example" placeholder="예제를 입력하세요." style="width:100%;height:200px;"></textarea></td></tr>
			<tr><th colspan="2">힌트</th></tr>
			<tr><td colspan="2"><textarea id="con-hint" name="con-hint" data-bind="value:selected.con_hint" placeholder="힌트를 입력하세요." style="width:100%;height:200px;"></textarea></td></tr>
		</tbody>
	</table>
</div>

<script type="text/x-kendo-template" id="toolbar-template">
	<div id="toolbar" style="float:left;">
		<a href="\\#" class="k-pager-refresh k-link k-button" id="add-btn" title="Create" onclick="return onClick(this);">추가</a>
	</div>
</script>                

<!-- grading popup editor template -->
<script id="popup_editor" type="text/x-kendo-template">
	<div>
	    <p>채점데이터</p>
	    <table style="width:100%;">
        	<colgroup>
	            <col width="50%">
            	<col width="50%">
        	</colgroup>
        	<tr><th>문제번호</th></tr>
        	<tr>
	            <td colspan="2">
                	<input name="grading_order" data-bind="value:grading_order" data-type="number" data-role="numerictextbox" data-format="n0" data-min="1" data-max="100" required/>
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
	/* DropDownList Template */
	var codelist = "_USER_TYPE_,_CONDITION_";
	var codeModles = "";
	var questionViewModel;
	var questionModel;
	var wnd;
	
	var temp;
	
	$.ajax({
		type : "post",
		url : "<c:url value='/common/getCodeListByCdIDModel.do'/>",
		data : {
			"list" : codelist
		},
		async : false, //동기 방식
		success : function(data, status) {
			//codeModles = $.extend(codeModles, data.rtnList);
			codeModles = data.rtnList;
		},
		fail : function() {
		},
		complete : function() {
		}
	});

	function fnCodeNameByCdID(code) {
		var rtnVal = "";
		for (var i = 0; i < codeModles.length; i++) {
			if (codeModles[i].cd_id == code) {
				rtnVal = codeModles[i].cd_nm;
			}
		}
		return rtnVal;
	}
	
	function fnCodeNameByCd(code) {
		var rtnVal = "";
		for (var i = 0; i < codeModles.length; i++) {
			if (codeModles[i].cd == code) {
				rtnVal = codeModles[i].cd_nm;
			}
		}
		return rtnVal;
	}

	var G_Condition = "ALL";
	var G_Keyword = ""; 
	var G_Seq = 0;
	var editor;
	
	$(function() {
		var searchData = [ 
			{ text : "전체", value : "ALL" }, 
			{ text : "제목", value : "TITLE" }, 
			{ text : "등록자", value : "USER_NAME" }, 
			{ text : "등록일", value : "REG_DT" },
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
					$("#searchArea .k-autocomplete").css({ "display" : "none" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
				} else if (G_Condition == "REG_DT") {
					G_Keyword = "";
					$("#in_searchDate").data("kendoDatePicker").value(new Date());
					$("#searchArea .k-datepicker").css({ "display" : "inline-block" });
					$("#in_keyword").css({ "display" : "none" });
					$("#searchArea .k-autocomplete").css({ "display" : "none" });
					G_Keyword = kendo.toString(new Date(), "yyyy-MM-dd");
				} else if (G_Condition == "USER_NAME") {
					G_Keyword = "";
					$("#in_user").val("");
					$("#searchArea .k-autocomplete").css({ "display" : "inline-block" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
					$("#in_keyword").css({ "display" : "none" });
				} else {
					G_Keyword = "";
					$("#in_keyword").val("");
					$("#in_keyword").css({ "display" : "inline-block" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
					$("#searchArea .k-autocomplete").css({ "display" : "none" });
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
		
		/*검색일자*/
		$("#in_searchDate").kendoDatePicker({
			culture : "ko-KR",
			format : "yyyy/MM/dd",
			parseFormats : [ "yyyy-MM-dd" ],
			value : new Date(),
			change : function(e) {
				G_Keyword = kendo.toString(this.value(), "yyyy-MM-dd");
			}
		});
	
		/* 조회 */
		$("#searchBtn").kendoButton({
			icon : "search",
			click : function(e) {
				var gridList = $("#gridList").data("kendoGrid");
				gridList.dataSource.read();
			}
		});
	
		/* 사용자명 */
		$("#in_user").kendoAutoComplete({
			dataSource : {
				transport : {
					read : {
						url : "<c:url value='/common/getAutoComplete.do'/>",
						dataType : "jsonp"
					},
					parameterMap : function(data, type) {//type =  read, create, update, destroy
						var result = {
							TABLE : "TB_USER_INFO",
							COLUNM : "USER_NAME"
						};
						return { params : kendo.stringify(result) };
					}
				}
			},
			dataTextField : "cd_nm",
			dataBound : function(e) {
			},
			change : function(e) {
				G_Keyword = this.value();
			}
		});
	});
	
	function addNew(e) {
		// invisible elements(delete button, reg_usr, mod_dt)
		$("#delete-btn").css("display", "none");
		$("#test-btn").css("display", "none");
		document.getElementsByClassName("modify")[0].style.display = "none";
		document.getElementsByClassName("modify")[1].style.display = "none";
		
		// open window
		wnd.center().open();		
		questionViewModel.set("selected", new questionModel());
		questionViewModel.dataSource.insert(0, questionViewModel.selected);
		// clear test_code editor
		setCodeEditor("");
		// clear language(later)
		
		return false;
	}
	
	function onClick(e) {
		var id = e.id;
		console.log(id + " is clicked");
		if(id == 'add-btn') {
			console.log("add questionViewModel");
			addNew(e);
		} 
    }
	
	function getG_Seq() {
		return G_Seq;	
	}	
	
	function setCodeEditor(value) {
		editor.getDoc().setValue(value);
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
				"question_seq" : getG_Seq
			},
			async : false, //동기 방식
			success : function(data, status) {
				console.log(data);
				if(data.success) {
	        		$("#gridGrading").data("kendoGrid").dataSource.read();
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
		editor = CodeMirror.fromTextArea(document.getElementById('test-code'), {
			lineNumbers: false
		});

		/*************************/
		/* deatils window
		/*************************/
		wnd = $("#window").kendoWindow({
            title: "글쓰기",
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
            	console.log("window.open");
            	setExecMsg("");
        		// read question condition
//         		$("#gridCondition").data("kendoGrid").dataSource.read();
        		// read question grading data
        		$("#gridGrading").data("kendoGrid").dataSource.read();
            },
            close: function() {
            	console.log("window.close");
        		G_Seq = 0;
        		$("#gridList").data("kendoGrid").dataSource.read();
            }
        }).data("kendoWindow");

		$("#tabstrip").kendoTabStrip({
			height: 700,
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
		
		/*************************/
		/* dataSgridListDetail */
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/mgr/question",
		/*** dataSource ***/
		dataSourceDetail = new kendo.data.DataSource({
			transport : {
				read : { 
					url : crudServiceBaseUrl + "/readList.do", 
					dataType : "jsonp",
					complete: function(e){ 
				    	console.log("/readList.do...................");
				    }
				},
				create : {
					url : crudServiceBaseUrl + "/create.do", 
					dataType : "jsonp",
					complete: function(e){ 
				    	console.log("/create.do...................");
				    }
				},
				destory : {
					url : crudServiceBaseUrl + "/delete.do", 
					dataType : "jsonp",
					complete: function(e){ 
				    	console.log("/delete.do...................");
				    }
				},
				update : {
					url : crudServiceBaseUrl + "/update.do", 
					dataType : "jsonp",
					complete: function(e){ 
				    	console.log("/update.do...................");
				    }
				},
				parameterMap : function(data, type) {//type =  read, create, update, destroy
					if (type == "read") {
						var result = {
							PAGESIZE : data.pageSize,
							SKIP : data.skip,
							PAGE : data.page,
							TAKE : data.take,
							CONDITION : G_Condition,
							KEYWORD : G_Keyword
						};
						return { params : kendo.stringify(result) };
					}

					if (type !== "read" && data.models) {
						return {
							models : kendo.stringify(data.models)
						};
					}
				}
			},//transport end...
			schema : {
				data : function(response) {
					console.log(response.rtnList);
					return response.rtnList; 
				},
				total : function(response) { return response.total; },
				errors : function(response) { return response.error; },
				parse : function(response) {
					return response;
				},
				model : {//가져온 값이 있음...
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
				console.log(e.errors);
				alert(e.errors);
			},
			change : function(e) {
				//alert("change...........");
				/* var data = this.data();
				console.log(data.length);
				alert(data.length+"건 처리하였습니다."); */
			},
			sync : function(e) {
				console.log("sync complete");
				alert("정상적으로 처리되었습니다.");
			},
			serverPaging : true, // 서버 사이드 페이징 활성화
			serverFiltering : false,
			serverSorting : false, // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
			//autoSync: true,          //     자동 저장
			batch : true, //     true: 쿼리를 한줄로,  false : row 단위로
			page : 1, //     반환할 페이지
			pageSize : 15, //     반환할 항목 수
			skip : 0, //     건너뛸 항목 수
			take : 15
		});//datasource gridList end...

		/*************************/
		/***    gridList     ***/
		/*************************/
		$("#gridList").kendoGrid({
			autoBind : true,
			dataSource : dataSourceDetail,
			navigatable : true,
			pageable : true,
			height : 710,
            toolbar: kendo.template($("#toolbar-template").html()),
			columns : [
				{ field : "question_seq", title : "번호", width : 100, attributes : { style : "text-align: center;" } },
				// Todo: 제목 길이 제한 
				{ field : "title", title : "제목", attributes : { style : "text-align: center;" } },
				{ field : "lang_type", title : "사용언어", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "user_name", title : "등록자", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "reg_dt", title : "등록일", width : 150, attributes : {	style : "text-align: center;" },
					template : "#= (reg_dt == '') ? '' : kendo.toString(new Date(Number(reg_dt)), 'yyyy-MM-dd') #" }
			],
			change: function(e) {
        		// find seq value in selected row  	
				var selectedItem = this.dataItem(this.select());
				G_Seq = selectedItem.question_seq;
				console.log("selected item: " + G_Seq + "(seq)");
                console.log(selectedItem);
        		// read questionViewModel by G_Seq 
        		questionViewModel.dataSource.read();
        		$("#delete-btn").css("display", "inline-block");
        		$("#test-btn").css("display", "inline-block");
        		document.getElementsByClassName("modify")[0].style.display = "";
        		document.getElementsByClassName("modify")[1].style.display = "";
                // open window
        		wnd.center().open();
			},
			sortable : true,
			selectable : "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable : true,
			mobile : true,
			excel : {
				allPages : true,
				fileName : "접속이력.xlsx",
			},
			noRecords : {
				template: "검색된 결과가 없습니다."
			},
			pageable : {
				//refresh: true, //하단의 리프레쉬 아이콘
				pageSizes : true,
				//buttonCount: 1  //paging 갯수
				//input: true //페이지 직접입력
				//info: false //하단의 페이지 정보
				messages : {
					display : "전체 {2}개 항목 중 {0}~{1}번째 항목 출력",
					empty : "출력할 항목이 없습니다",
					itemsPerPage : "한 페이지에 출력할 항목 수"
				}
			},
			resizable : true, //컬럼 크기 조절
			reorderable : true //컬럼 위치 이동
		});//gridList end...
		
		/*
		 * view model for window data 
		 */
		questionModel = kendo.data.Model.define({
			id: "question_seq",
			fields: {
				question_seq	:{ type: "number" },
				title			:{ type: "string" },
				con_question	:{ type: "string" },
				con_io			:{ type: "string" },
				con_example		:{ type: "string" },
				con_condition	:{ type: "string" },
				con_hint		:{ type: "string" },
				con_etc			:{ type: "string" },
				mod_dt			:{ type: "string" },
				mod_usr			:{ type: "string" },           
				reg_dt			:{ type: "string" },
				reg_usr			:{ type: "string" },
				lang_type		:{ type: "string" },
				timeout			:{ type: "number", defaultValue: "${default_timeout}" },
				max_codesize	:{ type: "number", defaultValue: "${default_max_codesize}" },
				ban_keyword		:{ type: "string", defaultValue: "${default_ban_kw}" }
			}
		});
		
	    /*** dataSource ***/
		questionViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: {
						url: crudServiceBaseUrl + "/read.do",
		    			dataType: "jsonp",
		    			complete: function(e){ 
		    				console.log("complete /read.do...................");
		    			}
					},
					update: { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					destroy: { url: crudServiceBaseUrl + "/delete.do", dataType: "jsonp" },
					create: { url: crudServiceBaseUrl + "/create.do", dataType: "jsonp" },
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
								question_seq: G_Seq
							};
							return { params: kendo.stringify(result) }; 
						}
		               
						if (type !== "read" && data.models) {
							return { models: kendo.stringify(data.models) };
						}
					}
				},
				batch: true,
				schema: {
					model: questionModel,
					parse: function(response) {
						console.log("viewmodel parse: ");
                    	var rtn = response.rtnList;
						if(typeof rtn != "undefined"){
                            $.each(rtn, function(idx, elem) {
                            	elem.reg_dt = kendo.toString(new Date(Number(elem.reg_dt)), 'yyyy-MM-dd');
                            	elem.mod_dt = kendo.toString(new Date(Number(elem.mod_dt)), 'yyyy-MM-dd HH:mm');
                            	$("#lang-type").data("kendoDropDownList").value(elem.lang_type);
        						$("#lang-type").data("kendoDropDownList").text(elem.lang_type);
                            });
                    	}
                    	return response;
					},
					errors: function(response) {
						console.log("viewmodel error: ");
						return response.error;
					},
					total: function(response) {
						console.log("viewmodel total: " + response.total);
						return response.total;
					},
					data: function(response) {
						console.log("viewmodel data: ");
						console.log(response.rtnList);
						if(typeof response.rtnList != "undefined") {
							setCodeEditor(response.rtnList[0].test_code);
						} 
						return response.rtnList;
					}
				},
		        error : function(e) {
			    	console.log('viewmodel error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("viewmodel change: set selected :");
		            var _data = this.data()[0];
					console.log(_data);
					if(typeof _data != "undefined") {
									
					} else {
						
					}
					questionViewModel.set("selected", _data);
		        },
		        sync: function(e) { 
		        	console.log("viewmodel save data: ");
     			    console.log(this.data()[0]);
					alert("정상적으로 처리되었습니다.");
					wnd.close();
				}
			}),
			error : function(e) {
            	console.log("kendo.observable:error");
            	console.log(e);
            },
            change: function(e) {
            	console.log("kendo.observable:change");
            },
            batch: true,
            selected: null,
            hasChanges: false,
            save: function (e) {
				console.log("kendo.observable:save");
// 				conditionList = $("#gridCondition").data("kendoGrid").dataSource.data();
// 				questionViewModel.dataSource.data()[0].set("condition", conditionList);
				gradingList = $("#gridGrading").data("kendoGrid").dataSource.data();
				questionViewModel.dataSource.data()[0].set("grading", gradingList);
				questionViewModel.dataSource.data()[0].set("reg_usr", "${userStore.username}")
	        	questionViewModel.dataSource.data()[0].set("mod_usr", "${userStore.username}")
	        	questionViewModel.dataSource.data()[0].set("lang_type", $("#lang-type").data("kendoDropDownList").value());
	        	questionViewModel.dataSource.data()[0].set("test_code", editor.getDoc().getValue());
	        	// convert tag for editor
	        	if(typeof $("#con-question").val() != "undefined"
	        			&& typeof $("#con-io").val() != "undefined"
	        			&& typeof $("#con-example").val() != "undefined"){
	        		$("#con-hint").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
	        		var inData = $("#con-example").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
		        	if(inData.length < 1 || inData == null){
						alert("예제를 입력해주세요.");
			    	   	e.preventDefault();	
			        } else if(inData.length < 1 || inData == null){
		        		inData = $("#con-io").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
						alert("입출력을 입력해주세요.");
			    	   	e.preventDefault();	
			        } else if(inData.length < 1 || inData == null){
		        		inData = $("#con-question").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
						alert("문제를 입력해주세요.");
			    	   	e.preventDefault();	
			        } else {
		            	this.dataSource.sync();
			        }
	        	}
            },
            remove: function(e) {
            	console.log("kendo.observable:remove");
                if (confirm("삭제하시겠습니까?")) {
                	console.log("remove");
                    this.dataSource.remove(this.dataSource.data()[0]);
                    this.dataSource.sync();
					wnd.close();
                }
            },
            cancel: function(e) {
            	console.log("kendo.observable:cancel");
                this.dataSource.cancelChanges();
                wnd.close();
            }
		});
	    
	    // binding data to window
		kendo.bind($("#window"), questionViewModel);
	    		
	    $("#cancel-btn").kendoButton({ icon: "cancel" });
	    $("#save-btn").kendoButton({ icon: "pencil" });
	    $("#delete-btn").kendoButton({ icon: "close" });

	    $("#lang-type").kendoDropDownList({
			dataTextField : "text",
			dataValueField : "value",
			dataSource : {
				transport : {
					read : {
						url : "<c:url value='/mgr/question/getSupportLanguage.do'/>",
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

	    $("#con-question").kendoEditor({
			resizable: {
	        	content: true,
	        	toolbar: true
	        },
	        encoded: false
		});
		$("#con-io").kendoEditor({
			resizable: {
	        	content: true,
	        	toolbar: true
	        },
	        encoded: false
		});
		$("#con-hint").kendoEditor({
			resizable: {
	        	content: true,
	        	toolbar: true
	        },
	        encoded: false
		});
		$("#con-example").kendoEditor({
			resizable: {
	        	content: true,
	        	toolbar: true
	        },
	        encoded: false
		});
		
// 		$("#gridCondition").kendoGrid({
// 			autoBind : true,
// 			dataSource : new kendo.data.DataSource({
// 				transport: {
// 					read:  { url: crudServiceBaseUrl + "/condition/readList.do", dataType: "jsonp",
//             			complete: function(e){ 
//             				console.log("readList...................");
//             			}
// 					},
// // 					update: { url: crudServiceBaseUrl + "/condition/update.do", dataType: "jsonp" },
// // 					destroy: { url: crudServiceBaseUrl + "/condition/delete.do", dataType: "jsonp" },
// // 					create: { url: crudServiceBaseUrl + "/condition/create.do", dataType: "jsonp" },
// 					parameterMap: function(data, type) {
// 						if (type == "read"){
//                            	var result = {
//                            		question_seq: G_Seq
// 							};
// 							return { params: kendo.stringify(result) }; 
// 						}
// // 						if (type !== "read" && data.models) {	
// // 							return { models: kendo.stringify(data.models) };
// // 						}
// 					}
// 				},//transport end...
// 				schema: {
// 					data: function(response) {
// 						return response.rtnList;
// 					},
// 					total: function(response) {
// 						return response.total;
// 					},
// 					errors: function(response) {
// 						return response.error;
// 					},
// 					model:{//가져온 값이 있음...
// 						id:"condition_seq",//id 로 insert할건지 update 할건지 판단함.
// 						fields: {
// 							condition_seq: { type: "number" },  
// 							question_seq: { type: "number", defaultValue : getG_Seq },  
// 							use_yn : { type : "boolean", defaultValue : true },
// 							condition_type: { type: "string", validation: { required: true } },
// 							condition_value: { type: "string", validation: { required: true } }
// 						}   
// 					}
// 				},
//                 error : function(e) {
//                 	console.log(e);
//                 },
//                 change : function(e) {
//                 },  	
//                 sync: function(e) {
// 					console.log("sync complete");
// 					alert("정상적으로 처리되었습니다.");
// 					console.log("save & refresh...............");
// 				},  
// 				autoSync: false,          //     자동 저장
// 				batch: true               //     true: 쿼리를 한줄로,  false : row 단위로
// 			}),
// 			navigatable : true,
//             toolbar: [
// 				{ name: "create", text: "추가" },
// 				/*{ name: "save", text: "저장" },
// 				{ name: "destroy", text: "삭제" },*/
// 				{ name: "cancel", text: "취소" }
//             ],
// 			columns : [
// 				{
// 					field : "use_yn",
// 					title : "사용",
// 					attributes : { style : "text-align: center;" },
// 					width : "10%"
// 				},
// 				{
// 					field : "condition_type",
// 					title : "조건",
// 					width : "20%",
// 					attributes : { style : "text-align: center;" },
// 					editor : function(container, options) {
// 						$('<input required id = "' + options.field + '" name="' + options.field + '"/>')
// 						.appendTo(container)
// 						.kendoDropDownList({
// 							dataTextField : "text",
// 							dataValueField : "value",
// 							dataSource : {
// 								transport : {
// 									read : {
// 										url : "<c:url value='/common/readCodeListForCombo.do'/>",
// 										dataType : "jsonp"
// 									},
// 									parameterMap : function(data, type) {
// 										var result = {
// 											CATGR : "_CONDITION_"
// 										};
// 										return { params : kendo.stringify(result) };
// 									}
// 								}
// 							},
// 							change : function() {
// 							},
// 							dataBound : function(e) {
// 								$(".k-list-container").css("width", "100px");
// 							},
// 							index: 0
// 						});
// 					},
// 					template : "#=fnCodeNameByCdID(condition_type)#"
// 				},
// 				{ field : "condition_value", title : "값", width : "60%", attributes : { style : "text-align: center;" } },
// 				{
// 					command: [
// 						{ name: "destroy", text: "삭제" }
// 					]
// 				}
// 			],
// 			editable: {
// 				mode:  "incell",
// 				confirmation: "선택한 행을 삭제하시겠습니까?(저장 클릭시 적용됩니다.)"
// 			},
// 			change: function(e) {
//             	console.log("gridCondition:grid:change");
// 			},
// 			edit: function(e) {
// 				console.log("gridCondition:grid:edit");
//             	if (!e.model.isNew()) {
//             		$("#condition_type").data("kendoDropDownList").readonly();
// 				}
//             },  
// 			sortable : true,
// 			selectable : "row",
// 			scrollable : false,
// 			mobile : true,
// 			noRecords : {
// 				template: "제약 조건이 없습니다."
// 			},
// 			pageable : false,
// 			resizable : true, //컬럼 크기 조절
// 			reorderable : false //컬럼 위치 이동
// 		});//gridList end...
		
		$("#gridGrading").kendoGrid({
			dataSource : new kendo.data.DataSource({
				transport: {
					read:  { url: crudServiceBaseUrl + "/grading/readList.do", dataType: "jsonp",
            			complete: function(e){ 
            				console.log("gridGrading:grid:datasource:read:complete");
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
                           		question_seq: G_Seq
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
							question_seq: { type: "number", defaultValue : getG_Seq },
							grading_input: { type: "string", validation: { required: true } },
							grading_output: { type: "string", validation: { required: true } },
							grading_order: { type: "number" },
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
					console.log("gridGrading:grid:dataSource:sync");
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
	            template: kendo.template($("#popup_editor").html()),
				confirmation: "선택한 행을 삭제하시겠습니까?(저장 클릭시 적용됩니다.)"
			},
			edit: function(e) {
				console.log("gridGrading:grid:edit");
				$(e.container).parent().css({
					width: '900px',
					height: '400px'
				});
            },  
			change: function(e) {
            	console.log("gridGrading:grid:change");
			},
			save: function(e) {
            	console.log("gridGrading:grid:save");
			},
			sortable : true,
			scrollable : false,
			mobile : true,
			noRecords : {
				template: "채점 데이터가 없습니다."
			},
			dataBound: function(e) {
				console.log("gridGrading:grid:dataBound");
			}
		});
		
		
// 		 $("#gridGrading").delegate("tbody>tr", "dblclick", function () {
		$("#gridGrading").delegate("tbody>tr", "click", function () {
				if (!$(this).hasClass('k-grid-edit-row')) {
				$("#gridGrading").data("kendoGrid").editRow($(this));
			}
		});
		
		invokeUserAuth($("#add-btn"), 'kendoButton', 'C');
		invokeUserAuth($("#save-btn"), 'kendoButton', 'U');
		invokeUserAuth($("#delete-btn"), 'kendoButton', 'D');
	});//document ready javascript end...
</script>

<style>
	.k-edit-form-container {
		width: 100%;
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