<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div tabindex="54" style="position: relative;top: 0px;height: 100%" class="maildetailscrollwrap ">
	<div class="mailbox">
		<!-- 公告详情 -->
		<div class="detailBox">

			<!-- 回复列表 -->
			<div class="replayBox">
				<div class="detailItem">
					<!-- 展开内容 -->
					<div class="detailItemContent locDetailItemContent">
						<div class="detailTop">
							<dl class="detailAddressor">
								<dt
									style="-moz-user-select: -moz-all; -webkit-user-select: auto;height: 60px"
									class="dAddHead fl allowContexMenu">
									<img src="http://www.gleasy.com/person/downloadAvatarAction.json?avatarType=avatarSmall&amp;type=card&amp;cardId=297867&amp;default=1&amp;version=1366200852000&amp;sv=1.0"
										alt="" class="pSideItemImg tpl_pSideItemImg dAddHeadImg">
									<i class="imp locUrgent" style="display: none;"></i>
								</dt>
								<dd
									style="-moz-user-select: -moz-all; -webkit-user-select: auto;"
									class="dAddContent cf allowContexMenu">
									<div class="dAddP">
										<!-- <button  style="float: right;" class="sBtn sendBtn">回复邮件</button> -->
										
										<div class="dAddTop locInviteDiv">
											<i class="fJ " style="display: none;"></i> <b
												class="detailAddor locFromName">leleleshun</b> <span
												style="" class="dAdd_s locFromAddr">&lt;leleleshun@gleasy.com&gt;</span>
											<span class="detailTime ">2013/06/07(周五) 15:42</span> <span
												class="dAdd_s dAddInviteInfo" style="display: none"
												name="shortInviteInfo"> <span class="dadd_line">|</span>
												<span name="inviteFrom">我</span><span>将</span><span
												name="invited"></span><span class="dAdd_s">加入此信件</span>
											</span>
										</div>
								
									</div>
									<!-- 收件人详情模式 -->
									<div style="" class="dAddsDetail cf">
										<p class="dAddP">
											<!-- <span class="dMenu fr cf">			                    <i class="dReplyBtn locReplyAll"></i>			                    <i class="dDropBtn locQuickOperate"></i>			                </span> -->
											<span class="dAdd_s fl">收件人:</span> <span class="dAdd_d cf"
												name="TO"> <!-- <i class="dAdd-i">文嘉</i>;  --> <i
												class="dAdd-i fl">loveslikey<span class="dAdd_s">&lt;loveslikey@gleasy.com&gt;</span>;
											</i></span>
										</p>
										<p class="dAddP cf" style="display: none;">
											<span class="dAdd_s fl">抄&#12288;送:</span> <span
												class="dAdd_d cf" name="CC"> <!-- <i class="dAdd-i">文嘉</i>;  -->
											</span>
										</p>
										<p class="dAddP cf" style="display: none;">
											<span class="dAdd_s fl">密&#12288;送:</span> <span
												class="dAdd_d cf" name="BCC"> <!-- <i class="dAdd-i">文嘉</i>;  -->
											</span>
										</p>
										<p class="dAddP dAddBcc cf locBccMsg" style="display: none;">
											<i class="dAddBccIco"></i> <span>您是这封信件的密送人，所以不会显示在收件人中</span>
										</p>
										<p class="dAddP cf">
											<span class="dAdd_s fl">主&#12288;题:</span> <span
												class="dAdd_d locSubjectDown">asdasd</span>
										</p>
									</div>
								</dd>
							</dl>
						</div>
						<div class="detailContentWrp">
							<b class="trigBox"> <b class="trig"></b> <b class="trigUp"></b>
							</b>
							<div>
								<!--邮件内容收起状态-->
								<div style="display: inline;" class="detailContentBrief locBriefDetail">
									<!--Content 展开/收起 按钮-->
									<!--收起状态显示的文本-->
									<div class="detailContent">
										${content}
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>