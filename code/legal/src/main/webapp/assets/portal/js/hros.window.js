/*
**  应用窗口
*/
HROS.window = (function(){
	return {
		getDeskHeight : function(){return $(window).height() - HROS.CONFIG.headerHeight;},
		/*
		**  创建窗口
		**  自定义窗口：HROS.window.createTemp({appid,title,url,width,height,resize,isflash,customWindow});
		**      后面参数依次为：appid(可指定可无),标题、地址、宽、高、是否可拉伸、是否打开默认最大化、是否为flash,customWindow你需要引用的window对象
		**      示例：HROS.window.createTemp({title:"百度",url:"http://www.baidu.com",width:800,height:400,isresize:false,isopenmax:false,isflash:false});
		*/
		createTemp : function(obj){
			obj = HROS.window.filterAppid(obj);
			$('.popup-menu').hide();
			$('.quick_view_container').remove();
			var type = 'app';
			var appid = obj.realappid == null ? 0 : obj.realappid;
			var customWindow = obj.customWindow;
			//判断窗口是否已打开
			var iswindowopen = false;
			$('#task-content-inner a.task-item').each(function(){
				if($(this).attr('appid') == appid){
					iswindowopen = true;
					HROS.window.show2top(appid);
				}
			});
			//如果没有打开，则进行创建
			if(iswindowopen == false){
				function nextDo(options){
					var windowId = '#w_' + options.appid;
					//新增任务栏
					$('#task-content-inner').prepend(taskTemp({
						'type' : options.type,
						'id' : 't_' + options.appid,
						'appid' : options.realappid,
						'title' : options.title,
						'imgsrc' : options.imgsrc
					}));
					$('#task-content-inner').css('width', $('#task-content-inner .task-item').length * 114);
					HROS.taskbar.resize();
					//新增窗口
					TEMP.windowTemp = {
						'width' : options.width,
						'height' : options.height,
						'top' : (HROS.window.getDeskHeight() - options.height) / 2 - 20 <= 0 ? 0 : (HROS.window.getDeskHeight() - options.height) / 2 - 20,
						'left' : ($(window).width() - options.width) / 2 <= 0 ? 0 : ($(window).width() - options.width) / 2,
						'emptyW' : $(window).width() - options.width,
						'emptyH' : HROS.window.getDeskHeight() - options.height,
						'zIndex' : HROS.CONFIG.createIndexid,
						'type' : options.type,
						'id' : 'w_' + options.appid,
						'appid' : options.appid,
						'realappid' : options.realappid,
						'title' : options.title,
						'url' : options.url,
						'imgsrc' : options.imgsrc,
						'isresize' : options.isresize,
						'isopenmax' : options.isopenmax,
						'istitlebar' : options.isresize,
						'istitlebarFullscreen' : options.isresize ? window.fullScreenApi.supportsFullScreen == true ? true : false : false,
						'issetbar' : options.issetbar,
						'isflash' : options.isflash
					};
					$('#desk').append(windowTemp(TEMP.windowTemp));
					$(windowId).data('info', TEMP.windowTemp);
					HROS.CONFIG.createIndexid += 1;
					//iframe加载完毕后
					$(windowId).find('iframe').on('load', function(){
						try{
							var iframeWindow = $(windowId).find(".window-frame>iframe").get(0).contentWindow;
							iframeWindow.currentappid = options.appid;
							if(customWindow){
								iframeWindow.customWindow = customWindow;
							}
						}catch (e) {
							// 跨域问题
						}
						if(options.isresize){
							//绑定窗口拉伸事件
							HROS.window.resize($(windowId));
						}
						//隐藏loading
						$(windowId + ' .window-frame').children('div').eq(1).fadeOut();
					});
					$(windowId).on('contextmenu',function(){
						return false;
					});
					//绑定窗口上各个按钮事件
					HROS.window.handle($(windowId));
					//绑定窗口移动
					HROS.window.move($(windowId));
					//绑定窗口遮罩层点击事件
					$('.window-mask').off('click').on('click', function(){
						HROS.window.show2top($(this).parents('.window-container').attr('appid'));
					});
					HROS.window.show2top(options.realappid);
				}
				nextDo({
					type : type,
					appid : appid,
					imgsrc_val : '2020',
					imgsrc : HROS.CONFIG.downloadImage+'2020',
					title : obj.title,
					url : obj.url,
					width : obj.width,
					height : obj.height,
					isresize : typeof obj.isresize == 'undefined' ? false : obj.isresize,
					isopenmax : typeof obj.isopenmax == 'undefined' ? false : obj.isopenmax,
					issetbar : false,
					isflash : typeof obj.isflash == 'undefined' ? true : obj.isflash
				});
			}else{
				//如果设置强制刷新
				if(obj.refresh){
					var windowId = '#w_' + appid;
					$(windowId).find('iframe').attr('src', obj.url);
				}
			}
			return appid;
		},
		/*
		 **  创建noframe窗口
		 **  自定义窗口：HROS.window.createNoframeTemp({title,url,width,height,resize,isflash,notask,ismask,content,movehandle,maxhandle,reverthandle,hidehandle,closehandle,minWidth,minHeight,onLoadSuccess});
		 **      后面参数依次为：标题、地址、宽、高、是否可拉伸、是否打开默认最大化、是否为flash,是否加入任务栏,是否有遮罩,内容,拖动元素,.....,内容或url load 成功后 onLoadSuccess:function
		 **      示例：HROS.window.createTemp({title:"百度",url:"http://www.baidu.com",width:800,height:400,isresize:false,isopenmax:false,isflash:false});
		 */
		createNoframeTemp : function(obj){
			obj = HROS.window.filterAppid(obj);
			$('.popup-menu').hide();
			$('.quick_view_container').remove();
			var type = 'app', appid = obj.appid == null ? Date.parse(new Date()) : obj.appid;
			//判断窗口是否已打开
			var iswindowopen = false;
			/*是否需要添加到任务栏*/
			if(!obj.notask){
				$('#task-content-inner a.task-item').each(function(){
					if($(this).attr('appid') == appid){
						iswindowopen = true;
						HROS.window.show2top(appid);
					}
				});
			}
			//如果没有打开，则进行创建
			if(iswindowopen == false){
				function nextDo(options){
					var windowId = '#w_' + options.appid;
					/*是否需要添加到任务栏*/
					if(!obj.notask){
						//新增任务栏
						$('#task-content-inner').prepend(taskTemp({
							'type' : options.type,
							'id' : 't_' + options.appid,
							'appid' : options.appid,
							'title' : options.title,
							'imgsrc' : options.imgsrc
						}));
						$('#task-content-inner').css('width', $('#task-content-inner .task-item').length * 114);
						HROS.taskbar.resize();
					}
					//新增窗口
					TEMP.windowTemp = {
							'width' : options.width,
							'height' : options.height,
							'top' : (HROS.window.getDeskHeight() - options.height) / 2 - 20 <= 0 ? 0 : (HROS.window.getDeskHeight() - options.height) / 2 - 20,
							'left' : ($(window).width() - options.width) / 2 <= 0 ? 0 : ($(window).width() - options.width) / 2,
							'emptyW' : $(window).width() - options.width,
							'emptyH' : HROS.window.getDeskHeight() - options.height,
							'zIndex' : HROS.CONFIG.createIndexid,
							'type' : options.type,
							'id' : 'w_' + options.appid,
							'appid' : options.appid,
							'realappid' : 0,
							'title' : options.title,
							'url' : options.url,
							'imgsrc' : options.imgsrc,
							'isresize' : options.isresize,
							'isopenmax' : options.isopenmax,
							'istitlebar' : options.isresize,
							'istitlebarFullscreen' : options.isresize ? window.fullScreenApi.supportsFullScreen == true ? true : false : false,
							'issetbar' : options.issetbar,
							'isflash' : options.isflash,
							'ismask' : options.ismask
					};
					$('#desk').append(windowNoFrameTemp(TEMP.windowTemp));
					$(windowId).data('info', TEMP.windowTemp);
					HROS.CONFIG.createIndexid += 1;
					if(obj.url){
						$(windowId).find(".noframe").load(obj.url,function(){
							//绑定窗口移动
							HROS.window.moveNoframe($(windowId),obj);
							//绑定窗口上各个按钮事件
							HROS.window.handleNoframe($(windowId),obj);
							if(options.isresize){
								//绑定窗口拉伸事件
								HROS.window.resize($(windowId),obj.minWidth,obj.minHeight);
							}
							//onLoadSuccess
							if(typeof obj.onLoadSuccess =='function'){
								obj.onLoadSuccess.call($(windowId).get(0));
							}
							//隐藏loading
							$(windowId + ' .window-noframe').children('div').eq(1).fadeOut();
						});
					}else{
						if(typeof(obj.content) == "string"){
							$(windowId).find(".noframe").html(obj.content);
						}else{
							$(windowId).find(".noframe").append(obj.content);
						}
						//绑定窗口移动
						HROS.window.moveNoframe($(windowId),obj);
						//绑定窗口上各个按钮事件
						HROS.window.handleNoframe($(windowId),obj);
						if(options.isresize){
							//绑定窗口拉伸事件
							HROS.window.resize($(windowId),obj.minWidth,obj.minHeight);
						}
						//onLoadSuccess
						if(typeof obj.onLoadSuccess =='function'){
							obj.onLoadSuccess.call($(windowId).get(0));
						}
						//隐藏loading
						$(windowId + ' .window-noframe').children('div').eq(1).fadeOut();
					}
					$(windowId).on('contextmenu',function(){
						return false;
					});
					$(windowId).bind("selectstart",function(event){event.stopPropagation();return true;}); 
					//绑定窗口遮罩层点击事件
					$('.window-mask').off('click').on('click', function(){
						HROS.window.show2top($(this).parents('.window-container').attr('appid'));
					});
					HROS.window.show2top(options.appid);
				}
				nextDo({
					type : type,
					appid : appid,
					imgsrc_val : '927',
					imgsrc : HROS.CONFIG.downloadImage+'927',
					title : obj.title,
					url : obj.url,
					width : obj.width,
					height : obj.height,
					isresize : typeof obj.isresize == 'undefined' ? false : obj.isresize,
					isopenmax : typeof obj.isopenmax == 'undefined' ? false : obj.isopenmax,
					issetbar : false,
					isflash : typeof obj.isflash == 'undefined' ? true : obj.isflash,
					ismask : typeof obj.ismask == 'undefined' ? true : obj.ismask
					
				});
			}else{
				//如果设置强制刷新
				if(obj.refresh){
					var windowId = '#w_' + appid;
					$(windowId).find('iframe').attr('src', obj.url);
				}
			}
			return appid;
		},
		/*
		**  创建窗口
		**  系统窗口：HROS.window.create(appid);
		**      示例：HROS.window.create(12);
		*/
		create : function(appid){
			appid = HROS.window.filterAppid(appid);
			$('.popup-menu').hide();
			$('.quick_view_container').remove();
			//判断窗口是否已打开
			var iswindowopen = false;
			$('#task-content-inner a.task-item').each(function(){
				if($(this).attr('appid') == appid){
					iswindowopen = true;
					HROS.window.show2top(appid);
				}
			});
			//如果没有打开，则进行创建
			if(iswindowopen == false && $('#d_' + appid).attr('opening') != 1){
				$('#d_' + appid).attr('opening', 1);
				function nextDo(options){
					var windowId = '#w_' + options.appid;
					var top = (HROS.window.getDeskHeight() - options.height) / 2 - 20 <= 0 ? 0 : (HROS.window.getDeskHeight() - options.height) / 2 - 20;
					var left = ($(window).width() - options.width) / 2 <= 0 ? 0 : ($(window).width() - options.width) / 2;
					switch(options.type){
						case 'app':
						case 'papp':
							//新增任务栏
							$('#task-content-inner').prepend(taskTemp({
								'type' : options.type,
								'id' : 't_' + options.appid,
								'appid' : options.appid,
								'title' : options.title,
								'imgsrc' : options.imgsrc
							}));
							$('#task-content-inner').css('width', $('#task-content-inner .task-item').length * 114);
							HROS.taskbar.resize();
							//新增窗口
							TEMP.windowTemp = {
								'width' : options.width,
								'height' : options.height,
								'top' : top,
								'left' : left,
								'emptyW' : $(window).width() - options.width,
								'emptyH' : HROS.window.getDeskHeight() - options.height,
								'zIndex' : HROS.CONFIG.createIndexid,
								'type' : options.type,
								'id' : 'w_' + options.appid,
								'appid' : options.appid,
								'realappid' : options.realappid,
								'title' : options.title,
								'url' : options.url,
								'imgsrc' : options.imgsrc,
								'isresize' : options.isresize == 1 ? true : false,
								'isopenmax' : options.isresize == 1 ? options.isopenmax == 1 ? true : false : false,
								'istitlebar' : options.isresize == 1 ? true : false,
								'istitlebarFullscreen' : options.isresize == 1 ? window.fullScreenApi.supportsFullScreen == true ? true : false : false,
								'issetbar' : options.issetbar == 1 ? true : false,
								'isflash' : options.isflash == 1 ? true : false
							};
							$('#desk').append(windowTemp(TEMP.windowTemp));
							$(windowId).data('info', TEMP.windowTemp);
							HROS.CONFIG.createIndexid += 1;
							//iframe加载完毕后
							$(windowId + ' iframe').on('load', function(){
								//防止异常
								try{
									var iframeWindow = $(windowId).find(".window-frame>iframe").get(0).contentWindow;
									iframeWindow.currentappid = options.appid;
									if(options.url && options.url.indexOf("/report/")==0){
										$(iframeWindow).on('resize', function(){
											if(iframeWindow.location.href.indexOf("/report/Report-ResultAction.do")>-1){
												$.doTimeout('resize', 500, function(){
													if(iframeWindow.document.getElementById("divHeaderColumn")!=null){
														iframeWindow.document.getElementById("divHeaderRow").style.width=(iframeWindow.document.body.clientWidth -10)+"px";
														iframeWindow.document.getElementById("divHeaderRowTop").style.width=(iframeWindow.document.body.clientWidth-10)+"px";
														iframeWindow.document.getElementById("innerDiv0").style.width=(iframeWindow.document.body.clientWidth-10)+"px";
													}
												});
											}
										});
									}

								}catch(e){
									try{
										console.log(e);
									}catch(e){}
								}
								if(options.isresize){
									//绑定窗口拉伸事件
									HROS.window.resize($(windowId));
								}
								//隐藏loading
								$(windowId + ' .window-frame').children('div').eq(1).fadeOut();
							});
							$(windowId).on('contextmenu',function(){
								return false;
							});
							//绑定窗口上各个按钮事件
							HROS.window.handle($(windowId));
							//绑定窗口移动
							HROS.window.move($(windowId));
							//绑定窗口遮罩层点击事件
							$('.window-mask').off('click').on('click', function(){
								HROS.window.show2top($(this).parents('.window-container').attr('appid'));
							});
							HROS.window.show2top(options.appid);
							break;
						case 'folder':
							//新增任务栏
							$('#task-content-inner').prepend(taskTemp({
								'type' : options.type,
								'id' : 't_' + options.appid,
								'appid' : options.appid,
								'title' : options.title,
								'imgsrc' : options.imgsrc
							}));
							$('#task-content-inner').css('width', $('#task-content-inner .task-item').length * 114);
							HROS.taskbar.resize();
							//新增窗口
							TEMP.folderWindowTemp = {
								'width' : options.width,
								'height' : options.height,
								'top' : top,
								'left' : left,
								'emptyW' : $(window).width() - options.width,
								'emptyH' : HROS.window.getDeskHeight() - options.height,
								'zIndex' : HROS.CONFIG.createIndexid,
								'type' : options.type,
								'id' : 'w_' + options.appid,
								'appid' : options.appid,
								'title' : options.title,
								'imgsrc' : options.imgsrc
							};
							$('#desk').append(folderWindowTemp(TEMP.folderWindowTemp));
							$(windowId).data('info', TEMP.folderWindowTemp);
							HROS.CONFIG.createIndexid += 1;
							//载入文件夹内容
							$.getJSON(ajaxUrl + '?ac=getMyFolderApp&folderid=' + options.appid, function(sc){
								if(sc != null){
									var folder_append = '';
									for(var i = 0; i < sc.length; i++){
										folder_append += appbtnTemp({
											'top' : 0,
											'left' : 0,
											'title' : sc[i]['name'],
											'type' : sc[i]['type'],
											'id' : 'd_' + sc[i]['appid'],
											'appid' : sc[i]['appid'],
											'imgsrc_val' : sc[i]['icon'],
											'imgsrc' : HROS.CONFIG.downloadImage+sc[i]['icon']
										});
									}
									$(windowId).find('.folder_body').append(folder_append);
									HROS.app.move();
								}
								appEvent();
							});
							function appEvent(){
								$(windowId).on('contextmenu', function(){
									return false;
								});
								//绑定文件夹内图标右击事件
								$(windowId + ' .folder_body').on('contextmenu', '.appbtn', function(e){
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
									}
									var l = ($(document).width() - e.clientX) < popupmenu.width() ? (e.clientX - popupmenu.width()) : e.clientX;
									var t = ($(document).height() - e.clientY) < popupmenu.height() ? (e.clientY - popupmenu.height()) : e.clientY;
									popupmenu.css({
										left : l,
										top : t
									}).show();
									return false;
								});
								//绑定窗口缩放事件
								HROS.window.resize($(windowId));
								//隐藏loading
								$(windowId + ' .window-frame').children('div').eq(1).fadeOut();
								//绑定窗口上各个按钮事件
								HROS.window.handle($(windowId));
								//绑定窗口移动
								HROS.window.move($(windowId));
								//绑定窗口遮罩层点击事件
								$('.window-mask').off('click').on('click', function(){
									HROS.window.show2top($(this).parents('.window-container').attr('appid'));
								});
								HROS.window.show2top(options.appid);
							}
							break;
					}
				}
				ZENG.msgbox.show('应用正在加载中，请耐心等待...', 6, 100000);
				$.getJSON(ajaxUrl + '?ac=getMyAppById&id=' + appid, function(app){
					if(app != null){
						if(app['error'] == 'E100'){
							ZENG.msgbox.show('应用不存在，建议删除', 5, 2000);
						}else{
							ZENG.msgbox._hide();
							nextDo({
								type : app['type'],
								id : app['appid'],
								appid : app['appid'],
								realappid : app['realappid'],
								title : app['name'],
								imgsrc_val:app['icon'],
								imgsrc : HROS.CONFIG.downloadImage+app['icon'],
								url : Util.fullUrl(HROS.CONFIG.basicDynamicUrl,app['url']),
								width : app['width'],
								height : app['height'],
								isresize : app['isresize'],
								isopenmax : app['isopenmax'],
								issetbar : app['issetbar'],
								isflash : app['isflash']
							});
						}
					}else{
						ZENG.msgbox.show('数据拉取失败', 5, 2000);
					}
					$('#d_' + appid).attr('opening', 0);
				});
			}
		},
		close : function(appid){
			appid = HROS.window.filterAppid(appid);
			var windowId = '#w_' + appid, taskId = '#t_' + appid;
			$(windowId).removeData('info').html('').remove();
			$('#task-content-inner ' + taskId).html('').remove();
			$('#task-content-inner').css('width', $('#task-content-inner .task-item').length * 114);
			$('#task-bar, #nav-bar').removeClass('min-zIndex');
			$('#desktop_nav').removeClass('min-zIndex');
			HROS.taskbar.resize();
		},
		closeAll : function(){
			$('#desk .window-container').each(function(){
				HROS.window.close($(this).attr('appid'));
			});
		},
		hide : function(appid){
			appid = HROS.window.filterAppid(appid);
			HROS.window.show2top(appid);
			var windowId = '#w_' + appid, taskId = '#t_' + appid;
			$(windowId).css('left', '-10000px').attr('state', 'hide');
			$('#task-content-inner ' + taskId).removeClass('task-item-current');
			if($(windowId).attr('ismax') == 1){
				$('#task-bar, #nav-bar').removeClass('min-zIndex');
				$('#desktop_nav').removeClass('min-zIndex');
			}
		},
		hideAll : function(){
			$('#task-content-inner a.task-item').removeClass('task-item-current');
			$('#desk-' + HROS.CONFIG.desk).nextAll('div.window-container').css('left', -10000).attr('state', 'hide');
		},
		max : function(appid){
			appid = HROS.window.filterAppid(appid);
			HROS.window.show2top(appid);
			var windowId = '#w_' + appid, taskId = '#t_' + appid;
			$(windowId + ' .title-handle .ha-max').hide().next(".ha-revert").show();
			$(windowId).addClass('window-maximize').attr('ismax',1).animate({
				width : '100%',
				height : HROS.window.getDeskHeight(),
				top : 0,
				left : 0
			}, 200);
			$('#task-bar, #nav-bar').addClass('min-zIndex');
			$('#desktop_nav').addClass('min-zIndex');
		},
		revert : function(appid){
			appid = HROS.window.filterAppid(appid);
			HROS.window.show2top(appid);
			var windowId = '#w_' + appid, taskId = '#t_' + appid;
			$(windowId + ' .title-handle .ha-revert').hide().prev('.ha-max').show();
			var obj = $(windowId), windowdata = obj.data('info');
			obj.removeClass('window-maximize').attr('ismax',0).animate({
				width : windowdata['width'],
				height : windowdata['height'],
				left : windowdata['left'],
				top : windowdata['top']
			}, 500);
			$('#task-bar, #nav-bar').removeClass('min-zIndex');
			$('#desktop_nav').removeClass('min-zIndex');
		},
		refresh : function(appid){
			appid = HROS.window.filterAppid(appid);
			HROS.window.show2top(appid);
			var windowId = '#w_' + appid, taskId = '#t_' + appid;
			//判断是应用窗口，还是文件夹窗口
			if($(windowId + '_iframe').length != 0){
				$(windowId + '_iframe').attr('src', $(windowId + '_iframe').attr('src'));
			}else{
				HROS.window.updateFolder(appid);
			}
		},
		show2top : function(appid){
			appid = HROS.window.filterAppid(appid);
			HROS.window.show2under();
			var windowId = '#w_' + appid, taskId = '#t_' + appid;
			if($(windowId).size()>0){
				var windowdata = $(windowId).data('info');
				//改变当前任务栏样式
				$('#task-content-inner ' + taskId).addClass('task-item-current');
				if($(windowId).attr('ismax') == 1){
					$('#task-bar, #nav-bar').addClass('min-zIndex');
					$('#desktop_nav').addClass('min-zIndex');
				}
				//改变当前窗口样式
				$(windowId).addClass('window-current').css({
					'z-index' : HROS.CONFIG.createIndexid,
					'left' : windowdata['left'],
					'top' : windowdata['top']
				}).attr('state', 'show');
				//如果窗口最小化前是最大化状态的，则坐标位置设为0
				if($(windowId).attr('ismax') == 1){
					$(windowId).css({
						'left' : 0,
						'top' : 0
					});
				}
				//改变当前窗口遮罩层样式
				$(windowId + ' .window-mask').hide();
				//改变当前iframe显示
				$(windowId + ' iframe').show();
				HROS.CONFIG.createIndexid += 1;
				return true;
			}else{
				return false;
			}
			
		},
		show2under : function(){
			//改变任务栏样式
			$('#task-content-inner a.task-item').removeClass('task-item-current');
			//改变窗口样式
			$('#desk .window-container').removeClass('window-current');
			//改变窗口遮罩层样式
			$('#desk .window-container .window-mask').show();
			//改变iframe显示
			$('#desk .window-container-flash iframe').hide();
		},
		updateFolder : function(appid){
			appid = HROS.window.filterAppid(appid);
			HROS.window.show2top(appid);
			var windowId = '#w_' + appid, taskId = '#t_' + appid;
			$.getJSON(ajaxUrl + '?ac=getMyFolderApp&folderid=' + appid, function(sc){
				if(sc != null){
					var folder_append = '';
					for(var i = 0; i < sc.length; i++){
						folder_append += appbtnTemp({
							'top' : 0,
							'left' : 0,
							'title' : sc[i]['name'],
							'type' : sc[i]['type'],
							'id' : 'd_' + sc[i]['appid'],
							'appid' : sc[i]['appid'],
							'imgsrc_val' : sc[i]['icon'],
							'imgsrc' : HROS.CONFIG.downloadImage+sc[i]['icon']
						});
					}
					$(windowId).find('.folder_body').html('').append(folder_append).on('contextmenu', '.appbtn', function(e){
						$('.popup-menu').hide();
						$('.quick_view_container').remove();
						TEMP.AppRight = HROS.popupMenu.app($(this));
						var l = ($(document).width() - e.clientX) < TEMP.AppRight.width() ? (e.clientX - TEMP.AppRight.width()) : e.clientX;
						var t = ($(document).height() - e.clientY) < TEMP.AppRight.height() ? (e.clientY - TEMP.AppRight.height()) : e.clientY;
						TEMP.AppRight.css({
							left : l,
							top : t
						}).show();
						return false;
					});
					HROS.app.move();
				}
			});
		},
		handle : function(obj){
			obj.on('dblclick', '.title-bar', function(e){
				//判断当前窗口是否已经是最大化
				if(obj.find('.ha-max').is(':hidden')){
					obj.find('.ha-revert').click();
				}else{
					obj.find('.ha-max').click();
				}
			}).on('click', '.ha-hide', function(){
				HROS.window.hide(obj.attr('appid'));
			}).on('click', '.ha-max', function(){
				HROS.window.max(obj.attr('appid'));
			}).on('click', '.ha-revert', function(){
				HROS.window.revert(obj.attr('appid'));
			}).on('click', '.ha-fullscreen', function(){
				window.fullScreenApi.requestFullScreen(document.getElementById(obj.find('iframe').attr('id')));
			}).on('click', '.ha-close', function(){
				HROS.window.close(obj.attr('appid'));
			}).on('click', '.refresh', function(){
				HROS.window.refresh(obj.attr('appid'));
			}).on('click', '.help', function(){
				if(obj.attr('realappid') !== 0){
					HROS.window.createTemp({
						appid : 'hoorayos-yysc',
						title : '应用市场',
						url : HROS.CONFIG.basicActionUrl+'/appmarket.do?id=' + obj.attr('realappid'),
						width : 800,
						height : 484,
						isflash : false,
						refresh : true
					});
				}else{
					ZENG.msgbox.show('对不起，该应用没有任何详细介绍', 1, 2000);
				}
			}).on('click', '.star', function(){
				$.dialog({
					title : '给“' + obj.data('info').title + '”打分',
					width : 250,
					id : 'star',
					content : starDialogTemp({
						'point' : Math.floor(0),
						'realpoint' : 0 * 20
					})
				});
				/*$.ajax({
					type : 'POST',
					url : ajaxUrl,
					data : 'ac=getAppStar&id=' + obj.data('info').appid,
					success : function(point){
						$.dialog({
							title : '给“' + obj.data('info').title + '”打分',
							width : 250,
							id : 'star',
							content : starDialogTemp({
								'point' : Math.floor(point),
								'realpoint' : point * 20
							})
						});
						$('#star ul').data('appid', obj.data('info').appid);
					}
				});
				$('body').off('click').on('click', '#star ul li', function(){
					var num = $(this).attr('num');
					var appid = $(this).parent('ul').data('appid');
					if(!isNaN(num) && /^[1-5]$/.test(num)){
						$.ajax({
							type : 'POST',
							url : ajaxUrl,
							data : 'ac=updateAppStar&id=' + appid + '&starnum=' + num,
							success : function(msg){
								art.dialog.list['star'].close();
								if(msg){
									ZENG.msgbox.show("打分成功！", 4, 2000);
								}else{
									ZENG.msgbox.show("你已经打过分了！", 1, 2000);
								}
							}
						});
					}
				});*/
			}).on('contextmenu', '.window-container', function(){
				$('.popup-menu').hide();
				$('.quick_view_container').remove();
				return false;
			});
		},
		handleNoframe : function(obj,objData){
			var data = {maxhandle:"-",reverthandle:"-",hidehandle:"-",closehandle:"-",movehandle:"-"};
			data = $.extend(data,objData);
			var patt = data.maxhandle+","+data.reverthandle+","+data.hidehandle+","+data.closehandle
			obj.on("mousedown",patt,function(){
				HROS.window.show2top(obj.attr('appid'));
				return false;
			});
			obj.on('dblclick', data.movehandle, function(e){
				//判断当前窗口是否已经是最大化
				if(obj.find(data.maxhandle).is(':hidden')){
					obj.find(data.reverthandle).click();
				}else{
					obj.find(data.maxhandle).click();
				}
			}).on('click', data.hidehandle, function(){
				HROS.window.hide(obj.attr('appid'));
			}).on('click', data.maxhandle, function(){
				HROS.window.max(obj.attr('appid'));
				obj.find(data.reverthandle).show();
				$(this).hide();
			}).on('click', data.reverthandle, function(){
				HROS.window.revert(obj.attr('appid'));
				obj.find(data.maxhandle).show();
				$(this).hide();
			}).on('click', data.closehandle, function(){
				HROS.window.close(obj.attr('appid'));
			});
		},
		move : function(obj){
			obj.on('mousedown', '.title-bar', function(e){
				if(obj.attr('ismax') == 1){
					return false;
				}
				HROS.window.show2top(obj.attr('appid'));
				var windowdata = obj.data('info'), lay, x, y;
				x = e.clientX - obj.offset().left;
				y = e.clientY - obj.offset().top;
				//绑定鼠标移动事件
				$(document).on('mousemove', function(e){
					lay = HROS.maskBox.desk();
					lay.show();
					//强制把右上角还原按钮隐藏，最大化按钮显示
					obj.find('.ha-revert').hide().prev('.ha-max').show();
					_l = e.clientX - x ;
					_t = e.clientY - y - HROS.CONFIG.headerHeight;
					_w = windowdata['width'];
					_h = windowdata['height'];
					//窗口贴屏幕顶部10px内 || 底部60px内
					//加上header高度
					_t = _t <= 10 ? 0 : _t >= lay.height()-30 - HROS.CONFIG.headerHeight ? lay.height()-30 - HROS.CONFIG.headerHeight : _t;
					obj.css({
						width : _w,
						height : _h,
						left : _l,
						top : _t 
					});
					obj.data('info').left = _l;
					obj.data('info').top = _t;
//					obj.data('info').left = obj.offset().left;
//					obj.data('info').top = obj.offset().top;
				}).on('mouseup', function(){
					$(this).off('mousemove').off('mouseup');
					if(typeof(lay) !== 'undefined'){
						lay.hide();
					}
				});
			});
		},
		moveNoframe : function(obj,objData){
			obj.on('mousedown', objData.movehandle, function(e){
				if(obj.attr('ismax') == 1){
					return false;
				}
				HROS.window.show2top(obj.attr('appid'));
				var lay, x, y;
				x = e.clientX - obj.offset().left;
				y = e.clientY - obj.offset().top;
				//绑定鼠标移动事件
				$(document).on('mousemove', function(e){
					lay = HROS.maskBox.desk();
					lay.show();
					if(objData.maxhandle){
						//强制把右上角还原按钮隐藏，最大化按钮显示
						obj.find(objData.reverthandle).hide().prev(objData.maxhandle).show();
					}
					_l = e.clientX - x ;
					_t = e.clientY - y - HROS.CONFIG.headerHeight;
					//窗口贴屏幕顶部10px内 || 底部30px内
					//加上header高度
					_t = _t <= 10 ? 0 : _t >= lay.height()-30 - HROS.CONFIG.headerHeight ? lay.height()-30 - HROS.CONFIG.headerHeight : _t;
					obj.css({
						left : _l,
						top : _t 
					});
					obj.data('info').left = _l;
					obj.data('info').top = _t;
				}).on('mouseup', function(){
					$(this).off('mousemove').off('mouseup');
					if(typeof(lay) !== 'undefined'){
						lay.hide();
					}
				});
			});
		},
		resize : function(obj,minWidth,minHeight){
			obj.find('div.window-resize').on('mousedown', function(e){
				//增加背景遮罩层
				var resizeobj = $(this), lay, x = e.clientX, y = e.clientY, w = obj.width(), h = obj.height(),_minWidth=HROS.CONFIG.windowMinWidth,_minHeight=HROS.CONFIG.windowMinHeight;
				if(minWidth){_minWidth=minWidth};
				if(minHeight){_minHeight=minHeight};
				y = y - HROS.CONFIG.headerHeight;
				$(document).on('mousemove', function(e){
					lay = HROS.maskBox.desk();
					lay.show();
					_x = e.clientX;
					_y = e.clientY - HROS.CONFIG.headerHeight;
					//当拖动到屏幕边缘时，自动贴屏
					_x = _x <= 10 ? 0 : _x >= (lay.width()-12) ? (lay.width()-2) : _x;
					_y = _y <= 10 ? 0 : _y >= (lay.height()-12) ? lay.height() : _y;
					switch(resizeobj.attr('resize')){
						case 't':
							h + y - _y > _minHeight ? obj.css({
								height : h + y - _y,
								top : _y
							}) : obj.css({
								height : _minHeight
							});
							break;
						case 'r':
							w - x + _x > _minWidth ? obj.css({
								width : w - x + _x
							}) : obj.css({
								width : _minWidth
							});
							break;
						case 'b':
							h - y + _y > _minHeight ? obj.css({
								height : h - y + _y
							}) : obj.css({
								height : _minHeight
							});
							break;
						case 'l':
							w + x - _x > _minWidth ? obj.css({
								width : w + x - _x,
								left : _x
							}) : obj.css({
								width : _minWidth
							});
							break;
						case 'rt':
							h + y - _y > _minHeight ? obj.css({
								height : h + y - _y,
								top : _y
							}) : obj.css({
								height : _minHeight
							});
							w - x + _x > _minWidth ? obj.css({
								width : w - x + _x
							}) : obj.css({
								width : _minWidth
							});
							break;
						case 'rb':
							w - x + _x > _minWidth ? obj.css({
								width : w - x + _x
							}) : obj.css({
								width : _minWidth
							});
							h - y + _y > _minHeight ? obj.css({
								height : h - y + _y
							}) : obj.css({
								height : _minHeight
							});
							break;
						case 'lt':
							w + x - _x > _minWidth ? obj.css({
								width : w + x - _x,
								left : _x
							}) : obj.css({
								width : _minWidth
							});
							h + y - _y > _minHeight ? obj.css({
								height : h + y - _y,
								top : _y
							}) : obj.css({
								height : _minHeight
							});
							break;
						case 'lb':
							w + x - _x > _minWidth ? obj.css({
								width : w + x - _x,
								left : _x
							}) : obj.css({
								width : _minWidth
							});
							h - y + _y > _minHeightt ? obj.css({
								height : h - y + _y
							}) : obj.css({
								height : _minHeight
							});
							break;
					}
				}).on('mouseup',function(){
					if(typeof(lay) !== 'undefined'){
						lay.hide();
					}
					obj.data('info').width = obj.width();
					obj.data('info').height = obj.height();
					obj.data('info').left = obj.offset().left;
					obj.data('info').top = obj.offset().top - HROS.CONFIG.headerHeight;
					obj.data('info').emptyW = $(window).width() - obj.width();
					obj.data('info').emptyH = HROS.window.getDeskHeight() - obj.height();
					$(this).off('mousemove').off('mouseup');
				});
			});
		},
		filterAppid : function(o){
			if(typeof o == "string"){
				o = o.replace(/\s/g,"");
			}else if(o!=null && typeof o == "object" && o.appid!=null){
				if(typeof o.appid == "string"){
					o.appid = o.appid.replace(/\s/g,"");
				}
			}
			return o;
		}
	}
})();