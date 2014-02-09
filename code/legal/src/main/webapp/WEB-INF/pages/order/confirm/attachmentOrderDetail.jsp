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
    //标志是否录入中标信息
    var bidFlag = true;
    //定义变量接收行的值
	var lastIndex;
    //标识提示录入中标信息是否提示过
    var vendorInfoFlag = true;
    var shipInfoFlag = true;
    //为了控制运输方式和运输公司sucess后会调用同样的ajax方法,造成提示信息会出现两次使用
    var shipNumber = 0;
    var vendorNumber = 0;
	//加载订单相信信息
	$(function(){
	    $.ajaxSettings.async=false;
		//加载T模式活动信息 
		$('#tmodelCode').combobox({  
		    url:'${dynamicURL}/salesOrder/salesOrderAction!selectTmodelInfo.action?orderCode='+'${orderCode}',  
		    valueField:'configId',  
		    textField:'tmodName'
		});
		//订单经理变量
		var execPara = "";
		//单证经理变量
		var docPara = "";
		//经营体长变量
		var custPara = "";
		//产品经理变量
		var prodPara = "";
		//订舱经理变量
		var tranPara = "";
		//收汇经理变量 
		var recPara = "";
		//订单付款条件变量
		var termPara = "";
		//成交方式变量
		var dealPara = "";
		//销售大区变量
		var areaPara = "";
		//运输公司变量
		var vendorPara = "";
		//运输方式变量
		var orderShipPara = "";
		$.ajax({
	   	     url:"${dynamicURL}/salesOrder/salesOrderAction!getAttachmentSalesOrderDetail.action",
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
		   	    //初始化T模式
		   	    var tmodelData = $('#tmodelCode').combobox('getData');
		   	    if (tmodelData.length > 0) {
                   $("#tmodelCode").combobox('select', tmodelData[0].configId);
               }
		   	    //过滤成交方式下拉列表
		   	    if(data.orderDealName != null || data.orderDealName != ""){
		   	    	dealPara = data.orderDealType;
		   	    }
		   	    //过滤销售大区下拉列表
		   	    if(data.saleAreaName != null || data.saleAreaName != ""){
		   	    	areaPara = data.saleAreaName;
		   	    }
		   	    //过滤运输公司下拉列表
		   	    if(data.vendorName != null || data.vendorName != ""){
		   	    	vendorPara = data.vendorCode;
		   	    }
		   	    //根据运输方式过滤运输公司
		   	    if(data.orderShipment != null || data.orderShipment != ""){
		   	    	orderShipPara = data.orderShipment;
		   	    }
		   	    //过滤备件订单经理下拉列表数据
		   	    if(data.orderExecName != null || data.orderExecName != ""){
		   		    execPara = data.orderExecManager;
		   	    }
		   	    //过滤单证经理下拉列表数据
		   	    if(data.docManagerName != null || data.docManagerName != "" ){
		   	    	docPara = data.docManager;
		   	    }
		   	    //过滤经营体长下拉列表数据
		   	    if(data.orderCustName != null || data.orderCustName != "" ){
		   	    	custPara = data.orderCustNamager;
		   	    }
		   	    //过滤产品经理下拉列表数据
		   	    if(data.orderProdName != null || data.orderProdName != ""){
		   	    	prodPara = data.orderProdManager;
		   	    }
		   	    //过滤订舱经理下拉列表数据 
		   	    if(data.orderTransManagerName != null || data.orderTransManagerName != ""){
		   	    	tranPara = data.orderTransManager;
		   	    }
		   	    //过滤收汇经理下拉列表数据
		   	    if(data.orderRecManagerName != null || data.orderRecManagerName != "" ){
		   	    	recPara = data.orderRecManager;
		   	    }
		   	    //过滤订单付款条件下拉列表数据
		   	    if(data.orderPaymentTermsName != null || data.orderPaymentTermsName != "" ){
		   	    	termPara = data.orderPaymentTerms;
		   	    }else{
		   	    	termPara = "6000";
		   	    }
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
		   	    //经营体code和name组合
		   	    var departmentString = "("+data.deptCode+")";
		   	    if(data.deptName != "" || data.deptName != null){
		   	    	departmentString = departmentString + data.deptName;
		   	    }
	   	     }
		});
		$.ajaxSettings.async=true;
		//加载始发港信息
		$('#portStartCode').combobox({  
		    url:'${dynamicURL}/bid/bidAction!selectPortStartCode.action',  
		    valueField:'itemCode',  
		    textField:'itemNameCn',
		    editable : false
		});
		//加载工厂下拉列表
		$('#factoryCode').combogrid({
			 url:'${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'+'&deptCode='+'${factoryTrunk}',
			 idField:'deptCode',  
			 textField:'deptNameCn',
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
				field : 'deptCode',
				title : '生产工厂编码',
				width : 20
			 },{
				field : 'deptNameCn',
				title : '生产工厂名称',
				width : 20
			 }  ] ],
			 onShowPanel:function(){
				//默认生产工厂的值
				 $('#factoryCode').combogrid('setValue','${factoryCode}');
			 }
		});
		var urlDeal = "";
		if(null == dealPara || dealPara == ""){
			urlDeal = '${dynamicURL}/basic/sysLovAction!selectDealTypeInfo.do';
		}else{
			urlDeal = '${dynamicURL}/basic/sysLovAction!selectDealTypeInfo.do?itemCode='+dealPara;
		}
		//加载成交方式信息
		$('#orderDealType').combogrid({
			url:urlDeal,
			idField:'itemCode',  
			textField:'itemNameCn',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_DEALDIV',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
			   field : 'itemNameCn',
			   title : '成交方式名称',
			   width : 20
			 }  ] ],
			 onSelect: function(rowIndex, rowData){
					//获取船公司code
				    var vendorCode = $('#vendorCode').combobox('getValue');
				    //获取出运时间
				    var orderShipDate = $('#orderShipDate').datebox('getValue');
				    //获取始发港code
				    var portStartCode = $('#portStartCode').combobox('getValue');
				    //获取目的港code
				    var portEndCode = $('#portEndCode').val();
				    //获取运输方式code
					var shipment = $('#orderShipment').combobox('getValue');
	                if((shipment != null && shipment != "") && (vendorCode!= null && vendorCode != "") && (orderShipDate !=null && orderShipDate != "")){
	                	 $.ajax({
				    			url:'${dynamicURL}/salesOrder/salesOrderAction!addOrderCondition.do',
				    			dataType:'json',
				    			data:{
				    				orderShipment: shipment,
				    				orderCode: $('#orderCode').val(),
				    				vendorCode : vendorCode,
				    				orderShipDate : orderShipDate,
				    				portStartCode : portStartCode,
				    				portEndCode : portEndCode,
				    				orderDealType : rowData.itemCode
				    			},
				    			success:function(data){
				    				vendorNumber = vendorNumber + 1;
				    				tabData();
//				    				if(vendorNumber <= 1){
				    					if(data.success){
						    				bidFlag = true;
						    				$.messager.progress('close');
						    				lastIndex = -1;
					    				}else{
					    					bidFlag = false;
					    					vendorInfoFlag = false;
					    					$.messager.progress('close');
					    					if(shipInfoFlag){
					    						$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.bid.uploadBidInfo">请录入中标信息！</s:text>','info');
					    					}
					    					lastIndex = -1;
					    				}
//				    				}else{
//				    					$.messager.progress('close');
//				    				}
				    			}
				    		}); 
					 }
				 }
		});
		var urlArea = "";
		if(null == areaPara || areaPara == ""){
			urlArea = '${dynamicURL}/basic/sysLovAction!selectOrgAreaInfo.do';
		}else{
			urlArea = '${dynamicURL}/basic/sysLovAction!selectOrgAreaInfo.do?itemNameCn='+areaPara;
		}
		//加载销售大区
		$('#saleArea').combogrid({
			url:urlArea,
			idField:'itemCode',  
			textField:'itemNameCn',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_AREADIV',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
			   field : 'itemNameCn',
			   title : '销售名称',
			   width : 20
			 }  ] ]
		});
		//加载运输方式信息
		$('#orderShipment').combobox({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectShipMentInfo.do',
			valueField:'itemCode',  
		    textField:'itemNameCn',
		    editable : false,
		    onSelect: function(data){
		    	//过滤中标公司
		    	urlVendor = '${dynamicURL}/basic/vendorAction!datagrid.action?shipMentMethod='+data.itemCode;
		        $('#vendorCode').combogrid({url:urlVendor})
		    	//获取船公司code
		    	var vendorCode = $('#vendorCode').combobox('getValue');
		    	//获取出运时间code
		    	var orderShipDate = $('#orderShipDate').datebox('getValue');
		    	//获取始发港code
		    	var portStartCode = $('#portStartCode').combobox('getValue');
		    	//获取目的港code
		    	var portEndCode = $('#portEndCode').val();
		    	//获取成交方式
		    	var orderDealType = $('#orderDealType').combogrid('getValue');
		    	//if(orderDealType != "FOB" && orderDealType != "FOC"){
		    		if(orderShipDate == "" || orderShipDate == null){
			    		$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.shipdateNotNull">出运时间不能为空！</s:text>','info');
			    	}else if(vendorCode == "" || vendorCode == null){
			    		$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.selectVendor">请选择运输公司！</s:text>','info');
			    	//假如海空联运不是FT03时存储数据
			    	}else if(data.itemCode != 'FT03'){
			    		$.messager.progress({
			    			text : '<s:text name="the.data.load">数据加载中....</s:text>',
			    			interval : 100
			    		});
			    	 	 $.ajax({
			    			url:'${dynamicURL}/salesOrder/salesOrderAction!addOrderCondition.do',
			    			dataType:'json',
			    			data:{
			    				orderShipment: data.itemCode,
			    				orderCode: $('#orderCode').val(),
			    				vendorCode : vendorCode,
			    				orderShipDate : orderShipDate,
			    				portStartCode : portStartCode,
			    				portEndCode : portEndCode,
			    				orderDealType : orderDealType
			    			},
			    			success:function(data){
			    				tabData();
// 			    				if(vendorNumber <= 1){
			    					if(data.success){
					    				bidFlag = true;
					    				$.messager.progress('close');
					    				lastIndex = -1;
				    				}else{
				    					bidFlag = false;
				    					vendorInfoFlag = false;
				    					$.messager.progress('close');
				    					if(shipInfoFlag){
				    						$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.bid.uploadBidInfo">请录入中标信息！</s:text>','info');
				    					}
				    					lastIndex = -1;
				    				}
// 			    				}else{
// 			    					$.messager.progress('close');
// 			    				}
			    			}
			    		}); 
			    	}
		    	//}
		    } 
		});
		var urlVendor = "";
		if(null == vendorPara || vendorPara == ""){
			urlVendor = '${dynamicURL}/basic/vendorAction!datagrid.action?shipMentMethod='+orderShipPara;
		}else{
			urlVendor = '${dynamicURL}/basic/vendorAction!datagrid.action?vendorCode='+vendorPara+"&shipMentMethod="+orderShipPara;
		}
		//加载运输公司信息
		$('#vendorCode').combogrid({
			 url:urlVendor,
			 idField:'vendorCode',  
			 textField:'vendorNameCn',
		     panelWidth : 500,
			 panelHeight : 220,
			 pagination : true,
			 pagePosition : 'bottom',
			 toolbar : '#_VENDOR',
			 rownumbers : true,
			 pageSize : 5,
			 pageList : [ 5, 10 ],
			 fit : true,
			 fitColumns : true,
			 editable : false,
			 columns : [ [ {
				field : 'vendorCode',
				title : '运输公司编码',
				width : 20
			 },{
				field : 'vendorNameCn',
				title : '运输公司名称',
				width : 20
			 }  ] ],
			 onSelect:function(rowIndex, rowData){
					//获取运输方式code
					var shipment = $('#orderShipment').combobox('getValue');
					//获取出运时间
				    var orderShipDate = $('#orderShipDate').datebox('getValue');
					//获取始发港code
				    var portStartCode = $('#portStartCode').combobox('getValue');
					//获取目的港code
				    var portEndCode = $('#portEndCode').val();
				    //获取成交方式
			    	var orderDealType = $('#orderDealType').combogrid('getValue');
				  //  if(orderDealType != "FOB" && orderDealType != "FOC"){
				    	if(orderShipDate == "" || orderShipDate == null){
					    	$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.shipdateNotNull">出运时间不能为空！</s:text>','info');
					    }else if(shipment == "" || shipment == null){
					    	$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.selectShipment">请选择运输方式！</s:text>','info');
					    	$('#vendorCode').combogrid('clear');
					    //假如海空联运不是FT03时存储数据
					    }else if(shipment != 'FT03'){
					    	$.messager.progress({
				    			text : '<s:text name="the.data.load">数据加载中....</s:text>',
				    			interval : 100
				    		});
					    	$.ajax({
					    		url:'${dynamicURL}/salesOrder/salesOrderAction!addOrderCondition.do',
					    		dataType:'json',
					    		data:{
					    			orderShipment: shipment,
					    			orderCode: $('#orderCode').val(),
					    			vendorCode : rowData.vendorCode,
					    			orderShipDate : orderShipDate,
					    			portStartCode : portStartCode,
					    			portEndCode : portEndCode,
					    			orderDealType : orderDealType
					    		},
					    		success:function(data){
					    			shipNumber = shipNumber + 1;
					    			tabData();
// 					    			if(shipNumber <= 1){
					    				if(data.success){
							    			bidFlag = true;
							    			$.messager.progress('close');
							    			lastIndex = -1;
						    			}else{
						    				bidFlag = false;
						    				shipInfoFlag = false;
						    				$.messager.progress('close');
						    				if(vendorInfoFlag){
							    				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.bid.uploadBidInfo">请录入中标信息！</s:text>','info');
							    			}
						    				lastIndex = -1;
						    			}
// 					    			}else{
// 					    				$.messager.progress('close');
// 					    			}
					    	  }
					    }); 
					 } 
				   // }
			} 
		});
		//加载订单付款方式信息
		$('#orderPaymentMethod').combobox({
			 url:'${dynamicURL}/payorder/confPayOrderItemAction!selectPayMentMethod.action',  
			 valueField:'itemCode',  
			 textField:'itemNameCn',
			 editable : false
		});
		var urlExec = "";
		if(null == execPara || execPara == ""){
			urlExec = '${dynamicURL}/salesOrder/salesOrderAction!selectAllOrderManager.do';
		}else{
			urlExec = '${dynamicURL}/salesOrder/salesOrderAction!selectAllOrderManager.do?empCode='+execPara;
		}
		//备件订单经理
		$('#orderExecManager').combogrid({
			url:urlExec,
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_DOC',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		});
		var urlCust = "";
		if(null == custPara || custPara == ""){
			urlCust = '${dynamicURL}/salesOrder/salesOrderAction!selectOrderCustManager.do';
		}else{
			urlCust = '${dynamicURL}/salesOrder/salesOrderAction!selectOrderCustManager.do?empCode='+custPara;
		}
		//经营体长
		$('#orderCustNamager').combogrid({
			url:urlCust,
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_CUST',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		}); 
		var urlPord = "";
		if(null == prodPara || prodPara == ""){
			urlPord = '${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do';
		}else{
			urlPord = '${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do?empCode='+prodPara;
		}
		//产品经理
		$('#orderProdManager').combogrid({
			url:urlPord,
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_PROD',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		}); 
		var urlTran = "";
		if(null == tranPara || tranPara == ""){
			urlTran = '${dynamicURL}/salesOrder/salesOrderAction!selectOrderTranManager.do';
		}else{
			urlTran = '${dynamicURL}/salesOrder/salesOrderAction!selectOrderTranManager.do?empCode='+tranPara;
		}
		//订舱经理
		$('#orderTransManagerCode').combogrid({
			url:urlTran,
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_TRAN',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		}); 
		var urlRec = "";
		if(null == recPara || recPara == ""){
			urlRec = '${dynamicURL}/salesOrder/salesOrderAction!selectOrderRecManager.do';
		}else{
			urlRec = '${dynamicURL}/salesOrder/salesOrderAction!selectOrderRecManager.do?empCode='+recPara;
		}
		//收汇经理
		$('#orderRecManager').combogrid({
			url:urlRec,
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_REC',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		}); 
		/* var urlDoc = "";
		if(null == docPara && docPara == ""){
			urlDoc = '${dynamicURL}/salesOrder/salesOrderAction!selectOrderDocManager.do';
		}else{
			urlDoc = '${dynamicURL}/salesOrder/salesOrderAction!selectOrderDocManager.do?empCode='+docPara;
		}
		//单证经理
		$('#docManager').combogrid({
			url:urlDoc,
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_DOC',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		});  */
		//单证经理下拉选变成备件订单经理
		var urlExec = "";
		if(null == docPara || docPara == ""){
			urlExec = '${dynamicURL}/salesOrder/salesOrderAction!selectAttachOrderManager.do';
		}else{
			urlExec = '${dynamicURL}/salesOrder/salesOrderAction!selectAttachOrderManager.do?empCode='+docPara;
		}
		$('#docManager').combogrid({
			url:urlExec,
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_ORDER',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		});
		var urlTerm = "";
		if(null == termPara || termPara == ""){
			urlTerm = '${dynamicURL}/payorder/paymentTermsAction!datagridSelect.action';
		}else{
			urlTerm = '${dynamicURL}/payorder/paymentTermsAction!datagridSelect.action?termsCode='+termPara;
		}
		//加载订单付款条件信息
		$('#orderPaymentTerms').combogrid({
			    url:urlTerm,
				idField:'termsCode',  
			    textField:'termsDesc',
				panelWidth : 500,
				panelHeight : 220,
				pagination : true,
				pagePosition : 'bottom',
				toolbar : '#_PAYMENTTERM',
				rownumbers : true,
				pageSize : 5,
				pageList : [ 5, 10 ],
				fit : true,
				fitColumns : true,
				editable : false,
				columns : [ [ {
					field : 'termsCode',
					title : '付款条件编码',
					width : 20
				},{
					field : 'termsDesc',
					title : '付款条件描述',
					width : 20
				}  ] ]
		});
		//如果是免费订单没有付款方式
		if('${orderType}' == '5' || '${orderType}' == '6' || '${orderType}' == '8'){
			$('#orderCustNamager').combogrid('disable');
			$('#orderProdManager').combogrid('disable');
			$('#orderRecManager').combogrid('disable');
			$('#orderPaymentCycle').attr("disabled","disabled");
			$('#orderPaymentMethod').combobox('disable');
			$('#orderPaymentTerms').combogrid('disable');
			
		};
	});
	//保存订单状态信息
	function saveSalesOrder(){
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中....</s:text>',
			interval : 100
		});
		//获取成交方式 
		var orderDealType = $('#orderDealType').combogrid('getValue');
		//获取经营体长
		var orderCustNamager = $('#orderCustNamager').combogrid('getValue');
		//获取产品经理
		var orderProdManager = $('#orderProdManager').combogrid('getValue');
		//获取订舱经理
		var orderTransManager = $('#orderTransManagerCode').combogrid('getValue');
		//获取收汇经理
		var orderRecManager = $('#orderRecManager').combogrid('getValue');
		//获取单证经理
		var docManager = $('#docManager').combogrid('getValue');
		//获取订单付款周期
		var orderPaymentCycle = $('#orderPaymentCycle').val();
		//获取订单付款方式
		var orderPaymentMethod = $('#orderPaymentMethod').combobox('getValue');
		//获取订单付款条件
		var orderPaymentTerms = $('#orderPaymentTerms').combobox('getValue');
		//获取T模式
		var tmodelCode = $('#tmodelCode').combobox('getValue');
		//获取售达方
		var orderSoldToName = $('#orderSoldToName').val();
		//获取收货人
		var orderShipToName = $('#orderShipToName').val();
		//获取始发港
		var portStartName = $('#portStartCode').combobox('getValue');
		//获取目的港
		var portEndName = $('#portEndName').val();
		//获取销售大区
		var orderSaleArea = $('#saleArea').combogrid('getValue');
		//生产工厂
		var factoryCodes = $('#factoryCode').combogrid('getValue'); 
		if(!bidFlag){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.bid.uploadBidInfo">请录入中标信息！</s:text>','info');
		}else if(orderSoldToName == "" || orderSoldToName == null){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.soldToValidator">售达方不能为空,请检查！</s:text>','info');
		}else if(orderShipToName == "" || orderShipToName == null){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.shipToValidator">收货人不能为空,请检查！</s:text>','info');
		}else if(portStartName == "" || portStartName == null){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.portStartValidator">始发港不能为空,请检查！</s:text>','info');
		}else if(portEndName == "" || portEndName == null){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.portEndValidator">目的港不能为空,请检查！</s:text>','info');
		}else if(orderDealType == "" || orderDealType == null){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.dealTypeNotNull">成交方式不能为空,请检查！</s:text>','info');
		}else if(orderTransManager == "" || orderTransManager == null){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.transManagerValidator">订舱经理不能为空,请检查！</s:text>','info');
		}else if(factoryCodes == "" || factoryCodes == null){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.factoryValidator">生产工厂不能为空,请检查！</s:text>','info');
		}else if(docManager == "" || docManager == null){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.docManagerValidator">单证经理不能为空,请检查！</s:text>','info');
		}else if(orderSaleArea == "" || orderSaleArea == null){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.salesAreaNotNUll">销售大区不能为空,请检查！</s:text>','info');
		}else if(tmodelCode == "" || tmodelCode == null){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.tmodInfoValidator">T模式不能为空,请检查！</s:text>','info');
		//验证是否没有录入箱量
		}else if(!valiTypQua()){
			$.messager.progress('close');
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.loadBidInfo">如果是海运,请箱型箱量至少输入一项(如果是空运,请录入毛重),请检查！</s:text>','info');
		}else if('${orderType}' == '9' ) {
			if(orderCustNamager == "" || orderCustNamager == null){
				$.messager.progress('close');
				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.custManagerValidator">经营体长不能为空,请检查！</s:text>','info');
			}else if(orderProdManager == "" || orderProdManager == null){
				$.messager.progress('close');
				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.prodManagerValidator">产品经理不能为空,请检查！</s:text>','info');
			}else if(orderRecManager == "" || orderRecManager == null){
				$.messager.progress('close');
				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.recManagerValidator">收汇经理不能为空,请检查！</s:text>','info');
			}else if(orderPaymentCycle == "" || orderPaymentCycle == null){
				$.messager.progress('close');
			    $.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.payCycleValidator">订单付款周期不能为空,请检查！</s:text>','info');
			}else if(orderPaymentMethod == "" || orderPaymentMethod == null){
				$.messager.progress('close');
				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.payMethodValidator">订单付款方式不能为空,请检查！</s:text>','info');
			}else if(orderPaymentTerms == "" || orderPaymentTerms == null){
				$.messager.progress('close');
				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.payTermValidator">订单付款条件不能为空,请检查！</s:text>','info');
			}else{
				submitCommonForm();
			}
		}else{
			submitCommonForm();
		}
	}
	//公用的form提交
	function submitCommonForm(){
		 $('#salesOrderSaveForm').form('submit',{
				url:'${dynamicURL}/salesOrder/salesOrderAction!saveAttachOrder.do',
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
						//代办关闭
						parent.window.HROS.window.close(currentappid);
						$.messager.progress('close');
				    }
				}
			}); 
	}
	//暂存
	function tempSave(){
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中....</s:text>',
			interval : 100
		});
		tempSubmitCommonForm();
	}
	//暂存公用的form提交
	function tempSubmitCommonForm(){
		 $('#salesOrderSaveForm').form('submit',{
				url:'${dynamicURL}/salesOrder/salesOrderAction!tempSaveAttachOrder.do',
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
						$.messager.progress('close');
				    }
				}
			}); 
	}
	//验证是否没有录入箱量
	function  valiTypQua(){
		var rows = $('#conditionDatagrid').datagrid('getRows');
		//标识是否验证通过
		var flag = true;
		var typQuaTotal = 0;
		for(var i =0; i < rows.length; i++){
			if(rows[i].conditionCode == "ZF00" || rows[i].conditionCode == "ZF02" ||rows[i].conditionCode == "ZF04" || rows[i].conditionCode == "ZF06"||rows[i].conditionCode =="ZF30"){
				typQuaTotal = typQuaTotal + rows[i].conditionRate;
			}
		}
		if(typQuaTotal <= 0){
			flag = false;
		}
		if(!flag){
			return flag;
		}else{
			return flag;
		}
	}
	
	//模糊查询备件订单经理下拉列表
	 function _getOrderManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectAttachOrderManager.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	} 
	//重置查询备件订单经理下拉列表
	function _cleanOrderManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectAttachOrderManager.do'
		});
		//$('#' + inputId ).val(_CCNTEMP);
	}
	//模糊查询单证经理下拉列表
	function _getDocManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectAllOrderManager.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询单证经理下拉列表
	function _cleanDocManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectAllOrderManager.do'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询经营体长下拉列表
	function _getCustManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderCustManager.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询经营体长下拉列表
	function _cleanCustManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderCustManager.do'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询产品经理下拉列表
	function _getProdManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询产品经理下拉列表
	function _cleanProdManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询订舱经理下拉列表
	function _getTranManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderTranManager.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询订舱经理下拉列表
	function _cleanTranManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderTranManager.do'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询收汇经理下拉列表
	function _getRecManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderRecManager.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询收汇经理下拉列表
	function _cleanRecManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderRecManager.do'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询船公司下拉列表
	function _VENDORMY(inputId,inputName, selectId) {
		//获取运输方式code
		var shipment = $('#orderShipment').combobox('getValue');
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/vendorAction!datagrid.action?vendorNameCn=' + _CCNTEMP+'&vendorCode='+_CCNCODE+'&shipMentMethod='+shipment
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询船公司信息输入框
	function _VENDORMYCLEAN(inputId, inputName, selectId) {
		//获取运输方式code
		var shipment = $('#orderShipment').combobox('getValue');
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/vendorAction!datagrid.action?shipMentMethod='+shipment
				});
	}
	//模糊查询付款条件下拉列表
	function _TERMMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/payorder/paymentTermsAction!datagridSelect.action?termsCode='+_CCNCODE+'&termsDesc='+_CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询付款条件信息输入框
	function _TERMMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/payorder/paymentTermsAction!datagridSelect.action'
				});
	}
	//模糊查询成交方式下拉列表
	function _DEALMY(inputId, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		//var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/sysLovAction!selectDealTypeInfo.do?itemCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询成交方式输入框
	function _DEALCLEAN(inputId, selectId) {
		$('#'+inputId).val("");
		//$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/sysLovAction!selectDealTypeInfo.do'
				});
	}
	//模糊查询销售大区下拉列表
	function _AREAMY(inputId, selectId){
		var _CCNCODE = $('#' + inputId).val();
		//var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/sysLovAction!selectOrgAreaInfo.do?itemNameCn='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询销售大区输入框
	function _AREACLEAN(inputId, selectId){
		$('#'+inputId).val("");
		//$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/sysLovAction!selectOrgAreaInfo.do'
				});
	} 
	//加载无商检的T模式
	function loadOrderNoCheck(){
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中....</s:text>',
			interval : 100
		});
		var orderInspectionFlag;
		if($('#orderInspectionFlag').attr('checked')=='checked'){
			orderInspectionFlag = 1;
		}
		if($('#orderInspectionNoFlag').attr('checked')=='checked'){
			orderInspectionFlag = 0;
		}
		
		$.ajax({
	   	     url:"${dynamicURL}/salesOrder/salesOrderAction!loadOrderNoCheck.action",
	   	     data:{
	   	    	  orderCode : '${orderCode}',
	   	    	  orderInspectionFlag : orderInspectionFlag
	   	     },
	   	     dataType:"json",
	   	     type:'post',
	   	     success:function(data){
	   	    	//$('#tmodelCode').combobox('loadData',data);
	   	    	for(var i = 0; i < data.length; i++){
	   	    		$('#tmodelCode').combobox('setValue',data[i].configId);
	   	    		$('#tmodelCode').combobox('setText',data[i].tmodName);
	   	    	}
	   	    	$.messager.progress('close');
	   	     }
		});
	}
	//模糊查询成交方式下拉列表
	function _FACTORYMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'+'&deptCode='+_CCNCODE+'&deptNameCn='+_CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询成交方式输入框
	function _FACTORYMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'
				});
	}
	//获取整机订单信息
	function gainOrder(){
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中....</s:text>',
			interval : 100
		});
		//获取订单号
		var gainOrderCode = $('#spZor').val();
		if(gainOrderCode == "" || gainOrderCode == null){
		    $.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.orderNoNull">整机订单号不能为空,请检查！</s:text>','info');
		    $.messager.progress('close');
		}else{
			$.ajax({
		   	     url:'${dynamicURL}/salesOrder/salesOrderAction!gainOrder.action',
		   	     data:{
		   	    	    orderCode:gainOrderCode
		   	    	  },
		   	     dataType:"json",
		   	     type:'post',
		   	     success:function(data){
		   	         if(data.orderCode == null){
		   	        	 $.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.orderNoExist">订单号不存在,请检查！</s:text>','info');
		   	        	 $.messager.progress('close');
		   	         }else{
		   	             //获取成交方式 
		   	        	 var orderDealCode = data.orderDealType;
		   	        	 //替换国家code和name
		   	        	 $('#countryCode').val(data.countryCode);
		   	        	 $('#countryName').val(data.countryName);
		   	        	 $('#countryName').attr('title',data.countryName);
		   	        	 //替换收货人code和name
		   	        	 $('#orderShipTo').val(data.orderShipTo);
		   	        	 $('#orderShipToName').val(data.orderShipToName);
		   	        	 $('#orderShipToName').attr('title',"("+data.orderShipTo+")"+data.orderShipToName);
		   	        	 //替换售达方code和name
		   	        	 $('#orderSoldTo').val(data.orderSoldTo);
		   	        	 $('#orderSoldToName').val(data.orderSoldToName);
		   	        	 $('#orderSoldToName').attr('title',"("+data.orderSoldTo+")"+data.orderSoldToName);
		   	        	 //替换始发港code和name
		   	      	     $('#portStartCode').combobox('setValue',data.portStartCode);
		   	        	 //替换目的港code和name
		   	        	 $('#portEndCode').val(data.portEndCode);
		   	        	 $('#portEndName').val(data.portEndName);
		   	        	 $('#portEndName').attr('title',"("+data.portEndCode+")"+data.portEndName);
		   	        	 //替换运输方式code和name
		   	        	 $('#orderShipment').combobox('setValue',data.orderShipment);
		   	        	 //替换运输公司code和name
		   	        	 $('#vendorCode').combogrid('setValue',data.vendorCode);
		   	        	 $('#vendorCode').combogrid('setText',data.vendorName);
		   	        	 //替换订舱经理code和name
		   	        	 $('#orderTransManagerCode').combogrid('setValue',data.orderTransManager);
		   	        	 $('#orderTransManagerCode').combogrid('setText',data.orderTransManagerName);
		   	        	 //替换销售大区code和name
		   	        	 $('#saleArea').combogrid('setValue',data.saleArea);
		   	        	 $('#saleArea').combogrid('setText',data.saleAreaName);
		   	        	 //替换单证经理code和name
		   	        	 $('#docManager').combogrid('setValue',data.docManager);
		   	        	 $('#docManager').combogrid('setText',data.docManagerName);
		   	        	 //替换经营体code和name
	   	        		 $('#deptCode').val(data.deptCode);
	   	        		 $('#deptName').val(data.deptName);
		   	        	 //如果是付费备件订单替换增加如下信息
		   	        	 if('${orderType}'== "9"){
		   	        		 //替换经营体长code和name  
		   	        		 $('#orderCustNamager').combogrid('setValue',data.orderCustNamager);
		   	        	     $('#orderCustNamager').combogrid('setText',data.orderCustName);
		   	        		 //替换产品经理code和name
		   	        		 $('#orderProdManager').combogrid('setValue',data.orderProdManager);
		   	        	     $('#orderProdManager').combogrid('setText',data.orderProdName);
		   	        		 //替换收汇经理code和name
		   	        		 $('#orderRecManager').combogrid('setValue',data.orderRecManager);
		   	        	     $('#orderRecManager').combogrid('setText',data.orderRecManagerName);
		   	        		 //替换订单付款周期
		   	        		 $('#orderPaymentCycle').val(data.orderPaymentCycle);
		   	        		 //替换订单付款方式
		   	        		 $('#orderPaymentMethod').combobox('setValue',data.orderPaymentMethod);
		   	        		 //替换订单付款条件code和name
		   	        		 $('#orderPaymentTerms').combogrid('setValue',data.orderPaymentTerms);
		   	        	     $('#orderPaymentTerms').combogrid('setText',data.orderPaymentTermsName);
		   	        	 }
		   	        	 //如果是促销订单替换如下信息
		   	        	 if('${orderType}'== "8"){
		   	        	     //替换订单经理code和name  
		   	        		 $('#orderExecManager').combogrid('setValue',data.orderExecManager);
		   	        	     $('#orderExecManager').combogrid('setText',data.orderExecName);
		   	        	 }
						 $.messager.progress('close');
		   	         }
		   	     } 
		   	 });
		}
	}
