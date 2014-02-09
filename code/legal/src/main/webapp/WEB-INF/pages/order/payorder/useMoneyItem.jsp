<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var useMoneydatagrid;
	var lastIndex;
	var percentMoney = '';
	$(window).load(function() {
		setTimeout(function(){
	    if('${payNum}' == '1' && '${paymentMethodsName[1]}' != "") {
	    	var contactStr = "  具体金额:  ${paymentMethodsName[0]} -- " + roundDouble(${payOneRate}*(customWindow.amount),4) +
	    	                 "  ,${paymentMethodsName[1]} -- " + roundDouble(${paySecendRate}*(customWindow.amount),4);
	    	percentMoney =   "  付款方式: ${payOneRate*100}%${paymentMethodsName[0]} + ${paySecendRate*100}%${paymentMethodsName[1]} " + contactStr;
	    }
	    
	    //查询列表	
		useMoneydatagrid = $('#useMoneydatagrid').datagrid({
			url : '${dynamicURL}/payorder/confPayOrderItemAction!showDatagrid.do',
			title : '用款查询 <font color=red>总金额:' + customWindow.showAmount +  
			" 销售组织:" + customWindow.salesOrgName + percentMoney + "</font>",
			queryParams:{
				payOneMethod:'${paymentMethods[0]}',
				paySecendMethod:'${paymentMethods[1]}',
				customerId:customWindow.hiddenCustomerCode,
				payTimesFlag:customWindow.isPayOneFinished,
				payNum:'${payNum}',
				currency:customWindow.currency,
				toUsaExchange:customWindow.toUsaExchange,
				toCnyExchange:customWindow.toCnyExchange,
				orderNum:customWindow.orderNum,
				salesOrgCode:customWindow.salesOrgCode
			},
			iconCls : 'icon-save',
			pagination : true,
			singleSelect : true,
			pagePosition : 'bottom',
			rownumbers : true,      
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			
			/* onLoadSuccess: function(data){
				if(data.rows.length>0){
					var type = data.rows[0].paymentMethod;
					if(type == 'O') {
						$($(this).prev().find("table.datagrid-htable td[field='paymentMethodName'] span").get(0)).text("--付款方式--");
					}else{
						$($(this).prev().find("table.datagrid-htable td[field='paymentMethodName'] span").get(0)).text("--付款方式2--");
					}
				}
			}, */
			columns : [ [ 
			   {field:'customerName',title:'客户名称',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.customerName;
					}
				},				
			   {field:'paymentMethodName',title:'付款方式',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						if(row.paymentMethod == 'O') {
							var opts = $('#useMoneydatagrid').datagrid('getColumnOption','payCode');
							
						}
						return row.paymentMethodName;
					}
				},				
			   {field:'payCode',title:'单据编号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.payCode;
					}
				},
			   {field:'totalAmount',title:'总金额',align:'center',sortable:true,width:250,
					formatter:function(value,row,index){
						return row.totalAmount;
					}
				},				
			   {field:'amount',title:'已使用金额',align:'center',sortable:true,width:250,
					formatter:function(value,row,index){
						return row.amount;
					}
				},				
			   {field:'balance',title:'余额',align:'center',sortable:true,width:250,
					formatter:function(value,row,index){
						return row.balance;
					}
				},
				{field:'orderCurrency',title:'订单币种',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return customWindow.currency;
					}
				},
			   {field:'useMoney',title:'本次付款金额',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.useMoney;
					},
					editor:{
						   type:'numberbox',
						   options:{
								precision:4,
								onChange:function(newValue,oldValue) {
									calAmount(null,null,null);
								}
						   }
					}
			   },
			   
			 ] ],
			 onAfterEdit: function (rowIndex, rowData, changes) {
				 calAmount(rowIndex, rowData, changes);
		     },
			 onLoadSuccess: function(data){
				if(data.rows.length>0){
					$($(this).prev().find("table.datagrid-htable td[field='balance'] span").get(0)).text("余额( " + customWindow.currency + "   汇率 : " + customWindow.toUsaExchange + " )");
					$($(this).prev().find("table.datagrid-htable td[field='amount'] span").get(0)).text("已使用金额");
					$($(this).prev().find("table.datagrid-htable td[field='totalAmount'] span").get(0)).text("总金额");
				}
			 },
			toolbar : [ {
				text : '使用',
				iconCls : 'icon-search',
				handler : function() {
					useMoney();
				}
			}, '-',
			 {
				text : '已经使用:',
				iconCls : 'LuckyStyle',
			}, '-' ,
			{
				text : '0',
				iconCls : 'cal',
			}, '-' ,
			{
				text : '还需支付:',
				iconCls : 'LuckyStyle',
			}, '-' ,
			{
				text : customWindow.showAmount,
				iconCls : 'cal2',
			}],
			onClickRow : function(rowIndex) {
			    if(lastIndex != rowIndex){
					$('#useMoneydatagrid').datagrid('endEdit', lastIndex);
					$('#useMoneydatagrid').datagrid('beginEdit', rowIndex);
				}
				if ($('#useMoneydatagrid').datagrid('getRows').length == 1) {
					$('#useMoneydatagrid').datagrid('beginEdit', rowIndex);
				}
				lastIndex = rowIndex;
			}
		});
		},500);
	});
	
	//动态计算金额
	function calAmount(rowIndex, rowData, changes) {
		endEdit();
		var totalMoney = 0.0;
		//赋予改变行的状态，为判断是否重复
		var updated = $('#useMoneydatagrid').datagrid('getChanges', "updated");
		for(var i = 0 , len = updated.length ; i < len ; i++) {
			if(!(updated[i].useMoney == "" || updated[i].useMoney == 0.00)) {
				totalMoney = accAdd(parseFloat(updated[i].useMoney),totalMoney);		
			}
		}
		$(".cal").text(totalMoney); 
		$(".cal2").text(customWindow.showAmount - totalMoney);
		$(".LuckyStyle").css("color","red");
	}
	//结束编辑方法
	function endEdit() {
		var rowsSelect = $('#useMoneydatagrid').datagrid('getRows');
		for ( var i = 0; i < rowsSelect.length; i++) {
			$('#useMoneydatagrid').datagrid('endEdit', i);
		}
	}
	//使用金额
	function useMoney() {
		$.messager.progress({
			text : '<s:text name="global.useMoney.warn1">数据校验中，请稍等</s:text>！',
			interval : 100
	   });
		//该状态为用于表示是否需要后续的 100%T/T和付款操作
		var breakFlag = "true";
		//用于存储本次付款的总金额
		var paidMoney = 0;
		//用于存储本次付款的总金额
		var totalAmount = 0;
		//默认是100%TT
		var isTT = "true";
		endEdit();
		var rows = $('#useMoneydatagrid').datagrid('getChanges');//修改，新增、删除都会获取到
		//赋予改变行的状态，为判断是否重复
		var updated = $('#useMoneydatagrid').datagrid('getChanges', "updated");
		
		var modUpdate = [];
		for(var i = 0 , len = updated.length ; i < len ; i++) {
			if(!(updated[i].useMoney == "" || updated[i].useMoney == 0.00)) {
				modUpdate[modUpdate.length] = updated[i];
				totalAmount = accAdd(parseFloat(updated[i].useMoney),totalAmount);		
			}
		}
		
		var jsonStr = JSON.stringify(modUpdate);
		$.ajax({
		   type: "POST",
		   url: "${dynamicURL}/salesOrder/salesOrderAction!validateShipDate.action",
		   data:{"confPayOrderItemQueryList":jsonStr,"orderShipDate":customWindow.orderShipDate},
		   success: function(json){
			   $.messager.progress('close');
			   var data = $.parseJSON(json);
			   if(data.success){
				   $.messager.alert('<s:text name="global.form.prompt">提示</s:text>', data.msg,'info');
			   }else{
				    var count = modUpdate.length;
					var datagridJson = {
						"rows" : modUpdate,
						"total" : count,
						"footer" : [{"currency":"总金额","useMoney":totalAmount}]
					};
				
					var flag = false;
					if(rows.length > 0){
						var updated = $('#useMoneydatagrid').datagrid('getChanges', "updated");
						//提示输入的本次使用金额是否大于剩余金额
						var allCode ='';
					   //定义每个付款方式本次付款总额的变量
						var useMoneyTotal = 0.0;
						var useTwoMoneyTotal = 0.0;
						if(${payNum} == 1){
							//假如一次付款的第二次付款方式为空为一次性付款。
							if('${paySecendMethod}' == null || '${paySecendMethod}' == ''){
								//遍历用款数据
								for(var i =0 ;i < updated.length; i++){
									if(updated[i].useMoney > updated[i].balance){
										allCode = allCode + updated[i].payCode +'，';
										flag = true;
										break;
									}else{
										//计算各个付款方式的总额和本次付款总额
										if(updated[i].paymentMethod == '${payOneMethod}'){
											useMoneyTotal = accAdd(useMoneyTotal,parseFloat(updated[i].useMoney));
										}
									}
								}
								if(!flag){
									if(customWindow.amount != useMoneyTotal){
										breakFlag = "false";
										$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.useMoney.warn2">一次性付款总额与使用总额的金额有误，请重新输入！</s:text>','info');
									}else{
										//获取使用的值
										customWindow.payMoneyDetail.datagrid('loadData', datagridJson);
										closeCur();
									}
								}
							}//一次性付款方式的组合方式
							else{
								//遍历用款数据
								for(var i =0 ;i < updated.length; i++){
									if(updated[i].useMoney > updated[i].balance){
										allCode = allCode + updated[i].payCode +'，';
										flag = true;
										break;
									}else{
										//计算各个付款方式的总额和本次付款总额
										if(updated[i].paymentMethod == '${payOneMethod}'){
											useMoneyTotal = accAdd(useMoneyTotal,parseFloat(updated[i].useMoney));
										}
										if(updated[i].paymentMethod == '${paySecendMethod}'){
											useTwoMoneyTotal = accAdd(useTwoMoneyTotal,parseFloat(updated[i].useMoney));
										}
									}
								}
								if(!flag){
									if(customWindow.amount != accAdd(useMoneyTotal,useTwoMoneyTotal)){
										breakFlag = "false";
										$.messager.alert('<s:text name="global.form.prompt">提示</s:text>','<s:text name="global.useMoney.warn2">一次性付款总额与使用总额的金额有误，请重新输入！</s:text>','info');
									}else if(roundDouble(${payOneRate}*(customWindow.amount),4) != useMoneyTotal){
										breakFlag = "false";
										$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '${paymentMethodsName[0]}'+"<s:text name='global.useMoney.message'>付款方式，所付款应为总额的</s:text>"+${payOneRate}*100+"%!",'info');
									}else if(roundDouble(${paySecendRate}*(customWindow.amount),4) != useTwoMoneyTotal){
										breakFlag = "false";
										$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '${paymentMethodsName[1]}'+"<s:text name='global.useMoney.message'>付款方式，所付款应为总额的</s:text>"+${paySecendRate}*100+"%!",'info');
									}
									else{
										//获取使用的值
										customWindow.payMoneyDetail.datagrid('loadData', datagridJson);
										closeCur();
									}
								}
							}
						}
						//如果是二次付款
						if(${payNum} == 2){
							//判断是否是二次付款的第二次付款，payTimesFlag是true是第二次付款
							if(${payTimesFlag}){
								//遍历用款数据
								for(var i =0 ;i < updated.length; i++){
									if(updated[i].useMoney > updated[i].balance){
										allCode = allCode + updated[i].payCode +'，';
										flag = true;
										break;
									}else{
										//计算各个付款方式的总额和本次付款总额
										if(updated[i].paymentMethod == '${paySecendMethod}'){
											useMoneyTotal = accAdd(useMoneyTotal,parseFloat(updated[i].useMoney));
										}
									}
								}
								//判断二次付款的第二次付款比例
								if(!flag){
									/* if(roundDouble(${paySecendRate}*(parent.amount),2) != parseFloat(useMoneyTotal)){
										breakFlag = "false";
										$.messager.alert('提示', "二次付款的第二次"+'${paymentMethodsName[1]}'+"付款方式比例应为总额的"+${paySecendRate}*100+"%!",'info');
									}else{
										//获取使用的值
										window.parent.payMoneyDetail.datagrid('loadData', datagridJson);
										window.parent.showUseMoneyDialog.dialog('close');
									} */
									if(customWindow.amount != useMoneyTotal){
										breakFlag = "false";                                                                                                                                                               
										$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', "<s:text name='global.useMoney.warn3'>付款方式为二次付款，您进行的第二次</s:text>"+'${paymentMethodsName[1]}'+"<s:text name='global.useMoney.warn4'>付款方式比例应为总额的</s:text>"+${paySecendRate}*100+"%!",'info');
									}else{
										//获取使用的值
										customWindow.payMoneyDetail.datagrid('loadData', datagridJson);
										closeCur();
									}
								}
							}else{
								//遍历用款数据
								for(var i =0 ;i < updated.length; i++){
									if(updated[i].useMoney > updated[i].balance){
										allCode = allCode + updated[i].payCode +'，';
										flag = true;
										break;
									}else{
										//计算各个付款方式的总额和本次付款总额
										if(updated[i].paymentMethod == '${payOneMethod}'){
											useMoneyTotal = accAdd(useMoneyTotal,parseFloat(updated[i].useMoney));
										}
									}
								}
								if(!flag){
									//判断二次付款的第一次付款比例
									/* if(roundDouble(${paySecendRate}*(parent.amount),2) != parseFloat(useMoneyTotal)){
										breakFlag = "false";
										$.messager.alert('提示', "二次付款的第二次"+'${paymentMethodsName[1]}'+"付款方式比例应为总额的"+${paySecendRate}*100+"%!",'info');
									}else{
										//获取使用的值
										window.parent.payMoneyDetail.datagrid('loadData', datagridJson);
										window.parent.showUseMoneyDialog.dialog('close');
									} */
									if(customWindow.amount != useMoneyTotal){
										breakFlag = "false";
										$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', "<s:text name='global.useMoney.warn5'>付款方式为二次付款，您进行的第一次</s:text>"+'${paymentMethodsName[0]}'+"<s:text name='global.useMoney.warn4'>付款方式比例应为总额的</s:text>"+${payOneRate}*100+"%!",'info');
									}else{
										//获取使用的值
										customWindow.payMoneyDetail.datagrid('loadData', datagridJson);
										closeCur();
									}
								}
							}
						}
					}else{
						$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.useMoney.message2">请输入本次付款金额</s:text>！','info');
					}
					
					if(breakFlag == "true") {
						//判断是否是100%付款完成
						//获取订单还未付款的金额
//			 			var balanceMoney = parent.document.getElementById("hiddenBalance").value;
						var balanceMoney = customWindow.$("#hiddenBalance").val();
						//获取订单执行的付款次数
//			 			var payNums = parent.document.getElementById("hiddenPayNums").value;
						var payNums = customWindow.$("#hiddenPayNums").val();
						//如果是二次付款，获取第一次付款是否为全部是TT款项
//			 			var payOneAllTT = parent.document.getElementById("hiddenOneAllTT").value;
						var payOneAllTT = customWindow.$("#hiddenOneAllTT").val();
						//如果已经填写了付款金额
						if (null != rows && rows.length > 0) {
							for ( var i = 0, j = rows.length; i < j; i++) {
								var row = rows[i];
								if (row.paymentMethodName != "T/T") {
									//如果任何一笔款项不是TT，则就不是100%TT款
									isTT = "false";
								}
								paidMoney = accAdd(paidMoney,row.useMoney);
							}
						}
						//如果本次付款和二次付款的第一次付款方式均为TT款项，则是100%TT
						if (isTT == "true" && payOneAllTT == "true") {
//			 				parent.document.getElementById("payAllTT").value = "是";
							customWindow.$("#payAllTT").val() = "是";
						}
						//如果本次付款的金额与还未付款的金额相同，则付款完成
						if(balanceMoney == paidMoney) {
//			 				parent.document.getElementById("payFinish").value = "是";
							customWindow.$("#payFinish").value = "是";
						}
						if(flag){
							$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', "<s:text name='global.useMoney.message3'>款项编号为</s:text>:"+allCode.substring(0,allCode.length-1)+"<s:text name='global.useMoney.message4'>的余额不足</s:text>!",'info');
						}else{
//			 				window.parent.payMoneyDetail.datagrid('loadData', datagridJson);
							customWindow.payMoneyDetail.datagrid('loadData', datagridJson);
//			 				window.parent.showUseMoneyDialog.dialog('close');
							closeCur();
						}	
					}
			   }
		   }
		});
	}
	
	/*
	*	浮点型数值四舍五入
	*/
	function roundDouble(number,fractionDigits){   
	    with(Math){   
	        return round(number*pow(10,fractionDigits))/pow(10,fractionDigits);   
	    }   
	} 
	
	function closeCur(){
		window.parent.HROS.window.close(currentappid);
	}
	
	//加法函数，用来得到精确的加法结果 
	//说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。 
	//调用：accAdd(arg1,arg2) 
	//返回值：arg1加上arg2的精确结果 
	function accAdd(arg1,arg2){ 
		var r1,r2,m; 
		try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
		try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
		m=Math.pow(10,Math.max(r1,r2)) 
		return (arg1*m+arg2*m)/m 
	} 
	
	function accMul(arg1,arg2) 
	{ 
		var m=0,s1=arg1.toString(),s2=arg2.toString(); 
		try{m+=s1.split(".")[1].length}catch(e){} 
		try{m+=s2.split(".")[1].length}catch(e){} 
		return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m) 
	} 
</script>
</head>
<body class="easyui-layout zoc">
	<div region="center" border="false" class="part_zoc">
		<table id="useMoneydatagrid"></table>
	</div>
</body>
</html>