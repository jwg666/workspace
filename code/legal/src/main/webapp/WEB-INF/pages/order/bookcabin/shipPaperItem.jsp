<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var shipPaperItemAddDialog;
	var shipPaperItemAddForm;
	var cdescAdd;
	var shipPaperItemEditDialog;
	var shipPaperItemEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'shipPaperItemAction!datagrid.do',
			title : '下货纸明细列表',
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
			   {field:'rowId',title:'唯一标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.rowId;
					}
				},				
			   {field:'itemLineCode',title:'行项目号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.itemLineCode;
					}
				},				
			   {field:'shipPaperRowId',title:'下货纸号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.shipPaperRowId;
					}
				},				
			   {field:'orderCode',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
			   {field:'orderItemLineCode',title:'订单行项目号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderItemLineCode;
					}
				},				
			   {field:'goodsMark',title:'唛头',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.goodsMark;
					}
				},				
			   {field:'goodsAmount',title:'数量',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.goodsAmount;
					}
				},				
			   {field:'goodsCount',title:'箱数或者件数',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.goodsCount;
					}
				},				
			   {field:'goodsPacageName',title:'包装种类与货名',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.goodsPacageName;
					}
				},				
			   {field:'goodsGrossWeight',title:'毛重',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.goodsGrossWeight;
					}
				},				
			   {field:'goodsSize',title:'尺码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.goodsSize;
					}
				},				
			   {field:'goodsPrice',title:'单价',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.goodsPrice;
					}
				},				
			   {field:'activeFlag',title:'是否有效，0无效 1有效',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.activeFlag;
					}
				}				
			 ] ],
// 			toolbar : [ {
// 				text : '增加',
// 				iconCls : 'icon-add',
// 				handler : function() {
// 					add();
// 				}
// 			}, '-', {
// 				text : '删除',
// 				iconCls : 'icon-remove',
// 				handler : function() {
// 					del();
// 				}
// 			}, '-', {
// 				text : '修改',
// 				iconCls : 'icon-edit',
// 				handler : function() {
// 					edit();
// 				}
// 			}, '-', {
// 				text : '取消选中',
// 				iconCls : 'icon-undo',
// 				handler : function() {
// 					datagrid.datagrid('unselectAll');
// 				}
// 			}, '-' ],
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

		shipPaperItemAddForm = $('#shipPaperItemAddForm').form({
			url : 'shipPaperItemAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					shipPaperItemAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		shipPaperItemAddDialog = $('#shipPaperItemAddDialog').show().dialog({
			title : '添加下货纸明细',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					shipPaperItemAddForm.submit();
				}
			} ]
		});
		
		
		

		shipPaperItemEditForm = $('#shipPaperItemEditForm').form({
			url : 'shipPaperItemAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					shipPaperItemEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		shipPaperItemEditDialog = $('#shipPaperItemEditDialog').show().dialog({
			title : '编辑下货纸明细',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					shipPaperItemEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '下货纸明细描述',
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
		shipPaperItemAddForm.form("clear");
		$('div.validatebox-tip').remove();
		shipPaperItemAddDialog.dialog('open');
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
						url : 'shipPaperItemAction!delete.do',
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
			$.messager.progress({ text : '数据加载中....', interval : 800 });
			$.ajax({
				url : 'shipPaperItemAction!showDesc.do',
				data : {
					rowId : rows[0].rowId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					shipPaperItemEditForm.form("clear");
					shipPaperItemEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					shipPaperItemEditDialog.dialog('open');
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
		$.messager.progress({ text : '数据加载中....', interval : 800 });
		$.ajax({
			url : 'shipPaperItemAction!showDesc.do',
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
					$.messager.alert('提示', '没有下货纸明细描述！', 'error');
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

	<div id="shipPaperItemAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="shipPaperItemAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>唯一标识</th>
							<td>
								<input name="rowId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>行项目号</th>
							<td>
								<input name="itemLineCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写行项目号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>下货纸号</th>
							<td>
								<input name="shipPaperRowId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写下货纸号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>订单号</th>
							<td>
								<input name="orderCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>订单行项目号</th>
							<td>
								<input name="orderItemLineCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单行项目号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>唛头</th>
							<td>
								<input name="goodsMark" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写唛头"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>数量</th>
							<td>
								<input name="goodsAmount" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写数量"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>箱数或者件数</th>
							<td>
								<input name="goodsCount" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写箱数或者件数"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>包装种类与货名</th>
							<td>
								<input name="goodsPacageName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写包装种类与货名"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>毛重</th>
							<td>
								<input name="goodsGrossWeight" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写毛重"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>尺码</th>
							<td>
								<input name="goodsSize" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写尺码"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>单价</th>
							<td>
								<input name="goodsPrice" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写单价"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>是否有效，0无效 1有效</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写是否有效，0无效 1有效"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="shipPaperItemEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="shipPaperItemEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>唯一标识</th>
							<td>
								<input name="rowId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>行项目号</th>
							<td>
								<input name="itemLineCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写行项目号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>下货纸号</th>
							<td>
								<input name="shipPaperRowId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写下货纸号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>订单号</th>
							<td>
								<input name="orderCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>订单行项目号</th>
							<td>
								<input name="orderItemLineCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单行项目号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>唛头</th>
							<td>
								<input name="goodsMark" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写唛头"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>数量</th>
							<td>
								<input name="goodsAmount" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写数量"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>箱数或者件数</th>
							<td>
								<input name="goodsCount" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写箱数或者件数"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>包装种类与货名</th>
							<td>
								<input name="goodsPacageName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写包装种类与货名"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>毛重</th>
							<td>
								<input name="goodsGrossWeight" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写毛重"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>尺码</th>
							<td>
								<input name="goodsSize" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写尺码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>单价</th>
							<td>
								<input name="goodsPrice" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写单价"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>是否有效，0无效 1有效</th>
							<td>
								<input name="activeFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写是否有效，0无效 1有效"  style="width: 155px;"/>
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