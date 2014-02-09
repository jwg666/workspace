<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="hop" uri="/hoptree-tags" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>创建角色</title>
<link rel="stylesheet" href="${staticURL}/style/hopCss/hop.css" type="text/css">
<script type="text/javascript" src="${staticURL}/scripts/hop.js"></script>
<script type="text/javascript" src="${staticURL}/scripts/jquery.ztree.all-3.5.js"></script>
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
	$("#resourceIds").val(ids.join());
}
</script>
</head>
<body>
<dd class="tab1">
<jsp:include page="/common/messages.jsp"/>
<s:form namespace="/security" method="post" id="createRole" action="createRole">
	<input type="hidden" id="resourceIds" name="resourceIds"/>
	<table class="form_table">
		<tr>
			<th>角色名称<span class="star">*</span>：</th>
			<td><s:textfield name="role.name" id="roleName" size="54"/></td>
		</tr>
		<tr>
			<th>描述：</th>
			<td><s:textarea name="role.description" rows="5" cols="45"></s:textarea></td>
		</tr>
		<tr>
			<th>资源：</th>
			<td>
				<hop:tree url="${dynamicURL}/security/resourceTree.do"
						expandUrl="${dynamicURL}/security/resourceTree.do" 
						async="true" 
						chkType="check" 
						id="depTree"
						setting="{check: {enable: true}, data: {simpleData: { enable: true}}, async: {enable:true, url: getTreeExpandUrl},callback:{onCheck: zTreeOnCheck} };"
						>
				</hop:tree>
			</td>
		</tr>
		<tr>
			<td colspan="2"><sj:submit value="创建" id="submit"
							onBeforeTopics="setResourceIds"
							targets="formResult" 
							onCompleteTopics="handleResult" cssClass="abn"/><input type="reset" value="重置" class="abn"/></td>
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
</script>
</body>
</html>
</page:apply-decorator>