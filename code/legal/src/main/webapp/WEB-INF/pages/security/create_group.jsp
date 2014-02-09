<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="p" uri="/pagination-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
	<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>创建组信息</title> 
<script type="text/javascript">
	var send = false;
	var addAdminDialog = null;
	function addAdminToGroupBlock1() {
		document.getElementById('searchUser').style.display = "block";
	}
	function createGroup() {
		if(!send){
			send = true;
			var groupdescription = document.getElementById('thisgroupdescription').value;
			var groupname = document.getElementById('thisgroupname').value;
			var groupcode = document.getElementById('thisgroupcode').value;
			$.ajaxSetup({ 
				cache : false
			});
			
			$.getJSON("${dynamicURL}/security/createGroup.do?group.description="
							+ encodeURI(groupdescription) + "&group.name="
							+ encodeURI(groupname)+"&group.code="+encodeURI(groupcode), function call(data) {
						ifModified: true;
						cache: false;
						if (data.actionMessages != null
								&& data.actionMessages != "") {
							parent.art.dialog({
								title : '成功提示',
								content : '' + data.actionMessages,
								esc : true,
								icon : 'succeed',
								close : function() {
									parent.window.location.reload();
								}
							});
							send = false;
						} else {
							var fe = data.fieldErrors;
							var msg = data.actionErrors;
							for (prop in fe) {
								if (prop == 'group.name') {
									msg += fe[prop] == null || fe[prop] == "" ? "":fe[prop] + "<br/>";
								}
								if (prop == 'group.code') {
									msg += fe[prop] == null || fe[prop] == "" ? "":fe[prop] + "<br/>";
								}
								if (prop == 'group.description') {
									msg += fe[prop] == null || fe[prop] == "" ? "":fe[prop] + "<br/>";
								}
							}
							parent.art.dialog({
								title : '失败提示',
								content : msg,
								esc : true,
								icon : 'error'
							});
							send = false;
						}
					});
		} 
		
	}
</script>
</head>
<dt>
	<h3>创建新组</h3>
</dt>
<dd class="tab1">
	<jsp:include page="/common/messages.jsp" />
	<s:form action="createGroup" namespace="/security" method="get"
		id="createGroupForm">
		<table class="form_table">
			<tr>
				<th>组名称<span class="star">*</span>:
				</th>
				<td><s:textfield name="group.name" id="thisgroupname" /></td>
				<th>组描述:</th>
				<td><s:textfield name="group.description"
						id="thisgroupdescription" /></td>			
			</tr>
			 <tr>
			<th>组编码:<span class="star">*</span>:</th>
				<td><s:textfield name="group.code"
						id="thisgroupcode" /></td>
			  <td colspan="4"><input type="button" value="创建"
					class="abn db l" onclick="createGroup()" /></td>
			</tr>
			<%-- <tr> 
			<th>设置管理员</th>
			<td><s:textarea name="userId" id="userId" onfocus="addAdminToGroupBlock()" cssStyle="width:200PX"/></td>
			<td colspan="4"><input type="submit" value="创建" class="abn db l"/></td>
		</tr>   --%>
		</table>
	</s:form>
	</html>
</page:apply-decorator>