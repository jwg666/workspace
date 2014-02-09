<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出运通知单</title>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
	var adviceForm;
	var lastIndex;
	var datagrid_toolbar;
	var adviceDialog;
	var adviceAddForm;
	var orderInformation;
	$(function() {
		adviceAddForm=$("#adviceAddForm").form();
		datagrid_toolbar = $('#datagrid_toolbar').datagrid({
			border : false,
			pagination : false,
			toolbar : [ {
				text : '保存',
				iconCls : 'icon-search',
				handler : function() {
					saveInfo();
				}
			}, '-', {
				text : '打印/导出',
				iconCls : 'icon-edit',
				handler : function() {
					appletPrint();
				}
			}, '-', {
				text : '退回',
				iconCls : 'icon-edit',
				handler : function() {
					rollBack();
				}
			}, '-' ]
		});
		adviceForm = $("#adviceForm").form();
		//orderInformation
		orderInformation=$("#orderInformation").datagrid({
			url : 'shippingAdviceInfoAction!getOrderList.do?invoiceNum=' + '${invoiceNum}',
			title : 'Order Information',
			rownumbers : true,
			/* pagination : true,
			pagePosition : 'bottom', */
			/* pageSize : 10,
			pageList : [ 10, 20, 30, 40 ], */
			//fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'rowId',
			singleSelect : true,
			height : 200,
			columns : [ [ {
				field : 'rowId',
				title : '唯一标识',
				align : 'center',
				sortable : true,
				hidden : true,
				formatter : function(value, row, index) {
					return row.rowId;
				}
			}, {
				field : 'descOfGoods',
				title : 'Description of goods',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (value == 'null') {
						return '';
					}
					return row.descOfGoods;
				},
				editor : {
					type : 'text'
				}
			}, {
				field : 'orderQty',
				title : 'Order Qty',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderQty + " " + row.qtyUnit;
				},
				editor : {
					type : 'numberbox'
				}
			}, {
				field : 'packageQty',
				title : 'Package Qty',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.packageQty + " " + row.packageQtyUnit;
				},
				editor : {
					type : 'numberbox'
				}
			}, {
				field : 'infoNw',
				title : 'N/W(Kgs)',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.infoNw;
				},
				editor : {
					type : 'numberbox',
					options : {
						precision : 2
					}
				}
			}, {
				field : 'infoGw',
				title : 'G/W(Kgs)',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.infoGw;
				},
				editor : {
					type : 'numberbox',
					options : {
						precision : 2
					}
				}
			} ] ],
			toolbar : [ {
				text : '新增',
				iconCls : 'icon-add',
				handler : function() {
					addRow();
				}
			}, {
				text : '删除',
				iconCls : 'icon-undo',
				handler : function(index) {
					deleteRow();
				}
			}, {
				text : '还原',
				iconCls : 'icon-edit',
				handler : function() {
					rollBackDatagrid();
				}
			} ],
			onDblClickRow : function(rowIndex, rowData) {
				if (lastIndex != rowIndex) {
					$('#orderInformation').datagrid('endEdit', lastIndex);
					$('#orderInformation').datagrid('beginEdit', rowIndex);
				}
				lastIndex = rowIndex;
			}
		});

		$("#custCodeId").combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action?customerId=' + '${custCode}',
			textField : 'name',
			idField : 'customerId',
			panelWidth : 600,
			panelHeight : 220,
			width : 200,
			toolbar : '#sold_to_panel',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			editable : false,
			border : false,
			columns : [ [ {
				field : 'customerId',
				title : '客户编号',
				width : 20
			}, {
				field : 'name',
				title : '客户名称',
				width : 20
			} ] ]
		});

		//加载目的港信息
		$('#portOfDeschargeId').combogrid({
			url : '${dynamicURL}/basic/portAction!datagrid.action?portCode=' + '${portOfDescharge}',
			idField : 'portCode',
			textField : 'englishName',
			panelWidth : 500,
			panelHeight : 235,
			width : 150,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_PORTEND',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'portCode',
				title : '目的港编码',
				width : 200
			}, {
				field : 'englishName',
				title : '目的港名称',
				width : 200
			} ] ]
		});
		//加载下拉框的数据(始发港、目的港、中标类型、运输公司)
		$('#portOfDeoartueId').combobox({//始发港
			url : '../basic/sysLovAction!comboxStartPort.do',
			valueField : 'itemCode',
			textField : 'itemNameEn',
			multiple : false,
			editable : true
		});
		adviceDialog = $('#adviceDialog').dialog({
			title : '添加信息',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '增加',
				handler : function() {
					if(adviceAddForm.form('validate')){
						var adviceAddForm0=sy.serializeObject($("#adviceAddForm"));
						adviceAddForm0.invoiceNum='${invoiceNum}';
						orderInformation.datagrid('appendRow',adviceAddForm0);
						adviceDialog.dialog('close');
					}
				}
			} ]
		});
	});
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		var _CCNTEMPID = $('#' + inputId + 'ID').val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP + '&customerId=' + _CCNTEMPID
		});
		$("#custCodeId").combogrid('setValue', '');
	}

	//模糊查询目的港下拉列表
	function _PORTMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/portAction!datagridEnAndCn.do?portName=' + _CCNTEMP + '&portCode=' + _CCNCODE
		});
		$("#portOfDeoartueId").combogrid('setValue', '');
	}
	//重置查询目的港信息输入框
	function _PORTMYCLEAN(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/portAction!datagridEnAndCn.do'
		});
	}
	//保存
	function saveInfo() {
		$("#orderInformation").datagrid("acceptChanges");

		$.ajax({
			url : 'shippingAdviceAction!add.action',
			data : adviceForm.serializeArray(),
			type : 'post',
			dataType : 'json',
			beforeSend : function() {
				$.messager.progress('close');
			},
			success : function(response) {
				$.messager.progress('close');
				if (response.success) {
					$.messager.progress({
						title : '正在保存订单信息.....'
					});
					var rows = $("#orderInformation").datagrid('getRows');
					var jsonString = JSON.stringify(rows)
					$.ajax({
						url : 'shippingAdviceInfoAction!saveAllOrderInfo.action',
						data : {
							"jsonString" : jsonString
						},
						type : 'post',
						dataType : 'json',
						success : function(response) {
							$.messager.progress('close');
							$.messager.alert('提示', '保存成功', 'info');
						}
					});
				} else {
					$.messager.alert('提示', response.msg, 'error');
				}
			}
		});
	}
	function rollBackDatagrid() {
		$("#orderInformation").datagrid("rejectChanges");
		lastIndex = null;
	}
	function addRow() {
		adviceDialog.dialog('open');
		/* $("#orderInformation").datagrid("appendRow", {
			rowId : '',
			descOfGoods : '',
			orderQty : 0.0,
			packageQty : 0.0,
			infoNw : 0.0,
			infoGw : 0.0,
			invoiceNum : '${invoiceNum}'
		}); */
	}
	function temperaySave() {
		$("#orderInformation").datagrid("acceptChanges");
	}
	function deleteRow() {
		var rows = $("#orderInformation").datagrid("getSelected");
		if (rows == null) {
		} else {
			var rowIndex = $("#orderInformation").datagrid("getRowIndex", rows)
			$("#orderInformation").datagrid("deleteRow", rowIndex);
		}
	}
	function appletPrint() {
		$("#orderInformation").datagrid("acceptChanges");
		adviceForm.form('submit', {
			url : 'shippingAdviceAction!add.action',
			onSubmit : function() {
				$.messager.progress({
					title : '正在保存通知单数据.....'
				});
			},
			success : function() {
				$.messager.progress('close');
				$.messager.progress({
					title : '正在保存订单信息.....'
				});
				var rows = $("#orderInformation").datagrid('getRows');
				var jsonString = JSON.stringify(rows)
				$.ajax({
					url : 'shippingAdviceInfoAction!saveAllOrderInfo.action',
					data : {
						"jsonString" : jsonString
					},
					type : 'post',
					dataType : 'json',
					success : function(response) {
						$.messager.progress('close');
						/* window.open("http://10.135.12.138:7011/report/Report-Guage.do?reportId=5fa81cbf-9f23-4db2-8ce6-65f0366d767a&negoInvoiceNum="
								+ '${invoiceNum}'); */
						window.open("http://hrois.haier.net/report/Report-Guage.do?reportId=5fa81cbf-9f23-4db2-8ce6-65f0366d767a&negoInvoiceNum="
								+ '${invoiceNum}');
					}
				});
			}
		})
	}
	function rollBack() {
		//退回所有的出运通知单数据（删除数据）
		$.ajax({
			url : 'shippingAdviceAction!rollBackData.action',
			type : 'post',
			dataType : 'json',
			data : {
				'invoiceNum' : '${invoiceNum}'
			},
			success : function(data) {
				adviceForm.form('load', 'shippingAdviceAction!shippingAdviceByInvoice.action?invoiceNum=${invoiceNum}');
				$("#orderInformation").datagrid('reload');
				$.messager.progress('close');
			},
			beforeSend : function() {
				$.messager.progress();
			}
		});
	}
