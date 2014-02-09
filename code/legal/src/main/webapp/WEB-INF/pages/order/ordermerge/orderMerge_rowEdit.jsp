<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var editRow = undefined;
	var datagrid;
	var mergedatagrid;
	var prepareOrderAddDialog;
	var prepareOrderAddForm;
	$(function() {
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid(
				{
					url : 'orderMergeAction!datagrid.action?orderNumT='
							+ '${orderNum}',
					title : '订单选择',
					iconCls : 'icon-save',
					fit : true,
					fitColumns : false,
					rownumbers : true,
					checkOnSelect : false,
					selectOnCheck : false,
					singleSelect : true,
					nowrap : true,
					border : false,
					columns : [ [ {
						field : 'ck',
						checkbox : true,
						formatter : function(value, row, index) {
							return row.obid;
						}
					}, {
						field : 'orderNum',
						title : '订单号',
						align : 'center',
						sortable : false,
						width : 100,
						formatter : function(value, row, index) {
							return row.orderNum;
						}
					}, {
						field : 'orderLinecode',
						title : '订单行项目号',
						align : 'center',
						sortable : false,
						width : 100,
						formatter : function(value, row, index) {
							return row.orderLinecode;
						}
					}, {
						field : 'mergeNum',
						title : '合并系数',
						align : 'center',
						sortable : false,
						width : 60,
						editor : {
							type : 'numberbox',
							options : {}
						},
						formatter : function(value, row, index) {
							return row.mergeNum;
						}
					}, {
						field : 'haierModel',
						title : '海尔型号',
						align : 'center',
						sortable : false,
						width : 100,
						formatter : function(value, row, index) {
							return row.haierModel;
						}
					}, {
						field : 'customerModel',
						title : '客户型号',
						align : 'center',
						sortable : false,
						width : 100,
						formatter : function(value, row, index) {
							return row.customerModel;
						}
					}, {
						field : 'materialCode',
						title : '物料号',
						align : 'center',
						sortable : false,
						width : 100,
						formatter : function(value, row, index) {
							return row.materialCode;
						}
					}, {
						field : 'quantity',
						title : '数量',
						align : 'center',
						sortable : false,
						width : 50,
						formatter : function(value, row, index) {
							return row.quantity;
						}
					}, {
						field : 'unit',
						title : '单位',
						align : 'center',
						sortable : false,
						width : 50,
						formatter : function(value, row, index) {
							return row.unit;
						}
					}, {
						field : 'price',
						title : '单价',
						align : 'center',
						sortable : false,
						width : 50,
						formatter : function(value, row, index) {
							return row.price;
						}
					}, {
						field : 'amount',
						title : '总额',
						align : 'center',
						sortable : false,
						width : 100,
						formatter : function(value, row, index) {
							return row.amount;
						}
					}, {
						field : 'custPrice',
						title : '报关单价',
						align : 'center',
						sortable : false,
						width : 60,
						formatter : function(value, row, index) {
							return row.custPrice;
						}
					}, {
						field : 'custAmount',
						title : '报关总额',
						align : 'center',
						sortable : false,
						width : 100,
						formatter : function(value, row, index) {
							return row.custAmount;
						}
					}, {
						field : 'netWeight',
						title : '净重',
						align : 'center',
						sortable : false,
						width : 50,
						formatter : function(value, row, index) {
							return row.netWeight;
						}
					}, {
						field : 'grossWeight',
						title : '毛重',
						align : 'center',
						sortable : false,
						width : 50,
						formatter : function(value, row, index) {
							return row.grossWeight;
						}
					}, {
						field : 'value',
						title : '体积',
						align : 'center',
						sortable : false,
						width : 50,
						formatter : function(value, row, index) {
							return row.value;
						}
					},{
						field : 'activeFlag',
						title : '套机内外机',
						hidden : true,
						sortable : false,
						width : 50,
						formatter : function(value, row, index) {
							return row.activeFlag;
						}
					},{
						field : 'prodType',
						title : '产品大类',
						hidden : true,
						sortable : false,
						width : 50,
						formatter : function(value, row, index) {
							return row.prodType;
						}
					} ] ],
					toolbar : [ {
						text : '填写合并系数',
						iconCls : 'icon-edit',
						handler : function() {
							edit();
						}
					}, '-', {
						text : '合并',
						iconCls : 'icon-add',
						handler : function() {
							setMergeNum();
						}
					}, '-' ],
					onClickRow : function(rowIndex, rowData) {
						if (editRow != undefined) {
							datagrid.datagrid('endEdit', editRow);
						}
					},
					onLoadSuccess : function(rowIndex, rowData) {
						computeSum();
					}
				});
		$("#orderNum").val('${orderNum}');
		mergedatagrid = $('#mergedatagrid').datagrid({
			iconCls : 'icon-save',
			fit : true,
			fitColumns : false,
			rownumbers : true,
			nowrap : false,
			border : false,
			idField : 'obid',
			
			frozenColumns : [ [ {
				field : 'orderNum',
				title : '订单号',
				align : 'center',
				sortable : false,
				width : 100,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			}, {
				field : 'mergeOrderNum',
				title : '被合并订单号',
				align : 'center',
				sortable : false,
				width : 100,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.mergeOrderNum;
				}
			}, {
				field : 'orderLinecode',
				title : '订单行项目号',
				align : 'center',
				sortable : false,
				width : 80,
				formatter : function(value, row, index) {
					return row.orderLinecode;
				}
			}, {
				field : 'haierModel',
				title : '海尔型号',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.haierModel;
					//return '<div style="word-break:break-all;">'+row.haierModel+'</div>';
				}
			}, {
				field : 'customerModel',
				title : '客户型号',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.customerModel;
				}
			}, {
				field : 'materialCode',
				title : '物料号',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			},{
				field : 'mergeMaterial',
				title : '合并物料编码',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.mergeMaterial;
				}
			},{
				field : 'prodType',
				title : '产品大类',
				hidden : true,
				sortable : false,
				width : 50,
				formatter : function(value, row, index) {
					return row.prodType;
				}
			}
			] ],
			columns : [ [ {
				field : 'haierProdDesc',
				title : '货描',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.haierProdDesc;
				}
			},{
				field : 'simpleCode',
				title : '简码',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.simpleCode;
				}
			},{
				field : 'quantity',
				title : '数量',
				align : 'center',
				sortable : false,
				width : 50,
				formatter : function(value, row, index) {
					return row.quantity;
				}
			}, {
				field : 'unit',
				title : '单位',
				align : 'center',
				sortable : false,
				width : 50,
				formatter : function(value, row, index) {
					return row.unit;
				}
			}, {
				field : 'piece',
				title : '件数',
				align : 'center',
				sortable : false,
				width : 50,
				formatter : function(value, row, index) {
					return row.piece;
				}
			}, {
				field : 'price',
				title : '单价',
				align : 'center',
				sortable : false,
				width : 50,
				formatter : function(value, row, index) {
					return row.price;
				}
			}, {
				field : 'amount',
				title : '总额',
				align : 'center',
				sortable : false,
				width : 100,
				formatter : function(value, row, index) {
					return Number(row.amount).toFixed(2);
				}
			}, {
				field : 'custPrice',
				title : '报关单价',
				align : 'center',
				sortable : false,
				width : 60,
				formatter : function(value, row, index) {
					if(row.custPrice=='' || row.custPrice==null){
						return "";
					}else{
						return Number(row.custPrice).toFixed(2);
					}
				}
			}, {
				field : 'custAmount',
				title : '报关总额',
				align : 'center',
				sortable : false,
				width : 100,
				formatter : function(value, row, index) {
					return Number(row.custAmount).toFixed(2);
				}
			}, {
				field : 'netWeight',
				title : '净重',
				align : 'center',
				sortable : false,
				width : 50,
				formatter : function(value, row, index) {
					return Number(row.netWeight).toFixed(2);
				}
			}, {
				field : 'grossWeight',
				title : '毛重',
				align : 'center',
				sortable : false,
				width : 50,
				formatter : function(value, row, index) {
					return Number(row.grossWeight).toFixed(2);
				}
			}, {
				field : 'value',
				title : '体积',
				align : 'center',
				sortable : false,
				width : 50,
				formatter : function(value, row, index) {
					return row.value;
				}
			}, {
				field : 'mergeRole',
				title : '合并规则',
				align : 'center',
				sortable : false,
				width : 250,
				formatter : function(value, row, index) {
					return row.mergeRole;
				}
			} ] ],
			toolbar : [ {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					if (editRow != undefined) {
						datagrid.datagrid('endEdit', editRow);
					}
					saveMergeOrder();
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
					mergeEdit();
				}
			},'-', {
				text : '修改完成',
				iconCls : 'icon-edit',
				handler : function() {
					if (editRow != undefined) {
						mergedatagrid.datagrid('endEdit', editRow);
					}
				}
			} ],
			onLoadSuccess : function(rowIndex, rowData) {
				computeMergeSum();
			},
			onClickRow : function(rowIndex, rowData) {
				if (editRow != undefined) {
					mergedatagrid.datagrid('endEdit', editRow);
				}
			},
		});
		prepareOrderAddForm = $('#prepareOrderAddForm').form();
		prepareOrderAddDialog = $('#prepareOrderAddDialog').show().dialog({
			title : '填写合并数量<span style="color: red;">（不可以超过合并物料的最大数量）</span>',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '合并',
				handler : function() {
					//验证输入的套数是否超过最大值
					mergeOrderItem();
				}
			} ]
		});
		computeMergeSum();
	});
	//查询
	function _search() {
		//判断是否已经开始合并
		var rows = mergedatagrid.datagrid('getRows');
		if (rows.length > 1) {
			$.messager.confirm('请确认', '已经开始合并订单，如若重新查询将会清空已经合并的数据？',
					function(r) {
						if (r) {
							mergedatagrid.datagrid('loadData', {
								"rows" : []
							});
						}
					});
		}
		if ($("#orderNum").val() == "") {
			alert("请优先输入订单编号！");
			return;
		}
		if ($("#mergeOrderNum").val() != "") {
			//当合并两个不同的订单时验证产品大类必须是家用和商用空调的，客户、目的港、出运期必须相同
			$
					.ajax({
						url : 'orderMergeAction!checkTwoOrder.action',
						data : {
							mergeOrderNum : $("#mergeOrderNum").val(),
							orderNum : $("#orderNum").val()
						},
						dataType : 'json',
						success : function(data) {
							if (!data.success) {
								alert("您所要合并订单不符合合并规则，请重新输入要合并的订单！（产品大类必须为空调，客户、目的港、出运期必须相同）");
								return;
							} else {
								checkOrderInMerge();
							}
						}
					});
		} else {
			$.ajax({
				url : 'orderMergeAction!checkOneOrder.action',
				data : {
					orderNum : $("#orderNum").val()
				},
				dataType : 'json',
				success : function(data) {
					if (!data.success) {
						$.messager.alert('提示',
								"您所要合并订单不符合合并规则，请重新输入要合并的订单！（产品大类必须为空调）",
								'info');
						return;
					} else {
						checkOrderInMerge();
					}
				}
			});
		}

	}
	function checkOrderInMerge() {
		$.ajax({
			url : 'orderMergeAction!checkOrderInMerge.action',
			data : {
				mergeOrderNum : $("#mergeOrderNum").val(),
				orderNum : $("#orderNum").val()
			},
			dataType : 'json',
			success : function(data) {
				if (data.success) {
				 	alert("该订单已经进行合并，请重新选择!");
					return;
				} else {
					datagrid.datagrid('load', sy.serializeObject(searchForm));
				}
			}
		});
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}

	function del() {
		$.messager.confirm('请确认', '您将删除当前所合并的所有数据？', function(r) {
			if (r) {
				mergedatagrid.datagrid('loadData', {
					"rows" : []
				});
				datagrid.datagrid('reload');
			}
		});
	}
	function edit() {
		var rows = datagrid.datagrid('getChecked');
		if (rows.length > 0) {
			if (editRow != undefined) {
				datagrid.datagrid('endEdit', editRow);
			}
			for ( var i = 0; i < rows.length; i++) {
				editRow = datagrid.datagrid('getRowIndex', rows[i]);
				datagrid.datagrid('beginEdit', editRow);
			}
			datagrid.datagrid('unselectAll');
		} else {
			$.messager.show({
				msg : '请选择一项进行修改！',
				title : '错误'
			});
		}
	}
	function mergeEdit() {
		var rows = mergedatagrid.datagrid('getChecked');
		if (rows.length == 1) {
			if (editRow != undefined) {
				mergedatagrid.datagrid('endEdit', editRow);
			}

			editRow = mergedatagrid.datagrid('getRowIndex', rows[0]);
			mergedatagrid.datagrid('beginEdit', editRow);
			mergedatagrid.datagrid('unselectAll');
		} else {
			$.messager.show({
				msg : '请选择一项进行修改！',
				title : '错误'
			});
		}
	}
	function setMergeNum() {
		//获取选中的行信息
		var rowsCheckeds = datagrid.datagrid('getChecked');
		for ( var i = 0; i < rowsCheckeds.length; i++) {
			var editRowOne = datagrid.datagrid('getRowIndex', rowsCheckeds[i]);
			datagrid.datagrid('endEdit', editRowOne);
		}
		if (rowsCheckeds.length == 0) {
			alert("请选择需要合并的信息！");
			return;
		}
		for ( var i = 0; i < rowsCheckeds.length; i++) {
			if (rowsCheckeds[i].mergeNum == null
					|| rowsCheckeds[i].mergeNum == ""
					|| rowsCheckeds[i].mergeNum == 0) {
				alert("请正确填写合并系数为大于0的正整数！");
				return;
			}
		}
		prepareOrderAddForm.form("clear");
		$('div.validatebox-tip').remove();
		prepareOrderAddDialog.dialog('open');
	}
	//合并
	function mergeOrderItem() {
		//获取选中的行信息
		var rowsCheckeds = datagrid.datagrid('getChecked');
		for ( var i = 0; i < rowsCheckeds.length; i++) {
			if (rowsCheckeds[i].quantity < $("#quantity").val()
					* rowsCheckeds[i].mergeNum) {
				alert("所选物料数量不满足合并套数，请重新选择物料货填写合并数量！");
				return;
			}
		}
		//删除最后一行合计	
		var mergeRows = mergedatagrid.datagrid('getRows');
		mergedatagrid.datagrid('deleteRow', mergeRows.length - 1);
		if (rowsCheckeds.length == 1) {
			//复制单个订单明细，修改源订单数量
			copyOrderItemOnlyOne(rowsCheckeds);
		} else {
			//按合并系数合并多个订单明细，修改原明细数量
			copyOrderItems(rowsCheckeds);
		}
		//修改合计
		var datagridRows = datagrid.datagrid('getRows');
		var amount = 0;//总额	
		var custAmount = 0;//报关总额	
		for ( var i = 0; i < datagridRows.length - 1; i++) {
			amount += Number(datagridRows[i].amount);
			custAmount += Number(datagridRows[i].custAmount);
		}
		datagrid.datagrid('updateRow', {
			index : datagridRows.length - 1,
			row : {
				amount : amount,
				custAmount : custAmount
			}
		});
		computeMergeSum();
		prepareOrderAddDialog.dialog('close');
	}
	//复制单个订单明细
	function copyOrderItemOnlyOne(rowsCheckeds) {
		//获取套数
		var quantity = $("#quantity").val();
		var haierModel = rowsCheckeds[0].haierModel; //海尔型号
		var customerModel = rowsCheckeds[0].customerModel;//客户型号
		var materialCode = rowsCheckeds[0].materialCode;//物料号
		var quantity = quantity * rowsCheckeds[0].mergeNum;//数量	
		var piece = rowsCheckeds[0].piece * quantity;//件数	
		var price = rowsCheckeds[0].price;//单价	
		var amount = rowsCheckeds[0].price * quantity;//总额	
		var custPrice = rowsCheckeds[0].custPrice;//报关单价	
		var custAmount = rowsCheckeds[0].custPrice * quantity;//报关总额	
		var netWeight = rowsCheckeds[0].netWeight * quantity;//净重	
		var grossWeight = rowsCheckeds[0].grossWeight * quantity;//毛重	
		var value = rowsCheckeds[0].value * quantity;//体积	
		var mergeRole = rowsCheckeds[0].orderNum + '/'
				+ rowsCheckeds[0].mergeNum;//合并规则
		var orderNumA = rowsCheckeds[0].orderNum;
		//是否是外机
		var mergeMaterial='';
		var prodType='';
		if(rowsCheckeds[0].activeFlag=='2'){
			mergeMaterial=rowsCheckeds[0].materialCode+'-T';
			prodType= rowsCheckeds[0].prodType;
		}
		var activeFlag=mergeMaterial
		//原订单index
		var rowindex = datagrid.datagrid('getRowIndex', rowsCheckeds[0]);
		var mergerow = 0;
		if ($("#orderLinecode").val() == 0) {
			mergerow = 10;
			$("#orderLinecode").val("10");
		} else {
			var orderLinecode = $("#orderLinecode").val();
			orderLinecode = Number(orderLinecode) + 10;
			mergerow = orderLinecode;
			$("#orderLinecode").val(orderLinecode);
		}
		//减少原订单数量
		var datagridQuantity = parseInt(rowsCheckeds[0].quantity)
				- parseInt(quantity);
		datagrid.datagrid('updateRow', {
			index : rowindex,
			row : {
				quantity : datagridQuantity,
				amount : parseInt(datagridQuantity)
						* parseInt(rowsCheckeds[0].price),
				custAmount : parseInt(datagridQuantity)
						* parseInt(rowsCheckeds[0].custPrice)
			}
		});
		$("#mergedatagrid").datagrid('appendRow', {
			'orderNum' : orderNumA,
			'orderLinecode' : mergerow,
			'haierModel' : haierModel,
			'customerModel' : customerModel,
			'materialCode' : materialCode,
			'quantity' : quantity,
			'unit' : 'PC',
			'piece' : quantity,
			'price' : price,
			'amount' : amount,
			'custPrice' : custPrice,
			'custAmount' : custAmount,
			'netWeight' : netWeight,
			'grossWeight' : grossWeight,
			'value' : value,
			'mergeRole' : mergeRole,
			'mergeMaterial':mergeMaterial,
			'prodType':prodType
		});
		//合计
	}
	//按合并系数合并多个订单明细
	function copyOrderItems(rowsCheckeds) {
		var haierModel = ""; //海尔型号
		var customerModel = "";//客户型号
		var materialCode = "";//物料号
		var quantity = 0;//数量	
		var piece = 0;//件数	
		var price = 0;//单价	
		var amount = 0;//总额	
		var custPrice = 0;//报关单价	
		var custAmount = 0;//报关总额	
		var netWeight = 0;//净重	
		var grossWeight = 0;//毛重	
		var value = 0;//体积	
		var mergeRole = "";//合并规则
		var orderNumA = rowsCheckeds[0].orderNum;
		var orderNumB = "";
		quantity = $("#quantity").val();
		for ( var i = 0; i < rowsCheckeds.length; i++) {
			//原订单index
			var rowindex = datagrid.datagrid('getRowIndex', rowsCheckeds[i]);
			haierModel += rowsCheckeds[i].haierModel + "/";
			customerModel += rowsCheckeds[i].customerModel + "/";
			materialCode += rowsCheckeds[i].materialCode + "/";
			piece += $("#quantity").val() * rowsCheckeds[i].mergeNum;
			price += rowsCheckeds[i].price;
			amount += $("#quantity").val() * rowsCheckeds[i].price
					* rowsCheckeds[i].mergeNum;
			custPrice += rowsCheckeds[i].custPrice * rowsCheckeds[i].mergeNum;
			custAmount += $("#quantity").val() * rowsCheckeds[i].custPrice
					* rowsCheckeds[i].mergeNum;
			netWeight += $("#quantity").val() * rowsCheckeds[i].netWeight
					* rowsCheckeds[i].mergeNum;
			grossWeight += $("#quantity").val() * rowsCheckeds[i].grossWeight
					* rowsCheckeds[i].mergeNum;
			value += $("#quantity").val() * rowsCheckeds[i].value
					* rowsCheckeds[i].mergeNum;
			mergeRole += $("#orderNum").val() + "/" + rowsCheckeds[i].mergeNum
					+ "+";
			//是否是外机
			var mergeMaterial='';
			var prodType='';
			if(rowsCheckeds[i].activeFlag=='2'){
				mergeMaterial=rowsCheckeds[i].materialCode+'-T';
				prodType= rowsCheckeds[i].prodType;
			}
			//验证是否来至同一个订单
			if (orderNumA != rowsCheckeds[i].orderNum
					&& orderNumB != rowsCheckeds[i].orderNum) {
				orderNumB = rowsCheckeds[i].orderNum
			}
			//减少原订单数量
			var datagridQuantity = parseInt(rowsCheckeds[i].quantity)
					- parseInt(quantity) * rowsCheckeds[i].mergeNum;
			datagrid.datagrid('updateRow', {
				index : rowindex,
				row : {
					quantity : datagridQuantity,
					amount : parseInt(datagridQuantity)
							* parseInt(rowsCheckeds[i].price),
					custAmount : parseInt(datagridQuantity)
							* parseInt(rowsCheckeds[i].custPrice)
				}
			});
		}
		var mergerow = "";
		if ($("#orderLinecode").val() == 0) {
			mergerow = 10;
			$("#orderLinecode").val("10");
		} else {
			var orderLinecode = $("#orderLinecode").val();
			orderLinecode = Number(orderLinecode) + 10;
			mergerow = orderLinecode;
			$("#orderLinecode").val(orderLinecode);
		}
		$("#mergedatagrid").datagrid('appendRow', {
			'orderNum' : orderNumA,
			'mergeOrderNum' : orderNumB,
			'orderLinecode' : mergerow,
			'haierModel' : haierModel,
			'customerModel' : customerModel,
			'materialCode' : materialCode,
			'quantity' : quantity,
			'unit' : 'SET',
			'piece' : piece,
			'price' : price,
			'amount' : amount,
			'custPrice' : custPrice,
			'custAmount' : custAmount,
			'netWeight' : netWeight,
			'grossWeight' : grossWeight,
			'value' : value,
			'mergeRole' : mergeRole,
			'mergeMaterial':mergeMaterial,
			'prodType':prodType
		});
	}
	//合计
	function computeSum() {
		var sumAmount = 0;//总额	
		var sumCustAmount = 0;//报关总额	
		var sumNetWeight = 0;//净重	
		var sumGrossWeight = 0;//毛重	
		var sumValue = 0;//体积	
		var datagridRows = datagrid.datagrid('getRows');
		for ( var i = 0; i < datagridRows.length; i++) {
			sumAmount += datagridRows[i].amount;
			sumCustAmount += datagridRows[i].custAmount;
			sumNetWeight += datagridRows[i].netWeight;
			sumGrossWeight += datagridRows[i].grossWeight;
			sumValue += datagridRows[i].value;
		}
		datagrid.datagrid('appendRow', {
			'orderNum' : '合计',
			'amount' : sumAmount,
			'custAmount' : sumCustAmount,
			'netWeight' : sumNetWeight,
			'grossWeight' : sumGrossWeight,
			'value' : sumValue
		});
	}
	//合计合并后的数据
	function computeMergeSum() {
		var sumAmount = 0;//总额	
		var sumCustAmount = 0;//报关总额	
		var sumNetWeight = 0;//净重	
		var sumGrossWeight = 0;//毛重	
		var sumValue = 0;//体积
		var mergedatagridRows = mergedatagrid.datagrid('getRows');
		for ( var i = 0; i < mergedatagridRows.length; i++) {
			sumAmount += mergedatagridRows[i].amount;
			sumCustAmount += mergedatagridRows[i].custAmount;
			sumNetWeight += mergedatagridRows[i].netWeight;
			sumGrossWeight += mergedatagridRows[i].grossWeight;
			sumValue += mergedatagridRows[i].value;
		}
		mergedatagrid.datagrid('appendRow', {
			'orderNum' : '合计',
			'amount' : sumAmount,
			'custAmount' : sumCustAmount,
			'netWeight' : sumNetWeight,
			'grossWeight' : sumGrossWeight,
			'value' : sumValue
		});
	}
	//保存合并的订单
	function saveMergeOrder() {
		var itemrows = mergedatagrid.datagrid('getRows');
		if (itemrows.length < 2) {
			alert("没有需要保存的合并数据，请先合并订单再保存！");
			return;
		}
		var datagridrows = datagrid.datagrid('getRows');
		if (datagridrows[datagridrows.length - 1].amount != 0
				|| datagridrows[datagridrows.length - 1].custAmount != 0) {
			alert("订单必需全部合并才能保存，请合并没有处理的物料！");
			return;
		}
		var itemMayList = '';
		if (mergedatagrid) {
			itemMayList = JSON.stringify(itemrows);
		}
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
			});
		$.ajax({
			url : 'orderMergeAction!saveall.action',
			data : {
				itemMayList : itemMayList
			},
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('提示', data.msg, 'info');
					mergedatagrid.datagrid('loadData', {
						"rows" : []
					});
					datagrid.datagrid('loadData', {
						"rows" : []
					});
				} else {
					$.messager.alert('警告', data.msg, 'error');
				}
			}
		});
		$.messager.progress('close');
	}
	function _searchHistory(){
		parent.window.HROS.window
				.createTemp({
					title : "已合并订单",
					url : "${dynamicURL}/orderMerge/orderMergeAction!searchHistory.action",
					width : 1100,
					height : 600,
					isresize : true,
					isflash : false
				});
	}
