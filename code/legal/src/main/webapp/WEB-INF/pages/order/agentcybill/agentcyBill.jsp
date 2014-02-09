<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var agentcyBillAddDialog;
	var agentcyBillAddForm;
	var cdescAdd;
	var agentcyBillEditDialog;
	var agentcyBillEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'agentcyBillAction!datagrid.do',
			title : '代理结算清单列表',
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
			idField : 'agentcyBillId',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.agentcyBillId;
						}
					},
			   {field:'agentcyBillId',title:'唯一标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.agentcyBillId;
					}
				},				
			   {field:'agentcyBillCode',title:'代理结算清单编号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.agentcyBillCode;
					}
				},				
			   {field:'orderNum',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderNum;
					}
				},				
			   {field:'printFlag',title:'打印状态1,正式打印，0未正式打印',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.printFlag;
					}
				},				
			   {field:'createBy',title:'创建人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createBy;
					}
				},				
			   {field:'createDate',title:'创建时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.createDate);
					}
				},				
			   {field:'lastUpBy',title:'最后修改人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastUpBy;
					}
				},				
			   {field:'lastUpDate',title:'最后修改时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpDate);
					}
				},				
			   {field:'modifyNum',title:'修改次数',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.modifyNum;
					}
				},				
			   {field:'activeFlag',title:'有效标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.activeFlag;
					}
				},				
			   {field:'printDate',title:'打印时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.printDate);
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

		agentcyBillAddForm = $('#agentcyBillAddForm').form({
			url : 'agentcyBillAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					agentcyBillAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		agentcyBillAddDialog = $('#agentcyBillAddDialog').show().dialog({
			title : '添加代理结算清单',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					agentcyBillAddForm.submit();
				}
			} ]
		});
		
		
		

		agentcyBillEditForm = $('#agentcyBillEditForm').form({
			url : 'agentcyBillAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					agentcyBillEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		agentcyBillEditDialog = $('#agentcyBillEditDialog').show().dialog({
			title : '编辑代理结算清单',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					agentcyBillEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '代理结算清单描述',
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
		agentcyBillAddForm.form("clear");
		$('div.validatebox-tip').remove();
		agentcyBillAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].agentcyBillId+"&";
						else ids=ids+"ids="+rows[i].agentcyBillId;
					}
					$.ajax({
						url : 'agentcyBillAction!delete.do',
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
				url : 'agentcyBillAction!showDesc.do',
				data : {
					agentcyBillId : rows[0].agentcyBillId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					agentcyBillEditForm.form("clear");
					agentcyBillEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					agentcyBillEditDialog.dialog('open');
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
			url : 'agentcyBillAction!showDesc.do',
			data : {
				agentcyBillId : row.agentcyBillId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有代理结算清单描述！', 'error');
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

	<div id="agentcyBillAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="agentcyBillAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>唯一标识</th>
							<td>
								<input name="agentcyBillId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>代理结算清单编号</th>
							<td>
								<input name="agentcyBillCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写代理结算清单编号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>订单号</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>打印状态1,正式打印，0未正式打印</th>
							<td>
								<input name="printFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写打印状态1,正式打印，0未正式打印"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建人</th>
							<td>
								<input name="createBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写创建人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建时间</th>
							<td>
								<input name="createDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写创建时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>最后修改人</th>
							<td>
								<input name="lastUpBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写最后修改人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>最后修改时间</th>
							<td>
								<input name="lastUpDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写最后修改时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>修改次数</th>
							<td>
								<input name="modifyNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>有效标识</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写有效标识"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>打印时间</th>
							<td>
								<input name="printDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写打印时间"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="agentcyBillEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="agentcyBillEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>唯一标识</th>
							<td>
								<input name="agentcyBillId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>代理结算清单编号</th>
							<td>
								<input name="agentcyBillCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写代理结算清单编号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>订单号</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>打印状态1,正式打印，0未正式打印</th>
							<td>
								<input name="printFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写打印状态1,正式打印，0未正式打印"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建人</th>
							<td>
								<input name="createBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写创建人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建时间</th>
							<td>
								<input name="createDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写创建时间"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>最后修改人</th>
							<td>
								<input name="lastUpBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写最后修改人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>最后修改时间</th>
							<td>
								<input name="lastUpDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写最后修改时间"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改次数</th>
							<td>
								<input name="modifyNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>有效标识</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写有效标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>打印时间</th>
							<td>
								<input name="printDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写打印时间"  style="width: 155px;"/>
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