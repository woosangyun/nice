// JavaScript Document

$(function(){
	
	/////////////////////     lnb     /////////////////////
		
	
	$.get("../include/lnb.asp",lnbLoad);
	
	function lnbLoad(data){
			
		$(data).find(".first").appendTo("#lnb");
		$("#lnb .first .depth").text($("#lnb .first li").eq(m0).find("a").text());
		$("#lnb .first li").eq(m0).find("a").addClass('on');
		
		$(data).find(".second").eq(m0).appendTo("#lnb");
		$("#lnb .second .depth").text($("#lnb .second li").eq(m1).find("a").text());
		$("#lnb .second li").eq(m1).find("a").addClass('on');
		
		$(data).find(".third").eq(s).appendTo("#lnb");
		$("#lnb .third .depth").text($("#lnb .third li").eq(m2).find("a").text());
		$("#lnb .third li").eq(m2).find("a").addClass('on');
	}
	
	
	$(document).on("mouseover focus","#lnb .first",function(){	
	
		$("#lnb .first ul").css("display","block");
		$("#lnb .second ul").css("display","none");
		$("#lnb .third ul").css("display","none");
	
	});
	
	$(document).on("mouseover focus","#lnb .second",function(){	
	
		$("#lnb .first ul").css("display","none");
		$("#lnb .second ul").css("display","block");
		$("#lnb .third ul").css("display","none");
	
	});
	
	$(document).on("blur","#lnb .second ul li:last-child a",function(){	
	
		$("#lnb .second ul").css("display","none");
	
	});
	
	$(document).on("mouseover focus","#lnb .third",function(){	
	
		$("#lnb .first ul").css("display","none");
		$("#lnb .second ul").css("display","none");
		$("#lnb .third ul").css("display","block");
	
	});
	
	$(document).on("blur","#lnb .third ul li:last-child a",function(){	
	
		$("#lnb .third ul").css("display","none");
	
	});
	
	$(document).on("mouseleave","#lnb .first,#lnb .second,#lnb .third",function(){	
	
		$("#lnb .first ul").css("display","none");
		$("#lnb .second ul").css("display","none");
		$("#lnb .third ul").css("display","none");
	
	});
	  
	
	
	/////////////////////     INPUT     /////////////////////
	
	var placeholderTarget = $('.textbox input[type="text"], .textbox input[type="password"]');
  
	//포커스시
	placeholderTarget.on('focus', function(){
		$(this).siblings('label').fadeOut('fast');
	});
	
	//포커스아웃시
	placeholderTarget.on('focusout', function(){
		if($(this).val() == ''){
		  $(this).siblings('label').fadeIn('fast');
		}
	});
	
	
	/////////////////////     faq     /////////////////////
	
	
	
	
	$(document).on("click",".faq .q",function(){
	
		if($(this).hasClass('on')){
			
			$(this).removeClass('on');
			$(this).next().slideUp(500,'easeInOutExpo')
			
		}else{
			
			$(this).addClass('on');
			$(this).next().slideDown(500,'easeInOutExpo')	
			
		}
		
	
	});
	
	
	/////////////////////     popup     /////////////////////
	
	/* 2016.03.16 - 윈도우팝업으로 페이지내 처리 ***
	
	$(".btnWrap .btn1").click(function(){
		
		$("#popupWrap").css("display","block");
		return false;
		
	});
	
	
	
	$("#popupWrap .popClose").click(function(){
		
		$("#popupWrap").css("display","none");
		return false;
		
	});
	*/
	
	
	
	/////////////////////     모바일 테이블     /////////////////////
	
	
	setCss();
	
	function setCss(){
	
		uacheck = checkUA();
		browser_w  = $(window).width();
		
		if(uacheck=="ie") {
			$("body").removeClass("mobile");
		} else if(uacheck=="mobile") {
			if (browser_w<960) {
				$("body").addClass("mobile");
			} else {
				$("body").removeClass("mobile");//
				//$("body").addClass("body_960");
			}
		} else {
			if (browser_w<=940) {
			//$("body").removeClass();
				$("body").addClass("mobile");
			} else if (browser_w<=1180) {
			$	("body").removeClass("mobile");//
				//$("body").addClass("body_960");
			} else {
				$("body").removeClass("mobile body_960");
			}
		}
	}
	
	function checkUA() {
		var ua = window.navigator.userAgent.toLowerCase(); 
		if ( /ipad/.test(ua) || /iphone/.test(ua) || /android/.test(ua) || /opera/.test(ua) || /bada/.test(ua) ) {
			return "mobile";
		} else {
			var ie = ua.indexOf("msie");
			if( ie > 0 ) {
			ieversion = parseInt(ua.substring(ie+5, ua.indexOf(".", ie))); 
			  	if( ieversion<=8 ){
					return "ie";
				} else return "general";
			} else return "general";
		}
	}
	
	
	$("body.mobile .table_inner.scroll").append("<div class=\"msg_touch_help mobile_only\"><img src=\"../images/common/bg_touch_help.png\" alt=\"touch slide\"></div>");
	$("body.mobile .table_inner.scroll").each(function() {
		$(this).scroll(function(){
			$(this).find(".msg_touch_help").fadeOut();
		})
	});
	
	$(window).resize(function(){
		
		setCss();
		
	});
	
	
	
	/////////////////////     google     /////////////////////
	
	google.maps.event.addDomListener(window, 'load', initialize);
	 
	function initialize(){
		if($("#google_map").length) {
	 
		var mapOptions = { //구글 맵 옵션 설정
			zoom : 18, //기본 확대율
			center : new google.maps.LatLng(37.528282, 126.920719), // 지도 중앙 위치
			scrollwheel : false, //마우스 휠로 확대 축소 사용 여부
			mapTypeControl : false //맵 타입 컨트롤 사용 여부
		};
	 
		var map = new google.maps.Map(document.getElementById('google_map'), mapOptions); //구글 맵을 사용할 타겟
		
		//var image = 'http://cheolguso.com/img/iconimg.png'; //마커 이미지 설정
	 
		var marker = new google.maps.Marker({ //마커 설정
			map : map,
			position : map.getCenter(), //마커 위치
			title : "나이스 정보통신"
			//icon : image //마커 이미지
		});
		google.maps.event.addDomListener(window, "resize", function() { //리사이즈에 따른 마커 위치
			var center = map.getCenter();
			google.maps.event.trigger(map, "resize");
			map.setCenter(center); 
		});
	 
		}//if-end
	}//function-end
	
	
});
