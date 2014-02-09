<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		$(".osCtnUserTab").toggle(function(){
			$(".osCtnHandle").animate({
				left : 0
			}, 500, function() {
				$(".osTalkGroupIco").addClass("Selected");
				$(".osCtnUserIco").removeClass("Selected");
				$(".osCtnTalkListWrap").show();
				$(".osCtnUserListWrap").hide();
			
				
			});	
		},function(){
			$(".osCtnHandle").animate({
				left : 93
			}, 500, function() {
				$(".osCtnUserIco").addClass("Selected");
				$(".osTalkGroupIco").removeClass("Selected");
				$(".osCtnTalkListWrap").hide();
				$(".osCtnUserListWrap").show();
			});
		});
		$(".template_my_link h3").click(function(){
			$(this).siblings("ul").toggle();
		});
		 
		
	});
</script>
</head>
<body>
<div class="im_filter">
	<div class="imMain"
		style="top: 0px; left: 0px; width: 100%; height: 100%;">
		<!-- 联系人或公司 主面板; osWindowCurrent 当前状态 -->
		<div class="osConnectionWrap os_im_wedget_view"
			style="top: 0px; left: 0px; width: 315px; height: 100%;">
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
				<span class="osCtnTopTxt">一说</span>
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
								style="background-image: url(http://asset.gleasy.com/platform/os/assets/images/im/wwhead.png)"
								class="osCtnHead" alt=""
								src="http://www.gleasy.com/person/downloadAvatarAction.json?type=user&amp;avatarType=avatarSmall&amp;userId=117059&amp;rand=0.6494799712192137">
							<i class="wwOffLineMask" style="display: none;"></i> <i
								class="osCtnHeadShade"></i>
						</dt>
						<dd>
							<span key="osMenuShow" class="osCtnStatus"><i
								id="osCtnStatusIco" key="osMenuShow" class="osStsOnline"></i><i
								key="osMenuShow" class="osJib"></i>
								<div id="osCtnStatusList" class="osCtnStatusList wwTipBox ">
									<dl status="online">
										<dt>
											<b class="osStsOnline"></b>
										</dt>
										<dd>我在线上</dd>
									</dl>
									<dl status="away">
										<dt>
											<b class="osStsAfk"></b>
										</dt>
										<dd>离开</dd>
									</dl>
									<dl status="busy">
										<dt>
											<b class="osStsBusy"></b>
										</dt>
										<dd>忙碌</dd>
									</dl>
									<dl status="dnd">
										<dt>
											<b class="osStsDND"></b>
										</dt>
										<dd>请勿打扰</dd>
									</dl>
									<dl status="hiding">
										<dt>
											<b class="osStsHiding"></b>
										</dt>
										<dd>隐身</dd>
									</dl>
									<dl status="offline">
										<dt>
											<b class="osStsOffline"></b>
										</dt>
										<dd>离线</dd>
									</dl>
									<i class="osStsLine"></i>
									<dl status="setting">
										<dt>
											<i class="wwIco wwIco13"></i>
										</dt>
										<dd>设置</dd>
									</dl>
								</div> </span>
							<div class="osUserNameBox">
								<b class="osUsername">李香枝</b>
								<!-- <span class="osCtnStatusTxt">离线</span> -->
							</div>
						</dd>
						<dd>
							<div class="osUserSignBox">
								<p style="" id="signP" class="osUserSign osUserSignTxt"
									title="编辑个性签名">冰箱产品经理</p>
							</div>
							<button tabindex="-1" type="button" id="newTopicBtn"
								class="osCtnAddBtn">
								<i class="wwIco wwIco26"></i> <span class="oVam">新讨论组</span>
							</button>
						</dd>
					</dl>
				</div>
			</div>

			<div class="osCtnUserWrap">
				<div class="osCtnUserTabWrap">
					<div class="osCtnUserTab">
						<span title="最近消息" class="osTalkGroupIco ">最近消息</span> <span
							title="联系人" class="osCtnUserIco Selected">联系人</span>
						<div style="left:93px" class="osCtnHandle ui-draggable"></div>
					</div>
				</div>

				<!-- 搜索 -->
				<div class="osCtnSearchWrap">
					<div class="osCtnSearchBox">
						<input type="text" class="osCtnSearchIpt" placeholder="搜索讨论组"
							name="">
					</div>
					<input type="button" id="searchBtn" class="osCtnSchBtn" name="">
					<input type="button" style="display: none;" id="cancelSearchBtn"
						class="osCtnSchBtn osCtnSchCloseBtn" name="">
				</div>

				<!-- 讨论组列表 -->
				<div  style="display: none;" class="osCtnTalkListWrap osCtnTabContent os_im_wedget_topic_list_div jScrollPaneContainer">
					<div templateid="topicList" viewid="{viewId}" style="display: none"
						class="osCtnTalkList">
						<!-- 一个讨论组dl.osTalkItem -->
						<dl draggable="true" roomid="{roomId}" uptid="{uptId}"
							topicid="{topicId}" templateid="topicLine" style="display: none"
							class="osTalkItem">
							<dt class="fl">
								<!-- <input name="topicItem" type="checkbox" value="" /> -->
								<i class="wwIco wwFormCheck_default" name="topicItem"></i>
								<!-- 还有一种状态，wwFormCheck_checked -->
								<i op="shield" class="{isShield}"></i>
							</dt>
							<dd class="osTalkItemDd">
								<div class="osTalkItemTitle">
									<b title="{title}" class="osTalkItemTitleTxt">{title}</b>
									<p class="fr">
										<i op="star" class="{isStar}"></i> <i op="access"
											class="osTalkAccess"></i> <em class="osTalkNum">{unreadMsgNum}</em>
									</p>
									<a href="javascript:;" title="从最近消息列表移除" op="remove"
										class="wwChatTipClose"></a>
								</div>
								<p class="osTalkLast">
									<span class="fl lastMsgSummary">{lastMsgSummary}</span> <span
										class="osTalkLastTime fr lastMsgCreateTime">{lastMsgCreateTime}</span>
								</p>
							</dd>
						</dl>
						<!-- 私聊 -->
						<dl uid="{uid}" topicid="{topicId}" templateid="pchatLine"
							style="display: none" class="osTalkItem">
							<dt class="osTalkHeadBox fl">
								<span class="osTalkHead"></span> <i op="shield"
									class="{isShield}"></i> <i class="wwOffLineMask"></i> <b
									style="display: none;" class="osStsIco" id="stat"></b>
							</dt>
							<dd class="osTalkItemDd">
								<div class="osTalkItemTitle">
									<b class="osTalkItemTitleTxt">{title}</b>
									<p class="fr">
										<!--i class="{isStar}" op="star"></i-->
										<i op="access" class="osTalkAccess"></i> <em class="osTalkNum">{unreadMsgNum}</em>
									</p>
									<a href="javascript:;" title="从最近消息列表移除" op="remove"
										class="wwChatTipClose"></a>
								</div>
								<p class="osTalkLast">
									<span class="fl lastMsgSummary">{lastMsgSummary}</span> <span
										class="osTalkLastTime fr lastMsgCreateTime">{lastMsgCreateTime}</span>
								</p>
							</dd>
						</dl>
					</div>
					<div templateid="topicList" viewid="activeTopics" style=""
						class="osCtnTalkList">
						<dl uid="117060" topicid="13069" templateid="pchatLine" style=""
							class="osTalkItem imClose">
							<dt class="osTalkHeadBox fl">
								<img class="osTalkHead"
									src="http://www.gleasy.com/person/downloadAvatarAction.json?avatarType=avatarSmall&amp;type=card&amp;cardId=297867&amp;default=1&amp;version=1366200852000&amp;sv=1.0">
								<i op="shield" class="osTalkEnable"></i> <i
									class="wwOffLineMask"></i> <b style="display: none;"
									class="osStsIco" id="stat"></b>
							</dt>
							<dd class="osTalkItemDd">
								<div class="osTalkItemTitle">
									<b class="osTalkItemTitleTxt">(订舱经理)杨桦</b>
									<p class="fr">
										<!--i class="osTalkStarOff" op="star"></i-->
										<i op="access" class="osTalkAccess" style="display: none;"></i>
										<em class="osTalkNum" style="display: none;">0</em>
									</p>
									<a href="javascript:;" title="从最近消息列表移除" op="remove"
										class="wwChatTipClose"></a>
								</div>
								<p class="osTalkLast">
									<span class="fl lastMsgSummary"></span> <span
										class="osTalkLastTime fr lastMsgCreateTime">04/19
										13:14:05</span>
								</p>
							</dd>
						</dl>
						<dl uid="117060" topicid="13069" templateid="pchatLine" style=""
							class="osTalkItem imClose">
							<dt class="osTalkHeadBox fl">
								<img class="osTalkHead"
									src="http://www.gleasy.com/person/downloadAvatarAction.json?avatarType=avatarSmall&amp;type=card&amp;cardId=297867&amp;default=1&amp;version=1366200852000&amp;sv=1.0">
								<i op="shield" class="osTalkEnable"></i> <i
									class="wwOffLineMask"></i> <b style="display: none;"
									class="osStsIco" id="stat"></b>
							</dt>
							<dd class="osTalkItemDd">
								<div class="osTalkItemTitle">
									<b class="osTalkItemTitleTxt">(商务经理)林青</b>
									<p class="fr">
										<!--i class="osTalkStarOff" op="star"></i-->
										<i op="access" class="osTalkAccess" style="display: none;"></i>
										<em class="osTalkNum" style="display: none;">0</em>
									</p>
									<a href="javascript:;" title="从最近消息列表移除" op="remove"
										class="wwChatTipClose"></a>
								</div>
								<p class="osTalkLast">
									<span class="fl lastMsgSummary"></span> <span
										class="osTalkLastTime fr lastMsgCreateTime">04/19
										13:14:05</span>
								</p>
							</dd>
						</dl>
						<dl uid="117060" topicid="13069" templateid="pchatLine" style=""
							class="osTalkItem imClose">
							<dt class="osTalkHeadBox fl">
								<img class="osTalkHead"
									src="http://www.gleasy.com/person/downloadAvatarAction.json?avatarType=avatarSmall&amp;type=card&amp;cardId=297867&amp;default=1&amp;version=1366200852000&amp;sv=1.0">
								<i op="shield" class="osTalkEnable"></i> <i
									class="wwOffLineMask"></i> <b style="display: none;"
									class="osStsIco" id="stat"></b>
							</dt>
							<dd class="osTalkItemDd">
								<div class="osTalkItemTitle">
									<b class="osTalkItemTitleTxt">(工厂排产员)孙坚</b>
									<p class="fr">
										<!--i class="osTalkStarOff" op="star"></i-->
										<i op="access" class="osTalkAccess" style="display: none;"></i>
										<em class="osTalkNum" style="display: none;">0</em>
									</p>
									<a href="javascript:;" title="从最近消息列表移除" op="remove"
										class="wwChatTipClose"></a>
								</div>
								<p class="osTalkLast">
									<span class="fl lastMsgSummary"></span> <span
										class="osTalkLastTime fr lastMsgCreateTime">04/19
										13:14:05</span>
								</p>
							</dd>
						</dl>
						<dl uid="117060" topicid="13069" templateid="pchatLine" style=""
							class="osTalkItem imClose">
							<dt class="osTalkHeadBox fl">
								<img class="osTalkHead"
									src="http://www.gleasy.com/person/downloadAvatarAction.json?avatarType=avatarSmall&amp;type=card&amp;cardId=297867&amp;default=1&amp;version=1366200852000&amp;sv=1.0">
								<i op="shield" class="osTalkEnable"></i> <i
									class="wwOffLineMask"></i> <b style="display: none;"
									class="osStsIco" id="stat"></b>
							</dt>
							<dd class="osTalkItemDd">
								<div class="osTalkItemTitle">
									<b class="osTalkItemTitleTxt">(产品经理)徐先强</b>
									<p class="fr">
										<!--i class="osTalkStarOff" op="star"></i-->
										<i op="access" class="osTalkAccess" style="display: none;"></i>
										<em class="osTalkNum" style="display: none;">0</em>
									</p>
									<a href="javascript:;" title="从最近消息列表移除" op="remove"
										class="wwChatTipClose"></a>
								</div>
								<p class="osTalkLast">
									<span class="fl lastMsgSummary"></span> <span
										class="osTalkLastTime fr lastMsgCreateTime">04/19
										13:14:05</span>
								</p>
							</dd>
						</dl>
						<!-- 一个讨论组dl.osTalkItem -->
						<dl draggable="true" roomid="{roomId}" uptid="{uptId}"
							topicid="{topicId}" templateid="topicLine" style="display: none"
							class="osTalkItem">
							<dt class="fl">
								<!-- <input name="topicItem" type="checkbox" value="" /> -->
								<i class="wwIco wwFormCheck_default" name="topicItem"></i>
								<!-- 还有一种状态，wwFormCheck_checked -->
								<i op="shield" class="{isShield}"></i>
							</dt>
							<dd class="osTalkItemDd">
								<div class="osTalkItemTitle">
									<b title="{title}" class="osTalkItemTitleTxt">{title}</b>
									<p class="fr">
										<i op="star" class="{isStar}"></i> <i op="access"
											class="osTalkAccess"></i> <em class="osTalkNum">{unreadMsgNum}</em>
									</p>
									<a href="javascript:;" title="从最近消息列表移除" op="remove"
										class="wwChatTipClose"></a>
								</div>
								<p class="osTalkLast">
									<span class="fl lastMsgSummary">{lastMsgSummary}</span> <span
										class="osTalkLastTime fr lastMsgCreateTime">{lastMsgCreateTime}</span>
								</p>
							</dd>
						</dl>
						<!-- 私聊 -->
						<dl uid="{uid}" topicid="{topicId}" templateid="pchatLine"
							style="display: none" class="osTalkItem">
							<dt class="osTalkHeadBox fl">
								<span class="osTalkHead"></span> <i op="shield"
									class="{isShield}"></i> <i class="wwOffLineMask"></i> <b
									style="display: none;" class="osStsIco" id="stat"></b>
							</dt>
							<dd class="osTalkItemDd">
								<div class="osTalkItemTitle">
									<b class="osTalkItemTitleTxt">{title}</b>
									<p class="fr">
										<!--i class="{isStar}" op="star"></i-->
										<i op="access" class="osTalkAccess"></i> <em class="osTalkNum">{unreadMsgNum}</em>
									</p>
									<a href="javascript:;" title="从最近消息列表移除" op="remove"
										class="wwChatTipClose"></a>
								</div>
								<p class="osTalkLast">
									<span class="fl lastMsgSummary">{lastMsgSummary}</span> <span
										class="osTalkLastTime fr lastMsgCreateTime">{lastMsgCreateTime}</span>
								</p>
							</dd>
						</dl>
					</div>
					<div templateid="topicList" viewid="otherTopics"
						style="display: none" class="osCtnTalkList">
						<!-- 一个讨论组dl.osTalkItem -->
						<dl draggable="true" roomid="{roomId}" uptid="{uptId}"
							topicid="{topicId}" templateid="topicLine" style="display: none"
							class="osTalkItem">
							<dt class="fl">
								<!-- <input name="topicItem" type="checkbox" value="" /> -->
								<i class="wwIco wwFormCheck_default" name="topicItem"></i>
								<!-- 还有一种状态，wwFormCheck_checked -->
								<i op="shield" class="{isShield}"></i>
							</dt>
							<dd class="osTalkItemDd">
								<div class="osTalkItemTitle">
									<b title="{title}" class="osTalkItemTitleTxt">{title}</b>
									<p class="fr">
										<i op="star" class="{isStar}"></i> <i op="access"
											class="osTalkAccess"></i> <em class="osTalkNum">{unreadMsgNum}</em>
									</p>
									<a href="javascript:;" title="从最近消息列表移除" op="remove"
										class="wwChatTipClose"></a>
								</div>
								<p class="osTalkLast">
									<span class="fl lastMsgSummary">{lastMsgSummary}</span> <span
										class="osTalkLastTime fr lastMsgCreateTime">{lastMsgCreateTime}</span>
								</p>
							</dd>
						</dl>
						<!-- 私聊 -->
						<dl uid="{uid}" topicid="{topicId}" templateid="pchatLine"
							style="display: none" class="osTalkItem">
							<dt class="osTalkHeadBox fl">
								<span class="osTalkHead"></span> <i op="shield"
									class="{isShield}"></i> <i class="wwOffLineMask"></i> <b
									style="display: none;" class="osStsIco" id="stat"></b>
							</dt>
							<dd class="osTalkItemDd">
								<div class="osTalkItemTitle">
									<b class="osTalkItemTitleTxt">{title}</b>
									<p class="fr">
										<!--i class="{isStar}" op="star"></i-->
										<i op="access" class="osTalkAccess"></i> <em class="osTalkNum">{unreadMsgNum}</em>
									</p>
									<a href="javascript:;" title="从最近消息列表移除" op="remove"
										class="wwChatTipClose"></a>
								</div>
								<p class="osTalkLast">
									<span class="fl lastMsgSummary">{lastMsgSummary}</span> <span
										class="osTalkLastTime fr lastMsgCreateTime">{lastMsgCreateTime}</span>
								</p>
							</dd>
						</dl>
					</div>
				</div>
				<!-- 联系人列表 -->
				<div 
					class="osCtnUserListWrap osCtnTabContent os_im_wedget_linkandorg_div jScrollPaneContainer">
					<!-- 好友分组模板 -->
					<div style="display: none" class="item template_my_link">
						<h3>
							<i>{group_name}</i>[<span style="display: inline;"
								class="group_online_friend">0</span>/<span
								style="display: inline;" class="group_total_friend">{total}</span>]
						</h3>
						<ul style="display: none" groupid="{group_id}">

						</ul>
					</div>
					<!-- 好友分组模板end -->

					<!-- div.item  组织模板部门  如果是子部门，需要加上itemchild，去掉item class  -->
					<li style="display: none;" class="item template_my_org">
						<h3 deptid="{keyid}">
							<span style="display: inline;" class="deptName">{name}</span> [<span
								style="display: inline;" class="group_online_friend">0</span>/<span
								style="display: inline;" class="group_total_friend">0</span>] <i
								class="my_link_hover"></i>
						</h3>
						<ul deptid="{keyid}" style="display: none;">
						</ul>
					</li>

					<!-- li.itemchild 子级列表，现在不需要了 -->
					<!-- <li class="itemchild template_my_sub_org" style="display:none">
	    				<h3 class="open" deptId={keyid}><span class="deptName" style="display:inline;">{name}</span>[<span class="group_online_friend" style="display:inline;">0</span>/<span class="group_total_friend" style="display:inline;">0</span>]
	    					<i class="my_link_hover"></i>
	    				</h3>
	    				<ul style="display:block" deptId="{keyid}">
	    				</ul>
	    			</li> -->
					<!-- 组织模板end -->


					<div class="osCtnUserList">
						<!-- 所有连接 -->
						<div style="" id="allLinkView"
							class="addr_alllink rootGroup addr_alllink_h4_hide">
							<h4 ref="links" style="display:;" id="linksTitle">
								<s class="addr_all_btn"></s><span>所有好友</span>[<span
									style="display: inline;" class="group_online_friend">0</span>/<span
									style="display: inline;" class="group_total_friend">1</span>]
							</h4>
							<!-- div.item  所有连接一级类别 -->
							<div style="" class="item template_my_link">
								<h3>
									<i>默认</i>[<span style="display: inline;"
										class="group_online_friend">0</span>/<span
										style="display: inline;" class="group_total_friend">1</span>]
								</h3>
								<ul style="display: none" groupid="348272">

									<li draggable="true" priority="2" status="offline"
										cardid="297867" uid="117060"
										class="item template_my_link_halt" style="">
										<div class="osHeadBox">
											<img class="osHead"
												src="http://www.gleasy.com/person/downloadAvatarAction.json?avatarType=avatarSmall&amp;type=card&amp;cardId=297867&amp;default=1&amp;version=1366200852000&amp;sv=1.0">
											<i class="wwOffLineMask"></i>
										</div> <span name="userName"><i>(订舱经理)杨桦</i><em
											class="osSign" name="sign"></em></span> <i class="osItemSts "
										name="status"></i> <i class="my_link_hover"></i>
									</li>
								</ul>
							</div>
							<div style="" class="item template_my_link">
								<h3>
									<i>示例名片夹</i>[<span style="display: inline;"
										class="group_online_friend">0</span>/<span
										style="display: inline;" class="group_total_friend">0</span>]
								</h3>
								<ul style="display: none" groupid="348273">

								</ul>
							</div>
						</div>
					</div>
				</div>

			</div>
			<div class="osCtnBtm">
			</div>
			<!-- 讨论组分组 -->
			<div class="osCtnGroupListMenu">
				<div class="osCtnGroupListScrollWrap jScrollPaneContainer">
				</div>
			</div>


		</div>
	</div>
</div>
</body>
</html>