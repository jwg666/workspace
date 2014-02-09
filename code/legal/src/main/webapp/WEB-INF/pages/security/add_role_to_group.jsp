<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="p" uri="/pagination-tags"%>
<%@ taglib prefix="security" uri="/security-tags"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
	<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组内角色查询</title> 
<script type="text/javascript">
var checkedNum = 0; 
	function addRoleToGroup() {
		var _items = document.getElementsByName('rolecheck');
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
		var groupid = document.getElementById('thisgroupid').value;
		if (j == 0) {
			art.dialog({
				title : '警告信息',
				content : '至少选择一条记录',
				esc : true,
				icon : 'warning'
			});
		} else {
			if (!confirm("确定要添加这" + j + "个角色到组吗？")) {
				return;
			}
			var addRoleLoading = art.dialog({title: '请稍后',content: '添加中请稍后...'});
			$.ajaxSetup({
				cache : false
			});
			$.getJSON("${dynamicURL}/security/addRoleToGroup.action?group.id="
					+ groupid + "&roleId=" + id, function call(data) {
				ifModified: true;
				cache: false;
				addRoleLoading.close();
				if (data.actionMessages != null && data.actionMessages != "") {
					art.dialog({
						title : '成功提示',
						content : '' + data.actionMessages,
						esc : true,
						icon : 'succeed',
						time: 2,
						close: function () {  
						    	parent.document.getElementById('addRoleToGroupInit').contentWindow.location.reload(); 
						    	parent.searchRoleInGroupDialog.content(parent.document.getElementById('addRoleToGroup'));
						    }
					});
				} else { 
					art.dialog({
						title : '失败提示',
						content : '' + data.actionErrors,
						esc : true,
						icon : 'error'
					});
				}
			});
		}
	}
</script>
</head>
<body>

	<dt>
		<h3>角色列表</h3>
	</dt>
	<dd class="tab1">
		<jsp:include page="/common/messages.jsp" />
		<s:form action="addRoleToGroupInit" namespace="/security"
			method="post" id="searchRoleForm">
			<s:hidden name="group.id" id="thisgroupid" />
			<table class="form_table">
				<th>角色名:</th>
				<td><s:textfield name="role.name" /></td>
				<th>角色描述:</th>
				<td><s:textfield name="role.description" /></td>
				<td><input type="submit" value="查询" class="abn db l" /></td>
			</table>
		</s:form>
		<div class="h5"></div>
		<input type="button" value="添加" onclick="addRoleToGroup()"
			class="abn db l" style="margin-left: 2px; margin-bottom: 3px;" />
		<table id="rounded-corner" class="color_table">
			<thead>
				<tr>
					<th><input name="allrolecheck" type="checkbox"
						id="allrolecheck" onclick="checkAll(this.checked, 'rolecheck')" /></th>
					<th>角色名</th>
					<th>描述</th>
					<th>创建者</th>
					<th>创建时间</th>
					<th>最后修改者</th>
					<th>最后修改时间</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="pagerRole.records" var="role" status="status">
					<tr>
						<td><input name="rolecheck" type="checkbox"
							id="rolecheck<s:property value='id'/>"
							value="<s:property value='id'/>"
							onclick="chkeckSingle('rolecheck', 'allrolecheck')" /></td>
						<td><s:property value="name" /></td>
						<td><s:property value="description" /></td>
						<td><s:property value="createBy" /></td>
						<td><s:date name="gmtCreate" format="yyyy-MM-dd HH:mm:ss" /></td>
						<td><s:property value="lastModifiedBy" /></td>
						<td><s:date name="gmtModified" format="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</dd>
	<dd class="dd-fd">
		<p:pagination pager="pagerRole" formId="searchRoleForm"></p:pagination>
	</dd>
	<script type="text/javascript"> 
	function checknum(){ 
    		var _items = document.getElementsByName('rolecheck');  
    		var itemvalue = new Array(); 
    		var id;
    		var j = 0;
    		for ( var i = 0; i < _items.length; i++) {
    			if (_items[i].checked) {
    				j = j + 1; 
    				itemvalue[i] = _items[i].value; 
    				if(j==1){
    					id = itemvalue[i];
    				}else{
    					id = id+","+itemvalue[i];
    				}   
    			}
    			checkedNum = j; 
    			}  
	}
    function goto_page(p){   
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的角色添加到组后再翻页");
    	}else{
    	if(!isInt(p)){
    		p =1;
    	}
    	createHiddenCurrentPage(p);
    	createHiddenPageSize();
    	var search_form = document.getElementById("searchRoleForm");
        search_form.submit();
    	}
    }  
    function createHiddenCurrentPage(p){
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的角色添加到组后再翻页");
    	}else{
    	var search_form = document.getElementById("searchRoleForm");
    	search_form['pagerRole.currentPage'] = p; 
    	createHidden(search_form,'pagerRole.currentPage',p);
    	}
    }
    function createHiddenPageSize(){
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的角色添加到组后再翻页");
    	}else{
    	var search_form = document.getElementById("searchRoleForm");
    	var pageSize = document.getElementById('_page_size_').value; 
    	if(!isInt(pageSize)){
    		pageSize = 1;
    	}
    	search_form['pagerRole.pageSize'] = pageSize;
    	createHidden(search_form,'pagerRole.pageSize',pageSize);
    	}
    }
    function createHidden(form,hiddenName,hiddenValue){
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的角色添加到组后再翻页");
    	}else{
    	var hidden = document.createElement("input");
    	hidden.setAttribute("name",hiddenName);
    	hidden.setAttribute("value",hiddenValue);
    	hidden.setAttribute("type","hidden");
    	form.appendChild(hidden);
    	}
    }
    function jumpto_page(){
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的角色添加到组后再翻页");
    	}else{
    	var cur = document.getElementById('_current_page_').value;
    	goto_page(cur);
    	}
    }
    function change_pageSize(){
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的角色添加到组后再翻页");
    	}else{
    	createHiddenPageSize();
    	var cur = document.getElementById('_current_page_').value;
    	createHiddenCurrentPage(cur);
    	var search_form = document.getElementById("searchRoleForm");
    	search_form.submit();
    	}
    }
    function isInt(v){
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的角色添加到组后再翻页");
    	}else{
	    var vArr = v.match(/^[0-9]+$/);
	    if (vArr == null){
	        return false;
	    }else{
	        return true;
	    }
    	}
	}
</script>  
</body>
	</html>
</page:apply-decorator>