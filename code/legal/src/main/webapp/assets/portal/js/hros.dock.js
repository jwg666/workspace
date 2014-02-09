/*
**  应用码头
*/
HROS.dock = (function(){
	return {
		init : function(callback){
			$('#dock-container div.one-widget').off("click","a.option-icon-btn").on("mousedown","a.option-icon-btn",function(){return false;}).on("click","a.option-icon-btn",function(){
				var opiton =  $(this).next(".opiton-container");
				if(opiton.hasClass("show")){
					opiton.removeClass("show");
					$(this).removeClass("show");
				}else{
					$('#dock-container .opiton-container').removeClass("show");
					opiton.addClass("show");
					$(this).addClass("show");
				}
				
			});
			$('#dock-container .opiton-container').off('click').on('click','li:eq(0)',function(){
				var appid = $(this).parent().attr("appid");
				var obj = $('#dock-container div#'+appid+'_dock_widget');
				HROS.app.remove(appid, function(){
					obj.remove();
				});
			}).on('click','li:eq(1)',function(){
				var appid = $(this).parent().attr("appid");
				$("#" + appid + "_dock_iframe").slideDown();
				$(this).hide().next().show().next().show();
			}).on('click','li:eq(2)',function(){
				var appid = $(this).parent().attr("appid");
				$("#" + appid + "_dock_iframe").slideUp();
				$(this).hide().prev().show();
				$(this).next().hide();
			}).on('click','li:eq(3)',function(){
				var appid = $(this).parent().attr("appid");
				var id = "#" + appid + "_dock_iframe";
				$(id).attr('src', $(id).attr('src'));
			}).on("click",function(){
				$('#dock-container .opiton-container').removeClass("show");
			}).on("mousedown",function(){
				return false;
			})
		},
		getPos : function(callback){
			$.ajax({
				type : 'POST',
				url : ajaxUrl,
				data : 'ac=getDockPos',
				success : function(i){
					HROS.CONFIG.dockPos = i;
					HROS.dock.setPos();
					callback && callback();
				}
			});
		},
		setPos : function(){
			var desktop = $('#desk-' + HROS.CONFIG.desk), desktops = $('#desk .desktop-container');
			var desk_w = desktop.css('width', '100%').width(), desk_h = desktop.css('height', '100%').height();
//			deskheader暂时不适用
//			var deskheader = $('#desk-header');
//			deskbottom暂时不适用
//			var deskbottom = $('#desk-bottom');
			var desktopnav = $('#desktop_nav');
			var deskheader_h=HROS.CONFIG.deskHeaderHeight;
			var deskbottom_h=HROS.CONFIG.deskBottomHeight
			var desktopnav_h=HROS.CONFIG.desktopNavHeight;
			var dockBar_w=HROS.CONFIG.dockBarWidth;
			var taskBar_h=HROS.CONFIG.taskBarHeight;
			//清除dock位置样式
			$('#dock-container').removeClass('dock-top').removeClass('dock-left').removeClass('dock-right');
			//$('#dock-bar').removeClass('top-bar').removeClass('left-bar').removeClass('right-bar').hide();
			$('#dock-bar').removeClass('top-bar').removeClass('left-bar').removeClass('right-bar');
			if(HROS.CONFIG.dockPos == 'top'){
				//top 已取消
				$('#dock-bar').addClass('top-bar').children('#dock-container').addClass('dock-top');
				desktops.css({
					'width' : desk_w,
					'height' : desk_h - 143 - deskheader_h - deskbottom_h - desktopnav_h,
					'left' : desk_w,
					'top' : 73 + deskheader_h 
				});
				desktop.css({
					'left' : 0
				});
//				deskheader.css({'width' : desk_w,'left':0});
//				deskbottom.css({'width' : desk_w,'left':0,'top' : desk_h- 143 - deskbottom_h - desktopnav_h});
			}else if(HROS.CONFIG.dockPos == 'left'){
				$('#dock-bar').addClass('left-bar').children('#dock-container').addClass('dock-left');
				desktops.css({
					'width' : desk_w - dockBar_w,
					'height' : desk_h - taskBar_h - deskheader_h - deskbottom_h - desktopnav_h,
					'left' : desk_w + dockBar_w,
					'top' : 0 + deskheader_h 
				});
				desktop.css({
					'left' : dockBar_w
				});
				$("#homeContainer").addClass("right");
//				deskbottom.css({'width' : desk_w - dockBar_w,'left':dockBar_w,'top' : desk_h - taskBar_h - deskbottom_h - desktopnav_h});
//				deskheader.css({'width' : desk_w - dockBar_w,'left':dockBar_w});
			}else if(HROS.CONFIG.dockPos == 'right'){
				$('#dock-bar').addClass('right-bar').children('#dock-container').addClass('dock-right');
				desktops.css({
					'width' : desk_w - dockBar_w,
					'height' : desk_h - taskBar_h - deskheader_h - deskbottom_h - desktopnav_h,
					'left' : desk_w,
					'top' : 0 + deskheader_h 
				});
				desktop.css({
					'left' : 0
				});
				$("#homeContainer").removeClass("right");
//				console.log(desk_h +"-"+ taskBar_h +"-"+ deskheader_h +"-"+ deskbottom_h +"-"+ desktopnav_h);
//				deskbottom.css({'width' : desk_w - dockBar_w,'left':0,'top' : desk_h - taskBar_h - deskbottom_h - desktopnav_h});
//				deskheader.css({'width' : desk_w - dockBar_w,'left':0});
			}
			$('#dock-container .widget-hub').height(desk_h - taskBar_h - deskheader_h - deskbottom_h - desktopnav_h);
			//$('#dock-bar').show();
			HROS.taskbar.resize();
		},
		updatePos : function(pos, callback){
			$.ajax({
				type : 'POST',
				url : ajaxUrl,
				data : 'ac=setDockPos&dock=' + pos,
				success : function(){
					HROS.CONFIG.dockPos = pos;
					callback && callback();
				}
			});
		},
		move : function(){
			/*$('#dock-container').off('mousedown').on('mousedown',function(e){
				if(HROS.CONFIG.dockPos == "left"){
					if(e.clientX > 100)return false;
				}
				if(HROS.CONFIG.dockPos == "right"){
					if($(window).height() - e.clientX > 100)return false;
				}
				if(e.button == 0 || e.button == 1){
					var lay = HROS.maskBox.dock(), location;
					$(document).on('mousemove', function(e){
						lay.show();
						取消头部的接受
						if(e.clientY < lay.height() * 0.2){
							location = 'top';		
						}else 
						
						if(e.clientX < lay.width() * 0.5){
							location = 'left';
						}else{				
							location = 'right';
						}
						$('.dock_drap_effect').removeClass('hover');
						$('.dock_drap_effect_' + location).addClass('hover');
					}).on('mouseup', function(){
						$(document).off('mousemove').off('mouseup');
						lay.hide();
						if(location != HROS.CONFIG.dockPos && typeof(location) != 'undefined'){
							HROS.dock.updatePos(location, function(){
								//更新码头位置
								HROS.dock.setPos();
								//更新图标位置
								HROS.deskTop.appresize();
								//更新滚动条
								HROS.app.getScrollbar();
							});
						}
					});
				}
			});*/
		}
	}
})();