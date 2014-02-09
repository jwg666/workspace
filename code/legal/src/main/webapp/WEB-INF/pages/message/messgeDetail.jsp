<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div tabindex="54" style="position: relative;top: 0px;height: 100%" class="maildetailscrollwrap ">
	<div class="mailbox">
		<!-- 邮件详情 -->
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
									<img src="${staticURL}/IM/stylesheets/os/images/person.png"
										alt="" class="pSideItemImg tpl_pSideItemImg dAddHeadImg">
									<i class="imp locUrgent" style="display: none;"></i>
								</dt>
								<dd
									style="-moz-user-select: -moz-all; -webkit-user-select: auto;"
									class="dAddContent cf allowContexMenu">
									<div class="dAddP">
										<div class="dAddTop locInviteDiv">
											<i class="fJ " style="display: none;"></i> <b
												class="detailAddor locFromName">${senderName}</b>
											<span class="detailTime ">2013/06/07(周五) 15:42</span>
										</div>
								
									</div>
									<!-- 收件人详情模式 -->
									<div style="" class="dAddsDetail cf">
										<p class="dAddP">
											<!-- <span class="dMenu fr cf">			                    <i class="dReplyBtn locReplyAll"></i>			                    <i class="dDropBtn locQuickOperate"></i>			                </span> -->
											<span class="dAdd_s fl">收件人:</span> <span class="dAdd_d cf"
												name="TO"> <!-- <i class="dAdd-i">文嘉</i>;  --> <i
												class="dAdd-i fl">${receiveNname}<span class="dAdd_s">&lt;${receiveNname}&gt;</span>;
											</i></span>
										</p>
										<p class="dAddP cf">
											<span class="dAdd_s fl">主&#12288;题:</span> <span
												class="dAdd_d locSubjectDown">${title }</span>
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
									<div class="detailContent" style="height:auto">
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