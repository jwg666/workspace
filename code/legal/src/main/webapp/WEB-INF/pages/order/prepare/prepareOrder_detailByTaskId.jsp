<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
$(document).ready(function() {
	
})
</script>
<script type="text/javascript">
	var datagrid_contract_one;
	var datagrid_materialDetail;
	var datagrid_contract_two;
	var editIndex = undefined;
	var contractDetailForm;
	var searchMaterialDetailDialog;
	var actCntAddDialog;
	var taskId = '${taskId}';
	var orderConfirmAppid = null;
	var queryPrepareDialog;
	var queryEndPrepareOrderDatagrid;
	$(function(){
		datagrid_contract_one = $('#datagrid_contract_one').datagrid({
  			url : "${dynamicURL}/salesOrder/salesOrderAction!getPrepareOrderDetailParaByTaskId.do?taskId="+taskId,
			//pagination : true,
			//pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			height : 100,
			fitColumns : true,
			nowrap : true,
			border : false,
			checkOnSelect:false,
			selectOnCheck:false,
			singleSelect : true, 
			idField : 'orderCode',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.orderCode;
				}
			}, {
				field : 'orderItemId',
				title : '序号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return ++index;
				}
			}, {
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderCode;
				}
			}, {
				field : 'orderLinecode',
				title : '订单行项目',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderItemLinecode;
				}
			}, {
				field : 'prodTypeEn',
				title : '产品大类',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.prodTypeEn;
				}
			}, {
				field : 'haierModel',
				title : '海尔型号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.haierModel;
				}
			}, {
				field : 'customerModel',
				title : '客户型号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customerModel;
				}
			}, {
				field : 'affirmNum',
				title : '特技单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.affirmNum;
				}
			}, {
				field : 'materialCode',
				title : '物料号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			}, {
				field : 'budgetOrderNumber',
				title : '订单数量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.budgetOrderNumber;
				}
			},  {
				field : 'budgetOrderQuatity',
				title : '剩余订单数量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.budgetOrderQuatity;
				}
			}, {
				field : 'budgetOrderQuatity',
				title : '可分配订单数量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.budgetOrderQuatity;
				}
			}, {
				field : 'quantity',
				title : '本次分配数量',
				align : 'center',
				sortable : true,
				styler: function(value,row,index){
					return 'background-color:#ffee00;color:red;';
				},
				editor : {
					type : 'numberbox'
				},
				formatter : function(value, row, index) {
					return row.quantity;
				}
// 				field : 'quantity',
// 				title : '本次分配数量',
// 				align : 'center',
// 				sortable : true,
// 				editor : {
// 					type : 'validatebox',
// 					options:{
// 						required: true,  
// 						validType: "['请输入正整数']"
// 					}
// 				},
// 				formatter : function(value, row, index) {
// 					return row.quantity;
// 				}
			},{
				field : 'hrcode',
				title : 'HR认证',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.hrcode;
				}
			}, {
				field : 'plcstatus',
				title : '生命周期状态',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.plcstatus;
				}
			}
