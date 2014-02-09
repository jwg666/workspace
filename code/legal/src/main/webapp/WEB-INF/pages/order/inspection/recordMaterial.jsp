<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var recordMaterialAddDialog;
	var recordMaterialAddForm;
	var cdescAdd;
	var recordMaterialEditDialog;
	var recordMaterialEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'recordMaterialAction!datagrid.do',
			title : '备案物料列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 15,
			pageList : [ 15, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.cdRecordMaterialId;
						}
					},
			   {field:'recordMaterialCode',title:'物料类',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.recordMaterialCode;
					}
				},				
			   {field:'prodname',title:'产品大类',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prodname;
					}
				},
				 {field:'prodgroup',title:'产品组',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prodgroup;
					}
				},			
			   {field:'codeInterpretation',title:'标识简码解释',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.codeInterpretation;
					}
				},				
			   {field:'hroisCode',title:'HROIS标识简码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.hroisCode;
					}
				},				
			   {field:'commodityCode',title:'商品编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.commodityCode;
					}
				},				
			   {field:'exportInspection',title:'出口商检',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.exportInspection;
					}
				},				
			   {field:'declarationName',title:'报关品名',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.declarationName;
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

		recordMaterialAddForm = $('#recordMaterialAddForm').form({
			url : 'recordMaterialAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					recordMaterialAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		recordMaterialAddDialog = $('#recordMaterialAddDialog').show().dialog({
			title : '添加备案物料',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					recordMaterialAddForm.submit();
				}
			} ]
		});
		
		
		

		recordMaterialEditForm = $('#recordMaterialEditForm').form({
			url : 'recordMaterialAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					recordMaterialEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		recordMaterialEditDialog = $('#recordMaterialEditDialog').show().dialog({
			title : '编辑备案物料',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					recordMaterialEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '备案物料描述',
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
		recordMaterialAddForm.form("clear");
		$('div.validatebox-tip').remove();
		recordMaterialAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].cdRecordMaterialId+"&";
						else ids=ids+"ids="+rows[i].cdRecordMaterialId;
					}
					$.ajax({
						url : 'recordMaterialAction!delete.do',
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
				url : 'recordMaterialAction!showDesc.do',
				data : {
					cdRecordMaterialId : rows[0].cdRecordMaterialId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					recordMaterialEditForm.form("clear");
					recordMaterialEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					recordMaterialEditDialog.dialog('open');
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
			url : 'recordMaterialAction!showDesc.do',
			data : {
				cdRecordMaterialId : row.cdRecordMaterialId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有备案物料描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件"   style="height: 100px;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc">
				<span>物料查询：</span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">产品大类: </div>
					<div class="righttext">
						<input type="text" name="prodtype" class="easyui-combobox" style="width: 160px; "
						  data-options="valueField:'prodTypeCode',textField:'prodType',url:'${dynamicURL}/basic/prodTypeAction!combox.do'"/>
					</div>
				</div>
				<!-- <div class="item33">
					<div class="itemleft">物料号: </div>
					<div class="righttext">
						<input type="text" name="materialCode" />
					</div>
				</div> -->
			<div class="item33">
				<div class="oprationbutt">
					<input type="button" onclick="_search();" value="查  询" /> <input
						type="button" onclick="cleanSearch();" value="取消" />
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

	<div id="recordMaterialAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="recordMaterialAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>物料类</th>
							<td>
								<input name="recordMaterialCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写物料类"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>产品大类</th>
							<td>
							<input type="text" name="prodType" class="easyui-combobox" style="width: 160px; "
						  					data-options="valueField:'prodTypeCode',textField:'prodType',url:'${dynamicURL}/basic/prodTypeAction!combox.do'"/>
							</td>
						</tr>
						<tr>
							<th>产品组</th>
							<td>
							<input type="text" name="prodgroup" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写产品组"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>HROIS标识简码</th>
							<td>
								<input name="hroisCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HROIS标识简码"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>商品编码</th>
							<td>
								<input name="commodityCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写商品编码"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>出口商检</th>
							<td>
								<input name="exportInspection" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写出口商检"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>报关品名</th>
							<td>
								<input name="declarationName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写报关品名"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>标识简码解释</th>
							<td>
								<textarea name="codeInterpretation" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写标识简码解释"  style="width: 255px;"/>						
							</td>
						</tr>
			</table>
		</form>
	</div>

	<div id="recordMaterialEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="recordMaterialEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>物料类</th>
							<td>
								<input name="recordMaterialCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写物料类"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>产品大类</th>
							<td>
								<input type="text" name="prodType" class="easyui-combobox" style="width: 160px; "
						  data-options="valueField:'prodTypeCode',textField:'prodType',url:'${dynamicURL}/basic/prodTypeAction!combox.do'"/>
							</td>
						</tr>
						<tr>
							<th>产品组</th>
							<td>
							<input type="text" name="prodgroup" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写产品组"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HROIS标识简码</th>
							<td>
								<input name="hroisCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HROIS标识简码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>商品编码</th>
							<td>
								<input name="commodityCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写商品编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>出口商检</th>
							<td>
								<input name="exportInspection" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写出口商检"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>报关品名</th>
							<td>
								<input name="declarationName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写报关品名"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>标识简码解释</th>
							<td>
								<textarea name="codeInterpretation" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写标识简码解释"  style="width: 255px;"/>
							</td>
						</tr>
			</table>
		</form>
	</div>
</body>
</html>