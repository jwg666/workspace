<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
   var payItemDatagrid;
   //定义变量接收行的值
   var lastIndex;
   var showUseMoneyDialog;
   var confPayItemJson;
   var payMoneyDetail;
   var hiddenCustomerCode;
   $(function(){
	  $.ajax({
	  		   type: "POST",
	  		   url: "${dynamicURL}/salesOrder/salesOrderAction!payMoneyDetailHis.action",
	  		   data: "orderCode=${orderCode}",
	  		   success: function(json){
	  		   		var data = $.parseJSON(json);
	  		   		if(data.msg == null || data.msg == "") {
	  		   			$("#payMoneyForm").form('load',data.obj);
	  		   		}else{
	  		   			$.messager.alert('提示', data.msg,'',function(){
		  					closeCur();
		  				});
	  		   		}
	  		   }
	  });
	  
	  showUseMoneyDialog = $('#showUseMoneyDialog').show().dialog({
		  title : '可用款列表',
		  modal : true,
		  closed : true,
		  maximizable : true,
		  resizable:true
	  });
		//查询列表	
		payMoneyDetail = $('#datagridItem').datagrid({
			url : '${dynamicURL}/payorder/confPayOrderItemAction!datagrid.do',
			queryParams:{
				orderNum:'${orderCode}'
			},
			title : '用款查询',
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
			
			columns : [ [ 
			   {field:'orderLinecode',title:'序号',align:'center',sortable:true,
					formatter:function(value,row,index){
						value = ++index;
						row.orderLinecode = value;
						return value;
					}
				},          
			   {field:'paymentMethodName',title:'付款方式',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.paymentMethodName;
					}
				},													
			   {field:'currency',title:'币种',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.currency;
					}
				},
			   {field:'amount',title:'本次付款金额',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.amount;
					}
			   },
			   {field:'payCode',title:'款项编号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.payCode;
					}
				}
			 ] ]
		});
   });
   //可用款页面
   function updateBmTender(){
	   var url = "${dynamicURL}/payorder/paymentTermsAction!showUseMoneyItem.action?payTermsCode="+$('#hiddenPayTerms').val()+"&orderCode="+$('#tenderCode').val();
	   $('#useMoneyIframe').attr("src",url); 
	   showUseMoneyDialog.dialog('open'); 
	   hiddenCustomerCode = $('#hiddenCustomerCode').val();
   }
   
   /*付款方法*/
   function checkBmTender(){
	   var payMoneyDetailData = $("#datagridItem").datagrid("getRows");
	   var seriForm = $("#payMoneyForm").serializeArray();
	   var jsonSeriForm = arrayToJson(seriForm);
	   jsonSeriForm["payMoneyDetailList"] = JSON.stringify(payMoneyDetailData);
	   
	   $.ajax({
		   type: "POST",
		   url: "${dynamicURL}/salesOrder/salesOrderAction!singleConfPayMoney.action",
		   data:jsonSeriForm,
		   success: function(json){
		   		var data = $.parseJSON(json);
		   }
	   });
   }
   //将ARRY转为json对象
   function arrayToJson(formValues) {
		var result = {};
		for ( var formValue, j = 0; j < formValues.length; j++) {
			formValue = formValues[j];
			var name = formValue.name;
			var value = formValue.value;
			result[name] = value;
			continue;
		}
		return result;
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" class="zoc" collapsed="false" style="overflow:auto;" align="left">
			<form id="payMoneyForm">
			<div id="center" class="part_zoc" >
				<div class="navhead_zoc">
					<span>付款保障办理</span>
				</div>
				<div class="part_zoc">
					<div class="partnavi_zoc">
						<span>付款保障办理：</span>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">订单号：</div>
							<div class="righttext">
								<input id="tenderCode" name="orderCode" type="text" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">订单币种：</div>
							<div class="rightselect_easyui">
								<input name="currency" type="text" id="currency" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">总金额：</div>
							<div class="rightselect_easyui">
								<input name="amount" type="text" id="amount" disabled="disabled"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">经营体长：</div>
							<div class="rightselect_easyui">
								<input name=orderCustName type="text" id="orderCustName" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">产品经理：</div>
							<div class="rightselect_easyui">
								<input name="orderProdName" type="text" id="orderProdName" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">订单执行经理：</div>
							<div class="rightselect_easyui">
								<input name="orderExecName" type="text" id="orderExecName" disabled="disabled"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">客户名称：</div>
							<div class="rightselect_easyui">
								<input name="contractCustName" type="text" id=contractCustName disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">SOLD_TO：</div>
							<div class="righttext">
								<input id="orderSoldTo" name="orderSoldTo" type="text" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">客户PO：</div>
							<div class="righttext">
								<input id="orderPoCode" name="orderPoCode" type="text" disabled="disabled"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">市场区域：</div>
							<div class="righttext">
								<input id="saleAreaName" name="saleAreaName" type="text" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">出口国家：</div>
							<div class="righttext">
								<input id="countryName" name="countryName" type="text" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">执行付款条件：</div>
							<div class="righttext">
								<input id="usedPayType" name="usedPayType" type="text" disabled="disabled"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">订单付款方式：</div>
							<div class="righttext">
								<input id="orderPaymentMethodName" name="orderPaymentMethodName" type="text" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">订单付款周期：</div>
							<div class="righttext">
								<input id="orderPaymentCycle" name="orderPaymentCycle" type="text" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">订单付款条件：</div>
							<div class="righttext">
								<input id="orderPaymentTermsName" name="orderPaymentTermsName" type="text" disabled="disabled"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">合同付款方式：</div>
							<div class="righttext">
								<input id="contractPaytypeName" name="contractPaytypeName" type="text" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">合同付款周期：</div>
							<div class="righttext">
								<input id="contractPaymentCycle" name="contractPaymentCycle" type="text" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">合同付款条件：</div>
							<div class="righttext">
								<input id="contractPayConditionName" name="contractPayConditionName" type="text" disabled="disabled"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">二次付款：</div>
							<div class="righttext">
								<input id="secondPay" name="secondPay" type="text" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">100%T/T：</div>
							<div class="righttext">
								<input id="payAllTT" name="payAllTT" type="text" disabled="disabled"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">付款100%完成：</div>
							<div class="righttext">
								<input id="payFinish" name="payFinish" type="text" disabled="disabled"/>
							</div>
						</div>
					</div>
			</div>
			</div>
			</form>
		</div>
		
		
	 	<div region="center" border="false" class="zoc">
	   		<table id="datagridItem"></table>
	 	</div>
</body>
</html>