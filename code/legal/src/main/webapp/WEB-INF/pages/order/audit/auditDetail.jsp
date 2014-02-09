<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var auditDetailAddDialog;
	var auditDetailAddForm;
	var cdescAdd;
	var auditDetailEditDialog;
	var auditDetailEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'auditDetailAction!datagrid.do',
			title : '订单评审明细表列表',
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
			idField : 'rowId',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.rowId;
						}
					},
			   {field:'rowId',title:'rowId',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.rowId;
					}
				},				
			   {field:'orderNum',title:'orderNum',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderNum;
					}
				},				
			   {field:'orderItemLinecode',title:'orderItemLinecode',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderItemLinecode;
					}
				},				
			   {field:'hrNum',title:'hrNum',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.hrNum;
					}
				},				
			   {field:'hrDate',title:'hrDate',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.hrDate);
					}
				},				
			   {field:'haveBom',title:'haveBom',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.haveBom;
					}
				},				
			   {field:'delisting',title:'delisting',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.delisting;
					}
				},				
			   {field:'failureRate',title:'failureRate',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.failureRate;
					}
				},				
			   {field:'qualityProblem',title:'qualityProblem',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.qualityProblem;
					}
				},				
			   {field:'haveRollPlan',title:'haveRollPlan',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.haveRollPlan;
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

		auditDetailAddForm = $('#auditDetailAddForm').form({
			url : 'auditDetailAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					auditDetailAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		auditDetailAddDialog = $('#auditDetailAddDialog').show().dialog({
			title : '添加订单评审明细表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					auditDetailAddForm.submit();
				}
			} ]
		});
		
		
		

		auditDetailEditForm = $('#auditDetailEditForm').form({
			url : 'auditDetailAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					auditDetailEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		auditDetailEditDialog = $('#auditDetailEditDialog').show().dialog({
			title : '编辑订单评审明细表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					auditDetailEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '订单评审明细表描述',
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
		auditDetailAddForm.form("clear");
		$('div.validatebox-tip').remove();
		auditDetailAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].rowId+"&";
						else ids=ids+"ids="+rows[i].rowId;
					}
					$.ajax({
						url : 'auditDetailAction!delete.do',
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
				url : 'auditDetailAction!showDesc.do',
				data : {
					rowId : rows[0].rowId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					auditDetailEditForm.form("clear");
					auditDetailEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					auditDetailEditDialog.dialog('open');
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
			url : 'auditDetailAction!showDesc.do',
			data : {
				rowId : row.rowId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有订单评审明细表描述！', 'error');
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

	<div id="auditDetailAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="auditDetailAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>rowId</th>
							<td>
								<input name="rowId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写rowId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>orderNum</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写orderNum"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>orderItemLinecode</th>
							<td>
								<input name="orderItemLinecode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写orderItemLinecode"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>hrNum</th>
							<td>
								<input name="hrNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写hrNum"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>hrDate</th>
							<td>
								<input name="hrDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写hrDate"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>haveBom</th>
							<td>
								<input name="haveBom" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写haveBom"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>delisting</th>
							<td>
								<input name="delisting" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写delisting"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>failureRate</th>
							<td>
								<input name="failureRate" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写failureRate"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>qualityProblem</th>
							<td>
								<input name="qualityProblem" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写qualityProblem"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>haveRollPlan</th>
							<td>
								<input name="haveRollPlan" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写haveRollPlan"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="auditDetailEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="auditDetailEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>rowId</th>
							<td>
								<input name="rowId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写rowId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>orderNum</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写orderNum"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>orderItemLinecode</th>
							<td>
								<input name="orderItemLinecode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写orderItemLinecode"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>hrNum</th>
							<td>
								<input name="hrNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写hrNum"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>hrDate</th>
							<td>
								<input name="hrDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写hrDate"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>haveBom</th>
							<td>
								<input name="haveBom" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写haveBom"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>delisting</th>
							<td>
								<input name="delisting" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写delisting"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>failureRate</th>
							<td>
								<input name="failureRate" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写failureRate"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>qualityProblem</th>
							<td>
								<input name="qualityProblem" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写qualityProblem"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>haveRollPlan</th>
							<td>
								<input name="haveRollPlan" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写haveRollPlan"  style="width: 155px;"/>
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