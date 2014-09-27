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
			title : '角色列表',
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
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.id;
						}
					},
				{field:'name',title:'角色名称',align:'center',sortable:true,width:50,
					formatter:function(value,row,index){
						return '<a style="color: blue;" href="${dynamicURL}/security/roleAction!updateRole.do?roleId='+row.id+'">'+row.name+'</a>';
					}
				},
			   {field:'description',title:'角色描述',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.description;
					}
				},	
				{field:'createBy',title:'创建人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createBy;
					}
				},	
			   {field:'gmtCreate',title:'创建时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.gmtCreate);
					}
			   },
			   
			 ] ],
			toolbar : [  {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					del();
				}
			},'-', {
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
			title : '添加角色',
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
			title : '编辑角色',
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
			title : '角色描述',
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
		<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 100px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>角色信息维护</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">角色名称：</div>
						<div class="righttext_easyui">
							<input type="text" name="empCode"  />
						</div>
					</div>
					<div class="item33">
						<div class="oprationbutt">
							<input type="button" value="查  询" onclick="_search();" />
							<input type="button" value="新建" onclick="" />
							<input type="button" value="重  置" onclick="cleanSearch();" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="roleAddDialog" style="display: none;width: 600px;height: 300px;" align="center">
		<form id="roleAddForm" method="post">
			<div style="width: 500px; height: 160px; margin-left: 20px;">
				<div class="part_popover_zoc" style="width: 500px;">
						<div class="oneline">
							<div class="itemleft60">角色名称：</div>
							<div class="righttext">
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写资源名称"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60" style="vertical-align: top;">角色描述：</div>
							<div align="left" style="display: inline-block;width: 300px">
									<textarea name="description" rows="5"  cols="200" data-options="" missingMessage="请填写资源描述"  style="width: 155px;"/>						
							</div>
						</div>
				</div>
			</div>
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