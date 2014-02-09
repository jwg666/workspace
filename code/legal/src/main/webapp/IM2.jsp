<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title>Insert title here</title>

</head>
<body>
<div class="im_filter">
<div class="chatWin" style="top: 0px; left: 0px; width: 100%; height: 100%;"><!-- 聊天窗口开始 -->
<div class="wwWrap">
	<div style="margin:0;left:0px;top:60px;display:none;z-index:999;" class="msgtip" id="opMsgDiv">
       	<span id="opMsg"></span>
       	<a href="javascript:;" class="msgtipclose"></a>
   	</div>
   	<div style="margin:0;left:0px;top:60px;display:none;z-index:999;" class="msgtip" id="newFileShareTip">
   		<i class="msgtipico"></i>
       	<span id="opMsg">有新共享文件</span>
       	<a href="javascript:;" class="msgtipclose"></a>
   	</div>
   	<div style="display:none;top:0;left:0;" class="wwImgTip" id="pictureSaveAsBtn">
        <i class="wwIco wwImgAddFace"></i>
        <div class="fl">|</div>
        <i class="wwIco wwImgSave"></i>
    </div>
    <div style="display:none;top:0;left:0;" class="wwImgTip" id="pictureSaveAsInForwardBtn">
        <i class="wwIco wwImgAddFace"></i>
        <div class="fl">|</div>
        <i class="wwIco wwImgSave"></i>
    </div>
	<!-- 拖动改变窗口尺寸的按钮 -->
	<i class="osConnectionResizeBtn"></i>


	<!-- 聊天头部 -->
	<div class="wwTop">

		<div class="osCtnTopBg"></div>

		<div class="osCtnTopBtn">
			<div class="oWindowBtnBar">
				<a href="#" class="oWinBtn oWinMin" title="最小化"></a> 
				<a href="#" class="oWinBtn oWinMax" title="最大化"></a> 
				<a href="#" class="oWinBtn oWinRestore" title="还原"></a> 
				<a href="#" class="oWinBtn oWinClose" title="关闭"></a>
			</div>
		</div>
		<div class="wwWhisperHeadBox">
			<div class="wwWhisperHeader">
				<img class="wwWhisperHeaderImg" src="http://www.gleasy.com/person/downloadAvatarAction.json?avatarType=avatarSmall&amp;type=card&amp;cardId=297867&amp;default=1&amp;version=1366200852000&amp;sv=1.0">
				<i class="wwOffLineMask"></i>
				<b id="statusTip" class=""></b>
				<i style="display:none;" class="wwIco wwIcoWriting" id="writingTip"></i>
			</div>
            <div class="wwWhisperNameBox">
            	<b class="wwWhisperName">(订舱经理)杨桦</b>
            	<!-- <span class="wwWhisperSign" style="left:0px;">
            		<input readonly="readonly" class="wwWhsSi_s" title="" value="" />
            	</span> -->
            	<div style="left: 75px;" class="wwWhisperSign ableselect">
	                <span class="wwIptHolder">
	                    <input value="" title="" readonly="readonly" class="wwWhsSi_s">
	                    <s title="" class="wwIptCopy"></s>
	                </span>
	            </div>
            </div>
			<div class="wwTopBtnBox">
				<i style="display:none;" uid="117060" class="wwWhisperCardBtn wwIco wwIco21"></i>
			 	<ul style="display:none;left:9px;top:34px;" class="dropmenu loc_share_dropmenu">
                    <li class="loc_share_dropmenu_gcd">共享一盘文件</li>
                    <a class="wwFlashUploadBox"><li class="loc_share_dropmenu_local">共享本地文件</li></a>
                    <li class="loc_share_dropmenu_lookup">查看共享</li>
                    <li class="loc_share_dropmenu_setting">共享设置</li>
                </ul>
                <a id="showAttachment" class="wwTopBtn wwDropBtn loc_share" href="#">
                    <i class="wwIco wwIco02"></i>
                    <span>共享</span>
                    <span class="wwToolBarIcoJib">
                        <i class="wwIco fl"></i>
                    </span>
                </a>
				<a style="display:none;" id="voiceChat" class="wwTopBtn" href="#"><i class="wwIco wwIco23"></i>语音会话</a> 
				<a style="display:none;" id="videoChat" class="wwTopBtn" href="#"><i class="wwIco wwIco24"></i>视频会话</a> 
				<a id="newTopic" class="wwTopBtn" href="#"><i class="wwIco wwIco25"></i>新讨论组</a>
			</div>
		</div>
	</div>
	<!-- 左列 -->
	<div style="right: 170px" class="wwLeft wwLeftMsgtip-show">
		<!-- 聊天信息列表 -->
		<!-- <div class="msgtip" id="offlineTip" style="display:none;">
            <i class="msgtipico"></i>
            <span>对方当前不在线或隐身，可能无法立即回复。</span>
            <a class="msgtipclose" href="javascript:;"></a>
        </div> -->
		<div style="bottom: 154px;" class="wwChatListBox jScrollPaneContainer allowContexMenu ableselect">
			<div id="wwChatListBox14207" class="wwChatListBoxScroll">
			<div style="" templateid="partitionTemplate" class="wwPartition"><span class="wwPartitionTxt"> 17:39</span></div><dl style="" msgid="195896" templateid="msgTemplate" class="wwChatMsgBox wwChatSelf" id="msg_msg:1b5c236a-7fce-41ef-ce03-7abfb0378b78">
			<dt class="wwChatHead">
                <i class="wwChatMsgBoxJib wwIco"></i>
                <img alt="" src="http://www.gleasy.com/person/downloadAvatarAction.json?type=user&amp;avatarType=avatarSmall&amp;userId=117059&amp;rand=0.21985290422078207" class="wwChatHeadImg">     
                <div class="fr wwChatReply">
					<a href="#" key="replyBtn" username="loveslikey" uid="117059" msgid="195896" class="wwChatReplyBtn" title="引用">引用</a>
				</div>
            </dt>
			<dt topicid="14207" msgid="195896" class="wwChatMsgBody">
				<div class="fl">
					<a class="wwChatSelfname im_sjh_userName">李香枝</a>
				</div>
				<div class="wwChatMsgDiv" style="line-height: 1.2; font-family: 宋体; font-size: 12px; font-weight: normal; text-decoration: none; color: rgb(66, 67, 69); font-style: normal;">0000731771&nbsp;订单今天晚上必须订舱不然，就赶不上船期了！！！！
