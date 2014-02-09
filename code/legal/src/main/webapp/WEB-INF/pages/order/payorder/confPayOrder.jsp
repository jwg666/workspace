<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var searchFormSecond;
	var datagrid;
	var datagridSecond;
	var hisDatagrid;
	var itemDatagrid;
	var orderCheckDialog;
	var orderCheckForm;
	
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		searchFormSecond = $('#searchFormSecond').form();
		searchHistoryForm = $('#searchHistoricForm').form();
		//人员列表  orderProdName
		$('#orderProdManager').combogrid({
			url : '${dynamicURL}/basic/customerAction!datagridForProd.do',
			textField : 'name',
			idField : 'customerId',
			panelWidth : 600,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_USERINFO',
			rownumbers : true,
			fit : true,
			fitColumns : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [{
				field : 'customerId',
				title : '员工号',
				width : 10,
				formatter : function(value, row, index) {
					return row.customerId;
				}
			}, {
				field : 'name',
				title : '用户姓名',
				width : 10,
				formatter : function(value, row, index) {
					return row.name;
				}
			}
			] ]
		});
		
		//加载国家信息
		$('#countryCode').combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 600,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_COUNTRY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 10
			}, {
				field : 'name',
				title : '国家名称',
				width : 10
			} ] ]
		});
		
		//加载国家信息
		$('#countryCode2').combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 600,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_COUNTRY2',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 10
			}, {
				field : 'name',
				title : '国家名称',
				width : 10
			} ] ]
		});
		
		//加载国家信息
		$('#countryCode3').combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 600,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_COUNTRY3',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 10
			}, {
				field : 'name',
				title : '国家名称',
				width : 10
			} ] ]
		});
		
		//custCodeId客户编号
		$('#custCodeId').combogrid({
			url : '../basic/customerAction!datagrid0.action',
			idField:'customerId',
			textField : 'name',
			panelWidth : 600,
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
			columns : [ [ 
			  {
				field : 'customerId',
				title : '客户编号',
				width : 10
			},{
				field : 'name',
				title : '客户名称',
				width : 10
			}] ]
		});
		
		//custCodeId客户编号
		$('#custCodeId2').combogrid({
			url : '../basic/customerAction!datagrid0.action',
			idField:'customerId',
			textField : 'name',
			panelWidth : 600,
			panelHeight : 220,
			toolbar : '#_CNNQUERY2',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ 
			  {
				field : 'customerId',
				title : '客户编号',
				width : 10
			},{
				field : 'name',
				title : '客户名称',
				width : 10
			}] ]
		});
		
		//custCodeId客户编号
		$('#custCodeId3').combogrid({
			url : '../basic/customerAction!datagrid0.action',
			idField:'customerId',
			textField : 'name',
			panelWidth : 600,
			panelHeight : 220,
			toolbar : '#_CNNQUERY3',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ 
			  {
				field : 'customerId',
				title : '客户编号',
				width : 10
			},{
				field : 'name',
				title : '客户名称',
				width : 10
			}] ]
		});
		
		hisDatagrid = $("#confPayHistoryList").datagrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!datagridForHistoricTask.do',
			rownumbers : true,
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			checkOnSelect:false,
			selectOnCheck:false,
			singleSelect : true,
			fitColumns : false,
			pagination:true,
			nowrap : true,
			border : false,
			idField : 'orderCode',
			
			
			scrollbarSize:10,
			frozenColumns:[ [ 
			{
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				width : 150,
				formatter : function(value, row, index) {
					return "<a href='javascript:void(0)' style='color:blue' onclick='detailCheckHis("+index+");return false;'>"+row.orderCode+"</a>";
				}
			}, {
				field : 'orderTypeName',
				title : '订单类型',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderTypeName;
				}
			}, {
				field : 'contractCode',
				title : '合同编号',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.contractCode;
				}
			}, {
				field : 'orderShipDate',
				title : '出运期',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderShipDate);
				}
			},{
				field : 'orderCustomDate',
				title : '客户要求到货时间',
				align : 'center',
				width : 200,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderCustomDate);
				}
			}
			 ] ],
			columns : [ [ 
			{
				field : 'orderDealType',
				title : '成交方式',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderDealType;
				}
			},{
				field : 'currency',
				title : '币种',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.currency;
				}
			},{
				field : 'orderPoCode',
				title : '客户订单号',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderPoCode;
				}
			},{
				field : 'portStartName',
				title : '始发港',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.portStartName;
				}
			},{
				field : 'portEndName',
				title : '目的港',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.portEndName;
				}
			},{
				field : 'vendorName',
				title : '船公司',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.vendorName;
				}
			},{
				field : 'orderCustName',
				title : '经营体长',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderCustName;
				}
			},{
				field : 'orderProdName',
				title : '产品经理 ',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderProdName;
				}
			}, {
				field : 'saleAreaName',
				title : '市场区域',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.saleAreaName;
				}
			}, {
				field : 'countryName',
				title : '出口国家',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			}, {
				field : 'contractCustName',
				title : '客户名称',
				align : 'center',
				width : 200,
				formatter : function(value, row, index) {
					return row.contractCustName;
				}
			}, {
				field : 'orderPaymentMethodName',
				title : '付款方式',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderPaymentMethodName;
				}
			}, {
				field : 'orderPaymentTermsName',
				title : '付款条件',
				align : 'center',
				width : 250,
				formatter : function(value, row, index) {
					return row.orderPaymentTermsName;
				}
			},{
				field : 'orderPaymentCycle',
				title : '订单付款周期',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.orderPaymentCycle;
				}
			}, {
				field : 'amount',
				title : '总金额',
				align : 'center',
				
				width :80,
				formatter : function(value, row, index) {
					return row.amount;
				}
			}, {
				field : 'tempFlag',
				title : '逾期申请状态',
				align : 'center',
				
				width :80,
				formatter : function(value, row, index) {
					return row.tempFlag;
				}
			}, {
				field : 'balance',
				title : '未付款金额',
				align : 'center',
				
				width : 80,
				formatter : function(value, row, index) {
					return row.balance;
				}
			}, {
				field : 'dueDate',
				title : '计划完成时间',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.dueDate;
				}
			}, {
				field : 'activeFlag',
				title : '传入SAP',
				align : 'center',
				width : 150,
				formatter : function(value, row, index) {
					return "<a href='javascript:void(0)' style='color:blue' onclick=\"repass(\'"+row.orderCode+"\');return false;\">"+row.orderCode+"</a>";
				}
			}
			 ] ] ,
		});
		
		datagrid = $("#confPayList").datagrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!datagridForTask.do?definitionKey=payMoney',
			rownumbers : true,
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			checkOnSelect:false,
			selectOnCheck:false,
			singleSelect : true,
			fitColumns : false,
			pagination:true,
			nowrap : true,
			border : false,
			idField : 'orderCode',
			
			
			scrollbarSize:10,
			onDblClickRow : function(rowIndex, rowData) {
				detailCheck(rowIndex);
			},
			toolbar : [ {
				text : '过付款',
				iconCls : 'icon-check',
				handler : function() {
					payMoney(datagrid);
				}
			}, '-', {
				text : '批量过付款',
				iconCls : 'icon-check',
				handler : function() {
					batchPayMoney();
				}} ] ,
			frozenColumns:[ [ 
			          {field:'ck',checkbox:true,
							formatter:function(value,row,index){
								return row.taskId;
							}
						},{
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				width : 150,
				formatter : function(value, row, index) {
					var img;
					if(row.assignee&&row.assignee!='null'){
					img="<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
					}else{
					img="<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
					}
					return "<a href='javascript:void(0)' style='color:blue' onclick='detailCheck("+index+")'>"+img+row.orderCode+"</a>";
				}
			}, {
				field : 'orderTypeName',
				title : '订单类型',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderTypeName;
				}
			}, {
				field : 'contractCode',
				title : '合同编号',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.contractCode;
				}
			}, {
				field : 'orderShipDate',
				title : '出运期',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderShipDate);
				}
			},{
				field : 'orderCustomDate',
				title : '客户要求到货时间',
				align : 'center',
				width : 200,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderCustomDate);
				}
			}
			 ] ],
			columns : [ [ 
			{
				field : 'orderDealType',
				title : '成交方式',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderDealType;
				}
			},{
				field : 'currency',
				title : '币种',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.currency;
				}
			},{
				field : 'orderPoCode',
				title : '客户订单号',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderPoCode;
				}
			},{
				field : 'portStartName',
				title : '始发港',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.portStartName;
				}
			},{
				field : 'portEndName',
				title : '目的港',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.portEndName;
				}
			},{
				field : 'vendorName',
				title : '船公司',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.vendorName;
				}
			},{
				field : 'orderCustName',
				title : '经营体长',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderCustName;
				}
			},{
				field : 'orderProdName',
				title : '产品经理 ',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderProdName;
				}
			}, {
				field : 'saleAreaName',
				title : '市场区域',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.saleAreaName;
				}
			}, {
				field : 'countryName',
				title : '出口国家',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			}, {
				field : 'contractCustName',
				title : '客户名称',
				align : 'center',
				width : 200,
				formatter : function(value, row, index) {
					return row.contractCustName;
				}
			}, {
				field : 'orderPaymentMethodName',
				title : '付款方式',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderPaymentMethodName;
				}
			}, {
				field : 'orderPaymentTermsName',
				title : '付款条件',
				align : 'center',
				width : 250,
				formatter : function(value, row, index) {
					return row.orderPaymentTermsName;
				}
			},{
				field : 'orderPaymentCycle',
				title : '订单付款周期',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.orderPaymentCycle;
				}
			}, {
				field : 'amount',
				title : '总金额',
				align : 'center',
				
				width :80,
				formatter : function(value, row, index) {
					return row.amount;
				}
			}, {
				field : 'tempFlag',
				title : '逾期申请状态',
				align : 'center',
				
				width :80,
				formatter : function(value, row, index) {
					return row.tempFlag;
				}
			}, {
				field : 'balance',
				title : '未付款金额',
				align : 'center',
				
				width : 80,
				formatter : function(value, row, index) {
					return row.balance;
				}
			}, {
				field : 'dueDate',
				title : '计划完成时间',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.dueDate;
				}
			}
			 ] ] ,
			onClickRow : function(rowIndex,rowData){
					itemDatagrid.datagrid({url:'${dynamicURL}/salesOrder/salesOrderItemAction!datagirdForItem.do',queryParams:{
						orderCode:rowData.orderCode
					}})
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
		
		datagridSecond = $("#confPayListSecond").datagrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!datagridForSecondPayTask.do?definitionKey=secondPayMoney',
			rownumbers : true,
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			checkOnSelect:false,
			selectOnCheck:false,
			singleSelect : true,
			fitColumns : false,
			pagination:true,
			nowrap : true,
			border : false,
			idField : 'orderCode',
			
			
			scrollbarSize:10,
			onDblClickRow : function(rowIndex, rowData) {
				detailCheck(rowIndex);
			},
			toolbar : [ {
				text : '过付款',
				iconCls : 'icon-check',
				handler : function() {
					payMoney(datagridSecond);
				}
			}] ,
			frozenColumns:[ [ 
			          {field:'ck',checkbox:true,
							formatter:function(value,row,index){
								return row.taskId;
							}
						},{
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				width : 150,
				formatter : function(value, row, index) {
					var img;
					if(row.assignee&&row.assignee!='null'){
					img="<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
					}else{
					img="<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
					}
					return "<a href='javascript:void(0)' style='color:blue' onclick='secondDetailCheck("+index+")'>"+img+row.orderCode+"</a>";
				}
			}, {
				field : 'orderTypeName',
				title : '订单类型',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderTypeName;
				}
			}, {
				field : 'contractCode',
				title : '合同编号',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.contractCode;
				}
			}, {
				field : 'orderShipDate',
				title : '出运期',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderShipDate);
				}
			},{
				field : 'orderCustomDate',
				title : '客户要求到货时间',
				align : 'center',
				width : 200,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderCustomDate);
				}
			}
			 ] ],
			columns : [ [ 
			{
				field : 'orderDealType',
				title : '成交方式',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderDealType;
				}
			},{
				field : 'currency',
				title : '币种',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.currency;
				}
			},{
				field : 'orderPoCode',
				title : '客户订单号',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderPoCode;
				}
			},{
				field : 'portStartName',
				title : '始发港',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.portStartName;
				}
			},{
				field : 'portEndName',
				title : '目的港',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.portEndName;
				}
			},{
				field : 'vendorName',
				title : '船公司',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.vendorName;
				}
			},{
				field : 'orderCustName',
				title : '经营体长',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderCustName;
				}
			},{
				field : 'orderProdName',
				title : '产品经理 ',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderProdName;
				}
			}, {
				field : 'saleAreaName',
				title : '市场区域',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.saleAreaName;
				}
			}, {
				field : 'countryName',
				title : '出口国家',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			}, {
				field : 'contractCustName',
				title : '客户名称',
				align : 'center',
				width : 200,
				formatter : function(value, row, index) {
					return row.contractCustName;
				}
			}, {
				field : 'orderPaymentMethodName',
				title : '付款方式',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.orderPaymentMethodName;
				}
			}, {
				field : 'orderPaymentTermsName',
				title : '付款条件',
				align : 'center',
				width : 250,
				formatter : function(value, row, index) {
					return row.orderPaymentTermsName;
				}
			},{
				field : 'orderPaymentCycle',
				title : '订单付款周期',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.orderPaymentCycle;
				}
			}, {
				field : 'amount',
				title : '总金额',
				align : 'center',
				
				width :80,
				formatter : function(value, row, index) {
					return row.amount;
				}
			}, {
				field : 'tempFlag',
				title : '逾期申请状态',
				align : 'center',
				
				width :80,
				formatter : function(value, row, index) {
					return row.tempFlag;
				}
			}, {
				field : 'balance',
				title : '未付款金额',
				align : 'center',
				
				width : 80,
				formatter : function(value, row, index) {
					return row.balance;
				}
			}, {
				field : 'dueDate',
				title : '计划完成时间',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.dueDate;
				}
			}
			 ] ] ,
			onDblClickRow : function(rowIndex,rowData){
					itemDatagrid.datagrid({url:'${dynamicURL}/salesOrder/salesOrderItemAction!datagirdForItem.do',queryParams:{
						orderCode:rowData.orderCode
					}})
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
		
		itemDatagrid = $('#itemDatagrid').datagrid({
			pagination : true,
			title : '付款明细',
			pagePosition : 'bottom',
			rownumbers : true,
			fit : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'orderItemLinecode',
			
			
			columns : [ [ 
			   {field:'orderItemLinecode',title:'行项目号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderItemLinecode;
					}
				},				
			   {field:'orderCode',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
			   {field:'prodTname',title:'产品大类',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prodTname;
					}
				},				
			   {field:'materialCode',title:'物料号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.materialCode;
					}
				},
				{field:'haierModel',title:'海尔型号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.haierModel;
					}
				},
				{field:'customerModel',title:'客户型号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.customerModel;
					}
				},
				{field:'affirmNum',title:'特技单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.affirmNum;
					}
				},				
			   {field:'prodQuantity',title:'数量',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prodQuantity;
					}
				},				
			   {field:'price',title:'单价',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.price;
					}
				},				
			   {field:'currency',title:'币种',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.currency;
					}
				},				
			   {field:'amount',title:'总额',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.amount;
					}
				}				
			 ] ]
		});
	});

	function _search() {
		$("#confPayList").datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		$("#confPayList").datagrid('load', {});
		searchForm.form('clear');
	}
	function _searchSecond() {
		$("#confPayListSecond").datagrid('load', sy.serializeObject(searchFormSecond));
	}
	function cleanSearchSecond() {
		$("#confPayListSecond").datagrid('load', {});
		searchFormSecond.form('clear');
	}
	
	function _historySearch() {
		$("#confPayHistoryList").datagrid('load', sy.serializeObject(searchHistoryForm));
	}
	function cleanHistorySearch() {
		$("#confPayHistoryList").datagrid('load', {});
		searchHistoryForm.form('clear');
	}
	
	/*过付款*/
	function payMoney(witchDatagrid) {
		var checkedRows = witchDatagrid.datagrid('getChecked');
		var len = checkedRows.length;
		var orderCode;
		var taskId;
		//如果选择多条，则需要批量过付款
		if(0 == len){
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.payOrder.warn1">请您选择订单！</s:text>', 'warn');	
		}else if(1 < len) {
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.payOrder.warn2">请您批量过付款！</s:text>', 'warn');
		}else{
			orderCode = checkedRows[0].orderCode;
			taskId = checkedRows[0].id;
			var isOverdue = false;
			
			$.ajax({
			   type: "POST",
			   url: "${dynamicURL}/salesOrder/salesOrderAction!singlePayMoneyOverdue.action?orderCode="+orderCode,
			   dataType:'json',
			   success: function(json){
			     if(json.msg != ""){
			    	 $.messager.confirm('<s:text name="global.form.prompt">提示</s:text>', json.msg, function(r){
			    		 if(r){
		                	 $.ajax({
		      		  		   type: "POST",
		      		  		   url: "${dynamicURL}/salesOrder/salesOrderAction!applyRelease.action",
		      		  		   data: "orderCode="+orderCode,
		      		  		   success: function(json){
		      		  			     var data = $.parseJSON(json);
			      		  			 if('null' == data.msg || '' == data.msg ) {
			      		  				 parent.window.HROS.window.createTemp({
			      			    			 title:"-订单号:${orderCode}，释放闸口申请！",
			      			    			 url:'${dynamicURL}/overdue/arOverdueAction!goOperationOverdue.do',
			      			    			 width:800,height:400,isresize:true,isopenmax:true,isflash:false,customWindow:window});
			      		  			 }	 
		      		  		   }
		                	 });  
		                }else{
		  					refresh();
		                }
		            });
			     }else{
			    	 var url = "${dynamicURL}/salesOrder/salesOrderAction!forwardPayMoney.action?orderCode="+orderCode+"&taskId="+taskId;
					
			    	 parent.window.HROS.window.createTemp({
		    			 title:checkedRows[0].name+"-<s:text name='global.order.number'>订单号</s:text>:"+checkedRows[0].orderCode,
		    			 url:url,
		    			 width:800,height:400,isresize:true,isopenmax:true,isflash:false,customWindow:window});
			     }
			   }
			});
		}
	}
	
	/*批量过付款*/
	function batchPayMoney() {
		//var ids = "";
		var checkedRows = datagrid.datagrid('getChecked');
		
		var totalMoney = 0.0;
		var jsonStr = JSON.stringify(checkedRows);
		
		var url = "${dynamicURL}/salesOrder/salesOrderAction!batchPayMoney.action";
		
		if(checkedRows.length > 0) {
			for(var i = 0 , len = checkedRows.length ; i < len ; i++) {
				var row = checkedRows[i];
				totalMoney = accAdd(totalMoney,row.balance);
			}
			$.messager.confirm('<s:text name="global.payOrder.batchPay">批量过付款</s:text>', '<s:text name="global.payOrder.batchPay2">您批量过付款的总金额为</s:text>：' + totalMoney, function(r) {
				if (r) {
					$.messager.progress({
							text : '<s:text name="the.data.load">数据加载中....</s:text>',
							interval : 100
					});
					$.ajax({
					   type: "POST",
					   url: url,
					   data:{"batchPayMoneyList":jsonStr},
					   success: function(json){
						   	$.messager.progress('close');
						    var data = $.parseJSON(json);
							$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', data.msg,'',function(){
								datagrid.datagrid('uncheckAll');
								refresh();
							});
					   }
					});
				}
			});
		}
	}
	
	function secondDetailCheck(rowIndex) {
		var obj=$("#confPayListSecond").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
		title:obj.name+"-<s:text name='global.order.number'>订单号</s:text>:"+obj.orderCode,
		url:"${dynamicURL}/salesOrder/salesOrderAction!forwardPayMoney.action?orderCode="+obj.orderCode+"&taskId="+obj.id,
		width:800,height:400,isresize:true,isopenmax:true,isflash:false,customWindow:window});
	}
	
	function detailCheck(rowIndex) {
		var obj=$("#confPayList").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
		title:obj.name+"-<s:text name='global.order.number'>订单号</s:text>:"+obj.orderCode,
		url:"${dynamicURL}/salesOrder/salesOrderAction!forwardPayMoney.action?orderCode="+obj.orderCode+"&taskId="+obj.id,
		width:800,height:400,isresize:true,isopenmax:true,isflash:false,customWindow:window});
	}
	
	function detailCheckHis(rowIndex) {
		var obj=$("#confPayHistoryList").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
		title:obj.name+"-<s:text name='global.order.number'>订单号</s:text>:"+obj.orderCode,
		url:"${dynamicURL}/salesOrder/salesOrderAction!forwardPayMoneyDetail.action?orderCode="+obj.orderCode,
		width:800,height:400,isresize:true,isopenmax:true,isflash:false});
	}
	
	function hideCheckSearchSecond(){
		$("#checkSearchSecond").layout("collapse","north");
	}
	
	function hideCheckSearch(){
		$("#checkSearch").layout("collapse","north");
	}
	function hideHistorySearch(){
		
		$("#historySearch").layout("collapse","north");
	} 
	function refresh() {
		top.window.showTaskCount();
		datagrid.datagrid('reload');
		datagridSecond.datagrid('reload');
		hisDatagrid.datagrid('reload');
	}
	
	function repass(ordCode) {
		var url = '${dynamicURL}/salesOrder/salesOrderAction!repass.action';
		$.ajax({
		   type: "POST",
		   url: url,
		   data:{"orderCode":ordCode},
		   dataType:'json',
		   success: function(json){
				$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', json.msg,'',function(){
					datagrid.datagrid('uncheckAll');
					refresh();
				});
		   }
		});
		
	}
	
	function CCNMY(inputId,inputId2,selectId) {
		var _CCNTEMP = $('#' + inputId).val();
		var _CCNTEMP2 = $('#' + inputId2).val();
		var url = '${dynamicURL}/basic/customerAction!datagrid0.action?name=' + _CCNTEMP;
		if("" != _CCNTEMP2) {
			url = url + '&customerId=' + _CCNTEMP2;
		}
		$('#' + selectId).combogrid({
			url : url
		});
	}
	
	//模糊查询国家下拉列表
	function _CCNCOUNTRY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do?name='+ _CCNTEMP+'&countryCode='+_CCNCODE 
		});
	}
	
	//模糊查询国家下拉列表
	function _USERINFO(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/customerAction!datagridForProd.do?name='+ _CCNTEMP+'&customerId='+_CCNCODE 
		});
	}
	
	function accAdd(arg1,arg2){ 
		var r1,r2,m; 
		try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
		try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
		m=Math.pow(10,Math.max(r1,r2)) 
		return (arg1*m+arg2*m)/m 
	} 
