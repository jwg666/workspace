<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var auditLogAddDialog;
	var auditLogAddForm;
	var cdescAdd;
	var auditLogEditDialog;
	var auditLogEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'auditLogAction!datagrid.do',
			title : 'SO_AUDIT_LOG列表',
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
			idField : 'soAuditLogId',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.soAuditLogId;
						}
					},
			   {field:'soAuditLogId',title:'唯一标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.soAuditLogId;
					}
				},				
			   {field:'orderNum',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderNum;
					}
				},				
			   {field:'auditFlag',title:'0待审核，1,审核通过，2问题订单',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.auditFlag;
					}
				},				
			   {field:'rejection',title:'拒绝原因',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.rejection;
					}
				},				
			   {field:'rejectionName',title:'拒绝人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.rejectionName;
					}
				},				
			   {field:'rejectionDate',title:'拒绝时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.rejectionDate);
					}
				},				
			   {field:'restore',title:'回复',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.restore;
					}
				},				
			   {field:'restoreName',title:'回复人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.restoreName;
					}
				},				
			   {field:'restoreDate',title:'回复时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.restoreDate);
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

		auditLogAddForm = $('#auditLogAddForm').form({
			url : 'auditLogAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					auditLogAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		auditLogAddDialog = $('#auditLogAddDialog').show().dialog({
			title : '添加SO_AUDIT_LOG',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					auditLogAddForm.submit();
				}
			} ]
		});
		
		
		

		auditLogEditForm = $('#auditLogEditForm').form({
			url : 'auditLogAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					auditLogEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		auditLogEditDialog = $('#auditLogEditDialog').show().dialog({
			title : '编辑SO_AUDIT_LOG',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					auditLogEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'SO_AUDIT_LOG描述',
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
		auditLogAddForm.form("clear");
		auditLogAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].soAuditLogId+"&";
						else ids=ids+"ids="+rows[i].soAuditLogId;
					}
					$.ajax({
						url : 'auditLogAction!delete.do',
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
				url : 'auditLogAction!showDesc.do',
				data : {
					soAuditLogId : rows[0].soAuditLogId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					auditLogEditForm.form("clear");
					auditLogEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					auditLogEditDialog.dialog('open');
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
			url : 'auditLogAction!showDesc.do',
			data : {
				soAuditLogId : row.soAuditLogId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有SO_AUDIT_LOG描述！', 'error');
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

	<div id="auditLogAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="auditLogAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>唯一标识</th>
							<td>
								<input name="soAuditLogId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>订单号</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>0待审核，1,审核通过，2问题订单</th>
							<td>
								<input name="auditFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写0待审核，1,审核通过，2问题订单"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>拒绝原因</th>
							<td>
								<input name="rejection" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写拒绝原因"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>拒绝人</th>
							<td>
								<input name="rejectionName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写拒绝人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>拒绝时间</th>
							<td>
								<input name="rejectionDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写拒绝时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>回复</th>
							<td>
								<input name="restore" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写回复"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>回复人</th>
							<td>
								<input name="restoreName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写回复人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>回复时间</th>
							<td>
								<input name="restoreDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写回复时间"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="auditLogEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="auditLogEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>唯一标识</th>
							<td>
								<input name="soAuditLogId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>订单号</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>0待审核，1,审核通过，2问题订单</th>
							<td>
								<input name="auditFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写0待审核，1,审核通过，2问题订单"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>拒绝原因</th>
							<td>
								<input name="rejection" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写拒绝原因"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>拒绝人</th>
							<td>
								<input name="rejectionName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写拒绝人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>拒绝时间</th>
							<td>
								<input name="rejectionDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写拒绝时间"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>回复</th>
							<td>
								<input name="restore" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写回复"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>回复人</th>
							<td>
								<input name="restoreName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写回复人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>回复时间</th>
							<td>
								<input name="restoreDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写回复时间"  style="width: 155px;"/>
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