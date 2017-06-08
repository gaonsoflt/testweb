<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#checkCctvView').parent().parent().addClass('active');
	$('#checkCctvView').addClass('active');
});	
</script>
      <!-- 내용 -->
      <div class="content-wrapper">
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>CCTV조회
            <small>CCTV와 위치를 확인합니다.</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> CCTV관리</a></li>
            <li class="active">CCTV조회</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
						<p>
						<div style="font-size: 15px;">
						</div>
						</p>
						<div class="col-sm-12">
						<div id="caution2">
							<!-- (<img style="width:20px;" src="/static/assets/img/vlcicon.png" alt="vlcicon"/> 가 보이지 않은 때) -->
							CCTV가 보이지 않은 때는 Player를 다운 받은 후 설치하셔야 합니다. 
							<button class="btn btn-danger btn-label-left btn-sm"  onclick="downfile('<c:url value='/resource/cab/vlc-2.2.4-win32.exe' />','vlcPlayer'); return false;">
							<span><i class="fa  fa-download"></i></span>다운로드</button>
						</div>
                        <div id="caution"></div>
                        <div id="msg"></div>
						<div id="player"> 
						<object classid='clsid:9BE31822-FDAD-461B-AD51-BE1D1C159921' codebase='http://downloads.videolan.org/pub/videolan/vlc/latest/win32/axvlc.cab' 
						width='300px' height='232px' style='left: 0px; top: 0px; width: 300px; height: 232px;' id='HVCS1' events='True'>
						    <param name='src' value='' /> 
							<embed type='application/x-vlc-plugin' name='HVCS1' autoplay='yes' loop='no' width='300px' height='232px'></embed></object>
						</div>
						 
						 
						 
						<!-- 지도 표시 영역  --> 
						<div id="map" style="width:100%;height:750px;"></div>
						
						<!-- 지도 표시 스크립트  -->
  						<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=81uUryLAafGQeP8B2eD1"></script> 
  						<script> var ipaddress='<%=request.getRemoteAddr()%>';</script>
  						<!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=GKcwJyfNtt4jfEf53Dhz"></script> -->
						<script> 
							var markers = [], infoWindows = [];
							
							var mapOptions = {
								//지도 중심 위치-임의로 덕실마을 위치
							    center: new naver.maps.LatLng(35.293807,121.253168), 	//지도의 초기 중심 좌표
							    zoom: 10,												//지도의 초기 줌 레벨
						        minZoom: 1, 											//지도의 최소 줌 레벨
						        zoomControl: true 										//줌 컨트롤의 표시 여부
						        /*
						        zoomControlOptions: { 									//줌 컨트롤의 옵션
						            position: naver.maps.Position.TOP_RIGHT
						        }*/
							};
							
							var map = new naver.maps.Map('map', mapOptions);
							
							var bounds = map.getBounds(),
							    southWest = bounds.getSW(),
							    northEast = bounds.getNE(),
							    lngSpan = northEast.lng() - southWest.lng(),
							    latSpan = northEast.lat() - southWest.lat();
							
							
							
							
							
							
							
							///커스텀 스크립트//////////////////////////////////////////////////////////////////////////////////////////
							var agent = navigator.userAgent.toLowerCase();
							var G_AreaIdVal  = "${userStore.areaId}"; 
							var cctvList = new Array();
							var markers = new Array();
							var timer = 50, bFlag=true, cnt;
							
							//익스플로러가 아닌 경우
							//chrome, safari, firefox
							if(agent.indexOf("msie") == -1 && agent.indexOf("trident") == -1) {
								bFlag = false;
								$("#caution").css({"display":"block"});
								$("#caution").html("해당 브라우저는 CCTV 조회를 지원하지 않습니다.<br />CCTV는 VLC 플러그인 설치 후 <span style='color:red'>[익스플로러 브라우저]</span>에서 조회할 수 있습니다.");
							}
							
							//ActiveX 여부
							 ActiveXCheck("VLC ActiveX Plugin and IE Web Plugin v2","VideoLAN.VLCPlugin");
														
							
							//CCTV 객체
							//var cctvData = new 
							function cctvData(A,B,C,D,E,F) {
							    this.AREA_ID 	= A;
							    this.CCTV_SEQ 	= B;
							    this.CCTV_URL	= C;
							    this.CCTV_NM 	= D;
							    this.LONGITUDE 	= E;
							    this.LATITUDE 	= F; 
							};
							
							//CCTV 정보 조회
								params = {"G_AreaIdVal" : G_AreaIdVal};
								params = JSON.stringify(params);
								$.ajax({
									type: "get",
									url: "<c:url value='/dgms/selectMngCctvInfoJsonp.do' />?params="+params,
									async: false, //동기 방식
								    dataType: 'jsonp',
								    jsonpCallback: "myCallback",
									success: function(data,status){
										//Data Mapping
										for( var i=0; i<data["rtnList"].length; i++ ){ 
											var ob = data["rtnList"][i];
											var myData = new cctvData(ob.AREA_ID, ob.CCTV_SEQ, ob.CCTV_URL, ob.CCTV_NM, ob.LONGITUDE, ob.LATITUDE);
											cctvList.push(myData);
											
											if(i==0){
												//지도 중심 재정의
												mapOptions = {
														//지도 중심 위치-임의로 덕실마을 위치
													    center: new naver.maps.LatLng(ob.LATITUDE,ob.LONGITUDE),  
													    zoom: 10,												  
												        minZoom: 1, 											 
												        zoomControl: true 										  
												        /*
												        zoomControlOptions: { 									 
												            position: naver.maps.Position.TOP_RIGHT
												        }*/
													};
													
													map = new naver.maps.Map('map', mapOptions);
													
													bounds = map.getBounds(),
													    southWest = bounds.getSW(),
													    northEast = bounds.getNE(),
													    lngSpan = northEast.lng() - southWest.lng(),
													    latSpan = northEast.lat() - southWest.lat();
											}
											
											marker = new naver.maps.Marker({
											    position: new naver.maps.LatLng(ob.LATITUDE, ob.LONGITUDE),
											    map: map,
											    url: ob.CCTV_URL
											});
											markers.push(marker);

										    var infoWindow = new naver.maps.InfoWindow({
										        content: '<div style="width:150px;text-align:center;padding:10px;">'+ob.CCTV_NM+'</div>'
										    });
										    infoWindows.push(infoWindow);

										    naver.maps.Event.addListener(map, 'idle', function() {
										        updateMarkers(map, markers);
										    });
										}
									}, 
									fail: function(){},
									complete: function(data){
									}
								});  

								function updateMarkers(map, markers) {

								    var mapBounds = map.getBounds();
								    var marker, position;

								    for (var i = 0; i < markers.length; i++) {

								        marker = markers[i]
								        position = marker.getPosition();

								        if (mapBounds.hasLatLng(position)) {
								            showMarker(map, marker);
								        } else {
								            hideMarker(map, marker);
								        }
								    }
								}
								
								function showMarker(map, marker) {

								    if (marker.setMap()) return;
								    marker.setMap(map);
								}

								function hideMarker(map, marker) {

								    if (!marker.setMap()) return;
								    marker.setMap(null);
								}

								// 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환합니다.
								function getClickHandler(seq) {
								    return function(e) {
								        var marker = markers[seq],
								            infoWindow = infoWindows[seq],
								            cctvUrl = cctvList[seq].CCTV_URL;
 										
								        if(bFlag) cctvPlay(cctvUrl); 
						        		
								        if (infoWindow.getMap()) {
								            infoWindow.close();
								        } else {
								            infoWindow.open(map, marker);
								        }
								    }
								}

								for (var i=0, ii=markers.length; i<ii; i++) {
								    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
								}
								
								function cctvPlay(cctvUrl){
									timer=50;
							        clearInterval(cnt);
							        
					        		var vlc = document.getElementById('HVCS1');
					    			
									$("#player").css({"display":"none"});
									$("#msg").css({"display":"block"});	
									
									
					     			vlc.playlist.stop(); 
					        	    vlc.playlist.clear();
					        	    vlc.playlist.items.clear();
					        	    vlc.playlist.add(cctvUrl);
					        	    $("object[name='HVCS1'] param[name='Src']").attr("value", cctvUrl);
					        	    vlc.playlist.play(); 

					    			//document.HVCS1.ShowDisplay = "True";
					    			//document.HVCS1.AutoLoop = "no";
					    			//document.HVCS1.AutoPlay = "yes";
					    			//document.HVCS1.Src = cctvUrl;  
					        	    
					        	    cnt =setInterval(function(){
										var state = vlc.input.state;	 
										
										//alert(state);
										//alert(vlc.playlist.isPlaying);
										//상태 
										if(state == 7 || state == 6){					//에러
											$("#player").css({"display":"none"});
											$("#msg").css({"display":"block"});													
											$("#msg").text("에러가 발생했습니다.");
								   		 	vlc.playlist.stop();
									        timer=50;
									        clearInterval(cnt);  
									        
										}else if(state == 3 && vlc.playlist.isPlaying && vlc.input.hasVout){		
											$("#msg").css({"display":"none"});	
											$("#player").css({"display":"block"});									
											$("#msg").text("");
									        timer=50;
									        clearInterval(cnt);
									        
										}else{ 											//30초 대기 
											$("#msg").css({"display":"block"});	 
											
											//30초 경과 재생안됨
											if(timer == 0 && state != 3){ 										
												$("#msg").text("동영상을 재생할 수 없습니다.");
									   		 	vlc.playlist.stop();
										        timer=50;
										        clearInterval(cnt);   
											}else{ 						
												$("#msg").text("Loding... "+timer+"초");
											}
											timer--;
											
										} 
									}, 1000);
										 
								}

								//Active 설치
								 function ActiveXCheck(name, progid){
									var installed;
									var msg; 
								
									try{
										var axObj = new ActiveXObject(progid);
								
										if(axObj){
											installed = true;
										}else{
											installed = false;
										}
									}catch(e){
										installed = false;
									}
								
									if(installed) {
										msg = '설치됨';
									}else{
										$("#caution2").css({"display":"block"});
									}     
								}  
								
								
								 function downfile(path,filename){
							     	document.location.href=path;
							     	return false;
							     }
								 
								 

								$(document).ready(function () { 
									//cctvPlay("https://www.youtube.com/watch?v=kCdjvTTnzDU");
								});
								 
						</script>
						<style>
							.box{height:800px;} 
							#player{background-color:#000; z-index:300;}
							#msg{line-height:232px; text-align:center; color:#fff; background-color:#000; border:1px solid #000; z-index:200;}
							#msg, #player{display: none; position: fixed; top: 163px; right: 55px; width:300px; height:232px;}
							#caution, #caution2{display: none; position:absolute; width:400px; height:40px; font-size:10px; padding:7px;
									 			z-index:300; text-align:right; top:0px;}
							#caution{right:15px; background:yellow; line-height:15x; } 
							#caution2{left: 15px; height:40px; background-color:#ADFF2F;}
							#msg2{width:100%; height:15px; line-height:15px; text-align:right;}
							#msg2 a{color: red;}
						</style>
					</div>
				</div><!-- box -->
			</div><!-- col-xs-12 -->
		</div><!-- row -->
		</section>    
      </div>
<%@ include file="../inc/footer.jsp" %>