// 			,{
// 				field : 'releaseflag',
// 				title : '滚动计划',
// 				align : 'center',
// 				sortable : true,
// 				formatter : function(value, row, index) {
// 					return row.releaseflag;
// 				}
// 			}  
			] ],
			onDblClickRow: function(index, rowData) {
				datagrid_contract_one.datagrid('endEdit', editIndex);
				datagrid_contract_one.datagrid('unselectAll');
			    },
			    onClickRow : function(index, rowData) {
			    	var rowss = datagrid_contract_one.datagrid('getRows');
			    	if(rowss.length > 1){
			    		//editIndex = undefined;
						if (editIndex != index) {
							if (endEditing()) {
								datagrid_contract_one.datagrid('selectRow', index).datagrid('beginEdit',index);
								editIndex = index;
							} else {
								datagrid_contract_one.datagrid('selectRow', editIndex);
							}
						}
						$("[field='quantity']").find("input").keyup(function(){
							var row = datagrid_contract_one.datagrid('getSelected');
							var quantity = $(this).val();
							if(parseInt(quantity) < 0){
								$("[field='quantity']").find("input").val('0');
							}
							if(parseInt(quantity)>parseInt(row.budgetOrderQuatity)) {
								$.messager.alert('提示', '所填写数量大于可预算数量！', 'error');
								$("[field='quantity']").find("input").val('0');
							}
							});
			    	}else{
			    		editIndex = undefined;
						if (editIndex != index) {
							if (endEditing()) {
								datagrid_contract_one.datagrid('selectRow', index).datagrid('beginEdit',index);
								editIndex = index;
							} else {
								datagrid_contract_one.datagrid('selectRow', editIndex);
							}
						}
						$("[field='quantity']").find("input").keyup(function(){
							var row = datagrid_contract_one.datagrid('getSelected');
							var quantity = $(this).val();
							if(parseInt(quantity) < 0){
								$("[field='quantity']").find("input").val('0');
							}
							if(parseInt(quantity)>parseInt(row.budgetOrderQuatity)) {
								$.messager.alert('提示', '所填写数量大于可预算数量！', 'error');
								$("[field='quantity']").find("input").val('0');
							}
							});
			    	}
			},
		});
		//预算明细
		contractDetailForm = $('#contractDetailForm').form({
			url : 'contractAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					saveMaterial();
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});
	 	$.ajax({
		 url : "${dynamicURL}/salesOrder/salesOrderItemAction!getActCntNewFormByTaskId.do",
  	     data:{
  	    		taskId : taskId
  	    	  },
  	     dataType:"json",
  	     type:'post',
  	   	 async:false,
  	     success:function(data){
  	    	 if(data.orderbuyoutflag == 0){
  	    		data.orderbuyoutflag = '代理'
  	    	 }
  	    	 if(data.orderbuyoutflag == 1){
  	    		data.orderbuyoutflag = '买断'
  	    	 }
  	    	 if(data.orderPaymentTerms == 0){
  	    		data.orderPaymentTerms = '尚未完成'
  	    	 }
  	    	 if(data.orderPaymentTerms == 1){
   	    		data.orderPaymentTerms = '完成已经'
   	    	 }
	   		$("#contractDetailForm").form('load',data);
  	     }
	});
	 	
	 	var urlPro = "${dynamicURL}/salesOrder/salesOrderItemAction!getProFactoryNameByCode.do";
		$('#proFactoryCode').combobox({
			url : "${dynamicURL}/salesOrder/salesOrderItemAction!getProFactoryNameByCode.do",
			valueField : "proFactoryCode",
			textField : "proFactoryName",
			onLoadSuccess : function(){
				$('#proFactoryCode').combobox('setValue', $("#escFactoryCode").val());
			},
			onSelect : function(recd) {
				$.ajax({
					type : 'POST',
					url : '${dynamicURL}/salesOrder/salesOrderItemAction!getFindCheckCodeByproCode.do?factoryCode='+ recd.proFactoryCode,
				    dataType : 'json',
					success : function(response) {
						$('#checkCode').val(response);
					}
				});
				}
		});
		
		//销售组织，销售渠道
		var salesOrgUrl = "${dynamicURL}/salesOrder/salesOrderItemAction!getsalesOrg";
		$('#itemNameCode').combobox('reload', salesOrgUrl).combobox('clear').combobox({
			onLoadSuccess : function(param) {
				if(param.length > 0){
				$(this).combobox("setValue",param[0].itemNameCode);
				}}});
		var salesWAYUrl = "${dynamicURL}/salesOrder/salesOrderItemAction!getsalesOrderWay";
		$('#salesorderCode').combobox('reload', salesWAYUrl).combobox('clear').combobox({
			onLoadSuccess : function(param) {
				if(param.length > 0){
				$(this).combobox("setValue",param[0].salesorderCode);
				}}});
		
		//结算方式
		var settlementType = "${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=23";
		$('#orderSettlementType').combobox('reload', settlementType).combobox('clear').combobox({
			onLoadSuccess : function(param) {
				if(param.length > 0){
				$(this).combobox("setValue",param[0].itemCode);
				}}});
		
		$('#manuEndDate').datebox({
			onSelect: function(date){
 				var dateb = $("#manuEndDate").datebox('getValue');
 				getDateByDate(dateb);
			}
		});
		$('#manuStartDate').datebox({
			onSelect: function(date){
 				var dateb = $("#manuStartDate").datebox('getValue');
 				$('#packingStartDate').datebox('setValue', dateb);
			}
		});
		
		
