<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="p" uri="/pagination-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="security" uri="/security-tags"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询组信息</title>
<%-- <script type="text/javascript" src="${staticURL}/scripts/fixed_header_column_table.js"></script> --%>
<style type="text/css">
.aui_content {
	padding-bottom: 0px !important;
	padding-left: 0px !important;
	padding-right: 0px !important;
	padding-top: 0px !important;
}
</style> 
<script type="text/javascript">
    
	function createGroupInit() {
		art.dialog({
			title : '创建新组',
			content : document.getElementById('addAdminToGroup'),
			esc : true,
			height : '100px',
			width : '300px',
			esc : true
		});
	}
	function delGroup() {
		var _items = document.getElementsByName('groupcheck');
		var itemvalue = new Array();
		var id;
		var j = 0;
		for ( var i = 0; i < _items.length; i++) {
			if (_items[i].checked) {
				j = j + 1;
				itemvalue[i] = _items[i].value;
				if (j == 1) {
					id = itemvalue[i];
				} else {
					id = id + "," + itemvalue[i];
				}
			}
		}
		if (j == 0) {
			alert("至少选择一条记录进行操作");
		} else if (!confirm("确定要删除这" + j + "个组吗？")) {
			return;
		}
		$.ajaxSetup({
			cache : false
		});
		
		$.getJSON("${dynamicURL}/security/deleteGroup.do?groupIds=" + id,
				function call(data) {
					ifModified: true;
					cache: false;
					if (data.actionMessages != null && data.actionMessages != "") {
						art.dialog({
							title : '成功提示',
							content : '' + data.actionMessages,
							esc : true,
							icon : 'succeed',
							close : function() {
// 								document.frames['addUserToGroupInitFrame'].location.reload();
// 								opener.location.reload();
								var form = $("#searchGroupForm").submit();;
							}
						});
					} else {
						parent.art.dialog({
							title : '失败提示',
							esc : true,
							icon : 'error',
							content : '' + data.actionErrors
						});
					}
				});
		// window.location.href = "${dynamicURL}/security/deleteGroup.action?groupIds="+id;  
	}
	function createGroup() {
		window.location.href = "${dynamicURL}/security/createGroupInit.action";
	}
</script>
<style type="text/css">
.tm {
	background: transparent;
	border-width: 0px;
	border-color: #666666 #999999 #999999 #666666;
	border-style: solid;
	margin-top: 10px;
}
/*input form table style*/
table.form_table2 {
	border: 1px solid #CCCCCC;
	background-color: #ffffff;
	border-collapse: collapse;
}

table.form_table td {
	padding: 2px;
	border-right: 1px solid #C0C0C0;
	border-bottom: 1px solid #C0C0C0;
}

table.form_table th {
	height: 24px;
	padding: 3px;
	border-bottom: 1px solid #A4B5C2;
	border-right: 1px solid #A4B5C2;
	text-align: center;
}
</style>
</head>
<body>

	<dt>
		<h3>权限组列表</h3>
	</dt>
	<dd class="tab1">
		<jsp:include page="/common/messages.jsp" />
		<div id="addAdminToGroup" style="display: none; padding-left: 0px;">
			<iframe id="addAdminToGroupInit" scrolling="no"
				name="addAdminToGroupInit" scrolling="no"
				src="${dynamicURL}/security/createGroupInit.action" frameborder="0"
				width="600px" height="100px" style="overflow: hidden;"></iframe>
		</div>
		
		
		
		
		
		<s:form action="searchGroup" namespace="/security" method="get"
			id="searchGroupForm">
			<table class="form_table">
				<tr>
					<th>组名称:</th>
					<td><s:textfield name="group.name" /></td>
					<th>组描述:</th>
					<td><s:textfield name="group.description" /></td>
					<td colspan="4"><input type="submit" value="查询"
						class="abn db l" /></td>
				</tr>
			</table>
		</s:form>
		<div class="h5"></div>
		<s:set name="displayDeleteButton" value="false" />
		<s:set name="displayAddButton" value="false" />
		<security:auth code="DELETE_GROUP">
			<s:set name="displayDeleteButton" value="true" />
		</security:auth>
		<security:auth code="CREATE_GROUP_INIT">
			<s:set name="displayAddButton" value="true" />
		</security:auth>
		<s:if test="displayDeleteButton">
			<input type="button" class="abn db l" onclick="delGroup()"
				style="cursor: pointer; width: 40px; margin-left: 2px; margin-bottom: 3px"
				value="删除" />
		</s:if>
		<s:if test="displayAddButton">
			<input type="button" class="abn db l" onclick="createGroupInit()"
				style="cursor: pointer;" value="新增" />
		</s:if>
		<table class="color_table" id="groupFixTable">
			<thead>
				<tr>
					<th nowrap="nowrap" style="width: 20px"><input
						name="allgroupcheck" type="checkbox" id="allgroupcheck"
						onclick="checkAll(this.checked, 'groupcheck')" /></th>
					<th nowrap="nowrap">组名称</th>
					<th nowrap="nowrap">组描述</th>
					<th nowrap="nowrap">组编码</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="pager.records" var="group" status="status">
					<tr>
						<td style="width: 20px"><input name="groupcheck"
							type="checkbox" id="groupcheck<s:property value='id'/>"
							value="<s:property value='id'/>"
							onclick="chkeckSingle('groupcheck', 'allgroupcheck')" /></td>
						<td nowrap="nowrap">
						    <a href="${dynamicURL}/security/updateGroupInit.do?group.id=<s:property value='id'/>"/>
						       <s:property value="name" />
						    </a>
						</td>
						<td nowrap="nowrap"><s:property value="description" /></td>
						<td nowrap="nowrap"><s:property value="code" /></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</dd>
	<dd class="dd-fd datagrid-pager pagination">
		<p:pagination pager="pager" formId="searchGroupForm"></p:pagination>
	</dd>
</body>
</html>
</page:apply-decorator>