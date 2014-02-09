/*
**  分页导航
*/
HROS.navbar = (function(){
	return {
		/*
		**  初始化
		*/
		init : function(){
			/*$('#nav-bar').css({
				'left' : $(document).width() / 2 - 105,
				'top' : 80
			}).show();
			HROS.navbar.getAvatar();
			HROS.navbar.move();*/
			HROS.navbar.resize();
			$('#navContainer a:not(.indicator-msg)').off("click").on("click",function(e){
				var thisobj = $(this);
				if(typeof(thisobj.attr('index')) !== 'undefined'){
					HROS.navbar.switchDesk(thisobj.attr('index'));
				}else if(thisobj.hasClass('indicator-manage')){
					//初始化全局视图
					HROS.appmanage.init();
				}else if(thisobj.hasClass('web-im')){
					//IM
					HROS.im.openIm();
				}
			});
			
			if(Util.isTouchDevice()){
				if($(document).find("#jquery_mobile_js").size()<1){
					$($(document).find("head").get(0)).append('<script id="jquery_mobile_js" src="'+HROS.CONFIG.basicStaticUrl+'/portal/js/jquery.mobile-1.3.1.min.js"></script>')
					//初始化滑动切屏
					$("#desktop").bind("swipeleft",HROS.navbar.switchLeft);
					$("#desktop").bind("swiperight",HROS.navbar.switchRight);
				}
			}
		},
		/*
		**  获取头像
		*/
		/*getAvatar : function(){
			$('#nav-bar .indicator-header-img').attr('src', 'img/ui/loading_24.gif');
			$.ajax({
				type : 'POST',
				url : ajaxUrl,
				data : 'ac=getAvatar'
			}).done(function(msg){
				$('#nav-bar .indicator-header-img').attr('src', msg);
			});
		},*/
		/*
		**  设置头像
		*/
		/*setAvatar : function(){
			HROS.window.createTemp({
				appid : 'txsz',
				title : '头像设置',
				url : 'sysapp/avatar/index.php',
				width : 550,
				height : 550
			});
		},*/
		/*
		**  拖动
		*/
		/*move : function(){
			$('#nav-bar, #navbarHeaderImg, #nav-bar .nav-container a.indicator').on('mousedown', function(e){
				$('.popup-menu').hide();
				$('.quick_view_container').remove();
				if(e.button == 0 || e.button == 1){
					var x, y, cx, cy, dx, dy, lay, obj = $('#nav-bar'), thisobj = $(this);
					dx = cx = obj.offset().left;
					dy = cy = obj.offset().top;
					x = e.clientX - dx;
					y = e.clientY - dy;
					//绑定鼠标移动事件
					$(document).on('mousemove', function(e){
						lay = HROS.maskBox.desk();
						lay.show();
						cx = e.clientX - x <= 0 ? 0 : e.clientX - x > $(document).width() - 210 ? $(document).width() - 210 : e.clientX - x;
						cy = e.clientY - y <= 10 ? 10 : e.clientY - y > $(document).height() - 50 ? $(document).height() - 50 : e.clientY - y;
						obj.css({
							left : cx,
							top : cy
						});
					}).on('mouseup', function(){
						if(dx == cx && dy == cy){
							if(typeof(thisobj.attr('index')) !== 'undefined'){
								HROS.navbar.switchDesk(thisobj.attr('index'));
							}else if(thisobj.hasClass('indicator-manage')){
								//初始化全局视图
								HROS.appmanage.init();
							}else if(thisobj.hasClass('indicator-header')){
								HROS.navbar.setAvatar();
							}
						}
						if(typeof(lay) !== 'undefined'){
							lay.hide();
						}
						$(this).off('mousemove').off('mouseup');
					});
				}
			});
		},*/
		/*
		**  切换桌面
		*/
		switchDesk : function(deskNumber){
			//验证传入的桌面号是否为1-HROS.CONFIG.deskLength+1的正整数
			var r = /^\+?[1-6]*$/;
			deskNumber = r.test(deskNumber) ? deskNumber : 1;
			var nav = $('#navContainer'), currindex = HROS.CONFIG.desk, switchindex = deskNumber,
			currleft = $('#desk-' + currindex).offset().left, switchleft = $('#desk-' + switchindex).offset().left;
			if(currindex != switchindex){
				//是选中桌边突出
				$('#navContainer div').removeClass("current");
				$('#b-content-0'+deskNumber).addClass("current");
				if(!$('#desk-' + switchindex).hasClass('animated') && !$('#desk-' + currindex).hasClass('animated')){
					$('#desk-' + currindex).addClass('animated').animate({
						left : switchleft
					}, 500, 'easeInOutCirc', function(){
						$(this).removeClass('animated');
					});
					$('#desk-'+switchindex).addClass('animated').animate({
						left : currleft
					}, 500, 'easeInOutCirc', function(){
						$(this).removeClass('animated');
						nav.removeClass('nav-current-' + currindex).addClass('nav-current-' + switchindex);
						HROS.CONFIG.desk = switchindex;
					});
				}
			}
		},
		switchLeft : function(){
			var currentDesk = Number(HROS.CONFIG.desk);
			if(currentDesk < HROS.CONFIG.deskLength){
        		HROS.navbar.switchDesk(currentDesk+1);
        	}else if(currentDesk == 6){
        		HROS.navbar.switchDesk(1);
        	}
		},
		switchRight : function(){
			var currentDesk = Number(HROS.CONFIG.desk);
			if(currentDesk > 1 && currentDesk <= HROS.CONFIG.deskLength){
        		HROS.navbar.switchDesk(currentDesk-1);
        	}else if(currentDesk == 1){
        		HROS.navbar.switchDesk(6);
        	}
		},
		resize : function(){
			var navContainer =  $("#navContainer>div:not(#b-content-msg,#b-content-im)");
			var size = navContainer.size();
			var leftW = ($(window).width() - size * 95)/2;
			leftW = leftW > 0 ? leftW:0;
			navContainer.each(function(i){
				$(this).css({left:leftW+(i*95)+"px"});
			});
		}
		
	}
})();


