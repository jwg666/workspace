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
	var wentidatagridid;
	var wentiform;
	var orderProblemDialog;
	//查询客户
	function _CCNMER(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}

	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
  
		searchHistoryForm = $('#searchHistoryForm').form();
		wentiform=$('#wentiformid').form();
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
        
		//加载国家信息
		$('#countryIdtask').combogrid({
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
		$('#countryIdHistory').combogrid({
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
		
		//加载经营体信息
		$('#deptIdTask').combogrid({
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
		 
		//加载经营体信息
		$('#deptIdHistory').combogrid({
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
		$('#endPortIdtask').combogrid({
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
		
		//加载目的港信息
		$('#endPortIdHistory').combogrid({
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
		
		historyDatagrid = $("#orderHistoryList")
				.datagrid(
						{
							url : '${dynamicURL}/audit/auditMainAction!bussinessManagerFinishedSchedule.do?',
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

										width : 100,
										formatter : function(value, row, index) {

											return "<a href='javascript:void(0)' style='color:blue' onclick='detailCheck2(\""
													+ row.taskName
													+ "\",\""
													+ row.orderCode
													+ "\")'> "
													+ row.orderCode + "</a>";
										}
									}/* ,
									{
										field : 'taskName',
										title : '代办事项名称',
										align : 'center',
										width : 100,
										formatter : function(value, row, index) {
											return row.taskName;
										}
									} */,
									{
										field : 'ifMaoyi',
										title : '是否贸易公司',
										align : 'center',
										width : 100,
										formatter : function(value, row, index) {
											if(row.ifMaoyi!=null&&row.ifMaoyi=='1'){
												return "是";
											}else{
												return "否";
											}
										}
									},
									{
										field : 'contractCode',
										title : '合同编号',
										align : 'center',

										width : 100,
										formatter : function(value, row, index) {
											return row.contractCode;
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
									{
										field : 'bussinessManagerName',
										title : '审核人',
										align : 'center',
										width : 70,
										formatter : function(value, row, index) {
											return row.bussinessManagerName;
										}
									}
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
									} */ ] ],
							columns : [ [  {
								field : 'comments',
								title : '订单备注',
								align : 'center',
								width : 90,
								formatter : function(value, row, index) {
									if(row.comments!=null&&row.comments!=''){
										var comm='';
										if(row.comments.length>4){
											comm=row.comments.substring(0,4)+'...';
											return "<a href='javascript:void(0)' id='tooltip_y"
											+ row.orderCode
											+ "'  style='color:blue' class='easyui-tooltip'  >"+comm+"</a>";
										}else{
											return row.comments;
										}
										
									}else{
										return ''
									}
									
									
								}
							},{
								field : 'container',
								title : '箱型箱量',
								align : 'center',
								width : 200,
								formatter : function(value, row, index) {
									return row.container;
								}
							},{
								field : 'orderShipDate',
								title : '出运期',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.orderShipDate);
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

								width : 200,
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
							}/* , {
								field : 'saleArea',
								title : '市场区域',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return '待定';
								}
							} */, {
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
							},
							onLoadSuccess : function(data) {
								$("a[id^='tooltip_y']").tooltip(
												{
													position : 'bottom',
													content:'正在加载...',
													deltaX:90,
													onShow:function(e){
														var tooltip=$(this);
														var orderCode=tooltip.attr("id").replace("tooltip_y","");
														var dd=getCommenthis(orderCode);
														//alert(dd);
														var messageHtml='<div>'+dd+'<div>'
														tooltip.tooltip('update',messageHtml);
													}
												});
							},
							toolbar:[
							          {
								text : '导出',
								iconCls : 'icon-check',
								handler : function() {
									exportHistory();
								}
							          } ]
						});

		datagrid = $("#orderCheckList")
				.datagrid(
						{
							url : '${dynamicURL}/audit/auditMainAction!bussinessManagerSchedule.do',
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
								text : '审核通过',
								iconCls : 'icon-check',
								handler : function() {
									quickCheck();
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
							}  , '-', {
								text : '导出',
								iconCls : 'icon-check',
								handler : function() {
									exportSchedule();
								} 
							} , '-' ],
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

										width : 100,
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
													+ row.assignee
													+ "\",\""
													+ row.taskName
													+ "\",\""
													+ row.orderCode
													+ "\")'> "
													+ img
													+ row.orderCode
													+ "</a>";
										}
									},{
										field : 'dueDate',
										title : '计划完成时间',
										align : 'center',
										width : 100,
										formatter : function(value, row, index) {
											return dateFormatYMD(row.dueDate);
										}
									}/* ,
									{
										field : 'taskName',
										title : '代办事项名称',
										align : 'center',
										width : 100,
										formatter : function(value, row, index) {
											return row.taskName;
										}
									} */,
									{
										field : 'ifMaoyi',
										title : '是否贸易公司',
										align : 'center',
										width : 100,
										formatter : function(value, row, index) {
											if(row.ifMaoyi!=null&&row.ifMaoyi=='1'){
												return "是";
											}else{
												return "否";
											}
										}
									},
									{
										field : 'contractCode',
										title : '合同编号',
										align : 'center',

										width : 100,
										formatter : function(value, row, index) {
											return row.contractCode;
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
									}
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
									} */ ] ],
							columns : [ [  
							               {
								field : 'comments',
								title : '订单备注',
								align : 'center',
								width : 90,
								formatter : function(value, row, index) {
									if(row.comments!=null&&row.comments!=''){
										var comm='';
										if(row.comments.length>4){
											comm=row.comments.substring(0,4)+'...';
											return "<a href='javascript:void(0)' id='tooltip_i"
											+ row.orderCode
											+ "'  style='color:blue' class='easyui-tooltip'  >"+comm+"</a>";
										}else{
											return row.comments;
										}
										
									}else{
										return ''
									}
									
									
								}
							},{
								field : 'auditlogOrdernum',
								title : '问题查看',
								align : 'center',
								width : 200,
								formatter : function(value, row, index) {
									if(row.auditlogOrdernum!=null&&row.auditlogOrdernum!=''){
										return "<a href='javascript:void(0)' style='color:blue' onclick='showwentidata(\""+row.auditlogOrdernum+"\")'>查看问题</a>";
									}else{
										return "正常订单";
									}
								}
							},{
								field : 'container',
								title : '箱型箱量',
								align : 'center',
								width : 200,
								formatter : function(value, row, index) {
									return row.container;
								}
							},{
								field : 'customerName',
								title : '客户(SOLD_TO)',
								align : 'center',
								width : 200,
								formatter : function(value, row, index) {
									return row.customerName;
								}
							},{
								field : 'shipTo',
								title : 'SHIP_TO',
								align : 'center',
								width : 200,
								formatter : function(value, row, index) {
									return row.shipTo;
								}
							},{
								field : 'createDate',
								title : '创建日期',
								align : 'center',
								width : 100,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.createDate);
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
								field : 'shipment',
								title : '运输方式',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return row.shipment;
								}
							},{
								field : 'orderShipDate',
								title : '出运期',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.orderShipDate);
								}
							},{
								field : 'payResult',
								title : '付款状态',
								align : 'center',

								width : 70,
								formatter : function(value, row, index) {
									if(row.payResult!=null&&row.payResult=='1'){
										return '完成';
									}else{
										return '未完成';
									}
									//return row.payResult;
								}
							},{
								field : 'beihuo',
								title : '备货状态',
								align : 'center',

								width : 70,
								formatter : function(value, row, index) {
										return '未完成';
									//return row.payResult;
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
							},{
								field : 'shipname',
								title : '船公司',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return row.shipname;
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
								field : 'yunFei',
								title : '运费(原币)',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return Number(row.yunFei).toFixed(4);
								}
							}, {
								field : 'baoFei',
								title : '保费(原币)',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									return Number(row.baoFei).toFixed(4);
								}
							}, {
								field : 'amount',
								title : '金额(原币)',
								align : 'center',

								width : 100,
								formatter : function(value, row, index) {
									
									return Number(row.amount).toFixed(4);
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
								field : 'operators',
								title : '经营主体',
								align : 'center',

								width : 150,
								formatter : function(value, row, index) {
									return row.operators;
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

								width : 200,
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
							},  {
								field : 'countryName',
								title : '出口国家',
								align : 'center',

								width : 80,
								formatter : function(value, row, index) {
									return row.countryName;
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
							} ] ],onLoadSuccess : function(data) {
								$("a[id^='tooltip_i']").tooltip(
										{
											position : 'bottom',
											content:'正在加载...',
											deltaX:90,
											onShow:function(e){
												var tooltip=$(this);
												var orderCode=tooltip.attr("id").replace("tooltip_i","");
												var dd=getComment(orderCode);
												//alert(dd);
												var messageHtml='<div>'+dd+'<div>'
												tooltip.tooltip('update',messageHtml);
											}
										});
					},
							onDblClickRow : function(rowIndex, rowData) {
								showDesc(rowData.orderCode);
							}
						});
		
		wentidatagridid = $("#wentidatagridid")
		.datagrid(
				{
					url : '${dynamicURL}/audit/auditLogAction!datagrid0.do',
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
					scrollbarSize : 10,
					frozenColumns : [ [  {
						field : 'orderNum',
						title : '订单号',
						align : 'center',
						width : 100,
						formatter : function(value, row, index) {
							return "<a href='javascript:void(0)' style='color:blue' onclick='detailCheck3(\""
							+ row.orderNum
							+ "\")'> "
							+ row.orderNum + "</a>";
						}
					},{
						field : 'comments',
						title : '订单备注',
						align : 'center',
						width : 90,
						formatter : function(value, row, index) {
							if(row.comments!=null&&row.comments!=''){
								var comm='';
								if(row.comments.length>4){
									comm=row.comments.substring(0,4)+'...';
									return "<a href='javascript:void(0)' id='tooltip_b"
									+ row.orderNum
									+ "'  style='color:blue' class='easyui-tooltip'  >"+comm+"</a>";
								}else{
									return row.comments;
								}
								
							}else{
								return ''
							}
							
							
						}
					},{
						field : 'rejectionName',
						title : '意见人',
						align : 'center',
						width : 200,
						formatter : function(value, row, index) {
							return row.rejectionName;
						}
					},{
						field : 'rejectionDate',
						title : '意见日期',
						align : 'center',
						width : 150,
						formatter : function(value, row, index) {
							return row.rejectionDate;
							//return dateFormatYMD(row.rejectionDate);
						}
					},{
						field : 'rejection',
						title : '意见',
						align : 'center',
						width : 500,
						formatter : function(value, row, index) {
							return row.rejection;
						}
					} ] ],onLoadSuccess : function(data) {
						$("a[id^='tooltip_b']").tooltip(
								{
									position : 'bottom',
									content:'正在加载...',
									deltaX:90,
									onShow:function(e){
										var tooltip=$(this);
										var orderCode=tooltip.attr("id").replace("tooltip_b","");
										var dd=getCommentb(orderCode);
										//alert(dd);
										var messageHtml='<div>'+dd+'<div>'
										tooltip.tooltip('update',messageHtml);
									}
								});
			},
					onDblClickRow : function(rowIndex, rowData) {
						showDesc(rowData.orderNum);
					},
					toolbar:[{
							text : '导出',
							iconCls : 'icon-check',
							handler : function() {
								exportWenti();
							} 
					}]
				});
		//订单问题查看
		orderProblemDialog = $('#orderProblemDialog').show().dialog({
			title : '订单问题',
			modal : true,
			closable : true,
			maximizable : true,
			width : 750,
			height : 300,
			buttons : [{
				text : '关闭',
				iconCls : 'icon-cancel',
				handler : function() {
					orderProblemDialog.dialog('close');
				}
			}]
		});
		orderProblemDialog.dialog('close');
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
		var salesOrderCoder = '0000014674';
		$.ajax({
			url : '${dynamicURL}/audit/auditMainAction!create.do?',
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
		parent.window.HROS.window.close('zhps_wc' + orderCode);
		var url = '${dynamicURL}/audit/auditMainAction!showResultOfReview0.action?orderNum=' + orderCode;
		//var url='techOrderAction!goModelManagerCheck.action';
		var appid = parent.window.HROS.window.createTemp({
			title : taskName + ":-订单综合评审单:" + orderCode,
			url : url,
			appid : 'zhps_wc' + orderCode,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
	} 
	//审核后的修改
	function detailCheck3(orderCode){
		parent.window.HROS.window.close('zhps_wc' + orderCode);
		var url = '${dynamicURL}/audit/auditMainAction!showResultOfReview0.action?orderNum=' + orderCode;
		//var url='techOrderAction!goModelManagerCheck.action';
		var appid = parent.window.HROS.window.createTemp({
			title : "订单综合评审单:" + orderCode,
			url : url,
			appid : 'zhps_wc' + orderCode,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
	} 
	//审核
	function detailCheck1(taskId, assignee, taskName, orderCode) {
		//alert(taskId+':'+assignee+':'+taskName+':'+orderCode);
		$
				.ajax({
					url : '${dynamicURL}/workflow/scheduleUrlAndTitleAction!titleAndUrl.action',
					data : {
						taskId : taskId
					},
					dataType : 'json',
					cache : false,
					success : function(response) {
						parent.window.HROS.window.close('zhps_' + taskId);
						var url = '${dynamicURL}/' + response.url;
						//var url='techOrderAction!goModelManagerCheck.action';
						var appid = parent.window.HROS.window.createTemp({
							title : taskName + ":-订单综合评审单:" + orderCode,
							url : url,
							appid : 'zhps_' + taskId,
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
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			    });
			//任务的批量审核
			$.ajax({
				url : '${dynamicURL}/audit/auditMainAction!quickCheck.action',
				data : taskIds,
				dataType : 'json',
				success : function(data) {
					$.messager.progress('close');
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
				url : '${dynamicURL}/audit/auditMainAction!haveTask.action',
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
		wentidatagridid.datagrid('reload');
		top.window.showTaskCount();
	}
	//问题订单查询
	function wentiSearch(){
		$("#wentidatagridid").datagrid('load', sy.serializeObject(wentiform));
	}
	function cleanWentiSearch(){
		wentiform.form('clear');
		$("#wentidatagridid").datagrid('load',sy.serializeObject(wentiform));
	}
	//模糊查询国家下拉列表
	function _CCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.action?name='+ _CCNTEMP+'&countryCode='+_CCNCODE 
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
	//导出代办
	function exportSchedule() {
		var codes='';
		var rows = datagrid.datagrid('getSelections');
		if(rows!=null&&rows.length>0){
			for ( var i = 0; i < rows.length; i++) {
				codes=codes+rows[i].orderCode+','
			}
		} /* else{
			$.messager.alert('提示','请选中需要导出的数据','warring');
			return;
		}  */
		$('#codesdaochu').val(codes);
		$("#searchForm").form('submit', {
			url : 'auditMainAction!exportSchedule.action'
		});
	}
	//导出已办理
	function exportHistory() {
		var codes='';
		var rows = historyDatagrid.datagrid('getSelections');
		if(rows!=null&&rows.length>0){
			for ( var i = 0; i < rows.length; i++) {
				codes=codes+rows[i].orderCode+','
			}
		}/* else{
			$.messager.alert('提示','请选中需要导出的数据','warring');
			return;
		} */
		$('#historydaochu').val(codes);
		$("#searchHistoryForm").form('submit', {
			url : 'auditMainAction!exportHistory.action'
		});
	}
	//到处完成
	function exportWenti(){
		$("#wentiformid").form('submit', {
			url : 'auditLogAction!exportWenti.action'
		});
	}
	//查看问题订单的问题信息
	function showwentidata(orderNum){
		//alert(orderNum);
		$('#problemDatagrid').datagrid({queryParams: {orderNum: orderNum} });
		orderProblemDialog.dialog('open');
	}
	//根据订单好获得列表中订单的备注
	function getCommenthis(orderCode){
		var rows=historyDatagrid.datagrid('getRows');
		if(rows!=null&&rows.length>0){
			for(var i=0;i<rows.length;i++){
				if(rows[i].orderCode==orderCode){
					return rows[i].comments;
				}
			}
		}else{
			return '';
		}
		return '';
	}
	//根据订单好获得列表中订单的备注
	function getComment(orderCode){
		var rows=datagrid.datagrid('getRows');
		if(rows!=null&&rows.length>0){
			for(var i=0;i<rows.length;i++){
				if(rows[i].orderCode==orderCode){
					return rows[i].comments;
				}
			}
		}else{
			return '';
		}
		return '';
	}
	//问题订单beizhu
	function getCommentb(orderCode){
		var rows=wentidatagridid.datagrid('getRows');
		if(rows!=null&&rows.length>0){
			for(var i=0;i<rows.length;i++){
				if(rows[i].orderNum==orderCode){
					return rows[i].comments;
				}
			}
		}else{
			return '';
		}
		return '';
	}
</script>
</head>
<jsp:include page="orderProblem.jsp" />
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true">
		<div title="订单审核">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">

				<div class="zoc" region="north" border="false" collapsible="true"
					title="查询" collapsed="true" style="height: 90px; overflow: hidden;">
					<form id="searchForm">
					<input type="hidden" name="typQua" id="codesdaochu"/>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft80">订单编号:</div>
								<div class="righttext_easyui">
									<input name="salseOrderCode" type="text" class="short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">订单类型:</div>
								<div class="righttext_easyui">
									<input name="orderType" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=0'" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">出口国家:</div>
								<div class="righttext_easyui">
									<input name="outPutCountry" type="text" id="countryIdtask"
										class="short50"
										 />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">经营体:</div>
								<div class="righttext_easyui">
									<input name="deptCode" type="text" id="deptIdTask"
										class="short50"
										 />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft80">客户:</div>
								<div class="righttext_easyui">
									<input name="custmorCode" type="text" id="custCodeId"
										class="short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">始发港:</div>
								<div class="righttext_easyui">
									<input name="startPort" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=17'" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">目的港:</div>
								<div class="righttext_easyui">
									<input name="endPort" type="text"
										class="short50" id="endPortIdtask"
										 />
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
				<!-- <div id="orderCheckDialog"
					style="display: none; width: 1280px; height: 610px;" align="center">
					<form id="orderCheckForm" method="post">
						<input type="hidden" name="kdOrderId" /> <input type="hidden"
							name="taskId" />

					</form>
				</div> -->
			</div>
		</div>

		<div title="已完成审核">
			<!--展开之后的content-part所显示的内容-->
			<div class="easyui-layout" fit="true" id="historySearch">
				<div class="zoc" region="north" border="false" collapsed="true"
					title="查询" style="height: 90px; overflow: hidden;">
					<form id="searchHistoryForm">
					<input type="hidden" name="typQua" id="historydaochu"/>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft80">订单编号:</div>
								<div class="righttext_easyui">
									<input name="salseOrderCode" type="text" class=" short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">订单类型:</div>
								<div class="righttext_easyui">
									<input name="orderType" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=0'" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">出口国家:</div>
								<div class="righttext_easyui">
									<input name="outPutCountry" type="text" id="countryIdHistory"
										class="short50"
										 />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">经营体:</div>
								<div class="righttext_easyui">
									<input name="deptCode" type="text" id="deptIdHistory"
										class="short50"
										 />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft80">客户:</div>
								<div class="righttext_easyui">
									<input name="custmorCode" type="text" id="hiscustCodeId"
										class=" short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">始发港:</div>
								<div class="righttext_easyui">
									<input name="startPort" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=17'" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">目的港:</div>
								<div class="righttext_easyui">
									<input name="endPort" type="text"
										class="short50" id="endPortIdHistory"
										/>
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


				<!-- <div id="iframeDialog"
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
				</div> -->
			</div>
		</div>
        <div title="问题订单">
			<!--展开之后的content-part所显示的内容-->
			<div class="easyui-layout" fit="true" id="historySearch">
				<div class="zoc" region="north" border="false" collapsed="true"
					title="查询" style="height: 70px; overflow: hidden;">
					<form id="wentiformid">
						<div class="oneline">
							<div class="item25">
								<div class="itemleft80">订单编号:</div>
								<div class="righttext_easyui">
									<input name="orderNum" type="text" class=" short50" />
								</div>
							</div>
							<div class="item25">
								<div class="oprationbutt">
									<input type="button" onclick="wentiSearch();" value="查  询" />
									<input type="button" onclick="cleanWentiSearch();" value="取消" />
								</div>
							</div>
						</div>
					</form>
				</div>

				<div region="center" border="false">
					<table id="wentidatagridid"></table>
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
						onclick="_CCNMER('_CNNINPUT','custCodeId')" />
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
						onclick="_CCNMER('_CNNINPUTHISTORY','hiscustCodeId')" />
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
						onclick="_CCNMY('_COUNTRYCODE','_COUNTRYINPUT','countryIdtask')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('_COUNTRYCODE','_COUNTRYINPUT','countryIdtask')" />
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
						onclick="_CCNMY('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryIdHistory')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryIdHistory')" />
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
						onclick="_getDeptMent('_DEPTMENTCODE','_DEPTMENTNAME','deptIdTask')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanDeptMent('_DEPTMENTCODE','_DEPTMENTNAME','deptIdTask')" />
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
						onclick="_getDeptMent('_DEPTMENTCODEHISTORY','_DEPTMENTNAMEHISTORY','deptIdHistory')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanDeptMent('_DEPTMENTCODEHISTORY','_DEPTMENTNAMEHISTORY','deptIdHistory')" />
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
						onclick="_PORTMY('_PORTCODEINPUT','_PORTINPUT','endPortIdtask')" />
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
						onclick="_PORTMY('_PORTCODEHISTORY','_PORTINPUTHISTORY','endPortIdHistory')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_PORTMYCLEAN('_PORTCODEHISTORY','_PORTINPUTHISTORY','endPortIdHistory')" />
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>