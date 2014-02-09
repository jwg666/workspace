<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script src="${staticURL}/scripts/baiduTemplate.js"></script>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var iframeDialog;
	var searchHistoryForm;
	var historydatagrid;
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP
		});
		$('#' + inputId).val(_CCNTEMP);
	}
	$(function() {
		//查询列表	
			//设置左分隔符为 <!
		baidu.template.LEFT_DELIMITER='{%';

		//设置右分隔符为 <!  
		baidu.template.RIGHT_DELIMITER='%}';
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid')
				.datagrid(
						{
							url : 'importHgvsInterfaceAction!hgvsInterfaceTaskdatagrid.do?definitionKey=exportHGVS&taskId='+'${taskId}',
							title : '订单导HGVS',
							iconCls : 'icon-save',
							pagination : true,
							pagePosition : 'bottom',
							rownumbers : true,
							pageSize : 20,
							pageList : [ 10, 20, 30, 40 ],
							height : 250,
							//fitColumns : true,
							fit : true,
							border : false,
							columns : [ [
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
											return row.ordercode;
										}
									},
									{
										field : 'actpreparecode',
										title : '备货单号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											var img;
											if (row.assignee
													&& row.assignee != 'null') {
												img = "<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
											} else {
												img = "<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
											}
											return '<a   id="tooltip_'+row.actpreparecode+'"  onclick="detailCheck(\''+row.actpreparecode+'\')" style="color: blue;cursor:pointer;" >'+img+row.actpreparecode+"</a>";
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
									},
									{
										field : 'ordershipdate',
										title : '出运期',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return dateFormatYMD(row.ordershipdate);
										}
									},
									{
										field : 'ordercustomdate',
										title : '要求到货期',
										align : 'center',
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
										formatter : function(value, row, index) {
											return row.dealtypename;
										}
									},
									{
										field : 'currencyname',
										title : '币种',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.currencyname;
										}
									},
									{
										field : 'termsdesc',
										title : '付款条件',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.termsdesc;
										}
									},
									{
										field : 'salesorgname',
										title : '销售组织',
										align : 'center',
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
										formatter : function(value, row, index) {
											return row.countryname;
										}
									},
									{
										field : 'customername',
										title : '客户',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.customername;
										}
									},
									{
										field : 'ordersourcecode',
										title : '客户订单号',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.ordersourcecode;
										}
									},
									{
										field : 'departmentname',
										title : '经营体',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.departmentname;
										}
									},
									{
										field : 'portstartname',
										title : '始发港',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.portstartname;
										}
									},
									{
										field : 'portendname',
										title : '目的港',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.portendname;
										}
									},
									{
										field : 'vendorname',
										title : '船公司',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.vendorname;
										}
									},{
										field : 'dueDate',
										title : '计划完成时间',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.dueDate;
										}
									}] ],
							toolbar : [ {
								text : '导HGVS',
								iconCls : 'icon-edit',
								handler : function() {
									hgvsInterface();
								}
							}, {
								text : '申领',
								iconCls : 'icon-apply',
								handler : function() {
									quickApply();
								}
							} ],
							onLoadSuccess : function(data) {
								$("a[id^='tooltip_']").tooltip(
												{
													position : 'bottom',
													content:'正在加载物料信息...',
													deltaX:40,
													onShow:function(e){
														var tooltip=$(this);
														var actpreparecode=tooltip.attr("id").replace("tooltip_","");
													 	$.ajax({
															url : "${dynamicURL}/prepare/prepareOrderItemAction!mapList.do",
															data : {
																actPrepareOrderCode : actpreparecode
															},
															dataType : "json",
															type : 'post',
															success : function(data) {
																var temp={};
																temp["data"]=data;
																var messageHtml=baidu.template('itemList_Template',temp);
																tooltip.tooltip('update',messageHtml);
															}
														}); 
														
													}
												});
							}

						});
		searchHistoryForm = $('#searchHistoryForm').form();
		historydatagrid = $('#historydatagrid')
				.datagrid(
						{
							url : 'importHgvsInterfaceAction!hgvsInterfaceHistroyTaskdatagrid.do',
							title : '订单导HGVS',
							iconCls : 'icon-save',
							pagination : true,
							pagePosition : 'bottom',
							rownumbers : true,
							pageSize : 10,
							pageList : [ 10, 20, 30, 40 ],
							//fitColumns : true,
							fit : true,
							border : false,
							columns : [ [
									{
										field : 'ordercode',
										title : '订单号',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.ordercode ;
										}
									},
									{
										field : 'orderhgvscode',
										title : 'HGVS单号',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.orderhgvscode ;
										}
									},
									{
										field : 'actpreparecode',
										title : '备货单号',
										align : 'center',
										width : 100,
										sortable : true,
										formatter : function(value, row, index) {
											return row.actpreparecode;
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
									},
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
									}, {
										field : 'dueDate',
										title : '计划完成时间',
										align : 'center',
										sortable : true,
										formatter : function(value, row, index) {
											return row.dueDate;
										}
									}] ]

						});
		//custCodeId客户编号
		$('#custCodeIdHistory').combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
			textField : 'name',
			idField:'customerId',
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
				field : 'name',
				title : '客户名称',
				width : 20
			} ] ]
		});
		//custCodeId客户编号
		$('#custCodeId').combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
			textField : 'name',
			idField:'customerId',
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
				field : 'name',
				title : '客户名称',
				width : 20
			}] ]
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
			toolbar : '#_COUNTRYFINISH',
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
		$('#countryCodehistory').combogrid({
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
		iframeDialog = $('#iframeDialog').show().dialog({
			title : 'POP弹出页面',
			modal : true,
			closed : true,
			maximizable : true
		});
	});
	//显示订单明细
	function detailCheck(actPrepareCode) {
		parent.window.HROS.window
		.createTemp({
			title : "导HGVS明细",
			url : "${dynamicURL}/prepare/importHgvsInterfaceAction!hgvsInterfacedetail.do?prepareOrderQuery.actPrepareCode="
					+ actPrepareCode,
			width : 800,
			height : 400,
			isresize : true,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
	}
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function reloaddata(){
		datagrid.datagrid('reload');
		top.window.showTaskCount();
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form("clear");
		datagrid.datagrid('clearSelections');
		datagrid.datagrid('clearChecked');
		//searchForm.find('input').val('');
	}
	function _searchHistory() {
		historydatagrid.datagrid('load', sy.serializeObject(searchHistoryForm));
	}
	function reloaddataHistory(){
		historydatagrid.datagrid('reload');
	}
	function cleanSearchHistory() {
		historydatagrid.datagrid('load', {});
		searchHistoryForm.form("clear");
		historydatagrid.datagrid('clearSelections');
		historydatagrid.datagrid('clearChecked');
		//searchForm.find('input').val('');
	}
	//导HGVS
	function hgvsInterface() {
		var rows = datagrid.datagrid('getChecked');
		quickApplyByOrder(rows);
			var actPrepareCodes = "";
			if (rows.length > 0) {
				$.messager.confirm('请确认', '您要进行导HGVS？',
						function(r) {
							if (r) {
								$.messager.progress({
									text : '数据加载中....',
									interval : 100
								});
								for ( var i = 0; i < rows.length; i++) {
									if (i != rows.length - 1)
										actPrepareCodes = actPrepareCodes + "actPrepareCodes="
												+ rows[i].actpreparecode + "&";
									else
										actPrepareCodes = actPrepareCodes + "actPrepareCodes="
												+ rows[i].actpreparecode;
								}
								$.ajax({
									url : 'importHgvsInterfaceAction!hgvsInterface.do',
									data : actPrepareCodes,
									dataType : 'json',
									success : function(response) {
										if(response.success){
											datagrid.datagrid('load');
											datagrid.datagrid('unselectAll');
											top.window.showTaskCount();
											$.messager.alert('提示','订单导HGVS成功！','info');
											$.messager.progress('close');
										}else{
											datagrid.datagrid('load');
											datagrid.datagrid('unselectAll');
											$.messager.alert('提示','导入失败：'+response.msg,'error');
											$.messager.progress('close');
										}
									}
								});
							}
						});
			} else {
				$.messager.alert('提示', '请选择要导HGVS的订单！', 'error');
			}
	}
	//隐藏
	function hiddenSearchForm() {
		$("#checkSearch").layout("collapse", "north");
	}
	//隐藏
	function hiddenSearchFormHistory() {
		$("#historySearch").layout("collapse", "north");
	}
	
	//申领
	function quickApply() {
		var rows = datagrid.datagrid('getChecked');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要申领当前的订单导HGVS待办？', function(r) {
				if (r) {
					var taskIds = "";
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1) {
							taskIds = taskIds + "taskIds=" + rows[i].taskId
									+ "&";
						} else {
							taskIds = taskIds + "taskIds=" + rows[i].taskId;
						}
					}
					$.ajax({
						url : 'importHgvsInterfaceAction!apply.do',
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
			$.messager.alert('提示', '请选择要申领的订单导HGVS待办！', 'error');
		}
	}
	function quickApplyByOrder(rows){
		var taskIds = "";
		for ( var i = 0; i < rows.length; i++) {
			if (i != rows.length - 1) {
				taskIds = taskIds + "taskIds=" + rows[i].taskId
						+ "&";
			} else {
				taskIds = taskIds + "taskIds=" + rows[i].taskId;
			}
		}
		$.ajax({
			url : 'importHgvsInterfaceAction!apply.do',
			data : taskIds,
			dataType : 'json',
			type : "post",
			success : function(response) {
			}
		});
	}
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
	//模糊查询国家下拉列表
	function _CCNMYHISTORY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do?name='+ _CCNTEMP+'&countryCode='+_CCNCODE 
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询国家信息输入框
	function _CCNMYCLEANHISTORY(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/countryAction!datagrid.do'
				});
	}
