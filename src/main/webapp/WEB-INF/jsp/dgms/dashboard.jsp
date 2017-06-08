<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<style>
.fc-content{display:inline-block !important;padding-left:2px;line-height:1.1em;}
.fc-content span{display:inline-block !important;line-height:1em;}
.fc-title{position:absolute;top:5px;}
.fc-title{position:absolute;top:5px;}
.box-primary{margin:10px !important;}
</style>
<script>
$(document).ready(function(){
	$('#dashboard').parent().parent().addClass('active');
	$('#dashboard').addClass('active');
});	
</script>
      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            대쉬보드
            <small>사용자별 모든 측정결과를 보여줍니다.</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 측정결과</a></li>
            <li class="active">대쉬보드</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
          <div class="row">
          	<!-- 내용 -->
          	<div class="col-xs-12">
            <form id="form1" name="form1"></form>
              <!-- table 하나 -->
              <div class="box">
<!--                 <div class="box-header">
                  <h3 class="box-title"><i class="fa fa-tag"></i>대쉬보드</h3>
                </div>/.box-header -->
                <!-- <div class="box-body"> -->

					<div class="col-md-9">
						<div class="box box-primary">
							<div class="box-body">
								<!-- THE CALENDAR -->
								<div id="calendar"></div>
							</div><!-- /.box-body -->
						</div><!-- /. box -->
					</div><!-- /.col -->
					        
		       <!--  </div> -->
		      </div><!-- box -->
					    

    <!-- fullCalendar 3.0.1-->
<%-- 	<script src="<c:url value='/resource/fullCalendar/3.0.1/lib/moment.min.js'/>"></script>
	<script src="<c:url value='/resource/fullCalendar/3.0.1/lib/jquery.min.js'/>"></script>
	<script src="<c:url value='/resource/fullCalendar/3.0.1/fullcalendar.min.js'/>"></script> --%>
	
    <!-- jQuery UI 1.11.1 -->
    <script src="https://code.jquery.com/ui/1.11.1/jquery-ui.min.js" type="text/javascript"></script>
    <!-- Slimscroll -->
    <script src="<c:url value='/resource/plugins/slimScroll/jquery.slimscroll.min.js'/>" type="text/javascript"></script>
    <!-- FastClick -->
    <%-- <script src="<c:url value='/resource/plugins/fastclick/fastclick.min.js'/>"></script> --%>
    <!-- AdminLTE for demo purposes -->
    <%-- <script src="<c:url value='/resource/dist/js/demo.js'/>" type="text/javascript"></script> --%>
    <!-- fullCalendar 2.2.5 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.7.0/moment.min.js" type="text/javascript"></script>
    <script src="<c:url value='/resource/plugins/fullcalendar/fullcalendar.min.js'/>" type="text/javascript"></script>
    
