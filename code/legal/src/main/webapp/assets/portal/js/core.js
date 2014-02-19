/*
**  legalOS桌面应用框架
*/

var version   = '2.1.1';        //版本号
var ajaxUrl   = '/legal/portal/portalAction/ajax.do';     //所有ajax操作指向页面
var zoomlevel = 1;
var TEMP      = {};
var HROS      = {};

HROS.CONFIG = {
	memberID        : 0,        //用户id
	desk            : 6,        //当前显示桌面
	dockPos         : 'top',    //应用码头位置，参数有：top,left,right
	appXY           : 'x',      //图标排列方式，参数有：x,y
	appButtonTop    : 20,       //快捷方式top初始位置
	appButtonLeft   : 20,       //快捷方式left初始位置
	createIndexid   : 1,        //z-index初始值
	windowMinWidth  : 215,      //窗口最小宽度
	windowMinHeight : 59,       //窗口最小高度
	wallpaper       : '',       //壁纸
	wallpaperWidth  : 0,        //壁纸宽度
	wallpaperHeight : 0,        //壁纸高度
	wallpaperType   : '',       //壁纸显示类型，参数有：tianchong,shiying,pingpu,lashen,juzhong
	wallpaperState  : 1 ,        //1系统壁纸 2自定义壁纸 3网络壁纸
	//-----------------------自定义------------------------
	headerHeight    : 46,
	dockBarWidth    : 330,
//	暂时不使用
	deskHeaderHeight:0,
//	暂时不使用
	deskBottomHeight:0,
	desktopNavHeight:42,
	taskBarHeight	:32,
	//--------------------------------------------------
	deskLength		:5,
	deskHome		:6,
	//-----------------------------url---------------
	basicStaticUrl	:'/legal/assets',
	basicDynamicUrl	:'/legal',
	basicActionUrl	:'/legal/portal',
	downloadImage	:'/legal/portal/fileUploadAction/downloadImage.do?fileId=',
	//-------------------------------locale------------------
	locale : 'zh_CN'
};
/**
 * 设置ajax的默认参数
 */
$.ajaxSetup({
	type : 'POST',
	dataType:'json',
	cache: false
});
