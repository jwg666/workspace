<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看用户信息</title>
<meta name="modulePath" content="security/"/>
</head>
<body>
<dt>
	<h3>查看用户信息</h3>
</dt>
<dd class="tab1">
<table id="rounded-corner">
	<tr>
		<th>员工号：</th>
		<td><s:property value="user.empCode"/></td>
		<th>用户姓名：</th>
		<td><s:property value="user.name"/></td>
	</tr>
	<tr>
		<th>邮箱：</th>
		<td><s:property value="user.email"/></td>
		<th>密码：</th>
		<td>******</td>
	</tr>
	<tr>
		<th>状态：</th>
		<td><s:property value="@com.haier.hrois.security.domain.enu.UserStatusEnum@toEnum(user.status).description"/></td>
		<th>账号类型：</th>
		<td><s:property value="@com.haier.hrois.security.domain.enu.UserTypeEnum@toEnum(user.type).description"/></td>
	</tr>
	<tr>
		<th>创建者：</th>
		<td><s:property value="user.createBy"/></td>
		<th>创建时间：</th>
		<td><s:date name="user.gmtCreate" format="yyyy-MM-dd HH:mm:ss"/></td>
	</tr>
	<tr>
		<th>创最后修改者：</th>
		<td><s:property value="user.lastModifiedBy"/></td>
		<th>最后修改时间：</th>
		<td><s:date name="user.gmtModified" format="yyyy-MM-dd HH:mm:ss"/></td>
	</tr>
	<tr>
		<th>上次登陆IP:</th>
		<td><s:property value="user.lastLoginIp" />
		</td>
		<th>上次登陆时间:</th>
		<td><s:date name="user.lastLoginTime" format="yyyy-MM-dd HH:mm:ss" />
		</td>
	</tr>
	<tr>
		<th>登陆失败时间:</th>
		<td><s:date name="user.loginFaildTime" format="yyyy-MM-dd HH:mm:ss" />
		</td>
		<th>登陆失败次数:</th>
		<td><s:property value="user.loginAttemptTimes" /></td>
	</tr>
	<tr>
	<th>过期时间<span class="star">*</span>：</th>
					<td colspan="1"><!-- <input type="text" name="" id="expired" /> --> 
					 <%-- <sj:datepicker id="expired" name="expired" maxDate="-1d" label="Select a Date" />  --%>
					  <s:date name="user.expiredTime" format="yyyy-MM-dd"/> 
					</td>
	</tr>
</table>
</dd>
</body>
</html>