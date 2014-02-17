<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="p" uri="/pagination-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%> 
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>更新组信息</title> 
<script type="text/javascript">
function deleteUserFromGroup(){
	var _items = document.getElementsByName('groupusercheck');  
	var itemvalue = new Array(); 
	var id;
	var j = 0;
	for ( var i = 0; i < _items.length; i++) {
		if (_items[i].checked) {
			j = j + 1; 
			itemvalue[i] = _items[i].value; 
			if(j==1){
				id = itemvalue[i];
			}else{
				id = id+","+itemvalue[i];
			}  
		}
		}     
	var groupid = parent.document.getElementById('thisgroupid').value;  
	if(j==0){
		parent.art.dialog({
			title: '警告信息',
		    content: '至少选择一条记录',  
		    esc: true,
		    icon: 'warning' 
		});   
	} else {
		if(!confirm("确定要从组中删除这"+j+"个人员吗？")){ 
		return;
	    }  
		var delUserLoading = art.dialog({title: '请稍后',content: '删除中请稍后...'});
	$.ajaxSetup ({ 
		cache: false 
		}); 
	$.getJSON("${dynamicURL}/security/deleteUserFromGroup.action?group.id="+groupid+"&userId="+id, 
			function call(data){ 
			 ifModified:true;
			 cache: false;
			delUserLoading.close();
			if(data.actionMessages != null && data.actionMessages != ""){
				parent.art.dialog({
					title: '成功提示',
				    content: ''+data.actionMessages,  
				    esc: true,
				    icon: 'succeed', 
			    	close: function () {  
			    		var form = document.getElementById("searchUserForm");
			    		form.submit();
			        },
			        time: 2
				});   
			}else{
				parent.art.dialog({
					title: '失败提示',
				    content: ''+data.actionMessages,   
				    esc: true,
				    icon: 'error' 
				});   
			}
	}); 
	}
}  
</script>
</head> 
<dd class="tab1">  
				<div style="width: 100%; margin-right: 10PX;">
					<s:form action="searchUserInGroup" namespace="/security" method="get"
						id="searchUserForm">
						<table class="form_table">
							<tr>
								<th>员工号：</th>
								<td><s:textfield name="user.empCode" /></td>
								<th>用戶名：</th>
								<td><s:textfield name="user.name" /></td>
								<th>Email：</th>
								<td><s:textfield name="user.email" />		<s:hidden name="group.id"/>
		<s:hidden name="group.description"/>
		<s:hidden name="group.name"/></td>
								<td><input type="submit" value="查询" class="abn db l" /></td>
							</tr>
						</table>
					</s:form>
				</div>
				<div style="margin-top: 3px">
		       <input type="button" value="移除" onclick="deleteUserFromGroup()"
									class="abn db" style="font-size: 12px;margin-left: 2px;margin-bottom: 3PX" />
				<input type="button" name="addUserToGroup" onclick="window.parent.addUserToGroup()" value="新增" class="abn db" style="margin-bottom: 3PX"/>
				</div>
				<div style="width: 100%;margin-right: 10PX;">
					<table id="rounded-corner" class="color_table">
						<thead>
							<tr>
								<th nowrap="nowrap"><input name="allgroupusercheck"
									type="checkbox" id="allgroupusercheck"
									onclick="checkAll(this.checked, 'groupusercheck')" /></th>
								<th>员工号</th>
								<th>用户名</th>
								<th nowrap="nowrap">
									邮箱</th>
								<th nowrap="nowrap">类型
								</th>
								<th nowrap="nowrap">状态
								</th>
								<th nowrap="nowrap">
									最近登陆IP</th>
								<th nowrap="nowrap">
									最近登陆时间</th> 
							</tr>
						</thead>
						<tbody>
							<!-- 数据行 -->
							<s:iterator value="pagerUser.records" var="user" status="status">
								<tr>
									<td style="width: 12PX;"><input name="groupusercheck"
										type="checkbox" id="groupusercheck<s:property value='id'/>"
										value="<s:property value='id'/>"
										onclick="chkeckSingle('groupusercheck', 'allgroupusercheck')" /></td>
									<td style="font-size: 12px;" nowrap="nowrap"><s:property
												value="empCode" /></td>
									<td style="font-size: 12px;" nowrap="nowrap"><s:property
											value="name" /></td>
									<td style="font-size: 12px;" nowrap="nowrap"><s:property
											value="email" /></td>
									<td style="font-size: 12px;" nowrap="nowrap"><s:property
											value="@com.neusoft.security.domain.enu.UserTypeEnum@toEnum(type).description" /></td>
									<td style="font-size: 12px;" nowrap="nowrap"><s:property
											value="@com.neusoft.security.domain.enu.UserStatusEnum@toEnum(status).description" /></td>
									<td style="font-size: 12px;" nowrap="nowrap"><s:property
											value="currentLoginIp" /></td>
									<td style="font-size: 12px;" nowrap="nowrap"><s:date
											name="lastLoginTime" format="yyyy-MM-dd HH:mm:ss" /></td> 
								</tr>
							</s:iterator>  
						 </tbody>
					</table>
					<div id="addUserToGroup" style="display: none;">
										<iframe scrolling="no" id="addUserToGroupInitFrame" name="addUserToGroupInitFrame"
											src="${dynamicURL}/security/addUserToGroupInit.action?group.id=<s:property value='group.id'/>"
											frameborder="0" width="850px" height="450px"></iframe>
										</div>  
				</div>
				<div id="footer-container" class="dd-fd"
					style="float: left; width: 100%; margin-right: 10px;">
					<p:pagination pager="pagerUser" formId="searchUserForm"></p:pagination>
				</div> 
			</dd>
</html>
</page:apply-decorator>
