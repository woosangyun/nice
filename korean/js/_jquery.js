// JavaScript Document

$(function(){
	
		
	/////////////////////     gnb     /////////////////////
	
	
	$("#gnb").load("../include/gnb.html");								
	
	
	//////////////////////////      웹 GNB 인터랙션      ////////////////////////////
		
	$(document).on("mouseover focus","#gnb .menu>li>a",function(){			
		if($(window).width() > 960){
			var menuActive = $(this).parent().index();
			$("#gnb .menu>li").removeClass("on");
			$(this).parent().addClass("on");
			$(".menuWrap").css("display","none");
			$(".menuWrap").eq(menuActive).css("display","block");
		}
	});
	$(document).on("mouseleave","#gnb",function(){	
		if($(window).width() > 960){
			$(".menuWrap").css("display","none");
			$("#gnb .menu>li").removeClass("on");
		}		
	});
	
	$(document).on("focus",".util li a",function(){	
		if($(window).width() > 960){
			$(".menuWrap").css("display","none");
			$("#gnb .menu>li").removeClass("on");
		}		
	});
		
			
	////////////////////////////       모바일 GNB 인터랙션     //////////////////////////////
		
	var mobileMenuActive = false;
	
	$(document).on("click",".mobileMenu",function(){				
		if(mobileMenuActive==false)
		{
			$(".gnbWrapper").animate({"left":0},500,"easeInOutExpo");
			$(this).css("background-position","left bottom");
			mobileMenuActive=true;
			return false;
		}else{
			$(".gnbWrapper").animate({"left":-270},500,"easeInOutExpo");
			$(this).css("background-position","left top");
			mobileMenuActive=false;
			return false;
		}			
	});
	
	$(document).on("click","#gnb .menu>li>a",function(){				
		if($(window).width() < 960)
		{				
			var self = this;				
			//현재 선택된 메뉴의 하위메뉴 의 열림,닫힘 상태를 변수에 담는다.
			var openLength = $(this).closest("ul").find("li div[style*='block']").length;
			var open = $(this).closest("ul").find("li div[style*='block']");
			var displayCondition = $(this).next().css("display");								
			//alert(open)
				
			//클릭한 버튼에 하위 메뉴가 있고 slide 이벤트가 완료가 되었다면 (더블 클릭 방지)
			if($(this).next().is("div") == true){
				if( openLength > 0 && displayCondition=="none"){  ////////////////  열린 메뉴 말고 다른 메뉴를 눌렀을때
					//alert("1")
					open.slideUp(500,'easeInOutExpo',function(){
						$("#gnb .menu>li>a[class^='on']").removeClass("on");
						$(self).addClass("on");	
						$(self).parents("ul").siblings("a").addClass("on");
						$(self).next().slideDown(500,'easeInOutExpo');					
					});
					return false;					
				}else if( openLength > 0 && displayCondition=="block"){  ///////////// 열린 메뉴를 눌렀을때
					open.slideUp(500,'easeInOutExpo',function(){
						open.prev().removeClass("on");
					});
					return false; 		
				}else if( openLength == 0 && displayCondition=="none" ){  ////////////    열린 메뉴가 없을때 
					//alert("3")
					$("#gnb .menu>li>a[class^='on']").removeClass("on");
					$(self).addClass("on");	
					$(self).parents("div").siblings("a").addClass("on");
					$(self).next().slideDown(500,'easeInOutExpo');
					return false;	
				}			
			}else{		
				open.slideUp(500,'easeInOutExpo');
				$("#gnb .menu>li>a[class^='on']").removeClass("on");
				$(self).addClass("on");	
				$(self).parents("ul").siblings("a").addClass("on");	
			}
			return false;
		}
	}); //메뉴 버튼 클릭 이벤트 END	
	
	/////////////////////     footer     /////////////////////
	
	
	$("#footer").load("../include/footer.html");
	
	/////////////////////     select     /////////////////////
	
	//var selectTarget = $('select');
	  $(document).on("focus","select",function(){		
		$(this).parent().addClass('focus');
	  });
		
	  $(document).on("blur","select",function(){
		$(this).parent().removeClass('focus');
	  });
	
	 $(document).on("change","select",function(){
		var select_name = $(this).children('option:selected').text();
		$(this).siblings('label').text(select_name);
		$(this).parent().removeClass('focus');
	  });
	  
	
});
