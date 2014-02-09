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
    var typQuaAppid = null;
    var updateLoadExcelDialog;
    var updateLoadExcelInfoForm;
	//加载订单相信信息
	$(function(){
		updateLoadExcelInfoForm = $('#updateLoadExcelInfoForm').form();
		 $.ajaxSettings.async=false;
		//加载T模式活动信息 
		$('#tmodelCode').combobox({  
		    url:'${dynamicURL}/salesOrder/salesOrderAction!selectTmodelInfo.action?orderCode='+'${orderCode}',  
		    valueField:'configId',  
		    textField:'tmodName'
		});
		//加载装运方法信息
		$('#orderTransType').combobox({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectTransType.action',
			valueField:'itemCode',  
		    textField:'itemNameCn'
		});
		//加载装箱方法信息
		$('#packageTypeCode').combobox({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectPackageType.action',
			valueField:'itemCode',  
		    textField:'itemNameCn'
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
			 toolbar : '#_FACTORY',
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
			 }  ] ],
			 onShowPanel:function(){
				//默认生产工厂的值
				 $('#factoryCode').combogrid('setValue','${factoryCode}');
			 }
		});
		$.ajax({
	   	     url:"${dynamicURL}/salesOrder/salesOrderAction!selectSalesOrderDetail.action",
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
			    //初始化装运方式
		   	    var orderTransTypeData = $('#orderTransType').combobox('getData');
		   	    if (orderTransTypeData.length > 0) {
                    $("#orderTransType").combobox('select', orderTransTypeData[0].itemCode);
                }  
		   	    //初始化装箱方式
		   	    var packageTypeData = $('#packageTypeCode').combobox('getData');
		   	    if (packageTypeData.length > 0) {
                    $("#packageTypeCode").combobox('select', packageTypeData[0].itemCode);
                }
		   	    //经营体长code和name组合
				var custString = "("+data.orderCustNamager+")";
				if(data.orderCustName != "" || data.orderCustName != null){
					custString = custString + data.orderCustName;
				}
				$('#orderCustName').attr('title',custString);
				//产品经理code和name组合
				var prodString = "("+data.orderProdManager+")";
				if(data.orderProdName != "" || data.orderProdName != null){
					prodString = prodString + data.orderProdName;
				}
				$('#orderProdName').attr('title',prodString);
				//订舱经理code和name组合
				var tranString ="("+data.orderTransManager+")"; 
				if(data.orderTransManagerName != "" || data.orderTransManagerName != null){
					tranString = tranString + data.orderTransManagerName;
				}
		   	    $('#orderTransManagerName').attr('title',tranString);
		   	    //收汇经理code和name组合
		   	    var recString = "("+data.orderRecManager+")";
				if(data.orderRecManagerName != "" || data.orderRecManagerName != null){
					recString = recString + data.orderRecManagerName;
				}
				$('#orderRecManagerName').attr('title',recString);
				//单证经理code和name组合
				var docString = "("+data.docManager+")";
				if(data.docManagerName != "" || data.docManagerName != null){
					docString = docString + data.docManagerName;
				}
		   	    $('#docManagerName').attr('title',docString);
		   	    //订单经理code和name组合
		   	    var orderString = "("+data.orderExecManager+")";
				if(data.orderExecName != "" || data.orderExecName != null){
					orderString = orderString + data.orderExecName;
				}
		   	    $('#orderExecName').attr('title',orderString);
		     	//收货人code和name组合
				var orderShipString = "("+data.orderShipTo+")";
				if(data.orderShipToName != "" || data.orderShipToName != null){
					orderShipString = orderShipString + data.orderShipToName;
				}
		   	    $('#orderShipToName').attr('title',orderShipString);
		   	    //售达方code和name组合
				var orderSoldString = "("+data.orderSoldTo+")";
				if(data.orderSoldToName != "" || data.orderSoldToName != null){
					orderSoldString = orderSoldString + data.orderSoldToName;
				}
		   	    $('#orderSoldToName').attr('title',orderSoldString);
		   	    //始发港code和name组合
		   	    var portStartString = "("+data.portStartCode+")";
		   	    if(data.portStartName != "" || data.portStartName != null){
		   	    	portStartString = portStartString + data.portStartName;
		   	    }
		   	    $('#portStartName').attr('title',portStartString);
		   	    //目的港code和name组合
		   	    var poartEndString = "("+data.portEndCode+")";
		   	    if(data.portEndName != "" || data.portEndName != null){
		   	    	poartEndString = poartEndString + data.portEndName;
		   	    }
		   	    $('#portEndName').attr('title',poartEndString);
		   	    //运输公司
		   	    var vendorString = "("+data.vendorCode+")";
		   	    if(data.vendorName != "" || data.vendorName != null){
		   	    	vendorString = vendorString + data.vendorName;
		   	    }
		   	    $('#vendorName').attr('title',vendorString);
		   	    //付款条件code和name组合
		   	    var payTermString = "("+data.orderPaymentTerms+")";
		        if(data.orderPaymentTermsName != "" || data.orderPaymentTermsName != null){
		        	payTermString = payTermString + data.orderPaymentTermsName;
		        }
		        $('#orderPaymentTermsName').attr('title',payTermString);
	   	     }
		});
		$.ajaxSettings.async=true;
		
		//上传文件dialog
		updateLoadExcelDialog = $('#updateLoadExcelDialog').show().dialog({
	    	title : '<s:text name="orderConfirm.loadPoFile">导入PO相关信息</s:text>',
	    	modal : true,
	    	closed : true,
	    	collapsible : true,
	    	buttons : [{
	    		text : '<s:text name="global.form.load">导入</s:text>',
	    		handler : function() {
	    			$.messager.progress({
	    				text : '<s:text name="the.data.load">数据加载中....</s:text>',
	    				interval : 100
	    			});
	    			var fileName = $("#excleFile").val();
	    			if('' === fileName || null == fileName){
	    				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="courier.select.file">请选择文件！</s:text>','info');
						$.messager.progress('close');
						return;
	    			}else{
		    			$('#updateLoadExcelInfoForm').form('submit',{
							url:'${dynamicURL}/salesOrder/salesOrderAction!updateOrderFile.action',
							onSubmit:function(param){
								param.orderCode = '${orderCode}';
							},
							success:function(data) {
								var json = $.parseJSON(data);
								if (json.success) {
									$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>',json.msg,'info');
									$.messager.progress('close');
									updateLoadExcelDialog.dialog('close');
									$('#orderAttachmentsName').val(json.obj.fileName);
									$('#orderAttachmentsName').attr('title',json.obj.fileName);
								}else{
									$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>',json.msg,'info');
									$.messager.progress('close');
								}
							}
					    });
	    			}
	    		}
	        }]
		 });
	});
	//保存订单状态信息
	function saveSalesOrder(){
		commonSave();
	}
	//公用的校验
	function commonSave(){
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中....</s:text>',
			interval : 100
		});
		//验证箱型箱量是否为空
		validateTypQua();
		//验证结算工厂是否为空
		validateFactroy();
		//验证单价是否为空;
		validatePrice();
		//验证实际运费是否低于中标费用
		validateFeight();
		//验证一个订单的物料是否重复
		repeatMaterialVal();
		var fileName = $('#excleFile').val();
		var attachmentsName = "${orderAttachmentsName}";
		var orderCustomDate = dateFormatYMD($('#orderCustomDate').val());
		var orderShipDate = dateFormatYMD($('#orderShipDate').val());
		//获取装箱方式
		var packageTypeName = $('#packageTypeCode').combobox('getValue');
		//经营体长
		var custManager = $('#orderCustName').val();
		//产品经理
		var prodManager = $('#orderProdName').val();
		//订舱经理
		var transManager = $('#orderTransManagerName').val();
		//收汇经理
		var recManager = $('#orderRecManagerName').val();
		//单证经理
		var docManager = $('#docManagerName').val();
		//订单经理
		var orderManager = $('#orderExecName').val();
		//始发港
		var portStartCode = $('#portStartName').val();
		//目的港
		var portEndCode = $('#portEndName').val();
		//船公司
		var vendorCode = $('#vendorName').val();
		//付款条件
		var payTerm = $('#orderPaymentTermsName').val();
		//国家
		var countryName = $('#countryName').val();
		//收货人
		var orderShipTo = $('#orderShipToName').val();
		//售达方
		var orderSoldTo = $('#orderSoldToName').val();
		//获取T模式
		var tmodelCode= $('#tmodelCode').combobox('getValue');
		//获取装运方式
		var orderTransType = $('#orderTransType').combobox('getValue');
		//收货人
		var orderShipTo = $('#orderShipToName').val();
		//售达方
		var orderSoldTo = $('#orderSoldToName').val();
		//生产工厂
		var factoryCodes = $('#factoryCode').combogrid('getValue'); 
		//获取总运费
		var freightMoney = $('#freight').val();
		if(orderShipDate >= orderCustomDate){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.timeValidator">出运时间大于等于客户抵达时间,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(tmodelCode == "" || tmodelCode == null){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.tmodInfoValidator">T模式不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(orderTransType == "NULL"){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.transTypeValidator">装运方式不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(packageTypeName == "NULL"){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.packageTypeValidator">装箱方式不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(factoryCodes == "" || factoryCodes == null){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.factoryValidator">生产工厂不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(countryName == "" || countryName == null){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.countryNameValidator">国家不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(custManager == null || custManager == ""){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.custManagerValidator">经营体长不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(prodManager == null || prodManager == ""){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.prodManagerValidator">产品经理不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(transManager == null || transManager ==""){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.transManagerValidator">订舱经理不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(recManager == null || recManager ==""){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.recManagerValidator">收汇经理不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(docManager == null || docManager == ""){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.docManagerValidator">单证经理不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(orderManager == null || orderManager == ""){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.orderManagerValidator">订单经理不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(orderShipTo == null || orderShipTo == ""){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.shipToValidator">收货人不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(orderSoldTo == null || orderSoldTo == ""){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.soldToValidator">售达方不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(portStartCode == null || portStartCode == "" ){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.portStartValidator">始发港不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(portEndCode == null || portEndCode == ""){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.portEndValidator">目的港不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(vendorCode == null || vendorCode == ""){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.vendorValidator">运输公司不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(!typQuaFlag){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.typQuaValidator">箱型箱量不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(!factoryFlag){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.factoryNameValidator">结算工厂不能为空,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(!bidFeightFlag){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.bidFreightValidator">中标费用不存在,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(!priceFlag){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.priceValidator">订单的运费有问题,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(!feightFlag){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>',"<s:text name='orderConfirm.totalPrice'>总运费</s:text>"+"("+freightInfo+")USD"+"<s:text name='orderConfirm.priceInfo'>低于中标实际费用</s:text>"+"("+bidFreightInfo+")USD,"+"<s:text name='orderConfirm.alertInfo'>请检查！</s:text>",'info');
			$.messager.progress('close');
		}else if(!repeatMaterialFlag){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.info">订单的</s:text>'+repeatMaterialInfo+'<s:text name="orderConfirm.repeatInfo">物料存在重复,请检查！</s:text>','info');
			$.messager.progress('close');
		}else if(attachmentsName == null || attachmentsName == ""){
			if(fileName == "" || fileName == null){
				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.attachValidator">订单附件不能为空,请检查！</s:text>','info');
				$.messager.progress('close');
			}else{
				commonValidateInfo(payTerm);
			}
		}else{
			commonValidateInfo(payTerm);
		}
	}
	//公用的验证
	function commonValidateInfo(payTerm){
		if('${orderType}' == '046'){
			if($('#specialCntId').val() == null || $('#specialCntId').val() == ''){
			    $.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.specialCntIdValidator">标准箱方案不能为空,请检查！</s:text>','info');
			    $.messager.progress('close');
			}else{
				submitCommonForm();
			}
		}else if('${orderType}' == '047'){
			submitCommonForm();
		}else{
			if(payTerm == null || payTerm ==""){
				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.payTermValidator">订单付款条件不能为空,请检查！</s:text>','info');
				$.messager.progress('close');
			}else{
				submitCommonForm();
			}
		}
	}
	//公用的form提交
	function submitCommonForm(){
		$('#salesOrderSaveForm').form('submit',{
				url:'salesOrderAction!saveOrderStatue.do',
				success:function(data){
				    var data = $.parseJSON(data);
				    if(data.success == true){
				    	$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>',data.msg,'info');
				    	//代办刷新
						customWindow.reloaddata();
						//代办关闭
						parent.window.HROS.window.close(currentappid);
						$.messager.progress('close');
				    }else{
				    	$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>',data.msg,'info');
				    	//代办刷新
						customWindow.reloaddata();
				    }
				}
			}); 
	}
	//验证箱型箱量是否为空
	var typQuaFlag = true;
	function validateTypQua(){
		$.ajaxSettings.async=false;
		$.ajax({
			url:"${dynamicURL}/salesOrder/salesOrderAction!validateTypQua.action",
			type:"post",
			data:{
				orderCode:'${orderCode}'
			},
			success:function(data){
				var json = $.parseJSON(data);
				if(json.success){
					typQuaFlag = true;
				}else{
					typQuaFlag = false;
				}
			}
		});
		$.ajaxSettings.async=true;
	}
	//验证工厂是否为空
	var factoryFlag = true;
	function validateFactroy(){
		$.ajaxSettings.async=false;
		$.ajax({
			url:"${dynamicURL}/salesOrder/salesOrderAction!validateFactroy.action",
			type:"post",
			data:{
				orderCode:'${orderCode}'
			},
			success:function(data){
				var json = $.parseJSON(data);
				if(json.success){
					factoryFlag = true;
				}else{
					factoryFlag = false;
				}
			}
		});
		$.ajaxSettings.async=true;
	}
	//验证订单运费是否低于中标的金额
	var feightFlag = true;
	var bidFeightFlag = true;
	var freightInfo = 0;
	var bidFreightInfo = 0;
	function validateFeight(){
		//获取始发港code
		var orderPortStartCode = $('#portStartCode').val();
		//获取目的港code
		var orderPortEndCode = $('#portEndCode').val();
		//获取中标公司code
		var orderVenderCode = $('#vendorCode').val();
		//获取运输方式
		var orderShipMentCode = $('#orderShipment').val();
		//获取出运期
		var orderShipDateInfo = $('#orderShipDate').val();
		//如果是EXW，FAC，FAS，FCA，FOB，FOC，FTC不校验
		 $.ajax({
			 url:'${dynamicURL}/salesOrder/salesOrderAction!isFareDealType.action',
			 data:{
				 orderCode : '${orderCode}',
				 portStartCode : orderPortStartCode,
				 portEndCode : orderPortEndCode,
				 vendorCode : orderVenderCode,
				 orderShipment : orderShipMentCode,
				 orderShipDate : orderShipDateInfo
			 },
			 type:'post',
			 dataType:'json',
			 async: false,
			 success:function(data){
				 if(data.success){
					 freightInfo = data.obj.freightTotalMoney;
					 bidFreightInfo = data.obj.bidTotalMoneyDouble;	
					 if(bidFreightInfo == 0){
						 bidFeightFlag = false;
					 }else if(Number(freightInfo) < Number(bidFreightInfo)){
						 feightFlag = false;
					 }else{
						 bidFeightFlag = true;
						 feightFlag = true;
					 }
				 }
			 }
		 });
	}
	
	//验证单价是否为空
	var priceFlag = true;
	function validatePrice(){
		$.ajaxSettings.async=false;
		$.ajax({
			url:'${dynamicURL}/salesOrder/salesOrderAction!validatePrice.action',
			dataType:'json',
			data:{
				orderCode : '${orderCode}'
			},
			type:'post',
			success:function(data){
				//获取总运费
				var freightMoney = $('#freight').val();
				if(!(data.success) && Number(freightMoney)>0){
					priceFlag = false;
				}else{
					priceFlag = true;
				}
			}
		});
		$.ajaxSettings.async=true;
	}
	
	//验证一个订单的物料是否重复 
	var repeatMaterialFlag = true;
	var repeatMaterialInfo;
	function repeatMaterialVal(){
		$.ajaxSettings.async=false;
		$.ajax({
			url:'${dynamicURL}/salesOrder/salesOrderAction!repeatMaterialVal.action',
			dataType:'json',
			data:{
				orderCode : '${orderCode}'
			},
			type:'post',
			success:function(data){
				if(data.success){
					repeatMaterialFlag = true;
				}else{
					repeatMaterialFlag = false;
					repeatMaterialInfo = data.msg;
				}
			}
		});
		$.ajaxSettings.async=true;
	}
	
	//选择标准箱方案
	function selectSpecial(){
		typQuaAppid = parent.window.HROS.window.createTemp({appid:typQuaAppid,
			title:'<s:text name="orderConfirm.selectSpricalTitle">选择标准箱方案</s:text>',
			url:'${dynamicURL}/salesOrder/salesOrderAction!goSpecialCnt.action?contractCode='+$('#contractCode').val()+"&orderCode="+$('#orderCode').val(),
			width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
	    //parent.window.HROS.window.refresh(typQuaAppid);
	}
	function setSpecialCntNum(specialCntId, multipeOrder){
		if($("#specialCntId").val() != null && $("#specialCntId").val() != ""){
			$("#specialCntId").val("");
			$("#specialCntId").val(specialCntId);
		}else{
			$("#specialCntId").val("");
			$("#specialCntId").val(specialCntId);
		}
	}
	//跳转空调合并报关
	function saveOrderMerge(){
		var orderCode = $('#orderCode').val();
		$.ajax({
			url:'${dynamicURL}/orderMerge/orderMergeAction!checkOrderInMerge.action',
			data:{
				orderNum:orderCode
			},
			dataType:'json',
			success:function(data){
				if(data.success){
					$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.checkInMergeValidator">该订单已经进行合并！</s:text>','info');
					return;
				}else{
					typQuaAppid = parent.window.HROS.window.createTemp({appid:typQuaAppid,
						title:'<s:text name="orderConfirm.checkInMergeTitle">合并报关</s:text>',
						url:'${dynamicURL}/orderMerge/orderMergeAction!goOrderMerge.action?orderNum='+orderCode,
						width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});
				}
			}
		});
	}
	//加载无HGVS的T模式
	function loadOrderNoHGVS(){
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中....</s:text>',
			interval : 100
		});
		var orderHgvsFlag;
		var expressFlag;
		var inspectionFlag;
		//获取导HGVS是否选中
		if($('#orderHgvsFlag').attr('checked') == "checked"){
			orderHgvsFlag = 1;
		}else{
			orderHgvsFlag = 0;
		}
		//获取外销是否选中
		if($('#orderExpressFlag').attr('checked') == "checked"){
			expressFlag = 1;
		}else{
			expressFlag = 0;
		}
		//获取商检是否选中
		if($('#orderInspectionFlag').attr('checked') == "checked"){
			inspectionFlag = 1;
		}else{
			inspectionFlag = 0;
		}
		$.ajax({
	   	     url:"${dynamicURL}/salesOrder/salesOrderAction!loadOrderNoHGVS.action",
	   	     data:{
	   	    	  orderCode:'${orderCode}',
	   	    	  orderHgvsFlag : orderHgvsFlag,
	   	    	  orderExpressFlag : expressFlag,
	   	    	  orderInspectionFlag : inspectionFlag
	   	     },
	   	     dataType:"json",
	   	     type:'post',
	   	     success:function(data){
// 	   	    	if(data.length){
// 	   	    		for(var i = 0; i < data.length; i++){
// 		   	    		$('#tmodelCode').combobox('setValue',data[i].configId);
// 		   	    		$('#tmodelCode').combobox('setText',data[i].tmodName);
// 		   	    	}
// 	   	    	}else{
// 	   	    		data = {};
// 	   	    		$('#tmodelCode').combobox('setValue',"");
// 	   	    		$('#tmodelCode').combobox('setText',"");
// 	   	    	}
	   	    	$('#tmodelCode').combobox('loadData',data);
	   	    	$.messager.progress('close');
	   	     }
		});
	}
	//加载无商检的T模式
	function loadOrderNoCheck(){
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中....</s:text>',
			interval : 100
		});
		var orderHgvsFlag;
		var expressFlag;
		var inspectionFlag;
		//获取导HGVS是否选中
		if($('#orderHgvsFlag').attr('checked') == "checked"){
			orderHgvsFlag = 1;
		}else{
			orderHgvsFlag = 0;
		}
		//获取外销是否选中
		if($('#orderExpressFlag').attr('checked') == "checked"){
			expressFlag = 1;
		}else{
			expressFlag = 0;
		}
		//是否商检
		if($('#orderInspectionFlag').attr('checked') == "checked"){
			inspectionFlag = 1;
		}else{
			inspectionFlag = 0;
		}
		$.ajax({
	   	     url:"${dynamicURL}/salesOrder/salesOrderAction!loadOrderNoCheck.action",
	   	     data:{
	   	    	  orderCode : '${orderCode}',
	   	    	  orderHgvsFlag : orderHgvsFlag,
	   	    	  orderExpressFlag : expressFlag,
	   	    	  orderInspectionFlag : inspectionFlag
	   	     },
	   	     dataType:"json",
	   	     type:'post',
	   	     success:function(data){
// 	   	    	if(data.length){
// 	   	    		for(var i = 0; i < data.length; i++){
// 		   	    		$('#tmodelCode').combobox('setValue',data[i].configId);
// 		   	    		$('#tmodelCode').combobox('setText',data[i].tmodName);
// 		   	    	}
// 	   	    	}else{
// 	   	    		data = {};
// 	   	    		$('#tmodelCode').combobox('setValue',"");
// 	   	    		$('#tmodelCode').combobox('setText',"");
// 	   	    	}
	   	    	$('#tmodelCode').combobox('loadData',data);
	   	    	$.messager.progress('close');
	   	     }
		});
	}
	//加载有外销快递T模式
	function loadOrderYesExpress(){
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中....</s:text>',
			interval : 100
		});
		var orderHgvsFlag;
		var expressFlag;
		var inspectionFlag;
		//是否商检
		if($('#orderInspectionFlag').attr('checked') == "checked"){
			inspectionFlag = 1;
		}else{
			inspectionFlag = 0;
		}
		//外销是否选中
		if($('#orderExpressFlag').attr('checked') == "checked"){
			expressFlag = 1;
			$('#orderInspectionFlag').val('0');
			document.getElementById('orderInspectionFlag').checked = false;
			inspectionFlag = 0;
		}else{
			expressFlag = 0;
			$('#orderInspectionFlag').val('1');
			document.getElementById('orderInspectionFlag').checked = true;
			inspectionFlag = 1;
		}
		//获取导HGVS是否选中
		if($('#orderHgvsFlag').attr('checked') == "checked"){
			orderHgvsFlag = 1;
		}else{
			orderHgvsFlag = 0;
		}
		$.ajax({
	   	     url:"${dynamicURL}/salesOrder/salesOrderAction!loadOrderYesExpress.action",
	   	     data:{
	   	    	  orderCode : '${orderCode}',
	   	    	  orderHgvsFlag : orderHgvsFlag,
	   	    	  orderExpressFlag : expressFlag,
	   	    	  orderInspectionFlag : inspectionFlag
	   	     },
	   	     dataType:"json",
	   	     type:'post',
	   	     success:function(data){
// 	   	    	if(data.length){
// 	   	    		for(var i = 0; i < data.length; i++){
// 		   	    		$('#tmodelCode').combobox('setValue',data[i].configId);
// 		   	    		$('#tmodelCode').combobox('setText',data[i].tmodName);
// 		   	    	}
// 	   	    	}else{
// 	   	    		data = {};
// 	   	    		$('#tmodelCode').combobox('setValue',"");
// 	   	    		$('#tmodelCode').combobox('setText',"");
// 	   	    	}
	   	    	$('#tmodelCode').combobox('loadData',data);
	   	    	$.messager.progress('close');
	   	     }
		});
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
	//修改文件1841941
	function updateFile(){
		updateLoadExcelInfoForm.form('clear');
		updateLoadExcelDialog.dialog('open');	
	}
</script>
</head>
<body class="easyui-layout">
     <div region="north"   split="true" style="height:323px;"  collapsed="false" >
        <form id="salesOrderSaveForm" method="post" enctype="multipart/form-data">
        <input  type="hidden"  name="orderType"  id="orderType" />
	        <div class="part_zoc" style="margin:0px 0px 0px 0px;">
	            <s:hidden id="orderCode" name="orderCode" />
				<div class="partnavi_zoc">
					<span><s:text name="orderConfirm.orderStatueText">订单状态</s:text>：</span>
				</div>
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100"><s:text name="orderConfirm.hgvsFlagText">是否导HGVS</s:text>：</div>
						<div class="rightcheckbox">
							<input id="orderHgvsFlag" name="orderHgvsFlag" class="short30"  type="checkbox" onclick="loadOrderNoHGVS();"  value="1"/>
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100"><s:text name="orderConfirm.expressFlagText">外销快递</s:text>：</div>
						<div class="rightcheckbox">
							<input id="orderExpressFlag" name="orderExpressFlag" class="short50"  type="checkbox" value="1"  onclick="loadOrderYesExpress();"/>
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100"><s:text name="orderConfirm.inspectionFlagText">是否商检</s:text>：</div>
						<div class="rightcheckbox">
							<input id="orderInspectionFlag" name="orderInspectionFlag" class="short50"  onclick="loadOrderNoCheck();" type="checkbox" value="1"/>
						</div>
				    </div>
				    <div class="item25 lastitem">
				        <div class="itemleft60"><s:text name="orderConfirm.tmodCodText">T模式</s:text>：</div>
				        <div class="rightselect_easyui">
				            <input id="tmodelCode"  name="tmodelCode"  class="short80"  type="text" editable="false" />
				        </div>
				    </div>
				    <s:if test="orderType == '046'">
					    <div class="item25 lastitem">
							<div class="itemleft100"><s:text name="orderConfirm.specialCodeText">标准箱方案</s:text>：</div>
							<div class="righttext">
								<input id="specialCntId" name=specialCntId class="short50"  type="text"  readonly="readonly" />
								<a style="cursor: pointer;" onclick="selectSpecial()"><img src="${staticURL}/easyui3.2/themes/icons/search.png" ></img></a>
							</div>
					    </div>
				    </s:if>
				</div>
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100"><s:text name="orderConfirm.transTypeText">装运方式</s:text>：</div>
						<div class="righttext">
							<input id="orderTransType" name="orderTransType" style="width:100px" editable="false"/>
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100"><s:text name="orderConfirm.packageTypeText">装箱方式</s:text>：</div>
						<div class="righttext">
							<input id="packageTypeCode" name="packageType" style="width:100px" editable="false"/>
						</div>
				    </div>
				    <div  class="item25">
				        <div class="itemleft100"><s:text name="orderConfirm.productFactoryText">生产工厂</s:text>：</div>
						<div class="righttext">
							<input id="factoryCode" name="factoryCode" style="width:100px" editable="false" />
						</div>
				    </div>
				    <s:if test="orderAttachmentsName == null">
				         <div class="item33 lastitem">
						     <div class="itemleft100"><s:text name="orderConfirm.loadFileText">订单附件上传</s:text>：</div>
						     <div class="righttext">
							     <s:file id="excleFile" name="excleFile"  style="width:140px" />
						     </div>
				         </div>
				    </s:if>
				    <s:else>
				        <div class="item33 lastitem">
				             <div class="itemleft60"><s:text name="orderConfirm.attachmentText">附件</s:text>：</div>
						     <div class="righttext">
							     <input id="orderAttachmentsName"  name="orderAttachmentsName"  type="text"  title=""  
							         readonly="true"  class="short80"  style="background-color: #EBEBE4"/>
							     <input type="button" value="<s:text name="orderConfirm.updateAttachmentButton">修改附件</s:text>" onclick="updateFile()" class="oprationbutt"/>
						     </div>
				         </div>
				    </s:else>
				</div>
				<div class="oneline">
				     <div class="item50 lastitem">
				        <div class="itemleft100"><s:text name="pcm.contenedor.comment">备注</s:text>：</div>
				        <div class="righttext">
				            <input id="comments" name="comments"  type="text"  style="width: 360px"  maxlength="800"/>
				        </div>
				    </div>
				     <div class="item50 lastitem">
				        <div class="oprationbutt">
				            <input type="button" value="<s:text name="global.form.save">保 存</s:text>" onclick="saveSalesOrder()"/>
				                <s:if test="(prodType == '05' || prodType == '06')&& orderType == '005' "> 
				                    <input type="button" value="<s:text name="global.form.mergeDeclarationButton">合并报关 </s:text>" onclick="saveOrderMerge()"/>
				                </s:if> 
				        </div>
				    </div>
				</div>
			</div>
	        <div class="part_zoc"  style="margin:0px 0px 0px 0px;">
	            <div class="partnavi_zoc">
						<span><s:text name="order.info.list">订单信息</s:text>：</span>
				</div>
				<div class="oneline">
				    <div class="item25">
							<div class="itemleft100"><s:text name="global.order.number">订单号</s:text>：</div>
							<div class="righttext">
								<input id="orderCode" name="orderCode"  disabled="true"  type="text" 
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100"><s:text name="order.contract.contractCode">合同编号</s:text>：</div>
							<div class="righttext">
								<input id="contractCode" name="contractCode"  disabled="true" type="text"  
									class="short50" />
							</div>
					</div>
				    <div class="item25">
							<div class="itemleft100"><s:text name="global.order.ordertype">订单类型</s:text>：</div>
							<div class="righttext">
								<input id="orderTypeName" name="orderTypeName"  disabled="true" type="text"  title="" 
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100"><s:text name="global.form.created">创建时间</s:text>：</div>
							<div class="righttext">
								<input id="orderCreateDate" name="orderCreateDate"  disabled="true"  type="text" 
									class="short50" />
							</div>
					</div>
					<div class="item25 lastitem">
							<div class="itemleft100"><s:text name="global.order.salesOrgCode">销售组织</s:text>：</div>
							<div class="righttext">
								<input id="salesOrgName" name="salesOrgName"  disabled="true" type="text" title=""  
									class="short50" />
							</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
							<div class="itemleft100"><s:text name="contract.main.contractSaleArea">销售大区</s:text>：</div>
							<div class="righttext">
								<input id="saleAreaName" name="saleAreaName"  disabled="true" type="text" title=""  
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100"><s:text name="global.order.deptName">经营体</s:text>：</div>
							<div class="righttext">
								<input id="deptName" name="deptName"  disabled="true" type="text"  title=""  
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100"><s:text name="order.confirm.orderCustNamager">经营体长</s:text>：</div>
							<div class="righttext">
								<input id="orderCustName" name="orderCustName"  disabled="true" type="text" title=""  
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100"><s:text name="global.order.orderExecManager">产品经理</s:text>：</div>
							<div class="righttext">
								<input id="orderProdName" name="orderProdName"  disabled="true" type="text" title=""
									class="short50" />
							</div>
					</div>
					<div class="item25 lastitem">
							<div class="itemleft100"><s:text name="global.order.orderTransManager">订舱经理</s:text>：</div>
							<div class="righttext">
								<input id="orderTransManagerName" name="orderTransManagerName"  disabled="true" type="text" title=""
									class="short50" />
							</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
							<div class="itemleft100"><s:text name="global.order.orderRecManager">收汇经理</s:text>：</div>
							<div class="righttext">
								<input id="orderRecManagerName" name="orderRecManagerName"  disabled="true" type="text" title=""
									class="short50" />
							</div>
					</div>
					<div  class="item25">
				        <div class="itemleft100"><s:text name="credit.lettercredit.orderComfirm">单证经理</s:text>：</div>
						<div class="righttext">
							<input id="docManagerName" name="docManagerName"  disabled="true" type="text"  title=""
									class="short50" />
						</div>
				    </div>
				    <div class="item25">
							<div class="itemleft100"><s:text name="global.order.orderExec">订单经理</s:text>：</div>
							<div class="righttext">
								<input id="orderExecName" name="orderExecName"  disabled="true" type="text"  title=""
									class="short50" />
							</div>
					</div>
					<s:if test="orderSapKvgr3 != 'A1' && orderSapKvgr3 != null">
					     <div class="item25">
							<div class="itemleft100"><s:text name="orderConfirm.orderSapKvgr3">买断标识</s:text>：</div>
							<div class="righttext">
								<input id="orderSapKvgr3" name="orderSapKvgr3"  type="text"  disabled="true"  title=""
									class="short50"  type="text" />
							</div>
					     </div>
					</s:if>
					<s:else>
					    <div class="item25">
							<div class="itemleft100"><s:text name="orderConfirm.orderBuyoutFlag">是否买断</s:text>：</div>
							<div class="righttext">
								<input id="orderBuyoutFlag" name="orderBuyoutFlag"  type="checkbox"  disabled="true" 
									class="short80"  type="text" value="1"/>
							</div>
					    </div>
					</s:else>
					<div class="item25 lastitem">
							<div class="itemleft100"><s:text name="orderConfirm.orderLockexchangeFlag">是否锁定汇率</s:text>：</div>
							<div class="righttext">
								<input id="orderLockexchangeFlag" name="orderLockexchangeFlag"  type="checkbox"  disabled="true"
									class="short80" type="text" value="1"/>
							</div>
					</div>
				</div>
				<div  class="oneline">
					<div class="item25">
				         <div class="itemleft100"><s:text name="order.confirm.orderPoCode">客户订单号</s:text>：</div>
						 <div class="righttext">
								<input id="orderPoCode" name="orderPoCode"  disabled="true" title=""
									class="short50" type="text" />
						 </div>
				     </div>
				     <div class="item25">
				         <div class="itemleft100"><s:text name="orderConfirm.totalPrice">总运费</s:text>：</div>
						 <div class="righttext">
								<input id="freight" name="freight"  disabled="true"
									class="short50" type="text" />
						 </div>
				    </div>
				    <div class="item25">
						<div class="itemleft100"><s:text name="global.order.countryName">出口国家</s:text>：</div>
						<div class="righttext">
							<input id="countryName" name="countryName" class="short50"  disabled="true" type="text" title=""/>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft100"><s:text name="courier.order.taxFlagSh">收货人</s:text>：</div>
						<div class="righttext">
							<input id="orderShipToName" name="orderShipToName" class="short50" disabled="true" type="text"  title=""/>
						</div>
					</div>
					<div class="item25 lastitem">
						<div class="itemleft100"><s:text name="global.order.orderSoldTo">售达方</s:text>：</div>
						<div class="righttext">
							<input id="orderSoldToName" name="orderSoldToName" class="short50"  disabled="true" type="text" title=""/>
						</div>
					</div>
				</div>
				<div class="oneline">
					 <div class="item25">
						<div class="itemleft100"><s:text name="order.confirm.orderShipment">运输方式</s:text>：</div>
						<div class="righttext">
						    <input id="orderShipment" name="orderShipment" type="hidden"></input>
							<input id="orderShipmentName" name="orderShipmentName" class="short50"  disabled="true" type="text" />
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100"><s:text name="order.confirm.portStart">始发港</s:text>：</div>
						<div class="righttext">
						    <input id="portStartCode" name="portStartCode" type="hidden"></input>
							<input id="portStartName" name="portStartName" class="short50"  disabled="true" type="text"  title=""/>
						</div>
				    </div>
				     <div class="item25">
						<div class="itemleft100"><s:text name="order.confirm.portEnd">目的港</s:text>：</div>
						<div class="righttext">
						    <input id="portEndCode" name="portEndCode" type="hidden"></input>
							<input id="portEndName" name="portEndName" class="short50"  disabled="true"  type="text" title=""/>
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100"><s:text name="order.confirm.vendorCode">运输公司</s:text>：</div>
						<div class="righttext">
						    <input  id="vendorCode"  name="vendorCode" type="hidden"></input>
							<input id="vendorName" name="vendorName" class="short50"  disabled="true" type="text" title=""/>
						</div>
				    </div>
					 <div class="item25 lastitem">
						<div class="itemleft100"><s:text name="global.order.orderShipDate">出运时间</s:text>：</div>
						<div class="righttext">
							<input id="orderShipDate" name="orderShipDate" class="short50"  disabled="true" type="text" />
						</div>
				    </div>
				</div>
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100"><s:text name="order.confirm.orderCustomDate">要求到货期</s:text>：</div>
						<div class="righttext">
							<input id="orderCustomDate" name="orderCustomDate" class="short50"  disabled="true" type="text" />
						</div>
				    </div>
				      <div  class="item25">
				        <div class="itemleft100"><s:text name="order.info.orderDealType">成交方式</s:text>：</div>
						<div class="righttext">
							<input id="orderDealName" name="orderDealName"  disabled="true" type="text"
									class="short50" />
						</div>
				    </div>
				    <div class="item25">
							<div class="itemleft100"><s:text name="order.info.toUsaExchange">兑美元汇率</s:text>：</div>
							<div class="righttext">
								<input id="toUsaExchange" name="toUsaExchange"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
					<div class="item25">
							<div class="itemleft100"><s:text name="order.info.toCnyExchange">兑人民币汇率</s:text>：</div>
							<div class="righttext">
								<input id="toCnyExchange" name="toCnyExchange"  disabled="true" type="text"
									class="short50" />
							</div>
					</div>
					<div  class="item25 lastitem">
				        <div class="itemleft100"><s:text name="global.order.ecurrency">币种</s:text>：</div>
						<div class="righttext">
							<input id="currency" name="currency"  disabled="true" type="text"
						  		 class="short50" />
						</div>
				    </div>
				</div>
				<div  class="oneline">
				     <div  class="item25">
				        <div class="itemleft100"><s:text name="global.order.orderPaymentCycle">订单付款周期</s:text>：</div>
							<div class="righttext">
								<input id="orderPaymentCycle" name="orderPaymentCycle"  disabled="true" type="text"
									class="short50" />
						</div>
				    </div>
				    <div  class="item25">
				        <div class="itemleft100"><s:text name="global.order.contractPaytype">合同付款方式</s:text>：</div>
							<div class="righttext">
								<input id="contractPaytypeName" name="contractPaytypeName"  disabled="true" type="text"
									class="short50" />
							</div>
				    </div>
				    <div  class="item25">
				        <div class="itemleft100"><s:text name="global.order.orderPaymentMethod">订单付款方式</s:text>：</div>
							<div class="righttext">
								<input id="orderPaymentMethodName" name="orderPaymentMethodName"  disabled="true" type="text"
									class="short50" />
							</div>
				    </div>
				    <div  class="item25">
				        <div class="itemleft100"><s:text name="global.order.paymentTerms">订单付款条件</s:text>：</div>
							<div class="righttext">
								<input id="orderPaymentTermsName" name="orderPaymentTermsName"  disabled="true" type="text" title=""
									style="width: 100px"  />
							</div>
				    </div>
				    <div  class="item25 lastitem">
				        <div class="itemleft100"><s:text name="global.order.contractPayCondition">合同付款条件</s:text>：</div>
							<div class="righttext">
								<input id="contractPayConditionName" name="contractPayConditionName"  disabled="true" title=""
									style="width: 100px"  type="text" />
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
	<div id="_FACTORY">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100"><s:text name="orderConfirm.productFactoryCode">生产工厂编码</s:text>：</div>
				<div class="righttext">
					<input class="short50" id="_FACTORYCODE" type="text" value="${factoryTrunk}"/>
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
	<div id="updateLoadExcelDialog"
		style="display: none; width: 400px; height: 100px;" align="center">
		<form id="updateLoadExcelInfoForm" method="post"
			enctype="multipart/form-data">
			<table class="tableForm">
				<tr>
					<th><s:text name="orderConfirm.loadPoFile">导入PO相关信息</s:text>:</th>
					<td><s:file id="excleFile" name="excleFile"></s:file></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>