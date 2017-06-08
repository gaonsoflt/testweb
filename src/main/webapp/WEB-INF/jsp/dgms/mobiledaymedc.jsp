<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/mobileheader.jsp" %>


<body>
<div class="wrap">
	<div class="tab_btn">
		<ul>
			<li><a href="/appinf/mobiledaymedc.do?mdate=${mdate}&user_id=${user_id}" class="on">복약기록</a></li>			
			<li><a href="/appinf/mobiledayecg.do?mdate=${mdate}&user_id=${user_id}">심전도기록</a></li>			
			<li><a href="/appinf/mobiledaybld.do?mdate=${mdate}&user_id=${user_id}">혈압기록</a></li>
		</ul>
	</div>

	<article>
		<section>
			<div class="container">
			</div>
		</section>
	</article>

</div> <!-- wrap -->
<script>
$(document).ready(function(){
	$.ajax({
		type: "get",
		url: "<c:url value='/appinf/selectmobiledaymedcData.do?mdate=${mdate}&user_id=${user_id}'/>",//<c:url value='/appinf/selectMeasureScheduleInfo.do'/>
		async: false, //동기 방식
		success: function(data,status){
				var calData1_ = [];
	    		var calData2_ = [];
	    		var calData3_ = [];
				var bCalData_ = [];
				var date = new Date();
				var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
				var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
				var lastDayOfMonth = (lastDay.getDate());
				var thisYM=date.getFullYear()+"-"+ (date.getMonth()+1);
				
				if (data["rtnList"].length !=undefined && data["rtnList"].length>0)
				{
					$(".container").empty();
					var strdiv="";
					for( var j = 0; j <data["rtnList"].length; j++ )
					{   
						var takestate="cn";
						if (j==0)
						{
							strdiv=strdiv+"<ul class=\"dt_ch01\">";
						}
						if (data["rtnList"][j]["STATE"]=="1")
						{
							takestate="co";
						}
						if (parseInt(data["rtnList"][j]["ACTION_HOUR"]) > 0 && parseInt(data["rtnList"][j]["ACTION_HOUR"]) <12)
						{
							strdiv=strdiv+"<li><span class=\"mo\"> </span><span class=\"dt\">아침 : "+data["rtnList"][j]["ACTION_HOUR"]+":"+data["rtnList"][j]["ACTION_MINUTE"]+ " "+data["rtnList"][j]["DSC"]+"</span><span class=\""+takestate+"\">"+data["rtnList"][j]["DSC"]+"</span></li>";
						}
						else if (parseInt(data["rtnList"][j]["ACTION_HOUR"]) > 12 && parseInt(data["rtnList"][j]["ACTION_HOUR"]) <15)
						{
							strdiv=strdiv+"<li><span class=\"af\"> </span><span class=\"dt\">점심 : "+data["rtnList"][j]["ACTION_HOUR"]+":"+data["rtnList"][j]["ACTION_MINUTE"]+ " "+data["rtnList"][j]["DSC"]+"</span><span class=\""+takestate+"\">"+data["rtnList"][j]["DSC"]+"</span></li>";
						}
						else if (parseInt(data["rtnList"][j]["ACTION_HOUR"]) >=15 && parseInt(data["rtnList"][j]["ACTION_HOUR"]) <=23)
						{
							strdiv=strdiv+"<li><span class=\"ni\"> </span><span class=\"dt\">저녁 : "+data["rtnList"][j]["ACTION_HOUR"]+":"+data["rtnList"][j]["ACTION_MINUTE"]+ " "+data["rtnList"][j]["DSC"]+"</span><span class=\""+takestate+"\">"+data["rtnList"][j]["DSC"]+"</span></li>";
						}
						if (j==(data["rtnList"].length-1))
						{
							strdiv=strdiv+"</ul>";
						}
					}
					
					$(".container").append(strdiv);
				}
				else
				{
					$(".container").html("<div style='padding:20px 40px 40px 20px;'> <B>수집된 복약 정보가 없습니다.</B></div>");
				}
				
		},
		fail: function(){},
		complete: function(data){
			
		}
	});   
});	
</script>
 </body>
</html>