<br></div>
				<a class="wwChatTransCount" href="javascript:;" style="display: none;">0</a>
			</dt>
		</dl><dl style="" msgid="195900" templateid="msgTemplate" class="wwChatMsgBox" id="msg_195900">
			<dt class="wwChatHead">
                <i class="wwChatMsgBoxJib wwIco"></i>
                <img alt="" src="http://www.gleasy.com/person/downloadAvatarAction.json?avatarType=avatarSmall&amp;type=card&amp;cardId=321402&amp;default=1&amp;version=1369301911694&amp;sv=1.0" class="wwChatHeadImg">     
                <div class="fr wwChatReply">
					<a href="#" key="replyBtn" username="HelloKitty" uid="114577" msgid="195900" class="wwChatReplyBtn" title="引用">引用</a>
				</div>
            </dt>
			<dt topicid="14207" msgid="195900" class="wwChatMsgBody">
				<div class="fl">
					<a class="wwChatUsername im_sjh_userName">(订舱经理)杨桦</a>
				</div>
				<div class="wwChatMsgDiv" style="line-height: 1.2; font-family: 宋体; font-size: 12px; font-weight: normal; text-decoration: none; color: rgb(66, 67, 69); font-style: normal;">好的，我会尽快协调货代公司下达下货纸</div>
				<a class="wwChatTransCount" href="javascript:;" style="display: none;">0</a>
			</dt>
		</dl></div>
		</div>
		<div class="wwInBoxWrap">
			<!-- 拖动 -->
			<div class="wwDragSizeBar ui-draggable"></div>
			<!-- 聊天工具条 -->
			<div class="wwToolBar">
				<div tabindex="999" style="display:none;top:25px;left:137px;font-size:12px" class="dropmenu captureMenu">
					<ul>
						<li class="captureDirect">直接截图  Ctrl+Shift+A</li>
						<li class="captureAfter">调整后截图 </li>
					</ul>
				</div>
				<a title="字体" id="styleBtn" class="wwToolBarBtn" href="#"><i class="wwIco wwIco1"></i></a> 
				<a title="表情" id="faceBtn" class="wwToolBarBtn" href="#"><i class="wwIco wwIco2"></i></a> 
				<a title="发送图片" id="pictureBtn" class="wwToolBarBtn" href="#"><i class="wwIco wwIco3"></i></a> 
				<a title="在线白板" id="canvasBtn" class="wwToolBarBtn" href="#"><i class="wwIco wwIco4"></i></a> 
				<a title="屏幕截图" id="captureBtn" class="wwToolBarBtn wwDropBtn wwToolBarBtn_active" href="#">
					<i id="captureNow" class="wwIco wwIco5"></i>
					<span id="captureMenuBtn" class="wwToolBarIcoJib wwLine">
	                  	<i class="wwIco fl"></i>
	                </span>
				</a> 
				<a title="历史记录" id="historyBtn" class="wwToolBarBtn fr" href="#"><i class="wwIco wwIco6"></i>历史记录</a>
				<!-- 字体样式 -->
				<div style="display:none;" id="stylePane" class="wwToolFontStyle">
                	<select class="wwFontStyleSelect" id="styleFamily" name="">
                    	<option value="'宋体','SimSun'">宋体</option>
						<option value="'楷体','楷体_GB2312','SimKai'">楷体</option>
						<option value="'黑体','SimHei'">黑体</option>
						<option value="'隶书','simli'">隶书</option>
						<option value="'andale mono'">andale mono</option>
						<option value="'arial','helvetica','sans-serif'">arial</option>
						<option value="'arial black','avant garde'">arial black</option>
						<option value="'comic sans ms'">comic</option>
						<option value="'impact','chicago'">impact</option>
						<option value="'times new roman'">times new roman</option>
                    </select>
                    
                	<select class="wwFontStyleSelect" id="styleSize" name="">
                    	<!-- <option value="10pt">10</option> -->
                    	<option value="12px">12</option>
                    	<option value="14px">14</option>
                    	<option value="16px">16</option>
                    	<option value="18px">18</option>
                    	<option value="20px">20</option>
                    	<option value="22px">22</option>
                    </select>
                    
                    <a id="styleBold" class="wwFontStyleBtn" href="javascript:;"><i class="wwIco wwIco27"></i></a>
                    <a id="styleItalic" class="wwFontStyleBtn" href="javascript:;"><i class="wwIco wwIco28"></i></a>
                    <a id="styleUnderline" class="wwFontStyleBtn" href="javascript:;"><i class="wwIco wwIco29"></i></a>
                    <a id="styleColor" class="wwFontStyleBtn" href="javascript:;"><i class="wwIco wwIco30"></i></a>
                    
                </div>
			</div>
			<!-- 输入框 -->
			<div class="wwInputBox jScrollPaneContainer">
				<span contenteditable="false" class="wwReplyTo" id="replyTip">
					<span id="replyTipText"></span>
                    <a href="javascript:;" class="msgtipclose"></a>
                </span>
				<div contenteditable="true" id="chatContent" class="wwInputBoxScroll allowContexMenu ableselect" style="line-height: 1.2; font-family: 宋体; font-size: 12px; font-weight: normal; text-decoration: none; color: rgb(66, 67, 69); font-style: normal;">
				尽快呀~ 谢谢!
				</div>
			</div>
			<div style="display:none" id="chatContentH"></div>
			<div style="display: none" id="chatContentDeal"></div>
			<div contenteditable="true" style="opacity:0;width:1px;height:1px;overflow:hidden;" class="ableselect" id="chatContentBoxPaste"></div>
		</div>
		<!-- 发送 -->
		<div class="osCtnBtm wwLeftBottom" id="sendDiv">
			<a class="wwSendBtn fr" id="sendBtn" href="#">发 送</a> 
			<a key="wwSendKeyBtn" class="wwTopBtn fr wwSendKeyBtn" href="#"> 
				<span key="wwSendKeyBtn" class="wwSendTxt">Enter</span> 
				<i key="wwSendKeyBtn" class="wwSendIco"></i>
			</a>
			<!-- 修改发送快捷键提示 -->
			<ul id="hotkeySetting" class="wwTipBox wwTipSendKey" style="display: none;">
				<!-- <i class="wwJibBottom"> <em class="wwJiba">&#9670;</em> <em
					class="wwJibb">&#9670;</em> </i> -->
				<li key="0" class="wwSelected">Enter</li>
				<li key="1" class="">Ctrl+Enter</li>
			</ul>
		</div>
		<!-- msg template -->
		<dl style="display:none" msgid="{msgId}" templateid="msgTemplate" class="wwChatMsgBox">
			<dt class="wwChatHead">
                <i class="wwChatMsgBoxJib wwIco"></i>
                <img alt="" src="{avatar}" class="wwChatHeadImg">     
                <div class="fr wwChatReply">
					<a href="#" key="replyBtn" username="{userName}" uid="{uid}" msgid="{msgId}" class="wwChatReplyBtn" title="引用">引用</a>
				</div>
            </dt>
			<dt topicid="13069" msgid="{msgId}" class="wwChatMsgBody">
				<div class="fl">
					<a class="{userClass} im_sjh_userName">{userName}</a>
				</div>
				<div class="wwChatMsgDiv">{message}</div>
				<a class="wwChatTransCount" href="javascript:;">{replyNum}</a>
			</dt>
		</dl>
		<!-- end msg template -->
		
		<!-- reply template -->
		<dd style="position:relative;display:none" templateid="replyTemplate" class="wwChatMsgReplyBox">
			<!-- dl.wwwwChatMsgBox 被回复 -->
			<dl class="wwChatMsgBox">
				<dt topicid="13069" msgid="{msgId}" class="wwChatMsgBody">
					<div class="fl">
						<a class="{userClass} im_sjh_userName">{userName}</a>
					</div>
					<div class="fr wwChatReply">
						<a href="#" key="replyBtn" username="{userName}" uid="{uid}" msgid="{msgId}" class="wwChatReplyBtn" title="引用">引用</a>
					</div>
					<div class="wwChatMsgDiv">{message}</div>
					<a class="wwChatTransCount" href="javascript:;">{replyNum}</a>
				</dt>
			</dl>
		</dd>
		<!-- end reply template -->

		<!-- start 发送失败template -->
		<dt style="display:none;" templateid="sendErrorTemplate" class="wwChatTipErrTmpl">
	        <div class="wwChatTip wwChatTipErr"> <span class="wwChatTipTxt">发送失败 :（</span> <a href="javascript:;" class="errorSendAgain">再次发送</a> </div>
	    </dt>
	    <!-- end 发送失败template -->
		
		<!-- reply remind tip -->
		<!-- <span class="wwReplyTo" templateId="replyTip" contenteditable="false" style="display:none;">引用{userName}:{summary}&nbsp;</span> -->
		<!-- end reply remind tip -->
		
		<!-- attachment p -->
		<!-- <p class="wwChatTip" templateId="attachmentTip" ref="file" style="display:none;">
            <img src="{icon}" alt="" class="wwChatTipImg" />
            <input type="hidden" name="ext" value="{ext}" class="osHidden" />
            <input type="hidden" name="size" value="{size}" class="osHidden" />
            <input type="hidden" name="fid" value="{fid}" class="osHidden" />
            <a name="basic" href="{downloadUrl}" target="_blank">{attachmentName}</a>
        </p> -->
        
        <!-- <p class="wwChatTip" templateId="attachmentTip" ref="file" style="display:none;">
			<a href="#" id="openFile">
				<img src="{icon}" alt="" class="wwChatTipImg" />
				<span>{attachmentName}</span>
			</a>
			<a href="#" id="openFile">打开</a>
			<a href="#" id="saveAs">另存为</a>
		</p> -->
		<!-- end attachment p -->

		<!-- MODIFY ON 20121108 共享文件 template attachment li -->
		<li style="display:none;" ref="file" templateid="attachmentTip" class="wwChatTipLi">
	        <span class="wwChatTipSpan">{attachmentName}</span>
	        <span class="fr">
	          <a href="#" id="openFile" class="wwChatTipActive">打开</a>|<a href="#" id="saveAs" class="wwChatTipActive">另存为</a>
	        </span>
	    </li>
		<!-- END attachment li -->

		<!-- MODIFY ON 20121108 提示类型的消息，不再使用msg template了 -->
		<div style="display:none;" templateid="tipTemplate" class="wwChatTip">{message}</div>

		<!-- MODIFY ON 20121108 时间分割线 -->
		<div style="display:none;" templateid="partitionTemplate" class="wwPartition"><span class="wwPartitionTxt">{time}</span></div>
	</div>
	<!-- 右列 -->
	<div style="width: 170px;" class="wwRight">
		<div class="wwWhisperUserInfo">
			<div class="wwWhisperUserImgBox">
                <img class="wwWhisperUserImg" src="http://www.gleasy.com/person/downloadAvatarAction.json?avatarType=avatarBig&amp;type=card&amp;cardId=297867&amp;default=1&amp;version=1366200852000&amp;sv=1.0">
            </div>
			<div id="personInfo">
				<div id="nameP" class="wwWhisperUserInfo_P"><a class="oVam" id="nameA">(订舱经理)杨桦</a><div class="lvView rankingImg oVam">
    <div class="pLv rankCls pLv0"></div>
