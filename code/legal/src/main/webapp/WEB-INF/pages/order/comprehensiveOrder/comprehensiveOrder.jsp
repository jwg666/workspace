<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
var searchForm;
var datagrid;
$(function() {
	//查询列表	
	searchForm = $('#searchForm').form();
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
	
	datagrid = $('#datagrid').datagrid({
		url : '${dynamicURL}/salesOrder/salesOrderAction!comprehensiveOrderDatagrid.do',
		title : '<s:text name="order.info.list" >订单信息列表</s:text>',
		pagination : true,
		pagePosition : 'bottom',
		rownumbers : true,
		pageSize : 10,
		pageList : [ 10, 20, 30, 40 ],
		fit : true,
		fitColumns : true,
		nowrap : true,
		border : false,
		singleSelect:true,
		idField : 'orderCode',
		columns : [ [ {
			field : 'orderCode',
			title : '<s:text name="global.order.number" >订单编号</s:text>',
			align : 'center',
			sortable : true,width:90
		}, {
			field : 'countryName',
			title : '<s:text name="global.order.countryName" >出口国家</s:text>',
			align : 'center',
			sortable : true,width:90
		}, {
			field : 'customerName',
			title : '<s:text name="global.order.customerName" >客户名称</s:text>',
			align : 'center',
			sortable : true,width:90
		}, {
			field : 'orderShipDate',
			title : '<s:text name="global.order.orderShipDate" >订单出运时间</s:text>',
			align : 'center',
			sortable : true,width:90,
			formatter:function(value,row,index){
				return dateFormatYMD(row.orderShipDate);
			}
		}, {
			field : 'deptName',
			title : '<s:text name="global.order.deptName" >经营体</s:text>',
			align : 'center',
			sortable : true,width:90
		}, {
			field : 'prodType',
			title : '<s:text name="global.order.prodtype" >产品大类</s:text>',
			align : 'center',
			sortable : true,width:90
		}, {
			field : 'factoryCode',
			title : '<s:text name="global.order.factoryCode" >生产工厂</s:text>',
			align : 'center',
			sortable : true,width:90
		} ] ],
		onDblClickRow : function(rowIndex, rowData) {
			orderDetail(rowData.orderCode);
		}
	});
	//选择客户 
	$('#customerCode_id').combogrid({
		url : '${dynamicURL}/basic/customerAction!datagrid0.action',
		textField : 'name',
		idField : 'customerId',
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
			title : '<s:text name="global.order.customerCode" >客户编号</s:text>',
			width : 10
		}, {
			field : 'name',
			title : '<s:text name="global.order.customerName" >客户名称</s:text>',
			width : 10
		} ] ]
	});
});
function _search() {
	//重写url 避免重复传值问题
	datagrid.datagrid({url:"${dynamicURL}/salesOrder/salesOrderAction!comprehensiveOrderDatagrid.do?"+searchForm.serialize()});
}
function cleanSearch() {
	searchForm.form('clear');
	_search();
}
function orderDetail(obj){
// 	var orderCode = '0000015591';
	var orderCode=obj;
// 	datagrid_detail = $('#datagrid_detail').datagrid({
// 		url : '${dynamicURL}/comprehensiveOrder/comprehensiveOrderAction!searchOrderDetail.do?orderCode='+orderCode,
// 		rownumbers : true,
// 		fit : true,
// 		fitColumns : true,
// 		nowrap : true,
// 		border : false,
// 		singleSelect:true,
// 		idField : 'rowId',
// 		showFooter: true ,
// 		columns : [ [ 
// 		   {field:'prodType',title:'货名',align:'center',sortable:true,width:90},				
// 		   {field:'haierModel',title:'型号',align:'center',sortable:true,width:90},				
// 		   {field:'prodQuantity',title:'数量',align:'center',sortable:true,width:90},				
// 		   {field:'grossWeight',title:'每件毛重(KG)',align:'center',sortable:true,width:90},				
// 		   {field:'sumGrossWeight',title:'总毛重',align:'center',sortable:true,width:90},				
// 		   {field:'grossValue',title:'每件尺码(m3)',align:'center',sortable:true,width:90},	
// 		   {field:'sumGrossValue',title:'总尺码(m3)',align:'center',sortable:true,width:90},
// 		   {field:'standardContainerId',title:'相关装箱图号',align:'center',sortable:true,width:90},	
// 		   {field:'price',title:'原币单价',align:'center',sortable:true,width:90},				
// 		   {field:'amount',title:'原币总额',align:'center',sortable:true,width:90},				
// 		   {field:'fobPrice',title:'原币FOB单价',align:'center',sortable:true,width:90},				
// 		   {field:'fobAmount',title:'原币FOB总额',align:'center',sortable:true,width:90}			
// 		 ] ]
// 	});
// 	comprehensiveOrderForm=$("#comprehensiveOrderForm").form();
// 	orderDetailDialog = $('#orderDetailDialog').show().dialog({
//     	title : '综合通知单明细',
//     	modal : true,
// 		closed : true,
// 		maximizable : true,
//     	buttons : [
//     	    {
//     			text : '打印',
//     			handler : function() {
//     				$.messager.alert('提示', '维护中...', 'info');
//     				return false;
//     			}
//     		}
//     	]
//     });
	$.messager.progress({
		text : '<s:text name="the.data.load" >数据加载中</s:text>....',
		interval : 100
	});
	$.ajax({
		url : '${dynamicURL}/comprehensiveOrder/comprehensiveOrderAction!ifOpenOrderDetail.do',
		data : {
			orderCode : orderCode
		},
		dataType : 'json',
		cache : false,
		success : function(response) {
			$.messager.progress('close');
			if(response.success){
				parent.window.HROS.window.createTemp({
				title:'<s:text name="order.comprehensive.comprehensiveOrderDetail" >综合通知单明细</s:text>'+'-<s:text name="global.order.number" >订单编号</s:text>:'+response.orderCode,
				url:"${dynamicURL}/comprehensiveOrder/comprehensiveOrderAction!openOrderDetail.do?orderCode="+response.orderCode,
				width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow:window});
			}else{
				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.comprehensive.comprehensiveOrder.without" >未获取到综合通知单信息</s:text>!', 'error');
			}
			
		}
	});
}
//客户查询
function _CCNMY1(codeId, nameId) {
	var custCode = $('#' + codeId).val();
	var custName = $('#' + nameId).val();
	$('#customerCode_id').combogrid({
		url : '${dynamicURL}/basic/customerAction!datagrid0.action?name=' + custName+'&customerId='+custCode
	});
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
</script>
</head>
<body class="easyui-layout zoc">
	<div region="north" border="false" class="zoc" title="" collapsed="false"  style="height: 80px;overflow: auto;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc">
				<span><s:text name="order.comprehensive.comprehensiveOrder" >综合通知单</s:text>：</span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft"><s:text name="global.order.number" >订单编号</s:text>：</div>
					<div class="righttext">
						<input id="orderCode" name="orderCode" type="text"
							style="width: 153px" class="orderAutoComple"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft"><s:text name="global.order.countryName" >出口国家</s:text>：</div>
					<div class="rightselect_easyui">
						<input name="countryCode" id="countryIdtask"/>
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft"><s:text name="global.order.customerName" >客户</s:text>：</div>
					<div class="rightselect_easyui">
						<input name="orderSoldTo" id="customerCode_id"/>
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">出运时间从：</div>
					<div class="rightselect_easyui">
						<input name="orderShipDateStart" class="easyui-datebox"  style="width: 155px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">到：</div>
					<div class="rightselect_easyui">
						<input name="orderShipDateEnd" class="easyui-datebox"  style="width: 155px;" />
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="oprationbutt">
						<input type="button" onclick="_search()" value="<s:text name="global.form.select" >查询</s:text>" />
						<input type="button" onclick="cleanSearch()" value="<s:text name="global.form.cancel" >取消</s:text>" />
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
<div id="_CNNQUERY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60"><s:text name="global.order.customerCode" >客户编号</s:text>：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60"><s:text name="global.order.customerName" >客户名称</s:text>：</div>
				<div class="righttext">
					<input class="short50" id="CNNINPUT2" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
		<div class="item50">
			<div class="oprationbutt">
				<input type="button" value="<s:text name="global.form.select" >查询</s:text>"
					onclick="_CCNMY1('_CNNINPUT','CNNINPUT2')" />
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
</body>
</html>