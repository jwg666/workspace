<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var actCntItemAddDialog;
	var actCntItemAddForm;
	var cdescAdd;
	var actCntItemEditDialog;
	var actCntItemEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'actCntItemAction!datagrid.do',
			title : '装箱明细表列表',
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
			idField : 'actCntItemCode',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.actCntItemCode;
						}
					},
			   {field:'actCntItemCode',title:'actCntItemCode',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.actCntItemCode;
					}
				},				
			   {field:'actCntCode',title:'actCntCode',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.actCntCode;
					}
				},				
			   {field:'orderNum',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderNum;
					}
				},				
			   {field:'orderItemCode',title:'订单行项目号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderItemCode;
					}
				},				
			   {field:'materialSetCode',title:'物料编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.materialSetCode;
					}
				},				
			   {field:'materialPartsCode',title:'物料分机编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.materialPartsCode;
					}
				},				
			   {field:'splitFlag',title:'套机标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.splitFlag;
					}
				},				
			   {field:'budgetQuantity',title:'预算数量',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.budgetQuantity;
					}
				},				
			   {field:'materialPackage',title:'物料/包装箱',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.materialPackage;
					}
				},				
			   {field:'grossWeight',title:'毛重',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.grossWeight;
					}
				},				
			   {field:'volume',title:'体积',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.volume;
					}
				},				
			   {field:'scanQuantity',title:'扫描数量',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.scanQuantity;
					}
				},				
			   {field:'scanFinishFlag',title:'扫描完成标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.scanFinishFlag;
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
			   {field:'containerType',title:'箱型',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.containerType;
					}
				},				
			   {field:'containerQuantity',title:'箱量',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.containerQuantity;
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

		actCntItemAddForm = $('#actCntItemAddForm').form({
			url : 'actCntItemAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					actCntItemAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		actCntItemAddDialog = $('#actCntItemAddDialog').show().dialog({
			title : '添加装箱明细表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					actCntItemAddForm.submit();
				}
			} ]
		});
		
		
		

		actCntItemEditForm = $('#actCntItemEditForm').form({
			url : 'actCntItemAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					actCntItemEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		actCntItemEditDialog = $('#actCntItemEditDialog').show().dialog({
			title : '编辑装箱明细表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					actCntItemEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '装箱明细表描述',
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
		actCntItemAddForm.form("clear");
		$('div.validatebox-tip').remove();
		actCntItemAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].actCntItemCode+"&";
						else ids=ids+"ids="+rows[i].actCntItemCode;
					}
					$.ajax({
						url : 'actCntItemAction!delete.do',
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
				url : 'actCntItemAction!showDesc.do',
				data : {
					actCntItemCode : rows[0].actCntItemCode
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					actCntItemEditForm.form("clear");
					actCntItemEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					actCntItemEditDialog.dialog('open');
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
			url : 'actCntItemAction!showDesc.do',
			data : {
				actCntItemCode : row.actCntItemCode
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有装箱明细表描述！', 'error');
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

	<div id="actCntItemAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="actCntItemAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>actCntItemCode</th>
							<td>
								<input name="actCntItemCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写actCntItemCode"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>actCntCode</th>
							<td>
								<input name="actCntCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写actCntCode"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>订单号</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>订单行项目号</th>
							<td>
								<input name="orderItemCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单行项目号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>物料编码</th>
							<td>
								<input name="materialSetCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写物料编码"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>物料分机编码</th>
							<td>
								<input name="materialPartsCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写物料分机编码"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>套机标识</th>
							<td>
								<input name="splitFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写套机标识"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>预算数量</th>
							<td>
								<input name="budgetQuantity" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写预算数量"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>物料/包装箱</th>
							<td>
								<input name="materialPackage" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写物料/包装箱"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>毛重</th>
							<td>
								<input name="grossWeight" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写毛重"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>体积</th>
							<td>
								<input name="volume" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写体积"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>扫描数量</th>
							<td>
								<input name="scanQuantity" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写扫描数量"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>扫描完成标识</th>
							<td>
								<input name="scanFinishFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写扫描完成标识"  style="width: 155px;"/>						
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
							<th>箱型</th>
							<td>
								<input name="containerType" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写箱型"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>箱量</th>
							<td>
								<input name="containerQuantity" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写箱量"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="actCntItemEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="actCntItemEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>actCntItemCode</th>
							<td>
								<input name="actCntItemCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写actCntItemCode"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>actCntCode</th>
							<td>
								<input name="actCntCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写actCntCode"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>订单号</th>
							<td>
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>订单行项目号</th>
							<td>
								<input name="orderItemCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单行项目号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>物料编码</th>
							<td>
								<input name="materialSetCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写物料编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>物料分机编码</th>
							<td>
								<input name="materialPartsCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写物料分机编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>套机标识</th>
							<td>
								<input name="splitFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写套机标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>预算数量</th>
							<td>
								<input name="budgetQuantity" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写预算数量"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>物料/包装箱</th>
							<td>
								<input name="materialPackage" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写物料/包装箱"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>毛重</th>
							<td>
								<input name="grossWeight" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写毛重"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>体积</th>
							<td>
								<input name="volume" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写体积"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>扫描数量</th>
							<td>
								<input name="scanQuantity" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写扫描数量"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>扫描完成标识</th>
							<td>
								<input name="scanFinishFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写扫描完成标识"  style="width: 155px;"/>
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
						<th>箱型</th>
							<td>
								<input name="containerType" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写箱型"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>箱量</th>
							<td>
								<input name="containerQuantity" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写箱量"  style="width: 155px;"/>
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