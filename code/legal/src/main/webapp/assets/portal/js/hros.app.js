/*
**  图标
*/
HROS.app = (function(){
	return {
		/*
		**  获得图标排列方式，x横向排列，y纵向排列
		*/
		getXY : function(callback){
			$.ajax({
				type : 'POST',
				url : ajaxUrl,
				data : 'ac=getAppXY'
			}).done(function(i){
				HROS.CONFIG.appXY = i;
				callback && callback();
			});
		},
		/*
		**  更新图标排列方式
		*/
		updateXY : function(i, callback){
			$.ajax({
				type : 'POST',
				url : ajaxUrl,
				data : 'ac=setAppXY&appxy=' + i
			}).done(function(){
				HROS.CONFIG.appXY = i;
				callback && callback();
			});
		},
		/*
		**  获取图标
		*/
		get : function(){
			//绘制图标表格
			var grid = HROS.grid.getAppGrid(), dockGrid = HROS.grid.getDockAppGrid();
			//获取json数组并循环输出每个图标
			$.getJSON(ajaxUrl + '?ac=getMyApp', function(sc){
				//加载应用码头图标
				if(sc['dock'] != ''){
					var dockMap = {};
					//生成桌面组件（dock）
					$(sc['dock']).each(function(i){
							dockMap[this.appid] =  deskDockItemTemp({
								type : this.type,
								appid : this.appid,
								realappid : this.realappid,
								title : this.name,
								imgsrc_val:this.icon,
								imgsrc : HROS.CONFIG.downloadImage+this.icon,
								url : Util.fullUrl(HROS.CONFIG.basicDynamicUrl,this.url),
								width : this.width,
								height :this.height,
								staticURL:HROS.CONFIG.basicStaticUrl
							});
					});
					var widgets = $('#dock-container div.widget-hub div.one-widget');
					if(widgets.size()>0){
						var preObj = null;
						for(var appid in dockMap){
							var widget = $('#dock-container div.widget-hub div#'+appid+'_dock_widget');
							if(widget.size()>0){
								widget.addClass("flag");
								preObj = widget;
							}else{
								var curObj = $(dockMap[appid]);
								if(preObj == null){
									preObj = curObj;
									$('#dock-container div.widget-hub').prepend(preObj);
								}else{
									preObj.after(curObj);
									preObj = curObj;
								}
							}
						}
					}else{
						var dock_append = '';
						for(var appid in dockMap){
							dock_append += dockMap[appid];
						}
						$('#dock-container div.widget-hub').html('').append(dock_append);
					}
					$('#dock-container div.widget-hub div.one-widget:not(.flag)').remove();
					$('#dock-container div.widget-hub div.one-widget').removeClass('flag');
					$('#dock-container div.widget-hub iframe').on('load', function(){
						this.contentWindow.dockappid = $(this).attr("id");
					});
				}else{
					$('#dock-container div.widget-hub').html('');
				}
				//加载桌面图标
				for(var j = 1; j <= HROS.CONFIG.deskLength; j++){
					var desk_append = '';
					if(sc['desk' + j] != ''){
						$(sc['desk' + j]).each(function(i){
							desk_append += appbtnTemp({
								'top' : grid[i]['startY'] + 7,
								'left' : grid[i]['startX'] + 16,
								'title' : this.name,
								'type' : this.type,
								'id' : 'd_' + this.realappid,
								'appid' : this.appid,
								'imgsrc_val' :this.icon,
								'imgsrc' : HROS.CONFIG.downloadImage+this.icon
							});
						});
					}
					desk_append += addbtnTemp({
						'top' : grid[sc['desk' + j].length]['startY'] + 7,
						'left' : grid[sc['desk' + j].length]['startX'] + 16
					});
					$('#desk-' + j + ' li').remove();
					$('#desk-' + j).append(desk_append);
				}
				//绑定'应用市场'图标点击事件
				$('#desk').off('click').on('click', 'li.add', function(){
					HROS.window.createTemp({
						appid : 'hoorayos-yysc',
						title : '应用市场',
						url : HROS.CONFIG.basicActionUrl+'/appmarket.do',
						width : 800,
						height : 520,
						isflash : false
					});
				});
				//绑定图标拖动事件
				HROS.app.move();
				//绑定应用码头拖动事件
				HROS.dock.move();
				//dock 菜单
				HROS.dock.init();
				//加载滚动条
				HROS.app.getScrollbar();
				//绑定滚动条拖动事件
				HROS.app.moveScrollbar();
				//绑定图标右击事件
				$('#desk').on('contextmenu', '.appbtn:not(.add)', function(e){
					$('.popup-menu').hide();
					$('.quick_view_container').remove();
					switch($(this).attr('type')){
						case 'app':
						case 'widget':
							var popupmenu = HROS.popupMenu.app($(this));
							break;
						case 'papp':
						case 'pwidget':
							var popupmenu = HROS.popupMenu.papp($(this));
							break;
						case 'folder':
							var popupmenu = HROS.popupMenu.folder($(this));
							break;
					}
					var l = ($(document).width() - e.clientX) < popupmenu.width() ? (e.clientX - popupmenu.width()) : e.clientX;
					var t = ($(document).height() - e.clientY) < popupmenu.height() ? (e.clientY - popupmenu.height()) : e.clientY;
					popupmenu.css({
						left : l,
						top : t
					}).show();
					return false;
				});
				//桌面组件没有 拉伸桌面
				if($('#dock-bar #dock-container div.one-widget').size()<1){
					$('#dock-bar').hide();
					if(HROS.CONFIG.dockBarWidth != 0){
						HROS.CONFIG.dockBarWidth=0;
						HROS.deskTop.resize(50);
					}
				}else{
					$('#dock-bar').show();
					if(HROS.CONFIG.dockBarWidth != 330){
						HROS.CONFIG.dockBarWidth=330;
						HROS.deskTop.resize(50);
					}
				}
			});
		},
		/*
		**  添加应用
		*/
		add : function(id, callback){
			$.ajax({
				type : 'POST',
				url : ajaxUrl,
				data : 'ac=addMyApp&id=' + id  + '&desk=' + (HROS.CONFIG.desk==HROS.CONFIG.deskHome?1:HROS.CONFIG.desk),
				success : function(){
					callback && callback();
				}
			}); 
		},
		/*
		**  删除应用
		*/
		remove : function(id, callback){
			$.ajax({
				type : 'POST',
				url : ajaxUrl,
				data : 'ac=delMyApp&id=' + id,
				success : function(){
					HROS.widget.removeCookie(id);
					callback && callback();
				}
			});
		},
		/*
		**  图标拖动、打开
		**  这块代码略多，主要处理了9种情况下的拖动，分别是：
		**  桌面拖动到应用码头、桌面拖动到文件夹内、当前桌面上拖动(排序)
		**  应用码头拖动到桌面、应用码头拖动到文件夹内、应用码头上拖动(排序)
		**  文件夹内拖动到桌面、文件夹内拖动到应用码头、不同文件夹之间拖动
		*/
		move : function(){
			//应用码头图标拖动
			$('#dock-container').off('mousedown', 'div.one-widget').on('mousedown', 'div.one-widget', function(e){
				e.preventDefault();
				e.stopPropagation();
				if(e.button == 0 || e.button == 1){
					var oldobj = $(this), x, y, cx, cy, dx, dy, lay, obj = $('<div id="dock-widget-shadow">' + oldobj.html() + '</div>');
					obj.find("iframe").remove();
					obj.height(oldobj.height());
					obj.width(oldobj.width());
					dx = cx = e.clientX;
					dy = cy = e.clientY;
					x = dx - oldobj.offset().left;
					y = dy - oldobj.offset().top;
					//绑定鼠标移动事件
					$(document).on('mousemove', function(e){
						$('body').append(obj);
						lay = HROS.maskBox.desk();
						lay.show();
						cx = e.clientX <= 0 ? 0 : e.clientX >= $(document).width() ? $(document).width() : e.clientX;
						cy = e.clientY <= 0 ? 0 : e.clientY >= $(document).height() ? $(document).height() : e.clientY;
						_l = cx - x;
						_t = cy - y;
						if(dx != cx || dy != cy){
							obj.css({
								left : _l,
								top : _t
							}).show();
						}
					}).on('mouseup', function(){
						$(document).off('mousemove').off('mouseup');
						obj.remove();
						if(typeof(lay) !== 'undefined'){
							lay.hide();
						}
						//判断是否移动图标，如果没有则判断为click事件
						if(dx == cx && dy == cy){
							return false;
						}
						//脱离接受范围
						if(HROS.CONFIG.dockPos =="right"){
							if(cx + HROS.CONFIG.dockBarWidth <  $(document).width()){
								return false;
							}
						}else if(HROS.CONFIG.dockPos =="left"){
							if(cx > HROS.CONFIG.dockBarWidth){
								return false;
							}
						}
						//移动
						var icon, icon2;
						var icon = oldobj.index();
						if(cy < HROS.CONFIG.headerHeight){
							icon2 = 0
						}else if(cy >= HROS.CONFIG.headerHeight + $("#dock-container").height()){
							icon2 = $('#dock-container div.one-widget').size() -1;
						}else{
							$('#dock-container div.one-widget').each(function(i){
								var _t = $(this).offset().top  ;
								var _h = $(this).height();
								if(cy >= _t && cy<= (_t + _h)){
									icon2 = i;
								}
							});
						}
						if(icon2 != null && icon2 != icon){
							$.ajax({
								type : 'POST',
								url : ajaxUrl,
								data : 'ac=updateMyApp&movetype=dock-dock&id=' + oldobj.attr('appid') + '&from=' + oldobj.index() + '&to=' + icon2,
								success : function(){
									if(icon2 < icon){
											$('#dock-container div.one-widget:eq(' + icon2 + ')').before(oldobj);
										}else if(icon2 > icon){
											$('#dock-container div.one-widget:eq(' + icon2 + ')').after(oldobj);
										}
									HROS.deskTop.appresize();
								}
							});
						}
					});
				}
				return false;
			});
			//桌面图标拖动
			$('#desk .desktop-container:not(.nomove)').off('mousedown', 'li:not(.add)').on('mousedown', 'li:not(.add)', function(e){
				e.preventDefault();
				e.stopPropagation();
				if(e.button == 0 || e.button == 1){
					var oldobj = $(this), x, y, cx, cy, dx, dy, lay, obj = $('<li id="shortcut_shadow">' + oldobj.html() + '</li>');
					dx = cx = e.clientX;
					dy = cy = e.clientY;
					x = dx - oldobj.offset().left;
					y = dy - oldobj.offset().top;
					//绑定鼠标移动事件
					$(document).on('mousemove', function(e){
						$('body').append(obj);
						lay = HROS.maskBox.desk();
						lay.show();
						cx = e.clientX <= 0 ? 0 : e.clientX >= $(document).width() ? $(document).width() : e.clientX;
						cy = e.clientY <= 0 ? 0 : e.clientY >= $(document).height() ? $(document).height() : e.clientY;
						_l = cx - x;
						_t = cy - y;
						if(dx != cx || dy != cy){
							obj.css({
								left : _l,
								top : _t
							}).show();
						}
					}).on('mouseup', function(){
						$(document).off('mousemove').off('mouseup');
						obj.remove();
						if(typeof(lay) !== 'undefined'){
							lay.hide();
						}
						//判断是否移动图标，如果没有则判断为click事件
						if(dx == cx && dy == cy){
							switch(oldobj.attr('type')){
								case 'app':
								case 'papp':
									HROS.window.create(oldobj.attr('appid'));
									break;
								case 'widget':
								case 'pwidget':
									HROS.widget.create(oldobj.attr('appid'));
									break;
								case 'folder':
									HROS.folderView.init(oldobj);
									break;
							}
							return false;
						}
						var folderId = HROS.grid.searchFolderGrid(cx, cy);
						if(folderId != null){
							if(oldobj.attr('type') != 'folder'){
								$.ajax({
									type : 'POST',
									url : ajaxUrl,
									data : 'ac=updateMyApp&movetype=desk-folder&id=' + oldobj.attr('appid') + '&from=' + (oldobj.index() - 2) + '&to=' + folderId + '&desk=' + HROS.CONFIG.desk,
									success : function(){
										oldobj.remove();
										HROS.deskTop.appresize();
										//如果文件夹预览面板为显示状态，则进行更新
										if($('#qv_' + folderId).length != 0){
											HROS.folderView.init($('#d_' + folderId));
										}
										//如果文件夹窗口为显示状态，则进行更新
										if($('#w_' + folderId).length != 0){
											HROS.window.updateFolder(folderId);
										}
									}
								});
							}
						}else{
							var icon, icon2;
							var iconIndex = $('#desk-' + HROS.CONFIG.desk + ' li.appbtn:not(.add)').length == 0 ? -1 : $('#desk-' + HROS.CONFIG.desk + ' li').index(oldobj);
							var iconIndex2 = $('#dock-bar .dock-applist').html() == '' ? -1 : $('#dock-bar .dock-applist li').index(oldobj);
							
							var dock_w2 = HROS.CONFIG.dockPos == 'left' ? 0 : HROS.CONFIG.dockPos == 'top' ? ($(window).width() - $('#dock-bar .dock-applist').width() - 20) / 2 : $(window).width() - $('#dock-bar .dock-applist').width();
							var dock_h2 = HROS.CONFIG.dockPos == 'top' ? 0 : ($(window).height() - $('#dock-bar .dock-applist').height() - 20) / 2;
							icon2 = HROS.grid.searchDockAppGrid(cx - dock_w2, cy - dock_h2);
							if(icon2 != null){
								$.ajax({
									type : 'POST',
									url : ajaxUrl,
									data : 'ac=updateMyApp&movetype=desk-dock&id=' + oldobj.attr('appid') + '&from=' + (oldobj.index() - 2) + '&to=' + (icon2 + 1) + '&desk=' + HROS.CONFIG.desk,
									success : function(){
										if(icon2 < iconIndex2){
											$('#dock-bar .dock-applist li:eq(' + icon2 + ')').before(oldobj);
										}else if(icon2 > iconIndex2){
											$('#dock-bar .dock-applist li:eq(' + icon2 + ')').after(oldobj);
										}else{
											if(iconIndex2 == -1){
												$('#dock-bar .dock-applist').append(oldobj);
											}
										}
										if($('#dock-bar .dock-applist li').length > 7){
											$('#desk-' + HROS.CONFIG.desk + ' li.add').before($('#dock-bar .dock-applist li').last());
										}
										HROS.deskTop.appresize();
									}
								});
							}else{
								var dock_w = HROS.CONFIG.dockPos == 'left' ? HROS.CONFIG.dockBarWidth : 0;
								var dock_h = HROS.CONFIG.dockPos == 'top' ? 73 : 0;
								icon = HROS.grid.searchAppGrid(cx - dock_w, cy - HROS.CONFIG.headerHeight -  HROS.CONFIG.deskHeaderHeight - dock_h);
								if(icon != null && icon != (oldobj.index() - 2)){
									$.ajax({
										type : 'POST',
										url : ajaxUrl,
										data : 'ac=updateMyApp&movetype=desk-desk&id=' + oldobj.attr('appid') + '&from=' + (oldobj.index() - 2) + '&to=' + icon + '&desk=' + HROS.CONFIG.desk,
										success : function(){
											if(icon < iconIndex){
												$('#desk-' + HROS.CONFIG.desk + ' li:not(.add):eq(' + icon + ')').before(oldobj);
											}else if(icon > iconIndex){
												$('#desk-' + HROS.CONFIG.desk + ' li:not(.add):eq(' + icon + ')').after(oldobj);
											}else{
												if(iconIndex == -1){
													$('#desk-' + HROS.CONFIG.desk + ' li.add').before(oldobj);
												}
											}
											HROS.deskTop.appresize();
										}
									});
								}
							}
						}
					});
				}
			});
			//文件夹内图标拖动
			$('.folder_body, .quick_view_container').off('mousedown', 'li').on('mousedown', 'li', function(e){
				e.preventDefault();
				e.stopPropagation();
				if(e.button == 0 || e.button == 1){
					var oldobj = $(this), x, y, cx, cy, dx, dy, lay, obj = $('<li id="shortcut_shadow">' + oldobj.html() + '</li>');
					dx = cx = e.clientX;
					dy = cy = e.clientY;
					x = dx - oldobj.offset().left;
					y = dy - oldobj.offset().top;
					//绑定鼠标移动事件
					$(document).on('mousemove', function(e){
						$('body').append(obj);
						lay = HROS.maskBox.desk();
						lay.show();
						cx = e.clientX <= 0 ? 0 : e.clientX >= $(document).width() ? $(document).width() : e.clientX;
						cy = e.clientY <= 0 ? 0 : e.clientY >= $(document).height() ? $(document).height() : e.clientY;
						_l = cx - x;
						_t = cy - y;
						if(dx != cx || dy != cy){
							obj.css({
								left : _l,
								top : _t
							}).show();
						}
					}).on('mouseup', function(){
						$(document).off('mousemove').off('mouseup');
						obj.remove();
						if(typeof(lay) !== 'undefined'){
							lay.hide();
						}
						//判断是否移动图标，如果没有则判断为click事件
						if(dx == cx && dy == cy){
							switch(oldobj.attr('type')){
								case 'app':
								case 'papp':
									HROS.window.create(oldobj.attr('appid'));
									break;
								case 'widget':
								case 'pwidget':
									HROS.widget.create(oldobj.attr('appid'));
									break;
							}
							return false;
						}
						var folderId = HROS.grid.searchFolderGrid(cx, cy);
						if(folderId != null){
							if(oldobj.parents('.folder-window').attr('appid') != folderId){
								$.ajax({
									type : 'POST',
									url : ajaxUrl,
									data : 'ac=updateMyApp&movetype=folder-folder&id=' + oldobj.attr('appid') + '&to=' + folderId,
									success : function(){
										oldobj.remove();
										HROS.deskTop.appresize();
										//如果文件夹预览面板为显示状态，则进行更新
										if($('#qv_' + folderId).length != 0){
											HROS.folderView.init($('#d_' + folderId));
										}
										//如果文件夹窗口为显示状态，则进行更新
										if($('#w_' + folderId).length != 0){
											HROS.window.updateFolder(folderId);
										}
									}
								});
							}
						}else{
							var icon, icon2;
							var iconIndex = $('#desk-' + HROS.CONFIG.desk + ' li.appbtn:not(.add)').length == 0 ? -1 : $('#desk-' + HROS.CONFIG.desk + ' li').index(oldobj);
							var iconIndex2 = $('#dock-bar .dock-applist').html() == '' ? -1 : $('#dock-bar .dock-applist li').index(oldobj);
							
							var dock_w2 = HROS.CONFIG.dockPos == 'left' ? 0 : HROS.CONFIG.dockPos == 'top' ? ($(window).width() - $('#dock-bar .dock-applist').width() - 20) / 2 : $(window).width() - $('#dock-bar .dock-applist').width();
							var dock_h2 = HROS.CONFIG.dockPos == 'top' ? 0 : ($(window).height() - $('#dock-bar .dock-applist').height() - 20) / 2;
							icon2 = HROS.grid.searchDockAppGrid(cx - dock_w2, cy - dock_h2);
							if(icon2 != null){
								$.ajax({
									type : 'POST',
									url : ajaxUrl,
									data : 'ac=updateMyApp&movetype=folder-dock&id=' + oldobj.attr('appid') + '&to=' + (icon2 + 1) + '&desk=' + HROS.CONFIG.desk,
									success : function(){
										var folderId = oldobj.parents('.folder-window').attr('appid');
										if(icon2 < iconIndex2){
											$('#dock-bar .dock-applist li.appbtn:not(.add):eq(' + icon2 + ')').before(oldobj);
										}else if(icon2 > iconIndex2){
											$('#dock-bar .dock-applist li.appbtn:not(.add):eq(' + icon2 + ')').after(oldobj);
										}else{
											if(iconIndex2 == -1){
												$('#dock-bar .dock-applist').append(oldobj);
											}
										}
										if($('#dock-bar .dock-applist li').length > 7){
											$('#desk-' + HROS.CONFIG.desk + ' li.add').before($('#dock-bar .dock-applist li').last());
										}
										HROS.deskTop.appresize();
										//如果文件夹预览面板为显示状态，则进行更新
										if($('#qv_' + folderId).length != 0){
											HROS.folderView.init($('#d_' + folderId));
										}
										//如果文件夹窗口为显示状态，则进行更新
										if($('#w_' + folderId).length != 0){
											HROS.window.updateFolder(folderId);
										}
									}
								});
							}else{
								var dock_w = HROS.CONFIG.dockPos == 'left' ? HROS.CONFIG.dockBarWidth : 0;
								var dock_h = HROS.CONFIG.dockPos == 'top' ? 73 : 0;
								icon = HROS.grid.searchAppGrid(cx - dock_w, cy - HROS.CONFIG.headerHeight -  HROS.CONFIG.deskHeaderHeight - dock_h);
								if(icon != null){
									if(HROS.CONFIG.deskHome == HROS.CONFIG.desk){
										//home 页不能放图标
										return false;
									}
									$.ajax({
										type : 'POST',
										url : ajaxUrl,
										data : 'ac=updateMyApp&movetype=folder-desk&id=' + oldobj.attr('appid') + '&to=' + (icon + 1) + '&desk=' + HROS.CONFIG.desk,
										success : function(){
											var folderId = oldobj.parents('.folder-window').attr('appid');
											if(icon < iconIndex){
												$('#desk-' + HROS.CONFIG.desk + ' li.appbtn:not(.add):eq(' + icon + ')').before(oldobj);
											}else if(icon > iconIndex){
												$('#desk-' + HROS.CONFIG.desk + ' li.appbtn:not(.add):eq(' + icon + ')').after(oldobj);
											}else{
												if(iconIndex == -1){
													$('#desk-' + HROS.CONFIG.desk + ' li.add').before(oldobj);
												}
											}
											HROS.deskTop.appresize();
											//如果文件夹预览面板为显示状态，则进行更新
											if($('#qv_' + folderId).length != 0){
												HROS.folderView.init($('#d_' + folderId));
											}
											//如果文件夹窗口为显示状态，则进行更新
											if($('#w_' + folderId).length != 0){
												HROS.window.updateFolder(folderId);
											}
										}
									});
								}
							}
						}
					});
				}
			});
		},
		/*
		**  加载滚动条
		*/
		getScrollbar : function(){
			setTimeout(function(){
				$('#desk .desktop-container').each(function(){
					var desk = $(this), scrollbar = desk.children('.scrollbar');
					//先清空所有附加样式
					scrollbar.hide();
					desk.scrollLeft(0).scrollTop(0);
					
					/*
					**  如果是home页面
					*/
					if($(this).attr("id") == 'desk-6'){
						/*var deskH = $(this).find(".main-content").height();
						if(desk.height() / deskH < 1){
							desk.children('.scrollbar-y').height(desk.height() / deskH * desk.height()).css('top',0).show();
						}*/
						return;
					}
					/*
					**  判断图标排列方式
					**  横向排列超出屏幕则出现纵向滚动条，纵向排列超出屏幕则出现横向滚动条
					*/
					if(HROS.CONFIG.appXY == 'x'){
						/*
						**  获得桌面图标定位好后的实际高度
						**  因为显示的高度是固定的，而实际的高度是根据图标个数会变化
						*/
						var deskH = parseInt(desk.children('.add').css('top')) + 108;
						/*
						**  计算滚动条高度
						**  高度公式（图标纵向排列计算滚动条宽度以此类推）：
						**  滚动条实际高度 = 桌面显示高度 / 桌面实际高度 * 滚动条总高度(桌面显示高度)
						**  如果“桌面显示高度 / 桌面实际高度 >= 1”说明图标个数未能超出桌面，则不需要出现滚动条
						*/
						if(desk.height() / deskH < 1){
							desk.children('.scrollbar-y').height(desk.height() / deskH * desk.height()).css('top',0).show();
						}
					}else{
						var deskW = parseInt(desk.children('.add').css('left')) + 106;
						if(desk.width() / deskW < 1){
							desk.children('.scrollbar-x').width(desk.width() / deskW * desk.width()).css('left',0).show();
						}
					}
				});
			},500);
		},
		/*
		**  移动滚动条
		*/
		moveScrollbar : function(){
			/*
			**  手动拖动
			*/
			$('.scrollbar').on('mousedown', function(e){
				var x, y, cx, cy, deskrealw, deskrealh, movew, moveh;
				var scrollbar = $(this), desk = scrollbar.parent('.desktop-container');
				deskrealw = parseInt(desk.children('.add').css('left')) + 106;
				deskrealh = parseInt(desk.children('.add').css('top')) + 108;
				movew = desk.width() - scrollbar.width();
				moveh = desk.height() - scrollbar.height();
				if(scrollbar.hasClass('scrollbar-x')){
					x = e.clientX - scrollbar.offset().left;
				}else{
					y = e.clientY - scrollbar.offset().top;
				}
				$(document).on('mousemove', function(e){
					if(scrollbar.hasClass('scrollbar-x')){
						if(HROS.CONFIG.dockPos == 'left'){
							cx = e.clientX - x - HROS.CONFIG.dockBarWidth < 0 ? 0 : e.clientX - x - HROS.CONFIG.dockBarWidth > movew ? movew : e.clientX - x - HROS.CONFIG.dockBarWidth;
						}else{
							cx = e.clientX - x < 0 ? 0 : e.clientX - x > movew ? movew : e.clientX - x;
						}
						scrollbar.css('left', cx / desk.width() * deskrealw + cx);
						desk.scrollLeft(cx / desk.width() * deskrealw);
					}else{
						if(HROS.CONFIG.dockPos == 'top'){
							cy = e.clientY - y - 73 < 0 ? 0 : e.clientY - y - 73 > moveh ? moveh : e.clientY - y - 73;
						}else{
							cy = e.clientY - y - HROS.CONFIG.headerHeight < 0 ? 0 : e.clientY - y - HROS.CONFIG.headerHeight > moveh ? moveh : e.clientY - y - HROS.CONFIG.headerHeight;
						}
						scrollbar.css('top', cy / desk.height() * deskrealh + cy);
						desk.scrollTop(cy / desk.height() * deskrealh);
					}
				}).on('mouseup', function(){
					$(this).off('mousemove').off('mouseup');
				});
			});
			/*
			**  鼠标滚轮
			**  只支持纵向滚动条
			*/
			$('#desk .desktop-container').each(function(i){
				$('#desk-' + (i + 1)).on('mousewheel', function(event, delta){
					var desk = $(this), deskrealh = parseInt(desk.children('.add').css('top')) + 108, scrollupdown;
					/*
					**  delta == -1   往下
					**  delta == 1    往上
					**  chrome下鼠标滚轮每滚动一格，页面滑动距离是200px，所以下面也用这个值来模拟每次滑动的距离
					*/
					if(delta < 0){
						scrollupdown = desk.scrollTop() + 200 > deskrealh - desk.height() ? deskrealh - desk.height() : desk.scrollTop() + 200;
					}else{
						scrollupdown = desk.scrollTop() - 200 < 0 ? 0 : desk.scrollTop() - 200;
					}
					desk.stop(false, true).animate({scrollTop:scrollupdown},300);
					desk.children('.scrollbar-y').stop(false, true).animate({
						top : scrollupdown / deskrealh * desk.height() + scrollupdown
					}, 300);
				});
			});
		}
	}
})();