// 		$('#orderSettlementType').combobox({
// 			url : '${dynamicURL}/basic/sysLovAction!selectDealType.do?itemType=23',
// 			valueField : 'itemCode',
// 			textField : 'itemNameCn'});

		//显示备货单查询
		queryPrepareDialog = $('#queryPrepareDialog').show().dialog({
			iconCls : 'icon-search',
			title: '滚动计划闸口数量详情',
			maximizable : true,
			modal : true,
			closed : true,
			width : 750,
			height : 300,
			buttons : [{
				text : '继续',
				iconCls : 'icon-add',
				handler : function() {
					var listPrepareOrder = datagrid_contract_one.datagrid('getData');
					contractDetailForm.form('submit', {
		 				url : 'prepareOrderAction!addworkflowToReleaseFlag.action',	
		 				data : {
		 					'listPrepareOrder' : listPrepareOrder
		 				},
		 				dataType : 'json',
		 				onSubmit : function(param) {
		 					param.listPrepareOrder = JSON.stringify(listPrepareOrder.rows);
		 				},
		 				success : function(data) {
		 					var json = $.parseJSON(data);
		 					$.messager.alert('提示', json.msg);
		 					$.messager.progress('close');
		 					//代办刷新
		 					customWindow.reloaddata();
		 					//代办关闭
		 					parent.window.HROS.window.close(currentappid);
		 				}
		 			});
		 			$.messager.show({title : '提示', msg : '有数据进入滚动计划闸口'});
					$.messager.progress('close');
					queryPrepareDialog.dialog('close');
				}
			} ,{
				text : '关闭',
				iconCls : 'icon-cancel',
				handler : function() {
					queryPrepareDialog.dialog('close');
 					//代办关闭
 					parent.window.HROS.window.close(currentappid);
				}
			} ]
		});
		//备货单datagrid
		queryDatagrid();
		
	});

	//行编辑代码
	function endEditing() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#datagrid_contract_one').datagrid('validateRow', editIndex)) {
			$('#datagrid_contract_one').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}

	//text必须填写数字
	$(document).ready(function() {
		$(".validate-number").validatebox({
			required : true,
			validType : 'number'
		});

	});
	//备货单保存
	function addPrepare() {
	var timeStart = $('#contractDetailForm').find('input[name = manuStartDate]').val();
	var timeEnd = $('#contractDetailForm').find('input[name = manuEndDate]').val();
	if("" == timeStart){
		timeStart = $('#contractDetailForm').find('input[name = packingStartDate]').val();
	}
	if("" == timeEnd){
		timeEnd = $('#contractDetailForm').find('input[name = packingEndDate]').val();
	}
    var d1 = new Date(timeStart);    
    var d2 = new Date(timeEnd);  
    var packEndDate = $('#contractDetailForm').find('input[name = packingEndDate]').val();
    var d4 = new Date(packEndDate);
    if(Date.parse(d1) - Date.parse(d2) < 0 && Date.parse(d2) - Date.parse(d4) <= 0){    
     	$.messager.progress({
     	text : '数据加载中....',
     	interval : 100
     	});
    	datagrid_contract_one.datagrid('endEdit', editIndex);
    	datagrid_contract_one.datagrid('unselectAll');
    	//先判断HR认证
    	var rows = datagrid_contract_one.datagrid('getRows');
    	var f = "0";
    	var fOne = 0;
    	var fTwo = 0;
    	var fThree = 0;
    	var fFour = 0;
    	for(var i = 0; i<rows.length; i++){
    		if(rows[i].hrcode == undefined || rows[i].hrcode == null || rows[i].hrcode == ""){
    			f = "1";
    		}
    	}
    	var orderT = $('#contractDetailForm').find('input[name = orderType]').val();
    	//如果订单类型为047(样机订单)不需要HR认证
    	if(orderT == "样机订单"){
    		f = "0";
    	}
    	//滚动计划标示判断,如果释放标示为1直接释放到计划排定
    	var flag = $('#contractDetailForm').find('input[name = orderCode]').val();
    	//释放标示
    	var dataFlag = "";
    	$.ajax({
    	 	url : "${dynamicURL}/prepare/prepareOrderAction!getReleaseFlag.do",
    	   	data:{ orderCode : flag},
    	   	dataType:"json",
    	   	type:'post',
    	   	async:false,
    	   	success:function(data){
    	   	    dataFlag = JSON.stringify(data);
    	   	   	}
    	 	   });
    	if("null" != dataFlag){
    		dataFlag = dataFlag.substring(1,2);
    	}
    	//判断3中不同情况对应不同Action		
    	var contractDetailForm = $('#contractDetailForm');
    	var dateTime = "";
    	if($('#contractDetailForm').find('input[name = manuEndDate]').val() == ""){
    		dateTime = $('#contractDetailForm').find('input[name = packingEndDate]').val();
    	}else{
    		dateTime = $('#contractDetailForm').find('input[name = manuEndDate]').val();	
    	}
    	//要分配的生产工厂Code
    	var factoryPCode = $('#contractDetailForm').find('input[name = proFactoryCode]').val();
    	var rowss = datagrid_contract_one.datagrid('getRows');
    	var rollplanNum = "";
    	var AllocateNum = "";
    	if(rowss.length > 0 ){
    		for(var i = 0;i < rowss.length; i++){
    			var paras = "";
    			paras = rowss[i].materialCode + "," + dateTime + "," + factoryPCode;
    	 		//抓取这个物料这个时间内滚动计划的数量
    	 		$.ajax({
    	 		 url : "${dynamicURL}/prepare/prepareOrderAction!getRollplanNum.do",
    	   	     data:{
    	   	    	    paras : paras
    	   	    	  },
    	   	     dataType:"json",
    	   	     type:'post',
    	   	   	 async:false,
    	   	     success:function(data){
    	   	    	rollplanNum = data.obj;
    	   	     }
    	 	   });
    	 		//抓取要分配生产工厂     在本周已分配数量
    	 		//抓取生产工厂编码
    	 		
    	 		var parass = "";
    	 		parass = rowss[i].orderItemId + "," + rowss[i].materialCode +"," + dateTime + "," + factoryPCode;
    	 		$.ajax({
    		 		 url : "${dynamicURL}/prepare/prepareOrderAction!getAllocatedNum.do",
    		   	     data:{
    		   	    		parass : parass
    		   	    	  },
    		   	     dataType:"json",
    		   	     type:'post',
    		   	   	 async:false,
    		   	     success:function(data){
    		   	    	AllocateNum = data.obj;
    		   	     }
    		 	});
    // 	 		alert(rowss[i].budgetOrderQuatity);
    // 			alert(rollplanNum-AllocateNum);
    // 	 		alert(rowss[i].quantity);
    	 		if(parseInt(rowss[i].budgetOrderQuatity) == parseInt(rowss[i].quantity) && parseInt(rollplanNum-AllocateNum) >= parseInt(rowss[i].budgetOrderQuatity)  && parseInt(rowss[i].quantity) > 0){
    	 			//剩余数量 = 分配数量  && 计划数量  >= 分配数量(剩余数量)
    	 			//进入计划排定
    	 			fOne++;
    	 		}else if(parseInt(rowss[i].budgetOrderQuatity) == parseInt(rowss[i].quantity) && parseInt(rowss[i].quantity) > parseInt(rollplanNum-AllocateNum) && parseInt(rowss[i].quantity) > 0){
    	 			//剩余数量 = 分配数量  && 计划数量  < 分配数量(剩余数量)
    	 			//进入滚动计划闸口
    	 			fTwo++;
    	 		}else if(parseInt(rowss[i].budgetOrderQuatity) == parseInt(rowss[i].quantity) && parseInt(rowss[i].quantity) <= parseInt(rollplanNum-AllocateNum)  && parseInt(rowss[i].quantity) > 0){
    	 			//剩余数量 > 分配数量 && 计划数量 >= 分配数量
    	 			//数据直接保存   分备货单 不结束
    	 			fThree++;
    	 		}
    	 		fFour++;
    		}
    	}	
//      alert(dataFlag);
//		生产计划结束时间  > T+4周 时间 ,直接计划排定
		var t4datetime = "";
		$.ajax({
    		 url : "${dynamicURL}/prepare/prepareOrderAction!findT4Date.do",
    		 dataType:"json",
    		 type:'post',
    		 async:false,
    		 success:function(data){
    		   	t4datetime = JSON.stringify(data).substring(1,11);
    		   	 }
    		 });
		var d5 = new Date(t4datetime); 
		 if(Date.parse(d2) - Date.parse(d5) > 0){ 
			 dataFlag = "0";
		 } 
		 
    	var listPrepareOrder = datagrid_contract_one.datagrid('getData');
    	if(f == "1"){
    		$.messager.alert('提示', 'HR认证信息不允许为空!');
    		$.messager.progress('close');
    	}else{
    		if("0" == dataFlag){
    			//进入计划排定
    				contractDetailForm.form('submit', {
     					url : 'prepareOrderAction!addworkflowToNext.action',	
    					data : {
    						'listPrepareOrder' : listPrepareOrder
    					},
    					dataType : 'json',
    					onSubmit : function(param) {
    						param.listPrepareOrder = JSON.stringify(listPrepareOrder.rows);
    					},
    					success : function(data) {
    						var json = $.parseJSON(data);
    						$.messager.alert('提示', json.msg);
    						$.messager.progress('close');
    						//代办刷新
    						customWindow.reloaddata();
    						//代办关闭
     						parent.window.HROS.window.close(currentappid);
    						$('#actCntAddDialog').dialog('close');
    						$.messager.show({title : '提示', msg : '订单备货单分配完成!'});
    					}
    				});
    				$.messager.progress('close');
    		}else{
    			if(fFour == (fOne + fTwo) && fTwo > 0){
    				//发起滚动计划闸口 判断条件
    				$.messager.progress({
    			     	text : '数据加载中....',
    			     	interval : 100
    			     });
    				var rowsData = JSON.stringify(listPrepareOrder.rows);
    				var orderCode = $('#contractDetailForm').find('input[name = orderCode]').val();
    				$.ajax({
    					url:'${dynamicURL}/prepare/prepareOrderItemAction!queryPrepareOrder.do',
    					dataType:"json",
    					data:{
    						"orderCode" : orderCode,
    						"factoryCode" : factoryPCode,
    						"planEndDate" : timeEnd,
    						"prepareOrderList" : JSON.stringify(listPrepareOrder.rows)
    					},
    					success:function(data){
    						$('#queryEndPrepareOrderDatagrid').datagrid('loadData',data);
    						//代办刷新
    						customWindow.reloaddata();
    						//代办关闭
     						parent.window.HROS.window.close(currentappid);
     						$('#actCntAddDialog').dialog('close');
    						$.messager.progress('close');
    					}
    				});
    				$.messager.progress('close');
    			}else if(fFour == fThree){
    				//保存操作
    					contractDetailForm.form('submit', {
     						url : 'prepareOrderAction!addworkflowToSave.action',	
    						data : {
    							'listPrepareOrder' : listPrepareOrder
    						},
    						dataType : 'json',
    						onSubmit : function(param) {
    							param.listPrepareOrder = JSON.stringify(listPrepareOrder.rows);
    						},
    						success : function(data) {
    							var json = $.parseJSON(data);
    							$.messager.alert('提示', json.msg);
    							$.messager.progress('close');
    							//代办刷新
        						customWindow.reloaddata();
        						//代办关闭
         						parent.window.HROS.window.close(currentappid);
         						$('#actCntAddDialog').dialog('close');
    							$.messager.show({title : '提示', msg : '订单数据保存成功！'});
    						}
    					});
    					$.messager.progress('close');
    			}else if(fFour == fOne){
    				//进入计划排定
    					contractDetailForm.form('submit', {
     						url : 'prepareOrderAction!addworkflowToNext.action',	
    						data : {
    							'listPrepareOrder' : listPrepareOrder
    						},
    						dataType : 'json',
    						onSubmit : function(param) {
    							param.listPrepareOrder = JSON.stringify(listPrepareOrder.rows);
    						},
    						success : function(data) {
    							var json = $.parseJSON(data);
    							$.messager.alert('提示', json.msg);
    							$.messager.progress('close');
    							//代办刷新
        						customWindow.reloaddata();
        						//代办关闭
         						parent.window.HROS.window.close(currentappid);
         						$('#actCntAddDialog').dialog('close');
        						$.messager.show({title : '提示', msg : '订单备货单分配完成!'});
    						}
    					});
    					$.messager.progress('close');
    				}else{
    					$.messager.alert('提示', '订单数据不正确,请重新确认数据在进行分单!', 'error');
    					$.messager.progress('close');
    				}
    		}
    		}   
    } else{
    	$.messager.alert('提示', '生产计划结束时间必须晚于开始时间并且生产计划结束时间必须是出运期3天以前!');
    } 
	}
	
	function getDateByDate(arys){
		arys1=arys.split('-');     //日期为输入日期，格式为 2013-3-10   
		var ssdate=new Date(arys1[0],parseInt(arys1[1]-1),arys1[2]);      
		ssdate.getDay();  //就是你要的星期几
		if(ssdate.getDay() == 0){
			 var yesterday_milliseconds=ssdate.getTime()-1000*60*60*24;     
			 var yesterday = new Date();     
			     yesterday.setTime(yesterday_milliseconds);     
			 var strYear = yesterday.getFullYear();  
			 var strDay = yesterday.getDate();  
			 var strMonth = yesterday.getMonth()+1;
			 if(strMonth<10)  
			 {  
			  strMonth="0"+strMonth;  
			 }  
			 if(strDay < 10){
				 datastr = strYear+"-"+strMonth+"-0"+strDay;
			 }else{
				 datastr = strYear+"-"+strMonth+"-"+strDay;
			 }
			$('#manuEndDate').datebox('setValue', datastr);
		}
	}
	//备货单查询
	function queryDatagrid(){
		queryEndPrepareOrderDatagrid = $('#queryEndPrepareOrderDatagrid').datagrid({
			title : '分备货单查询',
		/* 	url:'${dynamicURL}/prepare/prepareOrderItemAction!queryPrepareOrder.do',
			queryParams:{
				orderCode : '${orderCode}',
				factoryCode : '${factoryCode}',
				planDate : '${planEndDate}',
				jsonString : '${jsonString}'
			}, */
			nowrap : false,
			border : false,
			columns : [ [ {
				field : 'factoryName',
				title : '工厂',
				align : 'center',
				sortable : true,
				width:200,
				formatter : function(value, row, index) {
					return row.factoryName;
				}
			}, {
				field : 'materialCode',
				title : '物料号',
				align : 'center',
				sortable : true,
				width:70,
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			}, {
				field : 'weekN',
				title : 'T+N周',
				align : 'center',
				sortable : true,
				width:70,
				formatter : function(value, row, index) {
					return row.weekN;
				}
			}, {
				field : 'actualQuantity',
				title : '评审数量',
				align : 'center',
				sortable : true,
				width:70,
				formatter : function(value, row, index) {
					return row.actualQuantity;
				}
			}, {
				field : 'prepareQuantity',
				title : '已分配数量',
				align : 'center',
				sortable : true,
				width:70,
				formatter : function(value, row, index) {
					return row.prepareQuantity;
				}
			}, {
				field : 'quantity',
				title : '本次数量',
				align : 'center',
				sortable : true,
				width:70,
				formatter : function(value, row, index) {
					return row.quantity;
				}
			}, {
				field : 'diffQuantity',
				title : '差异数量',
				align : 'center',
				sortable : true,
				width:70,
				formatter : function(value, row, index) {
					return row.diffQuantity;
				}
			} ] ]
		});
	}
