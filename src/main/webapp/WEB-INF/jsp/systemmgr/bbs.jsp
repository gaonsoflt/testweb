<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>

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
				<div id="gridDetail"></div>
			</div>
		</div>
	</section>
</section>

<script>
	$(document).ready(function() {

		/*************************/
		/***    gridDetail     ***/
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/sm/bbs";
		$("#gridDetail").kendoGrid({
			autoBind : true,
			dataSource : {
				transport : {
					read : { url : crudServiceBaseUrl + "/readList.do", dataType : "jsonp" },
					update : { url : crudServiceBaseUrl + "/update.do", dataType : "jsonp" },
					destroy : { url : crudServiceBaseUrl + "/delete.do", dataType : "jsonp" },
					create : { url : crudServiceBaseUrl + "/create.do", dataType : "jsonp" },
					parameterMap : function(data, type) {//type =  read, create, update, destroy
						if (type == "read") {
							var result = {
								PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take
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
				},//transport end...
				schema : {
					data : function(response) {
						console.log(response.rtnList);
						return response.rtnList;
					},
					total : function(response) {
						return response.total;
					},
					errors : function(response) {
						return response.error;
					},
					model : {//가져온 값이 있음...
						id : "bbs_seq",//id 로 insert할건지 update 할건지 판단함.
						fields : {
							bbs_seq 	: { type : "number" },
							bbs_name 	: { type : "string", validation : { required : true } },
							bbs_id		: { type : "string", validation : { required : true } },
							use_attach	: { type : "boolean" },
							reg_dt 		: { type : "string", editable : false },
							reg_usr 	: { type : "string", editable : false, defaultValue : "${userStore.username}" },
							mod_dt 		: { type : "string", editable : false },
							mod_usr 	: { type : "string", editable : false, defaultValue : "${userStore.username}" }
						}
					}
				},
				error : function(e) {
					console.log(e.errors);
					alert(e.errors);
				},
				change : function(e) {
				},
				requestStart : function(e) {
				},
				requestEnd : function(e) {
					console.log("deployViewModel:dataSource:requestEnd");
		        	if(e.type != 'read' && e.response.error == null) {
		        		alert("정상적으로 처리되었습니다.");	
		        	}
				},
				sync : function(e) {
					console.log("sync complete");
					$("#gridDetail").data("kendoGrid").dataSource.read();
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
			height : 700,
			toolbar : [ 
				{ name : "create", text : "추가" }
			],
			messages : {
				commands : {
					canceledit : "취소",
					update : "저장"
				}
			},
			columns : [
				{ field : "bbs_seq", hidden : true, },
				{ field : "bbs_name", title : "게시판이름", attributes : { style : "text-align: center;" } },
				{ field : "bbs_id", title : "게시판ID", attributes : { style : "text-align: center;" } },
				{ field : "use_attach", title: "파일사용", width : 80, attributes: {style: "text-align: center;"} },
				{ field : "reg_usr", title : "생성자", width : 130, attributes : { style : "text-align: center;" } },
				{ field : "mod_dt", title : "수정일", width: 150, attributes : { style : "text-align: center;" },
					template : "#= (mod_dt == '') ? '' : kendo.toString(new Date(Number(mod_dt)), 'yyyy-MM-dd') #" 
				},
				{
					title : "",
					attributes : { style : "text-align: center;" },
					command : [ 
						{ name : "edit", text : "수정" }, 
					    { name : "destroy", text : "삭제" } 
					],
					width : 150
				}
			],
			editable : {
				mode : "inline",
				confirmation : "선택한 게시판을 정말 삭제하시겠습니까?\n삭제 시 관련된 모든 게시물이 삭제됩니다."
			},
			sortable : true,
			selectable : true, //selectable: "multiple cell","multiple row","cell","row",
			scrollable : true,
			mobile : true,
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
				if (e.model.isNew()) {
					var data = this.dataSource.at(0).bbs_id;
					var parameters = {
						'TABLE' : 'tb_bbs_ref',
						'COLUMN1' : 'bbs_id',
						'DATA1' : data
					};
					$.ajax({
						type : "post",
						url : "<c:url value='/common/getDuplicateCount.do'/>",
						async : false,
						data : parameters,
						success : function(data, status) {
							if (data.cnt > 0) {
								alert("동일한 아이디가 존재합니다.");
								e.preventDefault();
								this.dataSource.cancelChanges();
							}
						},
						fail : function() {
						}
					});
				}
				console.log("save...............");
			},
			saveChanges : function(e) {//저장버턴 클릭시 이벤트 
// 				var uid = this.dataSource.at(0).bbs_id;
// 				var upw = this.dataSource.at(0).password;
// 				if (typeof uid == 'undefined' || uid.replace(/ /gi, '').length < 1) {
// 					alert("아이디를 입력해주십시오.");
// 					e.preventDefault();
// 				}
			},
			edit : function(e) {
				if (!e.model.isNew()) {
					$("input[name=bbs_id]").attr({ "readonly" : true });
					$("input[name=bbs_id]").css({
						"background" : "#ccc",
						"text-align" : "center"
					});
				} else {
				}
			},
			dataBound : function(e) {
				invokeUserAuth($("#gridDetail"), "kendoGrid");
			}
		});//gridDetail end...
	});//document ready javascript end...
</script>

<style>
	#gridDetail .k-grid-content {
		overflow-x: auto;
	}
	
	#gridDetail table th {
		text-align: center;
	}
	.k-grid td {
	    overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
</style>
<%@ include file="../inc/footer.jsp"%>