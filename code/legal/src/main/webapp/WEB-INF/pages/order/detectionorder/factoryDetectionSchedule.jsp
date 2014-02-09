<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	/*
	 工厂新品处 首样质检 待办事项
	 */
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script src="${staticURL}/scripts/baiduTemplate.js"></script>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var detectionOrderAddDialog;
	var detectionOrderAddForm;
	var cdescAdd;
	var detectionOrderEditDialog;
	var detectionOrderEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	var lastIndex;
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		var _CCNTEMPID = $('#' + inputId + 'ID').val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP + '&customerId=' + _CCNTEMPID
		});
		$('#' + inputId).val(_CCNTEMP);
	}

	//模糊查询国家下拉列表
	function _CCNCOUNTRY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do?name=' + _CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	$(function() {
		//设置左分隔符为 <!
		baidu.template.LEFT_DELIMITER = '{%';

		//设置右分隔符为 <!  
		baidu.template.RIGHT_DELIMITER = '%}';
		//客户编号
		$('#CUSTOMER_CODE').combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
			textField : 'name',
			idField : 'customerId',
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
		//经营体
		$('#DEPT_CODE').combobox({
			url : '${dynamicURL}/security/departmentAction!combox.action?deptType=1',
			valueField : 'deptCode',
			textField : 'deptNameCn'
		});
		//工厂
		$('#factoryCode').combobox({
			url : '${dynamicURL}/security/departmentAction!combox.action?deptType=0',
			valueField : 'deptCode',
			textField : 'deptNameCn'
		});
		//加载国家信息
		$('#COUNTRY_CODE').combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do',
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
				width : 20,
				hidden : true
			}, {
				field : 'name',
				title : '国家名称',
				width : 20
			} ] ]
		});
		//市场区域
		$('#SALE_AREA').combobox({
			url : '${dynamicURL}/basic/sysLovAction!combox.action?itemType=3',
			valueField : 'itemCode',
			textField : 'itemNameCn'
		});
		//客户编号
		$('#CUSTOMER_CODE0').combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
			textField : 'name',
			idField : 'customerId',
			panelWidth : 600,
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
				width : 20
			}, {
				field : 'name',
				title : '客户名称',
				width : 20
			} ] ]
		});
		//经营体
		$('#DEPT_CODE0').combobox({
			url : '${dynamicURL}/security/departmentAction!combox.action?deptType=1',
			valueField : 'deptCode',
			textField : 'deptNameCn'
		});
		//工厂
		$('#factoryCode0').combobox({
			url : '${dynamicURL}/security/departmentAction!combox.action?deptType=0',
			valueField : 'deptCode',
			textField : 'deptNameCn'
		});

		//加载国家信息
		$('#COUNTRY_CODE0').combogrid({
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
				width : 20,
				hidden : true
			}, {
				field : 'name',
				title : '国家名称',
				width : 20
			} ] ]
		});
		//市场区域
		$('#SALE_AREA0').combobox({
			url : '${dynamicURL}/basic/sysLovAction!combox.action?itemType=3',
			valueField : 'itemCode',
			textField : 'itemNameCn'
		});
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid(
				{
					url : 'detectionOrderAction!factoryNPSchedule.action?dataSharding=37&DefinitionKey=factoryDetection&taskId=' + $("#taskId").val(),
					title : '首样质检表列表',
					iconCls : 'icon-save',
					pagination : true,
					pagePosition : 'bottom',
					rownumbers : true,
					pageSize : 10,
					pageList : [ 10, 20, 30, 40 ],
					fit : true,
					fitColumns : false,
					nowrap : true,
					border : false,
					frozenColumns : [ [
							{
								field : 'ck',
								checkbox : true
							},
							{
								field : 'orderCode',
								title : '订单号',
								width : 120,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									var img;
									if (row.assignee && row.assignee != 'null') {
										img = "<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
									} else {
										img = "<img width='16px' height='16px' title='未申领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
									}

									return img + "<a href='javascript:void(0)' id='tooltip_" + row.orderCode
											+ "' class=\"easyui-tooltip\" style='color:blue'   onclick='showDesc(\"" + row.orderCode + "\",\"" + row.taskId
											+ "\")' >" + row.orderCode + "</a>";
								}
							}, {
								field : 'factoryName',
								title : '工厂',
								width : 200,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.factoryName;
								}
							}, {
								field : 'statusCode',
								title : '付款状态',
								width : 100,
								align : 'center',
								sortable : true
							}, {
								field : 'result',
								title : '首样结论',
								width : 100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									if (value == "1") {
										return '通过';
									} else if (value == "0") {
										return '不通过';
									} else {
										row[index].result = "1";
										return '通过'
									}
								}
							} ] ],
					columns : [ [ {
						field : 'marketName',
						title : '市场区域',
						width : 100,
						align : 'center',
						sortable : true
					}, {
						field : 'jingyingti',
						title : '经营体',
						width : 100,
						align : 'center',
						sortable : true
					}, {
						field : 'fsDate',
						title : '样机日期',
						align : 'center',
						width : 150,
						sortable : true,
						formatter : function(value, row, index) {
							return dateFormatYMD(value);
						}
					}, {
						field : 'taskId',
						title : 'taskId',
						hidden : true,
						align : 'center',
						sortable : true
					}, {
						field : 'ordertypename',
						title : '订单类型',
						width : 100,
						align : 'center',
						formatter : function(value, row, index) {
							return row.ordertypename;
						}
					}, {
						field : 'contractcode',
						title : '合同编号',
						width : 100,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.contractcode;
						}
					}, {
						field : 'ordershipdate',
						title : '出运期',
						width : 150,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return dateFormatYMD(row.ordershipdate);
						}
					}, {
						field : 'ordercustomdate',
						title : '要求到货期',
						width : 150,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return dateFormatYMD(row.ordercustomdate);
						}
					}, {
						field : 'dealtypename',
						title : '成交方式',
						width : 100,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.dealtypename;
						}
					}, {
						field : 'currencyname',
						title : '币种',
						width : 100,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.currencyname;
						}
					}, {
						field : 'termsdesc',
						title : '付款条件',
						width : 150,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.termsdesc;
						}
					}, {
						field : 'salesorgname',
						title : '销售组织',
						width : 200,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.salesorgname;
						}
					}, {
						field : 'countryname',
						title : '国家',
						width : 200,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.countryname;
						}
					}, {
						field : 'customername',
						title : '客户',
						width : 200,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.customername;
						}
					}, {
						field : 'ordersourcecode',
						title : '客户订单号',
						width : 100,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.ordersourcecode;
						}
					}, {
						field : 'portstartname',
						title : '始发港',
						align : 'center',
						width : 100,
						sortable : true,
						formatter : function(value, row, index) {
							return row.portstartname;
						}
					}, {
						field : 'portendname',
						title : '目的港',
						align : 'center',
						width : 200,
						sortable : true,
						formatter : function(value, row, index) {
							return row.portendname;
						}
					}, {
						field : 'vendorname',
						title : '船公司',
						width : 200,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.vendorname;
						}
					}, {
						field : 'dueDate',
						title : '计划完成时间',
						width : 100,
						align : 'center',
						sortable : true
					}, {
						field : 'trace',
						title : '流程追踪',
						width : 100,
						align : 'center',
						width : 80,
						formatter : function(value, row, index) {
							return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg(" + index + ")'>流程跟踪</a>";
						}
					} ] ],
					toolbar : [
							{
								text : '批量完成首样质检',
								iconCls : 'icon-add',
								handler : function() {
									//以下代码可以改成ajax同步，由于时间紧急还未更改
									datagrid.datagrid('endEdit', lastIndex);
									var rows = datagrid.datagrid('getSelections');
									if (rows.length >= 1) {
										$.messager.confirm('提示', '默认物料毛重体积信息与实际没有差异，如有差异，需要先维护实测信息。确认完成首样质检？', function(b) {
											if (b) {
												var orderCodes = '';
												for ( var i = 0; i < rows.length; i++) {
													//检验实测与系统总毛重、体积差异超过+-5%
													if (i < rows.length - 1) {
														orderCodes = orderCodes + 'orderCodes=' + rows[i].orderCode + '&';
													} else {
														orderCodes = orderCodes + 'orderCodes=' + rows[i].orderCode;
													}
												}
												$
														.ajax({
															url : 'detectionOrderAction!confirmWeightAndVolume.action',
															dataType : 'json',
															data : orderCodes,
															success : function(response) {
																$.messager.progress('close');
																if (!(response.success)) {
																	//输出那些订单的那个物料 的那个数据差异超标
																	var msg = '以下订单的物料信息的实测与系统总毛重、体积差异超过+-5%，请更改MDM数据，是否完成首样质检任务？<br/>';
																	var orderConfirmArray = response.obj;
																	for ( var i = 0; i < orderConfirmArray.length; i++) {
																		var materialArray = orderConfirmArray[i];
																		for ( var j = 0; j < materialArray.length; j++) {
																			var objTemp = materialArray[j]
																			msg = msg + '订单号：' + objTemp.orderCode + '，物料号：' + objTemp.materialCode;
																			if (!objTemp.zongmaozhongFlag) {
																				//总毛重差异过大
																				msg = msg
																						+ '，默认毛重：'
																						+ objTemp.maozhong
																						+ '，实测毛重：'
																						+ objTemp.shicemaozhong
																						+ '，差异：'
																						+ (Math.abs((objTemp.shicemaozhong - objTemp.maozhong)
																								/ objTemp.maozhong) * 100).toFixed(3) + '%';
																			}
																			if (!objTemp.zongtijiFlag) {
																				//总体积差异过大
																				msg = msg
																						+ '，默认体积：'
																						+ objTemp.tiji
																						+ '，实测体积：'
																						+ objTemp.shicetiji
																						+ '，差异：'
																						+ (Math.abs((objTemp.shicetiji - objTemp.tiji) / objTemp.tiji) * 100)
																								.toFixed(3) + '%';
																			}
																			msg = msg + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;';
																		}
																	}
																	$.messager.confirm('提示', msg, function(r) {
																		if (r) {
																			//完成任务
																			//获得选择订单的首样结论，传到后台，完成任务的同时保存首样结论
																			taskIds = '';
																			orderNums = '';
																			result = '{"jsonDetection":[';
																			var len = rows.length;
																			for ( var i = 0; i < len; i++) {
																				var temp = '{"taskId":"' + rows[i].taskId + '","orderNum":"'
																						+ rows[i].orderCode + '","result":"' + rows[i].result
																						+ '","assignee":"' + rows[i].assignee + '"}';
																				if (i == len - 1) {
																					result = result + temp;
																				} else {
																					result = result + temp + ',';
																				}
																			}
																			result = result + ']}';
																			//数据传入后台
																			$.ajax({
																				url : 'detectionOrderAction!completeDetection.action',
																				data : {
																					"jsonDetection" : result
																				},
																				dataType : 'json',
																				success : function(response) {
																					$.messager.progress('close');
																					if (response && response.success) {
																						$.messager.alert('提示', '完成首样质检成功', 'info', function() {
																						});
																					} else {
																						var msg = '以下订单首样质检失败<br/>';
																						if (response.obj !== null && response.obj.length != 0) {
																							var rl = response.obj;
																							for ( var i = 0; i < rl.length; i++) {
																								msg = msg + '订单号：' + rl[i].orderCode + '，错误原因：'
																										+ rl[i].exceptionMsg + '<br/>';
																							}
																						}
																						$.messager.alert('错误', msg, 'info');
																					}
																					datagrid.datagrid('reload');
																					datagridHistory.datagrid('reload');
																					top.window.showTaskCount()
																				},
																				beforeSend : function() {
																					$.messager.progress();
																				}
																			});
																		}
																	});
																} else {
																	//完成任务
																	//获得选择订单的首样结论，传到后台，完成任务的同时保存首样结论
																	taskIds = '';
																	orderNums = '';
																	result = '{"jsonDetection":[';
																	var len = rows.length;
																	for ( var i = 0; i < len; i++) {
																		var temp = '{"taskId":"' + rows[i].taskId + '","orderNum":"' + rows[i].orderCode
																				+ '","result":"' + rows[i].result + '","assignee":"' + rows[i].assignee + '"}';
																		if (i == len - 1) {
																			result = result + temp;
																		} else {
																			result = result + temp + ',';
																		}
																	}
																	result = result + ']}';
																	//数据传入后台
																	$.ajax({
																		url : 'detectionOrderAction!completeDetection.action',
																		data : {
																			"jsonDetection" : result
																		},
																		dataType : 'json',
																		success : function(response) {
																			$.messager.progress('close');
																			if (response && response.success) {
																				$.messager.alert('提示', '完成首样质检成功', 'info', function() {
																				});
																			} else {
																				var msg = '以下订单首样质检失败<br/>';
																				if (response.obj !== null && response.obj.length != 0) {
																					var rl = response.obj;
																					for ( var i = 0; i < rl.length; i++) {
																						msg = msg + '订单号：' + rl[i].orderCode + '，错误原因：' + rl[i].exceptionMsg
																								+ '<br/>';
																					}
																				}
																				$.messager.alert('错误', msg, 'info');
																			}
																			datagrid.datagrid('reload');
																			datagridHistory.datagrid('reload');
																			top.window.showTaskCount()
																		},
																		beforeSend : function() {
																			$.messager.progress();
																		}
																	});
																}
															},
															beforeSend : function() {
																$.messager.progress();
															}
														});

											}
										});
									} else {
										$.messager.alert('提示', '请选择一条记录', 'info');
									}
								}
							}, '-', {
								text : '申领',
								iconCls : 'icon-remove',
								handler : function() {
									quickApply()
								}
							}, '-', {
								text : '录入实测信息',
								iconCls : 'icon-remove',
								handler : function() {
									showSY(true);
								}
							}, '-', {
								text : '取消选中',
								iconCls : 'icon-undo',
								handler : function() {
									datagrid.datagrid('unselectAll');
								}
							}, '-' ],
					onLoadSuccess : function(data) {
						$("a[id^='tooltip_']").tooltip({
							position : 'bottom',
							content : '正在加载物料信息...',
							deltaX : 90,
							onShow : function(e) {
								var tooltip = $(this);
								var orderCode = tooltip.attr("id").replace("tooltip_", "");
								$.ajax({
									url : "${dynamicURL}/salesOrder/salesOrderItemAction!combox.do",
									data : {
										orderCode : orderCode
									},
									dataType : "json",
									type : 'post',
									success : function(data) {
										var temp = {};
										temp["data"] = data;
										var messageHtml = baidu.template('itemList_Template', temp);
										tooltip.tooltip('update', messageHtml);
									}
								});
							}
						});
					}
				});

		datagridHistory = $('#datagridHistory').datagrid({
			url : 'detectionOrderAction!queryFactoryHistoryTask.action?dataSharding=37&DefinitionKey=factoryDetection',
			title : '首样质检表列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			nowrap : true,
			border : false,
			
			toolbar : [ {
				text : '更改实测信息',
				iconCls : 'icon-remove',
				handler : function() {
					showSY(false);
				}
			} ],
			frozenColumns : [ [ {
				field : 'taskId',
				title : 'taskId',
				align : 'center',
				hidden : true,
				sortable : true
			}, {
				field : 'orderCode',
				width : 100,
				title : '订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return '<a  style="color:blue"  onclick="showDesc(\'' + row.orderCode + '\')" href="#">' + value + '</a>';
				}
			}, {
				field : 'factoryName',
				title : '工厂',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'result',
				title : '首样结论',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (value == "1") {
						return '通过';
					} else if (value == "0") {
						return '不通过';
					} else {
						row[index].result = "1";
						return '通过'
					}
				}
			} ] ],
			columns : [ [ {
				field : 'marketName',
				title : '市场区域',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'jingyingti',
				title : '经营体',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'statusCode',
				title : '付款状态',
				width : 100,
				align : 'center',
				sortable : true
			}, {
				field : 'fsDate',
				title : '样机日期',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(value);
				}
			}, {
				field : 'ordertypename',
				title : '订单类型',
				width : 100,
				align : 'center',
				formatter : function(value, row, index) {
					return row.ordertypename;
				}
			}, {
				field : 'contractcode',
				title : '合同编号',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.contractcode;
				}
			}, {
				field : 'ordershipdate',
				title : '出运期',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.ordershipdate);
				}
			}, {
				field : 'ordercustomdate',
				title : '要求到货期',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.ordercustomdate);
				}
			}, {
				field : 'dealtypename',
				title : '成交方式',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.dealtypename;
				}
			}, {
				field : 'currencyname',
				title : '币种',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.currencyname;
				}
			}, {
				field : 'termsdesc',
				title : '付款条件',
				align : 'center',
				width : 150,
				sortable : true,
				formatter : function(value, row, index) {
					return row.termsdesc;
				}
			}, {
				field : 'salesorgname',
				title : '销售组织',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.salesorgname;
				}
			}, {
				field : 'countryname',
				title : '国家',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.countryname;
				}
			}, {
				field : 'customername',
				title : '客户',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customername;
				}
			}, {
				field : 'ordersourcecode',
				title : '客户订单号',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.ordersourcecode;
				}
			}, {
				field : 'portstartname',
				title : '始发港',
				align : 'center',
				width : 100,
				sortable : true,
				formatter : function(value, row, index) {
					return row.portstartname;
				}
			}, {
				field : 'portendname',
				title : '目的港',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.portendname;
				}
			}, {
				field : 'vendorname',
				title : '船公司',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.vendorname;
				}
			}, {
				field : 'detectionWidth',
				title : '实测宽(mm)',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return value;
				}
			}, {
				field : 'detectionLenth',
				title : '实测深(mm)',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return value;
				}
			}, {
				field : 'detectionHigh',
				title : '实测高(mm)',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return value;
				}
			}, {
				field : 'detectionNetWeight',
				title : '实测净重',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return value;
				}
			}, {
				field : 'detectionGrossWeight',
				title : '实测毛重',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return value;
				}
			}, {
				field : 'prodQuantity',
				title : '物料数量',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return value;
				}
			}, {
				field : 'detectionColume',
				title : '实测总体积(mm<sup>3</sup>)',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return value;
				}
			}, {
				field : 'detectionColumeSingle',
				title : '实测单台体积(mm<sup>3</sup>)',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return value;
				}
			}, {
				field : 'materialCode',
				title : '物料编号',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return value;
				}
			} ] ]
		});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function _searchHistory() {
		$("#datagridHistory").datagrid('load', sy.serializeObject($("#searchFormHistory")));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function cleanSearchHistory() {
		$("datagridHistory").datagrid('load', {});
		$("#searchFormHistory").form('clear');
	}

	//测试用，待删除
	function createTask() {
		$.ajax({
			url : 'detectionOrderAction!createTask.action',
			dataType : 'json',
			method : 'post',
			success : function(response) {
				if (response && response.success) {
					$.messager.alert('提示', response.msg, 'info', function() {
					});
				} else {
					$.messager.alert('提示', '流程创建失败', 'info', function() {
					});
				}
			}
		});
	}
	//申领
	function quickApply() {
		var rows = $("#datagrid").datagrid('getSelections');
		var taskIds = "";
		if (rows.length > 0) {
			if (!(rows[0].assignee && rows[0].assignee != 'null')) {
				$.messager.confirm('提示', '您要申领当前任务？', function(r) {
					if (r) {
						for ( var i = 0; i < rows.length; i++) {
							if (i != rows.length - 1) {
								taskIds = taskIds + "taskIds=" + rows[i].taskId + "&";
							} else {
								taskIds = taskIds + "taskIds=" + rows[i].taskId;
							}
						}
						$.ajax({
							url : 'detectionOrderAction!haveTask.action',
							data : taskIds,
							dataType : 'json',
							type : "post",
							success : function(response) {
								$("#datagrid").datagrid('load');
								$("#datagrid").datagrid('unselectAll');
								$.messager.show({
									title : '提示',
									msg : response.msg
								});
							}
						});
					}
				});
			} else {
				$.messager.alert('提示', '已经是您的任务，无需申领！', 'error');
			}
		} else {
			$.messager.alert('提示', '请选择要申领的订单！', 'error');
		}
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
	function showSY(isSchedule) {
		var rows;
		if(isSchedule){
			rows = datagrid.datagrid('getSelections');
		}else{
			rows = datagridHistory.datagrid('getSelections');
		}
		if (rows.length == 1) {
			parent.window.HROS.window.createTemp({
				title : "订单号:" + rows[0].orderCode,
				url : "${dynamicURL}/detectionOrder/detectionOrderAction!goSYselectAndAdd.action?orderCode=" + rows[0].orderCode + "&assignee="
						+ rows[0].assignee + "&taskId=" + rows[0].taskId,
				width : 800,
				height : 400,
				isresize : false,
				isopenmax : true,
				isflash : false
			});
		} else {
			$.messager.alert('提示', '请选择一条订单记录', 'info');
		}
	}

	function traceImg(rowIndex) {
		var obj = $("#datagrid").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title : obj.name + "-订单号:" + obj.orderCode + "-流程图",
			url : "${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId=" + obj.procInstId,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false
		});
	}
