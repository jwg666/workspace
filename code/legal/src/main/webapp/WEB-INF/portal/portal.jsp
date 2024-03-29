<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>法律援助系统</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="${staticURL}/portal/js/HoorayLibs/hooraylibs.css"/>
<link rel="stylesheet" href="${staticURL}/portal/img/ui/index.css?v=${jsCssVersion}"/>
<link rel="stylesheet" href="${staticURL}/portal/img/skins/${memberQuery.skin}.css" id="window-skin"/>
<script src="${staticURL}/portal/js/jquery-1.8.3.min.js"></script>
<script src="${staticURL}/portal/js/HoorayLibs/hooraylibs.js"></script>
<script src="${staticURL}/portal/js/util.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/core.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/templates.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.app.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.appmanage.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.base.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.desktop.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.dock.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.folderView.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.grid.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.maskBox.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.navbar.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.popupMenu.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.taskbar.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.uploadFile.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.wallpaper.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.widget.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.window.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.im.js?v=${jsCssVersion}"></script>
<script src="${staticURL}/portal/js/hros.zoom.js"></script>
<script src="${staticURL}/portal/js/artDialog4.1.6/jquery.artDialog.js?skin=default"></script>
<script src="${staticURL}/portal/js/artDialog4.1.6/plugins/iframeTools.js"></script>
<script src="${staticURL}/scripts/baiduTemplate.js"></script>
<script type='text/javascript' src='${dynamicURL}/dwr/engine.js'></script>  
<script type='text/javascript' src='${dynamicURL}/dwr/util.js'></script>  
<script type="text/javascript" src="${dynamicURL}/dwr/interface/portalPush.js"></script>
<link rel="stylesheet" href="${staticURL}/IM/stylesheets/os/os-style_bak.css?v=${jsCssVersion}"/>
<link rel="stylesheet" href="${staticURL}/IM/stylesheets/im/im_bak.css?v=${jsCssVersion}"/>

</head>

<body >
<s:if test="%{memberQuery.desknum && memberQuery.desknum > 0 }">
	<s:set var="desknum" value="%{memberQuery.desknum}" />
</s:if>
<s:else>
	<s:set var="desknum" value="3" />
</s:else>

