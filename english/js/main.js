// JavaScript Document

$(function(){
	
	
	////////////////////////     비주얼      //////////////////////////
	
	var visualNum = 0;
	$("#visual .imageWrap div").css("opacity",0);
	$("#visual .imageWrap div").eq(visualNum).css("opacity",1);
	
	
	var vNum = $("#visual .imageWrap div").length;
	var vAct = 0;
	
	
	$("#visual .ui .left").click(function(){		
		if(vAct > 0 ){			
			vAct--;
			visualActive();	
		}else{			
			vAct = vNum-1;
			visualActive();	
		}
		return false;		
	});
	
	$("#visual .ui .right").click(function(){		
		if(vAct < vNum-1 ){			
			vAct++;
			visualActive();	
		}else{			
			vAct = 0;
			visualActive();	
		}
		return false;		
	});
	
	$("#visual .indi li").click(function(){		
		vAct = $(this).index();
			visualActive();			
	});
	
	function visualActive(){		
		for(var i=0; i<vNum; i++){			
			$("#visual .imageWrap div").eq(i).stop().animate({"opacity":0},1000);			
		}
		$("#visual .imageWrap div").eq(vAct).stop().animate({"opacity":1},1000);
		$("#visual .indi li").removeClass("on");
		$("#visual .indi li").eq(vAct).addClass("on");
	}
	
	
	////////////////////////////    Quick     //////////////////////////
	
	
	var quickActive=false;
	$("#quick .btn").click(function(){
		
		if(quickActive == false){
			
			$(this).css("background-position","left bottom");
			$("#quick .wrap").slideDown(500,"easeInOutExpo");	
			quickActive=true;
		}else{
			$(this).css("background-position","left top");
			$("#quick .wrap").slideUp(500,"easeInOutExpo");	
			quickActive=false;	
		}
		return false;
		
	});
	
	
	var q1=false;
	$("#quick .q1").click(function(){
		
		if(q1 == false){
			
			$(this).css("background-position","left bottom");
			$("#quick .qw1").slideDown(500,"easeInOutExpo");	
			q1=true;
		}else{
			$(this).css("background-position","left top");
			$("#quick .qw1").slideUp(500,"easeInOutExpo");	
			q1=false;	
		}
		return false;
		
	});
	
	var q2=false;
	$("#quick .q2").click(function(){
		
		if(q2==false){
			
			$(this).css("background-position","left bottom");
			$("#quick .qw2").slideDown(500,"easeInOutExpo");	
			q2=true;
		}else{
			$(this).css("background-position","left top");
			$("#quick .qw2").slideUp(500,"easeInOutExpo");	
			q2=false;	
		}
		return false;
		
	});
	
});
