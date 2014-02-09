<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var materialSparePartsAddDialog;
	var materialSparePartsAddForm;
	var cdescAdd;
	var materialSparePartsEditDialog;
	var materialSparePartsEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'materialSparePartsAction!datagrid.do',
			title : '散件备案信息列表',
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
			idField : 'sparePartsCode',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.sparePartsCode;
						}
					},
			   {field:'sparePartsCode',title:'散件物料唯一标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.sparePartsCode;
					}
				},				
			   {field:'materialCode',title:'物料号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.materialCode;
					}
				},				
			   {field:'prodType',title:'产品大类',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prodType;
					}
				},				
			   {field:'hsCode',title:'海关商品编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.hsCode;
					}
				},				
			   {field:'hsName',title:'海关商品名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.hsName;
					}
				},				
			   {field:'brand',title:'品牌',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.brand;
					}
				},				
			   {field:'haierProdDesc',title:'海尔品名',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.haierProdDesc;
					}
				},				
			   {field:'simpleCode',title:'HROIS简码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.simpleCode;
					}
				},				
			   {field:'simpleCodeDesc',title:'HROIS简码描述',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.simpleCodeDesc;
					}
				},				
			   {field:'use',title:'用途',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.use;
					}
				},				
			   {field:'comments',title:'备注',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.comments;
					}
				},				
			   {field:'column1',title:'HS属性字段1',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column1;
					}
				},				
			   {field:'column2',title:'HS属性字段2',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column2;
					}
				},				
			   {field:'column3',title:'HS属性字段3',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column3;
					}
				},				
			   {field:'column4',title:'HS属性字段4',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column4;
					}
				},				
			   {field:'column5',title:'HS属性字段5',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column5;
					}
				},				
			   {field:'column6',title:'HS属性字段6',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column6;
					}
				},				
			   {field:'column7',title:'HS属性字段7',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column7;
					}
				},				
			   {field:'column8',title:'HS属性字段8',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column8;
					}
				},				
			   {field:'column9',title:'HS属性字段9',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column9;
					}
				},				
			   {field:'column10',title:'HS属性字段10',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column10;
					}
				},				
			   {field:'column11',title:'HS属性字段11',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column11;
					}
				},				
			   {field:'column12',title:'HS属性字段12',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column12;
					}
				},				
			   {field:'column13',title:'HS属性字段13',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column13;
					}
				},				
			   {field:'column14',title:'HS属性字段14',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column14;
					}
				},				
			   {field:'column15',title:'HS属性字段15',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column15;
					}
				},				
			   {field:'column16',title:'HS属性字段16',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column16;
					}
				},				
			   {field:'column17',title:'HS属性字段17',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column17;
					}
				},				
			   {field:'column18',title:'HS属性字段18',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column18;
					}
				},				
			   {field:'column19',title:'HS属性字段19',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column19;
					}
				},				
			   {field:'column20',title:'HS属性字段20',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.column20;
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

		materialSparePartsAddForm = $('#materialSparePartsAddForm').form({
			url : 'materialSparePartsAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					materialSparePartsAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		materialSparePartsAddDialog = $('#materialSparePartsAddDialog').show().dialog({
			title : '添加散件备案信息',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					materialSparePartsAddForm.submit();
				}
			} ]
		});
		
		
		

		materialSparePartsEditForm = $('#materialSparePartsEditForm').form({
			url : 'materialSparePartsAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					materialSparePartsEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		materialSparePartsEditDialog = $('#materialSparePartsEditDialog').show().dialog({
			title : '编辑散件备案信息',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					materialSparePartsEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '散件备案信息描述',
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
		materialSparePartsAddForm.form("clear");
		$('div.validatebox-tip').remove();
		materialSparePartsAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].sparePartsCode+"&";
						else ids=ids+"ids="+rows[i].sparePartsCode;
					}
					$.ajax({
						url : 'materialSparePartsAction!delete.do',
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
				url : 'materialSparePartsAction!showDesc.do',
				data : {
					sparePartsCode : rows[0].sparePartsCode
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					materialSparePartsEditForm.form("clear");
					materialSparePartsEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					materialSparePartsEditDialog.dialog('open');
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
			url : 'materialSparePartsAction!showDesc.do',
			data : {
				sparePartsCode : row.sparePartsCode
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有散件备案信息描述！', 'error');
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

	<div id="materialSparePartsAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="materialSparePartsAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>散件物料唯一标识</th>
							<td>
								<input name="sparePartsCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写散件物料唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>物料号</th>
							<td>
								<input name="materialCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写物料号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>产品大类</th>
							<td>
								<input name="prodType" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写产品大类"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>海关商品编码</th>
							<td>
								<input name="hsCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写海关商品编码"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>海关商品名称</th>
							<td>
								<input name="hsName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写海关商品名称"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>品牌</th>
							<td>
								<input name="brand" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写品牌"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>海尔品名</th>
							<td>
								<input name="haierProdDesc" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写海尔品名"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HROIS简码</th>
							<td>
								<input name="simpleCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HROIS简码"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HROIS简码描述</th>
							<td>
								<input name="simpleCodeDesc" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HROIS简码描述"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>用途</th>
							<td>
								<input name="use" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写用途"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>备注</th>
							<td>
								<input name="comments" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备注"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段1</th>
							<td>
								<input name="column1" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段1"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段2</th>
							<td>
								<input name="column2" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段2"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段3</th>
							<td>
								<input name="column3" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段3"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段4</th>
							<td>
								<input name="column4" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段4"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段5</th>
							<td>
								<input name="column5" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段5"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段6</th>
							<td>
								<input name="column6" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段6"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段7</th>
							<td>
								<input name="column7" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段7"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段8</th>
							<td>
								<input name="column8" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段8"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段9</th>
							<td>
								<input name="column9" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段9"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段10</th>
							<td>
								<input name="column10" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段10"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段11</th>
							<td>
								<input name="column11" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段11"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段12</th>
							<td>
								<input name="column12" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段12"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段13</th>
							<td>
								<input name="column13" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段13"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段14</th>
							<td>
								<input name="column14" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段14"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段15</th>
							<td>
								<input name="column15" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段15"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段16</th>
							<td>
								<input name="column16" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段16"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段17</th>
							<td>
								<input name="column17" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段17"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段18</th>
							<td>
								<input name="column18" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段18"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段19</th>
							<td>
								<input name="column19" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段19"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>HS属性字段20</th>
							<td>
								<input name="column20" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段20"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="materialSparePartsEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="materialSparePartsEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>散件物料唯一标识</th>
							<td>
								<input name="sparePartsCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写散件物料唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>物料号</th>
							<td>
								<input name="materialCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写物料号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>产品大类</th>
							<td>
								<input name="prodType" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写产品大类"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>海关商品编码</th>
							<td>
								<input name="hsCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写海关商品编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>海关商品名称</th>
							<td>
								<input name="hsName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写海关商品名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>品牌</th>
							<td>
								<input name="brand" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写品牌"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>海尔品名</th>
							<td>
								<input name="haierProdDesc" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写海尔品名"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HROIS简码</th>
							<td>
								<input name="simpleCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HROIS简码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HROIS简码描述</th>
							<td>
								<input name="simpleCodeDesc" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HROIS简码描述"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>用途</th>
							<td>
								<input name="use" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写用途"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>备注</th>
							<td>
								<input name="comments" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备注"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段1</th>
							<td>
								<input name="column1" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段1"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段2</th>
							<td>
								<input name="column2" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段2"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段3</th>
							<td>
								<input name="column3" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段3"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段4</th>
							<td>
								<input name="column4" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段4"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段5</th>
							<td>
								<input name="column5" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段5"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段6</th>
							<td>
								<input name="column6" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段6"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段7</th>
							<td>
								<input name="column7" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段7"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段8</th>
							<td>
								<input name="column8" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段8"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段9</th>
							<td>
								<input name="column9" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段9"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段10</th>
							<td>
								<input name="column10" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段10"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段11</th>
							<td>
								<input name="column11" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段11"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段12</th>
							<td>
								<input name="column12" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段12"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段13</th>
							<td>
								<input name="column13" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段13"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段14</th>
							<td>
								<input name="column14" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段14"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段15</th>
							<td>
								<input name="column15" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段15"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段16</th>
							<td>
								<input name="column16" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段16"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段17</th>
							<td>
								<input name="column17" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段17"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段18</th>
							<td>
								<input name="column18" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段18"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段19</th>
							<td>
								<input name="column19" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段19"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HS属性字段20</th>
							<td>
								<input name="column20" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写HS属性字段20"  style="width: 155px;"/>
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