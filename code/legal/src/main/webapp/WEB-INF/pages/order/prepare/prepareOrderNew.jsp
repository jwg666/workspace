<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
var searchForm;
var datagrid;
var datagrid1;
var datagrid2;
var prepareOrderAddDialog;
var prepareOrderAddForm;
var cdescAdd;
var prepareOrderEditDialog;
var prepareOrderDetailDialog; //明细Dialog
var prepareOrderEditForm;
var cdescEdit;
var showCdescDialog;
var iframeDialog;
var myJson;
$(function() {
	//查询列表	
	searchForm = $('#searchForm').form();
	datagrid = $('#datagrid').datagrid({
//		url:'techOrderAction!typeManagerWorkDataGrid.do?definitionKey=approveTask',
		url : 'prepareOrderAction!prepareOrderdatagridNeed.do?definitionKey=prepareOrder',
//		url : 'prepareOrderAction!datagridNeed.do',
		title : '待办任务列表',
		iconCls : 'icon-save',
		pagination : true,
		pagePosition : 'bottom',
		rownumbers : true,
		pageSize : 10,
		height : 280,
		pageList : [ 10, 20, 30, 40 ],
		fitColumns : true,
		nowrap : true,
		border : false,
		checkOnSelect : false,
		selectOnCheck : false,
		singleSelect : true,
		idField : 'orderCode',
		columns : [ [ {
			ield : 'ck',
			checkbox : true,
			formatter : function(value, row, index) {
				return row.orderCode;}
						}, {
			field : 'actPrepareCode',
			title : '序号',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return ++index;}
						}, {
			field : 'orderCode',
			title : '订单号',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.orderCode;}
						}, {
			field : 'factoryCode',
			title : '工厂',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.factoryCode;}
						}, {
			field : 'deptCode',
			title : '经营主体',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
					return row.deptCode;}
						}, {
			field : 'countryCode',
			title : '出口国家',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
					return row.countryCode;}
						}, {
			field : 'saleArea',
			title : '市场区域',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.saleArea;
							}
						}, {
			field : 'orderProdManager',
			title : '产品经理',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.orderProdManager;
							}
						}, {
			field : 'releaseFlag',
			title : '闸口状态',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.releaseFlag;
							}
						} ] ],

			toolbar : [ {
				text : '批量分单',
				iconCls : 'icon-undo',
				handler : function() {
				addListOrderItem();}
				}, '-', {
				text : '分单',
				iconCls : 'icon-undo',
				handler : function() {
				addprepareOrder();}
				}, '-' ],
		onClickRow : function(rowIndex, rowData) {
			    var rowd = datagrid.datagrid('getSelected');
				$('#datagrid1').datagrid({
					url : '${dynamicURL}/prepare/prepareOrderAction!datagridSales.do?orderCodes='+ rowd.orderCode});
				//加载datagrid1数据时 清空datagrid2 中的数据 
				var item = $('#datagrid2').datagrid('getRows');
				if (item) {
					for ( var i = item.length - 1; i >= 0; i--) {
					var index = $('#datagrid2').datagrid('getRowIndex', item[i]);
				$('#datagrid2').datagrid('deleteRow',index);}}
				$('#datagrid2').datagrid('loadData', {total : 0,rows : []});},
		onRowContextMenu : function(e, rowIndex, rowData) {e.preventDefault();
					$(this).datagrid('unselectAll');
					$(this).datagrid('selectRow', rowIndex);
					$('#menu').menu('show', {
						left : e.pageX,
						top : e.pageY
							});
						}
					});

	datagrid1 = $('#datagrid1').datagrid({
		title : '明细列表',
		iconCls : 'icon-save',
		pagination : false,
		rownumbers : true,
		pageSize : 10,
		//height : 200,
		//width : 500,
		checkbox : true,
		pageList : [ 10, 20, 30, 40 ],
		fit : true,
		fitColumns : true,
		nowrap : true,
		border : false,
		idField : 'orderItemLinecode',
		columns : [ [ {
			field : 'orderItemLinecode',
			title : '行项目',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.orderItemLinecode;
			}
		}, {
			field : 'haierModel',
			title : '海尔型号',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.haierModel;
			}
		}, {
			field : 'customerModel',
			title : '客户型号',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.customerModel;
			}
		}, {
			field : 'materialCode',
			title : '物料号',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.materialCode;
			}
		}, {
			field : 'prodQuantity',
			title : '可分配数量',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.prodQuantity;
			}
		} ] ],
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

	datagrid2 = $('#datagrid2').datagrid({
		title : '分配列表',
		iconCls : 'icon-save',
		pagination : false,
		rownumbers : true,
		pageSize : 10,
		//height : 200,
		//width : 500,
		checkbox : false,
		pageList : [ 10, 20, 30, 40 ],
		fit : true,
		fitColumns : true,
		nowrap : true,
		border : false,
		idField : 'orderItemLinecode',
		columns : [ [ {
			field : 'orderItemLinecode',
			title : '行项目号',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.orderItemLinecode;
			}
		}, {
			field : 'materialCode',
			title : '物料号',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.materialCode;
			}
		}, {
			field : 'prodQuantity',
			title : '分配数量',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.prodQuantity;
			}
		} ] ],
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

	prepareOrderAddForm = $('#prepareOrderAddForm').form({
		url : 'prepareOrderAction!editSales.do',
		success : function(data) {
			var rowsSelect = $('#datagrid1').datagrid('getSelected');
			var json = $.parseJSON(data);
			if (json && json.success) {
				$.messager.show({
					title : '成功',
					msg : json.msg
				});
				datagrid2.datagrid('reload');
				prepareOrderAddDialog.dialog('close');
			} else {
				$.messager.show({
					title : '失败',
					msg : '操作失败！'
				});
			}
		}
	});
	//datagrid1像datagrid2中分配数据
	prepareOrderAddDialog = $('#prepareOrderAddDialog').show().dialog({
		title : '填写可分配数量',
		modal : true,
		closed : true,
		maximizable : true,
		buttons : [ {
			text : '添加',
			handler : function() {
		/* prepareOrderAddForm.submit(); */
			var quantity = $("#quantity").val(); //获取分配数量
			var rowsSelect = datagrid1.datagrid('getSelected'); //获取datagrid1所选中行的信息
		if (quantity <= rowsSelect.prodQuantity) {
			var rowindex = datagrid1.datagrid('getRowIndex', rowsSelect);
			var rows = datagrid2.datagrid('getRows');
			if (rows.length == 0) {
			var qua = rowsSelect.prodQuantity;
			rowsSelect.prodQuantity = quantity; //将text填写框的内容赋值给   datagrid1所选中行的信息
		//将要传的信息封装成json对象
			myJson = [ {
				'orderItemLinecode' : rowsSelect.orderItemLinecode,
				'materialCode' : rowsSelect.materialCode,
				'prodQuantity' : rowsSelect.prodQuantity,
				'customerModel' : rowsSelect.customerModel,
				'haierModel' : rowsSelect.haierModel} ];
		//datagrid2 加载myJson对象的内容
			$("#datagrid2").datagrid('loadData', myJson);
		//根据 ID 获 得行信息
			var roindex = $("#datagrid2").datagrid('getRowIndex',rowsSelect.orderItemLinecode);
		// 修改datagrid2中的prodQuantity属性信息
			$("#datagrid2").datagrid('updateRow',{
				index : roindex,
				row : {prodQuantity : quantity}});
		//重新加载datagrid1的选中的行信息
			if (qua - quantity == 0) {
			$("#datagrid1").datagrid('deleteRow', rowindex);
			prepareOrderAddDialog.dialog('close');
			}else {
			$("#datagrid1").datagrid('updateRow',{
				index : rowindex,
				row : {prodQuantity : qua - quantity}});
			}
		//
			$("#datagrid1").datagrid('refreshRow', roindex);
			prepareOrderAddDialog.dialog('close');
			} else {
			for ( var i = 0; i < rows.length; i++) {
			if (rowsSelect.orderItemLinecode == rows[i].orderItemLinecode) {
			var ququq = parseInt(rowsSelect.prodQuantity)+ parseInt(rows[i].prodQuantity);
			rowsSelect.prodQuantity = quantity; //将text填写框的内容赋值给   datagrid1所选中行的信息
		//将要传的信息封装成json对象
			myJson = [ {
				'orderItemLinecode' : rowsSelect.orderItemLinecode,
				'materialCode' : rowsSelect.materialCode,
				'prodQuantity' : rowsSelect.prodQuantity,
				'customerModel' : rowsSelect.customerModel,
				'haierModel' : rowsSelect.haierModel} ];
		//datagrid2 加载myJson 对象的内容
		//根据 ID 获得行信息 
			var roindex = $("#datagrid2").datagrid('getRowIndex',rowsSelect.orderItemLinecode);
		// 修改datagrid2中的prodQuantity 属性信息
			$("#datagrid2").datagrid('updateRow',{
				index : roindex,
				row : {
				'customerModel' : rowsSelect.customerModel,
				'haierModel' : rowsSelect.haierModel,
				'orderItemLinecode' : rowsSelect.orderItemLinecode,
				'materialCode' : rowsSelect.materialCode,
				'prodQuantity' : parseInt(rows[i].prodQuantity)+ parseInt(rowsSelect.prodQuantity)
			}});
		//重新加载datagrid1的选中的行信息
			if (ququq - rows[i].prodQuantity == 0) {
			$("#datagrid1").datagrid('deleteRow',rowindex);
			} else {
			$("#datagrid1").datagrid('updateRow',{
				index : rowindex,
				row : {
					prodQuantity : ququq - rows[i].prodQuantity}});
			}
		//$("#datagrid1").datagrid('refreshRow',roindex);
			prepareOrderAddDialog.dialog('close');
			break;
			} else {
			var myBoolean = new Boolean(true);
			for ( var j = 0; j < rows.length; j++) {
			if (rowsSelect.orderItemLinecode == rows[j].orderItemLinecode) {
				myBoolean = false;
			} else {}
			}
			if (myBoolean == true) {
			var qua = rowsSelect.prodQuantity;
			rowsSelect.prodQuantity = quantity; //将text填写框的内容赋值给   datagrid1所选中行的信息
		//将要传的信息封装成json对象
			myJson = [ {
				'orderItemLinecode' : rowsSelect.orderItemLinecode,
				'materialCode' : rowsSelect.materialCode,
				'prodQuantity' : rowsSelect.prodQuantity,
				'customerModel' : rowsSelect.customerModel,
				'haierModel' : rowsSelect.haierModel
					} ];
		//datagrid2 加载myJson 对象的内容
			$("#datagrid2").datagrid('appendRow',{
				'orderItemLinecode' : rowsSelect.orderItemLinecode,
				'materialCode' : rowsSelect.materialCode,
				'prodQuantity' : rowsSelect.prodQuantity,
				'customerModel' : rowsSelect.customerModel,
				'haierModel' : rowsSelect.haierModel
			});
			if (qua - quantity == 0) {
			$("#datagrid1").datagrid('deleteRow',rowindex);
			} else {
			$("#datagrid1").datagrid('updateRow',{
				index : rowindex,
				row : {
					prodQuantity : qua- quantity}});}
			break;
		//$("#datagrid1").datagrid('refreshRow',roindex);
			}}}
			prepareOrderAddDialog.dialog('close');
			}
		} else {
		$.messager.alert('提示', '分配数量大于可分配数量！','error');}}
		}]
		});

	prepareOrderEditForm = $('#prepareOrderEditForm').form({
		url : 'prepareOrderAction!edit.do',
		success : function(data) {
			var json = $.parseJSON(data);
			if (json && json.success) {
				$.messager.show({
					title : '成功',
					msg : json.msg
				});
				datagrid.datagrid('reload');
				prepareOrderEditDialog.dialog('close');
			} else {
				$.messager.show({
					title : '失败',
					msg : '操作失败！'
				});
			}
		}
	});

	prepareOrderEditDialog = $('#prepareOrderEditDialog').show().dialog({
		title : '编辑小备单生成表',
		modal : true,
		closed : true,
		maximizable : true,
		buttons : [ {
			text : '编辑',
			handler : function() {
				prepareOrderEditForm.submit();
			}
		} ]
	});

	showCdescDialog = $('#showCdescDialog').show().dialog({
		title : '小备单生成表描述',
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

	prepareOrderDetailDialog = $('#prepareOrderDetailDialog').show().dialog({
				title : '备货单录入',
				modal : true,
				closed : true,
				maximizable : true,
				maximized : true,
				collapsible : true
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
	prepareOrderAddForm.form("clear");
	$('div.validatebox-tip').remove();
	prepareOrderAddDialog.dialog('open');
}

function delDetail() {
	var rowsSelect = $('#datagrid2').datagrid('getSelected');
	var idx = $('#datagrid1').datagrid('getRowIndex',rowsSelect.orderItemLinecode);
	var roindex = $("#datagrid2").datagrid('getRowIndex', rowsSelect);
	var rows = $('#datagrid1').datagrid('getRows');

	//获取被选行ID
	$($('#datagrid1').datagrid('getRows')).each(
		function(i, row) {
		if (rowsSelect.orderItemLinecode == row.orderItemLinecode) {
		var rowindex = $("#datagrid1").datagrid('getRowIndex', row.orderItemLinecode);
		datagrid1.datagrid('updateRow',{
			index : rowindex,
			row : {prodQuantity : parseInt(rowsSelect.prodQuantity)+ parseInt(row.prodQuantity)}
		});
		datagrid2.datagrid('deleteRow', roindex);
		}});
	if (idx == -1) {
		$("#datagrid1").datagrid('appendRow', {
			'orderItemLinecode' : rowsSelect.orderItemLinecode,
			'materialCode' : rowsSelect.materialCode,
			'prodQuantity' : rowsSelect.prodQuantity,
			'customerModel' : rowsSelect.customerModel,
			'haierModel' : rowsSelect.haierModel
		});
		datagrid2.datagrid('deleteRow', roindex);
	}
}
function del() {
	var rows = datagrid.datagrid('getSelections');
	var ids = "";
	if (rows.length > 0) {
		$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
			if (r) {
				for ( var i = 0; i < rows.length; i++) {
					if (i != rows.length - 1)
						ids = ids + "ids=" + rows[i].actPrepareCode + "&";
					else
						ids = ids + "ids=" + rows[i].actPrepareCode;
				}
				$.ajax({
					url : 'prepareOrderAction!delete.do',
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
			url : 'salesOrderItemAction!showDesc.do',
			data : {
				orderCode : rows[0].orderCode
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				prepareOrderEditForm.form("clear");
				prepareOrderEditForm.form('load', response);
				$('div.validatebox-tip').remove();
				prepareOrderEditDialog.dialog('open');
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
		url : 'prepareOrderAction!showDesc.do',
		data : {
			actPrepareCode : row.actPrepareCode
		},
		dataType : 'json',
		cache : false,
		success : function(response) {
			if (response && response.cdesc) {
				showCdescDialog.find('div[name=cdesc]')
						.html(response.cdesc);
				showCdescDialog.dialog('open');
			} else {
				$.messager.alert('提示', '没有小备单生成表描述！', 'error');
			}
			$.messager.progress('close');
		}
	});
	datagrid.datagrid('unselectAll');
}

function addprepareOrder() {
	//获取系统当前日期
	var currentTime = "";
	var myDate = new Date();
	var month = parseInt(myDate.getMonth().toString()) + 1;
	if (month < 10) {
		month = "0" + month.toString();
	}
	currentTime = myDate.getFullYear().toString() + '-' + month + "-"
			+ myDate.getDate().toString();
	//获取首样开始时间 (默认是生产计划开始时间前一天)
	var currentTime1 = "";
	var myDate1 = new Date();
	var month1 = parseInt(myDate1.getMonth().toString()) + 1;
	if (month1 < 10) {
		month1 = "0" + month1.toString();
	}
	var date1 = parseInt(myDate1.getDate().toString()) - 1;
	currentTime1 = myDate1.getFullYear().toString() + '-' + month1 + "-"
			+ date1;

	var rows = datagrid.datagrid('getChecked');
	var ros = datagrid2.datagrid('getRows');
	var rowsSelect = datagrid.datagrid('getSelected');
	if (rowsSelect.orderShipDate != null) {
		var shipTime = rowsSelect.orderShipDate.toString().substr(0, 10);
	}
	;
	if (rows.length > 1) {
		$.messager.alert('提示', '请选择一项分单的记录！', 'error');
	} else {
		prepareOrder_detail();
		$.ajax({
		url : '${dynamicURL}/security/departmentAction!getFindCheckCode.do',
		data : {
			'deptCode' : rowsSelect.deptCode
		},
		dataType : 'text',
		success : function(data) {
			if (data == "null") {
			contractDetailForm.form('load',{
				'taskId' : rowsSelect.taskId,
				'orderNum' : rowsSelect.orderCode,
				'orderItemLinecode' : rowsSelect.orderItemLinecode,
				'materialCode' : rowsSelect.materialCode,
				'prodQuantity' : rowsSelect.prodQuantity,
				'contractCode' : rowsSelect.contractCode,
				'countryCode' : rowsSelect.countryCode,
				'customerModel' : rowsSelect.customerModel,
				'orderBuyoutFlag' : rowsSelect.orderBuyoutFlag,
				'manuEndDate' : shipTime,
				'packingEndDate' : shipTime,
				'checkEndDate' : shipTime,
				'manuStartDate' : currentTime,
				'packingStartDate' : currentTime,
				'checkStartDate' : currentTime,
				'firstSampleDate' : currentTime1
			});
			} else {
			var adata = data.substr(1, 10);
			contractDetailForm.form('load',{
				'taskId' : rowsSelect.taskId,
				'orderNum' : rowsSelect.orderCode,
				'orderItemLinecode' : rowsSelect.orderItemLinecode,
				'materialCode' : rowsSelect.materialCode,
				'prodQuantity' : rowsSelect.prodQuantity,
				'contractCode' : rowsSelect.contractCode,
				'countryCode' : rowsSelect.countryCode,
				'customerModel' : rowsSelect.customerModel,
				'orderBuyoutFlag' : rowsSelect.orderBuyoutFlag,
				'manuEndDate' : shipTime,
				'packingEndDate' : shipTime,
				'checkEndDate' : shipTime,
				'manuStartDate' : currentTime,
				'packingStartDate' : currentTime,
				'checkStartDate' : currentTime,
				'firstSampleDate' : currentTime1,
				'checkCode' : adata
			});
			}}
			});

		$.ajax({
			url : '${dynamicURL}/salesOrder/salesOrderItemAction!getActprepareName.do',
			data : {
				'orderCode' : rowsSelect.orderCode
			},
			dataType : 'text',
			success : function(data) {
				var adata = data.substr(1, 13);
				contractDetailForm.find("[name='actPrepareCode']").val(adata);
					}
				});
		//清空 datagrid_contract_one 原有数据 加载新数据
		$('#datagrid_contract_one').datagrid('loadData', { total: 0, rows: [] }); 
		for ( var i = 0; i < ros.length; i++) {
			//加载新数据
			$('#datagrid_contract_one').datagrid('appendRow', {
				'actPrepareOrderItemCode' : rowsSelect.orderCode,
				'orderLinecode' : ros[i].orderItemLinecode,
				'prodTcode' : rowsSelect.prodTcode,
				'haierModer' : rowsSelect.haierModer,
				'customerModel' : rowsSelect.customerModel,
				'addirmNum' : rowsSelect.addirmNum,
				'materialCode' : ros[i].materialCode,
				'quantity' : ros[i].prodQuantity,
				'releaseFlag' : rowsSelect.releaseFlag,
				'hrDate' : rowsSelect.hrDate,
				'plcStatus' : rowsSelect.plcStatus
			});
		};
		contractDetailForm.find('input,textarea').attr("readonly", false);
		prepareOrderDetailDialog.dialog("open");
	}
}

function addListOrderItem() {
	var dddd = $('#datagrid').datagrid('getChecked');
}
</script>
</head>
	<jsp:include page="prepareOrderAdd.jsp" />
	<div region="north" border="false" class="zoc"
		style="height: 100px; overflow: auto;" align="left">
		<form id="searchForm" method="post">
			<div class="navhead_zoc">
				<span>分备货单</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>操作：</span>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">订单号 ：</div>
						<div class="righttext">
							<input id="orderCode" name="orderCode"
								style="width: 160px;" />
						</div>
					</div>
					<div class="item33">
						<div class="righttext">
							<input type="button" value="查  询" onclick="_search();;" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center" class="part_zoc">
		<div>
			<table id="datagrid"></table>
		</div>
		<div class="partnavi_zoc">
			<span>分备货单分单明细</span>
		</div>
		<div style="float: left;  height: 200px;width : 400px;">
			<table id="datagrid1" singleSelect="true"></table>
		</div>
		<div style="float: left;">
			<div style="margin-top: 60%; width : 100px; margin-left: 20px;">
				<button style="width: 80%; height: 30px;" onclick="add();">增加  >></button>
			</div>
			<div style="margin-top: 10px;margin-left: 20px;">
				<button style="width: 80%; height: 30px;" onclick="delDetail();">删除
					<<</button>
			</div>
		</div>
		<div style="float: left; height: 200px; ;width : 400px;">
			<table id="datagrid2" singleSelect="true"></table>
		</div>
	</div>
	
	
	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="prepareOrderAddDialog"
		style="display: none; width: 200px; height: 100px;" align="center">
		<form id="prepareOrderAddForm" method="post">
			<table class="tableForm">
				<tr>
					<th>请填写数量</th>
					<td><input name="prodQuantity" type="text" id="quantity"
						class="easyui-validatebox" data- options="required:true"
						missingMessage="请填写可分配数量" style="width: 60px;" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="prepareOrderEditDialog"
		style="display: none; width: 500px; height: 300px;" align="center">
		<form id="prepareOrderEditForm" method="post">
			<table class="tableForm">
				<tr>
					<th>序号</th>
					<td><input name="actPrepareCode" type="text"
						class="easyui-validatebox" data- options="required:true"
						missingMessage="请填写备单编号" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>订单号</th>
					<td><input name="orderCode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写if_damager" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>工厂</th>
					<td><input name="factoryCode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写商检批次号" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>经营主体</th>
					<td><input name="deptCode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写生产工厂编号" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>出口国家</th>
					<td><input name="countryCode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写结算工厂" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>市场区域</th>
					<td><input name="saleArea" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写销售渠道" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>产品经理</th>
					<td><input name="orderProdManager" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写settlementType" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>闸口状态</th>
					<td><input name="releaseFlag" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写销售组织编号" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>经营[主]体编号</th>
					<td><input name="deptCode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写经营[主]体编号" style="width: 155px;" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="showCdescDialog"
		style="display: none; overflow: auto; width: 500px; height: 400px;">
		<div name="cdesc"></div>
	</div>

	<div id="iframeDialog"
		style="display: none; overflow: auto; width: 600px; height: 400px;">
		<iframe name="iframe" id="iframe" src="#" scrolling="auto"
			frameborder="0" style="width: 100%; height: 100%;"> </iframe>
	</div>
</html>