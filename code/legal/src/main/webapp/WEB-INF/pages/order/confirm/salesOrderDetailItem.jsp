<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var salesOrderSaveForm;
	var salesOrdeCode = '${orderCode}';
    var orderType = '${orderType}';
	//加载订单相信信息
	$(function(){
		//加载装运方法信息
		$('#orderTransType').combobox({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectTransType.action',
			valueField:'itemCode',  
		    textField:'itemNameCn'
		});
		//加载装箱方法信息
		$('#packageType').combobox({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectPackageType.action',
			valueField:'itemCode',  
		    textField:'itemNameCn'
		});
		$.ajax({
	   	     url:"${dynamicURL}/salesOrder/salesOrderAction!selectSalesOrderDetailInfo.action",
	   	     data:{
	   	    	    orderCode:'${orderCode}'
	   	    	  },
	   	     dataType:"json",
	   	     type:'post',
	   	     success:function(data){
		   		$("#salesOrderSaveForm").form('load',data);
		   	    //增加title
		   	    $("#salesOrderSaveForm").find(":text").each(function(){
		   			if($(this).attr("name")!=null && $(this).attr("title")!=null){
		   				$(this).attr("title",$(this).val());
		   			}
		   		});
	   	     }
		});
		//加载工厂下拉列表
		$('#factoryCode').combogrid({
			 url:'${dynamicURL}/basic/factoryConfAction!datagrid.do?accountsFactoryCode='+'${factoryCode}',
			 idField:'productFactoryCode',  
			 textField:'productFactoryName',
		     panelWidth : 500,
			 panelHeight : 220,
			 pagination : true,
			 pagePosition : 'bottom',
			 toolbar : '#_factoryItem',
			 rownumbers : true,
			 pageSize : 5,
			 pageList : [ 5, 10 ],
			 fit : true,
			 fitColumns : true,
			 editable : false,
			 columns : [ [ {
				field : 'productFactoryCode',
				title : '<s:text name="orderConfirm.productFactoryCode">生产工厂编码</s:text>',
				width : 20
			 },{
				field : 'productFactoryName',
				title : '<s:text name="orderConfirm.productFactoryName">生产工厂名称</s:text>',
				width : 20
			 }  ] ]
		});
	});
	//下载附件
	function downLoad(){
		var attachmentCode= $('#orderAttachments').val();
		if(attachmentCode == null || attachmentCode == ""){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.orderNoAttach">此订单没有附件！</s:text>','info');
		}else{
			window.location.href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId="+attachmentCode;
		}
	}
	//模糊查询 生产工厂下拉列表
	function _FACTORYMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/factoryConfAction!datagrid.do?accountsFactoryCode='+'${factoryCode}'+'&productFactoryCode='+_CCNCODE+'&productFactoryName='+_CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询 生产工厂输入框
	function _FACTORYMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/factoryConfAction!datagrid.do?accountsFactoryCode='+'${factoryCode}'
				});
	}
	//修改订单的工厂、装运方式和装箱方式，工厂在分备货单后不能修改
	function updateSalesOrderInfo(){
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中....</s:text>',
			interval : 100
		});
		//获取装运方式
		var orderTransTypeCode;
		var orderTransTypeParam = $('#orderTransTypeName').val();
		if(orderTransTypeParam == null || orderTransTypeParam == "" ){
			orderTransTypeCode = $('#orderTransType').combobox('getValue')
		}
		//获取装箱方式
		var packageTypeCode;
		var packageTypeParam = $('#packageTypeName').val();
		if(packageTypeParam == "" || packageTypeParam == null){
			packageTypeCode = $('#packageType').combobox('getValue')
		}
		//获取工厂信息
		var factoryNameParm = $('#factoryName').val();
		var factoryCodes;
		if(factoryNameParm == null ||factoryNameParm == ""){
			//生产工厂
			factoryCodes = $('#factoryCode').combogrid('getValue'); 
		}
		if(orderTransTypeCode == "NULL"){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.transTypeValidator">装运方式不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(packageTypeCode == "NULL"){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.packageTypeValidator">装箱方式不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(factoryNameParm == null ||factoryNameParm == ""){
			if(factoryCodes == "" || factoryCodes == null){
				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.factoryValidator">生产工厂不能为空,请检查！</s:text>','info');
				$.messager.progress('close');
			}else{
				commonUpdateInfo(orderTransTypeCode, packageTypeCode, factoryCodes);
			}
		}else{
			commonUpdateInfo(orderTransTypeCode, packageTypeCode, factoryCodes);
		}
	}
	//公用的修改信息提交方法
	function commonUpdateInfo(orderTransTypeCode, packageTypeCode, factoryCodes){
		$.ajax({
			url:'{dynamicURL}/salesOrder/salesOrderAction!updateSalesOrderInfo.action',
			dataType:'json',
			type:"post",
			data:{
				orderCode : $('#orderCode').val(),
				orderTransType : orderTransTypeCode,
				packageType : packageTypeCode,
				factoryCode : factoryCodes
			},
			success:function(data){
				if(data.success){
					$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>',data.msg,'info');
					$.messager.progress('close');
					$('#factoryCode').combogrid('clear');
				}else{
					$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>',data.msg,'info');
					$.messager.progress('close');
				}
				$.messager.progress('close');
			}
		});
	}
