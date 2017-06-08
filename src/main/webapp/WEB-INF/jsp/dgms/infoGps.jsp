<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#infoGps').parent().parent().addClass('active');
	$('#infoGps').addClass('active');
});	
</script>
      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            안전서비스
            <small>위치파악</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 안전서비스</a></li>
            <li class="active">위치파악</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
          <div class="row">
          	<!-- 내용 -->
          	<div class="col-xs-12">
            
              <!-- table 하나 -->
              <div class="box">
                <div class="box-header">
                  <h3 class="box-title"><i class="fa fa-tag"></i>위치파악</h3>
                </div><!-- /.box-header -->
                <div class="box-body">
					<div id="map" style="width:800px;height:600px;"></div>
					
					        
		        </div>
		      </div><!-- box -->
            </div><!-- col-xs-12 -->
          </div><!-- row -->
        </section>    
      </div>

<!-- 임시 GPS 스타일  -->      
<style>
	#noData{margin-top:260px; text-align:center; color: #222d32;}
	#coordinate{text-align:center; width:148px;}
	#coordinate a{color:#3c8dbc !important;}
	#map{border:1px solid #222d32;}
</style>

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=4f6adc21d7ff1870334ffe81d7e96da5"></script>     
<!-- GPS 정보 -->
<script> 
		//사용자 이름, 사용자 최종 접속일, 사용자 위도, 사용자 경도
		var nm='${userStore.fullname}', id='${userStore.username}', dt, lat, lng;

		function selectGpsInfo(){ 

			$.ajax({
				data : "user_id="+id,
				dataType : "jsonp",
			    jsonp : "callback",
	            async: false,
				url : "<c:url value='/dgms/selectLastGPSInfo.do'/>", 
				success:function(data){
					rd = data.rtnList[0];
					if(rd != null){
						var gDate = new Date(rd.CRE_DT);
						nm = rd.USER_NM;
						dt = gDate.getFullYear() + "-" + (gDate.getMonth() + 1) + "-" + (gDate.getDate()) + " "
							 + gDate.getHours() + ":" + gDate.getMinutes() + ":" + gDate.getSeconds();
						lat = rd.GPS_LAT;
						lng = rd.GPS_LON;
						openGpsMap();
					}else{
						$("#map").html("<div id='noData'>표시할 정보가 없습니다.</div>");
					}
				},
				error:function(e){ 
					alert("서버 연결에 실패하였습니다.");
				}
			});
		}//selectGpsInfo
		
		function openGpsMap(){
			var mapContainer = document.getElementById('map');
			var mapOption = {
				center: new daum.maps.LatLng(lat, lng),
				level: 3
			};

			var map = new daum.maps.Map(mapContainer, mapOption);

			// 마커가 표시될 위치입니다 
			var markerPosition  = new daum.maps.LatLng(lat, lng); 

			// 마커를 생성합니다
			var marker = new daum.maps.Marker({
			    position: markerPosition
			});

			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			//2016-10-16 15:32:23
			var iwContent = '<div id="coordinate" style="padding:5px;"><b>'+nm+'님</b> <br> '+dt+' <br><a href="http://map.daum.net/link/map/관리자 님,'+lat+','+lng+'" style="color:blue" target="_blank">큰지도보기</a> <a href="http://map.daum.net/link/to/관리자 님,'+lat+','+lng+'" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwPosition = new daum.maps.LatLng(lat, lng); //인포윈도우 표시 위치입니다

			// 인포윈도우를 생성합니다
			var infowindow = new daum.maps.InfoWindow({
			    position : iwPosition, 
			    content : iwContent 
			});
			  
			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow.open(map, marker); 
		}
		
		$(document).ready(function(){ 
			selectGpsInfo(); 
		});
	</script>
<%@ include file="../inc/footer.jsp" %>