</div></div>
				<div class="wwWhisperUserInfo_P"><span id="positionP" class="oVam"></span></div>
				<div id="addButtonP" class="wwWhisperUserInfo_P"><div class="loc_addToBoxButton oVam">	
	<div class="pLBtn loc_button">默认</div>
	<div style="display: none;position: absolute;" class="pHolderListBox loc_pHolderListBox loading">
		<div class="pHolderListScrollWrap jScrollPaneContainer">
			<ul class="pHolderList loc_holder">
				
			</ul>
		</div>
		<div class="pHolderAddnew">
			<a class="pHolderAdd loc_add" href="javascript:;">创建新的名片夹</a> 
			<input type="text" style="display: none;" class="pHolderAddIpt loc_input">
			<button style="display: none;" class="pHolderAddBtn loc_create">创建</button>
		</div>
		
		<div style="position: absolute;z-index: 99999;display: none;" class="msgtip msgtipjibbottom pMsgmsgtip loc_pMsgmsgtip_confirm">
            <p class="loc_msg">[彻底移出名片夹会断开好友关系，| 移出所有名片夹会彻底删除此名片，]</p>
            <p>确定移出吗?
                <span>
                    <a class="loc_confirm" href="javascript:;">确定</a>
                    <a class="loc_cancel" href="javascript:;">取消</a>
                </span>
            </p>
            <a href="javascript:;" class="msgtipclose"></a>
        </div>
        
        <div style="position: absolute;z-index: 99999;display: none;" class="msgtip msgtipjibbottom pMsgmsgtip loc_pMsgmsgtip_connected">
            <p>ta也有您的名片，你们是好友了 ：）</p>
            <a href="javascript:;" class="msgtipclose"></a>
        </div>
        
        <div style="position: absolute;z-index: 99999;display: none;" class="msgtip msgtipjibbottom pMsgmsgtip loc_pMsgmsgtip_dragToBox">
            <p>收入名片成功，并告诉ta了</p>
            <a href="javascript:;" class="msgtipclose"></a>
        </div>
	</div>
