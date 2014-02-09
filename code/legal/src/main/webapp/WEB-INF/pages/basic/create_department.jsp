<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.thd">
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="hop" uri="/hoptree-tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>创建部门</title>
<link rel="stylesheet" href="${staticURL}/style/hopCss/hop.css" type="text/css">
<script type="text/javascript" src="${staticURL}/scripts/hop.js"></script>
<script type="text/javascript" src="${staticURL}/scripts/jquery.ztree.all-3.5.js"></script>
<script>
$.ajaxSetup({
	dataType : 'json'
});
//此函数为ztree中callback函数，请确保该函数定义在hop:tree之前，一般定义在<head>的<script>中即可
function zTreeOnCheck(event, treeId, treeNode) {
	if(treeNode.checked == true){
		$("#parent_department_id").val(treeNode.id);
	}else{
		$("#parent_department_id").val('');
	}
}
</script>
</head>
<body>
<dt>
	<h3>创建部门</h3>
</dt>
<dd class="tab1">
<jsp:include page="/common/messages.jsp"/>
	<s:form action="createDepartment" namespace="/basic" method="post">
        <table class="form_table">
            <tr>
                <th>部门名称<span class="star">*</span>:</th>
                <td><s:textfield name="department.name" size="54" /></td>
            </tr>
            <tr>
                <th>部门Code<span class="star">*</span>:</th>
                <td><s:textfield name="department.code" size="54" /></td>
            </tr>
            <tr>
                <th>上级部门:</th>
                <td>
                	<hop:tree url="${dynamicURL}/basic/departmentTree.action"
							expandUrl="${dynamicURL}/basic/departmentTree.action" 
							async="true" 
							chkType="radio" 
							id="depTree"
							setting="{check: {enable: true, chkStyle: 'radio', radioType: 'all'}, data: {simpleData: { enable: true}}, async: {enable:true, url: getTreeExpandUrl},callback:{onCheck: zTreeOnCheck} };"
							>
					</hop:tree>
                	<s:hidden name="department.parent.id" id="parent_department_id"/>
                </td>
            </tr>
            <tr>
                <th>部门状态<span class="star">*</span>:</th>
                <td><s:select name="department.status" list="#{1:'启用',0:'禁用'}"/>
                </td>
            </tr>
            <tr>
                <th>描述:</th>
                <td>
                	<s:textarea name="department.description" rows="5" cols="45"></s:textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:submit value="创建" id="submit"
							targets="formResult" 
							onCompleteTopics="handleResult" cssClass="abn"/><input type="reset" value="重置" class="abn"/></td>
            </tr>
        </table>
	</s:form>
</dd>
<script type="text/javascript">
	//页面加载完毕后选中当前资源的父资源
	$.subscribe('handleResult',function(event, data) {
		handleErrors(event,data,{
			onSuccess : function() {
				window.location.href = '${dynamicURL}/basic/searchDepartment.action';
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
</script>
</body>
</html>