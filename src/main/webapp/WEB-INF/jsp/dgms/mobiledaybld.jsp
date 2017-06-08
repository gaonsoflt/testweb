<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/mobileheader.jsp" %>

<body>
<div class="wrap">
	<div class="tab_btn">
		<ul>
			<li><a href="/appinf/mobiledaymedc.do?mdate=${mdate}&user_id=${user_id}">복약기록</a></li>			
			<li><a href="/appinf/mobiledayecg.do?mdate=${mdate}&user_id=${user_id}">심전도기록</a></li>
			<li><a href="/appinf/mobiledaybld.do?mdate=${mdate}&user_id=${user_id}" class="on">혈압기록</a></li>	
		</ul>
	</div>

	<article>
		<section>
			<div id="bldlist">
			</div>
		</section>
	</article>

</div> <!-- wrap -->
<script>
$(document).ready(function(){
	$.ajax({
		type: "get",
		url: "<c:url value='/appinf/selectmobiledaybldData.do?mdate=${mdate}&user_id=${user_id}'/>",//<c:url value='/appinf/selectMeasureScheduleInfo.do'/>
		async: false, //동기 방식
		success: function(data,status){

				if (data["rtnList"].length !=undefined && data["rtnList"].length>0)
				{
					$("#bldlist").empty();
					for( var j = 0; j <data["rtnList"].length; j++ )
					{   
						var strdiv="";

						strdiv=strdiv+"<div class=\"container2\">";
						if (data["rtnList"][j]["STATE"]=="0")
						{
							strdiv=strdiv+"<p class=\"ctitle\">측정시간 : "+data["rtnList"][j]["ACTION_HOUR"]+":"+data["rtnList"][j]["ACTION_MINUTE"]+" "+data["rtnList"][j]["DSC"]+"</p>";
						}else
						{
							strdiv=strdiv+"<p class=\"ctitle\">측정시간 : "+data["rtnList"][j]["ACTION_HOUR"]+":"+data["rtnList"][j]["ACTION_MINUTE"]+" <span style='color:red;'>"+data["rtnList"][j]["DSC"]+"</span></p>";
						}
						strdiv=strdiv+"<ul class=\"dt_ch02\"><li><span class=\"bl\"> </span><span class=\"dt\">혈압 : "+data["rtnList"][j]["MIN_BLDPRS"]+"/"+data["rtnList"][j]["MAX_BLDPRS"]+"<span class=\"st\">mmHg</span></span></li>";
						strdiv=strdiv+"<li><span class=\"sm\"> </span><span class=\"dt\">심박수 : "+data["rtnList"][j]["HEART_RATE"]+"<span class=\"st\">bpm</span></span></li>";
						strdiv=strdiv+"</ul></div>";
						
						$("#bldlist").append(strdiv);
					}
				}
				else
				{
					$("#bldlist").append("<div class=\"container2\" style='padding:40px;'> <B>수집된 혈압 측정 정보가 없습니다.</B></div>");
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
