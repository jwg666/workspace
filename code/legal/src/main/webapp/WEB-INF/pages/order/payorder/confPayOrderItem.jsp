<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var datagridItem;
	var showItemDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		showItemDialog = $('#showItemDialog').show().dialog({ 
		   title : '<s:text name="global.payOrderItem.detail">用款明细</s:text>',
		   modal : true,
		   closed : true,
		   maximizable : true,
		   resizable:true
		});
		datagrid = $('#datagrid')
				.datagrid(
						{
							url : '${dynamicURL}/payorder/confPayOrderItemAction!showDetailDatagrid.do?isUseMoneyPage=true',
							title : '<s:text name="global.payOrderItem.search">用款查询</s:text>',
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
							singleSelect : true,
							columns : [ [ {
								field : 'ck',
								checkbox : true,
								width : 10,
								formatter : function(value, row, index) {
									return row.actConfPayItemCode;
								}
							}, {
								field : 'customerId',
								title : '客户编号',
								align : 'center',
								sortable : true,
								width : 100,
								formatter : function(value, row, index) {
									return row.customerId;
								}
							},{
								field : 'customerName',
								title : '客户名称',
								align : 'center',
								sortable : true,
								width : 100,
								formatter : function(value, row, index) {
									return row.customerName;
								}
							}, {
								field : 'paymentMethodName',
								title : '付款方式',
								align : 'center',
								sortable : true,
								width : 100,
								formatter : function(value, row, index) {
									return row.paymentMethodName;
								}
							}, {
								field : 'payCode',
								title : '款项编号',
								align : 'center',
								sortable : true,
								width : 150,
								formatter : function(value, row, index) {
									return row.payCode;
								}
							}, {
								field : 'salOrg',
								title : '销售组织',
								align : 'center',
								sortable : true,
								width : 150,
								formatter : function(value, row, index) {
									return row.salOrg;
								}
							},{
								field : 'totalAmount',
								title : '总金额',
								align : 'center',
								sortable : true,
								width : 100,
								formatter : function(value, row, index) {
									return row.totalAmount;
								}
							}, {
								field : 'amount',
								title : '已使用金额',
								align : 'center',
								sortable : true,
								width : 100,
								formatter : function(value, row, index) {
									return row.amount;
								}
							}, {
								field : 'balance',
								title : '余额',
								align : 'center',
								sortable : true,
								width : 100,
								formatter : function(value, row, index) {
									return row.balance;
								}
							}, {
								field : 'currency',
								title : '币种',
								align : 'center',
								sortable : true,
								width : 50,
								formatter : function(value, row, index) {
									return row.currency;
								}
							} , {
								field : 'orderCurrency',
								title : '过付款金额',
								align : 'center',
								sortable : true,
								width : 250,
								formatter : function(value, row, index) {
									return row.orderCurrency;
								}
							} ] ],
							toolbar : [ {
								text : '显示明细',
								iconCls : 'icon-search',
								handler : function() {
									showItem();
								}
							}, '-' , {
								text : '导出',
								iconCls : 'icon-search',
								handler : function() {
									exportData();
								}
							}]

						});

		//用款明细列表
		datagridItem = $('#datagridItem')
				.datagrid(
						{
							title : '<s:text name="global.payOrderItem.detail">用款明细</s:text>',
							iconCls : 'icon-save',
							pagePosition : 'bottom',
							rownumbers : false,
							fit : true,
							fitColumns : true,
							nowrap : true,
							border : false,
							showFooter : true,
							loadMsg : '数据加载中......',
							columns : [ [ {
								field : 'paymentMethodName',
								title : '付款方式',
								align : 'center',
								sortable : true,
								width : 50,
								formatter : function(value, row, index) {
									return row.paymentMethodName;
								}
							}, {
								field : 'payCode',
								title : '款项编号',
								align : 'center',
								sortable : true,
								width : 50,
								formatter : function(value, row, index) {
									return row.payCode;
								}
							}, {
								field : 'totalAmount',
								title : '总金额',
								align : 'center',
								sortable : true,
								width : 50,
								formatter : function(value, row, index) {
									return row.totalAmount;
								}
							}, {
								field : 'orderNum',
								title : '订单号',
								align : 'center',
								sortable : true,
								width : 50,
								formatter : function(value, row, index) {
									return row.orderNum;
								}
							}, {
								field : 'amount',
								title : '已使用金额',
								align : 'center',
								sortable : true,
								width : 50,
								formatter : function(value, row, index) {
									return row.amount;
								}
							}, {
								field : 'balance',
								title : '余额',
								align : 'center',
								sortable : true,
								width : 50
							}, {
								field : 'orderAmonut',
								title : '过付款金额',
								align : 'center',
								sortable : true,
								width : 100
							}, {
								field : 'orderCurrency',
								title : '订单币种',
								align : 'center',
								sortable : true,
								width : 50
							}, {
								field : 'created',
								title : '付款日期',
								align : 'center',
								sortable : true,
								width : 50,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.created);
								}
							}, {
								field : 'sourceSystem',
								title : '系统来源',
								align : 'center',
								sortable : true,
								width : 50,
								formatter : function(value, row, index) {
									return row.sourceSystem;
								}
							} ] ],
							toolbar : [ {
								text : '导出明细',
								iconCls : 'icon-search',
								handler : function() {
									exportDetails();
								}
							}],
							rowStyler : function(index, row) {
								if (row.paymentMethodName == "小计：") {
									return 'background-color:#CC6600;color:#fff;font-weight:bold;';
								}
							}
						});

		//加载付款方式信息
		$('#paymentMethod')
				.combobox(
						{
							url : '${dynamicURL}/payorder/confPayOrderItemAction!selectPayMentMethod.action',
							valueField : 'itemCode',
							textField : 'itemNameCn'
						});
		//加载客户编号信息
		$('#customerId').combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
			textField : 'customerId',
			idField : 'customerId',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_CNNQUERY',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ {
				field : 'customerId',
				title : '客户编码',
				width : 20
			},
			{
				field : 'name',
				title : '客户名称',
				width : 20
			}
			] ]
		});
	});
	//模糊查询客户编码信息
	function _CCN(inputId, inputName, selectId) {
		var _CCNTEMP = $('#' + inputId).val();
		var _CCNNAMETEMP = $('#' + inputName).val();
		$('#' + selectId)
				.combogrid(
						{
							url : '${dynamicURL}/basic/customerAction!datagrid0.action?customerId='
									+ _CCNTEMP + "&name=" + _CCNNAMETEMP
						});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询客户信息输入框
	function _CCNCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/customerAction!datagrid0.action'
				});
	}
	//查询
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
		datagridItem.datagrid({
			data : []
		});
	}
	//重置
	function cleanSearch() {
		datagrid.datagrid('load', {});
		datagridItem.datagrid('load', {});
		datagrid.datagrid('clearSelections');
		datagrid.datagrid('clearChecked');
		searchForm.form('clear');
	}
	//选中一条或多条用款信息查询详细
	function showItem() {
		var rows = datagrid.datagrid('getSelections');
		var ids = [];
		var payCodeValue = {};
		//选择一条数据时
		if (rows.length == 1) {
			datagridItem.datagrid({
				data : []
			});
			var orderNum;
			if (rows[0].amount == 0) {
				$.messager.alert('<s:text name="global.form.prompt">提示</s:text>','<s:text name="global.payOrderItem.warn1">该款项无使用记录</s:text>！','info');
				orderNum = '无';
			} else {
				//根据款项编号查询订单号
				$
						.ajax({
							url : '${dynamicURL}/payorder/confPayOrderItemAction!selectOrderCodeByPayCode.action?isUseMoneyPage=true',
							data : {
								payCode : rows[0].payCode
							},
							dataType : 'json',
							success : function(data) {
								$.messager.progress('close');
								//读取数据
								if (data && data.length > 0) {
									var l = data.length;
									var row = {};
									row.paymentMethodName = "小计：";
									row.payCode = "总额：";
									row.totalAmount = rows[0].totalAmount;
									row.orderNum = "已使用金额：";
									row.amount = rows[0].amount;
									row.balance = rows[0].balance;
									data[l] = row;
									datagridItem.datagrid("loadData", data);
								}
							}
						});
				showItemDialog.dialog('open');
			}
		}else{
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>','<s:text name="global.payOrderItem.warn2">请选择一条数据查询明细</s:text>！','info');
		}
	}
	
	function exportDetails() {
		var itemRows = datagridItem.datagrid('getRows');
		if(null == itemRows || itemRows.length == 0) {
			$.messager.progress('close');                                       
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>','<s:text name="global.payOrderItem.warn3">未发现需要导出的数据</s:text>！','info');
		}else{
			var rows = datagrid.datagrid('getSelections');
			var json = itemRows[itemRows.length - 1];
			var str='';
			for(var m in json){
				str += m + "=" + json[m]+"&";
			}
			window.location.href = "${dynamicURL}/payorder/confPayOrderItemAction!exportData.do?isUseMoneyPage=true&"+str+"payCodeString="+rows[0].payCode;
			/* $("#hiddenData").val(rowsData);
			$("#exportForm").attr("action", "${dynamicURL}/payorder/confPayOrderItemAction!exportData.do");
			$("#exportForm").submit(); */
			
		}
	}
	
	function exportData() {
		var rows = datagrid.datagrid('getRows');
		if(rows.length > 0) {
			var serForm = $("#searchForm").serialize();
			window.location.href = "${dynamicURL}/payorder/confPayOrderItemAction!exportMainData.do?isUseMoneyPage=true&" + serForm;
		}else{
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>','<s:text name="global.payOrderItem.warn3">未发现需要导出的数据</s:text>！','info');
		}
	}
