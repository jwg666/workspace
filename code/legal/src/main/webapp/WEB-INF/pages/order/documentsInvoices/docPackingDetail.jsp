<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>

<script type="text/javascript" charset="utf-8">
	var searchForm;
	var searchPackForm;
	var datagrid;
	var datagrid_toolbar;
	var editIndex = undefined;
	var editRow;
	var packingListAddDialog;
	var packingListAddForm;
	var printFlag = true;
	var showLoadExcelInfoForm;
	var showLoadExcelDialog;
	var saveFlag;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		searchPackForm = $('#searchPackForm');
		datagrid_toolbar = $('#datagrid_toolbar').datagrid({
			border : false,
			pagination : false,
			toolbar : [{
				text : '保存',
				iconCls : 'icon-search',
				handler : function() {
					_savePackingList();
				}
			},'-',  {
				text : '打印/导出',
				iconCls : 'icon-edit',
				handler : function() {
					appletPrint();
				}
			}, '-' ]
		});
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/documentsInvoices/docPackingDetailAction!findPackingDetailAll.do?negoInvoiceNum='
				+ '${docPackingDetailQuery.negoInvoiceNum}',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 30,
			pageList : [ 10, 20, 30, 50, 100 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			showFooter : true,
			onDblClickRow : function(rowIndex, rowData) {
				onClickRow(rowIndex);
			},
			columns : [ [ {
				field : 'orderNum',
				title : 'orderNum',
				align : 'center',
				sortable : true,
				hidden : true,
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			}, {
				field : 'printFalg',
				title : 'printFalg',
				align : 'center',
				sortable : true,
				hidden : true,
				formatter : function(value, row, index) {
					return row.printFalg;
				},
			}, {
				field : 'containers',
				title : 'Container No',
				align : 'center',
				sortable : true,
				width : 70,
				editor : {
					type : 'text'
				},
				formatter : function(value, row, index) {
					return row.containers;
				},
			},{field : 'descGoods',title:'GOODS DESC',align : 'center',editor:'text',width:70,
				editor : {
					type : 'text'
				},
				formatter : function(value, row, index) {
					return row.descGoods;
				}
			},{
				field : 'customerModel',
				title : 'Description of Goods',
				align : 'center',
				width : 70,
				sortable : true,
				editor : {
					type : 'text'
				},
				formatter : function(value, row, index) {
						return row.customerModel;
				},
			}, {
				field : 'quantity',
				title : 'Quantity',
				align : 'center',
				sortable : true,
				
				width : 70,
				editor : {
					type : 'numberbox'
				},
				formatter : function(value, row, index) {
					if (row.unit == null) {
						return row.quantity;
					} else {
						return row.quantity + ' ' + row.unit;
					}
				},
			}, {
				field : 'netWeight',
				title : 'Net weight',
				align : 'center',
				sortable : true,
				
				editor : {
					type : 'numberbox',
					options : {
						precision : 2
					}
				},
				width : 70,
				formatter : function(value, row, index) {
					if (row.netWeight >= 0) {
						return Number(row.netWeight).toFixed(2) + ' KGS';
					} else {
						return '';
					}
				},
			}, {
				field : 'weight',
				title : 'Gross weight',
				align : 'center',
				sortable : true,
				
				editor : {
					type : 'numberbox',
					options : {
						precision : 2
					}
				},
				width : 70,
				formatter : function(value, row, index) {
					if (row.weight >= 0) {
						return Number(row.weight).toFixed(2) + ' KGS';
					} else {
						return '';
					}
				},
			}, {
				field : 'packages',
				title : 'Packages',
				align : 'center',
				sortable : true,
				editor : {
					type : 'numberbox',
				},
				width : 50,
				formatter : function(value, row, index) {
					if (row.packages >= 0) {
						return row.packages;
					} else {
						return '';
					}
				},
			}, {
				field : 'packagesUnit',
				title : 'Pack Unit',
				align : 'center',
				sortable : true,
				
				width : 40,
				editor : {
					type : 'text',
				},
				formatter : function(value, row, index) {
					return row.packagesUnit;
				},
			}, {
				field : 'unit',
				title : 'UNIT',
				align : 'center',
				sortable : true,
				
				width : 120,
				hidden : true,
				formatter : function(value, row, index) {
					return row.unit;
				},
			} ]],			
			toolbar : [ {
				text : '新增',
				iconCls : 'icon-add',
				handler : function() {
					add();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					deleteRow();//操作
				}
			}, '-', {
				text : '回退',
				iconCls : 'icon-redo',
				handler : function() {
					rollBack();//操作
				}
			}, '-'],
			onDblClickRow : function(rowIndex, rowData) {
				datagrid.datagrid('beginEdit', rowIndex);
				if (editRow != undefined) {
					datagrid.datagrid('endEdit', editRow);
				}
					editRow = rowIndex;
					datagrid.datagrid('unselectAll');
			},
			onAfterEdit : function(rowIndex, rowData, changes) {
					editRow = undefined;
					datagrid.datagrid('unselectAll');
					return;
			},
			loadFilter : function(data) {
				if (data.total > 0) {
					/* var marks='';
					for(var i=0;i<data.rows.length;i++){
						if(marks.indexOf(data.rows[i].marks)==-1){
							marks=marks+data.rows[i].marks+',';
						}
					} */
					searchPackForm.form('load', data.rows[0]);
					$("#showMark").val('N/M');
				} else {
					searchPackForm.find('.tr input').val('');
				}
				$("#invoiceNum").val('${docPackingDetailQuery.negoInvoiceNum}');
				return data;
			},
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
		packingListAddForm = $('#packingListAddForm').form({
			url : 'docPackingDetailAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					packingListAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		packingListAddDialog = $('#packingListAddDialog').show().dialog({
			title : '添加箱单发票',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					packingListAddForm.submit();
				}
			} ]
		});
		searchPackForm = $('#searchPackForm').form({
			url : '${dynamicURL}/documentsInvoices/docPackingDetailAction!saveDocumentsInvoices.do',
			success : function(data) {
				if(saveFlag=='T'){
					//window.open("http://10.135.12.138:7011/report/Report-Guage.do?reportId=10711366-08aa-4220-8736-206ddfe63d10&negoInvoiceNum="+$("#negoInvoiceNum").val());
					window.open("http://hrois.haier.net/report/Report-Guage.do?reportId=10711366-08aa-4220-8736-206ddfe63d10&negoInvoiceNum="+$("#negoInvoiceNum").val());
				}else{
					$.messager.show({
						title : '成功',
						msg : '保存成功！'
					});
				}
				saveFlag='F';
				datagrid.datagrid('reload');
			}
		});
	});
	//查询
	function _search() {
	}
	//新增
	function add() {
		//保存
		$.ajax({
					url : '${dynamicURL}/documentsInvoices/docPackingDetailAction!checkIsSave.do',
					async : false,
					data : {
						negoInvoiceNum : $("#negoInvoiceNum").val()
					},
					dataType : 'json',
					cache : false,
					success : function(response) {
						//如果已经保存就不再进行保存
						if(response.success){
							_savePackingList();
						}
					}
				});
		packingListAddForm.form("clear");
		$("#addNegoInvoiceNum").val($("#negoInvoiceNum").val());
		$("#addOrderShipDate").datebox('setValue',$("#orderShipDate").datebox("getValue"));
		$("#addOrderShipType").val($("#orderShipType").val());
		$("#addOrderPoCode").val($("#orderPoCode").val());
		$("#addInvoiceNum").val($("#invoiceNum").val());
		$('div.validatebox-tip').remove();
		packingListAddDialog.dialog('open');
	}
	//删除行记录
	function deleteRow() {
			var rows = datagrid.datagrid('getSelections');
			var packingListIds = "";
			if (rows.length > 0) {
				var rows = datagrid.datagrid('getSelections');
				for ( var i = 0; i < rows.length; i++) {
					var index = datagrid.datagrid('getRowIndex', rows[i]);//获取某行的行号
					datagrid.datagrid('deleteRow', index); //通过行号移除该行
				}
			}
	}
	//回滚行记录
	function rollBack() {
			var negoInvoiceNum = $("#negoInvoiceNum").val();
			$.messager
					.confirm(
							'请确认',
							'您要回退当前订单？',
							function(r) {
								if (r) {
									$
											.ajax({
												url : '${dynamicURL}/documentsInvoices/docPackingDetailAction!deleteByNegoInvoiceNum.do',
												data : {
													negoInvoiceNum : negoInvoiceNum
												},
												dataType : 'json',
												success : function(response) {
													$.messager.show({
														title : '提示',
														msg : '回退完成！'
													});
													datagrid.datagrid('load');
												}
											});
								}
							});
	}
	//保存发票
	function _savePackingList(){
		if (editRow != undefined) {
			datagrid.datagrid('endEdit', editRow);
		}
		var rows = datagrid.datagrid('getRows');
		if (rows.length > 0) {
			var jsonStr = JSON.stringify(rows)
			$("#jsonStr").val(jsonStr);
			$("#negoInvoice").val($("#negoInvoiceNum").val());
			searchPackForm.submit();
		}
	}
	//打印
	function appletPrint(){
		saveFlag='T';
		//保存
		$.ajax({
					url : '${dynamicURL}/documentsInvoices/docPackingDetailAction!checkIsSave.do',
					async : false,
					data : {
						negoInvoiceNum : $("#negoInvoiceNum").val()
					},
					dataType : 'json',
					cache : false,
					success : function(response) {
						//如果已经保存就不再进行保存
						if(response.success){
							_savePackingList();
						}
					}
				});
		//记录打印
		$.ajax({
					url : '${dynamicURL}/documentsInvoices/docPackingDetailAction!updatePrintFlag.do',
					async : false,
					data : {
						negoInvoiceNum : $("#negoInvoiceNum").val()
					},
					dataType : 'json',
					cache : false,
					success : function(response) {
						
					}
				});
		
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="order.custorder.packinglist">箱单</s:text></title>
</head>
<body class="easyui-layout zoc">
	<div region="north" border="false" class="zoc" collapsed="false"
		style="overflow: auto;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc">
				<span><s:text name="order.custorder.packinglist">箱单</s:text></span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft60">
						议付发票号:
					</div>
					<div class="righttext">
						<input type="text" id="negoInvoiceNum" value="${docPackingDetailQuery.negoInvoiceNum}" readonly="readonly"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft100" id="printFlag" style="color: red;"></div>
				</div>
			</div>
		</form>
		<div class="datagrid-toolbar">
			<table id="datagrid_toolbar" style="height: 28px;"></table>
		</div>
	</div>
	<div region="center" id="printBody" border="false"
		style="overflow: auto;" class="zoc" align="center">

		<div class="part_zoc zoc" style="width: 1200px;">
			<div class="partnavi_zoc" align="left">
				<span><s:text name="order.custorder.packinglist">箱单</s:text></span>
			</div>
			<form id="searchPackForm" style="height: 100%; width: 1200px;" method="post">
				<s:hidden name="docPackinglist" id="jsonStr"/>
				<s:hidden name="negoInvoiceNum" id="negoInvoice"/>
				<table width="100%" class="formtable" style="height: 100%;">
					<tr class="tr">
						<td colspan="4" class="t-head"><a href="#"><img
								src="${staticURL}/style/images/logo_login.png" /></a></td>
					</tr>
					<tr class="tr" style="height: 30px">
						<td colspan="4" class="t-head" align="center"
							style="vertical-align: top; text-align: center; font-family: arial, 微软雅黑; font-size: 40px; font-weight: bold;">&nbsp;PACKING
							&nbsp;&nbsp;LIST&nbsp;</td>
					</tr>
					<tr class="tr">
						<td class="t-title" colspan="4" style="text-align: left;">Shipping
							Marks:</td>

					</tr>
					<tr class="tr">
						<td rowspan="2" colspan="2" class="t-content" id='textareaFlag'
							style="width: 500px"><textarea name="marks" id="showMark" rows="2" cols="50"
								style="resize: none"></textarea></td>
						<th style="text-align: right;">NO:</th>
						<td><input type="text"  name="invoiceNum" id="invoiceNum" /></td>
					</tr>
					<tr class="tr">
						<th style="text-align: right;">DATE:</th>
						<td><input type="text"  class="easyui-datebox"
							name="orderShipDate" /></td>
					</tr>
					<tr class="tr">
						<td colspan="4">&nbsp;</td>
					</tr>
					<tr style="height: 278px;" id="datagridTr">
						<td colspan="4"
							style="border-bottom: 1px solid #A4B5C2; border-top: 1px solid #A4B5C2;">
							<table id="datagrid"></table>
						</td>
					</tr>
					<tr class="tr">
						<td colspan="4">&nbsp;</td>
					</tr>
					<tr class="tr">
						<th colspan="3" style="text-align: right;padding-right: 200px">SHIPPED ON:
						<input type="text" class="easyui-datebox"
							name="orderShipDate" id="orderShipDate" style="width: 180px;" /></th>
						<td colspan="1"></td>
					</tr>
					<tr class="tr">
						<th colspan="3" style="text-align: right;padding-right: 200px">SHIPPED BY:
						<input type="text" 
							name="orderShipType" id="orderShipType" style="width: 180px;" /></th>
						<td colspan="1"></td>
					</tr>
					<tr class="tr">
						<th colspan="3" style="text-align: right;padding-right: 200px">PO NO.:
						<input type="text" 
							name="orderPoCode" id="orderPoCode" style="width: 180px;" /></th>
						<td colspan="1"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div id="packingListAddDialog" style="display: none;width: 800px;height: 230px;overFlow-x: hidden;" align="center">
		<form id="packingListAddForm" method="post">
		<div class="part_zoc zoc">
						<div class="oneline">
							<div class="itemleft60">订单号:</div>
							<div class="righttext">
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">唛头:</div>
							<div class="righttext">
								<input name="marks" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唛头"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">箱号:</div>
							<div class="righttext">
								<input name="containers" type="text" class="easyui-validatebox" missingMessage="请填写箱号"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">客户型号:</div>
							<div class="righttext">
								<input name="customerModel" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写客户型号"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">数量:</div>
							<div class="righttext">
								<input name="quantity" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写数量"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">单位:</div>
							<div class="righttext">
								<input name="unit" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写数量"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
						<div class="itemleft60">净重:</div>
							<div class="righttext">
								<input name="netWeight" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写净重"  style="width: 155px;"/>						
						</div>
						<div class="itemleft60">毛重:</div>
							<div class="righttext">
								<input name="weight" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写净毛重"  style="width: 155px;"/>						
						</div>
						<div class="itemleft60">货描:</div>
							<div class="righttext">
								<input name="descGoods" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写货描"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
						<div class="itemleft60">件数:</div>
							<div class="righttext">
								<input name="packages" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写件数"  style="width: 155px;"/>						
						</div>
						<div class="itemleft60">件数单位:</div>
							<div class="righttext">
								<input name="packagesUnit"  type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写单位"  style="width: 155px;"/>						
							</div>
						<div class="itemleft60">议付发票:</div>
							<div class="righttext">
								<input name="negoInvoiceNum" id="addNegoInvoiceNum" type="text" class="easyui-validatebox"  readonly="readonly" style="width: 155px;"/>						
						</div>
						</div>
						<div style="display: none;">
								<input name="orderShipDate" class="easyui-datebox" type="text" id="addOrderShipDate"/>						
								<input name="orderShipType"  type="text" id="addOrderShipType"/>						
								<input name="orderPoCode" type="text" id="addOrderPoCode"/>			
								<input name="invoiceNum" type="text" id="addInvoiceNum"/>				
						</div>
						</div>
			</div>
		</form>
	</div>
</body>
</html>