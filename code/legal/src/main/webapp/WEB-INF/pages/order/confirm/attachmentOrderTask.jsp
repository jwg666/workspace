<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var checkFinishSearch;
	var waitWorkDatagrid;
	var waitWorkFinishDatagrid;
	var orderConfirmAppid = null;
	$(function() {
		//未完成订单确认列表
		searchForm = $('#searchForm').form();
		checkFinishSearch = $('#checkFinishSearch').form();
		waitWorkDatagrid = $('#waitWorkDatagrid').datagrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!attachmentOrderTask.action',
			pagination : true,
			pageList : [10],
			fit : true,
			//fitColumns : true,
			nowrap : true,
			border : false,
			singleSelect : true,
			frozenColumns : [ [ 
			{
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return "<a href='javascript:void(0)' style='color:blue' onclick='orderConfirm(\""+row.orderCode+"\",\""+row.orderType+"\")'> "+row.orderCode+"</a>";
				}
			},
			{
				field : 'orderPoCode',
				title : '客户订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderPoCode;
				}
			},
			{
				field : 'customerName',
				title : '客户',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customerName;
				}
			},
			{
			    field : 'portEndName',
			    title : '目的港',
			    align : 'center',
			    sortable : true,
			    formatter : function(value, row, index){
			    	return row.portEndName;
			    }
			},
			{
				field : 'orderTypeName',
				title : '订单类型',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderTypeName;
				}
			},
			{
				field : 'orderShipDate',
				title : '出运期',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return dateFormatYMD(row.orderShipDate);
				}
			}
			 ] ],
			columns:[ [ 
			{
				field : 'currencyName',
				title : '币种',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.currencyName;
				}
			},
			{
				field : 'countryName',
				title : '国家',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			},
			{
			    field : 'deptName',
			    title : '经营体',
			    align : 'center',
			    sortable : true,
			    formatter : function(value, row, index){
			    	return row.deptName;
			    }
			},
			{
			    field : 'portStartName',
			    title : '始发港',
			    align : 'center',
			    sortable : true,
			    formatter : function(value, row, index){
			    	return row.portStartName;
			    }
			},
			{
				field : 'contractCode',
				title : '合同编号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.contractCode;
				}
			},
			{
				field : 'salesOrgName',
				title : '销售组织',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.salesOrgName;
				}
			},
			{
				field : 'vendorName',
				title : '船公司',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.vendorName;
				}
			} ,
			{
				field : 'orderDealName',
				title : '成交方式',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.orderDealName;
				}
			},
			{
				field : 'orderCustomDate',
				title : '要求到货期',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return dateFormatYMD(row.orderCustomDate);
				}
			},
			{
				field : 'orderPaymentTermsName',
				title : '付款条件',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.orderPaymentTermsName;
				}
			},
			{
				field : 'orderAuditFlag',
				title : '订单状态',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if(row.orderAuditFlag == null){
						return "订单待确认";
					}
					if(row.orderAuditFlag == 0){
						return "订单待审核";
					}
					if(row.orderAuditFlag == 1){
						return "订单审核完成";
					}
					if(row.orderAuditFlag == 3){
						return "调度单锁定";
					}
				}
			} ] ]
		});
		//完成的任务
		waitWorkFinishDatagrid = $('#waitWorkFinishDatagrid').datagrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!attachmentOrderFinishTask.action',
			pagination : true,
			pageList : [10],
			fit : true,
			nowrap : true,
			border : false,
			singleSelect : true,
			frozenColumns : [ [ 
			{
				field : 'orderCode',
				title : '订单编号',
				align : 'center',
				sortable : true,
				width:120,
				formatter : function(value, row, index) {
					return "<a href='javascript:void(0)' style='color:blue' onclick='orderDetailItem(\""+row.orderCode+"\",\""+row.orderType+"\")'> "+row.orderCode+"</a>";
				}
			},
			{
				field : 'orderPoCode',
				title : '客户订单号',
				align : 'center',
				sortable : true,
				width:120,
				formatter : function(value, row, index) {
					return row.orderPoCode;
				}
			},
			{
				field : 'customerName',
				title : '客户',
				align : 'center',
				sortable : true,
				width:200,
				formatter : function(value, row, index) {
					return row.customerName;
				}
			},
			{
			    field : 'portEndName',
			    title : '目的港',
			    align : 'center',
			    sortable : true,
			    width:150,
			    formatter : function(value, row, index){
			    	return row.portEndName;
			    }
			},
			{
				field : 'orderTypeName',
				title : '订单类型',
				align : 'center',
				sortable : true,
				width:90,
				formatter : function(value, row, index) {
					return row.orderTypeName;
				}
			},
			{
				field : 'orderShipDate',
				title : '出运期',
				align :'center',
				sortable : true,
				width:70,
				formatter : function(value, row, index){
					return dateFormatYMD(row.orderShipDate);
				}
			}
			] ],
			columns:[ [ 
			{
				field : 'currencyName',
				title : '币种',
				align :'center',
				sortable : true,
				width:90,
				formatter : function(value, row, index){
					return row.currencyName;
				}
			},
			{
				field : 'countryName',
				title : '国家',
				align : 'center',
				sortable : true,
				width:150,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			},
			{
			    field : 'deptName',
			    title : '经营体',
			    align : 'center',
			    sortable : true,
			    width:100,
			    formatter : function(value, row, index){
			    	return row.deptName;
			    }
			},
			{
			    field : 'portStartName',
			    title : '始发港',
			    align : 'center',
			    sortable : true,
			    width:70,
			    formatter : function(value, row, index){
			    	return row.portStartName;
			    }
			},
			{
				field : 'orderDealName',
				title : '成交方式',
				align :'center',
				sortable : true,
				width:54,
				formatter : function(value, row, index){
					return row.orderDealName;
				}
			},
			{
				field : 'orderPaymentTermsName',
				title : '付款条件描述',
				align :'center',
				sortable : true,
				width:150,
				formatter : function(value, row, index){
					return row.orderPaymentTermsName;
				}
			},
			{
				field : 'salesOrgName',
				title : '销售组织',
				align : 'center',
				sortable : true,
				width:150,
				formatter : function(value, row, index) {
					return row.salesOrgName;
				}
			},
			{
				field : 'contractCode',
				title : '合同编号',
				align : 'center',
				sortable : true,
				width:65,
				formatter : function(value, row, index) {
					return row.contractCode;
				}
			},
			{
				field : 'orderCustomDate',
				title : '要求到货期',
				align :'center',
				sortable : true,
				width:66,
				formatter : function(value, row, index){
					return dateFormatYMD(row.orderCustomDate);
				}
			},
			{
				field : 'vendorName',
				title : '船公司',
				align : 'center',
				sortable : true,
				width:100,
				formatter : function(value, row, index) {
					return row.vendorName;
				}
			} ,
			{
				field : 'orderAuditFlag',
				title : '订单状态',
				align : 'center',
				sortable : true,
				width:100,
				formatter : function(value, row, index) {
					if(row.orderAuditFlag == null){
						return "订单待确认";
					}
					if(row.orderAuditFlag == 0){
						return "订单待审核";
					}
					if(row.orderAuditFlag == 1){
						return "订单审核完成";
					}
					if(row.orderAuditFlag == 3){
						return "调度单锁定";
					}
				}
			} ] ]
		});
		
		//加载合同信息
		$('#contractCode').combobox({
 			url:'${dynamicURL}/salesOrder/salesOrderAction!selectContractInfo.do',
			valueField:'contractCode',  
		    textField:'contractCode'
		});
		//加载经营体信息
		$('#deptCode').combogrid({
			url:'${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=1',
			idField:'deptCode',  
		    textField:'deptNameCn',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_DEPT',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'deptCode',
				title : '经营体编号',
				width : 20
			},{
				field : 'deptNameCn',
				title : '经营体名称',
				width : 20
			}  ] ]
		});
		//加载目的港信息
		$('#portEndCode').combogrid({
		    url:'${dynamicURL}/basic/portAction!datagrid.action',
			idField:'portCode',  
		    textField:'portName',
			panelWidth : 500,
			panelHeight : 220,
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
				width : 20
			},{
				field : 'englishName',
				title : '目的港名称',
				width : 20
			}  ] ]
		});
		//加载国家信息
		$('#countryCode').combogrid({
			url:'${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 500,
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
				width : 20
			},{
				field : 'name',
				title : '国家名称',
				width : 20
			}  ] ]
		});
		//加载国家信息
		$('#countryCode').combogrid({
			url:'${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 500,
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
				width : 20
			},{
				field : 'name',
				title : '国家名称',
				width : 20
			}  ] ]
		});
		//加载经营体长信息
		$('#orderCustNamager').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectOrderCustManager.do',
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_CUST',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		}); 
		//加载产品经理信息
		$('#orderProdManager').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do',
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_PROD',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		}); 
		//加载订单执行经理信息
		$('#orderExecManager').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectOrderManagerByDept.do',
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_ORDER',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		}); 
		//加载订单类型
		$('#orderTypeName').combobox({
			url:'${dynamicURL}/basic/sysLovAction!orderTypeList.do?orderTypeFlag=1',
		    valueField: 'itemCode',
		    textField: 'itemNameCn',
		    panelWidth : 150,
		    panelHeight : 100,
		    multiple : true
		});
		//已完成订单确认的查询条件
		//加载合同信息
		$('#contractCodeFinish').combobox({
 			url:'${dynamicURL}/salesOrder/salesOrderAction!selectContractInfo.do',
			valueField:'contractCode',  
		    textField:'contractCode'
		});
		//加载经营体信息
		$('#deptCodeFinish').combogrid({
			url:'${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=1',
			idField:'deptCode',  
		    textField:'deptNameCn',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_DEPTHISTORY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'deptCode',
				title : '经营体编号',
				width : 20
			},{
				field : 'deptNameCn',
				title : '经营体名称',
				width : 20
			}  ] ]
		});
		//加载目的港信息
		$('#portEndCodeFinish').combogrid({
			 url:'${dynamicURL}/basic/portAction!datagrid.action',
				idField:'portCode',  
			    textField:'portName',
				panelWidth : 500,
				panelHeight : 220,
				pagination : true,
				pagePosition : 'bottom',
				toolbar : '#_PORTENDHISTORY',
				rownumbers : true,
				pageSize : 5,
				pageList : [ 5, 10 ],
				fit : true,
				fitColumns : true,
				columns : [ [ {
					field : 'portCode',
					title : '目的港编码',
					width : 20
				},{
					field : 'englishName',
					title : '目的港名称',
					width : 20
				}  ] ]
		});
		//加载国家信息
		$('#countryCodeFinish').combogrid({
			url:'${dynamicURL}/basic/countryAction!datagrid.do',
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
			},{
				field : 'name',
				title : '国家名称',
				width : 20
			}  ] ]
		});
		//加载经营体长信息
		$('#orderCustNamagerFinish').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectOrderCustManager.do',
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_CUSTHITORY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		}); 
		
		//加载产品经理信息
		$('#orderProdManagerFinish').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do',
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_PRODHISTORY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		}); 
		//加载订单执行经理信息
		$('#orderExecManagerFinish').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectOrderManagerByDept.do',
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_ORDERHISTORY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		}); 
		//加载订单类型
		$('#orderTypeNameFinish').combobox({
			url:'${dynamicURL}/basic/sysLovAction!orderTypeList.do?orderTypeFlag=1',
		    valueField: 'itemCode',
		    textField: 'itemNameCn',
		    panelWidth : 150,
		    panelHeight : 100,
		    multiple : true
		});
		
	});
	//模糊查询国家下拉列表
	function _CCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do?name='+ _CCNTEMP+'&countryCode='+_CCNCODE 
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询国家信息输入框
	function _CCNMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/countryAction!datagrid.do'
				});
	}
	//模糊查询目的港下拉列表
	function _PORTMY(inputId,inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/portAction!datagrid.do?englishName=' + _CCNTEMP+'&portCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询目的港信息输入框
	function _PORTMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/portAction!datagrid.do'
				});
	}
	//模糊查询经营体长下拉列表
	function _getCustManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderCustManager.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询经营体长下拉列表
	function _cleanCustManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderCustManager.do'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询产品经理下拉列表
	function _getProdManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询产品经理下拉列表
	function _cleanProdManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询订单经理下拉列表
	function _getOrderManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderManagerByDept.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询订单经理下拉列表
	function _cleanOrderManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderManagerByDept.do'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询经营体下拉列表
	function _getDeptMent(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=1&deptNameCn=' + _CCNTEMP+'&deptCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询经营体下拉列表
	function _cleanDeptMent(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=1'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
    //未完成代办查询
	function _search() {
		waitWorkDatagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	//未完成代办重置
	function cleanSearch() {
		waitWorkDatagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	//完成代办查询
	function _finishSearch() {
		waitWorkFinishDatagrid.datagrid('load', sy.serializeObject(checkFinishSearch));
	}
	//完成代办重置
	function FinishCleanSearch() {
		waitWorkFinishDatagrid.datagrid('load', {});
		checkFinishSearch.form('clear');
	}
	//跳转到备件订单确认页面
	function orderConfirm(orderCode, ordertypecode){
		orderConfirmAppid = parent.window.HROS.window.createTemp({
			appid:orderConfirmAppid,
			title:"备件订单确认",
		    url:'${dynamicURL}/salesOrder/salesOrderAction!goAttachmentOrderDetail.action?orderCode='+orderCode+'&orderType='+ordertypecode,
		    width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
	}
	//跳转到备件订单详情页面
	function orderDetailItem(orderCode, ordertypecode){
		parent.window.HROS.window.createTemp({
			title:"备件订单详细信息",
			url:'${dynamicURL}/salesOrder/salesOrderAction!goAttachmentOrderDetailItem.action?orderCode='+orderCode+'&orderType='+ordertypecode,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	//刷新代办和已完成代办
	function reloaddata() {
		waitWorkDatagrid.datagrid('reload');
		waitWorkFinishDatagrid.datagrid('reload');
		parent.window.showTaskCount();
	}
	
</script>
</head>
<body>
<div  class="easyui-tabs"  data-options="fit:true">
    <div title="备件订单确认待办">
        <div id="checkSearch" class="easyui-layout" data-options="fit:true">
             <div class="zoc" region="north" border="false"   collapsed="false" style="height: 110px; overflow: hidden;">
                 <form id="searchForm">
					<div class="part_zoc">
						<div class="oneline">
							<div class="item33">
								<div class="itemleft60">订单编号：</div>
								<div class="righttext">
									<input id="orderCode" name="dimOrderCode"  type="text"  class="short50"
										 />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft60">合同编号：</div>
								<div class="rightselect_easyui">
									<input id="contractCode" name="contractCode"  class="short50"  type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft60">订单经理：</div>
								<div class="rightselect_easyui">
								    <input id="orderExecManager" name="orderExecManager" class="short50"  type="text" />
								</div>
							</div>
						</div>
						<div class="oneline">
						    <div class="item33">
								<div class="itemleft60">产品经理：</div>
								<div class="rightselect_easyui">
									<input id="orderProdManager" name="orderProdManager" class="short50"  type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft60">经营体：</div>
								<div class="rightselect_easyui">
									<input id="deptCode" name="deptCode" class="short50"  type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft60">经营体长：</div>
								<div class="rightselect_easyui">
									<input id="orderCustNamager" name="orderCustNamager" class="short50"  type="text" />
								</div>
							</div>
						</div>
						<div class="oneline">
						       <div class="item33">
								<div class="itemleft60">国家：</div>
								<div class="rightselect_easyui">
									<input id="countryCode" name="countryCode" class="short50"  type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft60">目的港：</div>
								<div class="rightselect_easyui">
									<input id="portEndCode" name="portEndCode" class="short50"  type="text" />
								</div>
							</div>
						     <div class="item33">
								<div class="itemleft60">订单类型：</div>
								<div class="rightselect_easyui">
									<input id="orderTypeName" name="orderTypeName" class="short50"  type="text" />
								</div>
							</div>
						</div>
						<div class="item100">
					        <div class="oprationbutt">
						        <input type="button" value="查  询" onclick="_search();"/>
						        <input type="button" value="重  置"  onclick="cleanSearch();"/>
					       </div>
				        </div>
					</div>
				</form>
             </div>
             <div region="center" border="false">
				<table id="waitWorkDatagrid"></table>
			</div>
        </div>
    </div>
    <div title="已完成的备件订单确认">
        <div id="checkFinishSearchDIV" class="easyui-layout" data-options="fit:true">
            <div class="zoc" region="north" border="false"  collapsed="false" style="height: 110px; overflow: hidden;">
                <form id="checkFinishSearch">
					<div class="part_zoc">
						<div class="oneline">
							<div class="item33">
								<div class="itemleft60">订单编号：</div>
								<div class="righttext">
									<input id="orderCodeFinish" name="dimOrderCode"  class="short50"  type="text"
										 />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft60">合同编号：</div>
								<div class="rightselect_easyui">
									<input id="contractCodeFinish" name="contractCode"  class="short50"  type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft60">订单经理：</div>
								<div class="rightselect_easyui">
								    <input id="orderExecManagerFinish" name="orderExecManager" class="short50"  type="text" />
								</div>
							</div>
						</div>
						<div class="oneline">
						    <div class="item33">
								<div class="itemleft60">产品经理：</div>
								<div class="rightselect_easyui">
									<input id="orderProdManagerFinish" name="orderProdManager" class="short50"  type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft60">经营体：</div>
								<div class="rightselect_easyui">
									<input id="deptCodeFinish" name="deptCode" class="short50"  type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft60">经营体长：</div>
								<div class="rightselect_easyui">
									<input id="orderCustNamagerFinish" name="orderCustNamager" class="short50"  type="text" />
								</div>
							</div>
						</div>
						<div class="oneline">
						    <div class="item33">
								<div class="itemleft60">国家：</div>
								<div class="rightselect_easyui">
									<input id="countryCodeFinish" name="countryCode" class="short50"  type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft60">目的港：</div>
								<div class="rightselect_easyui">
									<input id="portEndCodeFinish" name="portEndCode" class="short50"  type="text" />
								</div>
							</div>
						    <div class="item33">
								<div class="itemleft60">订单类型：</div>
								<div class="rightselect_easyui">
									<input id="orderTypeNameFinish" name="orderTypeName" class="short50"  type="text" />
								</div>
							</div>
						</div>
						<div class="item100">
					        <div class="oprationbutt">
						        <input type="button" value="查  询" onclick="_finishSearch();"/>
						        <input type="button" value="重  置"  onclick="FinishCleanSearch();"/>
					       </div>
				        </div>
					</div>
				</form>
            </div>
            <div region="center" border="false">
			    <table id="waitWorkFinishDatagrid"></table>
		    </div>
        </div>
    </div>
</div>
	<!-- 国家下拉选 -->
	<div id="_COUNTRY">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="_COUNTRYCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCNMY('_COUNTRYCODE','_COUNTRYINPUT','countryCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('_COUNTRYCODE','_COUNTRYINPUT','countryCode')" />
				</div>
			</div>
		</div>
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
	<!-- 目的港下拉选信息 -->
	<div id="_PORTEND">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">目的港编号：</div>
				<div class="righttext">
					<input class="short50" id="_PORTCODEINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">目的港：</div>
				<div class="righttext">
					<input class="short60" id="_PORTINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_PORTMY('_PORTCODEINPUT','_PORTINPUT','portEndCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_PORTMYCLEAN('_PORTCODEINPUT','_PORTINPUT','portEndCode')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_PORTENDHISTORY">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">目的港编号：</div>
				<div class="righttext">
					<input class="short50" id="_PORTCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">目的港：</div>
				<div class="righttext">
					<input class="short60" id="_PORTINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_PORTMY('_PORTCODEHISTORY','_PORTINPUTHISTORY','portEndCodeFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_PORTMYCLEAN('_PORTCODEHISTORY','_PORTINPUTHISTORY','portEndCodeFinish')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 经营体长下拉选信息 -->
	<div id="_CUST">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_CUSTCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">经营体长：</div>
				<div class="righttext">
					<input class="short60" id="_CUSTINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getCustManager('_CUSTCODE','_CUSTINPUT','orderCustNamager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanCustManager('_CUSTCODE','_CUSTINPUT','orderCustNamager')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_CUSTHITORY">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_CUSTCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">经营体长：</div>
				<div class="righttext">
					<input class="short60" id="_CUSTINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getCustManager('_CUSTCODEHISTORY','_CUSTINPUTHISTORY','orderCustNamagerFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanCustManager('_CUSTCODEHISTORY','_CUSTINPUTHISTORY','orderCustNamagerFinish')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 产品经理下拉选信息 -->
	<div id="_PROD">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_PRODCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">产品经理：</div>
				<div class="righttext">
					<input class="short60" id="_PRODINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getProdManager('_PRODCODE','_PRODINPUT','orderProdManager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanProdManager('_PRODCODE','_PRODINPUT','orderProdManager')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_PRODHISTORY">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_PRODCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">产品经理：</div>
				<div class="righttext">
					<input class="short60" id="_PRODINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getProdManager('_PRODCODEHISTORY','_PRODINPUTHISTORY','orderProdManagerFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanProdManager('_PRODCODEHISTORY','_PRODINPUTHISTORY','orderProdManagerFinish')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 订单经理下拉选信息 -->
	<div id="_ORDER">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_ORDERMANAGERCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">订单经理：</div>
				<div class="righttext">
					<input class="short60" id="_ORDERMANAGERINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getOrderManager('_ORDERMANAGERCODE','_ORDERMANAGERINPUT','orderExecManager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanOrderManager('_ORDERMANAGERCODE','_ORDERMANAGERINPUT','orderExecManager')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_ORDERHISTORY">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_ORDERMANAGERCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">订单经理：</div>
				<div class="righttext">
					<input class="short60" id="_ORDERMANAGERINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getOrderManager('_ORDERMANAGERCODEHISTORY','_ORDERMANAGERINPUTHISTORY','orderExecManagerFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanOrderManager('_ORDERMANAGERCODEHISTORY','_ORDERMANAGERINPUTHISTORY','orderExecManagerFinish')" />
				</div>
			</div>
		</div>
	</div>
	<!-- 经营体下拉信息 -->
	<div id="_DEPT">
	    <div class="oneline">
		    <div class="item25">
				<div class="itemleft100">经营体编号：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">经营体名称：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getDeptMent('_DEPTMENTCODE','_DEPTMENTNAME','deptCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanDeptMent('_DEPTMENTCODE','_DEPTMENTNAME','deptCode')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_DEPTHISTORY">
	    <div class="oneline">
		    <div class="item25">
				<div class="itemleft100">经营体编号：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">经营体名称：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTNAMEHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getDeptMent('_DEPTMENTCODEHISTORY','_DEPTMENTNAMEHISTORY','deptCodeFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanDeptMent('_DEPTMENTCODEHISTORY','_DEPTMENTNAMEHISTORY','deptCodeFinish')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>