<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="/struts-jquery-tags" prefix="sj"%>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
var searchForm;
var datagrid;
var myJson;
$(function() {
	//查询列表	
	searchForm = $('#searchForm').form();
	datagrid = $('#datagrid').datagrid({
		url : 'prepareOrderAction!prepareRollplanRelease.action',
		title : '滚动计划闸口待办任务列表',
		iconCls : 'icon-save',
		pagination : true,
		pagePosition : 'bottom',
		rownumbers : true,
		pageSize : 10,
		height : 500,
		pageList : [ 10, 20, 30, 40 ],
		fitColumns : true,
		nowrap : true,
		border : false,
		checkOnSelect : false,
		selectOnCheck : false,
		singleSelect : true,
		idField : 'orderCode',
		columns : [ [ {
			field : 'ck',
			checkbox : true,
			formatter : function(value, row, index) {
				return row.orderCode;}
						},{
			field : 'taskId',
			title : 'TaskId',
			hidden : true,
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.taskId;}
						},{
			field : 'actPrepareCode',
			title : '序号',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return ++index;}
						}, {
			field : 'orderCode',
			title : '订单号',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.orderCode;}
						}, {
			field : 'factoryCode',
			title : '工厂',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.factoryCode;}
						}, {
			field : 'deptCode',
			title : '经营主体',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
					return row.deptCode;}
						}, {
			field : 'countryCode',
			title : '出口国家',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
					return row.countryCode;}
						}, {
			field : 'saleArea',
			title : '市场区域',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.saleArea;
							}
						}, {
			field : 'orderProdManager',
			title : '产品经理',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.orderProdManager;
							}
						}, {
			field : 'releaseFlag',
			title : '闸口状态',
			align : 'center',
			sortable : true,
			formatter : function(value, row, index) {
				return row.releaseFlag;
							}
						} ] ],
			toolbar : [ {
							text : '释放滚动计划',
							iconCls : 'icon-edit',
							handler : function() {
								outReleaseFlag();
							}
						}, '-'],
					});
				});
				
function outReleaseFlag() {
	var rowdd = $('#datagrid').datagrid('getSelected');
	$.ajax({
		url : 'prepareOrderAction!releaseRollFlag.do?orderCodes='+rowdd.orderCode + '&taskId='+rowdd.taskId,
		dataType : 'json',
		cache : false,
	});
}				
function _search() {
	datagrid.datagrid('load', sy.serializeObject(searchForm));
}
	
</script>
</head>
	<div region="north" border="false" class="zoc"
		style="height: 120px; overflow: auto;" align="left">
		<form id="searchForm" method="post">
			<s:hidden name="loginName" id="loginName" />
			<div class="navhead_zoc">
				<span>滚动计划释放闸口</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>操作：</span>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">订单号 ：</div>
						<div class="righttext">
							<input id="orderCode" name="orderCode"
								style="width: 160px;" />
						</div>
					</div>
					<div class="item33">
						<div class="righttext">
							<input type="button" value="查  询" onclick="_search();;" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center" border="false" class="part_zoc">
		<table id="datagrid"></table>
	</div>
</html>