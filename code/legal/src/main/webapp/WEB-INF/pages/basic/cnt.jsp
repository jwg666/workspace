<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var cntAddDialog;
	var cntAddForm;
	var cdescAdd;
	var cntEditDialog;
	var cntEditForm;
	var cdescEdit;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'sysCntAction!datagrid.do',
			title : '箱型列表',
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
			idField : 'cntId',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.cntId;
						}
					},
			   {field:'cntId',title:'箱型编码',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.cntId;
					}
				},				
			   {field:'cntType',title:'箱型描述',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.cntType;
					}
				},				
			   {field:'length',title:'长 ( mm )',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.length;
					}
				},				
			   {field:'width',title:'宽 ( mm )',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.width;
					}
				},				
			   {field:'height',title:'高  ( mm )',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.height;
					}
				},				
			   {field:'load',title:'最大载重量( KG ) ',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.load;
					}
				},
				 {field:'comments',title:'备注',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.comments;
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

		cntAddForm = $('#cntAddForm').form({
			url : 'sysCntAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					cntAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '增加失败！'
					});
				}
			}
		});

		cntAddDialog = $('#cntAddDialog').show().dialog({
			title : '添加',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					cntAddForm.submit();
				}
			} ]
		});

		cntEditForm = $('#cntEditForm').form({
			url : 'sysCntAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					cntEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '编辑失败！'
					});
				}
			}
		});

		cntEditDialog = $('#cntEditDialog').show().dialog({
			title : '编辑',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					cntEditForm.submit();
				}
			} ]
		});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function add() {
		cntAddForm.form("clear");
		$('div.validatebox-tip').remove();
		cntAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].cntId+"&";
						else ids=ids+"ids="+rows[i].cntId;
					}
					$.ajax({
						url : 'sysCntAction!delete.do',
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
				url : 'sysCntAction!showDesc.do',
				data : {
					cntId : rows[0].cntId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					cntEditForm.form("clear");
					cntEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					cntEditDialog.dialog('open');
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
	<div region="north" border="false" class="zoc" title="" collapsed="false"  style="height: 57px;overflow: hidden;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc"><span>查询与操作：</span></div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft80">箱型编码：</div>
					<div class="rightselect_easyui">
						<input type="text" name="cntId">
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="oprationbutt">
						<input type="button" onclick="_search()" value="查询" />
						<input type="button" onclick="cleanSearch()" value="取消" />
					</div>
				</div>
			</div>
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

	<div id="cntAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="cntAddForm" method="post">
			<table class="tableForm">
				<tr>
					<th>箱型编码</th>
					<td>
						<input name="cntId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写箱型编码"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
					<th>箱型描述</th>
					<td>
						<input name="cntType" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写箱型描述"  style="width: 155px;"/>						
					</td>
				</tr>
				<tr>
					<th>长 (mm)</th>
					<td>
						<input name="length" type="text" class="easyui-numberbox" data-options="min:0,precision:0" missingMessage="请填写长    mm 毫米"  style="width: 155px;"/>						
					</td>
				</tr>
				<tr>
					<th>宽 (mm)</th>
					<td>
						<input name="width" type="text" class="easyui-numberbox" data-options="min:0,precision:0" missingMessage="请填写宽    mm 毫米"  style="width: 155px;"/>						
					</td>
				</tr>
				<tr>
					<th>高  (mm)</th>
					<td>
						<input name="height" type="text" class="easyui-numberbox" data-options="min:0,precision:0" missingMessage="请填写高    mm 毫米"  style="width: 155px;"/>						
					</td>
				</tr>
				<tr>
					<th>备注</th>
					<td>
						<input name="comments" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备注"  style="width: 155px;"/>						
					</td>
				</tr>
				<tr>
					<th>最大载重量(KG)</th>
					<td>
						<input name="load" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写最大载重量 KG 千克"  style="width: 155px;"/>						
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div id="cntEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="cntEditForm" method="post">
			<table class="tableForm">
				<tr>
				<th>箱型编码</th>
					<td>
						<input name="cntId" type="text" class="easyui-validatebox" data-options="required:true" readonly="readonly" style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>箱型描述</th>
					<td>
						<input name="cntType" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写箱型描述"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>长  (mm)</th>
					<td>
						<input name="length" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写长    mm 毫米"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>宽  (mm)</th>
					<td>
						<input name="width" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写宽    mm 毫米"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>高   (mm)</th>
					<td>
						<input name="height" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写高    mm 毫米"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>备注</th>
					<td>
						<input name="comments" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备注"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>最大载重量 (KG)</th>
					<td>
						<input name="load" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写最大载重量 KG 千克"  style="width: 155px;"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>