<div class="loading"></div>
<!-- 桌面 -->
<div id="desktop">
	<div id="zoom-tip"><div><i>​</i>​<span></span></div><a href="javascript:;" class="close" onClick="HROS.zoom.close();">×</a></div>
    <div id="header" class="head" style="height:46px;position: absolute; width:100%;z-index: 2">
    	<div class="head-body">
            <div class="head-body-l"></div>
            <div class="head-body-b">
               <div class="l-logo"><div class="l-head">法律援助综合信息平台</div></div>
               <div class="head-body-b-float">
	               <div class="b-button b-button-01">
	                   <div class="button-left">&nbsp;</div>
	                   <div class="button-right">&nbsp;</div>
	                   <a href="#">
	                   	<div class="button-bg">
	                         <span class="bg-01"><s:property value="#session['_user_name']"/></span>
	                   </div>
	                   </a>
	                   
	               </div>
	               <div class="b-button b-button-02">
	                   <div class="button-left">&nbsp;</div>
	                   <div class="button-right">&nbsp;</div>
	                   <a href="javascript:;" id="openMarket">
	                   	<div class="button-bg">
	                         <span class="bg-02">应用超市</span>
	                   	</div>
	                   </a>
	               </div>
	               <div class="b-button b-button-03">
	                   <div class="button-left">&nbsp;</div>
	                   <div class="button-right">&nbsp;</div>
	                   <a href="${dynamicURL}/security/logout.do"><div class="button-bg">
	                         <span class="bg-03">退出</span>
	                   </div></a>
	               </div>
               </div>
	         </div>
	         <div class="head-body-r">&nbsp;</div>
    	</div>
    </div>
	<div id="desk" style="top:46px;">
    	<!-- <div id="desk-header" style="background-color:#CCC; height:40px;position: absolute;">desh头部</div> -->
		<div id="desk-6" class="desktop-container nomove">
			<div class="scrollbar scrollbar-x"></div><div class="scrollbar scrollbar-y"></div>
			<div id="homeContainer">
				<div class="main-content">
					<div class="main-content-navi">
						<div class="nav-hc">
							<div class="handdle-left-hc" ><a href="javascript:void(0)">&nbsp;</a></div>
							<div class="handdle-right-hc" ><a href="javascript:void(0)">&nbsp;</a></div>
							
							<ul id="todotasks">
							<!-- 待办列表demo start-->
                                <li  src="../legal/legalAction!stepOne.do" resName="法律援助申请" resIcon="" resH="20"  resW="20" resid="0"  id="resource_0">
                                    <div class="main-content-navi-icon">
                                        <img width="35px" height="35px" src="${staticURL}/portal/img/images/content-icon8.png" />
                                        <div class="live-tip no-background-image"></div>
                                    </div>
                                    <div class="main-content-navi-icontext">法律援助申请</div>
                                    <div class="navi-selected-icon"></div>
                                </li>
							    <li  src="../legal/legalApproveAction!goTaskList.do" resName="案件审核" resIcon="" resH="20"  resW="20" resid="1"  id="resource_1">
								 <div class="main-content-navi-icon">
								 <img width="35px" height="35px" src="${staticURL}/portal/img/images/content-icon1.png" />
										<div class="live-tip no-background-image"></div>
									</div>
									<div class="main-content-navi-icontext">案件审核</div>
									<div class="navi-selected-icon"></div>
								</li>
								<li  src="../legal/legalAction!asignLegalOfficeTaskList.do" resName="指派律师事务所" resIcon="" resH="20"  resW="20" resid="2"  id="resource_2">
								 <div class="main-content-navi-icon"><img width="35px" height="35px" src="${staticURL}/portal/img/images/content-icon9.png" />
										<div class="live-tip no-background-image"></div>
									</div>
									<div class="main-content-navi-icontext">指派律师事务所</div>
									<div class="navi-selected-icon"></div>
								</li>
								<li  src="../legal/legalAction!accessCaseTaskList.do" resName="事务所受理案件" resIcon="" resH="20"  resW="20" resid="3"  id="resource_3">
								 <div class="main-content-navi-icon"><img width="35px" height="35px" src="${staticURL}/portal/img/images/content-icon7.png" />
										<div class="live-tip no-background-image"></div>
									</div>
									<div class="main-content-navi-icontext">事务所受理案件</div>
									<div class="navi-selected-icon"></div>
								</li>
								
								<li class="last-li"  src="../legal/legalAction!endCaseTaskList.do" resName="结案" resIcon="" resH="20"  resW="20" resid="5"  id="resource_5">
								 <div class="main-content-navi-icon"><img width="35px" height="35px" src="${staticURL}/portal/img/images/content-icon5.png" />
										<div class="live-tip no-background-image"></div>
									</div>
									<div class="main-content-navi-icontext">结案</div>
									<div class="navi-selected-icon"></div>
								</li>
							<!-- 待办列表demo end-->
								<!-- 待办列表start -->
								<!-- 
								<s:iterator value="%{resourceInfoList}" id='res' status='status'> 
								    <s:if test="#status.Last"> 
								    <li class="last-li"  src="${dynamicURL}<s:property value='url'/>"  resName="<s:property value='name'/>" resIcon="<s:property value='icon'/>" resH="<s:property value='height'/>"  resW="<s:property value='width'/>" resid="<s:property value='id'/>"  id="resource_<s:property value='id'/>" >
								    </s:if> 
								    <s:else>
								    <li  src="${dynamicURL}<s:property value='url'/>" resName="<s:property value='name'/>" resIcon="<s:property value='icon'/>" resH="<s:property value='height'/>"  resW="<s:property value='width'/>" resid="<s:property value='id'/>"  id="resource_<s:property value='id'/>">
								    </s:else>
								    <div class="main-content-navi-icon"><img width="35px" height="35px" src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=<s:property value='iconUrl'/>" />
										<div class="live-tip no-background-image"></div>
									</div>
									<div class="main-content-navi-icontext"><s:property value='name'/></div>
									<div class="navi-selected-icon"></div>
									</li>
								</s:iterator> 
								 -->
								<!--待办列表end  -->
							</ul>
						</div>
					</div>
					<div class="main-subnav">
						<div class="main-content-subnav">
						      <div class="subnav-hc" id="todosubtasks">
							      	<s:iterator value="%{resourceList}" id='res' status='status'> 
							      		<ul id="subResouceId_<s:property value='id'/>"  resid="<s:property value='id'/>">
							      			<s:iterator value="%{childResources}" id='r' status='status'>
							      				<li  src="${dynamicURL}<s:property value='url'/>" resName="<s:property value='localName'/>" resIcon="<s:property value='icon'/>" resH="<s:property value='height'/>"  resW="<s:property value='width'/>" resid="<s:property value='id'/>" id="subResource_<s:property value='id'/>" >
						            				<div class="count-subnav no-background-image"></div>
						            				<div class="text-subnav"><s:property value='localName'/></div>
						          				</li>
											</s:iterator> 
							      		</ul>
									</s:iterator> 
						      </div>
						</div>
					</div>
					<!-- iframe -->
					<div id="homeIframeContent" style="height:400px;width:100%;background-color: white;">
						<iframe id="homeIframe"  style="height:400px;width:100%; border:0 none;" src="" ></iframe>
					</div>
				</div>
			</div>
		</div>
		<s:bean name="org.apache.struts2.util.Counter" id="counter">
   			<s:param name="first" value="1" />
   			<s:param name="last" value="%{desknum}" /> 
   			<s:iterator>
				<div id="desk-<s:property/>" class="desktop-container">
					<div class="scrollbar scrollbar-x">
					</div>
					<div class="scrollbar scrollbar-y">
					</div>
				</div>
   			</s:iterator>
		</s:bean>
		<!-- 
		<div id="desk-bottom" style="background-color:#CCC; height:40px;position: absolute;">
			desk-底部
		</div> 
		-->
        <div id="dock-bar" class="right-bar" style="display: block;">
			<div id="dock-container" class="dock-right">
				<div class="widget-hub">							
						
				</div>
			</div>
		</div>
		
		<div id="desktop_nav" class="foot" style="height:42px;position: absolute; bottom:32px; width:100%;">
		<!--<div class="foot-body-b"> --> 
              	<div class="b-content" id="navContainer">
                           <div id="b-content-06">
                                <a href="#" index="6"><img src="${staticURL}/portal/img/images/home-b.png" /></a>
                                <a href="#" index="6" class="title-icon"><span>工作台</span></a>
                           </div>
                           <s:bean name="org.apache.struts2.util.Counter" id="counter">
   								<s:param name="first" value="1" />
					   			<s:param name="last" value="%{desknum}" /> 
					   			<s:iterator>
									<div id="b-content-0<s:property/>" class="deskNav">
									   <a href="#" index="<s:property/>"><img src="${staticURL}/portal/img/images/folder-b.png" /></a>
									   <a href="#" index="<s:property/>" class="title-icon" ><span><s:property value="%{memberQuery.desknames[current-2]}"/></span></a>
									</div>
					   			</s:iterator>
							</s:bean>
                          <div id="b-content-00">
                                <a href="#" class="indicator-manage" ><img src="${staticURL}/portal/img/images/all.png" /></a>
                                <a href="#" class="indicator-manage title-icon" ><span>全景图</span></a>
                          </div>
                          <div id="b-content-im">
                                <a href="#" class="web-im"><img src="${staticURL}/portal/img/images/ico_im.png" /></a>
                                <a href="#" class="web-im title-icon"><span>即时交流</span></a>
                          </div>
                          <div id="b-content-msg">
                          		<span class="num">0</span>
                                <a href="#" class="indicator-msg"><span class="b-content-msg-bg">&nbsp;</span></a>
                                <span class="tip">消息</span>
                          </div>
      			</div> 
        <!-- </div> -->
		</div>
			
	</div>
	<div id="task-bar-bg1"></div>
	<div id="task-bar-bg2"></div>
	<div id="task-bar">
		<div id="task-next"><a href="javascript:;" id="task-next-btn" hidefocus="true"></a></div>
		<div id="task-content">
			<div id="task-content-inner"></div>
		</div>
		<div id="task-pre"><a href="javascript:;" id="task-pre-btn" hidefocus="true"></a></div>
	</div>