</script>
<jsp:include page="queryPrepareList.jsp" />
<body>
	<div id="actCntAddDialog">
		<div class="part_zoc zoc">
			<!-- 第一部分 -->
			<form id="contractDetailForm" method="post"
				enctype="multipart/form-data">
				<input id="countryCode" name="countryCode" hidden="true" /> <input
					id="customerCode" name="customerCode" hidden="true" /> <input
					id="deptCode" name="deptCode" hidden="true" /> <input
					id="salesOrgCode" name="salesOrgCode" hidden="true" /> <input
					type="hidden" id="escFactoryCode" name="escFactoryCode" />
				<div class="part_zoc zoc">
					<div class="partnavi_zoc">
						<span>备货单基本信息：</span>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">备货单号:</div>
							<div class="righttext">
								<input id="actPrepareCode" name="actPrepareCode" type="text"
									readonly="readonly"
									style="width: 140px; background-color: #DDDDDD" />
							</div>
						</div>

						<div class="item33">
							<div class="itemleft">订单号:</div>
							<div class="righttext">
								<input name="orderCode" id="orderCode" type="text"
									style="width: 140px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">合同号:</div>
							<div class="righttext">
								<input name="contractCode" id="contractCode" type="text"
									style="width: 140px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
					</div>

					<div class="oneline">
						<!-- 				<div class="item33"> -->
						<!-- 					<div class="itemleft">特殊检:</div> -->
						<!-- 					<div class="righttext"> -->
						<!-- 						<input name="specialInspectionFlag" id="specialInspectionFlag" type="text" -->
						<!-- 							style="width: 140px;" readonly="readonly"/> -->
						<!-- 					</div> -->
						<!-- 				</div> -->
						<div class="item33">
							<div class="itemleft">付款状态</div>
							<div class="righttext">
								<input type="text" name="orderPaymentTerms"
									id="orderPaymentTerms"
									style="width: 140px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">成交方式:</div>
							<div class="righttext">
								<input name="orderDealType" id="orderDealType" type="text"
									style="width: 140px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
						<div class="item50">
							<div class="itemleft">客户:</div>
							<div class="righttext">
								<input id="cusName" name="cusName" type="text"
									style="width: 250px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
					</div>

					<div class="oneline">
						<div class="item33">
							<div class="itemleft">出口国家:</div>
							<div class="righttext">
								<input id="counName" type="text" name="counName"
									readonly="readonly"
									style="width: 140px; background-color: #DDDDDD" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">ROSH:</div>
							<div class="righttext">
								<input id="roshFlag" type="text" name="roshFlag" value="是"
									readonly="readonly"
									style="width: 140px; background-color: #DDDDDD" />
							</div>
						</div>
						<div class="item50">
							<div class="itemleft">经营主体:</div>
							<div class="righttext">
								<input name="operators" id="operators" type="text"
									style="width: 250px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
					</div>

					<div class="oneline">
						<div class="item33">
							<div class="itemleft">商检批次号:</div>
							<div class="righttext">
								<input type="text" name="checkOrder" id="checkCode"
									data-options="required:true" readonly="readonly"
									style="width: 140px; background-color: #DDDDDD" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">是否买断:</div>
							<div class="righttext">
								<input name="orderbuyoutflag" id="orderbuyoutflag"
									type="text" style="width: 140px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
						<div class="item50">
							<div class="itemleft">生产工厂:</div>
							<div class="righttext">
								<input id="proFactoryCode" name="proFactoryCode"
									style="width: 250px;" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">销售组织:</div>
							<div class="righttext">
								<input id="itemNameCode" class="easyui-combobox"
									name="itemNameCode"
									data-options="valueField:'itemNameCode',textField:'itemNameCn',editable:false"
									style="width: 140px;" readonly="readonly" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">销售渠道:</div>
							<div class="righttext">
								<input id="salesorderCode" class="easyui-combobox"
									name="salesorderCode"
									data-options="valueField:'salesorderCode',textField:'salesorderName',editable:false"
									style="width: 140px;" readonly="readonly" />
							</div>
						</div>
						<div class="item50">
							<div class="itemleft">结算工厂:</div>
							<div class="righttext">
								<input id="escFactoryName" name="escFactoryName" type="text"
									style="width: 250px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">HGVS订单号:</div>
							<div class="righttext">
								<input type="text" name="" id="" data-options="required:true"
									style="width: 140px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">结算方式:</div>
							<div class="righttext">
								<input id="orderSettlementType" class="easyui-combobox"
									name="orderSettlementType"
									data-options="valueField:'itemCode',textField:'itemNameCn',editable:false"
									style="width: 140px;" />
							</div>
						</div>
						<div class="item50">
							<div class="itemleft">装箱关联订单号:</div>
							<div class="righttext">
								<input id="belongCode" name="belongCode" type="text"
									style="width: 250px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">订单类型:</div>
							<div class="righttext">
								<input type="text" name="orderType" id="orderType"
									data-options="required:true"
									style="width: 140px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">是否导HGVS:</div>
							<div class="righttext">
								<input type="text" name="orderHgvsFlag" id="orderHgvsFlag"
									data-options="required:true"
									style="width: 140px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
					</div>
				</div>
				<!--这里是第二部分内容-->
				<div class="part_zoc zoc">
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">出运期</div>
							<div class="righttext">
								<input name="ordershipdate" id="ordershipdate" type="text"
									style="width: 145px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">首样开始时间</div>
							<div class="righttext">
								<input type="text" name="firstSampleDate" id="firstSampleDate"
									class="easyui-datebox" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">生产计划开始</div>
							<div class="righttext">
								<input type="text" name="manuStartDate" id="manuStartDate"
									class="easyui-datebox" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">装箱计划开始</div>
							<div class="righttext">
								<input type="text" disabled="disabled" name="packingStartDate"
									id="packingStartDate"
									style="width: 145px; background-color: #DDDDDD"
									class="easyui-datebox" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">商检计划开始</div>
							<div class="righttext">
								<input type="text" name="checkStartDate" id="checkStartDate"
									style="width: 145px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">生产计划结束</div>
							<div class="righttext">
								<input name="manuEndDate" id="manuEndDate"
									class="easyui-datebox" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">装箱计划结束</div>
							<div class="righttext">
								<input type="text" name="packingEndDate" id="packingEndDate"
									style="width: 145px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft">商检计划结束</div>
							<div class="righttext">
								<input type="text" name="checkEndDate" id="checkEndDate"
									style="width: 145px; background-color: #DDDDDD"
									readonly="readonly" />
							</div>
						</div>
					</div>
					<div class="item100">
						<div class="oprationbutt">
							<input type="button" value="保  存" onclick="addPrepare()" />
						</div>
					</div>
				</div>
			</form>
			<!-- datagrid部分 -->
			<div style="height: 200px;">
				<table id="datagrid_contract_one"></table>
			</div>
		</div>
	</div>
	<div>
		<object id="plugin0" type="application/x-pload"
			style="width: 0; height: 0">
			<param name="onload" value="pluginLoaded" />
		</object>
		<br />
	</div>
</body>
