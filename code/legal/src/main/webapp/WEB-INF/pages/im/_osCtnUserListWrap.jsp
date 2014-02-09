<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 联系人列表 -->
<div
	class="osCtnUserListWrap osCtnTabContent os_im_wedget_linkandorg_div jScrollPaneContainer"  style="top:0px">


	<div class="osCtnUserList">
		<!-- 所有连接 -->
		<div style="" id="allLinkView"
			class="addr_alllink rootGroup addr_alllink_h4_hide">
			<!-- div.item  所有连接一级类别 -->
			<s:iterator  value="onLineUserList"  var="group">
			<div style="" class="item template_my_link">
			    	 <h3 class="open"><i>${group['groupName']}</i>[<span style="display:inline;" id="${group['groupCode']}_count"  class="group_online_friend"> <s:property   value="%{#group.userList.size()}"/></span>]</h3>
			    		
			    	<ul style="display:none;" id="${group['groupCode']}">
			    	<s:iterator  value="#group.userList"  var="user">
			    	<li draggable="true" id="${group['groupCode']}_${user['code']}" priority="7" status="online" userName="${user['name']}" uid="${user['code']}" userId="${user['id']}"  class="item template_my_link_halt" style="display: none;">
			    		<div class="osHeadBox">
	    					<img class="osHead" src="${staticURL}/IM/stylesheets/im/images/defaultHead.png">
	    					
	    				</div>
	    				<span name="userName"><i>${user['name']}</i><em class="osSign" name="sign"></em></span>
	    				<i class="osItemSts " name="status"></i>
	    				<i class="my_link_hover"></i>
	    			</li>
	    			</s:iterator>
	    				
	    			</ul>
			   </div>
			   </s:iterator>
		</div>
	</div>
</div>












