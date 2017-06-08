<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/mobileheader.jsp" %>
<body>
<div class="wrap">
	<div id="mcontent">
		<div id ="searchArea" style="font-size: 15px;">
			<table id="searchArea">
				<tr>
					<td>관리기관: </td><td><input id="in_area" /></td>
				</tr>
				<tr>
					<td>시작일자: </td><td><input id="fromdate" name="fromdate" value="${fromdate}"/></td>
				</tr>
				<tr>
					<td>종료일자: </td><td><input id="todate" name="todate" value="${todate}"/></td>
				</tr>
				<tr>
					<td>기간별 비율: </td><td><input id="in_item" /></td>
				</tr>
				<tr class="tdn">
					<td>사용율: </td><td><input id="in_percent" /></td>
				</tr>
				<tr>
					<td colspan="2"><button id="searchBtn" type="button">조회</button></td>
				</tr>
			</table> 
		</div>
	
	
		
		<table id="view" class="rtable rtable--flip">
			<thead>
			<tr>
				<th>사용자</th>
				<th>기간별 복약 횟수</th>
				<th>기간별 혈압측정 횟수</th>
				<th>기간별 심전도측정 횟수</th>
				<th>기간별 복약률</th>
				<th>기간별 혈압측정률</th>
				<th>기간별 심전도측정률</th>
			</tr>
			</thead>
			<tbody> 
			</tbody>
		</table>
		<div id="pagenavi">
			<span class='navi prev'> < </span>
			<span>11</span>
			<span>21</span>
			<span>31</span>
			<span>41</span>
			<span>51</span>
			<span>61</span>
			<span>71</span>
			<span>81</span>
			<span>91</span>
			<span>10</span>
			<span class='navi next'> > </span>
		</div>
	
		<style>
			.sPage{color:red !important}
			.prev, .next{display: none !important}
			#view{margin:30px auto 20px auto;}
			#mcontent{width:90%; margin:0 auto;} 
			#searchBtn{clear:both; border:solid 1px #c1c1c1; font-size:14px; width:100%;  padding:5px 0; background-color:transparent; cursor:pointer}
			table thead tr th{text-align: center;}
			table tbody tr td{text-align: right;} 
			table tbody tr .tdname{text-align: center;} 
			#pagenavi{width:100%; text-align:center;}
			#pagenavi span{margin: auto 5px 50px 5px; cursor:pointer; border: 1px solid #ccc; color: #111; padding:3px 8px; display: inline-block;  text-align: center;}
			/*width: 20px; height: 20px;*/
			/*table tbody tr .tdname{text-align: right;}*/ 
		
			.rtable {
			  /*!
			  // IE needs inline-block to position scrolling shadows otherwise use:
			  // display: block;
			  // max-width: min-content;
			  */
			  display: inline-block;
			  vertical-align: top;
			  max-width: 100%;
			  
			  overflow-x: auto;
			  
			  // optional - looks better for small cell values
			  white-space: nowrap;
			
			  border-collapse: collapse;
			  border-spacing: 0;
			}
			
			.rtable,
			.rtable--flip tbody {
			  // optional - enable iOS momentum scrolling
			  -webkit-overflow-scrolling: touch;
			  
			  // scrolling shadows
			  background: radial-gradient(left, ellipse, rgba(0,0,0, .2) 0%, rgba(0,0,0, 0) 75%) 0 center,
			              radial-gradient(right, ellipse, rgba(0,0,0, .2) 0%, rgba(0,0,0, 0) 75%) 100% center;
			  background-size: 10px 100%, 10px 100%;
			  background-attachment: scroll, scroll;
			  background-repeat: no-repeat;
			}
			
			// change these gradients from white to your background colour if it differs
			// gradient on the first cells to hide the left shadow
			.rtable td:first-child,
			.rtable--flip tbody tr:first-child {
			  background-image: linear-gradient(to right, rgba(255,255,255, 1) 50%, rgba(255,255,255, 0) 100%);
			  background-repeat: no-repeat;
			  background-size: 20px 100%;
			}
			
			// gradient on the last cells to hide the right shadow
			.rtable td:last-child,
			.rtable--flip tbody tr:last-child {
			  background-image: linear-gradient(to left, rgba(255,255,255, 1) 50%, rgba(255,255,255, 0) 100%);
			  background-repeat: no-repeat;
			  background-position: 100% 0;
			  background-size: 20px 100%;
			}
			
			.rtable th {
			  font-size: 11px !important;
			  text-align: left;
			  text-transform: uppercase;
			  background: #f2f0e6;
			}
			
			.rtable td {
				font-size: 11px !important;
			}
			
			.rtable th,
			.rtable td {
			  padding: 6px 12px;
			  border: 1px solid #d9d7ce;
			}
			
			.rtable--flip {
			  display: flex;
			  overflow: hidden;
			  background: none;
			}
			
			.rtable--flip thead {
			  display: flex;
			  flex-shrink: 0;
			  min-width: min-content;
			}
			
			.rtable--flip tbody {
			  display: flex;
			  position: relative;
			  overflow-x: auto;
			  overflow-y: hidden;
			}
			
			.rtable--flip tr {
			  display: flex;
			  flex-direction: column;
			  min-width: min-content;
			  flex-shrink: 0;
			}
			
			.rtable--flip td,
			.rtable--flip th {
			  display: block;
			}
			
			.rtable--flip td {
			  background-image: none !important;
			  // border-collapse is no longer active
			  border-left: 0;
			}
			
			// border-collapse is no longer active
			.rtable--flip th:not(:last-child),
			.rtable--flip td:not(:last-child) {
			  border-bottom: 0;
			}
			
			/*!
			// CodePen house keeping
			*/
			
			body {
			  margin: 0;
			  padding: 25px;
			  color: #494b4d;
			  font-size: 14px;
			  line-height: 20px;
			}
			
			h1, h2, h3 {
			  margin: 0 0 10px 0;
			  color: #1d97bf;
			}
			
			h1 {
			  font-size: 25px;
			  line-height: 30px;
			}
			
			h2 {
			  font-size: 20px;
			  line-height: 25px;
			}
			
			h3 {
			  font-size: 16px;
			  line-height: 20px;
			}
			
			table {
			  margin-bottom: 30px;
			}
			
			a {
			  color: #ff6680;
			}
			
			code {
			  background: #fffbcc;
			  font-size: 12px;
			}
			
			#pagenavi span{
				line-height: 20px;
			}
		</style>
		<script> 
			if (/(iPhone|iPad|iPod)/gi.test(navigator.userAgent) && window.location.pathname.indexOf('/full') > -1) {
			  var p = document.createElement('p');
			  p.innerHTML = '<a target="_blank" href="http://s.codepen.io/dbushell/debug/wGaamR"><b>Click here to view this demo properly on iOS devices (remove the top frame)</b></a>';
			  document.body.insertBefore(p, document.body.querySelector('h1'));
			}
		</script>
	</div>
