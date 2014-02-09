<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="hop" uri="/hoptree-tags" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
<html>
<head>
<title>修改用户信息</title>
<link rel="stylesheet" href="${staticURL}/style/hopCss/tree.css" type="text/css">
<script src="${staticURL}/scripts/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="${staticURL}/scripts/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript">
$.ajaxSetup({
	dataType : 'json'
});
function zTreeOnCheckForAdd(event, treeId, treeNode) {
	var treeObj = $.fn.zTree.getZTreeObj("depTree");
	var nodes = treeObj.getCheckedNodes(true);
	var ids = new Array();
	for(var i =0;i < nodes.length; i++){
		ids.push(nodes[i].id);
		$("#departments").val(ids.join());
	}
}
</script>

</head>
<body>
	<dt>
		<h3>修改用户信息</h3>
	</dt>
	<dd class="tab1">
	<jsp:include page="/common/messages.jsp"/>
		<s:form action="updateUser" namespace="/security" method="post">
		<s:hidden id="departments" name="user.departments" />
		<s:hidden name="user.id"/>
			<table class="form_table">
				<tr>
					<th>员工号<span class="star">*</span>:</th>
					<td><s:textfield name="user.empCode" size="40"/></td>
					<th>用户姓名<span class="star">*</span>:</th>
					<td><s:textfield name="user.name" size="40" /></td>
				</tr>
				<tr>
					<th>邮箱<span class="star">*</span>:</th>
					<td><s:textfield name="user.email"  size="40" />
					</td>
					<th>状态<span class="star">*</span>:</th>
					<td><s:select name="user.status" list="#{1:'正常',0:'锁定'}" />
					</td>
				</tr>
				<tr>
					<th>创建者:</th>
					<td><s:property value="user.createBy" />
					</td>
					<th>创建时间:</th>
					<td><s:date name="user.gmtCreate" format="yyyy-MM-dd HH:mm:ss" />
					</td>
				</tr>
				<tr>
					<th>最后修改者:</th>
					<td><s:property value="user.lastModifiedBy" />
					</td>
					<th>最后修改时间:</th>
					<td><s:date name="user.gmtModified" format="yyyy-MM-dd HH:mm:ss" />
					</td>
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
					<th>上次登陆失败时间:</th>
					<td><s:date name="user.loginFaildTime" format="yyyy-MM-dd HH:mm:ss" />
					</td>
					<th>登陆失败次数:</th>
					<td><s:property value="user.loginAttemptTimes" /></td>
				</tr>
				<tr>
					<th>数据权限:</th>
					<td colspan="3">
					<hop:tree url="${dynamicURL}/basic/userDataConfigAction!buildTree.action?empCode=${user.empCode}"
									expandUrl="${dynamicURL}/basic/userDataConfigAction!buildTree.action" 
									async="true" 
									chkType="check" 
									id="depTree"
									setting="{check: {enable: true}, data: {simpleData: { enable: true}}, async: {enable:true, url: getTreeExpandUrl},callback:{onCheck: zTreeOnCheckForAdd} };"
									>
					</hop:tree>
					</td>
				</tr>
				<tr>
					<th>账号类型<span class="star">*</span>：</th>
					<td><s:select name="user.type" list="#{0:'普通账号',1:'域账号'}" />
					</td>
					<th>过期时间<span class="star">*</span>：</th>
					<td colspan="1">
						 <sj:datepicker id="expiredTime" size="30" name="user.expiredTime" label="Select a Date/Time" timepicker="false" displayFormat="yy-mm-dd"/>  
					</td>
				</tr>
				<tr> 
					<td colspan="2"></td> 
					<td colspan="2"><sj:submit value="保存" id="submit" onClickTopics="click"
							targets="formResult"
							onCompleteTopics="handleResult" cssClass="abn db l" /></td>
				</tr>
			</table>
		</s:form>
	</dd>
	<dd class="dd-fd">
		<p:pagination pager="pager" formId="searchResourceForm"></p:pagination>
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
	$(function(){
		var treeObj = $.fn.zTree.getZTreeObj("depTree");
		var nodes = treeObj.getCheckedNodes(true);
		for(var i =0;i < nodes.length; i++){
			treeObj.expandNode(nodes[i], true);	
		}
	});
</script>
</body>
</html>
</page:apply-decorator>