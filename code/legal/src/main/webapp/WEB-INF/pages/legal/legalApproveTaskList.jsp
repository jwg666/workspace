<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var legalApproveAddDialog;
	var legalApproveAddForm;
	var cdescAdd;
	var legalApproveEditDialog;
	var legalApproveEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'legalApproveAction!taskgrid.do',
			title : 'LegalApprove列表',
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
			   {field:'caseId',title:'caseId',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.caseId;
					}
				},				
			   {field:'approveId',title:'approveId',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.approveId;
					}
				},				
			   {field:'approveContent',title:'approveContent',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.approveContent;
					}
				},				
			   {field:'signiturePath',title:'signiturePath',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.signiturePath;
					}
				},				
			   {field:'approveTime',title:'approveTime',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.approveTime);
					}
				},				
			   {field:'workTime',title:'workTime',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.workTime);
					}
				},				
			   {field:'createTime',title:'createTime',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.createTime);
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

		legalApproveAddForm = $('#legalApproveAddForm').form({
			url : 'legalApproveAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					legalApproveAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		legalApproveAddDialog = $('#legalApproveAddDialog').show().dialog({
			title : '添加LegalApprove',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					legalApproveAddForm.submit();
				}
			} ]
		});
		
		
		

		legalApproveEditForm = $('#legalApproveEditForm').form({
			url : 'legalApproveAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					legalApproveEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		legalApproveEditDialog = $('#legalApproveEditDialog').show().dialog({
			title : '编辑LegalApprove',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					legalApproveEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'LegalApprove描述',
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
		legalApproveAddForm.form("clear");
		$('div.validatebox-tip').remove();
		legalApproveAddDialog.dialog('open');
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
						url : 'legalApproveAction!delete.do',
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
				url : 'legalApproveAction!showDesc.do',
				data : {
					id : rows[0].id
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					legalApproveEditForm.form("clear");
					legalApproveEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					legalApproveEditDialog.dialog('open');
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
			url : 'legalApproveAction!showDesc.do',
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
					$.messager.alert('提示', '没有LegalApprove描述！', 'error');
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

	<div id="legalApproveAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="legalApproveAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>id</th>
							<td>
								<input name="id" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>caseId</th>
							<td>
								<input name="caseId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写caseId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>approveId</th>
							<td>
								<input name="approveId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写approveId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>approveContent</th>
							<td>
								<input name="approveContent" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写approveContent"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>signiturePath</th>
							<td>
								<input name="signiturePath" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写signiturePath"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>approveTime</th>
							<td>
								<input name="approveTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写approveTime"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>workTime</th>
							<td>
								<input name="workTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写workTime"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>createTime</th>
							<td>
								<input name="createTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写createTime"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="legalApproveEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="legalApproveEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>id</th>
							<td>
								<input name="id" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>caseId</th>
							<td>
								<input name="caseId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写caseId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>approveId</th>
							<td>
								<input name="approveId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写approveId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>approveContent</th>
							<td>
								<input name="approveContent" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写approveContent"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>signiturePath</th>
							<td>
								<input name="signiturePath" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写signiturePath"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>approveTime</th>
							<td>
								<input name="approveTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写approveTime"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>workTime</th>
							<td>
								<input name="workTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写workTime"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>createTime</th>
							<td>
								<input name="createTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写createTime"  style="width: 155px;"/>
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