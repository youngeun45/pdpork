 $(function(){
        // slide
        $(".owl-carousel").owlCarousel({
            loop:false,
            nav:true,
            items:1,
            autoplay:false,
            autoplayTimeout:2000,
            autoplayHoverPause:true
        })
        //tab
        $('.tabMotion a').click(function() {
            var href = $(this).attr('href');		
            $(href).show().siblings('.tab_cont').hide();;
            $(this).parent().addClass('on').siblings().removeClass('on');
            return false;
        });

        if($('.tabMotion').size() > 0){
            $('.tabMotion').each(function() {
                $(this).children('li').eq(0).children('a').trigger('click');	
            }); 		
        }
         //checkbox, radio
            $('label .checkbox, label .radio').focus(function(){
                $(this).parent().addClass('hover');
            }).blur(function(){
                $(this).parent().removeClass('hover');
            });
			sameHeight('.entry .section2 ul li div');
 })
 function sameHeight(tar){
		$(window).on('load resize',function(){
			var $tar = $(tar),
				$heightArry = [];
			$tar.each(function(){
				$(this).css('height','auto');
				var $height = $(this).height();
				$heightArry.push($height);
			})
			//console.log($heightArry)
			var $maxHeight = Math.max.apply(null, $heightArry);
			//console.log($maxHeight)
			$tar.css('height',$maxHeight);
		})
	}

var vOnlyNumber = function(obj){
	var str = obj.value;
	str = new String(str);
	var Re = /[^0-9]/g;
	str = str.replace(Re,'');
	obj.value = str;
}

var vTrimString = function(o){
	var str = new String(o);
	return str.replace(/\s/g,'');
}