</div>
<!-- 全局视图 -->
<div id="appmanage">
	<a class="amg_close" href="javascript:;"></a>
	<div id="amg_dock_container"></div>
	<div class="amg_line_x"></div>
	<div id="amg_folder_container">
		<s:bean name="org.apache.struts2.util.Counter" id="counter">
   			<s:param name="first" value="1" />
   			<s:param name="last" value="%{desknum}" /> 
   			<s:iterator id="id" >
   				<div class="folderItem">
					<div class="folder_bg folder_bg<s:property/>"></div>
					<div class="folderOuter">
						<div class="folderInner"></div>
						<div class="scrollBar"></div>
					</div>
					<s:if test="%{#id != 1}">
						<div class="amg_line_y"></div>
					</s:if>
				</div>
   			</s:iterator>
		</s:bean>
		
	</div>
</div>
	<!--开始######## easy样式引用专用图层################ 开始-->
	<div class="im_filter">
	
	<!--### 通知列表 ###### -->
		<!--class=oWinListMessageCenter -->
		<div id="msgCenter" style="width: 280px; z-index: 999; display: none; bottom:100px; right:5px;"
			class="oWinList  oWinListBottom  messageCenter">
			<h4 class="oWLTitle">消息中心</h4>
			<a class="oWLClose configBtn">关闭</a>
			<div class="oWLItembox">
				<div class="oWMsgList">
				</div>
			</div>
		</div>
		
		<!-- 即时通知详情 -->
		<div id="newNotice" style="width: 250px; right: 10px; bottom: 68px; z-index: 999; opacity: 1;display: none" class="oWinList oWinListBottom messageReminder">
    	<h4 class="oWLTitle">新通知</h4>
        <a href="#" style="display: inline;"  class="oDel"></a>
        <div class="oWLItembox">
            <div class="oWMsgList"><dl style="" class="oWMsg template_default">
                	<dt class="oWMsgdt">
                    	<img class="oWMsghead" src="${staticURL}/IM/stylesheets/im/images/noAvata.png" alt=""/>
                    </dt>
                    <dd class="oWMsgdd oWMsgddNew"  style='cursor:pointer'>
                    <input type="hidden" name="nodeUrl" />
                    <input type="hidden" name="id" />
                    <input type="hidden" name="nodeTitle" />
                    	<p  class="oWMsgauthor">[新任务]</p>
                        <p class="oWMsgbrief">loveslikey给您发了新任务</p>
                        <p class="wWMsgContent"><a  href="javascipt:void(0)">点击办理 </a></p>
                    	<a href="javascript:;" class="oDel"></a>
                    </dd>
	</dl></div>
      </div>
    </div>

	</div>
	<!--结束######## easy样式引用专用图层################ 结束-->


