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
						<button type="button" onclick="location.href='${contextPath}/mgr/question/form.do'"><spring:message code="button.add"/></button>
						<div id="gridList"></div>
					</div>
				</div> <!-- box -->
			</div> <!-- col-xs-12 -->
		</div> <!-- row -->
	</section>
</div>

<script>
	/* DropDownList Template */
	var codelist = "_USER_TYPE_,_CONDITION_";
	var codeModles = "";
	
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
	var G_SEQ = 0;
	
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
	
	$(document).ready(function() {
		/*************************/
		/***    gridList     ***/
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/question";
		$("#gridList").kendoGrid({
			autoBind : true,
			dataSource : {
				transport : {
					read : { 
						url : crudServiceBaseUrl + "/readList.do", 
						dataType : "jsonp",
						complete: function(e){ 
					    	console.log("/readList.do...................");
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
							rnum : { type : "number", editable : false },
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
			},
			navigatable : true,
			pageable : true,
			height : 600,
            toolbar: false,
			columns : [
				{ field : "question_seq", hidden: true },
				{ field : "rnum", title : "번호", width : 100, attributes : { style : "text-align: center;" } },
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
				G_SEQ = selectedItem.question_seq;
				console.log("selected item: " + G_SEQ + "(seq)");
				location.href='${contextPath}/mgr/question/form.do?id=' + G_SEQ;
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
	.k-grid td {
	    overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
</style>
<%@ include file="../../inc/footer.jsp"%>