</script>
</head>
<body class="easyui-layout">
	<input type="hidden" value="0" id="orderLinecode">
	<div class="zoc" region="north" border="false" collapsible="true"
		collapsed="false" style="height: 100px;">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>合并报关</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">订单编号：</div>
						<div class="righttext">
							<input id="orderNum" name="orderNum" type="text"
								style="width: 145px" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft100">被合并订单号：</div>
						<div class="righttext">
							<input id="mergeOrderNum" name="mergeOrderNum" type="text"
								style="width: 145px" />
						</div>
					</div>
					<div class="item33">
						<div class="oprationbutt">
							<input type="button" value="查  询" onclick="_search();" />
							<input type="button" value="已合并订单" onclick="_searchHistory();" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	<div region="south" style="height: 230px;" border="false"
		title="空调内外机合并列表" split="true">
		<table id="mergedatagrid"></table>
	</div>
	<div id="prepareOrderAddDialog"
		style="display: none; width: 350px; height: 160px;" align="center">
		<form id="prepareOrderAddForm" method="post">
			<table class="tableForm" style="padding-top: 30px">
				<tr>
					<th>请填写合并的套数：</th>
					<td><input name="prodQuantity" type="text" id="quantity"
						class="easyui-validatebox"
						onblur="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"
						data- options="required:true" missingMessage="请填写合并的套数" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>