</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true" >
		<div title="付款保障待办">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="part_zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 113px; overflow: hidden;">
					<div class="partnavi_zoc"><span>查询与操作：</span></div>
					<form id="searchForm">
						<div class="oneline">
							<div class="item33">
								<div class="itemleft">订单号:</div>
								<div class="righttext">
									<input name="orderCode" type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft">出口国家:</div>
								<div class="righttext_easyui">
									<input name="countryCode" class="easyui-combobox short60" id="countryCode"/>
								</div>
							</div>
							<div class="item33">
								<div class="itemleft">客户名称:</div>
								<div class="righttext_easyui">
									<input type="text" class="short50" name="customerCode" id="custCodeId"/>
								</div>
							</div>
							<div class="item33 lastitem">
								<div class="itemleft">产品经理:</div>
								<div class="righttext_easyui">
									<input type="text" class="short50" name="orderProdManager" id="orderProdManager"/>
								</div>
							</div>
						</div>
						<!-- <div class="oneline">
							<div class="item33 lastitem">
								<div class="itemleft">任务类型:</div>
								<div class="righttext_easyui">
									<input name="taskType" class="easyui-combobox short60"
										data-options="panelHeight:80,valueField:'value',textField:'label',data: [{label: '全部',value: '',select:true},{label: '个人任务',value: 'my'},{label: '未认领任务',value: 'group'}]" />
								</div>
							</div>
						</div> -->
						<div class="oneline">
							<div class="item100">
								<div class="oprationbutt">
								<input type="button" onclick="_search();" value="查  询" /> <input
									type="button" onclick="cleanSearch();" value="取消" /> <a
									href="javascript:void(0)" onclick="hideCheckSearch();"><input
									type="button" value="隐藏" /></a>
								</div>
							</div>	
						</div>
					</form>
				</div>

				<div region="center" border="false">
					<table id="confPayList"></table>
				</div>
				
				<div region="south" border="false" style="height:150px;margin-top:10px;" class="zoc">
					<table id="itemDatagrid"></table>
				</div>
				
			</div>
		</div>

		<div title="二次付款待办">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearchSecond" class="easyui-layout" fit="true">
				<div class="part_zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 113px; overflow: hidden;">
					<div class="partnavi_zoc"><span>查询与操作：</span></div>
					<form id="searchFormSecond">
						<div class="oneline">
							<div class="item33">
								<div class="itemleft">订单号:</div>
								<div class="righttext">
									<input name="orderCode" type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft">出口国家:</div>
								<div class="righttext_easyui">
									<input name="countryCode" id="countryCode2" class="easyui-combobox short60" />
								</div>
							</div>
							<div class="item33 lastitem">
								<div class="itemleft">客户名称:</div>
								<div class="righttext_easyui">
									<input type="text" class="short50" name="customerCode" id="custCodeId2"/>
								</div>
							</div>
						</div>
						<!-- <div class="oneline">
							<div class="item33 lastitem">
								<div class="itemleft">任务类型:</div>
								<div class="righttext_easyui">
									<input name="taskType" class="easyui-combobox short60"
										data-options="panelHeight:80,valueField:'value',textField:'label',data: [{label: '全部',value: '',select:true},{label: '个人任务',value: 'my'},{label: '未认领任务',value: 'group'}]" />
								</div>
							</div>
						</div> -->
						<div class="oneline">
							<div class="item100">
								<div class="oprationbutt">
								<input type="button" onclick="_searchSecond();" value="查  询" /> <input
									type="button" onclick="cleanSearchSecond();" value="取消" /> <a
									href="javascript:void(0)" onclick="hideCheckSearchSecond();"><input
									type="button" value="隐藏" /></a>
								</div>
							</div>	
						</div>
					</form>
				</div>

				<div region="center" border="false">
					<table id="confPayListSecond"></table>
				</div>
				