</script>
</head>
<body class="easyui-layout">
     <div region="north"   split="true" style="height:270px;"  collapsed="false" >
        <form id="salesOrderSaveForm" method="post" enctype="multipart/form-data">
	        <div class="part_zoc"  style="margin:0px 0px 0px 0px;">
	            <div class="partnavi_zoc">
						<span><s:text name="order.confirm.attachInfo">订单信息</s:text>：</span>
				</div>
				<div class="oneline">
				    <div class="item25">
							<div class="itemleft100">订单编号：</div>
							<div class="righttext">
								<input id="orderCode" name="orderCode" class="short50" style="background-color: #EBEBE4"  
							    readonly="true"   type="text"  title=""  />
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
					<div class="item25">
						<div class="itemleft100">经营体：</div>
						<div class="righttext">
						    <input id="deptCode" name="deptCode" type="hidden"></input>
							<input id="deptName" name="deptName"   type="text" class="short50" disabled="true" title=""/>
						</div>
					</div>
					<div class="item25">
				         <div class="itemleft100">客户订单号：</div>
						 <div class="righttext">
								<input id="orderPoCode" name="orderPoCode"  disabled="true"  title=""
									class="short50" type="text" />
						 </div>
				     </div>
				</div>
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100">出口国家：</div>
						<div class="righttext">
						    <input id="countryCode" name="countryCode" type="hidden"></input>
							<input id="countryName" name="countryName" class="short50"  style="background-color: #EBEBE4"  
							    readonly="true" type="text" title=""/>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft100">收货人：</div>
						<div class="righttext">
						    <input id="orderShipTo" name="orderShipTo" type="hidden"></input>
							<input id="orderShipToName" name="orderShipToName" class="short50" style="background-color: #EBEBE4"  
							    readonly="true" type="text"  title="" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft100">售达方：</div>
						<div class="righttext">
						    <input id="orderSoldTo" name="orderSoldTo" type="hidden"></input>
							<input id="orderSoldToName" name="orderSoldToName" class="short50" style="background-color: #EBEBE4" 
							    readonly="true" type="text" title="" />
						</div>
					</div>
				    <div class="item25">
						<div class="itemleft100">目的港：</div>
						<div class="righttext">
						    <input id="portEndCode" name="portEndCode" type="hidden"></input>
							<input id="portEndName" name="portEndName" class="short50"  style="background-color: #EBEBE4" 
							    readonly="true"  type="text"  title=""  />
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">币种：</div>
						<div class="righttext">
							<input id="currencyName" name="currencyName"  disabled="true" type="text"
								class="short50" />
						</div>
					</div>
				</div>
				<div class="oneline">
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
					<s:if  test="orderType != 8">
					     <div class="item25">
						    <div class="itemleft100">订单经理：</div>
						    <div class="righttext">
							    <input id="empName" name="empName"  type="text" class="short50"  disabled="true"/>
						     </div>
					    </div>
					</s:if>
					<s:else>
					    <div class="item25">
						    <div class="itemleft100">订单经理：</div>
						    <div class="rightselect_easyui">
							    <input id="orderExecManager" name="orderExecManager"  type="text" class="short50" />
						     </div>
					    </div>
					</s:else>
					<div class="item25">
						<div class="itemleft100">出运时间：</div>
						<div class="righttext">
							<input id="orderShipDate" name="orderShipDate"  class="easyui-datebox" editable="false" style="width: 102px;" />
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">始发港：</div>
						<div class="rightselect_easyui">
							<input id="portStartCode" name="portStartCode" class="short50" style="background-color: #EBEBE4" 
							     type="text" />
						</div>
				    </div>
				</div>
				<div class="oneline">
				    <div  class="item25">
				        <div class="itemleft100">成交方式：</div>
						<div class="rightselect_easyui">
							<input id="orderDealType" name="orderDealType"  type="text" class="short50"  />
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">运输方式：</div>
						<div class="rightselect_easyui">
							<input id="orderShipment" name="orderShipment" class="short50"  type="text" />
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">运输公司：</div>
						<div class="rightselect_easyui">
							<input id="vendorCode" name="vendorCode" class="short50"   type="text" title=""/>
						</div>
				    </div>
					<div  class="item25">
				        <div class="itemleft100">单证经理：</div>
						<div class="rightselect_easyui">
							<input id="docManager" name="docManager"   type="text" class="short50" />
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">订舱经理：</div>
						<div class="rightselect_easyui">
							<input id="orderTransManagerCode" name="orderTransManager"  type="text" class="short50" />
						</div>
					</div>
				</div>
				<div class="oneline">
				    <div  class="item25">
				        <div class="itemleft100">生产工厂：</div>
						<div class="righttext">
							<input id="factoryCode" name="factoryCode" style="width:100px" editable="false" />
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">经营体长：</div>
						<div class="rightselect_easyui">
							<input id=orderCustNamager name="orderCustNamager"   type="text" class="short50" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft100">产品经理：</div>
						<div class="rightselect_easyui">
							<input id="orderProdManager" name="orderProdManager"   type="text" class="short50" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft100">收汇经理：</div>
						<div class="rightselect_easyui">
							<input id="orderRecManager" name="orderRecManager"   type="text" class="short50" />
						</div>
					</div>
					<div class="item25">
							<div class="itemleft100">销售大区：</div>
							<div class="righttext">
								<input id="saleArea" name="saleArea"   type="text" 
									class="short50" />
							</div>
					</div>
				</div>
				<div class="oneline">
				    <div  class="item25">
				        <div class="itemleft100">订单付款周期：</div>
						<div class="righttext">
							<input id="orderPaymentCycle" name="orderPaymentCycle"   type="text"
								class="short50" />
						</div>
				    </div>
				    <div  class="item25">
				        <div class="itemleft100">订单付款方式：</div>
						<div class="rightselect_easyui">
							<input id="orderPaymentMethod" name="orderPaymentMethod"  type="text"
								class="short50" />
						</div>
				    </div>
				    <div  class="item25">
				        <div class="itemleft100">订单付款条件：</div>
						<div class="rightselect_easyui">
							<input id="orderPaymentTerms" name="orderPaymentTerms"  type="text"
								class="short50"  />
						</div>
				    </div>
				    <div  class="item33 lastitem">
				        <div class="itemleft100">整机订单号：</div>
						<div class="righttext">
							<input id="spZor" name="spZor"  type="text"
								class="short50"  />
							<input type="button" value="获  取 " onclick="gainOrder()"/>
						</div>
				    </div>
	        </div>
		 </div>
		 <div class="part_zoc" style="margin:0px 0px 0px 0px;">
				<div class="partnavi_zoc">
					<span><s:text name="order.confirm.orderAuditFlag">订单状态</s:text>：</span>
				</div>
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100">商检：</div>
						<div class="rightcheckbox">
							<input id="orderInspectionFlag" name="orderInspectionFlag" class="short50" type="radio" value="1" onclick="loadOrderNoCheck();"/>
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">不商检：</div>
						<div class="rightcheckbox">
							<input id=orderInspectionNoFlag name="orderInspectionFlag" class="short50" type="radio"  value="0" onclick="loadOrderNoCheck();"/>
						</div>
				    </div>
				    <div class="item33">
						<div class="itemleft100">订单附件上传：</div>
						<div class="righttext">
							<s:file id="excleFile" name="excleFile"  style="width:140px" />
						</div>
				    </div>
				     <div class="item25">
				        <div class="itemleft60">T模式：</div>
				        <div class="rightselect_easyui">
				            <input id="tmodelCode"  name="tmodelCode"  class="short80"  type="text" editable="false" />
				        </div>
				    </div>
				</div>
				<div  class="oneline">
				    <div class="item100 lastitem">
				        <div class="oprationbutt">
				            <input type="button" value="<s:text name="global.form.save">保 存</s:text>" onclick="saveSalesOrder()"/>
				            <input type="button" value="<s:text name="global.form.temp">暂 存</s:text>"  onclick="tempSave()"/>
				        </div>
				    </div>
				</div>
			</div>
		</form>
	</div>
     
     <div region="center"  style="background:#eee;"  id="attachIframe">
           <jsp:include page="attachOrderDetailEdit.jsp"></jsp:include>
     </div>  
     <!-- 订单经理下拉选信息 -->
	<div id="_ORDER">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_ORDERMANAGERCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">订单经理：</div>
				<div class="righttext">
					<input class="short50" id="_ORDERMANAGERINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_getOrderManager('_ORDERMANAGERCODE','_ORDERMANAGERINPUT','docManager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_cleanOrderManager('_ORDERMANAGERCODE','_ORDERMANAGERINPUT','docManager')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 经营体长下拉选信息 -->
	<div id="_CUST">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_CUSTCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">经营体长：</div>
				<div class="righttext">
					<input class="short50" id="_CUSTINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_getCustManager('_CUSTCODE','_CUSTINPUT','orderCustNamager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_cleanCustManager('_CUSTCODE','_CUSTINPUT','orderCustNamager')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 产品经理下拉选信息 -->
	<div id="_PROD">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_PRODCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">产品经理：</div>
				<div class="righttext">
					<input class="short50" id="_PRODINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_getProdManager('_PRODCODE','_PRODINPUT','orderProdManager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_cleanProdManager('_PRODCODE','_PRODINPUT','orderProdManager')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 订舱经理下拉选信息 -->
	<div id="_TRAN">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_TRANCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">订舱经理：</div>
				<div class="righttext">
					<input class="short50" id="_TRANINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_getTranManager('_TRANCODE','_TRANINPUT','orderTransManagerCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_cleanTranManager('_TRANCODE','_TRANINPUT','orderTransManagerCode')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 收汇经理下拉选信息 -->
	<div id="_REC">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_RECCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">收汇经理：</div>
				<div class="righttext">
					<input class="short50" id="_RECINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_getRecManager('_RECCODE','_RECINPUT','orderRecManager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_cleanRecManager('_RECCODE','_RECINPUT','orderRecManager')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 单证经理下拉选信息 -->
	<div id="_DOC">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_DOCCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">订单经理：</div>
				<div class="righttext">
					<input class="short50" id="_DOCINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_getDocManager('_DOCCODE','_DOCINPUT','orderExecManager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_cleanDocManager('_DOCCODE','_DOCINPUT','orderExecManager')" />
				</div>
			</div>
		</div>
	</div>
	<!-- 船公司下拉选信息 -->
	<div id="_VENDOR">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">运输公司编号：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">运输公司名称：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_VENDORMY('_VENDORCODE','_VENDORNAME','vendorCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_VENDORMYCLEAN('_VENDORCODE','_VENDORNAME','vendorCode')" />
				</div>
			</div>
		</div>
	</div>
	<!-- 付款条件下拉列表 -->
	<div id="_PAYMENTTERM">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">付款编码：</div>
				<div class="righttext">
					<input class="short50" id="_TERMCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">付款条件描述：</div>
				<div class="righttext">
					<input class="short50" id="_TERMNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_TERMMY('_TERMCODE','_TERMNAME','orderPaymentTerms')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_TERMMYCLEAN('_TERMCODE','_TERMNAME','orderPaymentTerms')" />
				</div>
			</div>
		</div>
	</div>
	<!-- 成交方式下拉列表 -->
	<div id="_DEALDIV">
	    <div class="oneline">
		     <div class="item25">
				<div class="itemleft100">成交方式编号：</div>
				<div class="righttext">
					<input class="short50" id="_DEALCODE" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_DEALMY('_DEALCODE', 'orderDealType')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_DEALCLEAN('_DEALCODE', 'orderDealType')" />
				</div>
			</div>
		</div>
	</div>
	<!-- 销售大区下拉列表 -->
	<div id="_AREADIV">
	    <div class="oneline">
		     <div class="item25">
				<div class="itemleft100">销售大区名称：</div>
				<div class="righttext">
					<input class="short50" id="_AREACODE" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_AREAMY('_AREACODE', 'saleArea')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_AREACLEAN('_DEALCODE', 'saleArea')" />
				</div>
			</div>
		</div>
	</div>
	  <!-- 生产工厂下拉选信息 -->
	<div id="_FACTORY">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">生产工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_FACTORYCODE" type="text" value="${factoryTrunk}"/>
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">生产工厂名称：</div>
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