<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var iframeDialog;
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP
		});
		$('#' + inputId).val(_CCNTEMP);
	}
	$(function() {
		$('#custCodeId').combogrid({
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
	    //查询列表	
	    searchForm = $('#searchForm').form();
	    //searchForm.form('clear');
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/agentcybill/agentcyBillAction!datagrid0.do',
			title : '订单评审主表列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			//fitColumns : true,
			nowrap : true,
			border : false,
			singleSelect : true,
			//idField : 'rowId',
			
			frozenColumns : [ [ 
			   {field:'ORDER_CODE',title:'订单号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.ORDER_CODE;
					}
				},{field:'AGENTCY_BILL_CODE',title:'代理清单编号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.AGENTCY_BILL_CODE;
					}
				},{field:'PRINT_FLAG',title:'正式打印',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						
						if(row.PRINT_FLAG==null||row.PRINT_FLAG=='0'){
							return '否';
						}else if(row.PRINT_FLAG=='1'){
							return '是';
						}
					}
				},				
				{
					field : 'CONTRACT_CODE',
					title : '合同编号',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.CONTRACT_CODE;
					}
				}, {
					field : 'ORDER_SHIP_DATE',
					title : '出运期',
					align : 'center',

					width : 90,
					formatter : function(value, row, index) {
						return dateFormatYMD(row.ORDER_SHIP_DATE);
					}
				}, {
					field : 'ORDER_CUSTOM_DATE',
					title : '要求到货期',
					align : 'center',

					width : 90,
					formatter : function(value, row, index) {
						return dateFormatYMD(row.ORDER_CUSTOM_DATE);
					}
				}, {
					field : 'CURRENCY',
					title : '币种',
					align : 'center',

					width : 50,
					formatter : function(value, row, index) {
						return row.CURRENCY;
					}
				}, {
					field : 'PAYMENT_ITEMS',
					title : '付款条件',
					align : 'center',

					width : 200,
					formatter : function(value, row, index) {
						return row.PAYMENT_ITEMS;
					}
				}				
			 ] ],
			 columns : [ [ {
					field : 'SALE_ORG_NAME',
					title : '销售组织',
					align : 'center',

					width : 130,
					formatter : function(value, row, index) {
						return row.SALE_ORG_NAME;
					}
				}, {
					field : 'ORDER_PO_CODE',
					title : '客户订单号',
					align : 'center',

					width : 150,
					formatter : function(value, row, index) {
						return row.ORDER_PO_CODE;
					}
				}, {
					field : 'DEPT_NAME',
					title : '经营体',
					align : 'center',

					width : 120,
					formatter : function(value, row, index) {
						return row.DEPT_NAME;
					}
				}, {
					field : 'CUSTOMER_MANAGER',
					title : '经营体长',
					align : 'center',

					width : 120,
					formatter : function(value, row, index) {
						return row.CUSTOMER_MANAGER;
					}
				}, {
					field : 'START_PORT',
					title : '始发港',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.START_PORT;
					}
				}, {
					field : 'END_PORT',
					title : '目的港',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.END_PORT;
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
					field : 'CUSTOMER_NAME',
					title : '客户名称',
					align : 'center',
					width : 150,
					formatter : function(value, row, index) {
						return row.CUSTOMER_NAME;
					}
				}, {
					field : 'COUNTRY_NAME',
					title : '出口国家',
					align : 'center',

					width : 120,
					formatter : function(value, row, index) {
						return row.COUNTRY_NAME;
					}
				}, {
					field : 'DETAIL_TYPE',
					title : '成交方式',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.DETAIL_TYPE;
					}
				}, {
					field : 'EXECMANAGER_NAME',
					title : '订单执行经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.EXECMANAGER_NAME;
					}
				}, {
					field : 'PROD_NAME',
					title : '产品经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.PROD_NAME;
					}
				}, {
					field : 'TRANS_MANAGER',
					title : '储运经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.TRANS_MANAGER;
					}
				}, {
					field : 'DOC_MANAGER',
					title : '单证经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.DOC_MANAGER;
					}
				}, {
					field : 'REC_MANAGER',
					title : '收汇经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.REC_MANAGER;
					}
				} ] ],
			 onDblClickRow :function(rowIndex,rowData){
				var code=rowData.ORDER_CODE;
				detailCheck4(code);
			}
		});
		
		iframeDialog = $('#iframeDialog').show().dialog({
			title : 'POP弹出页面',
			modal : true,
			closed : true,
			maximizable : true
		});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		searchForm.form('clear');
		datagrid.datagrid('load', sy.serializeObject(searchForm));
		
	}
	function showdetail(code){
		var url='auditMainAction!showResultOfReview.action?orderNum='+code;
		$('#iframe').attr('src',url);
		dialog=$('#iframeDialog').show().dialog({
			title : "订单综合评审详细信息",
			modal : true,
			closed : true,
			minimizable : true,
			maximizable : true
		});
		$("#iframeDialog").dialog("open");
	}
	//刷新详细页面
	function showdetail1(code){
		var url='auditMainAction!showResultOfReview.action?orderNum='+code;
		$('#iframe').attr('src',url);
		dialog=$('#iframeDialog').show().dialog({
			title : "订单综合评审详细信息",
			modal : true,
			closed : true,
			minimizable : true,
			maximizable : true
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
	//刷新代办和已完成代办
	function reloaddata() {
		datagrid.datagrid('reload');
	}
</script>
</head>
<body class="easyui-layout zoc">
	<div data-options="region:'north'"  border="false" class="zoc" collapsed="false"  style="height: 100px;width : 100%;overflow: auto;" align="left">
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
		<table id="datagrid"></table>
	</div>
		
	<div id="iframeDialog" style="display: none;overflow: auto;width: 1200px;height: 500px;">
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:99%;">
    </iframe>
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
						onclick="_CCNMY('_CNNINPUTHISTORY','custCodeId')" />
				</div>
			</div>
		</div>
</div>
</body>
</html>