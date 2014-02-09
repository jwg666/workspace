/*
**  桌面
*/
HROS.deskTop = (function(){
	return {
		/*
		**  初始化桌面
		*/
		init : function(){
			//HROS.deskTop.load();
		},
		/*
		 **  重新初始化桌面
		 */
		reload : function(){
			HROS.deskTop.load();
			HROS.dock.setPos();
			HROS.app.get();
			HROS.navbar.init();
		},
		/*
		 **  加载桌面
		 */
		load : function(){
			$.ajax({
				  url: ajaxUrl + '?ac=loadDeskName',
				  cache: false,
				  //同步
				  async: false,
				  success: function(json){
					    var desknames = json.obj;
					    HROS.CONFIG.deskLength = desknames.length;
					    if(HROS.CONFIG.desk != HROS.CONFIG.deskHome){
					    	HROS.CONFIG.desk = HROS.CONFIG.desk > HROS.CONFIG.deskLength?HROS.CONFIG.deskLength:HROS.CONFIG.desk;
					    }
						$("#desk div.desktop-container:not(#desk-6)").remove();
						$("#navContainer div.deskNav").remove();
						$("#appmanage #amg_folder_container").empty();
						var desks = deskTemp({desknum:HROS.CONFIG.deskLength});
						$("#desk #desk-6").after(desks);
						var deskNav = deskNavTemp({list:desknames,basicStaticUrl:HROS.CONFIG.basicStaticUrl});
						$("#navContainer #b-content-06").after(deskNav);
						var appmanageItem = appmanageItemTemp({desknum:HROS.CONFIG.deskLength});
						$("#appmanage #amg_folder_container").html(appmanageItem);
				  }
			});
		},
		/*
		**  处理浏览器改变大小后的事件
		*/
		resize : function(time){
			//使用doTimeout插件，防止出现resize两次的bug
			$.doTimeout('resize', time, function(){
				$("#desk").css({height:$(window).height()-HROS.CONFIG.headerHeight});
				if($('#desktop').css('display') !== 'none'){
					//更新码头位置
					HROS.dock.setPos();
					//更新导航栏图标位置
					HROS.navbar.resize();
					//更新图标定位
					HROS.deskTop.appresize();
					//更新home
					HROS.homenavbar.resize();
					//更新窗口定位
					HROS.deskTop.windowresize();
					//更新滚动条
					HROS.app.getScrollbar();
				}else{
					HROS.appmanage.resize();
				}
				HROS.wallpaper.set(false);
				//重设desk高度
			});
		},
		/*
		**  重新排列图标
		*/
		appresize : function(){
			var grid = HROS.grid.getAppGrid(), dockGrid = HROS.grid.getDockAppGrid();
			$('#dock-bar .dock-applist li').each(function(i){
				$(this).animate({
					'left' : dockGrid[i]['startX'],
					'top' : dockGrid[i]['startY']
				}, 500);
			});
			for(var j = 1; j <= HROS.CONFIG.deskLength; j++){
				$('#desk-' + j + ' li').each(function(i){
					$(this).animate({
						'left' : grid[i]['startX'] + 16,
						'top' : grid[i]['startY'] + 7
					}, 500);
				});
			}
		},
		/*
		**  重新定位窗口位置(等比例变化top,left位置)
		*/
		windowresize : function(){
			$('#desk div.window-container').each(function(){
				var windowdata = $(this).data('info');
				currentW = $(window).width() - $(this).width();
				currentH = HROS.window.getDeskHeight() - $(this).height();
				var _l = windowdata['left'] / windowdata['emptyW'] * currentW >= currentW ? currentW : windowdata['left'] / windowdata['emptyW'] * currentW;
				_l = _l <= 0 ? 0 : _l;
				var _t = windowdata['top'] / windowdata['emptyH'] * currentH >= currentH ? currentH : windowdata['top'] / windowdata['emptyH'] * currentH;
				_t = _t <= 0 ? 0 : _t;
				if($(this).attr('state') != 'hide'){
					$(this).animate({
						'left' : _l,
						'top' : _t
					}, 500, function(){
						windowdata['left'] = _l;
						windowdata['top'] = _t;
						windowdata['emptyW'] = $(window).width() - $(this).width();
						windowdata['emptyH'] = HROS.window.getDeskHeight() - $(this).height();
					});
				}else{
					windowdata['left'] = _l;
					windowdata['top'] = _t;
					windowdata['emptyW'] = $(window).width() - $(this).width();
					windowdata['emptyH'] = HROS.window.getDeskHeight() - $(this).height();
				}
			});
		}
	}
})();