<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>
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
					<!-- <div class="box-header">
                  <h3 class="box-title"><i class="fa fa-tag"></i>사용자관리</h3>
                </div> -->
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
			            <div id="details"></div>
					</div>
				</div> <!-- box -->
			</div> <!-- col-xs-12 -->
		</div> <!-- row -->
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
			<col width="50%">
			<col width="50%">
		</colgroup>
		<tbody>
			<tr><th colspan="2">제목</th></tr>
			<tr><td colspan="2"><input id="title" class="bind_input" name="title" data-bind="value:selected.title" style="width:100%;" required/></td></tr>
			<tr>
				<th>게시시작</th>
				<th>게시종료</th>
			</tr>
			<tr>
				<td><input id="expose-from" class="bind_input" name="expose-from" data-bind="value:selected.expose_from" style="width:100%;"/></td>
				<td><input id="expose-to" class="bind_input" name="expose-to" data-bind="value:selected.expose_to" style="width:100%;"/></td>
			</tr>
			<tr><th colspan="2">내용</th>	</tr>
			<tr><td colspan="2"><textarea id="content" name="content" data-bind="value:selected.content" placeholder="내용을 입력하시고 [저장]버튼을 눌러주세요." style="width:100%;height:500px;"></textarea></td></tr>
		</tbody>
	</table>
</div>

<script type="text/x-kendo-template" id="toolbar-template">
	<div id="toolbar" style="float:left;">
		<a href="\\#" class="k-pager-refresh k-link k-button" id="add-btn" title="Create" onclick="return onClick(this);">추가</a>
	</div>
</script>                
            
