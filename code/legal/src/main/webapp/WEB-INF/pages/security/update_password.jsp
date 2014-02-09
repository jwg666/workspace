<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<meta content="user/" name="modulePath">
</head>
<body>
	<dt>
		<h3>修改密码</h3>
	</dt>
	<dd class="tab1">
		<jsp:include page="/common/messages.jsp" />
		<s:form action="updatePassword" namespace="/security" method="post">
		<s:hidden id="departmentIds" name="departmentIds" />
		<s:hidden id="roleIds" name="roleIds" />
			<table class="form_table">
				<tr>
					<th>旧密码<span class="star">*</span>:</th>
					<td><input type="password" name="password" value="${password}"/>
					</td>
					<th>新密码<span class="star">*</span>:</th>
					<td><input type="password" name="newPassword" value="${newPassword}"/>
					</td>
					<th>确认密码<span class="star">*</span>:</th>
					<td><input type="password" name="confirmPassword" value="${confirmPassword}"/>
					</td>
					<td><input type="submit" value="提交" class="abn db"/>&nbsp;&nbsp;<input type="reset" value="重置" class="abn db"/></td>
				</tr>
			</table>
		</s:form>
	</dd>
</body>
</html>