</div><div class="loc_exchangeButton oVam">
	<i style="" class="loc_exchange pIco pIcoDouble" title="好友"></i>
	<a style="display: none;" title="邀请加入Gleasy" href="jvascript:;" class="loc_invite inviteBtn">邀请</a>
	<span style="display: none;" class="loc_inblack">ta在你黑名单里</span>
</div></div>
				<div id="otherButtonP" class="wwWhisperUserInfo_P"><div class="eTalk eTalkGroup loc_eTalk oVam">
    <div class="eIcoBox">
        <div class="eIco"></div>
    </div>
    <div class="eJibbox" style="display: none;">
        <i class="eJib"></i>
    </div>
    <ul class="dropmenu loc_dropmenu">
        <li class="loc_im_private liDisabled">
            私聊
        </li>
        <li class="loc_im_topic">
            讨论组
        </li>
    </ul>
    <div style="position: absolute; z-index: 99999; display: none;" class="msgtip msgtipjibbottom pMsgmsgtip tpl_pMsgmsgtip_im">
        <p></p>
        <a href="javascript:;" class="msgtipclose"></a>
    </div>
</div><div class="eMail loc_eMail oVam">
	<div class="eIcoBox">
		<div class="eIco"></div>
	</div>
	<div class="eJibbox">
		<i class="eJib"></i>
	</div>
	<ul class="dropmenu loc_dropmenu">
		<li class="loc_mail">写邮件</li>
		<li class="loc_task liDisabled">发任务</li>
		<li class="loc_activity liDisabled">发活动</li>
		<li class="loc_vote liDisabled">发投票</li>
		<li class="loc_approval liDisabled">发审批</li>
	</ul>