<script>
	/* DropDownList Template */
	var codelist = "_USER_TYPE_";
	var codeModles = "";
	var noticeViewModel;
	var noticeModel;
	var wnd;
	
	var today = kendo.date.today();
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
			if (codeModles[i].CD_ID == code) {
				rtnVal = codeModles[i].CD_NM;
			}
		}
		return rtnVal;
	}
	
	function fnCodeNameByCd(code) {
		var rtnVal = "";
		for (var i = 0; i < codeModles.length; i++) {
			if (codeModles[i].CD == code) {
				rtnVal = codeModles[i].CD_NM;
			}
		}
		return rtnVal;
	}

	var G_Condition = "ALL";
	var G_Keyword = ""; 
	var G_NoticeSeq = 0;
	
	$(function() {
		var searchData = [ 
			{ text : "전체", value : "ALL" }, 
			{ text : "제목", value : "TITLE" }, 
			{ text : "글쓴이", value : "USER_NAME" }, 
			{ text : "접속일", value : "ACCESS_DT" } 
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
				} else if (G_Condition == "ACCESS_DT") {
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
		// invisible delete button
		$("#delete-btn").css("display", "none");
		
		// init data
		$("#expose-from").data("kendoDateTimePicker").value();
		$("#expose-to").data("kendoDateTimePicker").value();
		
		// open window
		wnd.center().open();		
		noticeViewModel.set("selected", new noticeModel());
		noticeViewModel.dataSource.insert(0, noticeViewModel.selected);
		return false;
	}
	
	function onClick(e) {
		var id = e.id;
		console.log(id + " is clicked");
		if(id == 'add-btn') {
			console.log("add noticeViewModel");
			addNew(e);
		} 
    }
	
	function closeWindow(e) {
		wnd.close();
		G_NoticeSeq = 0;
		$("#gridList").data("kendoGrid").dataSource.read();
	}
	
	$(document).ready(function() {
		/*************************/
		/* deatils window
		/*************************/
		wnd = $("#window").kendoWindow({
            title: "글쓰기",
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
		
		/*************************/
		/* dataSgridListDetail */
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/bbs/notice",
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

					if (type !== "read"
							&& data.models) {
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
					/*
					var list = response.rtnList;
					if (typeof list != "undefined") {
						$.each(list, function(idx, elem) {
							var loginDate = new Date(elem.LOGIN_DT);
							var year = loginDate.getFullYear();
							var month = (loginDate.getMonth() + 1);
							var day = loginDate.getDate();
							loginDate = year + "" + (month > 9 ? month : "0" + month) + "" + (day > 9 ? day : "0" + day);
							elem.access_dt = loginDate;
						});
					}*/
					return response;
				},
				model : {//가져온 값이 있음...
					id : "notice_seq",
					fields : {
						notice_seq : { type : "number", editable : false }, //data type of the field {Number|String|Boolean|Date} default is String
						title : { type : "string", editable : false },
						reg_dt : { type : "string", editable : false },
						reg_usr : { type : "string", editable : false },
						expose_from : { type : "string", editable : false },
						expose_to : { type : "string", editable : false }
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
				{ field : "notice_seq", title : "번호", width : 100, attributes : { style : "text-align: center;" } },
				// Todo: 제목 길이 제한 
				{ field : "title", title : "제목", attributes : { style : "text-align: center;" } },
				{ field : "reg_usr", title : "글쓴이", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "reg_dt", title : "등록일", width : 150, attributes : {	style : "text-align: center;" },
					template : "#= (reg_dt == '') ? '' : kendo.toString(new Date(Number(reg_dt)), 'yyyy-MM-dd') #" }
				// Todo: 조회수 필드 추가 예정 
				/* 
				{ field : "expose_from", title : "게시시작", attributes : {	style : "text-align: center;" },
					template : "#= (expose_from == '') ? '' : kendo.toString(new Date(Number(expose_from)), 'yyyy-MM-dd HH:mm') #" },
				{ field : "expose_to", title : "게시종료", attributes : {	style : "text-align: center;" },
					template : "#= (expose_to == '') ? '' : kendo.toString(new Date(Number(expose_to)), 'yyyy-MM-dd HH:mm') #" },
				{ command: { 
					text : " ", click: showDetails, className: "fa fa-folder" }, title: "", width: "100px", attributes : {	style : "text-align: center;" } }
				*/
			],
			change: function(e) {
        		// find notice_seq value in selected row  	
				var selectedItem = this.dataItem(this.select());
				G_NoticeSeq = selectedItem.notice_seq;
				console.log("selected item: " + G_NoticeSeq + "(seq)");
                console.log(selectedItem);
                console.log("showDetails");
        		// read noticeViewModel by G_NoticeSeq 
        		noticeViewModel.dataSource.read();
        		$("#delete-btn").css("display", "inline-block");
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
		noticeModel = kendo.data.Model.define({
			id: "notice_seq",
			fields: {
				notice_seq	:{ type: "number" },
				title		:{ type: "string" },
				content		:{ type: "string" },
				mod_dt		:{ type: "string" },
				mod_usr		:{ type: "string" },           
				reg_dt		:{ type: "string" },
				reg_usr		:{ type: "string" },           
				expose_from	:{ defaultValue: kendo.toString(new Date(), "yyyy-MM-dd HH:mm") },           
				expose_to	:{ defaultValue: kendo.toString(new Date(), "yyyy-MM-dd HH:mm") }
			}
		});
		
	    /*** dataSource ***/
		noticeViewModel = kendo.observable({
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
								notice_seq: G_NoticeSeq
							};
							return { params: kendo.stringify(result) }; 
						}
		               
						if (type !== "read" && data.models) {
							// if using kendo.stringify, converte datetime from UTC timezone
							data.models[0].expose_from = kendo.toString(data.models[0].expose_from, "yyyy-MM-dd HH:mm");
							data.models[0].expose_to= kendo.toString(data.models[0].expose_to, "yyyy-MM-dd HH:mm");
							return { models: kendo.stringify(data.models) };
						}
					}
				},
				batch: true,
				schema: {
					model: noticeModel,
					data: function(response) {
						console.log("viewmodel data: ");
						console.log(response.rtnList);
						return response.rtnList;
					},
					total: function(response) {
						console.log("viewmodel total: " + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("viewmodel error: " + response.error);
						return response.error;
					},
					parse: function(response) {
						console.log("viewmodel parse: ");
                    	return response;
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
						_data.expose_from = new Date(Number(_data.expose_from));
						_data.expose_to = new Date(Number(_data.expose_to));
					} else {
						
					}
					noticeViewModel.set("selected", _data);
		        },
		        sync: function(e) { 
		        	console.log("viewmodel save data: ");
     			    console.log(this.data()[0]);
					alert("정상적으로 처리되었습니다.");
					closeWindow(e);
				},
				dataBound: function(e){ 
					console.log("viewmodel dataBound");
				}
			}),
			error : function(e) {
            	console.log("kendo.observable:error" + e.errors);
            },
            change: function(e) {
            	console.log("kendo.observable:change");
            },
            batch: true,
            selected: null,
            hasChanges: false,
            save: function (e) {
				console.log("kendo.observable:save");
				noticeViewModel.dataSource.data()[0].set("reg_usr", "${userStore.username}")
	        	noticeViewModel.dataSource.data()[0].set("mod_usr", "${userStore.username}")
	        	// convert tag for editor
	        	if( typeof $("#content").val() != "undefined" ){
	        		var inData = $("#content").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
		        	if(inData.length < 1 || inData == null){
							alert("내용을 입력해주세요.");
				    	   	e.preventDefault();	
			        } else {
		            	this.dataSource.sync();
			        }//if
	        	}//undefined
            },
            remove: function(e) {
            	console.log("kendo.observable:remove");
                if (confirm("삭제하시겠습니까?")) {
                	console.log("remove");
                    this.dataSource.remove(this.dataSource.data()[0]);
                    this.dataSource.sync();
					closeWindow();
                }
            },
            cancel: function(e) {
            	console.log("kendo.observable:cancel");
                this.dataSource.cancelChanges();
                closeWindow();
            }
		});
	    
	    // binding data to window
		kendo.bind($("#window"), noticeViewModel);
	    		
// 	    $("#cancel-btn").kendoButton({ icon: "cancel" });
// 	    $("#save-btn").kendoButton({ icon: "pencil" });
// 	    $("#delete-btn").kendoButton({ icon: "close" });
	    
	    $("#expose-from").kendoDateTimePicker({
			culture: "ko-KR",
	    	mask: "0000-00-00 00:00",
	    	format: 'yyyy-MM-dd HH:mm',
	    	parseFormats: ["yyyy-MM-dd HH:mm"],
			change: function(e) {
				var dt = kendo.toString(this.value(), "yyyy-MM-dd HH:mm");
				console.log("expose-from change: " + dt);
				noticeViewModel.dataSource.at(0).set("expose_from", this.value());
			}
	    });
	    
	    $("#expose-to").kendoDateTimePicker({
	    	culture: "ko-KR",
	    	mask: "0000-00-00 00:00",
	    	format: 'yyyy-MM-dd HH:mm',
	    	parseFormats: ["yyyy-MM-dd HH:mm"],
			change: function(e) {
				var dt = kendo.toString(this.value(), "yyyy-MM-dd HH:mm");
				console.log("expose-to change: " + dt);
				noticeViewModel.dataSource.at(0).set("expose_to", this.value());
			}
	    });
	    
		$("#content").kendoEditor({
			resizable: {
	        	content: true,
	        	toolbar: true
	        },
	        encoded: false
		});

		invokeUserAuth($("#add-btn"), 'kendoButton', 'C');

		invokeUserAuth($("#save-btn"), 'kendoButton', 'U');
		invokeUserAuth($("#delete-btn"), 'kendoButton', 'U');

	});//document ready javascript end...
</script>

<style>
#in_keyword, .k-datepicker, .k-autocomplete {
	display: none;
}

#in_keyword, .k-datepicker, #searchBtn {
	margin-left: 9px;
}

.k-grid td {
	white-space: nowrap;
	text-overflow: ellipsis;
}
</style>
<%@ include file="../inc/footer.jsp"%>