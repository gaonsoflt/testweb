<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%> 

<style>
.tbl_default table {border-top:2px solid #60B1A3;}
.tbl_default th,
.tbl_default td {padding:9px 12px;background-color:#fff;border-bottom:1px solid #d1d1d1;}
.tbl_default thead th {background-color:#f5f5f5;text-align:center;}
.tbl_default tbody th {background-color:#f5f5f5;}
.tbl_default input[type="radio"],
.tbl_default input[type="checkbox"] {padding:0;margin:0;vertical-align:middle;}
.tbl_default input[type="text"],
.tbl_default input[type="password"],
.tbl_default select {vertical-align:middle;}
.tbl_default table.list tbody td {text-align:center;}
.tbl_default .bdl {border-left:1px solid #d1d1d1;}
.tbl_default tr.type_10 td {background:#e1f5ec;}
.tbl_default tr.type_30 td {background:#f5eae1;}

.icon-chart {float:right;}
.icon-chart img {width:25px;}

.bind_input {border-width:0px;}
</style>

<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i> 상담이력관리 <small>원격 의료상담 이력을 조회합니다.</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 원격의료상담관리</a></li>
			<li class="active">상담이력관리</li>
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
						<div style="font-size:15px;padding:10px 0px;">
							<span>이름 <input id="in_keyword_user" /></span>
							<span><button id="searchBtn" type="button">조회</button></span>
						</div>
						<div id="horizontal" style="height:715px">
							<div id="left-pane">
								<div id="patientlist-grid"></div>
							</div>
							<div id="vertical">
								<div id="right-pane">
									<div id="consultlist-grid"></div>
									<div id="consultinfo-view" class="demo-section k-content"></div>
									<div id="consultnote-view" class="demo-section k-content"></div>
									<!-- <div id="consultnote-grid"></div>  -->
								</div>
							</div>
	                	</div>
                	</div>
               	</div>
			</div>
		</div>
	</section>
</div>
<div id="details"></div>
	                	
<script id="detail-info-template" type="text/x-kendo-template">
<table class="tbl_default" style="width: 100%">
	<caption><strong>▶ 기본정보</strong></caption>
	<colgroup>
		<col width="20%">
		<col width="30%">
		<col width="20%">
		<col width="30%">
	</colgroup>
	<tbody id="detail-info">
		<tr>
			<th>접수번호</th>
			<td>#:REQUEST_NO #</td>
			<th>상태</th>
			<td>#:STATUS_NM #</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>#:USER_NM #</td>
			<th>생년월일</th>
			<td>#:(BIRTHDAY == '') ? '' : kendo.toString(kendo.parseDate(BIRTHDAY, 'yyyyMMdd'), 'yyyy-MM-dd') #</td>
		</tr>
		<tr>
			<th>접수자</th>
			<td>#:REG_USER #</td>
			<th>접수일</th>
			<td>#:(REG_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(REG_DT))), 'yyyy-MM-dd') #</td>
		</tr>
		<tr>
			<th>불편사항</th>
			<td colspan="3">
				<textarea id="ISSUE_NOTE" class="ISSUE_NOTE bind_input" style="width:100%;height:100px;" readonly="readonly">#:(ISSUE_NOTE == null) ? '' : ISSUE_NOTE #</textarea>
			</td>
		</tr>
	</tbody>
</table>
<table class="tbl_default" style="width: 100%">
	<caption><strong>▶ 건강측정정보</strong></caption>
	<colgroup>
		<col width="150px">
		<col width="120px">
		<col width="100px">
		<col width="100px">
		<col width="100px">
		<col width="100px">
		<col width="100px">
		<col width="100px">
	</colgroup>
	<tbody id="checkup-info">
		<tr>
			<th>건강측정번호</th>
			<td colspan="1">#:CHECKUP_NO #</td>
			<th>건강측정일</th>
			<td colspan="1">#:(CHECKUP_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(CHECKUP_DT))), 'yyyy-MM-dd') #</td>
			<th>측정시간</th>
			<td colspan="3">#:fnCodeNameByCdID(CHECK_TIME) #</td>
		</tr>
		<tr>
			<th rowspan="2">
				<span>혈압정보 </span>
				<span class="icon-chart"></span>
			</th>
			<th>최고혈압</th>
			<th>최저혈압</th> 
			<th colspan="5">맥박수</th>
		</tr>
		<tr>
			<td>#:BLOOD_PRES_MAX # mmHg</td>
			<td>#:BLOOD_PRES_MIN # mmHg</td> 
			<td colspan="5">#:BLOOD_PRES_PULSE # bpm</td>
		</tr>
		<tr>
			<th rowspan="2">
				<span>혈중 농도</span>
				<span class="icon-chart"></span>
			</th>
			<th>혈당</th>
			<th>요산</th>
			<th colspan="5">산소포화도</th>
		</tr>
		<tr>
			<td>#:BLOOD_SUGAR # mg/dL</td>
			<td>#:URIC_ACID # mg/dL</td>
			<td colspan="5">#:OXGEN # %</td>
		</tr>
		<tr>
			<th rowspan="2">
				<span>콜레스테롤 수치</span>
				<span class="icon-chart"></span>
			<th>총콜레스테롤</th>
			<th>고밀도콜레스테롤</th>
			<th>저밀도콜레스테롤</th>
			<th colspan="4">중성지방</th>
		</tr>	
		</tr>
		<tr>
			<td>#:CHOLESTEROL # mg/dL</td> 
			<td>#:HDLCHOLESTEROL # mg/dL</td> 
			<td>#:LDLCHOLESTEROL # mg/dL</td> 
			<td colspan="4">#:NEUTRAL # mg/dL</td>
		</tr>	

		<!-- <tr>
			<th rowspan="2">
				<span>산소포화도정보</span>
				<span class="icon-chart"></span>
			</th>
			<th colspan="7">산소포화도</th>
		</tr>
		<tr>
			<td colspan="7">#:OXGEN # %</td>
		</tr> -->
		<tr>
			<th rowspan="2">
				<span>심전도정보</span>
				<span class="icon-chart"></span>
			</th>
			<th colspan="7">심전도 보기</th>
		</tr>
		<tr>
			<td colspan="7"><button class="k-button k-button-icontext k-grid-심전도보기"  id="ecgBtn" onClick="viewEcg('#:USER_NM #', '#:FILE_PATH #')">심전도 보기</button></td> 
		</tr>
	</tbody>
</table>
<table class="tbl_default" style="width:100%;">
		<caption><strong>▶ 상담정보</strong></caption>
		<colgroup>
			<col width="20%">
			<col width="30%">
			<col width="20%">
			<col width="30%">
		</colgroup>
		<tbody id="checkup-info">
			<tr>
				<th>작성자</th>
				<td>#:MOD_USER #</td>
				<th>작성일</th>
				<td>#:(MOD_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(MOD_DT))), 'yyyy-MM-dd') #</td>
			</tr>
			<tr>
				<th>상담내용</th>
				<td colspan="3"><textarea id="CONSULT_NOTE" class="CONSULT_NOTE bind_input" style="width:100%;" readonly="readonly">#:(CONSULT_NOTE == null) ? '' : CONSULT_NOTE #</td>
			</tr>
		</tbody>
	</table>
</script>
<script src="<c:url value='/resource/js/comm/urtown.js'/>" type="text/javascript"></script>
<script>
/*
	var codeModles;
	$.ajax({
		type: "post",
		url: "<c:url value='/dgms/getCodeListByCdIDModel.do'/>",
		async: false, //동기 방식
		success: function(data,status){
			codeModles = data.rtnList;
		},
		fail: function(){},
		complete: function(){}
	});
	*/
	

	var codelist = "_CHECKUP_RES_";
	var codeModles="";
	

		$.ajax({
			type: "post",
			url: "<c:url value='/dgms/getCodeListByCdIDModel.do'/>",
			data: {"list" : codelist},
			async: false, //동기 방식
			success: function(data,status){
				//codeModles = $.extend(codeModles, data.rtnList);
				codeModles = data.rtnList;
			},
			fail: function(){},
			complete: function(){}
		});
	
	function fnCodeNameByCdID(code){ 
		var rtnVal = "";
		for (var i = 0; i < codeModles.length; i++) {
	        if (codeModles[i].CD == code) {
	        	rtnVal = codeModles[i].CD_NM;
	        }
	    }
		return rtnVal;
	}

	var G_MEDI_CONSULT_SQ = 0;
	var G_AREA_GB = "${userStore.areaId}"; 
	var G_TOWN_ID = "${userStore.townId}"; 
	var G_Admin = "${userStore.username}";  
	var G_UserNm = "${userStore.fullname}";
	var G_Search = "USER_NO";
	var G_Keyword = "";
	
	var chartWindow;
	var chartOpenSwitch = document.getElementById("chart-mouseover-switch");
	var consultViewModel;
	
	$("#in_keyword_user").kendoAutoComplete({
		dataSource: {
	    	transport: {
				read: {
					url: "<c:url value='/dgms/getAutoCompleteNew.do'/>",
					dataType: "jsonp"
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					var result = {
						AREA_GB: G_AREA_GB,
						TOWN_ID: G_TOWN_ID,
						TABLE: "TB_USER_INFO",
						TEXT: "USER_NM",
						VALUE: "USER_SEQ",
						USER_TYPE: '5113000000' // 마을주민

	            	};
					return { params: kendo.stringify(result) }; 
				}
			}	
	    },
		suggest: false,
		dataTextField: "TEXT",
		dataBound: function(e) {
		},
		select: function(e) {
			G_Search = 'USER_NO';
			G_Keyword = this.dataItem(e.item.index()).VALUE;
			// 무조건 USER_NM으로 검색 됨 
			console.log('in_keyword_user select: ' + G_Keyword);
		},
		change: function(e) {
			G_Search = 'USER_NM';
			G_Keyword = this.value();
			console.log('in_keyword_user change: '  + G_Keyword);
		}
	});
	
	$("#in_keyword_user").keydown(function (e) {
	    if (e.which == kendo.keys.ENTER) {
	    	doSearch();
	    }
	});
	
	/* 조회 */
	$("#searchBtn").kendoButton({
		icon: "search",
		click: doSearch
	});
	
	function doSearch(e) {
		$("#patientlist-grid").data("kendoGrid").dataSource.read();
	};
	
	function doSave() {
		
	}

	
	$(document).ready(function () {
		
		/*************************/
		/*       splitter        */
		/*************************/
		$("#horizontal").kendoSplitter({
			orientation: "horizontal",
			panes: [
				{ collapsible: true, resizable: true, min: "150px",	size: "20%"	}, 
				{ collapsible: false, resizable: true, min: "150px" }      
			]
		});
		$("#vertical").kendoSplitter({
			orientation: "vertical",
			panes: [
				{ collapsible: false, resizable: false }, 
				{ collapsible: false, resizable: false }
			]
		});
	
	    var crudServiceBaseUrl = "/urtown/mediconsult/his";
		/*************************/
		/* patientlist-grid */
		/*************************/
	    /*** dataSource ***/
		var patientlistDs = new kendo.data.DataSource({
			transport: {
				read:  {
					url: crudServiceBaseUrl + "/patientList.do",
	    			dataType: "jsonp",
	    			complete: function(e){ 
	    				console.log("/patientList...................");
	    			}
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					if (type == "read"){
	                   	var result = {
	                   		AREA_GB: G_AREA_GB,
							TOWN_ID: G_TOWN_ID,
	                        USER_NM: G_Keyword,
	                        USER_TYPE: '5113000000' // 마을주민
						};
						return { params: kendo.stringify(result) }; 
					}
	               
					if (type !== "read" && data.models) {	
						return { models: kendo.stringify(data.models) };
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
					id: "USER_NO",
					fields: { //data type of the field {Number|String|Boolean|Date} default is String
						USER_NM:		{ type: "string" },
						USER_NO:		{ type: "string" },
						BIRTHDAY: 		{ type: "string" }
					}  
				}
			},
	        error : function(e) {
		    	console.log('listds error: ' + e.errors);
	        },
	        change : function(e) {
	        	console.log("listds change...........");
	        },  	
	        sync: function(e) {
				console.log("listds sync complete");
				//console.log("model.dirty:"+this.schema.model.dirty);//수정되었는지 여부
				alert("정상적으로 처리되었습니다.");  
			},  
			serverPaging: true,        // 서버 사이드 페이징 활성화
			serverFiltering: false,
			serverSorting: false,      // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
			//autoSync: true,          //     자동 저장
			batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
			page: 1,                   //     반환할 페이지
			pageSize: 10,              //     반환할 항목 수
			skip: 0,                   //     건너뛸 항목 수
			take: 10                   //     반환할 항목 수 (pageSize와 같음)
		});//datasource grid end...
	
		
		/*************************/
		/***   grid patientlist-grid     ***/
		/*************************/
		var patientlistGrid = $("#patientlist-grid").kendoGrid({
			autoBind: true,
			dataSource: patientlistDs,
			navigatable: true,
			pageable: true,
			height: 713,
			columns: [
				{ field: "USER_NO", title: "신청자번호", width: 80, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "USER_NM", title: "신청자", width: 80, attributes: {style: "text-align: center;"} },
				{ field: "BIRTHDAY", title: "생년월일", width: 100, attributes: {style: "text-align: center;"},
					template: "#= (BIRTHDAY == '') ? '' : kendo.toString(kendo.parseDate(BIRTHDAY, 'yyyyMMdd'), 'yyyy-MM-dd') #" 
				}
			],
			sortable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			
			mobile: true,
	        noRecords: {
	           template: "검색된 결과가 없습니다."
	        },
	        pageable : false,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			save: function(e) {//저장전 이벤트
				console.log("listgd save...............");
			},
			saveChanges: function(e) {//저장버턴 클릭시 이벤트
				console.log("listgd saveChanges...............");
			},
			edit: function(e) {//Fired when the user edits or creates a data item
			},
			dataBound: function(e) {
				console.log("listgd dataBound..............");
				
				var grid = this;
			    $(grid.tbody).on("click", "td", function (e) {
			        var row = $(this).closest("tr");
			        var rowIdx = $("tr", grid.tbody).index(row);
			        var colIdx = $("td", row).index(this);
			        var data = grid.dataItem(row);
			        
			        if(data.USER_SEQ == null || data.USER_SEQ == '') {
			        	G_Keyword = 0;
			        } else {
			        	G_Keyword = data.USER_SEQ;
			        }
			        // 접수 리스트 로드
			        consultlistDs.read();
			        $("#consultlist-grid").data("kendoGrid").dataSource.read();
			        // 상담 노트 로드
			        //consultNoteDs.read(); // template
			        //consultViewModel.dataSource.read();
					//$("#consultnote-form textarea[name=CONSULT_NOTE]").val("");  
			    });
			}
		});//grid end...
		
		
		/*** dataSource ***/
		var consultlistDs = new kendo.data.DataSource({
			transport: {
				read:  {
					url: crudServiceBaseUrl + "/consultList.do",
	    			dataType: "jsonp",
	    			complete: function(e){ 
	    				console.log("/consultList...................");
	    			}
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					if (type == "read"){
	                   	var result = {
                   			PAGESIZE: data.pageSize,
							SKIP: data.skip,
							PAGE: data.page,
							TAKE: data.take,
							AREA_GB: G_AREA_GB,
							SEARCH: G_Search,
							KEYWORD: G_Keyword
						};
						return { params: kendo.stringify(result) }; 
					}
	               
					if (type !== "read" && data.models) {	
						return { models: kendo.stringify(data.models) };
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
					id: "MEDI_CONSULT_SQ",//id 로 insert할건지 update 할건지 판단함.
					fields: {//data type of the field {Number|String|Boolean|Date} default is String
						MEDI_CONSULT_SQ:{ type: "number" },
						REQUEST_NO: 	{ type: "number", editable: false },
						STATUS_NM: 		{ type: "string", editable: true, defaultValue: '접수' },
						USER_NM:		{ type: "string", editable: true },
						BIRTHDAY: 		{ type: "string", editable: false },
						ISSUE_NOTE:		{ type: "string", editable: false },
						CONSULT_REQ_DT: { type: "string", defaultValue: new Date() },
						CHECKUP_NO: 	{ type: "number", defaultValue: 0 },
						REG_DT: 		{ type: "string", editable: false },
						REG_USER: 		{ type: "string", editable: false, defaultValue: "${userStore.username}" },
					}  
				}
			},
	        error : function(e) {
		    	console.log('listds error: ' + e.errors);
	        },
	        change: function(e) {
	        	console.log('listds change');
	        },
			//serverPaging: true,        // 서버 사이드 페이징 활성화
			//serverFiltering: false,
			//serverSorting: false,      // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
			//autoSync: true,          //     자동 저장
			batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
			page: 1,                   //     반환할 페이지
			pageSize: 10,              //     반환할 항목 수
			skip: 0,                   //     건너뛸 항목 수
			take: 10                   //     반환할 항목 수 (pageSize와 같음)
		});//datasource grid end...
	
		
		/*************************/
		/***   grid patientlist-grid     ***/
		/*************************/
		var consultlistGrid = $("#consultlist-grid").kendoGrid({
			dataSource: consultlistDs,
			pageable: true,
			height: 715,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			toolbar: [ 
			    { name: "excel", text: "엑셀출력" }
			],
			columns: [
				{ field: "REQUEST_NO", title: "접수번호", width: 110, attributes: {style: "text-align: center;"} },
				{ field: "STATUS_NM", title: "진행상태", width: 90, attributes: {style: "text-align: center;"} },
				{ field: "USER_NM", title: "신청자", width: 120, attributes: {style: "text-align: center;"} },
				{ field: "BIRTHDAY", title: "생년월일", width: 100, attributes: {style: "text-align: center;"}, hidden: true,
					template: "#= (BIRTHDAY == '') ? '' : kendo.toString(kendo.parseDate(BIRTHDAY, 'yyyyMMdd'), 'yyyy-MM-dd') #", },
				{ field: "CONSULT_REQ_DT", title: "상담일", width: 110, attributes: {style: "text-align: center;"}, 
					template: "#= (CONSULT_REQ_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(CONSULT_REQ_DT))), 'yyyy-MM-dd') #" },
				{ field: "CHECKUP_NO", title: "측정결과번호", width: 130, attributes: {style: "text-align: center;"} },
				{ field: "ISSUE_NOTE", title: "불편사항", attributes: {style: "text-align: left;"},
					template: '#=ISSUE_NOTE #' }, 
				{ field: "REG_DT", title: "접수일", width: 100, attributes: {style: "text-align: center;"},
					template: "#= (REG_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(REG_DT))), 'yyyy-MM-dd') #" },	
				{ field: "REG_USER", title: "접수자", width: 80, attributes: {style: "text-align: center;"} }, 
			],
			sortable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			mobile: true,
            excel: {
                allPages: true,
                fileName: "상담이력.xlsx",
            },
			noRecords: {
				template: "검색된 결과가 없습니다."
            },
            pageable: {	
           		pageSizes: true,
           		messages: {
					display: "전체 {2}개 항목 중 {0}~{1}번째 항목 출력",
           	      	empty: "출력할 항목이 없습니다",
           	      	itemsPerPage: "한 페이지에 출력할 항목 수"
				}
            },
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
            detailTemplate: kendo.template($("#detail-info-template").html()),
            detailInit: detailInit,
			dataBound: function(e) {
				console.log("listgd dataBound..............");
				// open first row
				//this.expandRow(this.tbody.find("tr.k-master-row").first());
			}
		});//grid end...
		
		function detailInit(e) {
            var detailRow = e.detailRow;
            console.log(detailRow);
            console.log("L detailRow");
            
            detailRow.find(".ISSUE_NOTE").kendoEditor({ tools: [ ] });
            $(detailRow.find(".ISSUE_NOTE").kendoEditor.body).attr('contenteditable', false);
            detailRow.find(".CONSULT_NOTE").kendoEditor({ tools: [ ] });
            $(detailRow.find(".CONSULT_NOTE").kendoEditor.body).attr('contenteditable', false);
        }
	});//document ready javascript end...
	 
	function onClick(e) {
		consultViewModel.sync();
    }
	
	function resize(obj) {
		obj.style.height = "1px";
		obj.style.height = (20 + obj.scrollHeight) + "px";
	}

	
    var wnd, detailsTemplate; 
    
    wnd = $("#details")
        .kendoWindow({
            title: "심전도 보기",
            modal: true,
            visible: false,
            resizable: false,
            width: 1000,
            height:800
        }).data("kendoWindow");
    
    //detailsTemplate = kendo.template($("#template").html());
    
	function viewEcg(name, url){
		/*        
 		var msg = '<div id="details-container"><h2>덕실마을사람1님 심전도</h2>';
        
        if(url != 'NOFILE'){
        	msg += '<div id="ecg_caution2">마지막으로 올라온 심전도 이미지를 표시합니다.</div>'
			+'<img id="ecgImg" src="' + url + '" style="display: block" data-evernote-hover-show="true">';
        }else{
        	msg += '<div id="ecg_caution">심전도 이미지가 없습니다.</div>';
        }
        msg += '</div>';
        
        wnd.content(msg);
        wnd.center().open();
        */
        var msg = '<div id="details-container"><h2>'+name+'님 심전도</h2>';
        var display_el = (url == null || url == 'NOFILE' ? "none" :"block");
        
        if(url != 'NOFILE'){
        	var url2 = url + "?random=" + Math.floor((Math.random() * 100000000000000000000) + 1);
        	msg += '<div id="ecg_caution2">마지막으로 올라온 심전도 이미지를 표시합니다.<br />'
        	+'<input type="button" id="rbtn" onclick="javascript:rotation(90, \'canvas\', \'ecgImg\', \'ecgImg2\', \''+url+'\')" value="90도 회전하기" /></div>'
        	+'<canvas id="canvas" style="transform: translate3d(0px, 0px, 0px) scale3d(1, 1, 1); display: none;" width="332" height="400"></canvas>'
   
			+'<img id="ecgImg" src="' + url2 + '" style="display: '+display_el+'" data-evernote-hover-show="true">'
			+'<div id="imgView" style="display:none;"><img id="ecgImg2" src="'+url2+'" style="display: '+display_el+'" />';
        }else{
        	msg += '<div id="ecg_caution">심전도 이미지가 없습니다.</div>';
        }
        msg += '</div>';
        
        wnd.content(msg);
        wnd.center().open();
        

        rotation(0, 'canvas', 'ecgImg', 'ecgImg2');
	}
</script>	
<style>
	#details-container{ text-align: center; overflow-x:auto; overflow-y:auto; padding: 10px; }
	#details-container h2{ font-size:25px; margin-top:20px !important; }
	#details-container img{ display:none; border:1px solid #999; /*max-width:900px; max-height:600px;*/  height:auto; margin:0px auto 20px auto; }
	#ecg_caution{ margin-top: 10px; font-size: 15px; color:red; }
	#ecg_caution2{ margin-top: 10px; color:#ccc; }
	#details-container h2{		margin: 0;						}
	#details-container em{		color: #8c8c8c;					}
	#details-container dt{		margin:0; display: inline;		}
	#rbtn{border:1px solid #999; color:#000; margin:10px auto 30px auto;}
	.mw{max-width:550px}
	.mh{max-height:550px}
	
	.k-autocomplete, #in_kw_date, #searchBtn{margin-left:9px;}
	#gridDetail table th{text-align:center;}
</style>
<%@ include file="../inc/footer.jsp"%>