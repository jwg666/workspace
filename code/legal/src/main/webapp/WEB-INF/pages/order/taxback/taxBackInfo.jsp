<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'taxBackInfoAction!datagrid.do',
			title : '预申报列表',
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
			idField : 'rowId',
			
			frozenColumns : [ [ {
				field : 'createDate',
				title : '所属月份',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.createDate);
				}
			}, {
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderCode;
				}
			}, {
				field : 'taxcode',
				title : '增值税发票号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.taxcode;
				}
			},{
				field : 'compreeCode',
				title : '综合通知单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.compreeCode;
				}
			}, {
				field : 'invoiceCompany',
				title : '结算公司',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.invoiceCompany;
				}
			}, {
				field : 'productFactory',
				title : '工厂',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.productFactory;
				}
			}, {
				field : 'productCode',
				title : '产品大类',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.productCode;
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
				field : 'unit',
				title : '计量单位',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.unit;
				}
			}, {
				field : 'amount',
				title : '数量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.amount;
				}
			} ] ],
			columns : [ [ {
				field : 'moneyType',
				title : '原币币种',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.moneyType;
				}
			}, {
				field : 'price',
				title : '原币单价',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.price;
				}
			}, {
				field : 'exportAmount',
				title : '出口总额',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.exportAmount;
				}
			}, {
				field : 'shipFee',
				title : '运费保费',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.shipFee;
				}
			}, {
				field : 'fobAmount',
				title : 'FOB出口总额',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.fobAmount;
				}
			}, {
				field : 'usdExchangeRate',
				title : '美元兑人民币汇率',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.usdExchangeRate;
				}
			}, {
				field : 'applyAmount',
				title : '应退税申报额',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.applyAmount;
				}
			}, {
				field : 'prepareFactory',
				title : '备货厂家',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.prepareFactory;
				}
			}, {
				field : 'customDate',
				title : '报关日期',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.customDate);
				}
			}, {
				field : 'agencyBillCode',
				title : '代理清单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.agencyBillCode;
				}
			}, {
				field : 'customCode',
				title : '报关单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customCode;
				}
			}, {
				field : 'exportInvoiceCode',
				title : '出口发票号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.exportInvoiceCode;
				}
			}, {
				field : 'originalUsdRate',
				title : '原币兑美元汇率',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.originalUsdRate;
				}
			}, {
				field : 'customGoodsName',
				title : '海关商品名称',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customGoodsName;
				}
			}, {
				field : 'customGoodsCode',
				title : '海关商品编码',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customGoodsCode;
				}
			}, {
				field : 'docCode',
				title : '备案项号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.docCode;
				}
			}, {
				field : 'booksNum',
				title : '账册号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.booksNum;
				}
			}, {
				field : 'actualShipDate',
				title : '出口日期',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.actualShipDate;
				}
			}, {
				field : 'orderBuyoutFlag',
				title : '是否买断',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (row.orderBuyoutFlag == '1') {
						return '买断';
					} else if (row.orderBuyoutFlag == '0') {
						return '代理';
					} else {
						return '';
					}

				}
			} /* ,				
												   {field:'mergeFalg',title:'是否合票',align:'center',sortable:true,
														formatter:function(value,row,index){
															return row.mergeFalg;
														}
													},				
												   {field:'mergeValue',title:'合票值',align:'center',sortable:true,
														formatter:function(value,row,index){
															return row.mergeValue;
														}
													},				
												   {field:'taxBackFalg',title:'退税活动完成标志',align:'center',sortable:true,
														formatter:function(value,row,index){
															return row.taxBackFalg;
														}
													},				
												   {field:'taxBackDate',title:'退税活动结束日期',align:'center',sortable:true,
														formatter:function(value,row,index){
															return dateFormatYMD(row.taxBackDate);
														}
													},				
												   {field:'activeFlag',title:'有效标识',align:'center',sortable:true,
														formatter:function(value,row,index){
															return row.activeFlag;
														}
													}				 */
			] ],
			toolbar : [ {
				text : '导出预申报材料',
				iconCls : 'icon-edit',
				handler : function() {
					exceloutput();
				}
			}, '-'/*, {
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
															}, '-' */],
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
		$('#productCodeId').combobox({
			url : '${dynamicURL}/basic/prodTypeAction!combox.do',
			valueField : 'prodTypeCode',
			textField : 'prodType'
		});
		///加载工厂信息
		$('#factoryCodeFinish')
				.combogrid(
						{
							url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0',
							textField : 'deptNameCn',
							idField : 'deptCode',
							panelWidth : 500,
							panelHeight : 220,
							pagination : true,
							pagePosition : 'bottom',
							toolbar : '#_FACTORYHISTORY',
							rownumbers : true,
							pageSize : 5,
							pageList : [ 5, 10 ],
							fit : true,
							fitColumns : true,
							columns : [ [ {
								field : 'deptCode',
								title : '工厂编码',
								width : 20
							}, {
								field : 'deptNameCn',
								title : '工厂名称',
								width : 20
							} ] ]
						});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function exceloutput() {
		$("#searchForm").attr("action", "taxBackInfoAction!exceloutput.action");
		$("#searchForm").submit();
	}
	//模糊查询工厂下拉列表
	function _FACTORYCCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId)
				.combogrid(
						{
							url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0&deptNameCn='
									+ _CCNTEMP + '&deptCode=' + _CCNCODE
						});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询工厂信息输入框
	function _FACTORYCCNMYCLEAN(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId)
				.combogrid(
						{
							url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0'
						});
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div class="zoc" region="north" border="false" collapsible="true"
		style="height: 120px; overflow: hidden;">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>预申报</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">订单号:</div>
						<div class="righttext">
							<input type="text" name="orderCode" style="width: 150px" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">工厂:</div>
						<div class="rightselect_easyui">
							<input id="factoryCodeFinish" name="productFactory"
								class="short50" type="text" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">产品组:</div>
						<div class="righttext">
							<input type="text" id="productCodeId" name="productCode" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">买断标识:</div>
						<div class="righttext">
							<select name="orderBuyoutFlag" style="width: 150px">
								<option value="">全部</option>
								<option value="0">代理</option>
								<option value="1">买断</option>
							</select>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">报关单号:</div>
						<div class="righttext">
							<input type="text" name="customCode" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">所属月份:</div>
						<div class="righttext">
							<input type="text" name="printDateStart" class="easyui-datebox" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">至:</div>
						<div class="righttext">
							<input type="text" name="printDateEnd" class="easyui-datebox" />
						</div>
					</div>
					<div class="item25">
						<div class="oprationbutt">
							<input type="button" onclick="_search();" value="查  询" /> <input
								type="button" onclick="cleanSearch();" value="重  置" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div border="false" data-options="region:'center'">
		<table id="datagrid"></table>
	</div>
	<div id="_FACTORYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_FACTORYCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">工厂名称：</div>
				<div class="righttext">
					<input class="short60" id="_FACTORYINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_FACTORYCCNMY('_FACTORYCODEHISTORY','_FACTORYINPUTHISTORY','factoryCodeFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_FACTORYCCNMYCLEAN('_FACTORYCODEHISTORY','_FACTORYINPUTHISTORY','factoryCodeFinish')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>