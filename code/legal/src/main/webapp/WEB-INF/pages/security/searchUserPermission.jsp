<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/security/sysUserAction!datagrid.do',
			//pagination : true,
			//pagePosition : 'bottom',
			rownumbers : true,
			//pageSize : 10,
			//pageList : [ 10, 20, 30, 40 ],
			fit : true,
			//nowrap : false,
			border : false,
			columns:[ [ 
				{field:'role',title:'用户角色',align:'left',formatter:formatter},
				{field:'empCode',title:'用户账号',align:'left',formatter:formatter},
				{field:'userName',title:'用户姓名',align:'left',formatter:formatter},
				{field:'state',title:'账号状态',align:'left',formatter:formatter},
				{field:'email',title:'邮箱',align:'left',formatter:formatter},
				{field:'authorityPermission',title:'模块权限',align:'left',formatter:formatter},
				{field:'functionPermission',title:'功能权限',align:'left',formatter:formatter}
				//{field:'dataPermission',title:'数据权限',align:'left',formatter:formatter}
			 ] ]
		});

	});

	function _search() {
		datagrid.datagrid("unselectAll");
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid("unselectAll");
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function formatter(value,row,index){
		if(value!=null && value.length>50){
			var div = $("<div><p></p></div>");
			var inner = div.find("p");
			inner.html(value.substring(0,50));
			inner.attr('title',value);
			return div.html();
		}
		return value;
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" class="zoc" border="false" title="过滤条件" collapsed="true"  style="height: 120px;overflow: hidden;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc"><span>查询与操作：</span></div>
	            <div class="oneline">
	                <div class="item25">
	                    <div class="itemleft60">用户角色：</div>
	                    <div class="righttext">
	                    	 <input name="role" type="text"/>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60">用户账号：</div>
	                    <div class="righttext">
	                    	 <input name="empCode" type="text"/>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60">用户姓名：</div>
	                    <div class="righttext_easyui">
	                    	<input name="userName" type="text"/>
						</div>
	                </div>
	                <div class="item25">
	                   <div class="itemleft60">账号状态：</div>
	                   <div class="righttext_easyui">
					   		<select name="state" style="width:155px;" >
								<option value="">全部</option>
								<option value="有效">有效</option>
								<option value="无效">无效</option>	                    	
	                    	</select>
					   </div>
	                </div>
	                <div class="item25 lastitem">
	                   <div class="itemleft60">邮箱：</div>
	                   <div class="righttext_easyui">
					   		<input name="email" type="text"/>
					   </div>
	                </div>
	             </div>
	            <div class="oneline">
	                <div class="item25">
	                    <div class="itemleft60">模块权限：</div>
	                    <div class="righttext">
	                    	 <input name="authorityPermission" type="text"/>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60">功能权限：</div>
	                    <div class="righttext">
	                    	 <input name="functionPermission" type="text"/>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60">数据权限：</div>
	                    <div class="righttext">
	                    	 <input name="dataPermission" type="text"/>
	                    </div>
	                </div>
	                <div class="item25 lastitem">
				   		<div class="oprationbutt">
	                       <input type="button" onclick="_search()" value="过滤" />
	                       <input type="button" onclick="cleanSearch()" value="重置" />
		              	</div>
	                </div>
	             </div>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
</body>
</html>