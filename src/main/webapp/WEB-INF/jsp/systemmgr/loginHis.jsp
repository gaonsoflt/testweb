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
						<div id="gridDetail"></div>
					</div>
				</div> <!-- box -->
			</div> <!-- col-xs-12 -->
		</div> <!-- row -->
	</section>
</div>
<script>
	/* DropDownList Template */
	var codelist = "_USER_TYPE_";
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

	$(function() {
		var searchData = [ 
			{ text : "전체", value : "ALL" }, 
			{ text : "접속일", value : "ACCESS_DT" }, 
			{ text : "접속자 ID", value : "USER_ID" }, 
			{ text : "접속자명", value : "USER_NAME" }, 
			{ text : "접속자 IP", value : "REQ_IP" }, 
			{ text : "접속방법", value : "REQ_DEVICE" } 
		];
	
		$("#in_search").kendoComboBox({
			dataTextField : "text",
			dataValueField : "value",
			dataSource : searchData,
			change : function() {
				G_Condition = $("#in_search").val();
				if (G_Condition == "ALL") {
					$("#in_keyword").css({ "display" : "none" });
					$("#in_user").css({ "display" : "none" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
				} else if (G_Condition == "ACCESS_DT") {
					G_Keyword = "";
					$("#in_searchDate").data("kendoDatePicker").value(new Date());
					$("#searchArea .k-datepicker").css({ "display" : "inline-block" });
					$("#in_keyword").css({ "display" : "none" });
					$("#in_user").css({ "display" : "none" });
					G_Keyword = kendo.toString(new Date(), "yyyy-MM-dd");
				} else if (G_Condition == "USER_NAME") {
					G_Keyword = "";
					$("#in_user").val("");
					$("#in_user").css({ "display" : "inline-block" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
					$("#in_keyword").css({ "display" : "none" });
				} else {
					G_Keyword = "";
					$("#in_keyword").val("");
					$("#in_keyword").css({ "display" : "inline-block" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
					$("#in_user").css({ "display" : "none" });
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
				var gridDetail = $("#gridDetail").data("kendoGrid");
				gridDetail.dataSource.read();
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
		/* dataSource gridDetail */
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/sm/history/login",
		/*** dataSource ***/
		dataSourceDetail = new kendo.data.DataSource({
			transport : {
				read : { 
					url : crudServiceBaseUrl + "/read.do", 
					dataType : "jsonp",
					complete: function(e){ 
				    	console.log("/read.do...................");
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
					id : "seq",
					fields : {
						seq : { type : "number", editable : false }, //data type of the field {Number|String|Boolean|Date} default is String
						access_dt : { type : "string", editable : false },
						user_id : { type : "string", editable : false },
						user_name : { type : "string", editable : false },
						log_type : { type : "string", editable : false },
						req_ip : { type : "string", editable : false },
						req_device : { type : "string", editable : false }
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
		});//datasource gridDetail end...

		/*************************/
		/***    gridDetail     ***/
		/*************************/
		$("#gridDetail").kendoGrid({
			autoBind : true,
			dataSource : dataSourceDetail,
			navigatable : true,
			pageable : true,
			height : 710,
			toolbar : [{
				name : "excel",
				text : "엑셀"
			}],
			columns : [
				{ field : "seq", title : "SEQ", width : 100, attributes : { style : "text-align: center;" } }, 
				{ field : "access_dt", title : "요청일자", attributes : {	style : "text-align: center;" },
					template : "#= (access_dt == '') ? '' : kendo.toString(new Date(Number(access_dt)), 'yyyy년 MM월 dd일   HH시 mm분 ss초') #" }, 
				{ field : "user_id", title : "요청자아이디", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "user_name", title : "요청자이름", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "log_type", title : "로그유형", width : 100, attributes : { style : "text-align: center;" } },
				{ field : "req_ip", title : "요청자아이피", width : 200, attributes : { style : "text-align: center;" } },
				{ field : "req_device", title : "요청자장치", width : 300, attributes : { style : "text-align: center;" } } 
			],
			sortable : true,
			selectable : true, //selectable: "multiple cell","multiple row","cell","row",
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
		});//gridDetail end...
	});//document ready javascript end...
</script>

<style>
#in_keyword, .k-datepicker {
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