</script>
</head>
<body>
	<div class="easyui-tabs" data-options="fit:true">
		<s:hidden name="taskId" id="taskId" />
		<div title="待质检订单列表">
			<div class="easyui-layout" fit="true">
				<div region="north" border="false" collapsed="true" title="查询"
					class="zoc" style="height: 150px; overflow: hidden;"
					collapsible="true" collapsed="true">
					<form id="searchForm">
						<div class="part_zoc">
							<div class="oneline">
								<div class="item33">
									<div class='itemleft'>订单号：</div>
									<div class="righttext">
										<input name="salesOrderQuery.orderCode"
											class='orderAutoComple' />
									</div>
								</div>
								<div class="item33">
									<div class='itemleft'>经营体：</div>
									<div class="righttext">
										<input type="text" class="easyui-combobox short100"
											id="DEPT_CODE" name="salesOrderQuery.deptCode"></input>
									</div>
								</div>
								<div class="item33">
									<div class='itemleft'>工厂：</div>
									<div class="righttext">
										<input type="text" class="easyui-combobox short100"
											id="factoryCode" name="salesOrderQuery.factoryCode"></input>
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item33">
									<div class="itemleft">出口国家：</div>
									<div class="righttext">
										<input type="text" class="easyui-combobox short100"
											id="COUNTRY_CODE" name="salesOrderQuery.countryCode"></input>
									</div>
								</div>
								<div class="item33 lastitem">
									<div class="itemleft">市场区域：</div>
									<div class="righttext">
										<input type="text" class="easyui-combobox short100"
											id="SALE_AREA" name="salesOrderQuery.saleArea"></input>
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item33">
									<div class="itemleft">客户名称：</div>
									<div class="righttext">
										<input type="text" class="easyui-combobox short100"
											id="CUSTOMER_CODE" name="salesOrderQuery.orderSoldTo"></input>
									</div>
								</div>
								<div class="item33 lastitem">
									<div class="itemleft">任务类型：</div>
									<div class="righttext">
										<select name="taskType" class="easyui-combobox">
											<option value="">全部</option>
											<option value="my">个人任务</option>
											<option value="group">组任务</option>
										</select>
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item100">
									<div class="oprationbutt">
										<input type="button" onclick="_search();" value="查询" /><input
											type="button" onclick="cleanSearch();" value="清空" />
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="datagrid"></table>
				</div>
			</div>
		</div>
		<div title="历史任务">
			<div class="easyui-layout" fit="true">
				<div region="north" border="false" collapsed="true" title="查询"
					class="zoc" style="height: 150px; overflow: hidden;"
					collapsible="true" collapsed="true">
					<form id="searchFormHistory">
						<div class="part_zoc">
							<div class="oneline">
								<div class="item33">
									<div class='itemleft'>订单号：</div>
									<div class="righttext">
										<input name="salesOrderQuery.orderCode" />
									</div>
								</div>
								<div class="item33">
									<div class='itemleft'>经营体：</div>
									<div class="righttext">
										<input type="text" class="easyui-combobox short100"
											id="DEPT_CODE0" name="salesOrderQuery.deptCode"></input>
									</div>
								</div>
								<div class="item33">
									<div class='itemleft'>工厂：</div>
									<div class="righttext">
										<input type="text" class="easyui-combobox short100"
											id="factoryCode0" name="salesOrderQuery.factoryCode"></input>
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item33">
									<div class="itemleft">出口国家：</div>
									<div class="righttext">
										<input type="text" class="easyui-combobox short100"
											id="COUNTRY_CODE0" name="salesOrderQuery.countryCode"></input>
									</div>
								</div>
								<div class="item33 lastitem">
									<div class="itemleft">市场区域：</div>
									<div class="righttext">
										<input type="text" class="easyui-combobox short100"
											id="SALE_AREA0" name="salesOrderQuery.saleArea"></input>
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item33 lastitem">
									<div class="itemleft">客户名称：</div>
									<div class="righttext">
										<input type="text" class="easyui-combobox short100"
											id="CUSTOMER_CODE0" name="salesOrderQuery.orderSoldTo"></input>
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item100 lastitem">
									<div class="oprationbutt">
										<input type="button" onclick="_searchHistory();" value="查询" /><input
											type="button" onclick="cleanSearchHistory();" value="清空" />
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="datagridHistory"></table>
				</div>
			</div>
		</div>
	</div>
	<div id="_CNNQUERY">
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
						onclick="_CCNMY('_CNNINPUT','CUSTOMER_CODE')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_CNNQUERYHISTORY">
		<div class="oneline">
			<div class="item33">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short30" id="_CNNINPUTHISTORYID" type="text" />
				</div>
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short30" id="_CNNINPUTHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('_CNNINPUTHISTORY','CUSTOMER_CODE0')" />
				</div>
			</div>
		</div>
	</div>
	<!-- 国家下拉选 -->
	<div id="_COUNTRY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNCOUNTRY('_COUNTRYINPUT','COUNTRY_CODE')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_COUNTRYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUTHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNCOUNTRY('_COUNTRYINPUTHISTORY','COUNTRY_CODE0')" />
				</div>
			</div>
		</div>
	</div>

	<script id='itemList_Template' type="text/template">
		<table cellspacing="0" cellpadding="0" style="width: 350px;padding: 0;margin: 0" class="table2">
			<tbody><tr>
				<th style="height: 23px;">海尔型号</th>
				<th style="height: 23px;">客户型号</th>
				<th style="height: 23px;">物料号</th>
				<th style="height: 23px;">特技单号</th>
				<th style="height: 23px;">数量</th>
			</tr>

		{%  for(var i=0;i<data.length;i++){ %}
			<tr class="bgc1">
				<td>{%= data[i].haierModel %}</td>
				<td>{%= data[i].customerModel %}</td>
				<td>{%= data[i].materialCode %}</td>
				<td>{%= data[i].affirmNum %}</td>
				<td>{%= data[i].prodQuantity %}</td>
			</tr>
		
		{% }  %}

		</tbody></table>
</script>
</body>
</html>