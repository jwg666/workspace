<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		$(".osCtnUserTab").toggle(function(){
			$(".osCtnHandle").animate({
				left : '0%'
			}, 500, function() {
				$(".osTalkGroupIco").addClass("Selected");
				$(".osCtnUserIco").removeClass("Selected");
				$(".osCtnTalkListWrap").show();
				$(".osCtnUserListWrap").hide();
			
				
			});	
		},function(){
			$(".osCtnHandle").animate({
				left : '40%'
			}, 500, function() {
				$(".osCtnUserIco").addClass("Selected");
				$(".osTalkGroupIco").removeClass("Selected");
				$(".osCtnTalkListWrap").hide();
				$(".osCtnUserListWrap").show();
			});
		});
		$(".template_my_link h3").click(function(){
			var childUl=$(this).siblings("ul").toggle();
			childUl.find("li").toggle();
		});
		$(".osCtnUserList .template_my_link_halt").on("dblclick",openChart);
	});
</script>
</head>
<body>
<div class="im_filter">
	<div class="imMain"
		style="top: 0px; left: 0px; width: 100%; height: 100%;">
		<!-- 联系人或公司 主面板; osWindowCurrent 当前状态 -->
		<div class="osConnectionWrap os_im_wedget_view"
			style="top: 0px; left: 0px; width: 100%; height: 100%;">
			<!-- 修改和删除分组menu -->
			<div style="display: none" class="dropmenu modifyGroupMenu"
				id="modifyGroupMenuLeft">
				<ul>
					<li key="modifyGroupBtn" id="modifyGroupBtn">编辑</li>
					<li key="deleteGroupBtn" id="deleteGroupBtn">删除</li>
				</ul>
			</div>
			<!-- 拖动resize, osConnectionWrap的宽度和 osCtnTabContent的高度-->
			<i class="osConnectionResizeBtn"></i>
			<div style="margin: 0; left: 64px; top: 58px; display: none;"
				class="msgtip" id="opMsgDiv">
				<span id="opMsg"></span> <a href="javascript:;" class="msgtipclose"></a>
			</div>
			<div class="osConnectionTop">
				<div class="osCtnTopBg"></div>
				<span class="osCtnTopTxt">在线说说</span>
				<div class="osCtnTopBtn">
					<!-- <i class="osCtnSeparate"></i>
                <a title="最小化" class="osCtnBtn" href="###"><i class="osCtnHideIco"></i></a>
                <i class="osCtnSeparate"></i>
                <a title="退出" class="osCtnExit" href="###"><i class="osCtnExitIco"></i></a> -->

					<div class="oWindowBtnBar">
						<a href="javascript:;" class="oWinBtn oWinMin" title="最小化"></a>
					</div>
				</div>
				<div class="osCtnStatusWrap">
					<dl>
						<dt>
							<!-- 头像url放到style里 style="background-image:url(style/images/wwhead.png)",40*40 -->
							<img
								style="background-image: url(${staticURL}/IM/stylesheets/im/images/defaultHead_60_60.png)"
								class="osCtnHead" alt=""
								src="${staticURL}/IM/stylesheets/im/images/defaultHead_60_60.png">
							<i class="wwOffLineMask" style="display: none;"></i> <i
								class="osCtnHeadShade"></i>
						</dt>
						<dd>
							<div class="osUserNameBox">
								<b class="osUsername"><s:property value="#session['_user_name']"/></b>
								<!-- <span class="osCtnStatusTxt">离线</span> -->
							</div>
						</dd>
						<dd>
							<div class="osUserSignBox">
								<p style="" id="signP" class="osUserSign osUserSignTxt"
									title="权限"> </p>
							</div>
							<!-- <button tabindex="-1" type="button" id="newTopicBtn"
								class="osCtnAddBtn">
								<i class="wwIco wwIco26"></i> <span class="oVam">新讨论组</span>
							</button> -->
						</dd>
					</dl>
				</div>
			</div>

			<div class="osCtnUserWrap">
				<%@include file="_osCtnTalkListWrap.jsp" %>
				<%@include file="_osCtnUserListWrap.jsp" %>
			</div>
			<div class="osCtnBtm"></div>

		</div>
	</div>
</div>
</body>
</html>