<script>
var firdate;
var month;
var nmonth;
	$(document).ready(function() {
		
		var date = new Date();
        var d = date.getDate(),
        m = date.getMonth()+1,
        nm = date.getMonth()+2,
        y = date.getFullYear();
        
        var m1 = ("0"+m).slice(-2);
        var m2 = ("0"+nm).slice(-2);
        firdate = y+"-"+m1;
        viewcalendar(y+"-"+m1,y+"-"+m2);
        	
 /*        $('#calendar').fullCalendar({
            resourceColumns: [
                {
                    labelText: 'First Name',
                    field: 'fname'
                },
                {
                    labelText: 'Last Name',
                    field: 'lname'
                }
            ]
            resources: [
                {
                    id: 'a',
                    fname: 'John',
                    lname: 'Smith'
                },
                {
                    id: 'b',
                    fname: 'Jerry',
                    lname: 'Garcia'
                }
            ]
        }); */

        
	});

	function viewcalendar(month,nmonth)
	{
		$.ajax({
			type: "get",
			url: "<c:url value='/dgms/selectMeasureScheduleInfo.do?user_id=${userStore.username}&month="+month+"&nmonth="+nmonth+"'/>",//<c:url value='/appinf/selectMeasureScheduleInfo.do'/>
			async: false, //동기 방식
			success: function(data,status){
				setTimeout(function (){
					
	   	    		var calData_ = [];

	   	    		for( var i = 0; i < data["rtnList"].length; i++ ) {
	   	    			var strtr = "";
	   	    			var color="";
	   	    			var className="";
	   	    			var url="";
	   	    			var dsc="";
	   	    			if (data["rtnList"][ i ]["GUBUN"] =="0")
	   	    			{
	   	    				className="fa fa-tint";
	   	    				url="<c:url value='/dgms/dataBld.do?mdate="+data["rtnList"][ i ]["SACTION_DATE"]+"'/>"
	   	    				if (data["rtnList"][ i ]["STATE"]==0)
	   	    				{
	   	    					dsc="정상혈압";
	   	    				}
	   	    				else
	   	    				{
	   	    					dsc="이상혈압";
	   	    				}
	   	    						
	   	    			}
	   	    			else if(data["rtnList"][ i ]["GUBUN"] =="1")
	   	    			{
	   	    				className="fa fa-heart-o";
	   	    				url="<c:url value='/dgms/dataEcg.do?mdate="+data["rtnList"][ i ]["SACTION_DATE"]+"'/>"
	   	    				if (data["rtnList"][ i ]["STATE"]==0)
	   	    				{
	   	    					dsc="정상심박";
	   	    				}
	   	    				else
	   	    				{
	   	    					dsc="이상심박";
	   	    				}
	   	    			}
	   	    			else if(data["rtnList"][ i ]["GUBUN"] =="2")
	   	    			{
	   	    				className="fa fa-medkit";
	   	    				url="<c:url value='/dgms/dataMedc.do?mdate="+data["rtnList"][ i ]["SACTION_DATE"]+"'/>"
	   	    				if (data["rtnList"][ i ]["STATE"]==0)
	   	    				{
	   	    					dsc="정상복용";
	   	    				}
	   	    				else
	   	    				{
	   	    					dsc="오복용";
	   	    				}
	   	    			}
	   	    			else if(data["rtnList"][ i ]["GUBUN"] =="3")
	   	    			{
	   	    				className="fa fa-heart-o";
	   	    				url="<c:url value='/dgms/dataActEcg.do?mdate="+data["rtnList"][ i ]["SACTION_DATE"]+"'/>"
	   	    				if (data["rtnList"][ i ]["STATE"]==0)
	   	    				{
	   	    					dsc="정상심박";
	   	    				}
	   	    				else
	   	    				{
	   	    					dsc="이상심박";
	   	    				}
	   	    			}
	   	    			
	   	    			if (data["rtnList"][ i ]["STATE"] =="1")
	   	    			{
	   	    				color="#ff0000";
	   	    			}

		  	    		calData_.push( {
		  	    		  "id": data["rtnList"][ i ]["SEQ"],
		  	    		  "title": dsc,
		  	    		  "start": data["rtnList"][ i ]["SACTION_DATE"],
		  	    		  "url": url,
		  	    		  "color":color,
		  	    		  "className":  className,
		  	    		})     	    
	   	    		};	 

	   	    		//if (firdate!=month)
		  	        //{
	   	    			$('#calendar').fullCalendar('removeEvents');
	   	    			$('#calendar').fullCalendar( 'addEventSource', calData_ );
		  	        //}
	   	    		
	   	    		$('#calendar').fullCalendar({
		  	  			//locale: 'ko',
		  	  			//height: 700,
		  	  			contentHeight: 700,
		  	  			header: {
		  	  			    left:   '',//'month,agendaWeek,agendaDay'
		  	  			    center: 'title',
		  	  			    right:  'today prev,next'
		  	  			},
		  	  			titleFormat: {month: "YYYY년 MM월", week: " YYYY년 MM월 D일", day: "YYYY년 MM월 D일"},
		  	  			buttonText: { today : "오늘",month : "월별",week : "주별",day : "일별"},
		  	  			dayNamesShort: ["일","월","화","수","목","금","토"],
		  	  			dayNames: ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"],
		  	  			monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		  	  			monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		  	  			editable: true,
		  	  			eventLimit: false, // allow "more" link when too many events
		  	  			eventMouseover: function(event, jsEvent, view) {
		  	  				  var tooltip = '<div class="tooltipevent" style="font-size: 17px; font-weight: bold;width:200px;height:100px;position:absolute; z-index:100000; color:#111; border:1px solid #f3c534;background-color:#fefeb8;  ">' 
		  	  				       + event.title + '</div>';
		  	  				    $("body").append(tooltip);
		  	  				    $(this).mouseover(function(e) {
		  	  				        $(this).css('z-index', 10000);
		  	  				        $('.tooltipevent').fadeIn('500');
		  	  				        $('.tooltipevent').fadeTo('10', 1.9);
		  	  				    }).mousemove(function(e) {
		  	  				        $('.tooltipevent').css('top', e.pageY + 10);
		  	  				        $('.tooltipevent').css('left', e.pageX + 20);
		  	  				    });

		  	  				
		  	  				
		  	  			    //$('.fc-highlight', this).append('<div id=\"'+event.id+'\" class=\"hover-end\">'+moment(event.end).format('YYYY-MM-DD HH:mm')+'</div>');
		  	  			},
		  	  			eventMouseout: function(event, jsEvent, view) {
		  	  				  $(this).css('z-index', 8);
		  	  				     $('.tooltipevent').remove();

		  	  			},
			  	  		viewRender: function(view, element){
			  	          var currentdate = view.intervalStart;
			  	          //$('#datepicker').datepicker().datepicker('setDate', new Date(currentdate));
				  	        var date = new Date(currentdate);
				  	        var d = date.getDate(),
				  	        m = date.getMonth()+1,
				  	      	nm = date.getMonth()+2,
				  	        y = date.getFullYear();
				  	        
					  	    var m1 = ("0"+m).slice(-2);
					        var m2 = ("0"+nm).slice(-2);
					        						          
				  	        
			  	        	viewcalendar(y+"-"+m1,y+"-"+m2);
				  	        
			  	      },

		  	  /* 			dayClick: function(date, jsEvent, view) {//날짜클릭
		  	  		        alert('Clicked on: ' + date.format());
		  	  		        alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
		  	  		        alert('Current view: ' + view.name);
		  	  		        // change the day's background color just for fun
		  	  		        $(this).css('background-color', 'red');

		  	  		    }, */
		  	  /* 		    eventClick: function(calEvent, jsEvent, view) {
		  	  		        alert('Event: ' + calEvent.title);
		  	  		        alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
		  	  		        alert('View: ' + view.name);//month,week 등
		  	  		        // change the border color just for fun
		  	  		        $(this).css('border-color', 'red');

		  	  		    }, */
		  	  /* 			events: {
		  	  				url: 'php/get-events.php',
		  	  				error: function() {
		  	  					$('#script-warning').show();
		  	  				}
		  	  			},
		  	  			loading: function(bool) {
		  	  				$('#loading').toggle(bool);
		  	  			}, */
		  	  			events: calData_
		  	  				/* [
		  	  				{
		  	  					title: '혈압이상:151',
		  	  					start: '2016-10-01',
		  	  					color: '#ff0000',
		  	  					url: '<c:url value='/dgms/dataBld.do'/>',
		  	  					className:'fa fa-tint'
		  	  				},
		  	  				{
		  	  					title: '정상혈압:100',
		  	  					start: '2016-10-01',
		  	  					className:'fa fa-tint'
		  	  				},
		  	  				{
		  	  					title: '미복용',
		  	  					start: '2016-10-11',
		  	  					color: '#ff0000',
		  	  					url: '<c:url value='/dgms/dataMedc.do'/>',
		  	  					className:'fa fa-medkit'
		  	  				},
		  	  				{
		  	  					title: '복용완료',
		  	  					start: '2016-10-12',
		  	  					url: '<c:url value='/dgms/dataMedc.do'/>',
		  	  					className:'fa fa-medkit'
		  	  				},
		  	  				{
		  	  					title: '복용완료',
		  	  					start: '2016-10-12',
		  	  					url: '<c:url value='/dgms/dataMedc.do'/>',
		  	  					className:'fa fa-medkit'
		  	  				},
		  	  				{
		  	  					title: '복용완료',
		  	  					start: '2016-10-12',
		  	  					url: '<c:url value='/dgms/dataMedc.do'/>',
		  	  					className:'fa fa-medkit'
		  	  				},
		  	  				{
		  	  					title: '복용완료',
		  	  					start: '2016-10-12',
		  	  					url: '<c:url value='/dgms/dataMedc.do'/>',
		  	  					className:'fa fa-medkit'
		  	  				},
		  	  				{
		  	  					id: 999,
		  	  					title: '심박수정상',
		  	  					start: '2016-10-09T16:00:00',
		  	  					className:'fa fa-heart-o'
		  	  					 
		  	  				},
		  	  				{
		  	  					id: 999,
		  	  					title: '심박수이상',
		  	  					color: '#ff0000',
		  	  					start: '2016-10-16',
		  	  					url: '<c:url value='/dgms/dataEcg.do'/>',
		  	  					className:'fa fa-heart-o'
		  	  				}
		  	  			] */
		  	  		}); 
		        	}, 100);
			},
			fail: function(){},
			complete: function(data){
				
			}
		});        
	}
	
</script>
					    
					    
					    
            </div><!-- col-xs-12 -->
          </div><!-- row -->
        </section>    
        
      </div>
        
        
<%@ include file="../inc/footer.jsp" %>