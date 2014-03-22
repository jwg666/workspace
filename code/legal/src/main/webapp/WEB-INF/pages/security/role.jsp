<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var roleAddDialog;
	var roleAddForm;
	var cdescAdd;
	var roleEditDialog;
	var roleEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'roleAction!datagrid.do',
			title : 'Role列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			idField : 'id',
			sortName : 'createDt',
			sortOrder : 'desc',
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.id;
						}
					},
			   {field:'id',title:'id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.id;
					}
				},				
			   {field:'createBy',title:'createBy',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createBy;
					}
				},				
			   {field:'deletedFlag',title:'deletedFlag',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.deletedFlag;
					}
				},				
			   {field:'description',title:'description',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.description;
					}
				},				
			   {field:'gmtCreate',title:'gmtCreate',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.gmtCreate);
					}
				},				
			   {field:'gmtCreateString',title:'gmtCreateString',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.gmtCreateString;
					}
				},				
			   {field:'gmtModified',title:'gmtModified',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.gmtModified);
					}
				},				
			   {field:'gmtModifiedString',title:'gmtModifiedString',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.gmtModifiedString;
					}
				},				
			   {field:'lastModifiedBy',title:'lastModifiedBy',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastModifiedBy;
					}
				},				
			   {field:'name',title:'name',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.name;
					}
				},				
			   {field:'usingFlag',title:'usingFlag',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.usingFlag;
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

		roleAddForm = $('#roleAddForm').form({
			url : 'roleAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					roleAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		roleAddDialog = $('#roleAddDialog').show().dialog({
			title : '添加Role',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					roleAddForm.submit();
				}
			} ]
		});
		
		
		

		roleEditForm = $('#roleEditForm').form({
			url : 'roleAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					roleEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		roleEditDialog = $('#roleEditDialog').show().dialog({
			title : '编辑Role',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					roleEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'Role描述',
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

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function add() {
		roleAddForm.form("clear");
		$('div.validatebox-tip').remove();
		roleAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].id+"&";
						else ids=ids+"ids="+rows[i].id;
					}
					$.ajax({
						url : 'roleAction!delete.do',
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
				url : 'roleAction!showDesc.do',
				data : {
					id : rows[0].id
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					roleEditForm.form("clear");
					roleEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					roleEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
	function showCdesc(index) {
		var rows = datagrid.datagrid('getRows');
		var row = rows[index];
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url : 'roleAction!showDesc.do',
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
					$.messager.alert('提示', '没有Role描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" collapsed="true"  style="height: 110px;overflow: hidden;" align="left">
		<form id="searchForm">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>查询字段需要手工修改</th>
					<td><input name="hotelid" style="width:155px;" /></td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td><input name="ccreatedatetimeStart" class="easyui-datebox" editable="false" style="width: 155px;" />至<input name="ccreatedatetimeEnd" class="easyui-datebox" editable="false" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>最后修改时间</th>
					<td><input name="cmodifydatetimeStart" class="easyui-datebox" editable="false" style="width: 155px;" />至<input name="cmodifydatetimeEnd" class="easyui-datebox" editable="false" style="width: 155px;" /><a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">过滤</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">取消</a></td>
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

	<div id="roleAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="roleAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>id</th>
							<td>
								<input name="id" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>createBy</th>
							<td>
								<input name="createBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写createBy"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>deletedFlag</th>
							<td>
								<input name="deletedFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写deletedFlag"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>description</th>
							<td>
								<input name="description" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写description"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>gmtCreate</th>
							<td>
								<input name="gmtCreate" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写gmtCreate"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>gmtCreateString</th>
							<td>
								<input name="gmtCreateString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写gmtCreateString"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>gmtModified</th>
							<td>
								<input name="gmtModified" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写gmtModified"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>gmtModifiedString</th>
							<td>
								<input name="gmtModifiedString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写gmtModifiedString"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>lastModifiedBy</th>
							<td>
								<input name="lastModifiedBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写lastModifiedBy"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>name</th>
							<td>
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写name"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>usingFlag</th>
							<td>
								<input name="usingFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写usingFlag"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="roleEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="roleEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>id</th>
							<td>
								<input name="id" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>createBy</th>
							<td>
								<input name="createBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写createBy"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>deletedFlag</th>
							<td>
								<input name="deletedFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写deletedFlag"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>description</th>
							<td>
								<input name="description" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写description"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>gmtCreate</th>
							<td>
								<input name="gmtCreate" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写gmtCreate"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>gmtCreateString</th>
							<td>
								<input name="gmtCreateString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写gmtCreateString"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>gmtModified</th>
							<td>
								<input name="gmtModified" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写gmtModified"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>gmtModifiedString</th>
							<td>
								<input name="gmtModifiedString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写gmtModifiedString"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>lastModifiedBy</th>
							<td>
								<input name="lastModifiedBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写lastModifiedBy"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>name</th>
							<td>
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写name"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>usingFlag</th>
							<td>
								<input name="usingFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写usingFlag"  style="width: 155px;"/>
							</td>
						</tr>
			</table>
		</form>
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