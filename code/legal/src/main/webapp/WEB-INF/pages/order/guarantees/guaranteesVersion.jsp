<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var guaranteesVersionAddDialog;
	var guaranteesVersionAddForm;
	var cdescAdd;
	var guaranteesVersionEditDialog;
	var guaranteesVersionEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'guaranteesVersionAction!datagrid.do',
			title : '保函维护列表',
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
			idField : 'guarantees',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.guarantees;
						}
					},
			   {field:'guarantees',title:'保函号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.guarantees;
					}
				},				
			   {field:'beneficiaries',title:'受益人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.beneficiaries;
					}
				},				
			   {field:'customerCode',title:'客户编号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.customerCode;
					}
				},				
			   {field:'bankName',title:'开证行',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.bankName;
					}
				},				
			   {field:'modifyNum',title:'修改次数',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.modifyNum;
					}
				},				
			   {field:'payType',title:'类型 1 保函 2备用信用证',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.payType;
					}
				},				
			   {field:'currency',title:'币种',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.currency;
					}
				},				
			   {field:'amount',title:'金额',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.amount;
					}
				},				
			   {field:'cycleFlag',title:'是否可循环 1可循环  0不可循环',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.cycleFlag;
					}
				},				
			   {field:'payPeriod',title:'付款周期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.payPeriod;
					}
				},				
			   {field:'docAgainstDay',title:'单证交单期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.docAgainstDay;
					}
				},				
			   {field:'startDate',title:'开证日',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.startDate);
					}
				},				
			   {field:'endDate',title:'到期日',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.endDate);
					}
				},				
			   /* {field:'valid',title:'有效期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.valid);
					}
				} */,				
			   {field:'docAuditFlag',title:'单证审核标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.docAuditFlag;
					}
				},				
			   {field:'docAuditOpenion',title:'单证审核意见',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.docAuditOpenion;
					}
				},				
			   {field:'docAuditCode',title:'单证审核人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.docAuditCode;
					}
				},				
			   {field:'finAuditFlag',title:'财务审核标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.finAuditFlag;
					}
				},				
			   {field:'finAuditOpenion',title:'财务审核意见',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.finAuditOpenion;
					}
				},				
			   {field:'finAuditCode',title:'财务审核人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.finAuditCode;
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
			   {field:'notifyBank',title:'通知行',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.notifyBank;
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

		guaranteesVersionAddForm = $('#guaranteesVersionAddForm').form({
			url : 'guaranteesVersionAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					guaranteesVersionAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		guaranteesVersionAddDialog = $('#guaranteesVersionAddDialog').show().dialog({
			title : '添加保函维护',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					guaranteesVersionAddForm.submit();
				}
			} ]
		});
		
		
		

		guaranteesVersionEditForm = $('#guaranteesVersionEditForm').form({
			url : 'guaranteesVersionAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					guaranteesVersionEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		guaranteesVersionEditDialog = $('#guaranteesVersionEditDialog').show().dialog({
			title : '编辑保函维护',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					guaranteesVersionEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '保函维护描述',
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
		guaranteesVersionAddForm.form("clear");
		$('div.validatebox-tip').remove();
		guaranteesVersionAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].guarantees+"&";
						else ids=ids+"ids="+rows[i].guarantees;
					}
					$.ajax({
						url : 'guaranteesVersionAction!delete.do',
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
				url : 'guaranteesVersionAction!showDesc.do',
				data : {
					guarantees : rows[0].guarantees
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					guaranteesVersionEditForm.form("clear");
					guaranteesVersionEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					guaranteesVersionEditDialog.dialog('open');
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
			url : 'guaranteesVersionAction!showDesc.do',
			data : {
				guarantees : row.guarantees
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有保函维护描述！', 'error');
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

	<div id="guaranteesVersionAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="guaranteesVersionAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>保函号</th>
							<td>
								<input name="guarantees" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写保函号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>受益人</th>
							<td>
								<input name="beneficiaries" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写受益人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>客户编号</th>
							<td>
								<input name="customerCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写客户编号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>开证行</th>
							<td>
								<input name="bankName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写开证行"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>修改次数</th>
							<td>
								<input name="modifyNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>类型 1 保函 2备用信用证</th>
							<td>
								<input name="payType" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写类型 1 保函 2备用信用证"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>币种</th>
							<td>
								<input name="currency" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写币种"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>金额</th>
							<td>
								<input name="amount" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写金额"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>是否可循环 1可循环  0不可循环</th>
							<td>
								<input name="cycleFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写是否可循环 1可循环  0不可循环"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>付款周期</th>
							<td>
								<input name="payPeriod" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写付款周期"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>单证交单期</th>
							<td>
								<input name="docAgainstDay" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写单证交单期"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>开证日</th>
							<td>
								<input name="startDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写开证日"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>到期日</th>
							<td>
								<input name="endDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写到期日"  style="width: 155px;"/>						
							</td>
						</tr>
						<!-- <tr>
							<th>有效期</th>
							<td>
								<input name="valid" type="text" class="easyui-datebox" data-options="" missingMessage="请填写有效期"  style="width: 155px;"/>						
							</td>
						</tr> -->
						<tr>
							<th>单证审核标识</th>
							<td>
								<input name="docAuditFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写单证审核标识"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>单证审核意见</th>
							<td>
								<input name="docAuditOpenion" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写单证审核意见"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>单证审核人</th>
							<td>
								<input name="docAuditCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写单证审核人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>财务审核标识</th>
							<td>
								<input name="finAuditFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写财务审核标识"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>财务审核意见</th>
							<td>
								<input name="finAuditOpenion" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写财务审核意见"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>财务审核人</th>
							<td>
								<input name="finAuditCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写财务审核人"  style="width: 155px;"/>						
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
							<th>通知行</th>
							<td>
								<input name="notifyBank" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写通知行"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="guaranteesVersionEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="guaranteesVersionEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>保函号</th>
							<td>
								<input name="guarantees" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写保函号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>受益人</th>
							<td>
								<input name="beneficiaries" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写受益人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>客户编号</th>
							<td>
								<input name="customerCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写客户编号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>开证行</th>
							<td>
								<input name="bankName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写开证行"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改次数</th>
							<td>
								<input name="modifyNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写修改次数"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>类型 1 保函 2备用信用证</th>
							<td>
								<input name="payType" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写类型 1 保函 2备用信用证"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>币种</th>
							<td>
								<input name="currency" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写币种"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>金额</th>
							<td>
								<input name="amount" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写金额"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>是否可循环 1可循环  0不可循环</th>
							<td>
								<input name="cycleFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写是否可循环 1可循环  0不可循环"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>付款周期</th>
							<td>
								<input name="payPeriod" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写付款周期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>单证交单期</th>
							<td>
								<input name="docAgainstDay" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写单证交单期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>开证日</th>
							<td>
								<input name="startDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写开证日"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>到期日</th>
							<td>
								<input name="endDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写到期日"  style="width: 155px;"/>
							</td>
						</tr>
						<!-- <tr>
						<th>有效期</th>
							<td>
								<input name="valid" type="text" class="easyui-datebox" data-options="" missingMessage="请填写有效期"  style="width: 155px;"/>
							</td>
						</tr> -->
						<tr>
						<th>单证审核标识</th>
							<td>
								<input name="docAuditFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写单证审核标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>单证审核意见</th>
							<td>
								<input name="docAuditOpenion" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写单证审核意见"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>单证审核人</th>
							<td>
								<input name="docAuditCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写单证审核人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>财务审核标识</th>
							<td>
								<input name="finAuditFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写财务审核标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>财务审核意见</th>
							<td>
								<input name="finAuditOpenion" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写财务审核意见"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>财务审核人</th>
							<td>
								<input name="finAuditCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写财务审核人"  style="width: 155px;"/>
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
						<th>通知行</th>
							<td>
								<input name="notifyBank" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写通知行"  style="width: 155px;"/>
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