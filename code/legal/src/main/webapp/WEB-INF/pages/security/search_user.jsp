<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="p" uri="/pagination-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="security" uri="/security-tags" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
<html>
<head>
<title>用户查询</title>
<script type="text/javascript"
	src="${staticURL}/scripts/fixed_header_column_table.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	FixTable("HopFixTable", 1, "100%", "500", "scroll", "scroll");   
});
</script>
</head>
<body>
	<dt>
		<h3>用户查询</h3>
	</dt>
	<dd class="tab1">
	<jsp:include page="/common/messages.jsp"/>
		<s:form action="searchUser" namespace="/security" method="get"
			id="searchUserForm">
			<table class="form_table">
				<tr>
					<th>登录名：</th>
					<td><s:textfield name="user.empCode" /></td>
					<th>用戶名：</th>
					<td><s:textfield name="user.name" /></td>
					<th>Email：</th>
					<td><s:textfield name="user.email" /></td>
					<td><input type="submit" value="查询"
						onclick="submitForm('searchUser');" class="abn db" />&nbsp;&nbsp;
						<input type="button" value="新建" onclick="creatUser()"
						class="abn db" />&nbsp;&nbsp; <input type="submit" value="导出"
						onclick="submitForm('exportUserList');" class="abn db" /></td>
				</tr>
			</table>
		</s:form>
		<s:set name="displayDeleteButton" value="false" />
		<s:set name="displayResetPasswordButton" value="false" />
		<security:auth code="SECURITY_DELETE_USER">
			<s:set name="displayDeleteButton" value="true" />
		</security:auth>
		<security:auth code="SECURITY_RESET_PASSWORD">
			<s:set name="displayResetPasswordButton" value="true" />
		</security:auth>
		<div class="h5"></div>
		<table class="color_table">
			<thead>
				<tr>
					<th>登录名</th>
					<th>用户名</th>
					<th>邮箱</th>
					<th>部门</th>
					<th>状态</th>
					<th>最近登陆IP</th>
					<th>最近登陆时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<!-- 数据行 -->
				<s:iterator value="pager.records" var="user" status="status">
					<tr>
						<td>
							<a href='${dynamicURL}/security/updateUserInit.do?user.id=<s:property value="id"/>'>
								<s:property value="empCode" />
							</a>
						</td>
						<td><s:property
								value="name" /></td>
						<td><s:property
								value="email" /></td>
						<td><s:iterator
								value="departments" var="dep">
								<s:property value="#dep.name" />&nbsp;
						</s:iterator></td>
						<td><s:property
								value="@com.haier.hrois.security.domain.enu.UserStatusEnum@toEnum(status).description" /></td>
						<td><s:property
								value="currentLoginIp" /></td>
						<td><s:date
								name="lastLoginTime" format="yyyy-MM-dd HH:mm:ss" /></td>
						<td>
							<div style="float: left;">
									<s:if test="#displayDeleteButton==true">
										<img title="删除" border="0" src="${staticURL}/images/trash.png"
											onclick="delUser(<s:property value="id"/>)">
									</s:if>
								</div> 
								<div style="float: left;margin-left: 3px;">
									<s:if test="#displayResetPasswordButton==true">
										<a title="重置密码"
											href="${dynamicURL}/security/resetPasswordInit.action?userId=<s:property value='id'/>"><img
											border="0" src="${staticURL}/style/images/user.gif" /></a>
									</s:if>
								</div>
						</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</dd>
	<dd class="dd-fd">
		<p:pagination pager="pager" formId="searchUserForm"></p:pagination>
	</dd>
<script type="text/javascript">
//删除
function delUser(id){
	if (!confirm("确定要删除吗？")){
		return;
	}
	window.location.href = "${dynamicURL}/security/deleteUser.action?userId="+id;
}
function creatUser(){
	window.location.href = "${dynamicURL}/security/createUserInit.do";
}
function submitForm(action){
	var form = document.getElementById("searchUserForm");
	form.action="${dynamicURL}/security/"+action+".do";
	form.submit();
}
</script>
</body>
</html>
</page:apply-decorator>