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
   var isPayOneFinished;
   var amount;
   var showAmount;
   var currency;
   var toUsaExchange;
   var toCnyExchange;
   var orderNum;
   var salesOrgCode;
   var salesOrgName;
   var orderShipDate;
   $(function(){
	  var taskIdValue = $("#taskId").val();
	  $.messager.progress({
			text : '<s:text name="the.data.load">数据加载中......</s:text>',
			interval : 100
	  });
	  $.ajax({
		   type: "POST",
		   url: "${dynamicURL}/salesOrder/salesOrderAction!singlePayMoneyOverdue.action",
		   data: "orderCode=${orderCode}",
		   dataType:'json',
		   success: function(json){
		     if(json.msg != ""){
		    	$.messager.progress('close');   
		    	$("#payMoneyForm").find("input[type='button']").css('display','none');
		    	$.messager.confirm('<s:text name="global.form.prompt">提示</s:text>', json.msg, function(r){
	                if(r){
	                	 $.ajax({
	      		  		   type: "POST",
	      		  		   url: "${dynamicURL}/salesOrder/salesOrderAction!applyRelease.action",
	      		  		   data: "orderCode=${orderCode}",
	      		  		   success: function(json){
	      		  			   var data = $.parseJSON(json);
	      		  			   if('null' == data.msg || '' == data.msg ) {
	      		  				 parent.window.HROS.window.createTemp({
	      			    			 title:"-<s:text name='global.order.number'>订单号</s:text>:${orderCode}，<s:text name='global.payOrderItem.apply'>释放闸口申请</s:text>！",
	      			    			 url:'${dynamicURL}/overdue/arOverdueAction!goOperationOverdue.do',
	      			    			 width:800,height:400,isresize:true,isopenmax:true,isflash:false,customWindow:window});
	      		  				 closeCur();
	      		  			   }else{
		      		  				$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', data.msg,'',function(){
		      		  					closeCur();
		      		  					customWindow.refresh();
		      		  				});  		  				   
	      		  			   }
	      		  		   }
	                	 });  
	                }else{
	  					closeCur();
	  					customWindow.refresh();
	                }
	            });
		     }else{
		    	 $.ajax({
		  		   type: "POST",
		  		   url: "${dynamicURL}/salesOrder/salesOrderAction!payMoneyDetail.action",
		  		   data: "orderCode=${orderCode}&taskId="+taskIdValue,
		  		   dataType:'json',
		  		   success: function(json){
		  			 	$.messager.progress('close');  
// 		  		   		var data = $.parseJSON(json);
						if(json.msg == null || json.msg == "") {
		  		   			$("#payMoneyForm").form('load',json.obj);
						}else{
							$.messager.alert('<s:text name="global.form.prompt">提示</s:text> ', json.msg,'',function(){
      		  					closeCur();
      		  				});
						}
		  		   }
		  	   });
		     }
		   }
	  });
	  
	  showUseMoneyDialog = $('#showUseMoneyDialog').show().dialog({
		  title : '<s:text name="global.payMoney.warn1">可用款列表</s:text>',
		  modal : true,
		  closed : true,
		  maximizable : true,
		  resizable:true
	  });
		//查询列表	
		payMoneyDetail = $('#datagridItem').datagrid({
			title : '<s:text name="global.payOrderItem.search">用款查询</s:text>',
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
			
			showFooter: true,  
			columns : [ [ 
			   {field:'orderLinecode',title:'序号',align:'center',sortable:true,width:50,
					formatter:function(value,row,index){
						value = ++index;
						row.orderLinecode = value;
						return value;
					}
				},          
			   {field:'paymentMethodName',title:'付款方式',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.paymentMethodName;
					}
				},													
			   {field:'currency',title:'币种',align:'center',sortable:true,width:50,
					formatter:function(value,row,index){
						return row.currency;
					}
				},
			   {field:'useMoney',title:'本次付款金额',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.useMoney;
					},
					editor:{
						type:'numberbox',
						options:{
							precision:4
						}
					}
			   },
			   {field:'payCode',title:'款项编号',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.payCode;
					}
				}
			 ] ],
			onLoadSuccess: function(data){
				if(data.rows.length>0){
					$($(this).prev().find("table.datagrid-htable td[field='useMoney'] span").get(0)).text("本次付款金额(" + $("#currency").val() + ")");
				}
			}
		});
   });
   //可用款页面
   function updateBmTender(){
	   var url = "${dynamicURL}/payorder/paymentTermsAction!showUseMoneyItem.action?termsCode="+$('#hiddenPayTerms').val()+"&orderCode="+$('#tenderCode').val()+"&payTimesFlag="+$('#hiddenPayOneFinished').val();
	   parent.window.HROS.window.createTemp({
			title:'可用款界面(可用款项均已转为订单币种)',
			url:url,
			width:800,height:400,isresize:true,isopenmax:true,isflash:false,customWindow:window});
// 	   $('#useMoneyIframe').attr("src",url); 
// 	   showUseMoneyDialog.dialog('open');
	   hiddenCustomerCode = $('#hiddenCustomerCode').val();
	   isPayOneFinished = $('#hiddenPayOneFinished').val();
	   showAmount = $("#balance").val();
	   amount = $('#balance').val();
	   currency = $('#currency').val();
	   orderNum = $('#tenderCode').val();
	   toUsaExchange = $('#toUsaExchange').val();
	   toCnyExchange = $('#toCnyExchange').val();
	   salesOrgCode = $('#salesOrgCode').val();
	   salesOrgName = $('#salesOrgName').val();
	   orderShipDate = $('#orderShipDate').val();
   }
   
   /*付款方法*/
   function checkBmTender(){
	   var payMoneyDetailData = $("#datagridItem").datagrid("getRows");
	   var len = payMoneyDetailData.length;
	   if(len > 0) {
		   $.messager.progress({
				text : '<s:text name="global.payMoney.warn2">数据提交中，将付款状态同步到SAP....</s:text>',
				interval : 100
		   });
		   var seriForm = $("#payMoneyForm").serializeArray();
		   var jsonSeriForm = arrayToJson(seriForm);
		   jsonSeriForm["payMoneyDetailList"] = JSON.stringify(payMoneyDetailData);
		   
		   $.ajax({
			   type: "POST",
			   url: "${dynamicURL}/salesOrder/salesOrderAction!singleConfPayMoney.action",
			   data:jsonSeriForm,
			   success: function(json){
			   		var data = $.parseJSON(json);
			   		$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', data.msg,'',function(){
			   			$.messager.progress('close');
			   			closeCur();
						customWindow.refresh();
			   		});
			   }
		   });
	   }else{
		   $.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.payMoney.warn3">请您先选择用户的可用款项，再进行保存</s:text>！','info');
	   }
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
   
   function closeCur(){
		window.parent.HROS.window.close(currentappid);
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
						<span>付款保障办理:</span>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">订单号：</div>
							<div class="righttext">
								<input id="tenderCode" readonly="readonly" name="orderCode" type="text"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">订单币种：</div>
							<div class="rightselect_easyui">
								<input name="currency" readonly="readonly" type="text" id="currency"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">成交方式：</div>
							<div class="righttext">
								<input id="orderDealTypeName" readonly="readonly" name="orderDealTypeName" type="text"/>
							</div>
						</div>
						<div class="item25  lastitem">
							<div class="itemleft">销售组织：</div>
							<div class="righttext lastitem">
								<input id="salesOrgName" readonly="readonly" style="width:100px;" name="salesOrgName" type="text"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">经营体长：</div>
							<div class="rightselect_easyui">
								<input name=orderCustName readonly="readonly" type="text" id="orderCustName"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">产品经理：</div>
							<div class="rightselect_easyui">
								<input name="orderProdName" readonly="readonly" type="text" id="orderProdName"/>
							</div>
						</div>
						<div class="item33 lastitem">
							<div class="itemleft">订单执行经理：</div>
							<div class="rightselect_easyui">
								<input name="orderExecName" readonly="readonly" type="text" id="orderExecName"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">合同编号：</div>
							<div class="rightselect_easyui">
								<input name="contractCode" readonly="readonly" type="text" id="contractCode"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">售达方：</div>
							<div class="righttext">
								<input id="customerName" readonly="readonly" name="customerName" type="text"/>
							</div>
						</div>
						<div class="item33 lastitem">
							<div class="itemleft">客户PO：</div>
							<div class="righttext">
								<input id="orderPoCode" readonly="readonly" name="orderPoCode" type="text"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">市场区域：</div>
							<div class="righttext">
								<input id="saleAreaName" readonly="readonly" name="saleAreaName" type="text"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">出口国家：</div>
							<div class="righttext">
								<input id="countryName" readonly="readonly" name="countryName" type="text"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">执行付款条件：</div>
							<div class="righttext">
								<input id="usedPayType" readonly="readonly" name="usedPayType" type="text"/>
							</div>
						</div>
						<div class="item25  lastitem">
							<div class="righttext lastitem">
								<input id="execTermsDetail" readonly="readonly" style="width:300px;" name="execTermsDetail" type="text"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">订单付款方式：</div>
							<div class="righttext">
								<input id="orderPaymentMethodName" readonly="readonly" name="orderPaymentMethodName" type="text"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">订单付款周期：</div>
							<div class="righttext">
								<input id="orderPaymentCycle" readonly="readonly" name="orderPaymentCycle" type="text"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">订单付款条件：</div>
							<div class="righttext">
								<input id="orderPaymentTermsName" readonly="readonly" name="orderPaymentTermsName" type="text"/>
							</div>
						</div>
						<div class="item25  lastitem">
							<div class="righttext">
								<input id="orderTermsDetail" readonly="readonly" style="width:300px;" name="orderTermsDetail" type="text"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">合同付款方式：</div>
							<div class="righttext">
								<input id="contractPaytypeName" readonly="readonly" name="contractPaytypeName" type="text"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">合同付款周期：</div>
							<div class="righttext">
								<input id="contractPaymentCycle" readonly="readonly" name="contractPaymentCycle" type="text" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">合同付款条件：</div>
							<div class="righttext">
								<input id="contractPayConditionName" readonly="readonly" name="contractPayConditionName" type="text"/>
							</div>
						</div>
						<div class="item25  lastitem">
							<div class="righttext lastitem">
								<input id="contractTermsDetail" readonly="readonly" style="width:300px;" name="contractTermsDetail" type="text"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">二次付款：</div>
							<div class="righttext">
								<input id="secondPay" readonly="readonly" name="secondPay" type="text"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">100%T/T：</div>
							<div class="righttext">
								<input id="payAllTT" readonly="readonly" name="payAllTT" type="text"/>
							</div>
						</div>
						<div class="item33  lastitem">
							<div class="itemleft">付款100%完成：</div>
							<div class="righttext">
								<input id="payFinish" readonly="readonly" name="payFinish" type="text"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">总金额：</div>
							<div class="righttext">
								<input id="amount" readonly="readonly" name="amount" type="text"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">本次付款金额：</div>
							<div class="rightselect_easyui">
								<input name="balance" readonly="readonly" type="text" id="balance"/>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">兑美元汇率：</div>
							<div class="rightselect_easyui">
								<input name="toUsaExchange" readonly="readonly" type="text" id="toUsaExchange"/>
							</div>
						</div>
						<div class="item25  lastitem">
							<div class="itemleft">兑人民币汇率：</div>
							<div class="righttext lastitem">
								<input id="toCnyExchange" readonly="readonly" style="width:100px;" name="toCnyExchange" type="text"/>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item100 lastitem">
							<div class="oprationbutt">
								<input type="button" id="update" onclick="updateBmTender();" value="选择用款"/>
								<input type="button" id="check" onclick="checkBmTender();" value="保存"/>
							</div>
						</div>
					</div>
			</div>
			</div>
			<input type="hidden" id="hiddenPayTerms" name="usedPayTypeCode"/>
			<input type="hidden" id="hiddenPayNums" name="userPayTypeNums"/>
			<input type="hidden" id="hiddenBalance" name="balance"/>
			<input type="hidden" id="hiddenOneAllTT" name="payOneAllTT"/>
			<input type="hidden" id="hiddenPayOneFinished" name="isPayOneFinished"/>
			<input type="hidden" id="hiddenPayTerms" name="paymentTerms"/>
			<input type="hidden" id="hiddenCustomerCode" name="customerCode"/>
			<input type="hidden" id="taskId" name="taskId" value="${taskId}"/>
			<input type="hidden" id="secondPayCode" name="secondPayCode" />
			<input type="hidden" id="amountMoney" name="amount" />
			<input type="hidden" id="toUsaExchange" name="toUsaExchange"  />
			<input type="hidden" id="toCnyExchange" name="toCnyExchange" />
			<input type="hidden" id="salesOrgCode" name="salesOrgCode" />
			<input type="hidden" id="orderShipDate" name="orderShipDate" />
			</form>
		</div>
		
		
	 	<div region="center" border="false" class="zoc">
	   		<table id="datagridItem"></table>
	 	</div>
		
	   <div id="showUseMoneyDialog" style="display: none;overflow: hidden;width: 800px;height: 400px;">
           <iframe name="useMoneyIframe" id="useMoneyIframe" src="#"  scrolling="auto" frameborder="0" style="width:1000px;height:100%;">
              
           </iframe>
	   </div>
</body>
</html>