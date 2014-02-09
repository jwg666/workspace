<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var historyDatagrid;
	var orderCheckDialog;
	var orderCheckForm;
	var dialog;
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP
		});
		$('#' + inputId).val(_CCNTEMP);
	}

	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();

		searchHistoryForm = $('#searchHistoryForm').form();

		//custCodeId客户编号
		$('#custCodeId').combogrid({
			url : '../basic/customerAction!datagrid0.action',
			idField : 'customerId',
			textField : 'name',
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
				title : '客户编号',
				width : 10
			}, {
				field : 'name',
				title : '客户名称',
				width : 10
			} ] ]
		});
		$('#hiscustCodeId').combogrid({
			url : '../basic/customerAction!datagrid0.action',
			idField : 'customerId',
			textField : 'name',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_CNNQUERYHISTORY',
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
				title : '客户编号',
				width : 10
			}, {
				field : 'name',
				title : '客户名称',
				width : 10
			} ] ]
		});

		historyDatagrid = $("#orderHistoryList")
				.datagrid(
						{
							url : '${dynamicURL}/agentcybill/agentcyBillAction!havaHistoryTask.do',
							rownumbers : true,
							// 				pagination : true,
							// 				pagePosition : 'bottom',
							// 				rownumbers : true,
							// 				pageSize : 10,
							// 				pageList : [ 10, 20, 30, 40 ],
							fit : true,
							fitColumns : false,
							pagination : true,
							pageList : [ 10 ],
							nowrap : true,
							border : false,
							//idField : 'kdOrderId',
							
							scrollbarSize : 10,
							/* 			onDblClickRow : function(rowIndex, rowData) {
							 detailCheck(rowIndex);
							 }, */
							frozenColumns : [ [
									{
										field : 'ck',
										checkbox : true,
										formatter : function(value, row, index) {
											return row.kdOrderId;
										}
									},
									{
										field : 'orderCode',
										title : '订单号',
										align : 'center',

										width : 130,
										formatter : function(value, row, index) {

											return "<a href='javascript:void(0)' style='color:blue' onclick='detailCheck2(\""
													+ row.taskName
													+ "\",\""
													+ row.orderCode
													+ "\")'> "
													+ row.orderCode + "</a>";
										}
									},
									{
										field : 'taskName',
										title : '代办事项名称',
										align : 'center',
										width : 100,
										formatter : function(value, row, index) {
											return row.taskName;
										}
									},
									{
										field : 'orderType',
										title : '订单类型',
										align : 'center',
										width : 100,
										formatter : function(value, row, index) {
											return row.orderType;
										}
									},
									/* {
										field : 'contractCode',
										title : '合同编号',
										align : 'center',

										width : 100,
										formatter : function(value, row, index) {
											return row.contractCode;
										}
									} */
									/* {
										field : 'orderAuditFlag',
										title : '订单状态',
										align : 'center',

										width : 150,
										formatter : function(value, row, index) {
											if (row.orderAuditFlag = null) {
												return '订单补录';
											} else if (row.orderAuditFlag == '0') {
												return '订单确认';
											} else if (row.orderAuditFlag == '1') {
												return '顶大审核';
											} else if (row.orderAuditFlag == '3') {
												return '调度单锁定';
											} else if (row.orderAuditFlag == '4') {
												return '订单锁定';
											} else {
												return '订单状态无法识别';
											}
										}
									} */ 
									{
										field : 'orderShipDate',
										title : '出运期',
										align : 'center',

										width : 100,
										formatter : function(value, row, index) {
											return dateFormatYMD(row.orderShipDate);
										}
									},{
										field : 'invoiceNum',
										title : '出口发票号',
										align : 'center',

										width : 100,
										formatter : function(value, row, index) {
											return row.invoiceNum;
										}
									}
									] ],
							columns : [ [  {
								field : 'compreNum',
								title : '综合通知单号',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return row.compreNum;
								}
							},{
								field : 'CUST_DATE',
								title : '报关时间',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.CUST_DATE);
								}
							}, {
								field : 'orderCustomDate',
								title : '要求到货期',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.orderCustomDate);
								}
							}, {
								field : 'currency',
								title : '币种',
								align : 'center',

								width : 50,
								formatter : function(value, row, index) {
									return row.currency;
								}
							}, {
								field : 'paymentItems',
								title : '付款条件',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return row.paymentItems;
								}
							}, {
								field : 'saleOrgName',
								title : '销售组织',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.saleOrgName;
								}
							}, {
								field : 'orderPoCode',
								title : '客户订单号',
								align : 'center',

								width : 140,
								formatter : function(value, row, index) {
									return row.orderPoCode;
								}
							}, {
								field : 'deptName',
								title : '经营体',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.deptName;
								}
							}, {
								field : 'customerManager',
								title : '经营体长',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.customerManager;
								}
							}, {
								field : 'startPort',
								title : '始发港',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.startPort;
								}
							}, {
								field : 'endPort',
								title : '目的港',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.endPort;
								}
							}, {
								field : 'saleArea',
								title : '市场区域',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return '待定';
								}
							}, {
								field : 'customerName',
								title : '客户名称',
								align : 'center',
								width : 200,
								formatter : function(value, row, index) {
									return row.customerName;
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
								field : 'detailType',
								title : '成交方式',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.detailType;
								}
							}, {
								field : 'execmanagerName',
								title : '订单执行经理',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.execmanagerName;
								}
							}, {
								field : 'prodName',
								title : '产品经理',
								align : 'center',

								width : 80,
								formatter : function(value, row, index) {
									return row.prodName;
								}
							}, {
								field : 'transManager',
								title : '储运经理',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.transManager;
								}
							}, {
								field : 'docManager',
								title : '单证经理',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.docManager;
								}
							}, {
								field : 'recManager',
								title : '收汇经理',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.recManager;
								}
							} ,
							{
								field : 'trace',
								title : '流程追踪',
								align : 'center',
								width : 80,
								formatter : function(value, row, index) {
									return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg1("+index+")'>流程跟踪</a>";
								}
							}  ] ],
							onDblClickRow : function(rowIndex, rowData) {
								showDesc(rowData.orderCode);
							}
						});

		datagrid = $("#orderCheckList")
				.datagrid(
						{
							url : '${dynamicURL}/agentcybill/agentcyBillAction!haveagentcySchedule.do',
							rownumbers : true,
							// 				pagination : true,
							// 				pagePosition : 'bottom',
							// 				rownumbers : true,
							// 				pageSize : 10,
							// 				pageList : [ 10, 20, 30, 40 ],
							fit : true,
							fitColumns : false,
							pagination : true,
							pageList : [ 10 ],
							nowrap : true,
							border : false,
							//idField : 'kdOrderId',
							
							scrollbarSize : 10,
							/* 			onDblClickRow : function(rowIndex, rowData) {
							 detailCheck(rowIndex);
							 }, */
							toolbar : [ {
								text : '生成',
								iconCls : 'icon-check',
								handler : function() {
									detailCheck3();
								}
							}/* , '-', {
								text : '审核拒绝',
								iconCls : 'icon-check',
								handler : function() {
									quickCheckRefuse();
								}
							} */, '-', {
								text : '申领',
								iconCls : 'icon-apply',
								handler : function() {
									quickApply();
								}
							},'-',/* {
								text : '创建工作流',
								iconCls : 'icon-check',
								handler : function() {
									creatProcess();
								} 
							} */ ],
							frozenColumns : [ [
									{
										field : 'ck',
										checkbox : true,
										formatter : function(value, row, index) {
											return row.kdOrderId;
										}
									},
									{
										field : 'orderCode',
										title : '订单号',
										align : 'center',

										width : 130,
										formatter : function(value, row, index) {
											var img;
											if (row.assignee
													&& row.assignee != 'null') {
												img = "<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
											} else {
												img = "<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
											}
											return "<a href='javascript:void(0)' style='color:blue' onclick='detailCheck1(\""
													+ row.taskId
													+ "\",\""
													+ row.taskName
													+ "\",\""
													+ row.orderCode
													+ "\")'> "
													+ img
													+ row.orderCode
													+ "</a>";
										}
									},
									{
										field : 'taskName',
										title : '代办事项名称',
										align : 'center',
										width : 100,
										formatter : function(value, row, index) {
											return row.taskName;
										}
									},
									{
										field : 'orderType',
										title : '订单类型',
										align : 'center',
										width : 100,
										formatter : function(value, row, index) {
											return row.orderType;
										}
									},
									/* {
										field : 'contractCode',
										title : '合同编号',
										align : 'center',

										width : 100,
										formatter : function(value, row, index) {
											return row.contractCode;
										}
									} */
									/* {
										field : 'orderAuditFlag',
										title : '订单状态',
										align : 'center',

										width : 150,
										formatter : function(value, row, index) {
											if (row.orderAuditFlag = null) {
												return '订单补录';
											} else if (row.orderAuditFlag == '0') {
												return '订单确认';
											} else if (row.orderAuditFlag == '1') {
												return '顶大审核';
											} else if (row.orderAuditFlag == '3') {
												return '调度单锁定';
											} else if (row.orderAuditFlag == '4') {
												return '订单锁定';
											} else {
												return '订单状态无法识别';
											} 
											return row.orderAuditFlag;
										}
									} */
									{
										field : 'orderShipDate',
										title : '出运期',
										align : 'center',

										width : 100,
										formatter : function(value, row, index) {
											return dateFormatYMD(row.orderShipDate);
										}
									},{
										field : 'invoiceNum',
										title : '出口发票号',
										align : 'center',

										width : 100,
										formatter : function(value, row, index) {
											return row.invoiceNum;
										}
									}] ],
							columns : [ [ {
								field : 'compreNum',
								title : '综合通知单号',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return row.compreNum;
								}
							},{
								field : 'CUST_DATE',
								title : '报关时间',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.CUST_DATE);
								}
							}, {
								field : 'orderCustomDate',
								title : '要求到货期',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.orderCustomDate);
								}
							}, {
								field : 'currency',
								title : '币种',
								align : 'center',

								width : 50,
								formatter : function(value, row, index) {
									return row.currency;
								}
							}, {
								field : 'paymentItems',
								title : '付款条件',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return row.paymentItems;
								}
							}, {
								field : 'saleOrgName',
								title : '销售组织',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.saleOrgName;
								}
							}, {
								field : 'orderPoCode',
								title : '客户订单号',
								align : 'center',

								width : 140,
								formatter : function(value, row, index) {
									return row.orderPoCode;
								}
							}, {
								field : 'deptName',
								title : '经营体',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.deptName;
								}
							}, {
								field : 'customerManager',
								title : '经营体长',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.customerManager;
								}
							}, {
								field : 'startPort',
								title : '始发港',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.startPort;
								}
							}, {
								field : 'endPort',
								title : '目的港',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.endPort;
								}
							}, {
								field : 'saleArea',
								title : '市场区域',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return '待定';
								}
							}, {
								field : 'customerName',
								title : '客户名称',
								align : 'center',
								width : 200,
								formatter : function(value, row, index) {
									return row.customerName;
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
								field : 'detailType',
								title : '成交方式',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.detailType;
								}
							}, {
								field : 'execmanagerName',
								title : '订单执行经理',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.execmanagerName;
								}
							}, {
								field : 'prodName',
								title : '产品经理',
								align : 'center',

								width : 80,
								formatter : function(value, row, index) {
									return row.prodName;
								}
							}, {
								field : 'transManager',
								title : '储运经理',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.transManager;
								}
							}, {
								field : 'docManager',
								title : '单证经理',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.docManager;
								}
							}, {
								field : 'recManager',
								title : '收汇经理',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.recManager;
								}
							},
							{
								field : 'trace',
								title : '流程追踪',
								align : 'center',
								width : 80,
								formatter : function(value, row, index) {
									return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg("+index+")'>流程跟踪</a>";
								}
							} ] ],
							onDblClickRow : function(rowIndex, rowData) {
								showDesc(rowData.orderCode);
							}
						});
	});

	function _search() {
		$("#orderCheckList").datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		$("#orderCheckList").datagrid('load', {});
		searchForm.form('clear');
	}

	function _historySearch() {
		$("#orderHistoryList").datagrid('load',
				sy.serializeObject(searchHistoryForm));
	}
	function cleanHistorySearch() {
		$("#orderHistoryList").datagrid('load', {});
		searchHistoryForm.form('clear');
	}

	function detailCheck(rowIndex) {

		var obj = $("#orderCheckList").datagrid("getData").rows[rowIndex];
		//alert(obj.taskId);
		parent.window.HROS.window
				.createTemp({
					title : obj.taskName + "-订单号:" + obj.orderCode,
					url : "${dynamicURL}/courier/orderAction!goOrderCheck.do?aduitFlag=0&taskId="
							+ obj.taskId,
					width : 800,
					height : 400,
					isresize : false,
					isopenmax : true,
					isflash : false
				});
	}
	//启动一个工作流(暂时)
	function creatProcess() {
		var salesOrderCoder =$('#salseOrderCodeid').val();
		$.ajax({
			url : '${dynamicURL}/agentcybill/agentcyBillAction!create.do?',
			data : {
				orderNum : salesOrderCoder
			},
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('提示', data.msg, 'info');
				} else {
					$.messager.alert('提示', data.msg, 'info');
				}
			}
		});
	}
	function traceImg1(rowIndex){
		var obj=$("#orderHistoryList").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title:obj.taskName+"-订单号:"+obj.orderCode+"-流程图",
			url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+obj.processinstanceId,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	function traceImg(rowIndex){
		var obj=$("#orderCheckList").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title:obj.taskName+"-订单号:"+obj.orderCode+"-流程图",
			url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+obj.processinstanceId,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	function showDesc(orderCode) {
		parent.window.HROS.window.createTemp({
			title : "订单号:" + orderCode,
			url : "${dynamicURL}/salesOrder/salesOrderAction!goSalesOrderDetailItem.action?orderCode=" + orderCode,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false
		});
	}

	function hideCheckSearch() {
		$("#checkSearch").layout("collapse", "north");
	}
	function hideHistorySearch() {

		$("#historySearch").layout("collapse", "north");
	}
	//审核后的修改
	function detailCheck2(taskName,orderCode){
		parent.window.HROS.window.close('spcw_' + orderCode);
		var url = '${dynamicURL}/agentcybill/agentcyBillAction!goAgentcyBillcheck.action?orderNum=' + orderCode;
		//var url='techOrderAction!goModelManagerCheck.action';
		var appid = parent.window.HROS.window.createTemp({
			title : taskName + ":-代理出口结算清单:" + orderCode,
			url : url,
			appid : 'spcw_' + orderCode,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
	} 
	//生成代理结算清单
	function detailCheck1(taskId,taskName, orderCode) {
		//alert(taskId+':'+assignee+':'+taskName+':'+orderCode);
		$.ajax({
					url : '${dynamicURL}/workflow/scheduleUrlAndTitleAction!titleAndUrl.action',
					data : {
						taskId : taskId
					},
					dataType : 'json',
					cache : false,
					success : function(response) {
						parent.window.HROS.window.close('spcw_' + taskId);
						var url = '${dynamicURL}/' + response.url;
						//var url='techOrderAction!goModelManagerCheck.action';
						var appid = parent.window.HROS.window.createTemp({
							title : taskName + ":-代理结算清单:" + orderCode,
							url : url,
							appid : 'spcw_' + taskId,
							width : 800,
							height : 400,
							isresize : false,
							isopenmax : true,
							isflash : false,
							customWindow : window
						});
						//parent.window.HROS.window.close(appid);
					}
				});
	}
	function detailCheck4(orderCode){
		parent.window.HROS.window.close('dljs_' + orderCode);
		var url = '${dynamicURL}/agentcybill/agentcyBillAction!goAgentcyBillcheck.action?orderNum=' + orderCode;
		//var url='techOrderAction!goModelManagerCheck.action';
		var appid = parent.window.HROS.window.createTemp({
			title :"代理出口结算清单:" + orderCode,
			url : url,
			appid : 'dljs_' + orderCode,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
	} 
	//生成代理结算清单
	function detailCheck3() {
		//alert(taskId+':'+assignee+':'+taskName+':'+orderCode);
		var taskId;
		var taskName;
		var orderCode;
		var rows = datagrid.datagrid('getSelections');
		if(rows==null||rows.length==0){
			$.messager.alert('提示','请选中一条数据','warring');
			return;
		}else if(rows!=null&&rows.length>1){
			$.messager.alert('提示','只能选中一条数据','warring');
			return;
		}else if(rows!=null&&rows.length==1){
			taskId=rows[0].taskId;
			taskName=rows[0].taskName;
			orderCode=rows[0].orderCode;
		}else{
			$.messager.alert('提示','未知错误','warring');
		}
		$.ajax({
					url : '${dynamicURL}/workflow/scheduleUrlAndTitleAction!titleAndUrl.action',
					data : {
						taskId : taskId
					},
					dataType : 'json',
					cache : false,
					success : function(response) {
						parent.window.HROS.window.close('spcw_' + taskId);
						var url = '${dynamicURL}/' + response.url;
						//var url='techOrderAction!goModelManagerCheck.action';
						var appid = parent.window.HROS.window.createTemp({
							title : taskName + ":-代理结算清单:" + orderCode,
							url : url,
							appid : 'spcw_' + taskId,
							width : 800,
							height : 400,
							isresize : false,
							isopenmax : true,
							isflash : false,
							customWindow : window
						});
						//parent.window.HROS.window.close(appid);
					}
				});
	}
	//批量审核通过
	function quickCheck() {
		var rows = datagrid.datagrid('getSelections');
		var taskIds = '';
		if (rows.length > 1) {
			for ( var i = 0; i < rows.length; i++) {
				if (i != rows.length - 1)
					//将taskid和assignee封装起来传到后台
					taskIds = taskIds + "taskIds=" + rows[i].taskId + ":"
							+ rows[i].assignee + "&";
				else {
					taskIds = taskIds + "taskIds=" + rows[i].taskId + ":"
							+ rows[i].assignee;
				}
			}
			//任务的批量审核
			$.ajax({
				url : '${dynamicURL}/audit/auditMainAction!quickCheck.action',
				data : taskIds,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.show({
							title : '提示',
							msg : data.msg
						});
						reloaddata();
					} else {
						$.messager.alert('警告', data.msg, 'error');
					}
				}
			});
		} else if (rows.length == 1) {
			detailCheck1(rows[0].taskId, rows[0].assignee,rows[0].taskName,rows[0].orderCode);
		} else {
			$.messager.alert('提示', '请先选中要执行的任务', 'warring');
		}
	}
	//批量审核通过
	function quickCheckRefuse() {
		var rows = datagrid.datagrid('getSelections');
		var taskIds = '';
		if (rows.length > 1) {
			for ( var i = 0; i < rows.length; i++) {
				if (i != rows.length - 1)
					//将taskid和assignee封装起来传到后台
					taskIds = taskIds + "taskIds=" + rows[i].taskId + ":"
							+ rows[i].assignee + "&";
				else {
					taskIds = taskIds + "taskIds=" + rows[i].taskId + ":"
							+ rows[i].assignee;
				}
			}
			//任务的批量审核
			$
					.ajax({
						url : '${dynamicURL}/audit/auditMainAction!quickCheckRefuse.action',
						data : taskIds,
						dataType : 'json',
						success : function(data) {
							if (data.success) {
								$.messager.show({
									title : '提示',
									msg : data.msg
								});
								reloaddata();
							} else {
								$.messager.alert('警告', data.msg, 'error');
							}
						}
					});
		} else if (rows.length == 1) {
			detailCheck1(rows[0].taskId, rows[0].assignee);
		} else {
			$.messager.alert('提示', '请先选中要执行的任务', 'warring');
		}
	}
	//任务批量认领
	function quickApply() {
		var rows = datagrid.datagrid('getSelections');
		var taskIds = '';
		if (rows.length > 0) {
			for ( var i = 0; i < rows.length; i++) {
				if (i != rows.length - 1)
					taskIds = taskIds + "taskIds=" + rows[i].taskId + "&";
				else {
					taskIds = taskIds + "taskIds=" + rows[i].taskId;
				}
			}
			//任务的批量认领
			$.ajax({
				url : '${dynamicURL}/agentcybill/agentcyBillAction!haveTask.action',
				data : taskIds,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.show({
							title : '提示',
							msg : data.msg
						});
						datagrid.datagrid('reload');
					} else {
						$.messager.alert('警告', data.msg, 'error');
					}
				}
			});
		} else {
			$.messager.alert('提示', '请先选中要认领的任务', 'warring');
		}
	}
	//刷新代办和已完成代办
	function reloaddata() {
		datagrid.datagrid('reload');
		historyDatagrid.datagrid('reload');
	}
</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true">
		<div title="待生成代理结算清单">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">

				<div class="zoc" region="north" border="false" collapsible="true"
					title="查询" collapsed="true" style="height: 90px; overflow: hidden;">
					<form id="searchForm">
						<div class="oneline">
							<div class="item25">
								<div class="itemleft80">订单编号:</div>
								<div class="righttext_easyui">
									<input id="salseOrderCodeid" name="agentcyBillQuery.orderNum" type="text" class="short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">订单类型:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.orderType" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=0'" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">出口国家:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.outPutCountry" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'countryCode',textField:'name',url:'${dynamicURL}/basic/countryAction!combox.do'" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">经营体:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.deptCode" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'deptCode',textField:'deptNameCn',url:'${dynamicURL}/security/departmentAction!combox.do?deptType=1'" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft80">客户:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.custmorCode" type="text" id="custCodeId"
										class="short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">始发港:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.startPort" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=17'" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">目的港:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.endPort" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'portCode',textField:'portName',url:'${dynamicURL}/basic/portAction!combox.do'" />
								</div>
							</div>
							<div class="item25">
								<div class="oprationbutt">
									<input type="button" onclick="_search();" value="查  询" /> <input
										type="button" onclick="cleanSearch();" value="取消" />
								</div>
							</div>
						</div>
					</form>
				</div>

				<div region="center" border="false">
					<table id="orderCheckList"></table>
				</div>
				<div id="orderCheckDialog"
					style="display: none; width: 1280px; height: 610px;" align="center">
					<form id="orderCheckForm" method="post">
						<input type="hidden" name="kdOrderId" /> <input type="hidden"
							name="taskId" />

					</form>
				</div>
			</div>
		</div>

		<div title="已生成代理结算清单">
			<!--展开之后的content-part所显示的内容-->
			<div class="easyui-layout" fit="true" id="historySearch">
				<div class="zoc" region="north" border="false" collapsed="true"
					title="查询" style="height: 90px; overflow: hidden;">
					<form id="searchHistoryForm">
						<div class="oneline">
							<div class="item25">
								<div class="itemleft80">订单编号:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.orderNum" type="text" class=" short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">订单类型:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.orderType" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=0'" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">出口国家:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.outPutCountry" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'countryCode',textField:'name',url:'${dynamicURL}/basic/countryAction!combox.do'" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">经营体:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.deptCode" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'deptCode',textField:'deptNameCn',url:'${dynamicURL}/security/departmentAction!combox.do?deptType=1'" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft80">客户:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.custmorCode" type="text" id="hiscustCodeId"
										class=" short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">始发港:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.startPort" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=17'" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">目的港:</div>
								<div class="righttext_easyui">
									<input name="agentcyBillQuery.endPort" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'portCode',textField:'portName',url:'${dynamicURL}/basic/portAction!combox.do'" />
								</div>
							</div>
							<div class="item25">
								<div class="oprationbutt">
									<input type="button" onclick="_historySearch();" value="查  询" />
									<input type="button" onclick="cleanHistorySearch();" value="取消" />
								</div>
							</div>
						</div>
					</form>
				</div>

				<div region="center" border="false">
					<table id="orderHistoryList"></table>
				</div>


				<div id="iframeDialog"
					style="display: none; overflow: auto; width: 1200px; height: 500px;">
					<iframe name="iframe" id="iframe" src="#" scrolling="auto"
						frameborder="0" style="width: 100%; height: 99%;"> </iframe>
				</div>


				<div id="orderCheckDialog"
					style="display: none; width: 1280px; height: 610px;" align="center">
					<form id="orderCheckForm" method="post">
						<input type="hidden" name="kdOrderId" /> <input type="hidden"
							name="taskId" />

					</form>
				</div>
			</div>
		</div>




	</div>
	<div id="_CNNQUERY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPUT" type="text" />
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
	<div id="_CNNQUERYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPUTHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('_CNNINPUTHISTORY','hiscustCodeId')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>