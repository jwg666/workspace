<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var negoOrderAddDialog;
	var negoOrderAddForm;
	var cdescAdd;
	var negoOrderEditDialog;
	var negoOrderEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'negoOrderAction!datagrid.do',
			title : '议付活动表列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			//fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'negoCode',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.negoCode;
						}
					},
			   {field:'negoCode',title:'唯一标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.negoCode;
					}
				},				
			   {field:'orderNum',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderNum;
					}
				},				
			   {field:'negoInvoiceNum',title:'议付发票号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.negoInvoiceNum;
					}
				},				
			   {field:'orderInvoiceNum',title:'订单议付发票号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderInvoiceNum;
					}
				},				
			   {field:'negoFlag',title:'议付完成标识,0=未完成，1=已完成',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.negoFlag;
					}
				},				
			   {field:'activeFlag',title:'1=有效，0=无效',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.activeFlag;
					}
				},				
			   {field:'createdBy',title:'创建人Id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'created',title:'创建日期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'lastUpdBy',title:'修改人Id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'lastUpd',title:'修改日期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				},				
			   {field:'modificationNum',title:'修改次数',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.modificationNum;
					}
				},				
			   {field:'orderCode',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
			   {field:'remark',title:'备注',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.remark;
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

		negoOrderAddForm = $('#negoOrderAddForm').form({
			url : 'negoOrderAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					negoOrderAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		negoOrderAddDialog = $('#negoOrderAddDialog').show().dialog({
			title : '添加议付活动表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					negoOrderAddForm.submit();
				}
			} ]
		});
		
		
		

		negoOrderEditForm = $('#negoOrderEditForm').form({
			url : 'negoOrderAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					negoOrderEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		negoOrderEditDialog = $('#negoOrderEditDialog').show().dialog({
			title : '编辑议付活动表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					negoOrderEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '议付活动表描述',
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
		negoOrderAddForm.form("clear");
		$('div.validatebox-tip').remove();
		negoOrderAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].negoCode+"&";
						else ids=ids+"ids="+rows[i].negoCode;
					}
					$.ajax({
						url : 'negoOrderAction!delete.do',
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
				url : 'negoOrderAction!showDesc.do',
				data : {
					negoCode : rows[0].negoCode
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					negoOrderEditForm.form("clear");
					negoOrderEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					negoOrderEditDialog.dialog('open');
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
			url : 'negoOrderAction!showDesc.do',
			data : {
				negoCode : row.negoCode
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有议付活动表描述！', 'error');
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

	<div id="negoOrderAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="negoOrderAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>唯一标识</th>
							<td>
								<input name="negoCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>订单号</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>议付发票号</th>
							<td>
								<input name="negoInvoiceNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写议付发票号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>订单议付发票号</th>
							<td>
								<input name="orderInvoiceNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单议付发票号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>议付完成标识,0=未完成，1=已完成</th>
							<td>
								<input name="negoFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写议付完成标识,0=未完成，1=已完成"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>1=有效，0=无效</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写1=有效，0=无效"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建人Id</th>
							<td>
								<input name="createdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写创建人Id"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建日期</th>
							<td>
								<input name="created" type="text" class="easyui-datebox" data-options="" missingMessage="请填写创建日期"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>修改人Id</th>
							<td>
								<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改人Id"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>修改日期</th>
							<td>
								<input name="lastUpd" type="text" class="easyui-datebox" data-options="" missingMessage="请填写修改日期"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>修改次数</th>
							<td>
								<input name="modificationNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>订单号</th>
							<td>
								<input name="orderCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>备注</th>
							<td>
								<input name="remark" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备注"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="negoOrderEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="negoOrderEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>唯一标识</th>
							<td>
								<input name="negoCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>订单号</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>议付发票号</th>
							<td>
								<input name="negoInvoiceNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写议付发票号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>订单议付发票号</th>
							<td>
								<input name="orderInvoiceNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单议付发票号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>议付完成标识,0=未完成，1=已完成</th>
							<td>
								<input name="negoFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写议付完成标识,0=未完成，1=已完成"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>1=有效，0=无效</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写1=有效，0=无效"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建人Id</th>
							<td>
								<input name="createdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写创建人Id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建日期</th>
							<td>
								<input name="created" type="text" class="easyui-datebox" data-options="" missingMessage="请填写创建日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改人Id</th>
							<td>
								<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改人Id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改日期</th>
							<td>
								<input name="lastUpd" type="text" class="easyui-datebox" data-options="" missingMessage="请填写修改日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改次数</th>
							<td>
								<input name="modificationNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>订单号</th>
							<td>
								<input name="orderCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>备注</th>
							<td>
								<input name="remark" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备注"  style="width: 155px;"/>
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