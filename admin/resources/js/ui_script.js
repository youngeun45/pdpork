/*
	author : an.hyo-ju (anoju@cntt.co.kr) in CNTT
*/

$(function(){
	headActive();
	timer();
	formStyle();
	layerCtrl();
	tapMotion();
	topBtn();
	etcCtrl();

	//placeholder
	$(":input[placeholder]").placeholder();
	
	//$('html').add_browser_classes();
});

//브라우저 체크
$.fn.add_browser_classes = function(testielte9) {
	$(this).addClass('not-webkit not-firefox not-opera not-ie');

	if (/Chrome/.match(navigator.userAgent) && /Google Inc/.match(navigator.vendor)) {
		$(this).removeClass('not-webkit').addClass('webkit chrome');
	} else if (/Safari/.match(navigator.userAgent) && /Apple Computer/.match(navigator.vendor)) {
		$(this).removeClass('not-webkit').addClass('webkit safari');
	} else if (/Firefox/.match(navigator.userAgent)) {
		$(this).removeClass('not-firefox').addClass('firefox');
	} else if (window.opera && window.opera.buildNumber) {
		$(this).removeClass('not-opera').addClass('opera');
	} else if (Function('/*@cc_on return /^10/.test(@_jscript_version) @*/')()) {
		$(this).removeClass('not-ie').addClass('ie ie10');
	} else if (testielte9 == true) {
		var ie_lt_10=(function(){var c,a=3,d=document.createElement("div"),b=d.getElementsByTagName("i");while(d.innerHTML="<!--[if gt IE "+(++a)+"]><i></i><![endif]-->",b[0]){}return a>4?a:c}());
		if ((ie_lt_10 >= 4) && (ie_lt_10 <= 9)) {
			$(this).removeClass('not-ie');
			if (ie_lt_10 <= 6) {
				$(this).addClass('ie ie6 lt-ie10 lt-ie9 lt-ie8 lt-ie7');
			} else if (ie_lt_10 === 7) {
				$(this).addClass('ie ie7 lt-ie10 lt-ie9 lt-ie8');
			} else if (ie_lt_10 === 8) {
				$(this).addClass('ie ie8 lt-ie10 lt-ie9');
			} else if (ie_lt_10 === 9) {
				$(this).addClass('ie ie9 lt-ie10');
			}
		}
	}
	return this;
};

function urlParams(){
	// 파라미터가 담길 배열
	var param = new Array();

	// 현재 페이지의 url
	var url = decodeURIComponent(location.href);
	// url이 encodeURIComponent 로 인코딩 되었을때는 다시 디코딩 해준다.
	url = decodeURIComponent(url);

	var params;
	// url에서 '?' 문자 이후의 파라미터 문자열까지 자르기
	params = url.substring(url.indexOf('?')+1, url.length);
	// 파라미터 구분자("&") 로 분리
	params = params.split("&");

	// params 배열을 다시 "=" 구분자로 분리하여 param 배열에 key = value 로 담는다.
	var size = params.length;
	var key, value;
	for(var i=0 ; i < size ; i++){
		key = params[i].split("=")[0];
		value = params[i].split("=")[1];

		param[key] = value;
	}
	return param;
}

/*head*/
function headActive(){
	//gnb
	var gnbTxt = $('#gnb a');
	var current = $('#page_tit').text();

	//if($('#page_tit').size() > 0){
	//	document.title = current + ' | 굽네 관리시스템';
	//}

	// gnb active
	gnbTxt.each(function(){
		 if ($(this).text() == current){
			$(this).parents('li').addClass('active');
		}
	});

	//gnb 
	var speed = 500;
	$('#gnb > ul > li.active > div').delay(speed).slideDown(speed);

	$('#gnb > ul > li').each(function(index, el){
		if($(this).children('div').size()>0){
			if($(this).hasClass('active')){
				$(this).addClass('in_sub on');
			}else{
				$(this).addClass('in_sub');
			}
		}
	})
	$('#gnb').on('click','.in_sub>a',function(){
		$(this).next().slideToggle(speed).parent().toggleClass('on');
		$(this).closest('li').siblings('.in_sub').removeClass('on').children('div').slideUp(speed);
		return false;
	});
	$('.left_menu').mouseleave(function(){
		$('#gnb > ul > li').each(function(){
			if($(this).hasClass('active') && $(this).hasClass('in_sub')){
				$(this).addClass('on').children('div').slideDown(speed);
			}else{
				$(this).removeClass('on').children('div').slideUp(speed);
			}
		});
	});
	
	$('.btn_gnb').click(function(){
		if($('.left_menu').hasClass('active')){
			$(this).removeClass('on');
			$('.left_menu').removeClass('active');
		}else{
			$(this).addClass('on');
			$('.left_menu').addClass('active');
		}
		return false;
	});
}


