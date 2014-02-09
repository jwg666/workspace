<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var confPayOrderAddDialog;
	var confPayOrderAddForm;
	var cdescAdd;
	var confPayOrderEditDialog;
	var confPayOrderEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP
		});
		$('#' + inputId).val(_CCNTEMP);
	}
	$(function() {
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
		$('#ifquanbu1').combobox('setValue','0');
	    //查询列表	
	    searchForm = $('#searchForm').form();
	    datagrid = $('#datagrid').datagrid({
	    	url : '../salesOrder/salesOrderAction!payOrderdatagrid.action',
			title : '付款保障主表列表',
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
				}, {
					field : 'PAY_FINISHED_FLAG',
					title : '付款保障',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						if(row.PAY_FINISHED_FLAG==null||row.PAY_FINISHED_FLAG==''){
							return '尚未开始';
						}else if(row.PAY_FINISHED_FLAG=='0'){
							return '尚未完成'
						}else if(row.PAY_FINISHED_FLAG=='1'){
							return '已经完成';
						}else{
							return '无法识别';
						}
					}
				}, {
					field : 'ORDER_TYPE',
					title : '订单类型',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
							return row.ORDER_TYPE;
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
				showPayOrderDetail(code);
			}
		});

	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function _cleanSearch() {	
		searchForm.form('clear');
		datagrid.datagrid('load',sy.serializeObject(searchForm));
	}
	function showPayOrderDetail(orderCode){
		var url='../payorder/confPayOrderAction!showPayOrderdetail.action?orderCode='+orderCode;
		$('#iframe').attr('src',url);
		dialog=$('#iframeDialog').show().dialog({
			title : "订单过付款明细",
			modal : true,
			closed : true,
			minimizable : true,
			maximizable : true
		});
		$("#iframeDialog").dialog("open");
	}
</script>
</head>
<body class="easyui-layout zoc">
<div region="north" border="false" title="过滤条件" collapsed="true"  style="height: 150px;overflow: hidden;" align="left">
	<div data-options="region:'north'"  border="false" class="zoc" collapsed="false"  style="height: 169px;width : 100%;overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc"><span>订单付款保障查询</span></div>
			<div class="part_zoc" region="north">
			<div class="oneline">
			      <div class="item25">
				    <div class="itemleft80">
					    订单号
					</div>
					<div class="righttext">
					<input name="orderCode" class="short50"  type="text"/>
					</div>
				 </div>
			     <div class="item25">
						<div class="itemleft80">客户:</div>
						    <div class="righttext_easyui">
								    <input name="orderSoldTo" type="text" id="custCodeId"
									class="short50" />
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
				    <div class="itemleft80">
					    过付款
					</div>
					<div class="righttext">
					<s:textfield id="ifquanbu1" name="ifquanbu1" cssClass="easyui-combobox short50" type="text" data-options="
		                          valueField: 'code',
		                          textField: 'name',
		                          data: [{
			                      code: '0',
			                      name: '已完成'
		                          },{
		                          code:'1',
		                          name:'未完成'
		                          },{
		                          code:'2',
		                          name:'全部订单'
		                          }]">
					
					</s:textfield>
					</div>
				 </div>
			    </div>
			    <div class="oneline">
			        <div class="item25">
								<div class="itemleft80">出口国家:</div>
								<div class="righttext_easyui">
									<input name="countryCode" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'countryCode',textField:'name',url:'${dynamicURL}/basic/countryAction!combox.do'" />
								</div>
							</div>
				 <div class="item25">
				    <div class="itemleft80">
					   订单创建时间  从
					</div>
					<div class="righttext">
					<input name="createdStart" class="easyui-datetimebox short50"  type="text" />
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					    到
					</div>
					<div class="righttext">
					<input name="createdEnd"  class="easyui-datetimebox short50" type="text"  />
					</div>
				 </div>
			    </div>
			     
			</div>
		</form>
		        <div class="oneline">
			        <div class="item100">
				        <div class="oprationbutt">
					       <input type="button" value="查询" onclick="_search();"/>
					       <input type="button" value="清空" onclick="_cleanSearch();"/>
				        </div>
				    </div>
			     </div>
	</div>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	
	<div id="iframeDialog" style="display: none;overflow: auto;width: 1000px;height: 600px;">
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:99%;">
    </iframe>
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

</body>
</html>