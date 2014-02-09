<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="p" uri="/pagination-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>日志查询</title>
</head>
<body>
<dt>
<h3>部门列表</h3>
</dt>
<dd class="tab1">
<jsp:include page="/common/messages.jsp"/>
	<s:form namespace="/security" method="post" id="searchLogForm" action="searchOperationLog">
        <table class="form_table">
				<th>开始时间:</th>
				<td><sj:datepicker name="searchModel.from" timepicker="false" displayFormat="yy-mm-dd"/></td>
				<th>结束时间:</th>
				<td><sj:datepicker name="searchModel.to" timepicker="false" displayFormat="yy-mm-dd"/></td>
				<td><input type="button" value="查询" class="abn db l" onclick="$('#searchLogForm').submit()" />
				</td>
			</table>
	</s:form>
<br/>
<table id="rounded-corner" class="color_table">
	<thead>
		<tr>
			<th class="rounded">事件</th>
			<th class="rounded">操作人</th>
			<th class="rounded">操作时间</th>
		</tr>
</thead>
<tbody>
	<s:iterator value="pager.records" var="department" status="status">
	<tr>
		<td><s:property value="description"/></td>
		<td><s:property value="userName"/></td>
		<td><s:date name="gmtCreate" format="yyyy-MM-dd HH:mm:ss"/></td>
	</tr>
	</s:iterator>
</tbody>
</table>
</dd>
<dd class="dd-fd">
<p:pagination pager="pager" formId="searchLogForm"></p:pagination> 
</dd>
</body>
</html>