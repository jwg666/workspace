<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<script type="text/javascript">
$("#messageListTable tr").dblclick(function(){
	$("#showMessage").load("${dynamicURL}/message/messageAction!showDesc.do?id="+$(this).attr("data"));
	$("#showMessage").window("open");
});
/* $("#messageListTable .locDataCheckTd").on("click",function(){
	return false;
}); */

</script>
				<div class="toolbar toolbartop" style="display: block;">
					<div menu="select" class="dropBtn">
						<div class="selectIcoBox fl locGlobalChk">
							<i style="display: none;" class="selectPartialIco locPartial "></i>
							<i style="" class="Checkbox locUnCheck"></i> 
							<i style="display: none;" class="Checkbox CheckboxChecked locChecked"></i>
						</div>
						<i class="dropico"></i>
					</div>

					<div title="舍弃草稿" class="dropBtn dropDisabled" name="pDelBtn"
						style="display: none;">舍弃草稿(永久删除)</div>
					<div title="删除" class="dropBtn" onclick="del('${box}')" name="delBtn" style="display: none;">删除</div>

					<div title="刷新" class="dropBtn" name="refresh" onclick="refresh()">
						<i class="flush"></i>
					</div>

					<div class="pager">
						<input type="hidden" id="pageNumber" value="${messagePager.currentPage}">
						<input type="hidden" id="totalPage" value="${messagePager.totalPages}">
						<span class="pager_s">共${messagePager.totalRecords}封</span>
						<span class="pager_s">${messagePager.currentPage}/${messagePager.totalPages} 页</span> 
						<a href="javascript:void(0)" onclick="backPage()"><span name="pager_prev" style="cursor:pointer;" class="pager_prev cc" disabled="disabled">上一页</span> </a>
						<a href="javascript:void(0)" onclick="nextPage()" ><span name="pager_next" style="cursor:pointer;" class="pager_next cc" disabled="disabled">下一页</span></a>
						<span class="gotopager btmgotopager cc" disabled="disabled">
							第<input type="text" id="toPageNum" size="1" value="">页						
						</span>
						<a href="javascript:void(0)" onclick="ToPageNumber()"><span class="gotopager btmgotopager cc" style="cursor:pointer;"  disabled="disabled">跳转</span></a>
						
					</div>
					<div class="search">
						<input id="searchTitle" type="text" class="topsearch">
						<div class="cSchIco" id="searchStaffIco" onclick="search()"></div>
					</div>
				</div>

				<div name="qryResult" class="toolbar" style="display: none;">
					<p class="searchText"></p>
				</div>

				<!-- <div class="mailscrollwrap jScrollPaneContainer"> -->
				<div class="mailscrollwrap">
					<div style="overflow: auto;" class="mailbox">

						<table width="100%" id="messageListTable" cellspacing="0" cellpadding="0" border="0" class="message${box}List">
							<tbody>
							<s:iterator value="messagePager.records"  var="messageMap" >
								<tr data="${messageMap['MESSAGE_ID'] }" class="">
									<td class="mailcx locDragTd">&nbsp;&nbsp;</td>
									<td class="mailcx locDataCheckTd"><input type="checkbox"
										value="${messageMap['MESSAGE_ID'] }"	class="iptChk ipt" name="dataCheck"></td>
									<td class="mailfg" name="starBtn">
										<s:if test="%{#messageMap['TYPE'] == 3}">
											<i class="staroff"></i>
										</s:if>
										<s:if test="%{#messageMap['TYPE'] == 5}">
											<i class="staron"></i>
										</s:if>
										<!-- staron or staroff--></td>
									<td class="mailtl"><div class="sender ">
										<s:if test="%{box=='send'}">
											<span class="addresser locMembers ">${messageMap['RECEIVENAME'] } </span>
										</s:if>
										<s:if test="%{box=='receive'}">
											<span class="addresser locMembers ">${messageMap['NAME'] } </span>
										</s:if>	
										</div></td>
									<td class="mailcx locImpTd"><i style="display: none;"
										class="imp"></i></td>
									<td class="mailgt"><div class="mailttbox">
											<span class="mailtt ">[通知]${messageMap['TITLE']}</span>
										</div></td>
									<td class="maildt"><div class="tar">
											<span class="">${messageMap['SENDTIME']}</span><!-- <span class="cc">[信息]</span> -->
										</div></td>
								</tr>
								</s:iterator>
							</tbody>
						</table>
					</div>
				</div>
				
