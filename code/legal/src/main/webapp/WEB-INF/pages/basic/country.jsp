<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var countryAddDialog;
	var countryAddForm;
	var cdescAdd;
	var countryEditDialog;
	var countryEditForm;
	var cdescEdit;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'countryAction!datagrid.do',
			title : '国家列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'countryId',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.countryId;
						}
					},
			   {field:'countryId',title:'countryId',align:'center',sortable:true,width:100,hidden:true,
					formatter:function(value,row,index){
						return row.countryId;
					}
				},
				{field:'countryCode',title:'国家编码',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.countryCode;
					}
				},
			   {field:'name',title:'国家名称',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.name;
					}
				},
			   {field:'alias',title:'别名',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.alias;
					}
				},
				{field:'activeFlag',title:'有效标志',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.activeFlag=="1"){
							return "有效";
						}else{
							return "无效";
						}
					}
				},
			   {field:'comments',title:'描述',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.comments;
					}
				},
			   {field:'createdBy',title:'创建人',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},
			   {field:'created',title:'创建日期',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},
			   {field:'lastUpd',title:'修改日期',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				},
			   {field:'lastUpdBy',title:'修改人',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				}
			 ] ],
			toolbar : [ {
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					add();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					del();
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ],
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

		countryAddForm = $('#countryAddForm').form({
			url : 'countryAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					countryAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		countryAddDialog = $('#countryAddDialog').show().dialog({
			title : '添加国家',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					countryAddForm.submit();
				}
			} ]
		});
		
		countryEditForm = $('#countryEditForm').form({
			url : 'countryAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					countryEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		countryEditDialog = $('#countryEditDialog').show().dialog({
			title : '编辑国家',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					countryEditForm.submit();
				}
			} ]
		});

	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function add() {
		countryAddForm.find('input,textarea').val('');
		$('div.validatebox-tip').remove();
		countryAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].countryId+"&";
						else ids=ids+"ids="+rows[i].countryId;
					}
					$.ajax({
						url : 'countryAction!delete.do',
						data : ids,
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'error');
		}
	}
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url : 'countryAction!showDesc.do',
				data : {
					countryId : rows[0].countryId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					countryEditForm.find('input,textarea').val('');
					countryEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					countryEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" collapsed="true"  style="height: 70px;overflow: hidden;" align="left">
		<form id="searchForm">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>国家编码</th>
					<td><input name="countryCode" style="width:100px;" /></td>
					<th>国家名称</th>
					<td><input name="name" style="width:155px;" />
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">过滤</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">取消</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="countryAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="countryAddForm" method="post">
			<table class="tableForm">
				<tr>
					<th>国家代码</th>
					<td>
						<input name="countryCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写国家代码"  style="width: 155px;"/>						
					</td>
				</tr>
			
				<tr>
					<th>有效标志</th>
					<td>
						<select name="activeFlag" style="width:160px">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>国家名称</th>
					<td>
						<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写国家名称"  style="width: 155px;"/>						
					</td>
				</tr>
			
				<tr>
					<th>别名</th>
					<td>
						<input name="alias" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写别名"  style="width: 155px;"/>						
					</td>
				</tr>
				
				<tr>
					<th>描述</th>
					<td>
						<input name="comments" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写描述"  style="width: 155px;"/>						
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div id="countryEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="countryEditForm" method="post">
			<table class="tableForm">
				<tr>
					<td>
						<input name="countryId" type="hidden" class="easyui-validatebox" data-options="required:true" missingMessage="请填写countryId"  style="width: 155px;"/>
						<input name="createdBy" type="hidden" />
						<input name="created" type="hidden" />
					</td>
				</tr>
				<tr>
				<th>国家代码</th>
					<td>
						<input name="countryCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写国家代码"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>有效标志</th>
					<td>
						<select name="activeFlag" style="width:160px">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
					</td>
				</tr>
				<tr>
				<th>国家名称</th>
					<td>
						<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写国家名称"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>别名</th>
					<td>
						<input name="alias" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写别名"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>描述</th>
					<td>
						<input name="comments" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写描述"  style="width: 155px;"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>