</div></div>
			</div>
			
			<!--正在语音-->
            <div style="display:none;" class="wwMediaIngBox">
                <div class="wwMediaIng">
                    <i class="wwIco wwIco37"></i> <span id="chatTime">00:00</span>
                </div>
                <button id="cancel" class="wwButton"><i class="wwIco wwIco36"></i>挂断</button>
            </div>
		</div>
		
		<div style="display:none;" class="wwTabBox">
			<ul class="wwTab">
				<li style="display:none;" key="attachment"><a href="#" class="wwChatTipClose wwTabAccessClose"></a>共享</li>
				<li style="display:none;" key="comment"><a href="#" class="wwChatTipClose wwTabHisClose"></a>批注</li>
				<li style="display:none;" key="forward"><a href="#" class="wwChatTipClose wwTabHisClose"></a>引用</li>
				<li style="display:none;" key="mediaChatRequest"><a href="#" class="wwChatTipClose wwTabHisClose"></a><span style="display:inline;">语音/视频邀请</span></li>
				<li style="display:none;" key="videoChat"><a href="#" class="wwChatTipClose wwTabHisClose"></a>视频聊天</li>
			</ul>
		</div>
		
		<!-- 选项卡：附件 -->
        <div style="display:none;" class="loc_AttachmentListView"><div class="wwTabContent wwTabAccess">
    <div class="wwTabCtnTop">
        <a href="#" class="wwTopBtn loc_shareGcdFiles"><i class="wwUploadIco"></i>共享</a>
        <a href="#" class="wwTopBtn loc_refresh"><i class="wwFlushIco"></i>刷新</a>
    </div>
    <div class="wwTabAccessListScrollWrap jScrollPaneContainer">
        <div class="wwTabAccessList">
            
            
            <p class="wwTabAccessItemNone">无共享内容</p>
        </div>
    </div>