</script>
</head>
<body class="easyui-layout">
     <div region="north"   split="true" style="height:350px;"  collapsed="false" >
        <form id="salesOrderSaveForm" method="post" enctype="multipart/form-data">
	        <div class="part_zoc" style="margin:0px 0px 0px 0px;">
	            <s:hidden id="orderCode" name="orderCode" />
				<div class="partnavi_zoc">
					<span>订单状态：</span>
				</div>
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100">导HGVS：</div>
						<div class="rightcheckbox">
							<input id="orderHgvsFlag" name="orderHgvsFlag" class="short30"  type="checkbox" disabled="true"  value="1" />
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">外销快递：</div>
						<div class="rightcheckbox">
							<input id="orderExpressFlag" name="orderExpressFlag" class="short50"  type="checkbox" disabled="true" value="1" />
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">商检：</div>
						<div class="rightcheckbox">
							<input id="orderInspectionFlag" name="orderInspectionFlag" class="short50" type="checkbox" disabled="true" value="1" />
						</div>
				    </div>
				    <div class="item25 lastitem">
				        <div class="itemleft100">T模式：</div>
				        <div class="righttext">
				            <input id="tmodelName"  name="tmodelName"  class="short50"  disabled="true" type="text" title=""/>
				        </div>
				    </div>
				</div>
				<div class="oneline">
				    <s:if test="factoryFlag == 1">
				        <div class="item25">
				        	<div class="itemleft100">生产工厂：</div>
							<div class="righttext">
								<input id="factoryName" name="factoryName" class="short50"   type="text" disabled="true" title=""/>
							</div>
				    	</div>
				    </s:if>
				    <s:else>
				        <div class="item25">
				        	<div class="itemleft100">生产工厂：</div>
							<div class="righttext">
								<input id="factoryCode" name="factoryCode" class="short50"   type="text"/>
							</div>
				    	</div>
				    </s:else>
				    <s:if  test="updateFlag == 1">
				        <div class="item25">
							<div class="itemleft100">装运方式：</div>
							<div class="righttext">
								<input id="orderTransTypeName" name="orderTransTypeName" class="short50"   type="text" disabled="true" title=""/>
							</div>
				    	</div>
				    	<div class="item25">
				        	<div class="itemleft100">装箱方式：</div>
							<div class="righttext">
								<input id="packageTypeName" name="packageTypeName" class="short50"   type="text" disabled="true" title=""/>
							</div>
				    	</div>
				    </s:if>
				    <s:else>
				         <div class="item25">
						    <div class="itemleft100">装运方式：</div>
						    <div class="righttext">
							    <input id="orderTransType" name="orderTransType" class="short50"   type="text" />
						    </div>
				         </div>
				         <div class="item25">
				            <div class="itemleft100">装箱方式：</div>
						    <div class="righttext">
							    <input id="packageType" name="packageType" class="short50"   type="text" />
						     </div>
			    		 </div>
				    </s:else>
				     <div class="item33 lastitem">
						<div class="itemleft60">附件：</div>
						<div class="righttext">
						    <input  type="hidden"  id="orderAttachments"  name="orderAttachments" />
						    <div class="oprationbutt">
			                     <input type="button" value="<s:text name="order.confirm.downFile">下载附件</s:text>" onclick="downLoad();"/>
			                 </div>
						</div>
				    </div>
				   
				</div>
				<s:if  test="(updateFlag != 1 && factoryFlag == 1) ||(updateFlag == 1 && factoryFlag != 1) ||(updateFlag != 1 && factoryFlag != 1)">
				    <div  class="oneline">
				     <div class="item100 lastitem">
				        <div class="oprationbutt">
				            <input type="button" value="修   改" onclick="updateSalesOrderInfo()"/>
				        </div>
				    </div>
				</div>
				</s:if>
			</div>
	        <div class="part_zoc"  style="margin:0px 0px 0px 0px;">
	            <div class="partnavi_zoc">
						<span>订单信息：</span>
				</div>
				<div class="oneline">
				    <div class="item25">
							<div class="itemleft100">订单编号：</div>
							<div class="righttext">
								<input id="orderCode" name="orderCode"  disabled="true"  type="text"
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100">合同编号：</div>
							<div class="righttext">
								<input id="contractCode" name="contractCode"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
				    <div class="item25">
							<div class="itemleft100">订单类型：</div>
							<div class="righttext">
								<input id="orderTypeName" name="orderTypeName"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100">创建日期：</div>
							<div class="righttext">
								<input id="orderCreateDate" name="orderCreateDate"  disabled="true"  type="text"
									class="short50" />
							</div>
					</div>
					<div class="item25 lastitem">
							<div class="itemleft100">销售组织：</div>
							<div class="righttext">
								<input id="salesOrgName" name="salesOrgName"  disabled="true" type="text" title=""
									class="short50" />
							</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
							<div class="itemleft100">销售大区：</div>
							<div class="righttext">
								<input id="saleAreaName" name="saleAreaName"  disabled="true" type="text" title=""
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100">经营体：</div>
							<div class="righttext">
								<input id="deptName" name="deptName"  disabled="true" type="text"  title=""
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100">经营体长：</div>
							<div class="righttext">
								<input id="orderCustName" name="orderCustName"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100">产品经理：</div>
							<div class="righttext">
								<input id="orderProdName" name="orderProdName"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
					<div class="item25 lastitem">
							<div class="itemleft100">订舱经理：</div>
							<div class="righttext">
								<input id="orderTransManagerName" name="orderTransManagerName"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
							<div class="itemleft100">收汇经理：</div>
							<div class="righttext">
								<input id="orderRecManagerName" name="orderRecManagerName"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
					<div  class="item25">
				        <div class="itemleft100">单证经理：</div>
						<div class="righttext">
							<input id="docManagerName" name="docManagerName"  disabled="true" type="text"
									class="short50" />
						</div>
				    </div>
				    <div class="item25">
							<div class="itemleft100">订单经理：</div>
							<div class="righttext">
								<input id="orderExecName" name="orderExecName"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
				    <div class="item25">
							<div class="itemleft100">是否买断：</div>
							<div class="righttext">
								<input id="orderBuyoutFlag" name="orderBuyoutFlag"  type="checkbox"  disabled="true" 
									class="short80"  type="text" value="1"/>
							</div>
					</div>
					<div class="item25 lastitem">
							<div class="itemleft100">是否锁定汇率：</div>
							<div class="righttext">
								<input id="orderLockexchangeFlag" name="orderLockexchangeFlag"  type="checkbox"  disabled="true"
									class="short80" type="text" value="1"/>
							</div>
					</div>
				</div>
				<div  class="oneline">
					<div class="item25">
				         <div class="itemleft100">终端客户订单号：</div>
						 <div class="righttext">
								<input id="orderPoCode" name="orderPoCode"  disabled="true" title=""
									class="short50" type="text" />
						 </div>
				     </div>
				     <div class="item25">
				         <div class="itemleft100">总运费：</div>
						 <div class="righttext">
								<input id="freight" name="freight"  disabled="true"
									class="short50" type="text" />
						 </div>
				     </div>
				     <div class="item25">
						<div class="itemleft100">出口国家：</div>
						<div class="righttext">
							<input id="countryName" name="countryName" class="short50"  disabled="true" type="text" title=""/>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft100">收货人：</div>
						<div class="righttext">
							<input id="orderShipToName" name="orderShipToName" class="short50" disabled="true" type="text"  title=""/>
						</div>
					</div>
					<div class="item25 lastitem">
						<div class="itemleft100">售达方：</div>
						<div class="righttext">
							<input id="orderSoldToName" name="orderSoldToName" class="short50"  disabled="true" type="text" title=""/>
						</div>
					</div>
				</div>
				<div class="oneline">
					 <div class="item25">
						<div class="itemleft100">运输方式：</div>
						<div class="righttext">
							<input id="orderShipmentName" name="orderShipmentName" class="short50"  disabled="true" type="text" />
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">始发港：</div>
						<div class="righttext">
							<input id="portStartName" name="portStartName" class="short50"  disabled="true" type="text" />
						</div>
				    </div>
				     <div class="item25">
						<div class="itemleft100">目的港：</div>
						<div class="righttext">
							<input id="portEndName" name="portEndName" class="short50"  disabled="true"  type="text" title=""/>
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">运输公司：</div>
						<div class="righttext">
							<input id="vendorName" name="vendorName" class="short50"  disabled="true" type="text" title=""/>
						</div>
				    </div>
					<div class="item25 lastitem">
						<div class="itemleft100">出运时间：</div>
						<div class="righttext">
							<input id="orderShipDate" name="orderShipDate" class="short50"  disabled="true" type="text" />
						</div>
				    </div>
				</div>
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100">要求到货日：</div>
						<div class="righttext">
							<input id="orderCustomDate" name="orderCustomDate" class="short50"  disabled="true" type="text" />
						</div>
				    </div>
				     <div class="item25">
							<div class="itemleft100">币种：</div>
							<div class="righttext">
								<input id="currencyName" name="currencyName"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100">兑美元汇率：</div>
							<div class="righttext">
								<input id="toUsaExchange" name="toUsaExchange"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100">兑人民币汇率：</div>
							<div class="righttext">
								<input id="toCnyExchange" name="toCnyExchange"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
				    <div  class="item25 lastitem">
				        <div class="itemleft100">订单付款方式：</div>
							<div class="righttext">
								<input id="orderPaymentMethodName" name="orderPaymentMethodName"  disabled="true" type="text"
									class="short50" />
							</div>
				    </div>
				</div>
				<div  class="oneline">
				     <div  class="item25">
				        <div class="itemleft100">订单付款周期：</div>
							<div class="righttext">
								<input id="orderPaymentCycle" name="orderPaymentCycle"  disabled="true" type="text"
									class="short50" />
						</div>
				    </div>
				    <div  class="item25">
				        <div class="itemleft100">合同付款方式：</div>
							<div class="righttext">
								<input id="contractPaytypeName" name="contractPaytypeName"  disabled="true" type="text"
									class="short50" />
							</div>
				    </div>
				    <div  class="item25 lastitem">
				        <div class="itemleft100">订单付款条件：</div>
							<div class="righttext">
								<input id="orderPaymentTermsName" name="orderPaymentTermsName"  disabled="true" type="text" title=""
									class="short50" />
							</div>
				    </div>
				</div>
				<div class="oneline">
				    <div  class="item25">
				        <div class="itemleft100">成交方式：</div>
						<div class="righttext">
							<input id="orderDealName" name="orderDealName"  disabled="true" type="text" 
									class="short50" />
						</div>
				    </div>
				     <div  class="item25">
				        <div class="itemleft100">合同付款周期：</div>
						<div class="righttext">
							<input id="contractPayCycle" name="contractPayCycle"  disabled="true" type="text"
						  		 class="short50" />
						</div>
				    </div>
				     <div  class="item25 lastitem">
				        <div class="itemleft100">合同付款条件：</div>
							<div class="righttext">
								<input id="contractPayConditionName" name="contractPayConditionName"  disabled="true" title=""
									class="short50" type="text" />
							</div>
				    </div>
	        </div>
		 </div>
		</form>
	</div>
     <div region="center"  style="padding:5px;background:#eee;">
          <jsp:include page="salesOrderDetailInfo.jsp"></jsp:include>
     </div>  
     
      <!-- 生产工厂下拉选信息 -->
	<div id="_factoryItem">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100"><s:text name="orderConfirm.productFactoryCode">生产工厂编码</s:text>：</div>
				<div class="righttext">
					<input class="short50" id="_FACTORYCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100"><s:text name="orderConfirm.productFactoryName">生产工厂名称</s:text>：</div>
				<div class="righttext">
					<input class="short50" id="_FACTORYNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_FACTORYMY('_FACTORYCODE','_FACTORYNAME','factoryCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_FACTORYMYCLEAN('_FACTORYCODE','_FACTORYNAME','factoryCode')" />
				</div>
			</div>
		</div>
	</div>
     
     
</body>
</html>