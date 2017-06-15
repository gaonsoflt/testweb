<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>
<!-- chart js --> 
<script src="<c:url value='/resource/js/comm/urtown.js'/>" type="text/javascript"></script>
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
#editor01 .k-editor iframe.k-content{height: 50px !important}
</style>

<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i> 원격상담관리 <small>원격의료상담을 진행합니다.</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 원격의료상담관리</a></li>
			<li class="active">원격상담관리</li>
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
							<span>상담요청일:&nbsp;&nbsp;&nbsp;&nbsp;<input id="in_req_dt" /></span>&nbsp;&nbsp;&nbsp;
							<span>신청자:&nbsp;&nbsp;&nbsp;&nbsp;<input id="in_keyword_user" /></span>&nbsp;&nbsp;&nbsp;
							<span><button id="searchBtn" type="button">조회&nbsp;&nbsp;&nbsp;&nbsp;</button></span>
							<span><button id="searchDetailBtn" type="button">간편 진료 프로그램</button></span>
							<span><button id="beforInfo" type="button" onclick="befoInfo()">이전 측정정보</button></span>
							<span style="float:right">차트열림방식 <input id="chart-mouseover-switch"/></span>
						</div>
						<div id="horizontal" style="height:715px">
							<div id="left-pane">
								<div id="waitinglist-grid"></div>
							</div>
							<div id="vertical">
								<div id="right-pane">
									<div id="consultinfo-view" class="demo-section k-content"></div>
									<div id="consultnote-view" class="demo-section k-content"></div>
									<!-- <div id="consultnote-grid"></div>  -->
								</div>
							</div>
	                	</div>
	                	<div id="chart-window">
				            <div id="chart"></div>
	                	</div>
                	</div>
               	</div>
			</div>
		</div>
	</section>
</div>

