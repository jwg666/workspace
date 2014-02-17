<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="p" uri="/pagination-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="security" uri="/security-tags"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
	<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组内用户查询</title> 
<script type="text/javascript">  
var checkedNum = 0; 
function addUserToGroup(){
	var _items = document.getElementsByName('usercheck');  
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
		}    
	var groupid = document.getElementById('thisgroupid').value; 
	if(j==0){
		art.dialog({
			title: '警告信息',
		    content: '至少选择一条记录',  
		    esc: true,
		    icon: 'warning' 
		});   
	} else {
		if(!confirm("确定要添加这"+j+"个人员到组吗？")){
		return;
	    }  
		var addUserLoading = art.dialog({title: '请稍后',content: '添加中请稍后...'});
	$.ajaxSetup ({ 
		cache: false 
		}); 
	$.getJSON("${dynamicURL}/security/addUserToGroup.action?group.id="+groupid+"&userId="+id, 
			function call(data){ 
			 ifModified:true;
			 cache: false;
			addUserLoading.close();
			if(data.actionMessages != null && data.actionMessages != ""){
				art.dialog({
					title: '成功提示',
				    content: ''+data.actionMessages,  
				    esc: true,
				    icon: 'succeed',
				    time: 2,
				    close: function () {  
				    	parent.document.getElementById('addUserToGroupInit').contentWindow.location.reload(); 
				    	parent.searchUserInGroupDialog.content(parent.document.getElementById('addUserToGroup'));
				    }
				});    
			}else{ 
				art.dialog({
					title: '失败提示',
				    content: ''+data.actionErrors,  
				    esc: true,
				    icon: 'error' 
				});   
			}
	}); 
	} 
}

</script>
</head>
<body>

	<dt>
		<h3>用户列表</h3>
	</dt>
	<dd class="tab1" style="width: 100%;">
		<jsp:include page="/common/messages.jsp" />
		<s:form action="addUserToGroupInit" namespace="/security" method="get"
			id="searchUserForm">
			<s:hidden name="group.id" id="thisgroupid" />
			<table class="form_table">
				<tr>
					<th>员工号：</th>
					<td><s:textfield name="user.empCode" /></td>
					<th>用戶名：</th>
					<td><s:textfield name="user.name" /></td>
					<th>Email：</th>
					<td><s:textfield name="user.email" /></td>
					<td><input type="submit" value="查询" class="abn db" /></td>
				</tr>
			</table>
		</s:form>
		<div class="h5"></div>
		<input type="button" value="添加" onclick="addUserToGroup()"
			class="abn db" style="margin-bottom: 3px;margin-left: 2px" />
		<table id="rounded-corner" class="color_table">
			<thead>
				<tr>
					<th nowrap="nowrap"><input name="allusercheck" type="checkbox"
						id="allusercheck" onclick="checkAll(this.checked, 'usercheck')" />
					</th>
					<th style="width: 80px; font-size: 12px;">员工号</th>
					<th style="width: 80px; font-size: 12px;">用户名</th>
					<th style="width: 100px; font-size: 12px;" nowrap="nowrap">邮箱
					</th>
					<th style="width: 80px; font-size: 12px;" nowrap="nowrap">类型</th>
					<th style="width: 80px; font-size: 12px;" nowrap="nowrap">状态</th>
					<th style="width: 120px; font-size: 12px;" nowrap="nowrap">
						最近登陆IP</th>
					<th style="width: 160px; font-size: 12px;" nowrap="nowrap">
						最近登陆时间</th>
				</tr>
			</thead>
			<tbody>
				<!-- 数据行 -->
				<s:iterator value="pagerUser.records" var="user" status="status">
					<tr>
						<td style="width: 12PX;"><input name="usercheck"
							type="checkbox" id="usercheck<s:property value='id'/>"
							value="<s:property value='id'/>"
							onclick="chkeckSingle('usercheck', 'allusercheck')" /></td>
						<td style="font-size: 12px;" nowrap="nowrap"><s:property
								value="empCode" /></td>
						<td style="font-size: 12px;" nowrap="nowrap"><s:property
								value="name" /></td>
						<td style="font-size: 12px;" nowrap="nowrap"><s:property
								value="email" /></td>
						<td style="font-size: 12px;" nowrap="nowrap"><s:property
								value="@com.neusoft.security.domain.enu.UserTypeEnum@toEnum(type).description" /></td>
						<td style="font-size: 12px;" nowrap="nowrap"><s:property
								value="@com.neusoft.security.domain.enu.UserStatusEnum@toEnum(status).description" /></td>
						<td style="font-size: 12px;" nowrap="nowrap"><s:property
								value="currentLoginIp" /></td>
						<td style="font-size: 12px;" nowrap="nowrap"><s:date
								name="lastLoginTime" format="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>

		<div id="footer-container" class="dd-fd"
			style="float: left; width: 100%">
			<p:pagination pager="pagerUser" formId="searchUserForm"></p:pagination>
		</div> 
	</dd>
<script type="text/javascript"> 
	function checknum(){ 
    		var _items = document.getElementsByName('usercheck');  
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
    		alert("请将选择的用户添加到组后再翻页");
    	}else{
    	if(!isInt(p)){
    		p =1;
    	}
    	createHiddenCurrentPage(p);
    	createHiddenPageSize();
    	var search_form = document.getElementById("searchUserForm");
        search_form.submit();
    	}
    }  
    function createHiddenCurrentPage(p){
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的用户添加到组后再翻页");
    	}else{
    	var search_form = document.getElementById("searchUserForm");
    	search_form['pagerUser.currentPage'] = p; 
    	createHidden(search_form,'pagerUser.currentPage',p);
    	}
    }
    function createHiddenPageSize(){
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的用户添加到组后再翻页");
    	}else{
    	var search_form = document.getElementById("searchUserForm");
    	var pageSize = document.getElementById('_page_size_').value; 
    	if(!isInt(pageSize)){
    		pageSize = 1;
    	}
    	search_form['pagerUser.pageSize'] = pageSize;
    	createHidden(search_form,'pagerUser.pageSize',pageSize);
    	}
    }
    function createHidden(form,hiddenName,hiddenValue){
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的用户添加到组后再翻页");
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
    		alert("请将选择的用户添加到组后再翻页");
    	}else{
    	var cur = document.getElementById('_current_page_').value;
    	goto_page(cur);
    	}
    }
    function change_pageSize(){
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的用户添加到组后再翻页");
    	}else{
    	createHiddenPageSize();
    	var cur = document.getElementById('_current_page_').value;
    	createHiddenCurrentPage(cur);
    	var search_form = document.getElementById("searchUserForm");
    	search_form.submit();
    	}
    }
    function isInt(v){
    	checknum(); 
    	if(checkedNum > 0){
    		alert("请将选择的用户添加到组后再翻页");
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