</div></div>
        
		<!-- 选项卡：批注 -->
        <div style="display:none" class="wwTabContent wwTabNote">
        	<!-- 批注列表 -->
			<div id="commentList" class="wwNoteTxtBox">
		        <div class="wwTipNoteListScrollWrap jScrollPaneContainer">
		        	<ul id="listView" class="wwTipNoteListScroll">
		    			
		    		</ul>
		        </div>
		    </div>
		    
		    <!-- 批注编辑 -->
            <div id="commentEdit" class="wwNoteTxtBox">
            	<textarea style="display:block" class="wwNoteTextarea" rows="10" cols="30" id="note" name=""></textarea>
            </div>
            <div class="wwNoteBtm">
            	<a id="seeAllBtn" class="wwTopBtn fl" href="javascript:;"><i class="wwIco wwSearch"></i>查看所有批注</a>
            	<a style="display:none;" href="javascript:;" class="wwTopBtn fl" id="seeContext"><i class="wwIco wwSearch"></i>查看上下文</a>
            	<a id="okBtn" class="wwSendBtn fr" href="javascript:;">确定</a>
            </div>
            
            <li style="display:none" topicid="{topicId}" msgid="{msgId}" templateid="commentLine"><a href="#">{comment}</a></li>
        </div>
        <!-- 选项卡：转发 -->
      	<div style="display:none;" class="wwTabContent wwTabForward">
	            <div class="wwTipTranScrollWrap">
	        	<div class="wwTipTranScroll">
	                
	            </div>  
	        </div>
            
            <!-- 转发翻页 -->
            <div style="display:none;" class="oPager">
                <button type="button" class="oPagerFirst oPagerFirst_disable"></button>
                <button type="button" class="oPagerPrev oPagerPrev_disable"></button>
                <span>第</span>
                <input type="text" id="pageInput" class="oPagerIpt">
                <span>/</span><span id="totalPage">0</span>
                <span>页</span>
                <button type="button" class="oPagerNext "></button>
                <button type="button" class="oPagerEnd "></button>
            </div>
            
              <!-- 消息template -->
		      <dl style="position:relative;display:none" templateid="msgTemplate" class="wwChatMsgBox">
					<dt topicid="{topicId}" msgid="{msgId}" class="wwChatMsgBody">
						<div class="fl">
							<a class="{userClass}  im_sjh_userName">{userName}</a> <span class="wwChatTime">{date}</span>
						</div>
						<div class="fr wwChatReply">
							<a href="#" key="replyBtn" username="{userName}" uid="{uid}" msgid="{msgId}" class="wwChatReplyBtn" title="引用">引用</a>
						</div>
						<div class="wwChatMsgDiv">{message}</div>
					</dt>
				</dl>
				
				<!-- 转发p template -->
				<p style="display:none" templateid="tipTemplate" class="wwChatMsgBox wwChatMsgBody">被引用<span id="replyNum">{replyNum}</span>次</p>
        </div>
        <!-- 语音/视频邀请界面(需根据主动和被动，绘制不同的界面) -->
        <div style="display:none;" class="wwTabContent wwAudio" id="mediaTabContent">
            <div class="wwMediaContent">
                <div class="wwMediaLogoWrap"> <div class="wwMediaLogoBox"> <i class="wwMediaLogo"></i> </div> </div>
                <p id="mediaChatTip" class="wwMediaTxt"></p>
                <div class="wwMediaTxt">
                    <button style="display:none;" id="accept" class="wwButton"><i class="wwIco wwIco33"></i>接收</button>
                    <button style="display:none;" id="reject" class="wwButton"><i class="wwIco wwIco34"></i>拒绝</button>
                    <button style="display:none;" id="cancel" class="wwButton"><i class="wwIco wwIco35"></i>取消</button>
                </div>
            </div>
        </div>
        <!-- 视频聊天界面 -->
        <div style="display:none;" class="wwTabContent wwVideo wwBigVideo" id="videoChatTabContent">
	        <div class="wwMediaContent">
	            <div class="wwMediaLogoWrap">
	                <div id="videoBox" class="wwMediaLogoBox">
	                	<i class="wwMediaLogo"></i>
	                    <p class="wwMediaTxt">video chatting...</p>
	                </div>
	            </div>
	        </div>
	
	        <!--正在视频-->
	        <div class="wwMediaIngBox">
	            <div class="wwMediaIng">
	                <i class="wwIco wwIco37"></i> <span>00:23</span>
	            </div>
	        </div>
	        <button id="cancel" class="wwButton fr"><i class="wwIco wwIco36"></i>挂断</button>
	    </div>
	</div>
	
	<!-- ===== 右键 ===== -->
	<div attach="no" style="display: none;" class="oConTextMenuBox contextMenu" id="ctxMenu">
		<ul id="ctxRoot" class="oContextMenu">
		</ul>
	</div>
	<!-- 右键菜单项 -->
	<li class="oDisabled" templateid="ctxMenuItem" style="display: none;" id="{id}"><a href="#">{text}</a></li>
	<!-- ===== end 右键 ===== -->
	
	<!-- 弹层TIP -->
	<div style="display:none;" class="msgtip" id="floatTip">
	    <!-- <span id="msg"></span>
	    <a href="#" id="link"></a> -->
	</div>
	<!-- END 弹层TIP -->
</div></div>
</div>
</body>
</html>