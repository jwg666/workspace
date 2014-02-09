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
<style type="text/css">
.aui_content {
	padding: 0px 0px;
}

.aui_content {
	padding-bottom: 0px !important;
	padding-left: 0px !important;
	padding-right: 0px !important;
	padding-top: 0px !important;
}
</style> 
<script type="text/javascript">
	var addAdminDialog = null;
	var searchUserInGroupDialog;
	var searchAdminInGroupDialog;
	var searchRoleInGroupDialog;
	function addAdminToGroup() {
		document.getElementById('addAdminToGroupInit').contentWindow.location.reload();  
    	searchAdminInGroupDialog = art.dialog({
					title : '添加组内管理员',
					content : document.getElementById('addAdminToGroup'),
					esc : true,
					height : '100px',
					width : '100px',
					close : function() {
						document.getElementById('searchAdminInGroup').contentWindow.location
								.reload();
					}
				});
	}
	function addUserToGroup() {
		document.getElementById('addUserToGroupInit').contentWindow.location.reload();  
		searchUserInGroupDialog = art.dialog({
					title : '添加组内人员',
					content : document.getElementById('addUserToGroup'),
					esc : true,
					height : '100px',
					width : '100px',
					close : function() {
						document.getElementById('searchUserInGroup').contentWindow.location
								.reload();
					}
				});
	}
	function addRoleToGroup() {
		document.getElementById('addRoleToGroupInit').contentWindow.location.reload();  
		searchRoleInGroupDialog = art
				.dialog({
					title : '添加组内角色',
					content : document.getElementById('addRoleToGroup'),
					esc : true,
					height : '100px',
					width : '100px',
					close : function() {
						document.getElementById('searchRoleInGroup').contentWindow.location
								.reload();
					}
				});
	}
	function addAdminToGroupBlock() {
		addAdminDialog = art.dialog({
			title : '设置组管理员',
			content : document.getElementById('searchAdminInGroup'),
			esc : true,
			height : '100px',
			width : '100px'
		});
	}
	function updateGroup() {
		var groupid = document.getElementById('thisgroupid').value;
		var groupdescription = document.getElementById('updatedescription').value;
		var groupname = document.getElementById('updatename').value;
		var oldName = document.getElementById('thisgroupname').value;
		var groupcode = document.getElementById('updatecode').value;
		//alert(groupcode);
		$.ajaxSetup({
			cache : false
		});
		$.getJSON("${dynamicURL}/security/updateGroup.action?group.id="
				+ groupid + "&group.description=" + encodeURI(groupdescription)
				+ "&group.name=" + encodeURI(groupname) + "&oldName="
				+ encodeURI(oldName)+"&group.code="+encodeURI(groupcode), groupname, function call(data) {
			ifModified: true;
			cache: false;
			if (data.actionMessages != null && data.actionMessages != "") {
				art.dialog({
					title : '成功提示',
					content : '' + data.actionMessages,
					esc : true,
					icon : 'succeed'
				});
				var updatename = document.getElementById('updatename').value;
				document.getElementById('thisgroupname').value = updatename;
			} else {
				var fe = data.fieldErrors;
				var groupname = '';
				var groupdescription = '';
				for (prop in fe) {
					if (prop == 'group.name') {
						groupname = fe[prop];
					}
					if (prop == 'group.description') {
						groupdescription = fe[prop];
					}
				}
				art.dialog({
					title : '失败提示',
					content : '' + data.actionErrors + groupname + '<br/>'
							+ groupdescription,
					esc : true,
					icon : 'error'
				});
			}
		});
	}
</script> 
</head>
<dt>
	<h3>组维护界面</h3>
