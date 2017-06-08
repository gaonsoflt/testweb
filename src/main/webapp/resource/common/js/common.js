$(function(){
	/* 怨듯넻 -------------------- */
	$totlaMenu_bol = false;
	
	/* �쟾泥대낫湲� �븘�씠肄� �쐞移� */
	$(window).resize(function(){
		var stageW = $(this).width();
		var stageH = $(this).height();
		var maxW = 1200;
		var menuR = stageW > maxW ? (stageW-maxW)/2 : 0
		//console.log(menuR + " : " + $totlaMenu_bol)
		if($totlaMenu_bol){
			$('.total_menu').animate({'right':436});
		}else{
			$('.total_menu').css({'right':menuR});
		}
	}).resize();
	$('.contentBG').css({'opacity':0.5});
	$('.total_menu').click(function(){	
		if($totlaMenu_bol){
			$(this).find('img').attr('src','images/common/icon_total_menu.png');
			$('.side_area').animate({'right':'-398px'});
			$('.contentBG').fadeOut();
			$('.side_GNB .menu > li').find('.sub_menu').slideUp();
			$('body').css({'overflow-y':'auto'});
			$totlaMenu_bol = false;
		}else{			
			$(this).find('img').attr('src','images/common/icon_total_menu_x.png');
			$('.side_area').animate({'right':'0'});
			$('.contentBG').fadeIn();
			$('body').css({'overflow-y':'hidden'});
			contentBG_resize();
			$totlaMenu_bol = true;					
		}

		$(window).resize();
		return false;
	});
	/* gnb */
	/*
	$('.side_GNB .menu > li').find('a').click(function(){
		//$('.side_GNB .menu > li').removeClass('on');
		//$(this).parent().addClass('on');
		$('.side_GNB .menu > li').find('.sub_menu').slideUp();
		$(this).parent().find('.sub_menu').slideDown();
		return false;
	});
	$('.side_GNB .menu').mouseleave(function(){
		//$('.side_GNB .menu > li').removeClass('on');
		$('.side_GNB .menu > li:not(.on)').find('.sub_menu').slideUp();
		$('.side_GNB .menu > li.on').find('.sub_menu').slideDown();

	});
	*/
	/* 怨듯넻------------------- */

	/* eluocian - 由ъ뒪�듃 �렯移�/�뿴由� 紐⑥뀡 */
	$(document).on('click','.eluocian .subject > a',function(){
		$list = $(this).parent().parent();		
		$('.history li').removeClass('on');				
		$list.addClass('on');
		$list.find('.detail').slideDown();
		//$list.find('.detail').animate({'height':$list.find('.detail').height()});
		$('.history li:not(.on)').find('.detail').hide();
		$('.history li.on').find('.detail').slideDown();
		$('.history li.on').animatescroll({scrollSpeed:1500,easing:'easeInOutQuint'});
		return false;
	});

	$(document).on('click','.eluocian .detail a.close',function(){
		$list = $(this).parent().parent().parent().parent();
		$list.removeClass('on');
		$list.find('.detail').slideUp();
		//$list.animatescroll({scrollSpeed:1500,easing:'easeInOutQuint'});
		return false;
	});
	/* eluocian - �뀈�룄 slide */
	$yearH = 34;
	$year_start= 0;
	$(window).load(function(){
		var last_year = $('#lastValue').val();
		var year = $('#searchValue').val();
		//console.log(last_year+" :: "+year);
		if($('.his_year ul li').length > 4){
			if(year){
				$year_start = (last_year - year);
				if($('.his_year ul li').length-4 < $year_start){
					$year_start = $('.his_year ul li').length-4;
				}
				year_move();
			};
		}

	});

	$('.eluocian .next_year').click(function(){
		if(0 < $year_start){
			$year_start--;
			year_move();
		}
	});
	$('.eluocian .prev_year').click(function(){
		if($('.his_year ul li').length-4 > $year_start){
			$year_start++;
			year_move();
		}
	});
	function year_move(){
		$('.his_year ul').animate({'top':-($yearH * $year_start)});
	}

	/* think - hover */
	
	$('.think .container ul li').find('.bg').css({'opacity':0});
	$('.think ul.list li').on({
		mouseover: function() {
		$(this).addClass('on');
		$(this).find('.bg').stop().animate({'opacity':1});
		},
		mouseout: function() {
		$(this).removeClass('on');
		$(this).find('.bg').stop().animate({'opacity':0});
		}
		
	});
	$('.think .btn_more').click(function(){
		$('.think .container ul li').find('.bg').css({'opacity':0});
	});
	/* think_view - comment */
	$('.think_view .btn_incom').click(function() {
		$(this).toggleClass('active');
		$(this).next().slideToggle('200');
	});

	/* about-careers (吏��썝遺꾩빞 combo_box)*/
	$('.combo_box').mouseenter(function(){
		$(this).find('ul').stop().slideDown();
	});

	$('.combo_box').mouseleave(function(){
		$(this).find('ul').stop().slideUp();
	});

	$('.combo_box ul li').find('a').click(function(){
		$str = $(this).text();
		$('.combo_box').find(':input').val($str);
		return false;
	});

	 /*�뙆�씪李얘린 踰꾪듉 �뵒�옄�씤 change*/
	/*
	 $(".file_add input[type=file]").filestyle({
        image:"/v2014/images/common/btn_srh_file.png",
        imageheight:30,
        imagewidth:76,
        width:304
    });
	 */
	
	$(".goch.yht").click(function(){
		areaId = "6368700000";
		console.log("onNext areaId: " + areaId);
        window.location.replace("/dgms/main.do?areaId=" + areaId);
	});
	
	$(".goch.dst").click(function(){
		areaId = "6368600000";
		console.log("onNext areaId: " + areaId);
        window.location.replace("/dgms/main.do?areaId=" + areaId);
	});
	
});


//openPop
function openPopup(winNM, nm, width, height){
	var sw	= screen.availWidth;                          
	var sh	= screen.availHeight;                        
	var px	= (sw-width)/2;
	var py	= (sh-height)/2;
	var set	= 'top=' + py
			+ ',left=' + px
			+ ',width=' + width
			+ ',height=' + height
			+ ',toobar=0,resizable=0,status=0,scrollbars=1';

	var w = window.open(winNM, nm, set);
	w.focus();

	return false;
}

function contentBG_resize(){
	var cBG = $('.header').height()+$('.container').height();
	if(cBG < $(window).height()){
		$('.contentBG').css({'height':$(window).height()});
	}else{
		$('.contentBG').css({'height':cBG});
	}
}

$(window).load(function(){
	contentBG_resize();
});
