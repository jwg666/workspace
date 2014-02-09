<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var editRow = undefined;
	var datagrid;
	$(function() {

		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'negoOrderAction!findDocList.action',
			title : '议付活动表列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			singleSelect : true,
			pageSize : 20,
			pageList : [ 10, 20, 30, 40, 50, 100 ],
			fit : true,
			fitColumns : true,
			rownumbers : true,
			nowrap : false,
			border : false,
			idField : 'obid',
			sortName : '',
			sortOrder : 'desc',
			columns : [ [ 
				{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.obid;
						}
				},
			   {field:'negoInvoiceNum',title:'议付发票号',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.negoInvoiceNum;
					}
				},		
			   {field:'country',title:'国家',align:'center',sortable:false,width : 85,
					formatter:function(value,row,index){
						return row.country;
					}
				},			
				{field:'custname',title:'客户',align:'center',sortable:false,width : 85,
					formatter:function(value,row,index){
						return row.custname;
					}
				},
			   {field:'ordertype',title:'结算类型',align:'center',sortable:false,width : 85,
					formatter:function(value,row,index){
						return row.ordertype;
					}
				},
				 {field:'factory',title:'工厂',align:'center',sortable:false,width : 85,
					formatter:function(value,row,index){
						return row.factory;
					}
				},
				 {field:'dept',title:'经营体',align:'center',sortable:false,width : 85,
					formatter:function(value,row,index){
						return row.dept;
					}
				}
			   ] ],
			toolbar : [  {
				text : '发票',
				iconCls : 'icon-remove',
				handler : function() {
					docCust();
				}
			},'-',{
				text : '箱单',
				iconCls : 'icon-add',
				handler : function() {
					docPacking();
				}
			},  '-', {
				text : '出运通知单',
				iconCls : 'icon-edit',
				handler : function() {
					docShiping();
				}
			}, '-']	

		});
		$("#custCodeId").combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
			textField : 'name',
			idField : 'customerId',
			panelWidth : 600,
			panelHeight : 220,
			width : 200,
			toolbar : '#sold_to_panel',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			editable : false,
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
	});
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		var _CCNTEMPID = $('#' + inputId + 'ID').val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP + '&customerId=' + _CCNTEMPID
		});
		$("#custCodeId").combogrid('setValue', '');
	}
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	
	function docPacking() {
		var rows = datagrid.datagrid('getSelections');
		 parent.window.HROS.window.createTemp({
			 	title:"箱单",
			 	url:'${dynamicURL}/documentsInvoices/docPackingDetailAction!goDocPackingDetail.do?negoInvoiceNum='+rows[0].negoInvoiceNum,
			 	width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
	}
	function docCust() {
		var rows = datagrid.datagrid('getSelections');
		 parent.window.HROS.window.createTemp({
			 	title:"发票",
			 	url:'${dynamicURL}/documentsInvoices/docCustInvoiceMainAction!goDocCustInvoiceMain.do?negoInvoiceNum='+rows[0].negoInvoiceNum,
			 	width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
	}
	function docShiping() {
		var rows = datagrid.datagrid('getSelections');
		 parent.window.HROS.window.createTemp({
			 	title:"出运通知单",
			 	url:'${dynamicURL}/documentsInvoices/shippingAdviceAction!goShippingAdviceByInvoice.action?invoiceNum='+rows[0].negoInvoiceNum,
			 	width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
	}
</script>
</head>
<body class="easyui-layout">
		<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 120px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>单证发票查询</span>
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
						<div class="itemleft60">议付发票号：</div>
						<div class="righttext">
							<input id="negoInvoiceNum" name="negoInvoiceNum" type="text"
								style="width: 125px" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft60">客户：</div>
						<div class="righttext">
							<input id="custCodeId" style="width: 95%" name="custname" />
						</div>
					</div>
				</div>
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查  询" onclick="_search();" /> 
					</div>
				</div>
			</div>
		</form>
	</div>

	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>	
	<div id="sold_to_panel">
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
						onclick="_CCNMY('_CNNINPUT','custCodeId')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>