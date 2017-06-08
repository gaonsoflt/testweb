<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/mobileheader.jsp" %>
<body>
<div class="wrap">
	<div class="tab_btn">
		<ul>
			<li><a href="/appinf/mobiledaymedc.do?mdate=${mdate}&user_id=${user_id}">복약기록</a></li>	
			<li><a href="/appinf/mobiledayecg.do?mdate=${mdate}&user_id=${user_id}" class="on">심전도기록</a></li>		
			<li><a href="/appinf/mobiledaybld.do?mdate=${mdate}&user_id=${user_id}">혈압기록</a></li>			
		</ul>
	</div>

	<article>
		<section>
			<div id="ecglist">
			</div>
		</section>
	</article>

</div> <!-- wrap -->
<script>
$(document).ready(function(){
	$.ajax({
		type: "get",
		url: "<c:url value='/appinf/selectmobiledayecgData.do?mdate=${mdate}&user_id=${user_id}'/>",//<c:url value='/appinf/selectMeasureScheduleInfo.do'/>
		async: false, //동기 방식
		success: function(data,status){

				if (data["rtnList"].length !=undefined && data["rtnList"].length>0)
				{
					$("#ecglist").empty();
					for( var j = 0; j <data["rtnList"].length; j++ )
					{   
						var strdiv="";

						strdiv=strdiv+"<div class=\"container2\">";
						strdiv=strdiv+"<p class=\"ctitle\">측정시간 : "+data["rtnList"][j]["ACTION_HOUR"]+":"+data["rtnList"][j]["ACTION_MINUTE"]+"</p>";
						strdiv=strdiv+"<ul class=\"dt_ch02\"><li><span class=\"sm\"> </span><span class=\"dt\">심박이상 : <span class=\"fr rcc pl20\">"+data["rtnList"][j]["UNUSUAL_CNT"]+"건</span></span></li>";
						strdiv=strdiv+"</ul><ul class=\"dt_ch03\">";
						strdiv=strdiv+"<li>Minimum <span class=\"fr gt rcc\">"+data["rtnList"][j]["MIN_HEART"]+"</span></li>";
						strdiv=strdiv+"<li>Maximum <span class=\"fr gt rcc\">"+data["rtnList"][j]["MAX_HEART"]+"</span></li>";
						strdiv=strdiv+"<li>Average <span class=\"fr gt rcc\">"+data["rtnList"][j]["AVG_HEART"]+"</span></li>";
						strdiv=strdiv+"<li>Max R-R <span class=\"fr gt rcc\">"+data["rtnList"][j]["MAX_RRS"]+"</span></li>";
						strdiv=strdiv+"<li>&gt; 100 bpm(빈맥) <span class=\"fr gt rcc\">"+data["rtnList"][j]["FREQ_CNT"]+"</span></li>";
						strdiv=strdiv+"<li>&lt; 50 bpm(서맥) <span class=\"fr gt rcc\">"+data["rtnList"][j]["INFREQ_CNT"]+"</span></li>";
						strdiv=strdiv+"</ul></div>";
						
						$("#ecglist").append(strdiv);
					}
				}
				else
				{
					$("#ecglist").append("<div class=\"container2\" style='padding:40px;'> <B>수집된 심전도 측정 정보가 없습니다.</B></div>");
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
