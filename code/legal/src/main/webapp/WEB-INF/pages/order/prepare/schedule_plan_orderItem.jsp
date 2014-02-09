<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	$(function() {
		//查询列表	
		datagrid = $('#datagrid')
				.datagrid(
						{
							url : '${dynamicURL}/prepare/schedulePlanAction!datagridByOrderCode2.do',
							title : '订单号为<span style="color: red;">'
									+ "${orderNum}" + '</span>的订单明细：',
							iconCls : 'icon-save',
							queryParams : {
								orderNum : "${orderNum}"
							},
							//pagination : true,
							pagePosition : 'bottom',
							rownumbers : true,
							pageSize : 10,
							pageList : [ 10, 20, 30, 40 ],
							fit : true,
							//fitColumns : true,
							border : false,
							frozenColumns : [ [  {
								field : 'orderNum',
								title : '订单号',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.orderNum;
								}
							},{
								field : 'countryName',
								title : '国家',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.countryName;
								}
							}, {
								field : 'factoryProduceCode',
								title : '生产工厂',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.factoryProduceCode;
								}
							},/* {
								field : 'contractCode',
								title : '合同号',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.contractCode;
								}
							}, {
								field : 'haierModer',
								title : '海尔型号',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.haierModer;
								}
							},  */{
								field : 'customerModel',
								title : '客户型号',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.customerModel;
								}
							},  {
								field : 'materialCode',
								title : '物料号',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.materialCode;
								}
							}, {
								field : 'quantity',
								title : '数量',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.quantity;
								}
							}, {
								field : 'orderShipDate',
								title : '出运期',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.orderShipDate);
								}
							},{
								field : 'addirmNum',
								title : '特技单号',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.addirmNum;
								}
							},{
								field : 'orderType',
								title : '订单类型',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.orderType;
								}
							}] ],
							columns : [ [  {
								field : 'created',
								title : '分备单时间',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.created);
								}
							},{
								field : 'actualFinishDate',
								title : '订单审核时间',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.actualFinishDate);
								}
						    },{
								field : 'prodType',
								title : '产品大类',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.prodType;
								}
							} ,{
								field : 'actPrepareCode',
								title : '备货单号',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.actPrepareCode;
								}
							},{
								field : 'custname',
								title : '客户',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.custname;
								}
							}, {
								field : 'deptname',
								title : '经营主体',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.deptname;
								}
							}, {
								field : 'orderBuyoutFlag',
								title : '是否买断',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.orderBuyoutFlag;
								}
							}, {
								field : 'salesOrgName',
								title : '销售组织',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.salesOrgName;
								}
							}, {
								field : 'salesChennel',
								title : '销售渠道',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.salesChennel;
								}
							}, {
								field : 'orderSettlementType',
								title : '结算方式',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.orderSettlementType;
								}
							},  {
								field : 'factorySettlementCode',
								title : '结算工厂',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.factorySettlementCode;
								}
							}, {
								field : 'firstSampleDate',
								title : '首样开始时间',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.firstSampleDate);
								}
							}, {
								field : 'manuStartDate',
								title : '生产计划开始时间',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.manuStartDate);
								}
							}, {
								field : 'manuEndDate',
								title : '生产计划结束时间',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.manuEndDate);
								}
							},{
								field : 'packingStartDate',
								title : '装箱计划开始时间',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.packingStartDate);
								}
							}, {
								field : 'packingEndDate',
								title : '装箱计划结束时间',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.packingEndDate);
								}
							}, {
								field : 'checkStartDate',
								title : '商检计划开始时间',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.checkStartDate);
								}
							}, {
								field : 'checkEndDate',
								title : '商检计划结束时间',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.checkEndDate);
								}
							} ] ]
						});
	});
</script>
</head>
<body>
	<table id="datagrid"></table>
</body>
</html>