</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true">
		<div title="订单导HGVS待办">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					 style="height: 120px; overflow: hidden;">
					<form id="searchForm">
						<div class="navhead_zoc"><a ></a>
							<span>订单导HGVS待办</span>
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
									<div class="itemleft60">备货单号：</div>
									<div class="righttext">
										<input id="actPrepareCode" name="actPrepareCode" type="text"
											style="width: 125px" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">国家：</div>
									<div class="rightselect_easyui">
										<input id="countryCodeFinish" name="countryCode" class="short50"  type="text" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">客户：</div>
									<div class="righttext">
										<input type="text" name="customerCode" id="custCodeId" />
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
			</div>
		</div>
		<div title="订单导HGVS已完成的待办">
			<!--展开之后的content-part所显示的内容-->
			<div id="historySearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					style="height: 110px; overflow: hidden;">
					<form id="searchHistoryForm">
						<div class="navhead_zoc">
							<span>订单导HGVS已完成的待办</span>
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
									<div class="itemleft60">备货单号：</div>
									<div class="righttext">
										<input id="actPrepareCode" name="actPrepareCode" type="text"
											style="width: 125px" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">国家：</div>
									<div class="rightselect_easyui">
										<input id="countryCodehistory" name="countryCode" class="short50"  type="text" />
									</div>
								</div>
								<div class="item25">
									<div class="itemleft60">客户：</div>
									<div class="righttext">
										<input type="text" name="customerCode" id="custCodeIdHistory" />
									</div>
								</div>
							</div>
							<div class="item100">
								<div class="oprationbutt">
									<input type="button" value="查  询" onclick="_searchHistory();" /> <input
										type="button" value="重  置" onclick="cleanSearchHistory();" /> <input
										type="button" value="隐藏" onclick="hiddenSearchFormHistory();" />
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
						onclick="_CCNMY('_CNNINPUTHISTORY','custCodeIdHistory')" />
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
						onclick="_CCNMYHISTORY('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryCodehistory')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEANHISTORY('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryCodehistory')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_COUNTRYFINISH">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="_COUNTRYCODEFINISH" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUTFINISH" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCNMY('_COUNTRYCODEFINISH','_COUNTRYINPUTFINISH','countryCodeFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('_COUNTRYCODEFINISH','_COUNTRYINPUTFINISH','countryCodeFinish')" />
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
				<td>{%= data[i].haierProductCode %}</td>
				<td>{%= data[i].prodCode %}</td>
				<td>{%= data[i].materialCode %}</td>
				<td>{%= data[i].affirmCode %}</td>
				<td>{%= data[i].quantity %}</td>
			</tr>
		
		{% }  %}

		</tbody></table>
</script>
</body>
</html>