</script>
</head>
<body class="easyui-layout zoc">
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 1３0px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>用款查询</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft80">付款方式：</div>
						<div class="rightselect_easyui">
							<input id="paymentMethod" name="paymentMethod" type="text"
								class="short80" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">款项编号：</div>
						<div class="rightselect_easyui">
							<input id="payCode" name="payCode" type="text" class="short80" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">客户编号：</div>
						<div class="rightselect_easyui">
							<input id="customerId" name="customerId" type="text"
								class="short80" />
						</div>
					</div>
					<div class="item33 lastitem">
						<div class="itemleft">币种：</div>
						<div class="righttext">
							<input id="currency" name="currency" type="text" class="easyui-combobox"
								data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=13'"/>
						</div>
					</div>
<!-- 					<input type="hidden" name="isUseMoneyPage" value="true" /> -->
				</div>
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查  询" onclick="_search();" /> <input
							type="button" value="重  置" onclick="cleanSearch();" />
					</div>
				</div>
			</div>

		</form>
	</div>

	<div region="center" border="false" class="part_zoc">
		<table id="datagrid"></table>
	</div>
	<!-- 客户查询  -->
	<div id="_CNNQUERY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCN('_CNNINPUT','_CNNINPUTHISTORY','customerId')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNCLEAN('_CNNINPUT','_CNNINPUTHISTORY','customerId')" />
				</div>
			</div>
		</div>
	</div>
	
   <div id="showItemDialog" style="display: none;overflow: hidden;width: 800px;height: 400px;">
         <table id="datagridItem"></table>
   </div>

</body>
</html>