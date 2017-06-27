<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../inc/header.jsp"%>
<%@ include file="../../inc/aside.jsp"%>

<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i>환경설정 <small>ESPA의 환경변수를 관리합니다.</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> ESPA관리</a></li>
			<li class="active">환경설정</li>
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
						<p id="searchArea" style="font-size: 15px; padding: 10px 0px;">
							검색&nbsp;&nbsp;&nbsp;&nbsp;
							<input id="in_search" /> 
							<input id="in_keyword" /> 
							<button id="searchBtn" type="button">조회</button>
						</p>
						<div id="gridList"></div>
					</div>
				</div>
				<!-- box -->
			</div>
			<!-- col-xs-12 -->
		</div>
		<!-- row -->
	</section>
</div>
<script>
var
	codelist = "_USER_TYPE_";
	var G_Condition = "ALL";
	var G_Keyword = ""; 
	var codeModles = "";
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
	
	$(function() {
		var searchData = [ 
			{ text : "전체", value : "ALL" }, 
			{ text : "변수아이디", value : "CFG_ID" }, 
			{ text : "변수명", value : "CFG_NAME" }, 
			{ text : "변수그룹", value : "CFG_GROUP" } 
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
				var gridList = $("#gridList").data("kendoGrid");
				gridList.dataSource.read();
			}
		});
	});

	$(document).ready(function() {
		/*************************/
		/* dataSource gridList */
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/mgr/config",
		/*** dataSource ***/
		gridListDataSource = new kendo.data.DataSource({
			transport : {
				read : {
					url : crudServiceBaseUrl + "/read.do",
					dataType : "jsonp",
					complete : function(e) {
						console.log("read.do...................");
					}
				},
				update : {
					url : crudServiceBaseUrl + "/update.do",
					dataType : "jsonp"
				},
				destroy : {
					url : crudServiceBaseUrl + "/delete.do",
					dataType : "jsonp"
				},
				create : {
					url : crudServiceBaseUrl + "/create.do",
					dataType : "jsonp"
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
						return {
							params : kendo.stringify(result)
						};
					}

					if (type !== "read" && data.models) {
						return {
							models : kendo.stringify(data.models)
						};
					}
				}
			},
			schema : {
				data : function(response) {
					return response.rtnList;
				},
				total : function(response) {
					return response.total;
				},
				errors : function(response) {
					return response.error;
				},
				model : {//가져온 값이 있음...
					id : "cfg_seq",//id 로 insert할건지 update 할건지 판단함.
					fields : {
						cfg_seq 	: { type : "number" },
						cfg_id 		: { type : "string" },
						cfg_name	: { type : "string" },
						cfg_value 	: { type : "string" },
						use_yn 		: { type : "boolean", defaultValue: true },
						description : { type : "string" },
						cfg_group 	: { type : "string" }
					}
				}
			},
			error : function(e) {
				console.log(e.errors);
				alert(e.errors);
			},
			change : function(e) {
				console.log("change...........");
			},
			sync : function(e) {
				console.log("sync complete");
				alert("정상적으로 처리되었습니다.");
				$.ajax({
					type : "get",
					url : "<c:url value='/mgr/config/notify.do'/>",
					async : false //동기 방식
				});
			},
			serverPaging : true, // 서버 사이드 페이징 활성화
			serverFiltering : false,
			serverSorting : false, // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
			batch : true, //     true: 쿼리를 한줄로,  false : row 단위로
			page : 1, //     반환할 페이지
			pageSize : 15, //     반환할 항목 수
			skip : 0, //     건너뛸 항목 수
			take : 15
		//     반환할 항목 수 (pageSize와 같음)
		});//datasource grid end...

		/*************************/
		/***    gridDetail     ***/
		/*************************/
		$("#gridList").kendoGrid({
			autoBind : true,
			dataSource : gridListDataSource,
			navigatable : true,
			pageable : true,
			height : 712,
			toolbar : [ 
            	{ name : "create", text : "추가" }, 
            	{ name : "save", text : "저장" }, 
            	{ name : "cancel", text : "취소" }, 
            	{ name : "excel", text : "엑셀" } 
            ],
			columns : [ 
				{ field : "cfg_seq", title : "seq", hidden:true }, 
				{ field : "cfg_group", title : "변수그룹", width : "10%", attributes : { style : "text-align: center;" } }, 
				{ field : "cfg_id", title : "변수아이디", width : "10%", attributes : { style : "text-align: center;" } }, 
				{ field : "cfg_name", title : "변수명", width : "10%", attributes : { style : "text-align: center;" } }, 
				{ field : "cfg_value", title : "변수값", width : "25%", attributes : { style : "text-align: center;" } }, 
				{ field : "description", title : "설명", width : "25%", attributes : { style : "text-align: center;" } }, 
				{ field : "use_yn", title : "사용여부", width : "5%", attributes : { style : "text-align: center;" } }, 
				{
					command: [
						{ name: "destroy", text: "삭제" }
					],
					width: 100
				}
			],
			editable : {
				mode : "incell",
				confirmation : "선택한 행을 삭제하시겠습니까?(저장 클릭 시 반영됩니다.)"
			},
			sortable : true,
			selectable : true, //selectable: "multiple cell","multiple row","cell","row",
			scrollable : true,
			mobile : true,
			excel : {
				allPages : true,
				fileName : "환경설정.xlsx",
			},
			noRecords : {
				template : "검색된 결과가 없습니다."
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
			reorderable : true, //컬럼 위치 이동
			save : function(e) {//저장전 이벤트
				console.log("save2...............");
			},
			saveChanges : function(e) {//저장버턴 클릭시 이벤트
			},
			edit : function(e) {//Fired when the user edits or creates a data item
				console.log("edit2...............");
			},
			change : function(e) {
				console.log("change2...............");
			},
			dataBound : function(e) {
				invokeUserAuth($("#gridDetail"), "kendoGrid");
			}
		});//gridDetail end...
	});//document ready javascript end...
</script>
<style>
	#in_keyword, .k-datepicker, .k-autocomplete {
		display: none;
	}
	
	#in_keyword, .k-datepicker, #searchBtn {
		margin-left: 9px;
	}
</style>
<%@ include file="../../inc/footer.jsp"%>