<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="hop" uri="/hoptree-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>

<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
<html>
<head>
<title>创建用户</title>
<script type="text/javascript" src="${staticURL}/scripts/hop.js"></script>
<script src="${staticURL}/scripts/jquery-ui-1.8.1.custom.min.js"></script>
<script src="${staticURL}/scripts/jquery.ui.datepicker.js"></script>
<link rel="stylesheet" href="${staticURL}/style/hopCss/tree.css" type="text/css">
<script type="text/javascript" src="${staticURL}/scripts/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript">
$.ajaxSetup({
	dataType : 'json'
});
function zTreeOnCheckForAdd(event, treeId, treeNode) {
	var treeObj = $.fn.zTree.getZTreeObj("depTree");
	var nodes = treeObj.getCheckedNodes(true);
	var ids = new Array();
	for(var i =0;i < nodes.length; i++){
		ids.push(nodes[i].id);
		$("#departments").val(ids.join());
	}
}
</script>
</head>
<body>
	<dt>
		<h3>创建用户信息</h3>
	</dt>
	<dd class="tab1">
	<jsp:include page="/common/messages.jsp"/>
		<s:form id="upUserForm" name="upUserForm" action="createUser" namespace="/security" method="post">
		<s:hidden id="roleIds" name="roleIds" />
		<s:hidden id="departments" name="user.departments" />
			<table class="form_table">
				<tr>
					<th>登录名(员工号)<span class="star">*</span>:</th>
					<td><s:textfield name="user.empCode" size="30"/></td>
					<th>用户姓名<span class="star">*</span>:</th>
					<td><s:textfield name="user.name" size="30"/></td>
				</tr>
				<tr>
					<th>密码<span class="star">*</span>:</th>
					<td><s:password name="user.password" size="30"/></td>
					<th>确认密码<span class="star">*</span>:</th>
					<td><s:password name="confirmPassword" size="30"/></td>
				</tr>
				<tr>
					<th>数据权限:</th>
					<td colspan="3">
						<hop:tree url="${dynamicURL}/basic/userDataConfigAction!buildTree.action"
									expandUrl="${dynamicURL}/basic/userDataConfigAction!buildTree.action" 
									async="true" 
									chkType="check" 
									id="depTree"
									setting="{check: {enable: true, chkStyle: 'checkbox'}, data: {simpleData: { enable: true}}, async: {enable:true, url: getTreeExpandUrl},callback:{onCheck: zTreeOnCheckForAdd} };"
									>
						</hop:tree>
					</td>
				</tr>
				<tr>
					<th>邮箱<span class="star">*</span>:</th>
					<td><s:textfield name="user.email" size="30"/></td>
					<th>状态<span class="star">*</span>:</th>
					<td><s:select name="user.status" list="#{1:'正常',0:'锁定'}" /></td>
				</tr>
				<%-- <tr>
					<th>角色:</th>
					<td colspan="3">
						<div>
							<table rules="none">
								<s:iterator value="roles" var="role" status="status">
									<s:if test="#status.count%6==1">
										<tr>
									</s:if>
									<td style="border: 0"><input type="checkbox" name="checkbox"
										value='<s:property value="id"/>'> <s:property
											value="name" /></td>
								</s:iterator>
							</table>
						</div></td>
				</tr> --%>
				<tr>
					<th>账号类型<span class="star">*</span>：</th>
					<td><s:select name="user.type" list="#{0:'普通账号',1:'域账号'}" />
					</td>
					<th>过期时间<span class="star">*</span>：</th>
					<td colspan="1"><!-- <input type="text" name="" id="expired" /> --> 
					 <%-- <sj:datepicker id="expired" name="expired" maxDate="-1d" label="Select a Date" />  --%>
					  <sj:datepicker id="expiredTime" size="30" name="user.expiredTime" label="Select a Date/Time" timepicker="false" displayFormat="yy-mm-dd"/> 
					</td>
				</tr>
				<tr> 
					<td colspan="2"></td> 
					<td colspan="2">
					<sj:submit value="创建" id="submit" onClickTopics="click"
							targets="formResult"  onBeforeTopics="setDepartmentIds"
							onCompleteTopics="handleResult" cssClass="abn"></sj:submit>
							&nbsp;&nbsp;
							<input type="reset" class="abn" value="重置" /></td>
				</tr>
			</table>
		</s:form>
	</dd>
	<dd class="dd-fd">
		<p:pagination pager="pager" formId="searchResourceForm"></p:pagination>
	</dd>
<script type="text/javascript">
	$.subscribe('handleResult',
		function(event, data) {
			handleErrors(event,data,{
				onFaild : function() {
					return;
				},
				onSuccess : function() {
					window.location.href = '${dynamicURL}/security/searchUser.action';
				}
		});
	});
</script>
</body>
</html>
</page:apply-decorator>