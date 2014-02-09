<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="p" uri="/pagination-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门查询</title>
<script type="text/javascript">
function doSearch(){
	var url = "${dynamicURL}/basic/searchDepartment.action";
	document.forms[0].action = url;
    document.forms[0].submit();
}
function doDel(departmentId){
	if(!window.confirm("确定要删除吗？")){
		return;
	}
	window.location.href = "${dynamicURL}/basic/deleteDepartment.action?id="+departmentId;
	//document.forms[0].action = "${dynamicURL}/basic/deleteDepartment.action?id="+departmentId;
    //document.forms[0].submit();
}
</script>
</head>
<body>
<dt>
<h3>部门列表</h3>
</dt>
<dd class="tab1">
<jsp:include page="/common/messages.jsp"/>
	<s:form namespace="/basic" method="post" id="searchDepartmentForm" action="searchDepartment">
        <table class="form_table">
				<th>部门名:</th>
				<td><s:textfield name="department.name" /></td>
				<th>Code:</th>
				<td><s:textfield name="department.code" /></td>
				<th>部门描述:</th>
				<td><s:textfield name="department.description" /></td>
				<td><input type="button" value="查询" class="abn db l" onclick="doSearch()" />&nbsp;&nbsp;
					<a class="abn db l" href="${dynamicURL}/basic/createDepartmentInit.action">新建</a>
				</td>
			</table>
	</s:form>
<br/>
<table id="rounded-corner" class="color_table">
	<thead>
		<tr>
			<th class="rounded">部门名</th>
			<th class="rounded">Code</th>
			<th class="rounded">描述</th>
			<th class="rounded">创建者</th>
			<th class="rounded">创建时间</th>
			<th class="rounded">最后修改者</th>
			<th class="rounded">最后修改时间</th>
			<th class="rounded">操作</th>
		</tr>
</thead>
<tbody>
	<s:iterator value="pager.records" var="department" status="status">
	<tr>
		<td><a href="${dynamicURL}/basic/updateDepartmentInit.action?department.id=<s:property value="id"/>"/><s:property value="name"/></a></td>
		<td><s:property value="code"/></td>
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
<p:pagination pager="pager" formId="searchDepartmentForm"></p:pagination> 
</dd>
</body>
</html>