<script type="text/javascript">
var ajaxUrl   = '${dynamicURL}/portal/portalAction/ajax.do';     //所有ajax操作指向页面
/*设置basicUrl 以及 当前语言 */
HROS.CONFIG.locale = '${locale}';
HROS.CONFIG.deskLength = ${desknum};
HROS.CONFIG.basicDynamicUrl = '${dynamicURL}';
HROS.CONFIG.basicStaticUrl = '${staticURL}';
HROS.CONFIG.basicActionUrl = '${dynamicURL}/portal/portalAction';
HROS.CONFIG.downloadImage = '${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=';
var _id_ = 1;
$(function(){
	/*jquery mobile page不自动初始化 */
	$(document).bind("mobileinit", function(){
		$.extend( $.mobile , {autoInitializePage: false});
	});
	
	//IE下禁止选中
	document.body.onselectstart = document.body.ondrag = function(){return false;}
	
	$('.loading').hide();
	$('#desktop').show();
	//初始化
	HROS.base.init();
	//待办任务列表
	
	$("#desk-6 .main-content .main-subnav ul").on("click","li",function(){
		$("#todotasks li").removeClass("current-zoc");
		var id= $(this).parent().attr("resid");
		$("#todotasks #resource_"+id).addClass("current-zoc");
		$("#desk-6 .main-content .main-subnav ul li").removeClass("current");
		$(this).addClass("current");
		showTaskWindow(this);
	});
	$("#todotasks").off("click").on("click","li",function(){
		$("#todotasks li").removeClass("current-zoc");
		$(this).addClass("current-zoc");
		showTaskWindow(this);
	}).on("mouseenter","li",function(){
		var id = $(this).attr("resid");
		var left = $(this).offset().left;
		var rightLeft = $(".handdle-right-hc").offset().left;
		left = left - 5;
		$("#desk-6 .main-content .main-subnav").hide().css({marginLeft:left}).find("ul").hide();
		var width = $("#desk-6 .main-content .main-subnav").show().find("#subResouceId_"+id).show().width();
		if(left+(90*2)>rightLeft && width > 90){
			left = left - (width - 90);
		}
		if(HROS.CONFIG.dockPos == 'left'){
			left = left - HROS.CONFIG.dockBarWidth;
		}
		$("#desk-6 .main-content .main-subnav").css({marginLeft:left});
	}).on("mouseover",function(){
		return false;
	})
	$("#desk-6 .main-content .main-subnav").on("mouseover",function(){
		return false;
	})
	$("body").on("mouseover",function(){
		$("#desk-6 .main-content .main-subnav").hide().find("ul").hide();
	});
	//2秒后 请求taskCount
	setTimeout(showTaskCount,1000);
	//10分钟刷新taskCount
	setInterval(showTaskCount,600000);
	//10钟刷新在线用户
	//setInterval(refreshOnLineUser,1000*10);
	
	$("#newNotice .oDel").click(function(){
		$("#newNotice").slideUp("slow");
	});
	$(".oWLClose").click(function(){
		$("#msgCenter").slideUp("slow");
	});
	
	//设置左分隔符为 <!
	baidu.template.LEFT_DELIMITER='{%';

	//设置右分隔符为 <!  
	baidu.template.RIGHT_DELIMITER='%}';
	//取消dwr错误弹窗
	//dwr.engine._errorHandler = function(message, ex) {dwr.engine._debug("Error: " + ex.name + ", " + ex.message, true);};
	
});

