<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	//工厂检验处待办事项列表
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
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
	$(function() {
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
		//出口国家或地区countryCodeId
		$('#COUNTRY_CODE').combobox({
			url : '${dynamicURL}/basic/countryAction!combox.action',
			valueField : 'countryCode',
			textField : 'name'
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
		//出口国家或地区countryCodeId
		$('#COUNTRY_CODE0').combobox({
			url : '${dynamicURL}/basic/countryAction!combox.action',
			valueField : 'countryCode',
			textField : 'name'
		});
		//市场区域
		$('#SALE_AREA0').combobox({
			url : '${dynamicURL}/basic/sysLovAction!combox.action?itemType=3',
			valueField : 'itemCode',
			textField : 'itemNameCn'
		});
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'detectionOrderAction!factoryNPSchedule.action?dataSharding=47&DefinitionKey=factoryCheck&taskId=' + $("#taskId").val(),
			title : '质量合格证',
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
			
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true
			}, {
				field : 'taskId',
				title : 'taskId',
				align : 'center',
				hidden : true,
				sortable : true
			}, {
				field : 'orderCode',
				title : '订单号',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					var img;
					if (row.assignee && row.assignee != 'null') {
						img = "<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
					} else {
						img = "<img width='16px' height='16px' title='未申领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
					}
					return img + "<a href='javascript:void(0)' onclick=\"showDesc(\'" + row.orderCode + "\')\" style='color:blue' >" + row.orderCode + "</a>";
				}
			}, {
				field : 'factoryName',
				title : '工厂',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'qualifiedDate',
				title : '质量合格日期',
				width : 200,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					var d = new Date(value);
					return d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
				}
			}, {
				field : 'result',
				title : '质量合格结论',
				align : 'center',
				width : 100,
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
				field : 'jingyingti',
				title : '经营体',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'countryname',
				title : '出口国家',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'marketName',
				title : '市场区域',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'custName',
				title : '客户名称',
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
				width : 100,
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
				width : 100,
				align : 'center',
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
				field : 'dueDate',
				title : '计划完成时间',
				width : 100,
				align : 'center',
				sortable : true
			},{
				field : 'trace',
				title : '流程追踪',
				width : 100,
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg(" + index + ")'>流程跟踪</a>";
				}
			} ] ],
			toolbar : [ {
				text : '完成质量合格',
				iconCls : 'icon-remove',
				handler : function() {
					complete();
				}
			}, '-', {
				text : '申领',
				iconCls : 'icon-remove',
				handler : function() {
					quickApply()
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ]
		});

		datagridHistory = $('#datagridHistory').datagrid({
			url : 'detectionOrderAction!queryFactoryHistoryTask.action?dataSharding=47&DefinitionKey=factoryCheck',
			title : '质量合格证',
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
			
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true
			}, {
				field : 'taskId',
				title : 'taskId',
				align : 'center',
				hidden : true,
				sortable : true
			}, {
				field : 'orderCode',
				title : '订单号',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					var img;
					if (row.assignee && row.assignee != 'null') {
						img = "<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
					} else {
						img = "<img width='16px' height='16px' title='未申领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
					}
					return img + "<a href='javascript:void(0)' onclick=\"showDesc(\'" + row.orderCode + "\')\" style='color:blue' >" + row.orderCode + "</a>";
				}
			}, {
				field : 'factoryName',
				title : '工厂',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'qualifiedDate',
				title : '质量合格日期',
				align : 'center',
				width : 200,
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.qualifiedDate)
				}
			} ] ],
			columns : [ [ {
				field : 'taskId',
				title : 'taskId',
				hidden : true,
				align : 'center',
				sortable : true
			}, {
				field : 'jingyingti',
				title : '经营体',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'countryname',
				title : '出口国家',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'marketName',
				title : '市场区域',
				width : 200,
				align : 'center',
				sortable : true
			}, {
				field : 'custName',
				title : '客户名称',
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
				field : 'result',
				title : '质量合格结论',
				align : 'center',
				width : 75,
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
				align : 'center',
				width : 200,
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.ordershipdate);
				}
			}, {
				field : 'ordercustomdate',
				title : '要求到货期',
				align : 'center',
				width : 200,
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
				width : 200,
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
			} ] ],
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
		$("#datagridHistory").datagrid('load', {});
		$("#searchFormHistory").form('clear');
	}

	function createTask() {
		$.ajax({
			url : 'detectionOrderAction!createTask0.action',
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
			$.messager.alert('提示', '请选择要申领的特技单！', 'error');
		}
	}

	function showDesc(orderCode) {
		parent.window.HROS.window.createTemp({
			title : "订单号:" + orderCode,
			url : "${staticURL}/../salesOrder/salesOrderAction!panoramaShow.action?orderCode=" + orderCode,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false
		});
	}
	//完成任务
	function complete() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('提示', '确认完成质量合格证？', function(r) {
				if (r) {
					taskIds = '';
					orderNums = '';
					result = '{"jsonDetection":[';
					var len = rows.length;
					for ( var i = 0; i < len; i++) {
						var temp = '{"taskId":"' + rows[i].taskId + '","orderNum":"' + rows[i].orderCode + '","result":"' + rows[i].result + '","assignee":"'
								+ rows[i].assignee + '"}';
						if (i == len - 1) {
							result = result + temp;
						} else {
							result = result + temp + ',';
						}
					}
					result = result + ']}';
					//数据传入后台
					$.ajax({
						url : 'detectionOrderAction!completeCheck.action',
						data : {
							"jsonDetection" : result
						},
						dataType : 'json',
						success : function(response) {
							if (response && response.success) {
								$.messager.alert('提示', '完成质量合格成功', 'info', function() {
								});
							} else {
								$.messager.alert('提示', '完成质量合格未全部成功，任务可能已经被别人申领，请刷新列表', 'error', function() {
								});
							}
							refreshDatagrid();
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择一条订单记录', 'info', function() {
			})
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
	//展示订单明细
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
	function refreshDatagrid() {
		datagrid.datagrid('reload');
		datagridHistory.datagrid('reload');
		top.window.showTaskCount();
	}
</script>
</head>
<body>
	<div class="easyui-tabs" data-options="fit:true">
		<s:hidden name="taskId" id="taskId"></s:hidden>
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
								<div class="item33">
									<div class="itemleft">客户名称：</div>
									<div class="righttext">
										<input type="text" class="easyui-combobox short100"
											id="CUSTOMER_CODE0" name="salesOrderQuery.orderSoldTo"></input>
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
</body>
</html>