</script>
</head>
<body class="zoc">
	<div collapsed="false" style="height: 85px; overflow: auto;"
		align="left">
		<form id="searchForm">
			<div class="partnavi_zoc">
				<span>出运通知单：</span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft80">议付发票号：</div>
					<div class="righttext">
						<input id="negoInvoiceNum" value="${invoiceNum}"
							readonly="readonly" type="text" />
					</div>
				</div>
			</div>
		</form>
		<div class="datagrid-toolbar">
			<table id="datagrid_toolbar" style="height: 28px;"></table>
		</div>
	</div>
	<div style="font-size: 10pt;" align="center">
		<div class="part_zoc zoc" style="width: 60%">
			<form id="adviceForm" method="post">
				<table style="border-collapse: collapse; width: 90%;" align="center"
					cellspacing="10px">
					<tr>
						<!-- 表头 -->
						<td>
							<table style="width: 100%">
								<tr>
									<td style="font-family: Verdana;"><h1>Haier</h1></td>
									<td style="float: right;"><div style="text-align: left">
											${ title}</div></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<!-- 客户信息 -->
						<td>
							<table style="width: 100%;" cellspacing="10px">
								<tr>
									<td>To:</td>
									<td><input id="custCodeId" style="width: 95%"
										value="${custCode }" name="custCode" /></td>
									<td>From:</td>
									<td>DOCUMENTS SERVICE DEPT</td>
								</tr>
								<tr>
									<td>Attn:</td>
									<td>TO WHOM IT MAY CONCERN</td>
									<td>Date:</td>
									<!-- 系统要求出运期 -->
									<td><input style="width: 95%" class="easyui-datebox"
										name="shippingDate"
										value="<s:date  name="shippingDate" format="yyyy-MM-dd"/>" />
									</td>
								</tr>
								<tr>
									<td>Fax:</td>
									<td><input style="width: 95%" name="custFax"
										value="${custFax }" /></td>
									<td>Page(s):</td>
									<td><input style="width: 95%" name="custPage"
										value="${ custPage}" /></td>
								</tr>
								<tr>
									<td>CC:</td>
									<td><input style="width: 95%" name="custCc"
										value="${custCc }" /></td>
									<td>Ref.No.:</td>
									<td><input style="width: 95%" name="custRefNo"
										value="${custRefNo }" /></td>
								</tr>
								<tr>
									<td>Re:</td>
									<td colspan="3">SHIPPING ADVICE</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<!-- SHIPPING ADVICE -->
						<td align="center"><h3>SHIPPING ADVICE</h3></td>
					</tr>
					<tr>
						<!-- DEAR SIR,ATTACHED PLE………… -->
						<td><table style="width: 100%" cellspacing="10px">
								<tr>
									<td>Dear Sir: Attched please find the SHIPPING ADVICE for
										your P/O:</td>
								</tr>
								<tr>
									<td><input value="${ custOrderPos}" style="width: 100%"
										name="custOrderPos" /></td>
								</tr>
							</table></td>
					</tr>
					<tr>
						<!-- DETAIED INFORMATION AS BELOW(TABLE) -->
						<td>
							<h4>Detailed Information as below</h4>
							<table style="width: 100%" cellspacing="10px">
								<tr>
									<td>Haier internal S/O No.:</td>
									<td colspan="3"><input style="width: 95%" name="orderNums"
										value="${ orderNums}" /></td>
								</tr>
								<tr>
									<td>B/L No.:</td>
									<td colspan="3"><input value="${blNos }" name="blNos"
										style="width: 95%" /></td>
								</tr>
								<tr>
									<td>On board Date:</td>
									<td><input class="easyui-datebox" style="width: 95%"
										name="onBoardDate"
										value="<s:date  name="onBoardDate" format="yyyy-MM-dd"/>" /></td>
									<td>ETA:</td>
									<td><input class="easyui-datebox" style="width: 95%"
										name="adviceEta"
										value="<s:date  name="adviceEta" format="yyyy-MM-dd"/>" /></td>
								</tr>
								<tr>
									<td>Ocean Vessel:</td>
									<td><input style="width: 95%" name="oceanVessel"
										id="oceanVesselId" value="${ oceanVessel }" /></td>
									<td>Voy.No.:</td>
									<td><input style="width: 95%" name="voyNo"
										value="${ voyNo }" /></td>
								</tr>
								<tr>
									<td>Port of Deoarture:</td>
									<td><input style="width: 95%" name="portOfDeoartue"
										id="portOfDeoartueId" value="${ portOfDeoartue }" /></td>
									<td>Port of Discharge:</td>
									<td><input style="width: 95%" name="portOfDescharge"
										id="portOfDeschargeId" value="${ portOfDescharge }" /></td>
								</tr>
								<tr>
									<td>Invoice No.:</td>
									<td><input style="width: 95%" value="${ invoiceNo }"
										id="invoiceNoId" name="invoiceNo" /></td>
									<td>Value:</td>
									<td><input style="width: 95%" id="shippingValueId"
										type="hidden" name="shippingValue" value="${shippingValue}" />
										<input type="hidden" name="currency" value="${currency }" />
										<input style="width: 95%" name="currencyAndShippingValue"
										value="${currency }${shippingValue}" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style="overflow: visible;">
							<!-- ORDER INFORMATION -->
							<table id="orderInformation" style="overflow: visible;"></table>
						</td>
					</tr>
					<tr>
						<td height="50px"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>

	<div id="sold_to_panel">
		<div class="oneline">
			<div class="item33">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short30" id="_CNNINPUTID" type="text" />
				</div>
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short30" id="_CNNINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('_CNNINPUT','custCodeId')" />
				</div>
			</div>
		</div>
	</div>

	<!--目的港下拉选信息  -->
	<div id="_PORTEND">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft100">目的港编号：</div>
				<div class="righttext">
					<input class="short50" id="_PORTCODEINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">目的港名称：</div>
				<div class="righttext">
					<input class="short50" id="_PORTINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_PORTMY('_PORTCODEINPUT','_PORTINPUT','portOfDeschargeId')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_PORTMYCLEAN('_PORTCODEINPUT','_PORTINPUT','portOfDeschargeId')" />
				</div>
			</div>
		</div>
	</div>
	<div id="adviceDialog" style="width: 700px; height: 230px;">
		<form id="adviceAddForm" method="post">
			<div class="part_zoc">
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">Description of goods：</div>
						<div class="righttext">
							<input name="descOfGoods" id="descOfGoodsId" type="text"
								class="easyui-validatebox" data-options="required:true"
								style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">Order Qty</div>
						<div class="righttext">
							<input name="orderQty" type="text" id="orderQtyId"
								data-options="required:true" class="easyui-numberbox"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">Unit：</div>
						<div class="righttext">
							<input name="qtyUnit" type="text" id="qtyUnitId"
								data-options="required:true" class="easyui-validatebox"
								style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">Package Qty：</div>
						<div class="righttext">
							<input name="packageQty" class="easyui-numberbox"
								style="width: 155px;" data-options="required:true"
								id="packageQtyId"></input>
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">Package Unit：</div>
						<div class="righttext">
							<input name="packageQtyUnit" type="text" id="packageQtyUnitId"
								data-options="required:true" class="easyui-validatebox"
								style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">N/W(Kgs)</div>
						<div class="righttext">
							<input id="infoNwId" name="infoNw" type="text"
								class="easyui-numberbox" data-options="required:true,precision:2"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">G/W(Kgs)</div>
						<div class="righttext">
							<input name="infoGw" type="text" id="infoGwId"
								class=" easyui-numberbox"
								data-options="required:true,precision:2" style="width: 155px;" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>