<!-- 				<div region="south" border="false" style="height:150px;margin-top:10px;" class="zoc">
					<table id="itemDatagridSecond"></table>
				</div> -->
				
			</div>
		</div>

		<div title="已完成的过付款待办">
			<!--展开之后的content-part所显示的内容-->
			<div class="easyui-layout" fit="true" id="historySearch">
				<div class="part_zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 113px; overflow: hidden;">
					<div class="partnavi_zoc"><span>查询与操作：</span></div>
					<form id="searchHistoricForm">
						<div class="oneline">
							<div class="item33">
								<div class="itemleft">订单号:</div>
								<div class="righttext">
									<input name="orderCode" type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft">出口国家:</div>
								<div class="righttext_easyui">
									<input name="countryCode" id="countryCode3" class="easyui-combobox short60" />
								</div>
							</div>
							<div class="item33 lastitem">
								<div class="itemleft">客户名称:</div>
								<div class="righttext_easyui">
									<input type="text" class="short50" name="customerCode" id="custCodeId3"/>
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item33 lastitem">
								<div class="itemleft">任务类型:</div>
								<div class="righttext_easyui">
									<input name="definitionKey" class="easyui-combobox short60"
										data-options="panelHeight:80,valueField:'value',textField:'label',data: [{label: '一次付款',value: 'payMoney','selected':true},{label: '二次付款',value: 'secondPayMoney'}]" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item100">
								<div class="oprationbutt">
								<input type="button" onclick="_historySearch();" value="查  询" /> <input
									type="button" onclick="cleanHistorySearch();" value="取消" /> <a
									href="javascript:void(0)" onclick="hideHistorySearch();"><input
									type="button" value="隐藏" /></a>
								</div>
							</div>	
						</div>
					</form>
				</div>

				<div region="center" border="false">
				 	<table id="confPayHistoryList" ></table> 
				</div>
				
			</div>
		</div>
	</div>
	
	<div id="iframeDialog" style="display: none;overflow: auto;width: 600px;height: 400px;">
		<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:100%;">
	    </iframe> 
	</div>
	
	<div id="_CNNQUERY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUT2" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名称：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item100">
				<div class="oprationbutt">
					<input type="button" value="查询"
						onclick="CCNMY('_CNNINPUT','_CNNINPUT2','custCodeId')" />
				</div>
			</div>
		</div>
	</div>
	
	<div id="_CNNQUERY2">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUT2" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名称：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item100">
				<div class="oprationbutt">
					<input type="button" value="查询"
						onclick="CCNMY('_CNNINPUT','_CNNINPUT2','custCodeId2')" />
				</div>
			</div>
		</div>
	</div>
	
	<div id="_CNNQUERY3">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUT2" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名称：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item100">
				<div class="oprationbutt">
					<input type="button" value="查询"
						onclick="CCNMY('_CNNINPUT','_CNNINPUT2','custCodeId3')" />
				</div>
			</div>
		</div>
	</div>
	
	<div id="_COUNTRY">
			<div class="oneline">
				<div class="item25">
					<div class="itemleft60">国家编号：</div>
					<div class="righttext">
						<input class="short60" id="_COUNTRYINPUT1" type="text" />
					</div>
				</div>
				<div class="item25">
					<div class="itemleft60">国家名称：</div>
					<div class="righttext">
						<input class="short60" id="_COUNTRYINPUT2" type="text" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查询"
							onclick="_CCNCOUNTRY('_COUNTRYINPUT1','_COUNTRYINPUT2','countryCode')" />
					</div>
				</div>
			</div>
		</div>
		
		<div id="_COUNTRY2">
			<div class="oneline">
				<div class="item25">
					<div class="itemleft60">国家编号：</div>
					<div class="righttext">
						<input class="short60" id="_COUNTRYINPUT1" type="text" />
					</div>
				</div>
				<div class="item25">
					<div class="itemleft60">国家名称：</div>
					<div class="righttext">
						<input class="short60" id="_COUNTRYINPUT2" type="text" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查询"
							onclick="_CCNCOUNTRY('_COUNTRYINPUT1','_COUNTRYINPUT2','countryCode2')" />
					</div>
				</div>
			</div>
		</div>
		
		<div id="_COUNTRY3">
			<div class="oneline">
				<div class="item25">
					<div class="itemleft60">国家编号：</div>
					<div class="righttext">
						<input class="short60" id="_COUNTRYINPUT1" type="text" />
					</div>
				</div>
				<div class="item25">
					<div class="itemleft60">国家名称：</div>
					<div class="righttext">
						<input class="short60" id="_COUNTRYINPUT2" type="text" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查询"
							onclick="_CCNCOUNTRY('_COUNTRYINPUT1','_COUNTRYINPUT2','countryCode3')" />
					</div>
				</div>
			</div>
		</div>
		
		<div id="_USERINFO">
			<div class="oneline">
				<div class="item25">
					<div class="itemleft60">编 码：</div>
					<div class="righttext">
						<input class="short60" id="_USERINFOINPUT1" type="text" />
					</div>
				</div>
				<div class="item25">
					<div class="itemleft60">姓 名：</div>
					<div class="righttext">
						<input class="short60" id="_USERINFOINPUT2" type="text" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查询"
							onclick="_USERINFO('_USERINFOINPUT1','_USERINFOINPUT2','orderProdManager')" />
					</div>
				</div>
			</div>
		</div>
</body>
</html>