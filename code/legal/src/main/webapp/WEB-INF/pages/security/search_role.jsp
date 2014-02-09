<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="p" uri="/pagination-tags" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色查询</title>
<meta content="security/" name="modulePath">
<script type="text/javascript">
function doSearch(){
	var url = "${dynamicURL}/security/searchRole.do";
	document.forms[0].action = url;
    document.forms[0].submit();
}
function doDel(roleId){
	if(!window.confirm("确定要删除吗？")){
		return;
	}
	var url = "${dynamicURL}/security/deleteRole.do?roleId="+roleId;
	document.forms[0].action = url;
    document.forms[0].submit();
}
function updateRoleResource(id,name,description){
	var url =  "${dynamicURL}/security/showRoleResource.do?roleId="+id+"&name="+name+"&description="+description;
	document.forms[0].action = url;
    document.forms[0].submit();
}
</script>
</head>
<body>
<dt>
<h3>角色列表</h3>
</dt>
<dd class="tab1">
<jsp:include page="/common/messages.jsp"/>
	<s:form namespace="/security" method="post" id="searchRoleForm">
        <table class="form_table">
				<th>角色名:</th>
				<td><s:textfield name="role.name" /></td>
				<th>角色描述:</th>
				<td><s:textfield name="role.description" /></td>
				<td><input type="button" value="查询" class="abn db" onclick="doSearch()" />&nbsp;&nbsp;
					<a class="abn db" href="${dynamicURL}/security/createRoleInit.do">新建</a>
				</td>
			</table>
	</s:form>
<div class="h5"></div>
<table id="rounded-corner" class="color_table">
	<thead>
		<tr>
			<th class="rounded">角色名</th>
			<th class="rounded">描述</th>
			<th class="rounded">创建者</th>
			<th class="rounded">创建时间</th>
			<th class="rounded">最后修改者</th>
			<th class="rounded">最后修改时间</th>
			<th class="rounded">操作</th>
		</tr>
</thead>
<tbody>
	<s:iterator value="pager.records" var="role" status="status">
	<tr>
		<td><a href="${dynamicURL}/security/updateRoleInit.do?roleId=<s:property value="id"/>"/><s:property value="name"/></a></td>
		<td><s:property value="description"/></td>
		<td><s:property value="createBy"/></td>
		<td><s:date name="gmtCreate" format="yyyy-MM-dd HH:mm:ss"/></td>
		<td><s:property value="lastModifiedBy"/></td>
		<td><s:date name="gmtModified" format="yyyy-MM-dd HH:mm:ss"/></td>
		<td><a href="#"><img border="0" title="" alt="" src="${staticURL}/images/trash.png" onclick="doDel(<s:property value="id"/>)"></a></td>
	</tr>
	</s:iterator>
</tbody>
</table>
</dd>
<dd class="dd-fd">
<p:pagination pager="pager" formId="searchRoleForm"></p:pagination> 
</dd>
</body>
</html>
</page:apply-decorator>