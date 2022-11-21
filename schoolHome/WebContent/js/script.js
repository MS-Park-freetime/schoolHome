// JavaScript Document
var imgs = 4;
var now = 0;

$(function(){
	$(".nav>li").mouseover(function(){
	  $(this).children(".submenu").stop().slideDown();
	});
	$(".nav>li").mouseleave(function(){
	  $(this).children(".submenu").stop().slideUp();
	});

	/* start(); */
	
	 $( ".btn_slides_next" ).click(function() {
		    if(!$("#slides li").last().is(":visible")){
		        $("#slides li:visible").hide().next("li").fadeIn("95");
		        $(".btn_slides_prev").removeClass("off");
		    }
		    if($("#slides li").last().is(":visible")){
		        $('.btn_slides_next').addClass('off');
		    }
		    return false;
		});

		$( ".btn_slides_prev" ).click(function() {
		    if(!$("#slides li").first().is(":visible")){
		        $("#slides li:visible").hide().prev("li").fadeIn("95");
		        $(".btn_slides_next").removeClass("off");
		    }
		    if($("#slides li").first().is(":visible")){
		        $('.btn_slides_prev').addClass('off');
		    }
		    return false;
		});
	
	/*  $('#imgsbar a').click(function(){
	    $('#imgsbar a').removeClass('active')
	    $(this).addClass('active');
	    var imgLeft=$(this).attr('img-left');
	    $('#imgs').animate({left:imgLeft},"fast");
	 });  */
});
	
	   
/* 	  function start(){
	  $(".imgs>#slides img").eq(0).siblings().css({"margin-left":"-2000px"});
	  setInterval(function(){slide();},2000);
	}
	  
	function slide(){
	  now = now==imgs?0:now+=1;
	  $(".imgs>#slides img").eq(now-1).css({"margin-left":"-2000px"});	
	  $(".imgs>#slides img").eq(now).css({"margin-left":"0px"});
	}  
	  */
	
	 var win;
	 function winOpen(){
	 win = window.open('contact.html','child','toolbar = no, location= no , status = no, menubar = no, resizable = no , scrollbars = no, width = 500, height = 950')
	 };

	/*  
	 $( ".btn_slides_next" ).click(function() {
		    if(!$("#slides li").last().is(":visible")){
		        $("#slides li:visible").hide().next("li").fadeIn("95");
		        $(".btn_slides_prev").removeClass("off");
		    }
		    if($("#slides li").last().is(":visible")){
		        $('.btn_slides_next').addClass('off');
		    }
		    return false;
		});

		$( ".btn_slides_prev" ).click(function() {
		    if(!$("#slides li").first().is(":visible")){
		        $("#slides li:visible").hide().prev("li").fadeIn("95");
		        $(".btn_slides_next").removeClass("off");
		    }
		    if($("#slides li").first().is(":visible")){
		        $('.btn_slides_prev').addClass('off');
		    }
		    return false;
		});
	  */
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  