function showTaskWindow(obj){
	var src = $(obj).attr("src");
	var g = /_blank$/;
	var gm = /_blank_max$/;
	var blank = false;
	var blankMax = false;
	if(g.test(src)){
		blank = true;
	}else if(gm.test(src)){
		blankMax = true;
	}
	if(blankMax || blank){
		var app = {"appid":"","folderId":0,"height":1000,"icon":"917","isflash":0,"isopenmax":blankMax?1:0,"isresize":1,"issetbar":1,"type":"app","url":"","width":1000};
		var  id = $(obj).attr("resid");
		var  name = $(obj).attr("resName");
		var width = $(obj).attr("resW");
		var height = $(obj).attr("resH");
		var icon = $(obj).attr("resIcon");
		icon = (icon==null && app.icon);
		app = $.extend(app,{appid:"res_"+id,title:name,width:width,height:height,icon:icon,url:src});
		app.imgsrc = HROS.CONFIG.downloadImage+app['icon'];
		HROS.window.createTemp(app);
	}else{
		$("#homeIframe").attr("src",src);
	} 
}

  function showMessage(content){
	  $.dialog({
			title: '您有一条新信息',
			width: 320,
			content: content
		});
  }
  var interval;
  function addNotice(notice){
	 
		var newNotice=$("#newNotice");
		/*显示新信息*/
		$("#newNotice [name='nodeUrl']").val(notice.nodeUrl);
		$("#newNotice [name='nodeTitle']").val(notice.nodeTitle);
		$("#newNotice [name='id']").val(notice.id);
		newNotice.find(".oWMsgauthor").html(notice.type);
		newNotice.find(".oWMsgbrief").html(notice.title);
		newNotice.find(".wWMsgContent").html(notice.content);
		newNotice.slideDown("normal");
		/*增加messageList*/
		var messageHtml=baidu.template('messageList_Template',notice);
		$("#msgCenter .oWMsgList").append(messageHtml);
		/*设置计数器*/
		var num=parseInt($(".num").text());
		$(".num").text(num+1);
		if(num+1>0){
			$(".num").show();
		}
		 if(interval){
			 clearTimeout(interval);  //关闭定时器   
		  }
		interval = setTimeout(function(){
			newNotice.slideUp("slow");
		}, "10000");   
		
		$(".oWMsgdd").click(function(){
			console.log($(this).html());
			var url=$(this).find("[name='nodeUrl']").val();
			var title=$(this).find("[name='nodeTitle']").val();
			taskDetail(title,url);
		});
		$(".oWMsgdd .oDel").click(function(){
			var id=$(this).siblings("[name='id']").val();
			$("#messageList_"+id).slideUp("normal",function(){
				$(this).remove();
				/*设置计数器*/
				var num=parseInt($(".num").text());
				$(".num").text(num-1);
				if(num-1==0){
					$(".num").hide();
					$("#msgCenter").hide();
				}
			});
			
			if($(this).hasClass('oWMsgddNew')){
				$("#newNotice").slideUp("slow");
			}
			return false;
		});
		
	}
  function removeNotice(taskIds){
	  for(var i=0;i<taskIds.length;i++){
	 	 $("#messageList_"+taskIds[i]+" .oDel").click();
	  }
  }
  
  function initPortalPush(){
	      portalPush.onPageLoad();
		 dwr.engine.setActiveReverseAjax(true);
	     dwr.engine.setNotifyServerOnPageUnload(true); 
	     console.log("已经与主机建立通信....");
	}
  
  function openIm(){
	  HROS.im.openIm();
  }
  
	function taskDetail(title,url) {
		window.HROS.window.createTemp({
		title:title,
		url:"${dynamicURL}/"+url,
		width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	//计算任务数量
	function showTaskCount(){		
		var resIds = "";
		$("#todotasks li,#todosubtasks ul li").each(function(){
			var id = $(this).attr("resid");
			resIds = resIds +   id + ",";
		})
		if(resIds.length > 1){
			$.ajax({
				 url:"${dynamicURL}/portal/taskCount.do",
			     data:{
			    	 resourceInfoIds:resIds,
			     },
			     dataType:"json",
			     type:'post',
			     success:function(data){
		 			if(data.success&&data.obj!=null){
		 				//给各自赋值
		 				for(var m in data.obj){
		 					if(data.obj[m]!=null && data.obj[m]>0){
			 					$("#resource_" + m + " .live-tip").html(data.obj[m]).removeClass("no-background-image");
			 					$("#subResource_" + m + " .count-subnav" ).html(data.obj[m]).removeClass("no-background-image");
		 					}else{
		 						$("#resource_" + m + " .live-tip").html("").addClass("no-background-image");
			 					$("#subResource_" + m + " .count-subnav" ).html("").addClass("no-background-image");
		 					}
		 				}
		 				//计算父节点数量
			 			$("#todosubtasks ul").each(function(){
			 				var id = $(this).attr("resid");
			 				var count = 0;
			 				$(this).find("li div.count-subnav").each(function(){
			 					var tempCount = $(this).html();
			 					if(tempCount.length>0){
			 						count = count+parseInt(tempCount);	
			 					}
			 				});
			 				if(count>0){
			 					$("#resource_" + id + " .live-tip").html(count).removeClass("no-background-image");
			 				}
			 			});
		 			}
			     }
			});	
		}
	
	}
</script>




<script type="text/javascript">
function refreshOnLineUser(){
	$.ajax({
		 url:"${dynamicURL}/im/imAction!refreshOnlinUser?"+new Date(),
	     dataType:"json",
	     type:'post',
	     success:function(userList){
	    	 for(var group_code in userList){
	 			var userMapList=userList[group_code];
	 			var data={"list":userMapList};
	 			var ul=$("#"+group_code);
	 			var display=ul.css("display");
	 			if("none"==display){
	 				data["display"]="none";
	 			}else{
	 				data["display"]="list-item";
	 			}
	 			var messageHtml=baidu.template('onLineUserList',data);
	 			ul.html(messageHtml);
	 			$("#"+group_code+"_count").html(ul.find("li").size());
	 			$(".osCtnUserList .template_my_link_halt").on("dblclick",openChart);
	 			
	 		}
	     }
	});
}
function openChart(){
	var message={};
	message["sendUserName"]=$(this).attr("userName");
	message["sendUsercode"]=$(this).attr("uid");
	message["sendUserId"]=$(this).attr("userId");
	var chartHtml=baidu.template('chartTemplate',message);
	HROS.window.createNoframeTemp({
		appid:"user_"+message["sendUsercode"],
		title:message["sendUserName"],
		content:chartHtml,
		//url:"${dynamicURL}/im/imAction!toChart?toUserId="+uid+"&toUserName="+name,
		ismask:false,
		isflash:false,
		isresize:true,
		width:650,
		height:450,
		movehandle:".wwTop",
		maxhandle:".oWinMax",
		reverthandle:".oWinRestore",
		closehandle:".oWinClose",
		hidehandle:".oWinMin",
		minWidth:360,
		minHeight:300
});
}
function sendMessage(toUserCode,toUserId){
	var message=$("#chatContent"+toUserCode).html();
	$("#chatContent"+toUserCode).html('');
	var data={'message':message,'toUserCode':toUserCode,"toUserId":toUserId};
	var messageHtml=baidu.template('msgTemplate',data);
	$("#wwChatListBox"+toUserCode).append(messageHtml);
	$("#wwChatListBox"+toUserCode).parent().scrollTop(999999);
	$.ajax({
		 url:"${dynamicURL}/im/imAction!sendMessage",
	     dataType:"json",
	     type:'post',
	     data:data,
	     success:function(){
	      console.log("发送成功");
	     }
	});
}

function receviedMessage(message){
	console.log("接收成功");
	var chart=$("#w_user_"+message.sendUsercode+"_noframe");
	if(chart.size()<1){
		var chartHtml=baidu.template('chartTemplate',message);
		HROS.window.createNoframeTemp({
			appid:"user_"+message.sendUsercode,
			title:message.sendUserName,
			//url:"${dynamicURL}/im/imAction!toChart?toUserId="+message.sendUsercode+"&toUserName="+message.sendUserName,
			content:chartHtml,
			ismask:false,
			isflash:false,
			isresize:true,
			width:600,
			height:450,
			movehandle:".wwTop",
			maxhandle:".oWinMax",
			reverthandle:".oWinRestore",
			closehandle:".oWinClose",
			hidehandle:".oWinMin",
			minWidth:360,
			minHeight:300
	});
	}
		HROS.window.show2top("user_"+message.sendUsercode);
		 chart=$("#w_user_"+message.sendUsercode+"_noframe");
			var messageHtml=baidu.template('replyTemplate',message);
			$("#wwChatListBox"+message.sendUsercode).append(messageHtml);
			$("#wwChatListBox"+message.sendUsercode).parent().scrollTop(999999);
	
}
</script>

</body>
</html>