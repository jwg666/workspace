<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
									src="${staticURL}/IM/stylesheets/im/images/defaultHead_60_60.png">
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
									src="${staticURL}/IM/stylesheets/im/images/defaultHead_60_60.png">
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
									src="${staticURL}/IM/stylesheets/im/images/defaultHead_60_60.png">
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
									src="${staticURL}/IM/stylesheets/im/images/defaultHead_60_60.png">
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