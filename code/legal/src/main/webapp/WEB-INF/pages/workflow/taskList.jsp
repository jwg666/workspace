<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
	var searchForm;
	var datagrid;
	$(function() {
		//alert("dsadsad");
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'taskListAction!datagrid.do',
			title : '任务列表管理',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10, 15, 20 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'id',
			
			columns : [ [ 
			{field:'申请人',title:'申请人',
				 formatter:function(value,row,index){
					return '申请人';
				 }
			},
			{field:'id',title:'执行id',
				 formatter:function(value,row,index){
					return row.id;
				 }
			},
			{field:'name',title:'当前节点name',
				 formatter:function(value,row,index){
					return row.name;
				 }
			},
			{field:'processInstanceId',title:'流程实例id',
				 formatter:function(value,row,index){
					return row.processInstanceId;
				 }
			},
			{field:'processDefinitionId',title:'流程定义id'
			},
			{field:'createTime',title:'任务创建时间',
				 formatter:function(value,row,index){
					return row.createTime;
				 }
			},
			{field:'suspensionState',title:'流程状态',
				 formatter:function(value,row,index){
					return row.suspensionState;
				 }
			},
			{field:'assignee',title:'当前处理人',
				 formatter:function(value,row,index){
					return row.assignee;
				 }
			},
			] ],
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'CD_BUDGET描述',
			modal : true,
			closed : true,
			maximizable : true
		});

		iframeDialog = $('#iframeDialog').show().dialog({
			title : 'POP弹出页面',
			modal : true,
			closed : true,
			maximizable : true
		});
	});

	function _search()
	{
		var assignee = $('#assignee').val();
		datagrid.datagrid('load',{"name":assignee});

	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	
	function showCdesc(index) {
		var rows = datagrid.datagrid('getRows');
		var row = rows[index];
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url : 'processAction!showDesc.do',
			data : {
				id : row.id
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有CD_BUDGET描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	
</script>
</head>
<body class="easyui-layout">
		<div region="north" border="false" title="过滤条件" collapsed="true"  style="height: 60px;overflow: hidden;" align="left">
		<form id="searchForm">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>当前处理人</th>
					<td><input name="assignee" id="assignee" style="width:155px;" /></td>
					<td>
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">过滤</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">取消</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
		<div id="showCdescDialog" style="display: none;overflow: auto;width: 500px;height: 400px;">
		<div name="cdesc"></div>
	</div>
	<div id="iframeDialog" style="display: none;overflow: auto;width: 600px;height: 400px;">
		<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:100%;">
	    </iframe>
	</div>
</body>
</html>