/*
**  home页 导航
*/
HROS.homenavbar = (function(){
	return {
		init : function(){
			$('#desk-6 .main-content-navi').off('click').on('click', 'li', function(){
				if($(this).hasClass('content-item-current')){
					
				}else{
					
				}
			});
			HROS.homenavbar.resize();
		},
		pageClick : function(showNum, realNum){
			$('#desk-6 .nav-hc .handdle-left-hc a').off('click').on('click',function(){
				var thisObj = $(this);
				if(thisObj.hasClass('disable'))return;
				var mleft = parseInt($('#desk-6 .main-content-navi ul').css('margin-left'));
				thisObj.addClass('disable');
				if(mleft<0){
					$('#desk-6 .nav-hc ul').animate({
						marginLeft : mleft + 90
					}, 200,function(){if(mleft + 90 < 0){thisObj.removeClass('disable');}});
					$('#desk-6 .nav-hc .handdle-right-hc a').removeClass('disable');
				}
			});
			$('#desk-6 .nav-hc .handdle-right-hc a').off('click').on('click',function(){
				var thisObj = $(this);
				if(thisObj.hasClass('disable'))return;
				var mleft = parseInt($('#desk-6 .main-content-navi ul').css('margin-left'));
				var leftNum = (mleft*-1) / 90;
				thisObj.addClass('disable');
				if(realNum > (leftNum+showNum)){
					$('#desk-6 .nav-hc ul').animate({
						marginLeft : mleft - 90
					}, 200,function(){if(realNum > (leftNum+showNum+1)){thisObj.removeClass('disable');}});
					$('#desk-6 .nav-hc .handdle-left-hc a').removeClass('disable');
				}
			});
		},
		resize : function(){
			var desktop = $('#desk-' + HROS.CONFIG.desk);
			var width = desktop.width();
			var height = desktop.height();
			var iframeH = height - 65;
			$("#homeIframeContent,#homeIframe").height(iframeH > 200?iframeH:200);
			var showNum = 0;
			var mleft = parseInt($('#desk-6 .main-content-navi ul').css('margin-left'));
			var leftNum = (mleft / 90)*-1;
			if(width>35){
				showNum = Math.floor((width-35) / 90);
				$("#desk-6 .main-content").width(showNum*90+35);
				//$("#desk-6 .main-content .main-content-subnav").width(showNum*90+40);
			}
			var realNum = $('#desk-6 .main-content-navi ul li').length;
			if(realNum > showNum){
				$('#desk-6 .nav-hc .handdle-left-hc').show().find("a").removeClass('disable');
				$('#desk-6 .nav-hc .handdle-right-hc').show().find("a").removeClass('disable');
				var needNum = showNum - (realNum - leftNum);
				if(needNum>0){
					$('#desk-6 .nav-hc ul').animate({
						marginLeft : (leftNum - needNum) * 90 * -1
					}, 200);
				}
				HROS.homenavbar.pageClick(showNum, realNum);
			}else{
				$('#desk-6 .nav-hc .handdle-left-hc').hide();
				$('#desk-6 .nav-hc .handdle-right-hc').hide();
				$('#desk-6 .nav-hc ul').animate({
					marginLeft : 0
				}, 200);
			}
		}
	}
})();
