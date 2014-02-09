<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var cdescAdd;
	var cdescEdit;
	var showCdescDialog;
	var prepareOrderDetailDialog; //明细Dialog
	var iframeDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid')
				.datagrid(
						{
							url : 'queryPrepareAction!findNotPrepareDatagrid.do',
							title : '未分单订单查询',
							iconCls : 'icon-save',
							pagination : true,
							pagePosition : 'bottom',
							rownumbers : true,
							singleSelect : true,
							pageSize : 10,
							pageList : [ 10, 20, 30, 40 ],
							fit : true,
							//fitColumns : true,
							nowrap : true,
							border : false,
							frozenColumns : [ [{
								field : 'orderNum',
								title : '订单号',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.orderNum;
								}
							},
							{
								field : 'contractCode',
								title : '合同号',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.contractCode;
								}
							},
							{
								field : 'orderType',
								title : '订单类型',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.orderType;
								}
							},{
								field : 'rFlag',
								title : '状态',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									if(row.rFlag=='0'){
										return '订单保存完成(尚未审核)';
									}else if(row.rFlag=='1'){
										return '订单审核完成';
									}else if(row.rFlag=='3'){
										return '调度单锁定状态';
									}else if(row.rFlag=='5'){
										return '修改申请通过可以修改订单';
									}else{
										return '订单的补录状态';
									}
									return row.rFlag;
								}
							}
							                   ]],
							columns : [ [ {
								field : 'custname',
								title : '客户名称',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.custname;
								}
							},{
								field : 'counName',
								title : '国家',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.counName;
								}
							}, 
							{
								field : 'orderShipDate',
								title : '出运期',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.orderShipDate);
								}
							}, {
								field : 'actualFinishDate',
								title : '订单审核时间',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.actualFinishDate);
								}
						    },{
								field : 'shipTo',
								title : '运输方式',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.shipTo;
								}
							},{
								field : 'orderExecManager',
								title : '订单执行经理',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.orderExecManager;
								}
							}, {
								field : 'orderCustNamager',
								title : '经营体长',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.orderCustNamager;
								}
							},  {
								field : 'prodType',
								title : '产品大类',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.prodType;
								}
							}, {
								field : 'haierModer',
								title : '海尔型号',
								align : 'center',
								formatter : function(value, row, roindex) {
									return row.haierModer;
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
								field : 'addirmNum',
								title : '特技单号',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.addirmNum;
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
								field : 'factoryName',
								title : '生产工厂',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.factoryName;
								}
							},{
								field : 'prodQuantity',
								title : '数量',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.prodQuantity;
								}
							},{
								field : 'price',
								title : '单价',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.price;
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
		//加载国家信息
		$('#countryCodeFinish').combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_COUNTRYHISTORY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 20
			}, {
				field : 'name',
				title : '国家名称',
				width : 20
			} ] ]
		});
		//加载工厂信息
		$('#factoryCodeFinish')
				.combogrid(
						{
							url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0',
							textField : 'deptNameCn',
							idField : 'deptCode',
							panelWidth : 500,
							panelHeight : 220,
							pagination : true,
							pageSize : 300,
							pageList : [ 300 ],
							pagePosition : 'bottom',
							toolbar : '#_FACTORYHISTORY',
							rownumbers : true,
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

		prepareOrderDetailDialog = $('#prepareOrderDetailDialog').show()
				.dialog({
					title : '备货单详情',
					modal : true,
					closed : true,
					draggable : false,
					maximizable : true
				});
	});
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
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
					$.messager.alert('提示', '没有生成描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	function export1() {
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$("#searchForm").attr("action",
				"queryPrepareAction!exportQueryNotPrepare.action");
		$("#searchForm").submit();
		$.messager.progress('close');
	}
	//模糊查询国家下拉列表
	function _CCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid(
				{
					url : '${dynamicURL}/basic/countryAction!datagrid.do?name='
							+ _CCNTEMP + '&countryCode=' + _CCNCODE
				});
	}
	//重置查询国家信息输入框
	function _CCNMYCLEAN(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do'
		});
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
<body class="easyui-layout">
	<jsp:include page="query_prepareOrder_detail.jsp" />
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 120px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>未分单订单查询</span>
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
								style="width: 125px" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">产品大类：</div>
						<div class="righttext_easyui">
						<input name="prodType" class="easyui-combobox short60"
										style="width: 130px" 
										data-options="valueField:'prodTypeCode',textField:'prodType',url:'${dynamicURL}/basic/prodTypeAction!combox.action'" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">国家：</div>
						<div class="rightselect_easyui">
							<input id="countryCodeFinish" name="countryCode" class="short50"
								type="text" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft60">工厂：</div>
						<div class="rightselect_easyui">
							<input id="factoryCodeFinish" name="factoryProduceCode"
								class="short100" type="text" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">出运期：</div>
						<div class="rightselect_easyui">
							<input id="orderShipDate" name="orderShipDate"
								style="width: 120px" class="easyui-datebox" editable="false" />
						</div>
					</div>
				</div>
				<div class="oneline">
				<div class="item25">
						<div class="itemleft60">是否导R3：</div>
						<div class="rightselect_easyui">
							<select name="roshFlag">
								<option value="">全部</option>
								<option value="1">是</option>
								<option value="0">否</option>
							</select>
						</div>
					</div>
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查  询" onclick="_search();" /> <input
							type="button" value="重  置" onclick="cleanSearch();" /> <input
							type="button" value="导  出" onclick="export1();" />
					</div>
				</div>
				</div>
			</div>
		</form>
	</div>

	<div region="center" border="false">
		<table id="datagrid"></table>
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
	<div id="_COUNTRYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="_COUNTRYCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCNMY('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryCodeFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryCodeFinish')" />
				</div>
			</div>
		</div>
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