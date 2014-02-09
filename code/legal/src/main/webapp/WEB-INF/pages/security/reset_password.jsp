<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>重置密码</title>
<meta content="user/" name="modulePath">
</head>
<body>
	<dt>
		<h3>重置密码</h3>
	</dt>
	<dd class="tab1">
		<jsp:include page="/common/messages.jsp" />
		<s:form action="resetPassword" namespace="/security" method="post">
		<s:hidden name="userId"/>
		<s:hidden name="password" value="1111"/>
			<table class="form_table">
				<tr>
					<th>账号:</th>
					<td><s:property value="user.empCode"/></td>
					<th>姓名:</th>
					<td><s:property value="user.name"/></td>
				</tr>
				<tr>
					<th>密码<span class="star">*</span>:</th>
					<td><input type="password" name="newPassword"/>
					</td>
					<th>确认密码<span class="star">*</span>:</th>
					<td><input type="password" name="confirmPassword" />
				</tr>
				<tr>
					<td colspan="4"><sj:submit value="提交" id="submit"
							targets="formResult" onCompleteTopics="handleResult" cssClass="abn"/></td>
				</tr>
			</table>
		</s:form>
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