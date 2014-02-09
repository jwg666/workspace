<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var iframeDialog;
	var searchHistoryForm;
	var historydatagrid;
	var orderDetailAppid = null;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid')
				.datagrid(
						{
							url : 'schedulePlanAction!schedulePlanTaskdatagrid.do?definitionKey=scheduling&taskId='+'${taskId}',
							title : '排定计划<span style="color:red;">（单击订单号显示订单明细）</span>',
							iconCls : 'icon-save',
							pagination : true,
							checkOnSelect : false,
							selectOnCheck : false,
							singleSelect : true,
							pagePosition : 'bottom',
							rownumbers : true,
							pageSize : 10,
							pageList : [ 10, 20, 30, 40 ],
							height : 250,
							//fitColumns : true,
							fit : true,
							border : false,
							frozenColumns : [ [
									{
										field : 'ck',
										checkbox : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.index;
										}
									},
									{
										field : 'ordercode',
										title : '订单号',
										align : 'center',
										width : 100,
										sortable : true,
										formatter : function(value, row, index) {
											var img;
											if (row.assignee
													&& row.assignee != 'null') {
												img = "<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
											} else {
												img = "<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
											}
											return '<a onclick="detailCheck(\''
													+ row.ordercode
													+ '\')" style="color: blue;" >'
													+ img + row.ordercode
													+ '</a>';
										}
									},
									{
										field : 'ordertypename',
										title : '订单类型',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.ordertypename;
										}
									},
									{
										field : 'factoryproducename',
										title : '生产工厂',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.factoryproducename;
										}
									},
									{
										field : 'contractcode',
										title : '合同编号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.contractcode;
										}
									} ] ],
							columns : [ [ {
								field : 'ordershipdate',
								title : '出运期',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.ordershipdate);
								}
							}, {
								field : 'ordercustomdate',
								title : '要求到货期',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.ordercustomdate);
								}
							}, {
								field : 'dealtypename',
								title : '成交方式',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.dealtypename;
								}
							}, {
								field : 'currencyname',
								title : '币种',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.currencyname;
								}
							}, {
								field : 'termsdesc',
								title : '付款条件',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.termsdesc;
								}
							}, {
								field : 'salesorgname',
								title : '销售组织',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.salesorgname;
								}
							}, {
								field : 'countryname',
								title : '国家',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.countryname;
								}
							}, {
								field : 'customername',
								title : '客户',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.customername;
								}
							}, {
								field : 'ordersourcecode',
								title : '客户订单号',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.ordersourcecode;
								}
							}, {
								field : 'departmentname',
								title : '经营体',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.departmentname;
								}
							}, {
								field : 'portstartname',
								title : '始发港',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.portstartname;
								}
							}, {
								field : 'portendname',
								title : '目的港',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.portendname;
								}
							}, {
								field : 'vendorname',
								title : '船公司',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.vendorname;
								}
							}, {
								field : 'dueDate',
								title : '计划完成时间',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.dueDate;
								}
							} ] ],
							toolbar : [ {
								text : '计划排定',
								iconCls : 'icon-edit',
								handler : function() {
									schedulePlan();
								}
							}, {
								text : '申领',
								iconCls : 'icon-apply',
								handler : function() {
									quickApply();
								}
							} ]
						/* ,
													onClickRow : function(value, row, index) {
														findOrderItems(row.ordercode, "datagridItem");
													} */

						});
		searchHistoryForm = $('#searchHistoryForm').form();
		historydatagrid = $('#historydatagrid')
				.datagrid(
						{
							url : 'schedulePlanAction!schedulePlanHistroyTaskdatagrid.do',
							title : '排定计划<span style="color:red;">（单击订单号显示订单明细）</span>',
							iconCls : 'icon-save',
							pagination : true,
							checkOnSelect : false,
							selectOnCheck : false,
							singleSelect : true,
							pagePosition : 'bottom',
							rownumbers : true,
							pageSize : 10,
							pageList : [ 10, 20, 30, 40 ],
							//fitColumns : true,
							fit : true,
							border : false,
							frozenColumns : [ [
									{
										field : 'ordercode',
										title : '订单号',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return '<a onclick="detailCheck(\''
													+ row.ordercode
													+ '\')" style="color: blue;" >'
													+ row.ordercode + '</a>';
										}
									},
									{
										field : 'ordertypename',
										title : '订单类型',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.ordertypename;
										}
									},
									{
										field : 'factoryproducename',
										title : '生产工厂',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.factoryproducename;
										}
									},
									{
										field : 'contractcode',
										title : '合同编号',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.contractcode;
										}
									} ] ],
							columns : [ [

									{
										field : 'ordershipdate',
										title : '出运期',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return dateFormatYMD(row.ordershipdate);
										}
									},
									{
										field : 'ordercustomdate',
										title : '要求到货期',
										align : 'center',
										width : 100,
										sortable : true,
										formatter : function(value, row, index) {
											return dateFormatYMD(row.ordercustomdate);
										}
									},
									{
										field : 'dealtypename',
										title : '成交方式',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.dealtypename;
										}
									},
									{
										field : 'currencyname',
										title : '币种',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.currencyname;
										}
									},
									{
										field : 'termsdesc',
										title : '付款条件',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.termsdesc;
										}
									},
									{
										field : 'salesorgname',
										title : '销售组织',
										align : 'center',
										width : 100,
										sortable : true,
										formatter : function(value, row, index) {
											return row.salesorgname;
										}
									},
									{
										field : 'countryname',
										title : '国家',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.countryname;
										}
									},
									{
										field : 'customername',
										title : '客户',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.customername;
										}
									},
									{
										field : 'ordersourcecode',
										title : '客户订单号',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.ordersourcecode;
										}
									},
									{
										field : 'departmentname',
										title : '经营体',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.departmentname;
										}
									},
									{
										field : 'portstartname',
										title : '始发港',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.portstartname;
										}
									},
									{
										field : 'portendname',
										title : '目的港',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.portendname;
										}
									},
									{
										field : 'vendorname',
										title : '船公司',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.vendorname;
										}
									},
									{
										field : 'releaseflag',
										title : '闸口状态',
										width : 100,
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											if (row.releaseflag == "1") {
												return "已经释放";
											} else if (row.releaseflag == "0") {
												return "拒绝释放";
											} else {
												return "";
											}
										}
									},
									{
										field : 'trace',
										title : '流程追踪',
										align : 'center',
										width : 80,
										formatter : function(value, row, index) {
											return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg("
													+ index + ")'>流程跟踪</a>";
										}
									} ] ],
							toolbar : []
						/* ,
													onClickRow : function(value, row, index) {
														findOrderItems(row.ordercode,
																"historydatagridItem");
													} */

						});
		//加载国家信息
		$('#countryCode').combobox({
			url : 'queryPrepareAction!selectCountryInfo',
			valueField : 'countryCode',
			textField : 'name'
		});

		iframeDialog = $('#iframeDialog').show().dialog({
			title : 'POP弹出页面',
			modal : true,
			closed : true,
			maximizable : true
		});
		findOrderItems("11");
	});

	function _searchHistory() {
		historydatagrid.datagrid('load', sy.serializeObject(searchHistoryForm));
	}
	function cleanSearchHistory() {
		historydatagrid.datagrid('load', {});
		searchHistoryForm.form("clear");
		historydatagrid.datagrid('clearSelections');
		historydatagrid.datagrid('clearChecked');
		//searchForm.find('input').val('');
	}
	function traceImg(rowIndex) {
		var obj = historydatagrid.datagrid("getData").rows[rowIndex];
		parent.window.HROS.window
				.createTemp({
					title : obj.name + "-订单号:" + obj.ordercode + "-流程图",
					url : "${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="
							+ obj.procInstId,
					width : 800,
					height : 400,
					isresize : false,
					isopenmax : true,
					isflash : false
				});
	}
	//计划排定
	function schedulePlan() {
		var rows = datagrid.datagrid('getChecked');
		var taskIds = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要进行计划排定？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							taskIds = taskIds + "taskIds=" + rows[i].taskId
									+ "&";
						else
							taskIds = taskIds + "taskIds=" + rows[i].taskId;
					}
					$.ajax({
						url : 'schedulePlanAction!schedulePlan.do',
						data : taskIds,
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							top.window.showTaskCount();
							$.messager.show({
								title : '提示',
								msg : '计划排定成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要计划排定的订单！', 'error');
		}
	}
	//查看订单明细
	function findOrderItems(orderCode, datagridId) {
		$('#' + datagridId).datagrid(
				{
					url : 'schedulePlanAction!datagridByOrderCode.do',
					queryParams : {
						orderNum : orderCode
					},
					title : '订单号为<span style="color: red;">' + orderCode
							+ '</span>的订单明细：',
					iconCls : 'icon-save',
					//pagination : true,
					pagePosition : 'bottom',
					rownumbers : true,
					pageSize : 10,
					pageList : [ 10, 20, 30, 40 ],
					fit : true,
					//fitColumns : true,
					border : false,
					idField : 'actPrepareCode',
					columns : [ [ {
						field : 'prodType',
						title : '产品大类',
						align : 'center',
						sortable : true,
						width : 100,
						formatter : function(value, row, index) {
							return row.prodType;
						}
					}, {
						field : 'haierModer',
						title : '海尔型号',
						align : 'center',
						sortable : true,
						width : 100,
						formatter : function(value, row, index) {
							return row.haierModer;
						}
					}, {
						field : 'customerModel',
						title : '客户型号',
						align : 'center',
						sortable : true,
						width : 100,
						formatter : function(value, row, index) {
							return row.customerModel;
						}
					}, {
						field : 'addirmNum',
						title : '特技单号',
						align : 'center',
						sortable : true,
						width : 100,
						formatter : function(value, row, index) {
							return row.addirmNum;
						}
					}, {
						field : 'materialCode',
						title : '物料号',
						align : 'center',
						sortable : true,
						width : 100,
						formatter : function(value, row, index) {
							return row.materialCode;
						}
					}, {
						field : 'quantity',
						title : '数量',
						align : 'center',
						sortable : true,
						width : 100,
						formatter : function(value, row, index) {
							return row.quantity;
						}
					} ] ]
				});
	}
	//隐藏
	function hiddenSearchForm() {
		$("#checkSearch").layout("collapse", "north");
	}
	//隐藏
	function hiddenHistorySearchForm() {
		$("#historySearch").layout("collapse", "north");
	}
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form("clear");
		datagrid.datagrid('clearSelections');
		datagrid.datagrid('clearChecked');
		//searchForm.find('input').val('');
	}
	//显示订单明细
	function detailCheck(orderNum) {
		parent.window.HROS.window.close(orderDetailAppid);
		orderDetailAppid = parent.window.HROS.window
				.createTemp({
					appid : orderDetailAppid,
					title : "备货单明细",
					url : "${dynamicURL}/prepare/schedulePlanAction!checkOrderItem.do?orderNum="
							+ orderNum,
					width : 1100,
					height : 600,
					isresize : true,
					isflash : false
				});

	}
	//申领
	function quickApply() {
		var rows = datagrid.datagrid('getChecked');
		var taskIds = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要申领当前计划排定待办？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1) {
							taskIds = taskIds + "taskIds=" + rows[i].taskId
									+ "&";
						} else {
							taskIds = taskIds + "taskIds=" + rows[i].taskId;
						}
					}
					$.ajax({
						url : 'schedulePlanAction!apply.do',
						data : taskIds,
						dataType : 'json',
						type : "post",
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '申领成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要申领的计划排定待办！', 'error');
		}
	}
