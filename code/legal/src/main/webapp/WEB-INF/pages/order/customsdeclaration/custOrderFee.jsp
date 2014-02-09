<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var editRow = undefined;
	var uploadExcelDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid')
				.datagrid(
						{
							url : 'custOrderAction!listCustOrderFee.action',
							title : '',
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
							//idField : 'orderCode',
							frozenColumns : [ [
									{
										field : 'ck',
										checkbox : true,
										formatter : function(value, row, index) {
											return row.orderCode;
										}
									},
									{
										field : 'ORDER_CODE',
										title : '订单号',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return value;
										}
									}, {
										field : 'TRANS_NAME',
										title : '报关操作人',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return value;
										}
									}, {
										field : 'VENDOR_NAME_CN',
										title : '报关行',
										align : 'center',
										width : 200,
										formatter : function(value, row, index) {
											return value;
										}
									}, {
										field : 'CUST_DATE',
										title : '报关时间',
										align : 'center',
										sortable : true,
										width : 200,
										formatter : function(value, row, index) {
											return dateFormatYMD(value);
										}
									}, ] ],
							columns : [ [
									{
										field : 'CUST_AMOUNT_ALL',
										title : '报关总额',
										align : 'center',
										sortable : true,
										width : 200,
										formatter : function(value, row, index) {
											return value
										}
									},
									{
										field : 'AMOUNT',
										title : '报关费',
										align : 'center',
										sortable : true,
										width : 100,
										formatter : function(value, row, index) {
											return row.AMOUNT;
										}
									},
									{
										field : 'STATUS_CODE',
										title : '申请状态',
										align : 'center',
										sortable : true,
										width : 80,
										formatter : function(value, row, index) {
											if(value=='')return '可申请';
											if(value=='1')return '可申请';
											if(value=='2')return "申请完毕";//不可生成费用
										}
									},
									{
										field : 'customerName',
										title : '订单信息',
										align : 'center',
										sortable : true,
										width : 200,
										formatter : function(value, row, index) {
											return row.customerName;
										}
									},
									{
										field : 'countryName',
										title : '<s:text name="global.order.countryName">出口国家</s:text>',
										align : 'center',
										sortable : true,hidden : true,
										width : 200,
										formatter : function(value, row, index) {
											return row.countryName;
										}
									},
									{
										field : 'procInstId',
										title : '流程id',
										align : 'center',
										sortable : true,
										width : 100,
										hidden : true,
										formatter : function(value, row, index) {
											return row.procInstId;
										}
									},
									{
										field : 'taskId',
										title : '任务id',
										align : 'center',
										sortable : true,
										width : 100,
										hidden : true,
										formatter : function(value, row, index) {
											return row.taskId;
										}
									},
									 ] ],
							toolbar : [ {
								text : '生成费用',
								iconCls : 'icon-edit',
								handler : function() {
									//
									createFee();
								}
							}, '-', {
								text : '批量生成费用',
								iconCls : 'icon-edit',
								handler : function() {
									//
									createAllFee();
								}
							},'-']
						});
	});
	
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function hiddenSearchForm() {
		$("#checkSearch").layout("collapse", "north");
	}
	function createFee(){
		var rows = datagrid.datagrid('getSelections');
		if(rows.length==1){
			if(rows[0].STATUS_CODE=='2'){
				$.messager.alert('提示','不可申请','error');
				return;
			}
			$.ajax({
				url:'custOrderAction!generateCustFee.action',
				data:{'orderCode':rows[0].ORDER_CODE},
				dataType:'json',
				type:'POST',
				success:function(response){
					$.messager.progress('close');
					if(response&&response.success){
						$.messager.alert('提示',response.msg,'info')
					}else{
						$.messager.alert('提示',response.msg,'error')
					}
				},
				beforeSend:function(){
					$.messager.progress();
				}
			});
		}else if(rows.length==0){
			$.messager.alert('提示','多条请点击“批量生成”','info');
		}
		refreshTask();
	}
	function createAllFee(){
		var rows = datagrid.datagrid('getSelections');
		if(rows.length==0){
			$.messager.alert('提示','请选择记录','error');
		}else{
			var orderCodes = '';
			for ( var i = 0; i < rows.length; i++) {
				if(rows[i].STATUS_CODE=='2'){
					$.messager.alert('提示','存在记录不能申请','error')
					return;
				}
				if (i < rows.length - 1) {
					orderCodes = orderCodes + 'orderCodes=' + rows[i].ORDER_CODE + '&';
				} else {
					orderCodes = orderCodes + 'orderCodes=' + rows[i].ORDER_CODE;
				}
			}
			$.ajax({
				url:'custOrderAction!generateCustFeeAll.action',
				data:orderCodes,
				dataType:'json',
				type:'POST',
				success:function(response){
					$.messager.progress('close');
					if(response&&response.success){
						$.messager.alert('提示',response.msg,'info')
					}else{
						$.messager.alert('提示',response.msg,'error')
					}
				},
				beforeSend:function(){
					$.messager.progress();
				}
			});
		}
		refreshTask();
	}
	//刷新任务列表
	function refreshTask() {
		datagrid.datagrid('reload');
	}
</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true">
		<div title="报关代办">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 100px; overflow: hidden;">
					<form id="searchForm">
						<div class="partnavi_zoc">
							<span><s:text name="global.info.queriesAndoperations">查询与操作</s:text>：</span>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft60">订单号：</div>
								<div class="righttext_easyui">
									<div class="righttext">
										<input name="orderCode" type="text" />
									</div>
								</div>
							</div>
							<div class="item33">
								<div class="itemleft">
									报关操作人：
								</div>
								<div class="righttext">
									<input name="assignee" type="text" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft">
									报关行：
								</div>
								<div class="righttext">
									<input name="custCompany" type="text" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft60">报关时间：</div>
								<div class="righttext_easyui">
									<div class="righttext">
										<input name="created" type="text" class="easyui-datebox"/>
									</div>
								</div>
							</div>
							<div class="item25">
								<div class="righttext_easyui">
									<div class="righttext">
										<input name="lastUpd" type="text" class="easyui-datebox"/>
									</div>
								</div>
							</div>
							<div class="item33">
								<div class="itemleft">
									生成状态：
								</div>
								<div class="righttext">
								<!-- 代理接收标识 0未接收，1已接收，2拒绝 -->
									<select class="easyui-combobox" name="agentTakeFlag">
										<option value="">全部</option>
										<option value="0">未接收</option>
										<option value="1">已接收</option>
										<option value="2">拒绝</option>
									</select>
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item33 lastitem">
								<div class="oprationbutt">
									<input type="button" onclick="_search()"
										value="<s:text name="global.form.filter">过滤</s:text>" /> <input
										type="button" onclick="cleanSearch()" value="清空" /> <input
										type="button" onclick="hiddenSearchForm()"
										value="<s:text name="pcm.distributor.state_hidden">隐藏</s:text>" />
								</div>
							</div></div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="datagrid"></table>
				</div>
			</div>
		</div>
	</div>
	<div id="uploadExcelDialog"
		style="display: none; width: 400px; height: 120px;" align="center">
		<form id="upLoadExcelForm" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<th><s:text name="page.statistics.upload">导入</s:text>:</th>
					<td><s:file id="excleFile" name="excleFile"></s:file></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>