</div>
	<!-- wrap -->
    <!-- Common Kendo UI CSS for web widgets and widgets for data visualization. -->
    <link href="/resource/kendoui/styles/kendo.common.min.css" rel="stylesheet" />
    <!-- (Optional) RTL CSS for Kendo UI widgets for the web. Include only in right-to-left applications. -->
    <link href="/resource/kendoui/styles/kendo.rtl.min.css" rel="stylesheet" type="text/css" />
    <!-- Default Kendo UI theme CSS for web widgets and widgets for data visualization. -->
    <link href="/resource/kendoui/styles/kendo.default.min.css" rel="stylesheet" />
    <!-- (Optional) Kendo UI Hybrid CSS. Include only if you will use the mobile devices features. -->
    <link href="/resource/kendoui/styles/kendo.default.mobile.min.css" rel="stylesheet" type="text/css" />		
    <!-- jQuery JavaScript -->
    
    <!-- Kendo UI combined JavaScript -->
    <script charset="UTF-8"  src="/resource/kendoui/js/kendo.all.min.js"></script>
    <!-- kendo 지역 설정 -->
    <script src="/resource/kendoui/js/cultures/kendo.culture.ko-KR.min.js"></script>
	<!--<![endif]-->
	<script> 
	$(document).ready(function(){
		var crudServiceBaseUrl = "<c:url value='/appinf'/>";	//기본경로
		var fromdate='2016-09-28', todate='2016-10-28', user_id='${user_id}', AREA_ID='101372';
		var total=0, page=1, cpage=1, pagesize=10, lpage=1, item=null, percent=null;
		var G_AreaCdVal = "101372";//조회조건 : 관리기관코드
		var G_UserNmVal;//조회조건 : 사용자명  
		
		
		//관리기관 검색
		$("#in_area").kendoComboBox({
			index: 0,
			dataTextField: "CD_NM",
			dataValueField: "CD",
			filter: "contains",
			dataSource: {
				transport: {
					read: {
						url: crudServiceBaseUrl+"/getCodeListByCdID.do",
						dataType: "jsonp"
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						var result = {
								//AREA_ID: G_AreaCdVal, 
								CD_ID: "_AREA_ID_",
								USER_ID: user_id,
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
			}
		}); 
		
		var combobox = $("#in_area").data("kendoComboBox");
		combobox.value(G_AreaCdVal); 
		combobox.trigger("change");
		
		
		
		function getData(){ 
			var params="fromdate="+fromdate+"&todate="+todate+"&PAGE="+page+"&PAGESIZE="+pagesize+"&AREA_ID="+G_AreaCdVal+"&item="+item+"&percent="+percent;
			
			$.ajax({
				url: crudServiceBaseUrl+"/selectMngIntegDetailInfoJsonp.do",
				type: "post",
				data: params,
		        dataType: "jsonp",
		        jsonpCallback: "callback",
				success: function(data){ 
					var wraplist = data.rtnList; 
					var tableData = "";
					
					total = data.total;
					var pageData = "<span class='prePage'><</span>";
					var pagecnt = Math.floor(total/pagesize) + (total%pagesize > 0 ? 1 : 0);
					lpage = pagecnt;

					for(var i=1; i<=pagecnt; i++){
						pageData += "<span class='nn";
						if(page == i){
							cpage = i;
							pageData += " sPage";
						}
						pageData += "'>"+i+"</span>";
					}
					pageData += "<span class='nextPage'>></span>";
					$("#pagenavi").html(pageData);
					
					$(wraplist).each(function(i, e){
						tableData += "<tr>";
						tableData += "<td class='tdname'>"+e.USER_NM+"</td><td>"+e.MEDC+"</td><td>"+e.BLDPRS+"</td><td>"+e.ECG
								  +"</td><td class='dp'>"+e.MEDC_P+"%</td><td class='dp'>"+e.BLDPRS_P+"%</td><td class='dp'>"+e.ECG_P+"%</td>";
						tableData += "</tr>";
					});   
					$("#view tbody").html(tableData);
				},
				fail: function(e){ 
				}
			});
		} 
		getData();

		$(document).on("click", ".nextPage", function(i, e){  
			var npage = ((cpage-1) / 10 + 1)*10 +1;
			if(npage > lpage){
				return; 
			}else{
				cpage = npage;
				getData();
			}
		});

		$(document).on("click", ".prePage", function(i, e){
			ppage = ((cpage-1) / 10 -1)*10 +9; 
			if(ppage < 1){ 
				return;
			}else{
				page = ppage;
				getData();
			} 
		});

		$(document).on("click", ".nn", function(i, e){ 
			if(page != $(this).text()){
				page = $(this).text();
				getData();
			}
		});
		
		$("#fromdate").on("change", function(){ fromdate = $(this).val() });
		$("#todate").on("change", function(){ todate = $(this).val() });
		
		 var itemData = [
		                { text: "전체", value: "" },
		                { text: "복약률", value: "MEDC" },
		                { text: "혈압측정률", value: "BLDPRS" },
		                { text: "심전도측정률", value: "ECG" }
		            ];
		
		            var percentData = [ 
		                { text: "100% 이하", value: "100" },
		                { text: "90% 이하", value: "90" },
		                { text: "80% 이하", value: "80" },
		                { text: "70% 이하", value: "70" },
		                { text: "60% 이하", value: "60" },
		                { text: "50% 이하", value: "50" },
		                { text: "40% 이하", value: "40" },
		                { text: "30% 이하", value: "30" },
		                { text: "20% 이하", value: "20" },
		                { text: "10% 이하", value: "10" }
		            ];
		
		$("#in_item").kendoComboBox({ 
			dataTextField: "text",
			dataValueField: "value",
			dataSource: itemData,   
		    change: itemOnChange,
			index: 0,
		});
		
		$("#in_percent").kendoComboBox({ 
			dataTextField: "text",
			dataValueField: "value",
			dataSource: percentData, 
		    change: percentOnChange,
			index: 0
		}); 
		$(".tdn").hide();

		function percentOnChange() {
		    var value = $("#in_percent").val(); 
			percent = value; 
		}
		
		function itemOnChange() {
		    var value = $("#in_item").val(); 
		                
			if(value == null || value.length < 1){ 
				item = null;
				percent=null;
				$(".tdn").hide();
			}else{
				item = value; 
				percent = $("#in_percent").val(); 
				$(".tdn").show();
			}
		};
		
		/* DropDownList Template */
		var codeModles;
		$.ajax({
			type: "post",
			url: "/dgms/getCodeListByCdIDModel.do",
			async: false, //동기 방식
			success: function(data,status){
				codeModles = data.rtnList;
			},
			fail: function(){},
			complete: function(){}
		});
		
		function fnCodeNameByCdID(code){
			var rtnVal = "";
			for (var i = 0; i < codeModles.length; i++) {
		           if (codeModles[i].CD_ID == code) {
		           	rtnVal = codeModles[i].CD_NM;
		           }
		       }
			return rtnVal;
		}
		
		function fnCodeNameByCd(code){
			var rtnVal = "";
			for (var i = 0; i < codeModles.length; i++) {
		           if (codeModles[i].CD == code) {
		           	rtnVal = codeModles[i].CD_NM;
		           }
		       }
			return rtnVal;
		}
		 
		/* 조회 */
		$("#searchBtn").kendoButton({
			icon: "search",
			click: function(e) {
				getData();
				//var gridDetail = $("#gridDetail").data("kendoGrid");
				//gridDetail.dataSource.read();
				//alert("G_AreaCdVal:"+G_AreaCdVal);
			}
		}); 

		
		$("#fromdate").kendoDatePicker({
	                    
	                    culture: "ko-KR",
	                    // display month and year in the input
	                    format: "yyyy-MM-dd"
	                });
		$("#todate").kendoDatePicker({
	                    
	                    culture: "ko-KR",
	                    // display month and year in the input
	                    format: "yyyy-MM-dd"
	                });
	
		var nowDay = new Date();
		var firstDay = new Date();
		firstDay.setMonth(firstDay.getMonth()-1); 
		
		$("#fromdate").data("kendoDatePicker").value(firstDay);
		$("#todate").data("kendoDatePicker").value(nowDay);
		 
	
	});//document ready javascript end...
	
	</script>
 </body>
</html>