/*timer*/
function timer(){
	var myDate = new Date(),
		year = myDate.getYear(),
		month = myDate.getMonth() +1,
		day = myDate.getDate(),
		dday=new Array('일','월','화','수','목','금','토'),
		weekend = myDate.getDay();
	//var hours = myDate.getHours();
	//var min = myDate.getMinutes();

	year = (year < 1000) ? year + 1900 :year;
	$('#header .date').html("<span><b>" + year + "</b>년</span><span><b>" + month + "</b>월</span><span><b>" + day +  "</b>일</span><span>"+ dday[weekend] + "요일</span>") 

	//clock
	var clock = $('#header .clock').FlipClock({
		clockFace:'TwelveHourClock'
	});
}

/*폼요소*/
function formStyle(){
	//spinner
	if($('.spinner').size() > 0){
		$('.spinner').spinner({
			min:1,
			max:9,
			create:function(event, ui){
				//add custom classes and icons
				$(this)
				.next().html('<i class="icon icon-plus">더하기</i>')
				.next().html('<i class="icon icon-minus">빼기</i>')
			}
		});
	}

	//inputFile	
	$('.inp_file > input').focus(function(){
		$(this).closest('.inp_file').find('.btn_file input').trigger('click');
	});	
	$('.btn_file .btn').click(function(e){
		e.preventDefault();
		$(this).closest('.inp_file').find('.btn_file input').trigger('click');
	});	
	$('.btn_file input').change(function(){
		$(this).closest('.inp_file').find('> input').val($(this).val());
	});

	if($('.datepicker').size() > 0){
		$('.datepicker').datepicker({
			closeText:'닫기',
			prevText:'이전달',
			nextText:'다음달',
			currentText:'오늘',
			monthNames:['01','02','03','04','05','06','07','08','09','10','11','12'],
			monthNamesShort:['01','02','03','04','05','06','07','08','09','10','11','12'],
			dayNames:['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
			dayNamesShort:['일','월','화','수','목','금','토'],
			dayNamesMin:['일','월','화','수','목','금','토'],
			changeMonth: true,
      		changeYear: true,
			dateFormat:'yy-mm-dd',
			showMonthAfterYear:true,
			showOn:'button',
			buttonText:'기간조회'
		});
	}

	// th 체크박스 기능
	$('.table thead th input:checkbox').on('click',function(){
		var that = this;
		$(this).closest('table').find('tr > th:first-child input:checkbox').each(function(){
			this.checked = that.checked;
		});
	});
}


/* TOP 버튼 */
function topBtn(){
	var settings ={
			button	  :'#toTop',
			text		:'컨텐츠 상단으로 이동',
			min		 :100,
			fadeIn	  :400,
			fadeOut	 :400,
			scrollSpeed :800,
			easingType  :'easeInOutExpo'
		}

	$('body').append('<a href="#" id="' + settings.button.substring(1) + '" title="' + settings.text + '">' + settings.text + '</a>');
	$(settings.button).on('click', function(e){
		$('html, body').animate({scrollTop :0}, settings.scrollSpeed, settings.easingType);
		e.preventDefault();
	})
	.on('mouseenter', function(){
		$(settings.button).addClass('hover');
	})
	.on('mouseleave', function(){
		$(settings.button).removeClass('hover');
	});

	$(window).scroll(function(){
		var position = $(window).scrollTop();
		if(position > settings.min){$(settings.button).fadeIn(settings.fadeIn);}
		else{$(settings.button).fadeOut(settings.fadeOut);}
	});
}

/* Tap */
function tapMotion(){	
	$('.tabMotion a').click(function(){
		if(!$(this).parent().hasClass('on')){
			var href = $(this).attr('href');		
			$(href).show().siblings('.tab_cont').hide();
			$(this).parent().addClass('on').siblings().removeClass('on');
			$(this).parents('.tabmenu').removeClass('tab_open')
		}else{
			$(this).parents('.tabmenu').toggleClass('tab_open')
		}
		return false;
	});

	$('.tabmenu a').click(function(){
		if($(this).parent().hasClass('on') && !$(this).parents('.tabmenu').hasClass('tabMotion')){
			$(this).parents('.tabmenu').toggleClass('tab_open');
			return false;
		}		
	});

	if($('.tabMotion').size() > 0){
		var $tab = parseInt(urlParams()['tab']);
		if($tab > 0){
			$('.tabMotion').each(function(){
				if($(this).hasClass('tab_url')){
					$(this).children('li').eq($tab-1).find('a').trigger('click');
				}else{
					$(this).children('li').eq(0).find('a').trigger('click');
				}
			});
		}else{
			$('.tabMotion').each(function(){
				$(this).children('li').eq(0).find('a').trigger('click');
			});
		}
	}
}

/* popup */
function layerCtrl(){
	$('.pop_open').click(function(){
		var _this =$(this);
		var vCont = _this.attr('href');
		
		layerShow(vCont);
		return false;
	});

	$('.pop_close').click(function(){
		var vCont = $(this).parents('.pop_bg');
		layerHide(vCont);
		return false;
	});

	$('.pop_bg').on('click',function(){
		var vCont = $(this);
		layerHide(vCont);
	}).on('click','.pop_wrap',function(e) {
		e.stopPropagation();
	});
}
function layerShow(tar){
	$('body').addClass('hidden');
	$(tar).fadeIn(300,function(){
		$(this).children().slideDown(300)
	});	
}
function layerHide(tar){
	var layer
	if(tar == undefined){
		layer = '.pop_bg';
	}else{
		layer = tar
	}	
	
	$('body').removeClass('hidden');
	$(layer).children('.pop_wrap').slideUp(300,function(){
		$(this).parent().fadeOut(300)
	})
}
function layerChange(tar){
	$('.pop_wrap').hide().closest('.pop_bg').hide();
	$(tar).show().find('.pop_wrap').show();
}

function etcCtrl(){	
	//a태그 기능정지
	$('a').click(function(e){
		var href = $(this).attr('href');
		if(href=='#none'){
			e.preventDefault;
		}
	});

	//faq
	$('.faq_list li p a').click(function(){
		$(this).parent().next('div').slideToggle(300).parent().toggleClass('on').siblings('li').removeClass('on').children('div').slideUp(300);
		return false;
	});

	//table hover
	$('.tbl_hover tbody th, .tbl_hover tbody td').hover(function(){
		$(this).parent('tr').addClass('hover').siblings('tr').removeClass('hover');
	},function(){
		$('.tbl_hover tr').removeClass('hover')
	});

	//인쇄
	$('.btn_print').click(function(){
		window.print();
		return false;
	});

	//on,off 버튼
	$('.onoffAction').click(function(){$(this).toggleClass('active');return false;});
	
	/* 숫자 업시키는 클래스 .countUp*/
	if($('.countUp').size()>0){
		$(window).load(function(){
			$('.countUp').counterUp({
				delay:10,
				time:1000
			});
		})
	}
}

var vCommaNumber = function(num){
	num = String(num);
	var pattern = /(-?[0-9]+)([0-9]{3})/;
	while(pattern.test(num)){
		num = num.replace(pattern,"$1,$2");
	}
	
	return num;
}