<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%-- <%@ taglib prefix="sj" uri="/struts-jquery-tags"%> --%>
<%@ taglib prefix="hop" uri="/hoptree-tags" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>修改角色信息</title>
<link rel="stylesheet" href="${staticURL}/style/hopCss/hop.css" type="text/css">
<script type="text/javascript" src="${staticURL}/scripts/hop.js"></script>
<script type="text/javascript" src="${staticURL}/scripts/jquery.ztree.all-3.5.js?v=1.0"></script>
<script>
$.ajaxSetup({
	dataType : 'json'
});
//此函数为ztree中callback函数，请确保该函数定义在hop:tree之前，一般定义在<head>的<script>中即可
function zTreeOnCheck(event, treeId, treeNode) {
	var treeObj = $.fn.zTree.getZTreeObj("depTree");
	var nodes = treeObj.getCheckedNodes(true);
	var ids = new Array();
	for(var i =0;i < nodes.length; i++){
		ids.push(nodes[i].id);
	}
	$("#resourceIds").val(ids.join())
}
</script>
</head>
<body>
	<dt>
		<h3>修改角色</h3>
	</dt>
	<dd class="tab1">
	<jsp:include page="/common/messages.jsp"/>
		<s:form action="updateRole" namespace="/security" method="post">
			<s:hidden name="role.id"></s:hidden>
			<input id="resourceIds" type="hidden" name="resourceIds"/>
			<table>
				<tr>
					<th>角色名称<span class="star">*</span>：
					</th>
					<td><s:textfield name="role.name" size="54"></s:textfield></td>
				</tr>
				<tr>
					<th>描述：</th>
					<td><s:textarea name="role.description" rows="5" cols="45"></s:textarea></td>
				</tr>
				<tr>
					<th>资源：</th>
					<td><s:property value="%{#resource.id}"/>
						<hop:tree url="${dynamicURL}/security/displayResourceTree.do?id=0&expandId=${resource.id}"
								expandUrl="${dynamicURL}/security/expandingResourceTree.do" 
								async="true" 
								chkType="check" 
								id="depTree"
								setting="{check: {enable: true}, data: {simpleData: { enable: true}}, async: {enable:true, url: getTreeExpandUrl},callback:{onCheck: zTreeOnCheck} };"
								>
						</hop:tree>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><%-- <sj:submit value="修改" Class="abn" onCompleteTopics="handleResult" targets="formResult" onBeforeTopics="setResourceIds"/> --%></td>
				</tr>
			</table>
		</s:form>
	</dd>
<script type="text/javascript">
	$.subscribe('handleResult',function(event, data) {
		handleErrors(event,data,{
			onSuccess : function() {
				window.location.href = '${dynamicURL}/security/searchRole.do';
			}
		});
	});
	function findNode(nodes, pId) {
		if(nodes != null) {
			for (var i = 0; i < nodes.length; i++){
				if (nodes[i].id == pId) {
					return nodes[i];
				} else {
					var children = nodes[i].children;
					var found = findNode(children, pId);
					if(found != null) {
						return found;
					}
				}
			}
		}
		return null;
	}
	// 选中上级目录
 	$(function () {
 		var ids = new Array();
 		var treeObj = $.fn.zTree.getZTreeObj("depTree");
		var nodes = treeObj.getNodes();
 		<s:iterator value="role.resources" var="res">
	 		var resourceId = "<s:property value='#res.id'/>";
	 		ids.push(resourceId);
			var prt = findNode(nodes, resourceId);	// 查找父节点
			treeObj.checkNode(prt, true);	// 选中父节点
			//treeObj.selectNode(prt);	// 选择（高亮显示）节点
			treeObj.expandNode(prt, true);	// 展开节点
		</s:iterator>
		$("#resourceIds").val(ids.join())
    }); 
	
</script>
</body>
</html>
</page:apply-decorator>