</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true">
		<div title="待办的计划排定">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 110px; overflow: hidden;">
					<form id="searchForm">
						<div class="navhead_zoc">
							<span>计划排定</span>
						</div>
						<div class="part_zoc">
							<div class="partnavi_zoc">
								<span>查询与操作：</span>
							</div>
							<div class="oneline">
								<div class="item25">
									<div class="itemleft60">订单编号：</div>
									<div class="righttext">
										<input id="orderCode" name="orderCode" type="text"
											style="width: 125px" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">备货单号：</div>
									<div class="righttext">
										<input id="actPrepareCode" name="actPrepareCode" type="text"
											style="width: 125px" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">国家：</div>
									<div class="rightselect_easyui">
										<input id="countryCode" name="countryCode" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">客户：</div>
									<div class="righttext">
										<input id="actPrepareCode" name="actPrepareCode" type="text"
											style="width: 125px" />
									</div>
								</div>
							</div>
							<div class="item100">
								<div class="oprationbutt">
									<input type="button" value="查  询" onclick="_search();" /> <input
										type="button" value="重  置" onclick="cleanSearch();" /> <input
										type="button" value="隐藏" onclick="hiddenSearchForm();" />
								</div>
							</div>
						</div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="datagrid"></table>
				</div>
				<!-- <div region="south" style="height: 100px;" border="false">
					<table id="datagridItem"></table>
				</div> -->
			</div>
		</div>
		<div title="已完成的计划排定">
			<!--展开之后的content-part所显示的内容-->
			<div id="historySearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 110px; overflow: hidden;">
					<form id="searchHistoryForm">
						<div class="navhead_zoc">
							<span>计划排定</span>
						</div>
						<div class="part_zoc">
							<div class="partnavi_zoc">
								<span>查询与操作：</span>
							</div>
							<div class="oneline">
								<div class="item25">
									<div class="itemleft60">订单编号：</div>
									<div class="righttext">
										<input id="orderCode" name="orderCode" type="text"
											style="width: 125px" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">备货单号：</div>
									<div class="righttext">
										<input id="actPrepareCode" name="actPrepareCode" type="text"
											style="width: 125px" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">国家：</div>
									<div class="rightselect_easyui">
										<input id="countryCode" name="countryCode" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">客户：</div>
									<div class="righttext">
										<input id="actPrepareCode" name="actPrepareCode" type="text"
											style="width: 125px" />
									</div>
								</div>
							</div>
							<div class="oneline">
								<div class="item25">
									<div class="itemleft80">计划排定时间从：</div>
										<div class="rightselect_easyui">
											<input id="scheduleDateStar" name="scheduleDateStar"
												style="width: 130px" class="easyui-datebox" editable="false" />
										</div>
									</div>
									<div class="item25">
										<div class="itemleft60">至：</div>
										<div class="rightselect_easyui">
											<input id="scheduleDateEnd" name="scheduleDateEnd"
												style="width: 120px;margin-left: 1px;" class="easyui-datebox" editable="false" />
										</div>
									</div>
								<div class="item33">
									<div class="oprationbutt">
										<input type="button" value="查  询" onclick="_searchHistory();" /> <input
											type="button" value="重  置" onclick="cleanSearchHistory();" /> <input
											type="button" value="隐藏" onclick="hiddenHistorySearchForm();" />
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="historydatagrid"></table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>