</dt>
<dd class="tab1">
	<sj:tabbedpanel id="localtabs">
		<sj:tab id="tab1" target="tone" label="基本信息"
			cssStyle="font-size: 12px;" />
		<sj:tab id="tab2" target="ttwo" label="组内人员"
			cssStyle="font-size: 12px;" />
		<sj:tab id="tab3" target="tthree" label="组内角色"
			cssStyle="font-size: 12px;" />
		<sj:tab id="tab3" target="tfore" label="组管理员"
			cssStyle="font-size: 12px;" />
		<!-- 组基本信息维护 -->
		<div id="tone">
			<s:hidden name="group.id" id="thisgroupid" />
			<s:hidden name="group.description" id="thisgroupdescription" />
			<s:hidden name="group.name" id="thisgroupname" />
			<div style="margin-left: 10px">
				<jsp:include page="/common/messages.jsp" />
				<s:form action="updateGroup" namespace="/security" method="get"
					id="updateGroupForm">
					<table class="form_table" style="font-size: 12px;">
						<tr>
							<th>组名称<span class="star">*</span>:
							</th>
							<td><s:textfield name="group.name" id="updatename" /></td>
							<th>组描述<span class="star">*</span>:
							</th>
							<td><s:textfield name="group.description"
									id="updatedescription" /> <s:hidden name="group.id" /></td>
							<th>组编码<span class="star">*</span>:
							</th>
							<td><s:textfield name="group.code"
									id="updatecode" /> 
							<td colspan="4"><input type="button" value="更新"
								class="abn db l" onclick="updateGroup()" /></td>
							<%-- 		<td colspan="4">
									<input type="button" value="设置管理员"
									class="abn db l" onclick="addAdminToGroupBlock()"/>  
									<input type="button" value="更新"
									class="abn db l" onclick="updateGroup()"/>
									<s:hidden name="userId" id="userId"/>
									</td> --%>
						</tr>
					</table>
				</s:form>
			</div>
			<div style="height: 40px"></div>
		</div>


		<div id="addUserToGroup" style="display: none;">
			<iframe scrolling="no" name="addUserToGroupInit" id="addUserToGroupInit"
				src="${dynamicURL}/security/addUserToGroupInit.action?group.id=<s:property value='group.id'/>"
				frameborder="0" width="850px" height="450px"
				style="overflow: hidden;"></iframe>
		</div>
		<div id="addRoleToGroup" style="display: none;">
			<iframe scrolling="no" name="addRoleToGroupInit" id="addRoleToGroupInit"
				src="${dynamicURL}/security/addRoleToGroupInit.action?group.id=<s:property value='group.id'/>"
				frameborder="0" width="850px" height="450px"
				style="overflow: hidden;"></iframe>
		</div>
		<div id="addAdminToGroup" style="display: none;">
			<iframe scrolling="no" id="addAdminToGroupInit"
				name="addAdminToGroupInit"
				src="${dynamicURL}/security/addAdminToGroupInit.action?group.id=<s:property value='group.id'/>"
				frameborder="0" width="850px" height="450px"></iframe>
		</div>
		<!-- 组人员信息维护 -->
		<div id="ttwo">
			<iframe scrolling="no" name="searchUserInGroup"
				id="searchUserInGroup"
				src="${dynamicURL}/security/searchUserInGroup.action?group.id=<s:property value='group.id'/>"
				frameborder="0" width="100%" height="500px"
				style="overflow: hidden; overflow: hidden;"></iframe>

		</div>
		<div id="tthree">

			<iframe scrolling="no" id="searchRoleInGroup"
				name="searchRoleInGroup"
				src="${dynamicURL}/security/searchRoleInGroup.action?group.id=<s:property value='group.id'/>"
				frameborder="0" width="100%" height="500px"
				style="overflow: hidden;"></iframe>
		</div>
		<div id="tfore">
			<iframe scrolling="no" name="searchAdminInGroup"
				id="searchAdminInGroup" style="overflow: hidden;" height="500px"
				width="100%" frameborder="0"
				src="${dynamicURL}/security/searchAdminInGroup.action?group.id=<s:property value='group.id'/>"></iframe>
		</div>
	</sj:tabbedpanel>
</html>
</page:apply-decorator>