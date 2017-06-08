$(function(){
			
	var stageW;
	var stageH;
	var maxW = 1200;
	var maxH = 750;
	var isios=(/(iphone)/i).test(navigator.userAgent);//ios
	var isandroid=(/android/i).test(navigator.userAgent);//android

	/* visual_蹂��닔 */
	$autoRollingB = 'play';
	$num = 0;
	$inter_time = 5000;	
	$interval = '';
	/* work 蹂��닔 */
	$work_num = 0;
	$work_leg = $('.work_txt ul li').length;
	$work_txtW = 550;

	$(window).load(function(){
		$interval = setInterval(autoRolling,$inter_time);
		visual_Motion();
	});
	
	
	
	$(window).resize(function(){
		stageW = $(this).width();
		stageH = $(this).height();
		//maxW = $('.inner').width();
		//console.log(stageW + " : " + menuposX)
		
		//visual_setting
		if(isios || isandroid){
			$('.header').css({'width':'100%','height':maxH});					
			$('.header .bg').css({'width':$('.header').width(),'height':$('.header').height()});
			$('.header .bg').find('li.on').css({'width':'100%'});
			$('.header .arrow_wrap').css({'left':(maxW-$('.header .arrow_wrap').width())/2});
		}else{
			$('.header').css({'width':(stageW < maxW ? maxW : stageW),'height':(stageH < maxH ? maxH : stageH)});
			$('.header .bg').css({'width':$('.header').width(),'height':$('.header').height()});
			$('.header .bg').find('li.on').css({'width':'100%'});
			$('.header .arrow_wrap').css({'left':(maxW-$('.header .arrow_wrap').width())/2});
			if(stageW > 1600){
				$('.header .bg img').css({'width':$('.header').width(),'left':0});
			}else{
				$('.header .bg img').css({'width':1600,'left':-(1600-$('.header').width())/2});
			}
		}
		//work_setting
		$('.sec_2').css({'width':(stageW < maxW ? maxW : stageW)});					
		$('.sec_2 .bg').css({'width': $('.header').width()*$('.sec_2 .bg li').length, 'left': -($('.header').width()*$work_num)});
		$('.sec_2 .bg li').css({'width': $('.header').width()});

		
		
		if(stageW < maxW){
			$('.main').css({'overflow-x':'scroll'});
		}else{
			$('.main').css({'overflow-x':'hidden'});
		}

	}).resize();
	/* visual motion ------------------------------------------------------------------------  */
	
	$('.play_toggle').click(function(){
		if($autoRollingB == 'play'){
			$(this).addClass('stop');
			clearInterval($interval);					
			$autoRollingB = 'stop';
		}else{
			$(this).removeClass('stop');
			$interval = setInterval(autoRolling,$inter_time);
			$autoRollingB = 'play';
		}
	});

	$('.visual_nav').find('a').click(function(){
		if($num != ($(this).index() - 1)){
			$num = $(this).index() - 1 ;
			//console.log($num);
			visual_Motion();
		}
		return false;
	});
	
	$('.header .bg').find('li:not(.on)').css({'left':$('.header').width()});
	$('.txt_wrap').find('li:not(.on)').css({'opacity':0});

	function visual_Motion(){
		$('.visual_nav a').removeClass('on');
		$('.visual_nav a:eq('+$num+')').addClass('on');	
		/* bg */
		$('.header .bg').find('li').removeClass('on');
		$('.header .bg').find('li.bg'+$num).addClass('on');
		$('.header .bg').append($(".header .bg li.on"));
		/* title */
		$('.txt_wrap').find('li').removeClass('on');
		$('.txt_wrap').find('li:eq('+$num+')').addClass('on');

		/* IE8踰꾩쟾 �씠�븯�뒗 紐⑥뀡 �뾾�쓬 */
		if($.browser.msie && $.browser.version <= 8.0){
			$('.txt_wrap li').stop().css({'opacity':0});
			$('.txt_wrap li.on').stop().css({'opacity':1});
			$('.header .bg').find('li.on').css({'z-index':1,'left':0});
		}else{
			$('.txt_wrap li').stop().css({'opacity':0});
			$('.txt_wrap li.on').stop().animate({'opacity':1},2000);

			$('.header .bg').find('li.on').css({'left':$('.header').width()}).animate({'left':0},1000,'easeOutQuint');
			/*
			if($num == 0){
				TweenMax.to('.txt_wrap li.txt1 .img1', 0,{scale:0, onComplete:function(){
					TweenMax.to('.txt_wrap li.txt1 .img1', 1.5,{scale:1, delay:0.3, ease:Elastic.easeOut});
				}}); 
				TweenMax.to('.txt_wrap li.txt1 .img2', 0,{scale:0, onComplete:function(){
					TweenMax.to('.txt_wrap li.txt1 .img2', 1.5,{scale:1, delay:0.6, ease:Elastic.easeOut});
				}});
				TweenMax.to('.txt_wrap li.txt1 .img3', 0,{scale:0, onComplete:function(){
					TweenMax.to('.txt_wrap li.txt1 .img3', 1.5,{scale:1, delay:0.9, ease:Elastic.easeOut});
				}});
			}else if($num == 1){*/
				$('.txt_wrap li.txt5 .img1').css({'top':50,'left':150,'opacity':0}).stop().delay(700).animate({'top':0,'left':103,'opacity':1},1500,'easeInOutExpo');				
			//}
		}	
		
		clearInterval($interval);
		if($autoRollingB == 'play'){
			$interval = setInterval(autoRolling,$inter_time);
		}
	}

	function autoRolling(){
		$num ++;
		if($num == $('.header .bg li').length){
			$num = 0;
		}
		visual_Motion();
	}
	
	/* visual motion ------------------------------------------------------------------------ */

	/* work motion ------------------------------------------------------------------------  */			
	//console.log($work_leg);
	$('.work_txt ul').css({'width':$work_txtW*$work_leg});
	$('.btn_next').click(function(){
		$work_num++;
		work_Handler();
		return false;
	});
	$('.btn_prev').click(function(){
		$work_num--;
		work_Handler();
		return false;
	});

	function work_Handler(){
		if($work_num >= ($work_leg - 1)){
			$work_num = $work_leg - 1;
			$('.btn_next').fadeOut();
			$('.btn_prev').fadeIn();
		}else if($work_num <= 0){
			$work_num = 0;
			$('.btn_prev').fadeOut();
			$('.btn_next').fadeIn();
		}else{
			$('.btn_prev').fadeIn();
			$('.btn_next').fadeIn();
		}
		$('.sec_2 .bg').animate({'left':-($('.header').width()*$work_num)},1500,'easeInOutQuint');
		$('.work_txt ul').animate({'left':-($work_txtW*$work_num)},1500,'easeInOutQuint');
	}

	
	/* work motion ------------------------------------------------------------------------ */
	
	/* browser scroll ------------------------------------------------------------------------ */
	/*
	$('.direct').click(function(){
		skip_contents('#skip_content');
	});
	
	console.log($.browser.msie +' && '+$.browser.version + '> 8.0');
	if( navigator.appName.indexOf("Microsoft") > -1 ){// IE?   
		if( navigator.appVersion.indexOf("MSIE 0") > -1) // IE7?
		{}else{
			wheel_handler()
		}
	}else{
		wheel_handler()
	}
	function wheel_handler(){
		$(".header").mousewheel(function(e) {
			
			if (e.deltaY == -1) {
				skip_contents('#skip_content');
			}
		});
		$(".sec_1").mousewheel(function(e) {
			//console.log(e.deltaY);
			if(e.deltaY == 1){
				skip_contents('.header');
			}
		});
	}
	
	var visual_ck = false;
	function skip_contents(sec){				
		$(sec).animatescroll({scrollSpeed:1000,easing:'easeInOutQuint'});
		console.log(visual_ck + ' : ' + $autoRollingB);
		if(sec == '#skip_content'){			
			if($autoRollingB == 'play'){
				visual_ck = true;
				$('.play_toggle').click();
			}
		}else{
			if(visual_ck){
				$('.play_toggle').click();
				visual_ck = false;
			}
		}
	}
	*/
	/* browser scroll ------------------------------------------------------------------------ */

	/* mobile -----------------------------------*/			
	 var ua = window.navigator.userAgent.toLowerCase();
	 if ( /iphone/.test(ua) || /ipad/.test(ua) || /android/.test(ua) || /opera/.test(ua) || /bada/.test(ua) ) {
	//alert('紐⑤컮�씪湲곌린'); 				
		$(".header").swipe( {
			swipeUp:function(event, direction, distance, duration, fingerCount) {
				skip_contents('#skip_content');
			},
			swipeLeft:function(event, direction, distance, duration, fingerCount) {
				$num ++;
				if($num == $('.header .bg li').length){
					$num = 0;
				}
				visual_Motion();
			},
			swipeRight:function(event, direction, distance, duration, fingerCount) {
				
				$num --;
				if($num < 0){
					$num = $('.header .bg li').length - 1;
				}
				visual_Motion();
			},threshold:0
		});
		$(".sec_1").swipe( {
			swipeDown:function(event, direction, distance, duration, fingerCount) {
				skip_contents('.header');
			},threshold:0
		});
		$(".sec_2").swipe( {					
			swipeLeft:function(event, direction, distance, duration, fingerCount) {
				$work_num++;
				work_Handler(); 
			},
			swipeRight:function(event, direction, distance, duration, fingerCount) {
				$work_num--;
					work_Handler();
			},threshold:0
		});
	 }
	 /* mobile -----------------------------------*/

	 /* contact */
	 
	$('.contact_us .open_btn').click(function(){
		if(con_toggle){
			$('.contact_form').slideUp();
			con_toggle = false;
		}else{
			contact_open();
		}
		return false;
	});

	 /*�뙆�씪李얘린 踰꾪듉 �뵒�옄�씤 change*/
	/*
	$("input[type=file]").filestyle({
        image:"/v2014/images/main/btn_search_file.gif",
        imageheight:22,
        imagewidth:64,
        width:245
    });
    */ 

});
var con_toggle = false;
function contact_open(){	
	con_toggle = true;
	$('.contact_form').slideDown();
	$('.contact_us').animatescroll({scrollSpeed:1000,easing:'easeInOutQuint'});
}

	

