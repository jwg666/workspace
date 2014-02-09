<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	var confPayOrderAddDialog;
	var confPayOrderAddForm;
	var cdescAdd;
	var confPayOrderEditDialog;
	var confPayOrderEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	var codeNumOfOrder;
	function showpaydetail(){
		//查询订单付款保障的详细信息
		$.ajax({
			   type: "POST",
			   url: "${dynamicURL}/salesOrder/salesOrderAction!showPayOrderDetail.action",
			   data: "orderCode=${orderCode}",
			   success: function(json){
			   		var data = $.parseJSON(json);
			   		if(data.success){
			   			$("#searchForm").form('load',data.obj);
			   			var amount=$('#amountIdaa').val()
			   			if(amount!=null&&amount!=''){
			   				$('#amountIdaa').val(Number(amount).toFixed(2));
			   			}
			   		}else{
			   			$("#searchForm").form('load',data.obj);
			   			var amount=$('#amountIdaa').val()
			   			if(amount!=null&&amount!=''){
			   				$('#amountIdaa').val(Number(amount).toFixed(2));
			   			}
			   			$.messager.alert('提示',data.msg,'error');
			   		}
			   		
			   }
		   });
	}
	$(function() {
		showpaydetail();
	    //查询列表
	    codeNumOfOrder=$('#codeOfOrder').val();
		datagrid = $('#datagrid').datagrid({
			url : '../payorder/confPayOrderItemAction!datagrid0.action?orderNum='+codeNumOfOrder,
			title : '详细表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			singleSelect : true,
			//idField : 'actConfPayCode',
			
			columns : [ [
			   {field:'paymentMethod',title:'付款方式',align:'center',sortable:true,width:4,
					formatter:function(value,row,index){
						return row.paymentMethod;
					}
				},				
			   {field:'currency',title:'币种',align:'center',sortable:true,width:4,
					formatter:function(value,row,index){
						return row.currency;
					}
				},				
			   {field:'amount',title:'金额',align:'center',sortable:true,width:4,
					formatter:function(value,row,index){
						return row.amount;
					}
				},
			   {field:'payCode',title:'款项编号',align:'center',sortable:true,width:4,
					formatter:function(value,row,index){
						return row.payCode;
					}
				}	
			 ] ]
		});

	});

</script>
</head>
<body class="easyui-layout zoc">
<s:hidden name="orderCode" id="codeOfOrder"></s:hidden>
<div region="north" border="false" title="主体信息" collapsed="false"  style="height: 220px;overflow: hidden;" align="left">
	<div data-options="region:'north'"  border="false" class="zoc" collapsed="false"  style="height: 219px;width : 100%;overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc"><span>订单过付款明细信息</span></div>
			<div class="part_zoc" region="north">
			<div class="oneline">
			     <div class="item25">
				    <div class="itemleft80">
					    订单号
					</div>
					<div class="righttext">
					<input id="tenderCode" class="short50" name="orderCode" type="text"/>
					</div>
				 </div>
			     <div class="item25">
				    <div class="itemleft80">
					    订单币种
					</div>
					<div class="righttext">
					<input name="currency" class="short50" type="text" id="currency"/>
					</div>
				 </div>
			     <div class="item25">
				    <div class="itemleft80">
					    总金额
					</div>
					<div class="righttext">
					<input name="amount" type="text" class="short50" id="amountIdaa"/>
					</div>
				 </div>
			     <div class="item25">
				    <div class="itemleft80">
					    经营体长
					</div>
					<div class="righttext">
					<input name="orderCustNamager" type="text" class="short50" id="orderCustNamager"/>
					</div>
				 </div>
			    </div>
			    <div class="oneline">
			        <div class="item25">
				    <div class="itemleft80">
					    产品经理
					</div>
					<div class="righttext">
					<input name="orderProdManager" type="text" class="short50" id="orderProdManager"/>
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					   订单执行经理
					</div>
					<div class="righttext">
					<input name="orderExecManager" type="text" class="short50" id="orderExecManager"/>
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					    客户名称
					</div>
					<div class="righttext">
					<input name="custCode" type="text" class="short50" id="custName"/>
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					    SOLD_TO
					</div>
					<div class="righttext">
					<input id="orderSoldTo" name="orderSoldTo" class="short50" type="text"/>
					</div>
				 </div>
			    </div>
			     
			     <div class="oneline">
			     <div class="item25">
				    <div class="itemleft80">
					    客户PO
					</div>
					<div class="righttext">
					<input id="orderPoCode" name="orderPoCode" class="short50" type="text"/>
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					   市场区域
					</div>
					<div class="righttext">
					<input id="saleAreaName" name="saleAreaName" class="short50" type="text"/>
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					    出口国家
					</div>
					<div class="righttext">
					<input id="countryName" name="countryName" class="short50" type="text"/>
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					    执行付款条件
					</div>
					<div class="righttext">
					<input id="usedPayType" name="usedPayType" class="short50" type="text"/>
					</div>
				 </div>
			     </div>
			     
			     
			     <div class="oneline">
			     
			     <div class="item25">
				    <div class="itemleft80">
					    二次付款
					</div>
					<div class="righttext">
					<input id="secondPay" name="secondPay" class="short50" type="text"/>
					</div>
				 </div>
			     <div class="item25">
				    <div class="itemleft80">
					    订单付款方式
					</div>
					<div class="righttext">
					<input id="orderPaymentMethod" class="short50" name="orderPaymentMethod" type="text"/>
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					   订单付款周期
					</div>
					<div class="righttext">
					<input id="orderPaymentCycle" class="short50" name="orderPaymentCycle" type="text"/>
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					    订单付款条件
					</div>
					<div class="righttext">
					<input id="orderPaymentTermsName" class="short50" name="orderPaymentTermsName" type="text"/>
					</div>
				 </div>
			     </div>
			     <div class="oneline">
			     <div class="item25">
				    <div class="itemleft80">
					    100%T/T
					</div>
					<div class="righttext">
					<input id="" name="payAllTT" class="short50" type="text"/>
					</div>
				 </div>
			     <div class="item25">
				    <div class="itemleft80">
					    和同付款方式
					</div>
					<div class="righttext">
					<input id="htPayMethod" class="short50" name="htPayMethod" type="text"/>
					</div>
				 </div>
			     <div class="item25">
				    <div class="itemleft80">
					   合同付款周期
					</div>
					<div class="righttext">
					<input id="contractPaymentCycle" class="short50" name="htPayCycle" type="text" />
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					   合同付款条件
					</div>
					<div class="righttext">
					<input id="contractPayConditionName" class="short50" name="contractPayConditionName" type="text"/>
					</div>
				 </div>
				 
				 
			     </div>
			     <div class="oneline">
			         <div class="item25">
				    <div class="itemleft80">
					    付款100%完成
					</div>
					<div class="righttext">
					<input id="" name="payFinish" class="short50" type="text"/>
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					    成交方式
					</div>
					<div class="righttext">
					<input id="" name="orderDealType" class="short50" type="text"/>
					</div>
				 </div>
			     </div>
			</div>
		</form>
	</div>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	
	<!-- <div id="iframeDialog" style="display: none;overflow: auto;width: 600px;height: 400px;">
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:100%;">
    </iframe>
</div>  -->
</body>
</html>