<div id="beforDetails"></div>
<script type="text/x-kendo-template" id="template"></script>
<script> 
    
    var wnd, detailsTemplate; 
    
    function befoInfo(){
    
    wnd = $("#beforDetails")
        .kendoWindow({
            title: "test",
            modal: true,
            visible: false,
            resizable: false,
            width: 900,
            height:400
        }).data("kendoWindow");
    
    detailsTemplate = kendo.template($("#template").html());
    

	function viewEcg(name, url){
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
	
	viewEcg('${name}','${url}');
	
    }
</script>	

<div id="details"></div>     
<script type="text/x-kendo-template" id="template">
</script>

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
		<!--tr>
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
		</tr-->
		<tr>
			<th>불편사항</th>
			<td colspan="3" id='editor01'>
				<textarea id="ISSUE_NOTE" class="ISSUE_NOTE bind_input" style="width:100%;height:100px;" readonly="readonly">#:(ISSUE_NOTE == null) ? '' : ISSUE_NOTE #</textarea>
			</td>
		</tr>
	</tbody>
</table>
<table class="tbl_default" style="width: 100%">
	<caption><strong>▶ 건강측정정보</strong></caption>
	<colgroup>
		<col width="140px">
		<col width="120px">
		<col width="100px">
		<col width="100px">
		<col width="110px">
		<col width="110px">
		<col width="110px">
	</colgroup>
	<tbody id="checkup-info">
		<tr>
			<th>건강측정번호</th>
			<td colspan="1">#:CHECKUP_NO #</td>
			<th>건강측정일</th>
			<!-- <td colspan="3">#:(CHECKUP_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(CHECKUP_DT))), 'yyyy-MM-dd') #</td> -->
			<td colspan="1">#: kendo.toString(kendo.parseDate(new Date(Number(CHECKUP_DT))), 'yyyy-MM-dd') #</td>
			<th>측정시간</th> 
			<td colspan="1">#:fnCodeNameByCdID(CHECK_TIME) #</td>
		</tr>
		<tr>
			<th rowspan="2">
				<span>혈압 정보 </span>
				<span class="icon-chart">
					<img src="../../resource/images/icon_chart.png" alt="open chart" 
						onmouseover="javascript:if(chartOpenSwitch.checked==true){openChart(0, #:USER_NO #);}" 
						onmouseout="javascript:if(chartOpenSwitch.checked==true){closeChart();}"
						onclick="openChart(0, #:USER_NO #)" />
				</span>
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
				<span class="icon-chart">
					<img src="../../resource/images/icon_chart.png" alt="open chart" 
						onmouseover="javascript:if(chartOpenSwitch.checked==true){openChart(1, #:USER_NO #);}" 
						onmouseout="javascript:if(chartOpenSwitch.checked==true){closeChart();}"
						onclick="openChart(1, #:USER_NO #)" />
				</span>
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
				<span class="icon-chart">
					<img src="../../resource/images/icon_chart.png" alt="open chart" 
						onmouseover="javascript:if(chartOpenSwitch.checked==true){openChart(2, #:USER_NO #);}" 
						onmouseout="javascript:if(chartOpenSwitch.checked==true){closeChart();}"
						onclick="openChart(2, #:USER_NO #)" />
				</span>
			</th>
			<th>총콜레스테롤</th>
			<th>고밀도콜레스테롤</th>
			<th>저밀도콜레스테롤</th>
			<th colspan="4">중성지방</th>
		</tr>
		<tr>
			<td>#:CHOLESTEROL # mg/dL</td>
			<td>#:HDLCHOLESTEROL # mg/dL</td>
			<td>#:LDLCHOLESTEROL # mg/dL</td>
			<td colspan="4">#:NEUTRAL # mg/dL</td>
		</tr>

		<tr>
			<th rowspan="2">
				<span>심전도 정보</span>
				<span class="icon-chart"> 
				</span>
			</th>
			<th colspan="7">심전도 보기</th>
		</tr>
		<tr>
			<td colspan="7"><button class="k-button k-button-icontext k-grid-심전도보기"  id="ecgBtn" onClick="viewEcg('#:USER_NM #', '#:FILE_PATH #')">심전도 보기</button></td>
		</tr>
		<!--
		<tr>
			<th rowspan="2">
				<span>심전도정보</span>
				<span class="icon-chart">
					<img src="../../resource/images/icon_chart.png" alt="open chart" 
						onmouseover="javascript:if(chartOpenSwitch.checked==true){openChart(3, #:USER_NO #);}" 
						onmouseout="javascript:if(chartOpenSwitch.checked==true){closeChart();}"
						onclick="openChart(3, #:USER_NO #)" />
				</span>
			</th>
			<th>평균심박수</th>
			<th>최저심박수</th>
			<th>최대심박수</th>
			<th>이상심박횟수</th>
			<th>서맥횟수</th>
			<th>맥횟수</th>
		</tr>
		<tr>
			<td>#:ECG_AVG_HEARTBT # bmp</td>
			<td>#:ECG_MIN_HEARTBT # bmp</td>
			<td>#:ECG_MAX_HEARTBT # bmp</td>
			<td>#:ECG_UNUSUAL_CNT # bmp</td>
			<td>#:ECG_BRADY_CNT # bmp</td>
			<td>#:ECG_FREQ_CNT # bmp</td>
		</tr>
		-->
	</tbody>
</table>
</script>
<script id="detail-note-template" type="text/x-kendo-template">
<div id="consultnote-form">
	<div><button id="savenote-btn" class="k-primary" style="float:right;margin:10px 10px 0 0;">저장</button></div>
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
				<th>최종수정자</th>
				<td><input id="MOD_USER" class="bind_input" name="MOD_USER" data-bind="value:selected.MOD_USER" required readonly="readonly"/></td>
				<th>최종수정일</th>
				<td><input id="MOD_DT" class="bind_input" name="MOD_DT" data-format="yyyy-MM-dd" data-bind="value:selected.MOD_DT" required readonly="readonly"/></td>
			</tr>
			<tr>
				<th>상담내용</th>
				<td colspan="3"><textarea id="CONSULT_NOTE" name="CONSULT_NOTE" data-bind="value:selected.CONSULT_NOTE" placeholder="상담 내용을 입력하시고 [저장]버튼을 눌러주세요." style="width:100%;height:500px;"></textarea></td>
			</tr>
		</tbody>
	</table>
</div>
</script>
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
	var G_CONSULT_REQ_DT;
	var G_AREA_GB = "${userStore.areaId}"; 
	var G_TOWN_ID = "${userStore.townId}"; 
	var G_Search;
	var G_Keyword;
	
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
	
	/* 의료상담일  */
	$("#in_req_dt").kendoDatePicker({
		culture: "ko-KR",
		format: "yyyy/MM/dd",
		parseFormats: ["yyyy-MM-dd"],
		value: new Date(),
		change: function(e) {
			G_CONSULT_REQ_DT = kendo.toString(this.value(), "yyyy-MM-dd");
			console.log("in_req_dt: " + G_CONSULT_REQ_DT);
		}	
	}); 
	
	//초기화
	var datepicker = $("#in_req_dt").data("kendoDatePicker");
	datepicker.value(G_CONSULT_REQ_DT);
	datepicker.trigger("change");
	
	/* 조회 */
	$("#searchBtn").kendoButton({
		icon: "search",
		click: doSearch
	});
	
	function doSearch(e) {
		$("#waitinglist-grid").data("kendoGrid").dataSource.read();
		G_MEDI_CONSULT_SQ = 0;
	};
	
	/* 보건의용 간편 프로그램 조회*/
	$("#searchDetailBtn").kendoButton({
		icon: "search",
		click: doDetailSearch
	});
	
	function doDetailSearch(e) {
		var strWindowFeatures = "scrollbars=no,toolbar=no,location=no,resizable=yes,status=no,menubar=no,width=680,height=830,left=0,top=0"; 
		var winobj = window.open("/urtown/mediConsultMgrPopup.do", "mediConsultMgrPopup", strWindowFeatures);
	};
	
	$(document).ready(function () {
		chartWindow = $("#chart-window");
		chartWindow.kendoWindow({
			width: "900px",
            actions: ["Close"],
            title: "chart"
		}).data("kendoWindow").close();
        
		$("#chart-mouseover-switch").kendoMobileSwitch({
			onLabel: "OVER",
			offLabel: "CLICK",
			checked: false
		});
		
		/*************************/
		/*       splitter        */
		/*************************/
		$("#horizontal").kendoSplitter({
			orientation: "horizontal",
			panes: [
				{ collapsible: true, resizable: true, min: "150px",	size: "25%"	}, 
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
	
		var detailinfoTemplate = kendo.template($("#detail-info-template").html());
		var detailnoteTemplate = kendo.template($("#detail-note-template").html());
	    var crudServiceBaseUrl = "/urtown/mediconsult/mgr";

		/*************************/
		/* waitinglist-grid */
		/*************************/
	    /*** dataSource ***/
		var waitinglistDs = new kendo.data.DataSource({
			transport: {
				read:  {
					url: crudServiceBaseUrl + "/waitingList.do",
	    			dataType: "jsonp",
	    			complete: function(e){ 
	    				console.log("/waitingList...................");
	    			}
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					if (type == "read"){
	                   	var result = {
    						AREA_GB: G_AREA_GB,
    						TOWN_ID: G_TOWN_ID,
							SEARCH: G_Search,
                           	KEYWORD: G_Keyword,
                           	CONSULT_REQ_DT: G_CONSULT_REQ_DT
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
					id: "MEDI_CONSULT_SQ",
					fields: { //data type of the field {Number|String|Boolean|Date} default is String
						MEDI_CONSULT_SQ:{ type: "number" },
						STATUS_CD: 		{ type: "string" },
						STATUS_NM: 		{ type: "string" },
						REQUEST_NO:		{ type: "string" },
						USER_NM:		{ type: "string" },
						USER_NO:		{ type: "string" },
						BIRTHDAY: 		{ type: "string" },
						CONSULT_REQ_DT: { type: "string" }
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
		/***   grid waitinglist-grid     ***/
		/*************************/
		var waitinglistGrid = $("#waitinglist-grid").kendoGrid({
			autoBind: true,
			dataSource: waitinglistDs,
			navigatable: true,
			pageable: true,
			height: 713,
			columns: [
				{ field: "STATUS_CD", title: "진행상태코드", width: 80, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "STATUS_NM", title: "진행상태", width: 80, attributes: {style: "text-align: center;"} },
				{ field: "USER_NO", title: "신청자번호", width: 80, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "USER_NM", title: "신청자", width: 120, attributes: {style: "text-align: center;"} },
				{ field: "BIRTHDAY", title: "생년월일", width: 100, attributes: {style: "text-align: center;"}, hidden: true,
					template: "#= (BIRTHDAY == '') ? '' : kendo.toString(kendo.parseDate(BIRTHDAY, 'yyyyMMdd'), 'yyyy-MM-dd') #" 
				},
				{ field: "CONSULT_REQ_DT", title: "상담요청일", width: 150, attributes: {style: "text-align: center;"}, hidden: true,
					template: "#= (CONSULT_REQ_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(CONSULT_REQ_DT))), 'yyyy-MM-dd') #" 
				},
				{ field: "REQUEST_NO", title: "접수번호", width: 150, attributes: {style: "text-align: center;"} }
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
			        
			        if(data.MEDI_CONSULT_SQ == null || data.MEDI_CONSULT_SQ == '') {
			        	G_MEDI_CONSULT_SQ = 0;
			        } else {
				        G_MEDI_CONSULT_SQ = data.MEDI_CONSULT_SQ;
			        }		
			        // 상담 정보 로드
			        detailInfoDs.read();
			        // 상담 노트 로드
			        //consultNoteDs.read(); // template
			        consultViewModel.dataSource.read();
			        $("#consultnote-form textarea[name=CONSULT_NOTE]").val("");  
			    });
			    
				invokeUserAuth($("#waitinglist-grid"), 'kendoGrid');
			}
		});//grid end...

		var detailInfoDs = new kendo.data.DataSource({
			transport: {
				read:  {
					url: crudServiceBaseUrl + "/detailInfo.do",
	    			dataType: "jsonp",
	    			complete: function(e){ 
	    				console.log("/detailInfo.do");
	    			}
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					if (type == "read"){
	                   	var result = {
	                           AREA_GB: G_AREA_GB,
	                           MEDI_CONSULT_SQ: G_MEDI_CONSULT_SQ
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
					id: "MEDI_CONSULT_SQ",
					fields: { //data type of the field {Number|String|Boolean|Date} default is String
						MEDI_CONSULT_SQ		: { type: "number" },
						REQUEST_NO			: { type: "number" },
						STATUS_NM			: { type: "string" },
						USER_NM				: { type: "string" },
						BIRTHDAY			: { type: "string" },
						ISSUE_NOTE			: { type: "string" },
						REG_DT				: { type: "string" },
						REG_USER			: { type: "string" },
						MOD_DT				: { type: "string" },
						MOD_USER			: { type: "string" },
						CHECKUP_NO			: { type: "string" },
						CHECKUP_DT			: { type: "string" }
					}  
				}
			},
	        error : function(e) {
		    	console.log('detailInfods error: ' + e.errors);
	        },
	        change: function(e) { // subscribe to the CHANGE event of the data source
	        	console.log("detailInfods change...........");
	            $("#consultinfo-view").html(kendo.render(detailinfoTemplate, this.view()));
	            infoEditorInit();
	        },
	        sync: function(e) {
				console.log("detailInfods sync complete");
				//console.log("model.dirty:"+this.schema.model.dirty);//수정되었는지 여부
				alert("정상적으로 처리되었습니다.");  
			},  
			serverPaging: true,        // 서버 사이드 페이징 활성화
			serverFiltering: false,
			serverSorting: false,      // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
			//autoSync: true,          //     자동 저장
			batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
			page: 1,                   //     반환할 페이지
			pageSize: 15,              //     반환할 항목 수
			skip: 0,                   //     건너뛸 항목 수
			take: 15                   //     반환할 항목 수 (pageSize와 같음)
		});//datasource grid end...
		
		/*************************/
		/* dataSource consultnote-grid */
		/*************************/
		var consultNoteModel = kendo.data.Model.define({
			id: "NOTE_SQ",
			fields: {
				NOTE_SQ			:{ type: "number" },
				MEDI_CONSULT_SQ	:{ type: "string" },
				CONSULT_NOTE	:{ type: "string" },
				REG_DT			:{ type: "string" },           
				REG_USER		:{ type: "string" },   
				MOD_DT			:{ type: "string" },           
				MOD_USER  		:{ type: "string" }
			}
		});
		var fffff = true;
	    /*** dataSource ***/
		consultViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read:  {
						url: crudServiceBaseUrl + "/consultnotes.do",
		    			dataType: "jsonp",
		    			complete: function(e){ 
		    				console.log("/consultnotes.do...................");
		    			}
					},
					update: {
						url: crudServiceBaseUrl + "/consultnote/update.do",
						dataType: "jsonp"
					},
					destroy: {
						url: crudServiceBaseUrl + "/consultnote/delete.do",
						dataType: "jsonp"
					},
					create: {
						url: crudServiceBaseUrl + "/consultnote/create.do",
						dataType: "jsonp"
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
								MEDI_CONSULT_SQ: G_MEDI_CONSULT_SQ
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
					model: consultNoteModel,
					data: function(response) {
						console.log("noteds data");
						console.log(response.rtnList);
						return response.rtnList;
					},
					total: function(response) {
						return response.total;
					},
					errors: function(response) {
						return response.error;
					}
				},
		        error : function(e) {
			    	console.log('noteds error: ' + e.errors);
		        },
		        change : function(e) {
		        	console.log("noteds change");
		            var _data = this.data()[0];
					console.log(_data);
					
					// only once run
					if(fffff) {
						noteEditorInit();
						fffff = false;
					}
					
		            _data.MOD_DT = (_data.MOD_DT.indexOf('-') >= 0) ? _data.MOD_DT : kendo.toString(kendo.parseDate(new Date(Number(_data.MOD_DT))), 'yyyy-MM-dd');
		            _data.CONSULT_NOTE = (_data.CONSULT_NOTE == null) ? '' : _data.CONSULT_NOTE;
					consultViewModel.set("selected", _data);
					
					invokeUserAuth($("#savenote-btn"), 'kendoButton', 'U');
					invokeUserAuth($("#CONSULT_NOTE"), 'kendoEditor', 'U');
		        },
		        requestStart: function(e) {
		        	if(e.type == "update" && e.response) {
		        	}
		        },
		        requestEnd: function(e) {
					if(e.type == "read" && e.response) {
		        	}
		        },
		        sync: function(e) { 
		        	//상담내용
		        	if( typeof $("#CONSULT_NOTE").val() != "undefined" ){
		        		var inData = $("#CONSULT_NOTE").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
			        	if(inData.length < 1 || inData == null){
								alert("상담내용을 입력해주세요.");
					    	   	e.preventDefault();	
				        }else{
							console.log("noteds sync");
							alert("정상적으로 처리되었습니다.");
							//this.refresh();
							//waitinglistDs.refresh();
							//detailInfoDs.refresh();
							this.read();
							waitinglistDs.read();
							detailInfoDs.read();
				        }//if
		        	}//undefined
				},
				dataBound: function(e){ 
					console.log("noteds dataBound");
				}
			}),
			error : function(e) {
            	console.log("kendo.observable:error" + e.errors);
            },
            change: function(e) {
            	console.log("kendo.observable:change");
            },
            batch: true,
            selected: function(){},
            hasChanges: false,
            sync: function (e) {
				console.log("kendo.observable:sync");
				consultViewModel.dataSource.data()[0].set("MOD_USER", "${userStore.username}"); 
				this.dataSource.sync();
            },
			close: function(){
				console.log("kendo.observable:close");
				//$("#grid").data("kendoGrid").dataSource.read();
			},
            cancel: function () {
            	console.log("kendo.observable:cancel");
                this.dataSource.cancelChanges();
            },
            remove: function () {
            	console.log("kendo.observable:remove");
            }
		});
	    
	    function noteEditorInit() {
			$("#consultnote-view").html(kendo.render(detailnoteTemplate, consultViewModel.dataSource.view()));
    	    kendo.bind($("#consultnote-form"), consultViewModel);
    	    $("#savenote-btn").kendoButton({
	            icon: "pencil",
	            click: onClick
	        });
   	        $("#CONSULT_NOTE").kendoEditor({
   	        	resizable: {
   	        		content: true,
   	        		toolbar: true
   	        	},
   	        	encoded: false
   	        });
	    }
	    
	    function infoEditorInit() {
   	        $("#ISSUE_NOTE").kendoEditor({ tools: [ ] });
            $($('#ISSUE_NOTE').data().kendoEditor.body).attr('contenteditable', false);
	    }
	    
	    
	    
	      
        
        
	});//document ready javascript end...
	
	function onClick(e) {
		consultViewModel.sync();
    }
	
	$("#chart-window").mouseleave(function(){
		closeChart();
	}); 
	 

    
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
    
    detailsTemplate = kendo.template($("#template").html());

    //$("#ecgBtn").kendoButton();
    
    
    

	function viewEcg(name, url){
		//var e= $("#gridDetail").data("kendoGrid");
        //var dataItem = e.dataItem($(e.currentTarget).closest("tr")); 
         
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