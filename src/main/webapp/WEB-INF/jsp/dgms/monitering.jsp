<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>

<script>
$(document).ready(function(){
$('#monitering').parent().parent().addClass('active');
$('#monitering').addClass('active');
});	
</script> 
<style> 
	#sWrap{display:inline-block; margin-bottom: 8px;}
	#cntView{display:inline-block; font-weight:bold;}
	.inline{display:inline-block;} 
	h4{font-weight:bold; font-size:15px; margin-top:60px; color:#444} 
</style>
<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i>기기통합모니터링
			<small></small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 운영관리</a></li>
			<li class="active">기기통합모니터링&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
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
					

					<!-- 검색조건 -->

				<p>

					<div style="font-size: 15px;">
						&nbsp;&nbsp;&nbsp;
						관리기관: <input id="in_area" />&nbsp;&nbsp;&nbsp; 
						<button id="searchBtn" type="button">조회</button>
					</div>

					<script>
					var G_AreaCdVal = "${userStore.areaid2}";//조회조건 : 관리기관코드
						var G_EquipmentVal="ALL";		//장비 변수
						var totalEquip=0;
						var nrentc=0;
						var rentc=0; 



						$(document).ready(function () { 

							//관리기관 검색
							$("#in_area").kendoComboBox({
								index: 0,
								dataTextField: "CD_NM",
								dataValueField: "CD",
								filter: "contains",
								dataSource: {
									transport: {
										read: {
											url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
											dataType: "jsonp"
										},
										parameterMap: function(data, type) {//type =  read, create, update, destroy
											var result = {
													//AREA_ID: G_AreaCdVal, 
													CD_ID: "_AREA_ID_",
													USER_ID: "${userStore.username}",
													USE_YN: "1"
											};
											return { params: kendo.stringify(result) }; 
										}
									}
								},
								dataBound: function(e) {
									G_AreaCdVal = this.value();  
								},  
								change: function(e) { 
									G_AreaCdVal = this.value(); 
									//alert("G_AreaCdVal:"+G_AreaCdVal);
								}
							}); 
							
							var combobox = $("#in_area").data("kendoComboBox");
							//alert(G_AreaCdVal);
							//$("#in_area").val(G_AreaCdVal);
							combobox.value(G_AreaCdVal); 
							combobox.trigger("change"); 
						});
					</script>  

				</p>
					<!-- 차트 --> 
					<div id="chart"></div>
					
					<script> 
						$(document).ready(function () {
							/* 조회 */
							$("#searchBtn").kendoButton({
								icon: "search",
								click: function(e) {  
									//초기화 
									createChart();
									equipCnt();
									var gridDetail = $("#gridDetail").data("kendoGrid");
									gridDetail.dataSource.read();
									
									var gridDetail2 = $("#gridDetail2").data("kendoGrid");
									gridDetail2.dataSource.read();
									
									var gridDetail3 = $("#gridDetail3").data("kendoGrid");
									gridDetail3.dataSource.read();
								}
							});


							/* 조회 */
							$("#searchBtn2").kendoButton({
								icon: "search",
								click: function(e) {  
									//초기화 
									createChart();
									equipCnt();
									var gridDetail = $("#gridDetail").data("kendoGrid");
									gridDetail.dataSource.read();
									
									var gridDetail2 = $("#gridDetail2").data("kendoGrid");
									gridDetail2.dataSource.read();
									
									var gridDetail3 = $("#gridDetail3").data("kendoGrid");
									gridDetail3.dataSource.read();
								}
							});
							
							function equipCnt() { 
								$.ajax({
									type: "get",
									url: "<c:url value='/dgms/selectMorniteringDataCNT1.do?fromdate="+$("#fromdate").val()+"&todate="+$("#todate").val()+"&AREA_ID="+G_AreaCdVal+"&G_EquipmentVal="+G_EquipmentVal+"' />",
									async: false, //동기 방식
									success: function(data,status){
										//Data Mapping 
										for( var i=0; i<data["rtnList"].length; i++ ){   	
											var ob = data["rtnList"][i];
											nrentc=ob["NRENTC"];
											rentc=ob["RENTC"];  
											totalEquip = nrentc + rentc;
										}  
										$("#rentc").text(rentc);
										$("#nrentc").text(nrentc);
										$("#totalEquip").text(totalEquip);
									}, 
									fail: function(){},
									complete: function(data){ 
										 
									}
								});    
							}  


							function createChart() {
								var state = [];
								var cnt1 = [];
								var cnt2 = [];
								var cnt3 = [];
								var cnt4 = [];
								 
								$.ajax({
									type: "get",
									url: "<c:url value='/dgms/selectChartDataMornitering.do?fromdate="+$("#fromdate").val()+"&todate="+$("#todate").val()+"&AREA_ID="+G_AreaCdVal+"' />",
									async: false, //동기 방식
									success: function(data,status){
										//Data Mapping
										for( var i=0; i<data["rtnList"].length; i++ ){   	
											var ob = data["rtnList"][i];
											state.push(ob[""]);
											cnt1.push(ob["CNT1"]); 
											cnt2.push(ob["CNT2"]); 
											cnt3.push(ob["CNT3"]); 
											cnt4.push(ob["CNT4"]);  
										}
										
										//Data Chart View
										 $("#chart").kendoChart({
												title: {
													text: "기기상태"
												},
												legend: {
												   position: "top"
												},
												seriesDefaults: {
												   // stack: true
													type: "column"
												},
												series: [{
													name: "디지털 약상자",
													data: cnt1,
													color: "#0045AB"
												}, {
													name: "활동용 심전도기",
													data: cnt2,
													color: "#FF2222"
												}, {
													name: "댁내용 심전도기",
													data: cnt3,
													color: "#FFFF00"
												}, {
													name: "혈압기",
													data: cnt4,
													color: "#3CAB00"
												}],
												valueAxis: {
													//max: 5,
													line: {
														visible: false
													},
													minorGridLines: {
														visible: true
													}
												},
												categoryAxis: {
													//categories: state,
													categories: ["정상", "파손", "수리중", "전체"],
													majorGridLines: {
														visible: false
													}
												},
												tooltip: {
													visible: true,
													template: "#= series.name #: #= value #"
												}
											});
										
										
										
									}, 
									fail: function(){},
									complete: function(data){
									}
								});    
							} 
							$(document).ready(equipCnt);
							$(document).ready(createChart);
							$(document).bind("kendo:skinChange", createChart);  
						});
					</script>


					<!-- 1. 기기현황 -->
						
                  	<h4>기기현황 </h4> 
					<div id="gridDetail"></div>
					<script>
						   $(document).ready(function () {
 
								/**********************************************************************************************************/
								/********************************************** dataSource ***********************************************/
								/**********************************************************************************************************/
								var crudServiceBaseUrl = "<c:url value='/dgms'/>",	
											
								dataSourceDetail = new kendo.data.DataSource({
								    serverPaging: false,
									transport: {
										read:  {
											url: crudServiceBaseUrl + "/selectMorniteringData1.do",
											dataType: "jsonp",
											complete : function(){

											}
										}, 
										parameterMap: function(data, type) {//type =  read, create, update, destroy
											var result = {
													AREA_ID: G_AreaCdVal
													//CD_ID: "",
													//USE_YN: ""
				                            };
											return { params: kendo.stringify(result) };   
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
										model:{ 
											id:"MEDC", 
											fields: {
												MEDC: { 
													type: "Number", 
													editable: false   
												},
												ECG_1: { 
													type: "Number", 
													editable: false  
												},
												ECG_2 : { 
													type: "Number", 
													editable: false 
												},
												BLDPRS : { 
													type: "Number", 
													editable: false 
												},
												ALE : { 
													type: "Number", 
													editable: false 
												} 
											}   
										}
									},
									error : function(e) {
									console.log(e.errors);
										alert("Error:" + e.errors);
									},
									change : function(e) { 
									},  	
									sync: function(e) {
										console.log("sync complete"); 
										alert("정상적으로 처리되었습니다.");  
									},   
									batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
									page: 1,                   //     반환할 페이지
									pageSize: 10,              //     반환할 항목 수
									skip: 0,                   //     건너뛸 항목 수
									take: 10                   //     반환할 항목 수 (pageSize와 같음)
								});//datasource gridDetail end...
					 




								/*************************/
								/***    gridDetail     ***/
								/*************************/
								$("#gridDetail").kendoGrid({
									autoBind: true,
									dataSource: dataSourceDetail,
									//navigatable: false,
									//pageable: false,
									height: 100,
									toolbar: [ 
									{ name: "excel", text: "엑셀" } 
									],
									columns: [
										{
											field: "ALE",
											title: "총수량",
											attributes: {style: "text-align: center;"},
											width: 100
										}, 
										{
											field: "MEDC",
											title: "디지털 약상자",
											attributes: {style: "text-align: center;"},
											width: 100
										},
										{
											field: "ECG_1",
											title: "댁내용 심전도계",
											attributes: {style: "text-align: center;"},
											width: 100
										},
										{
											field: "ECG_2",
											title: "활동용 심전도계",
											attributes: {style: "text-align: center;"},
											width: 100
										},
										{
											field: "BLDPRS",
											title: "혈압계",
											attributes: {style: "text-align: center;"},
											width: 100
										}
									],
									editable: false,
									sortable: true,
									//selectable: true, //selectable: "multiple cell","multiple row","cell","row",
									scrollable: false,
									mobile: true, 
									//excel, pdf
									excel: {
										allPages: true,
										fileName: "기기현황.xlsx",
									},
									pdf: {
										allPages: true,
										fileName: "기기현황.pdf",
										paperSize: "A4",
										landscape: true,
										scale: 0.75
									},      

									noRecords: { 
										template: "No data"
									},
									resizable: true,  //컬럼 크기 조절
									reorderable: true, //컬럼 위치 이동
									save: function(e) {//저장전 이벤트
										console.log("save...............");
									},
									saveChanges: function(e) {//저장버턴 클릭시 이벤트
									} 
								});//gridDetail end...
							});
							</script>

							
                  			<h4>기기상태 </h4>
                  			
							<!-- 2. 기기상태 -->
							<div id="gridDetail2"></div>

							<script>
						   $(document).ready(function () { 
								/**********************************************************************************************************/
								/********************************************** dataSource2 ***********************************************/
								/**********************************************************************************************************/
								var crudServiceBaseUrl = "<c:url value='/dgms'/>",	
											
								dataSourceDetail = new kendo.data.DataSource({
								    serverPaging: false,
									transport: {
										read:  {
											url: crudServiceBaseUrl + "/selectMorniteringData2.do",
											dataType: "jsonp",
											complete : function(){
											}
										}, 
										parameterMap: function(data, type) {//type =  read, create, update, destroy
											var result = {
													AREA_ID: G_AreaCdVal
													//CD_ID: "",
													//USE_YN: ""
				                            };
											return { params: kendo.stringify(result) };   
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
										model:{ 
											id:"SORT", 
											fields: {
												SORT: {
													type: "Number", 
													editable: false 
												},
												MEDC: { 
													type: "Number", 
													editable: false   
												},
												ECG_1: { 
													type: "Number", 
													editable: false  
												},
												ECG_2 : { 
													type: "Number", 
													editable: false 
												},
												BLDPRS : { 
													type: "Number", 
													editable: false 
												}
											}   
										}
									},
									error : function(e) {
									console.log(e.errors);
										alert("Error:" + e.errors);
									},
									change : function(e) { 
									},  	
									sync: function(e) {
										console.log("sync complete"); 
										alert("정상적으로 처리되었습니다.");  
									},   
									batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
									page: 1,                   //     반환할 페이지
									pageSize: 10,              //     반환할 항목 수
									skip: 0,                   //     건너뛸 항목 수
									take: 10                   //     반환할 항목 수 (pageSize와 같음)
								});//datasource gridDetail end...
					 




								/*************************/
								/***    gridDetail2    ***/
								/*************************/
								$("#gridDetail2").kendoGrid({
									autoBind: true,
									dataSource: dataSourceDetail,
									//navigatable: false,
									//pageable: false,
									height: 198,
									toolbar: [ 
									{ name: "excel", text: "엑셀" } 
									],
									columns: [
										{
											field: "SORT",
											title: "정렬",
											attributes: {style: "text-align: center;"},
											hidden:true
										}, 
										{
											field: "TITLE",
											title: "구분",
											attributes: {style: "text-align: center;"},
											width: 100
										}, 
										{
											field: "NOR",
											title: "정상",
											attributes: {style: "text-align: center;"},
											width: 100
										},
										{
											field: "DAM",
											title: "파손",
											attributes: {style: "text-align: center;"},
											width: 100
										},
										{
											field: "REP",
											title: "수리",
											attributes: {style: "text-align: center;"},
											width: 100
										},
										{
											field: "ALE",
											title: "총수량",
											attributes: {style: "text-align: center;"},
											width: 100
										}
									],
									editable: false,
									sortable: true,
									//selectable: true, //selectable: "multiple cell","multiple row","cell","row",
									scrollable: false,
									mobile: true, 
									//excel, pdf
									excel: {
										allPages: true,
										fileName: "기기상태.xlsx",
									},
									pdf: {
										allPages: true,
										fileName: "기기상태.pdf",
										paperSize: "A4",
										landscape: true,
										scale: 0.75
									},      

									noRecords: { 
										template: "No data"
									},
									resizable: true,  //컬럼 크기 조절
									reorderable: true, //컬럼 위치 이동
									save: function(e) {//저장전 이벤트
										console.log("save...............");
									},
									saveChanges: function(e) {//저장버턴 클릭시 이벤트
									} 
								});//gridDetail end...
 
							});//jquery end
					</script>


                  			<h4 class='inline'> 환자별 기기대여 </h4> 
								<div id="sWrap">&nbsp;&nbsp;&nbsp;
								사용중인 장비&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;<input id="in_equiment" />
					            <!--<select id="in_equiment" style="width: " >
					                <option value="ALL">전체</option>
					                <option value="BLDPRS">혈압계</option>
					                <option value="ECG_2">댁내용 심전도</option>
					                <option value="ECG_1">활동용 심전도</option>
					                <option value="MEDC">디지털 약상자</option>
					            </select>-->
								&nbsp;&nbsp;&nbsp; 
								<button id="searchBtn2" type="button">조회</button>
								&nbsp;&nbsp;&nbsp; 
                  				<span id="cntView">대여 <span id='rentc'>0</span>개&nbsp;&nbsp;&nbsp;재고  <span id='nrentc'>0</span>개&nbsp;&nbsp;&nbsp;&nbsp;총 <span id='totalEquip'>0</span>개</span>
							<!-- 3. 환자별 기기대여 -->
							</div>
							<div id="gridDetail3"></div>

							<script>							
							var rentEquipData = [ 
								{ text: "전체", value: "" },
								{ text: "혈압계", value: "BLDPRS" },
								{ text: "댁내용 심전도", value: "ECG_2" },
								{ text: "활동용 심전도", value: "ECG_1" },
								{ text: "디지털 약상자", value: "MEDC" }
							];

							$("#in_equiment").kendoComboBox({ 
								dataTextField: "text",
								dataValueField: "value",
								dataSource: rentEquipData,   
								change: eqOnChange,
								index: 0
							}); 
							
							function eqOnChange(){
								   G_EquipmentVal=$("#in_equiment").val(); 
							}

						   $(document).ready(function () { 
							   $("#in_equiment").on("change", function(e){
								   G_EquipmentVal=$("#in_equiment option:selected	").val(); 
							   });
							   
							   
								/**********************************************************************************************************/
								/********************************************** dataSource3 ***********************************************/
								/**********************************************************************************************************/
								var crudServiceBaseUrl = "<c:url value='/dgms'/>",	
											
								dataSourceDetail = new kendo.data.DataSource({
								    serverPaging: false,
									transport: {
										read:  {
											url: crudServiceBaseUrl + "/selectMorniteringData3.do",
											dataType: "jsonp",
											complete : function(){
											}
										}, 
										parameterMap: function(data, type) {//type =  read, create, update, destroy

											var result = {
													AREA_ID: G_AreaCdVal,
													G_EquipmentVal: G_EquipmentVal
													//CD_ID: "",
													//USE_YN: ""
				                            };
											return { params: kendo.stringify(result) };   
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
										model:{ 
											id:"RENT_USER_NM", 
											fields: {
												RENT_USER_NM: { 
													type: "String", 
													editable: false   
												},
												MEDC: { 
													type: "Number", 
													editable: false  
												},
												ECG_1 : { 
													type: "Number", 
													editable: false 
												},
												ECG_2 : { 
													type: "Number", 
													editable: false 
												},
												BLDPRS : { 
													type: "Number", 
													editable: false 
												}
											}   
										}
									},
									error : function(e) {
									console.log(e.errors);
										alert("Error:" + e.errors);
									},
									change : function(e) { 
									},  	
									sync: function(e) {
										console.log("sync complete"); 
										alert("정상적으로 처리되었습니다.");  
									},   
									serverPaging: true,        // 서버 사이드 페이징 활성화
									serverFiltering: false,
									serverSorting: false,      // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
									batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
									page: 1,                   //     반환할 페이지
									pageSize: 10,              //     반환할 항목 수
									skip: 0,                   //     건너뛸 항목 수
									take: 10                   //     반환할 항목 수 (pageSize와 같음)
								});//datasource gridDetail end...
					 




								/*************************/
								/***    gridDetail3    ***/
								/*************************/
								$("#gridDetail3").kendoGrid({
									autoBind: true,
									dataSource: dataSourceDetail,
									navigatable: true,
									pageable: true,
									height: 500,
									toolbar: [ 
									{ name: "excel", text: "엑셀" } 
									],
									columns: [
										{
											field: "RENT_USER_NM",
											title: "대여자",
											attributes: {style: "text-align: center;"},
											width: 100
										}, 
										{
											field: "MEDC",
											title: "디지털 약상자",
											attributes: {style: "text-align: center;"},
											width: 100
										},
										{
											field: "ECG_1",
											title: "댁내용 심전도계",
											attributes: {style: "text-align: center;"},
											width: 100
										},
										{
											field: "ECG_2",
											title: "활동용 심전도계",
											attributes: {style: "text-align: center;"},
											width: 100
										},
										{
											field: "BLDPRS",
											title: "혈압계",
											attributes: {style: "text-align: center;"},
											width: 100
										}
									],
									editable: false,
									sortable: true,
									selectable: false, //selectable: "multiple cell","multiple row","cell","row",
									scrollable: true,
									mobile: true, 
									//excel, pdf
									excel: {
										allPages: true,
										fileName: "환자별기기대여.xlsx",
									},
									pdf: {
										allPages: true,
										fileName: "환자별기기대여.pdf",
										paperSize: "A4",
										landscape: true,
										scale: 0.75
									},      

									noRecords: { 
										template: "No data"
									}, 
			 			            pageable: {	
						            		//refresh: true, //하단의 리프레쉬 아이콘
						            		pageSizes: true,
						            		//buttonCount: 1  //paging 갯수
						            		//input: true //페이지 직접입력
						            		//info: true, //하단의 페이지 정보
						            		messages: {
						            	      display: "전체 {2}개 항목 중 {0}~{1}번째 항목 출력",
						            	      empty: "출력할 항목이 없습니다",
						            	      itemsPerPage: "한 페이지에 출력할 항목 수"
						            	    }
						            }, 
									resizable: true,  //컬럼 크기 조절
									reorderable: true, //컬럼 위치 이동
									save: function(e) {//저장전 이벤트
										console.log("save...............");
									},
									saveChanges: function(e) {//저장버턴 클릭시 이벤트
									} 
								});//gridDetail end...
 
							});//jquery end
					</script>

 

					</div>
				</div><!-- box -->
			</div><!-- col-xs-12 -->
		</div><!-- row -->
	</section>    
</div>

<%@ include file="../inc/footer.jsp" %>