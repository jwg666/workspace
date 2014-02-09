<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script type="text/javascript">
	var datagrid_contract_one;
	var datagrid_contract_two;//选择物料对话框
	var datagrid_materialDetail//物料详细condition表datagrid
	var searchMaterialForm;
	var contractDetailForm;
	var selectMaterialDialog;
	var searchMaterialDetailDialog;
	function prepareOrder_detail(orderCodeD) {
		datagrid_contract_one = $('#datagrid_contract_one').datagrid({
			rownumbers : true,
			fit : true,
			fitColumns : true,
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			nowrap : true,
			border : false,
			idField : 'orderLinecode',
			
			columns : [ [ {
				field : 'orderLinecode',
				title : '行项目1',
				width : 60,
				align : 'center',
				formatter : function(value, row, index) {
					return row.orderLinecode;
				}
			}, {
				field : 'prodType',
				title : '产品大类',
				width : 80,
				align : 'center',
				formatter : function(value, row, index) {
					return row.prodType;
				}
			}, {
				field : 'haierModer',
				title : '海尔型号',
				width : 100,
				align : 'center',
				formatter : function(value, row, roindex) {
					return row.haierModer;
				}
			}, {
				field : 'customerModel',
				title : '客户型号',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customerModel;
				}
			}, {
				field : 'addirmNum',
				title : '特技单号',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.addirmNum;
				}
			}, {
				field : 'materialCode',
				title : '物料号',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			}, {
				field : 'quantity',
				title : '数量',
				width : 80,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.quantity;
				}
			}, {
				field : 'hrCode',
				title : 'HR认证',
				width : 150,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.hrCode;
				}
			}, {
				field : 'plcStatus',
				title : '生命周期状态',
				width : 150,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.plcStatus;
				}
			}, {
				field : 'releaseFlag',
				title : '滚动计划',
				width : 55,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.releaseFlag;
				}
			}] ],onLoadSuccess : function(rowIndex, rowData) {
 				var checkScheduleFlag = $("#checkScheduleFlag").val();
 			    if (checkScheduleFlag == 'true') {
	 				$("#factoryCodeFinishO").combo("disable");
	 				$("#factorySettlementCode").combo("disable");
			    }
			}
		});
		//加载工厂信息
		$('#factorySettlementCode').combogrid({
			url:'${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0',
			textField : 'deptNameCn',
			idField : 'deptCode',
			pagination : true,
			pageSize : 300,
			pageList : [ 300],
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_FACTORYHISTORYT',
			rownumbers : true,
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'deptCode',
				title : '工厂编码',
				width : 20
			},{
				field : 'deptNameCn',
				title : '工厂名称',
				width : 20
			}  ] ]
		});
		//加载工厂信息
		$('#factoryCodeFinishO').combogrid({
			url:'${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0',
			textField : 'deptNameCn',
			idField : 'deptCode',
			pagination : true,
			pageSize : 300,
			pageList : [ 300],
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_FACTORYHISTORYO',
			rownumbers : true,
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'deptCode',
				title : '工厂编码',
				width : 20
			},{
				field : 'deptNameCn',
				title : '工厂名称',
				width : 20
			}  ] ]
		});
	//生产计划结束时间周日自动变为周六  并且带出 装箱和商检的结束时间
		var orderShipDdate;
		$('#manuEndDate').datebox({
			onSelect: function(date){
				$.ajax({
   		 		 url : "${dynamicURL}/salesOrder/salesOrderAction!getOrderListByorderCode.do",
   		   	     data:{
   		   	    		orderCode : orderCodeD
   		   	    	  },
   		   	     dataType:"json",
   		   	     type:'post',
   		   	   	 async:false,
   		   	     success:function(data){
   		   	   		orderShipDdate = AddDays(data[0].orderShipDate,3);
   		   	     	}
   		 		});
			var dateb = $("#manuEndDate").datebox('getValue');
				if(DateDiff(dateb,orderShipDdate) > 0){
					$("#manuEndDate").datebox('setValue',orderShipDdate);
					$('#packingEndDate1').datebox('setValue',orderShipDdate);
					$('#checkEndDate').datebox('setValue',orderShipDdate);
					getDateByDate(orderShipDdate);
				}else{
					$("#manuEndDate").val(dateb);
					$('#packingEndDate1').datebox('setValue',dateb);
					$('#checkEndDate').datebox('setValue',dateb);
					getDateByDate(dateb);
				}
			}
		});
	//生产计划开始时间 带出 装箱和商检的开始时间
		$('#manuStartDate').datebox({
			onSelect: function(date){
 				var dateb = $("#manuStartDate").datebox('getValue');
 				$('#packingStartDate').datebox('setValue',dateb);
 				$('#checkStartDate').datebox('setValue',dateb);
			}
		});
	}
	//备货单保存
	function updatePrepare() {
       // 生产工厂CODE    factoryPCode
       var factoryFlag;
        $.ajax({
        	url : "${dynamicURL}/prepare/prepareOrderAction!findFactoryFilter.do",
   		  	dataType:"json",
   		   	type:'post',
   		   	async:false,
   		   	success:function(dataFactory){
   		   		for(var m = 0; m < dataFactory.length; m++){
   		   			if(factoryPCode == dataFactory[m].itemName){
   		   				factoryFlag = "1";
   		   			}
   		   		}
   		   	}
   		 });
//***********************************************************************************************************************//	
		//获取生产计划结束时间 , 生产工厂
		if($('#contractDetailForm').find('input[name = manuEndDate]').val() == ""){
    		dateTime = $('#contractDetailForm').find('input[name = packingEndDate]').val();
    	}else{
    		dateTime = $('#contractDetailForm').find('input[name = manuEndDate]').val();	
    	}
		//判断订单是否要走备货单闸口释放
		var rollflag = "2";
		var rowss = datagrid_contract_one.datagrid('getRows');
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
    	 		parass = orderCodeD + "," + rowss[i].materialCode +"," + dateTime + "," + factoryPCode;
    	 		$.ajax({
    		 		 url : "${dynamicURL}/prepare/prepareOrderAction!getAllocatedNumExceptSelf.do",
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
				if((parseInt(rollplanNum) - parseInt(AllocateNum)) >= parseInt(rowss[i].quantity)){
					rollflag = "1";
				}    	 		
    		}
    	}	
		//生产计划结束时间  > T+4周 时间 ,直接计划排定
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
		 if(Date.parse(new Date(dateTime)) - Date.parse(d5) > 0){ 
			 factoryFlag = "1";
		 } 
		//判断订单在 生产周次内是否 释放过闸口
		var fdata;
		$.ajax({
	 		 url : "${dynamicURL}/prepare/prepareOrderAction!savePrepare.do",
	   	     data:{
	   	    		orderNum : orderCodeD,
	   	    		manuEndDate : dateTime
	   	    	  },
	   	     dataType:"json",
	   	     type:'post',
	   	   	 async:false,
	   	     success:function(data){
	   	    	fdata = JSON.stringify(data);
	   	     }
	 	});
		//判断数量状态 确认数据走向   rollflag = "1"  允许保存   rollflag = "2" 不允许
		if(factoryFlag == "1" || fdata == "1"){
			var contractDetailForm = $('#contractDetailForm');
	 		contractDetailForm.form('submit', {
	 			url : 'prepareOrderAction!edit.do',
	 			success : function(data) {
	 				var json = $.parseJSON(data);
	 				$.messager.alert('提示', json.msg);
	 				prepareOrderDetailDialog.dialog('close');
	 			}
	 		});
		}else{
			if(rollflag == "1"){
		 		var contractDetailForm = $('#contractDetailForm');
		 		contractDetailForm.form('submit', {
		 			url : 'prepareOrderAction!edit.do',
		 			success : function(data) {
		 				var json = $.parseJSON(data);
		 				$.messager.alert('提示', json.msg);
		 				prepareOrderDetailDialog.dialog('close');
		 			}
		 		});
			}else{
				$.messager.confirm('Confirm', '订单需要走备货单闸口释放,是否发起闸口申请?', function(r){
					if(r){
						$.ajax({
					 		 url : "prepareOrderAction!addPrepareOrderToReleaseFlag.action",
					   	     data:{
					   	    		orderCodes : orderCodeD,
					   	    		t4Date : dateTime
					   	    	  },
					   	     dataType:"json",
					   	     type:'post',
					   	   	 async:false,
					   	     success:function(data){
					   	    	$.messager.alert('提示', data.msg);
					   	    	prepareOrderDetailDialog.dialog('close');
					   	     }
					 	});
					}else{
						prepareOrderDetailDialog.dialog('close');
					}
				});
			}
		}
	}
	//导HGVS
	function hgvsInterface() {
		var actPrepareCodes = "actPrepareCodes=" + $("#actPrepare").val();
		$.messager.confirm('请确认', '您要进行导HGVS？', function(r) {
			if (r) {
				$.messager.progress({
					text : '数据加载中....',
					interval : 100
				});
				$.ajax({
					url : 'importHgvsInterfaceAction!hgvsInterface.do',
					data : actPrepareCodes,
					dataType : 'json',
					success : function(response) {
						if(response.success){
							$.messager.alert('提示','订单导HGVS成功！','info');
							$.messager.progress('close');
							datagrid.datagrid('reload');
							datagrid.datagrid('unselectAll');
							$("#orderHgvsCode").val(response.orderCode);
						}else{
							$.messager.alert('提示','导入失败：'+response.msg,'error');
							$.messager.progress('close');
							datagrid.datagrid('reload');
							datagrid.datagrid('unselectAll');
							$("#orderHgvsCode").val(response.orderCode);
						}
						
					}
				});
			}
		});
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
	
	function DateDiff(d1,d2){
	    var day = 24 * 60 * 60 *1000;
			try{    
			        var dateArr = d1.split("-");
			   var checkDate = new Date();
			        checkDate.setFullYear(dateArr[0], dateArr[1]-1, dateArr[2]);
			   var checkTime = checkDate.getTime();
			  
			   var dateArr2 = d2.split("-");
			   var checkDate2 = new Date();
			        checkDate2.setFullYear(dateArr2[0], dateArr2[1]-1, dateArr2[2]);
			   var checkTime2 = checkDate2.getTime();
			    
			   var cha = (checkTime - checkTime2)/day;  
			        return cha;
			    }catch(e){
			   return false;
			}
	}
	
	function AddDays(date,days){
			 var nd = new Date(date);
			   nd = nd.valueOf();
			   nd = nd - days * 24 * 60 * 60 * 1000;
			   nd = new Date(nd);
			   //alert(nd.getFullYear() + "年" + (nd.getMonth() + 1) + "月" + nd.getDate() + "日");
			 var y = nd.getFullYear();
			 var m = nd.getMonth()+1;
			 var d = nd.getDate();
			 if(m <= 9) m = "0"+m;
			 if(d <= 9) d = "0"+d; 
			var cdate = y+"-"+m+"-"+d;
			 return cdate;
		 }
</script>
</head>
<body>
	<div id="prepareOrderDetailDialog"
		style="display: none; width: 1000px; height: 507px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',split:true,border:false"
				style="height: 280px; overflow: hidden;">
				<form id="contractDetailForm">
					<div class="navhead_zoc">
						<span>备货单详细信息</span>
					</div>
					<div class="part_zoc">
						<div class="oneline">
							<div class="item33">
								<div class="itemleft80">备货单号:</div>
								<div class="righttext">
									<input id="actPrepare" name="actPrepareCode" type="text"
										readonly="readonly" style="background-color: #DDDDDD;" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">订单号:</div>
								<div class="righttext">
									<input name="orderNum" id="orderNum" type="text" style="background-color: #DDDDDD;" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">合同号:</div>
								<div class="righttext">
									<input name="contractCode" id="contractCode" type="text"
										readonly="readonly" style="background-color: #DDDDDD;" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item33">
								<div class="itemleft80">出口国家:</div>
								<div class="righttext">
									<input id="countryName" type="text" name="countryName"
										readonly="readonly" style="background-color: #DDDDDD;" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">ROSH:</div>
								<div class="righttext">
									<input id="" type="text" name="" value="是" readonly="readonly"
										style="background-color: #DDDDDD;" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">客户:</div>
								<div class="righttext">
									<input id="custname" name="custname" type="text"
										readonly="readonly" style="background-color: #DDDDDD;" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item33">
								<div class="itemleft80">商检批次号:</div>
								<div class="righttext">
									<input type="text" name="checkCode" id="checkCode"
										data-options="required:true" readonly="readonly"
										style="background-color: #DDDDDD;" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">经营主体:</div>
								<div class="righttext">
									<input id="deptname" type="text" name="deptname"
										readonly="readonly" style="background-color: #DDDDDD;" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">是否买断:</div>
								<div class="righttext">
									<input name="orderBuyoutFlag" type="text" id="orderBuyoutFlag"
										readonly="readonly" style="background-color: #DDDDDD;" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item33">
								<div class="itemleft80">销售组织:</div>
								<div class="righttext">
									<input id="salesOrgName" name="salesOrgName" type="text"
										readonly="readonly" style="background-color: #DDDDDD;" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">销售渠道:</div>
								<div class="righttext">
									<input id="salesChennel" name="salesChennel" type="text"
										readonly="readonly" style="background-color: #DDDDDD;" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">结算方式:</div>
								<div class="righttext">
									<input id="orderSettlementType" name="orderSettlementType"
										type="text" readonly="readonly"
										style="background-color: #DDDDDD;" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item33">
								<div class="itemleft80">HGVS订单号:</div>
								<div class="righttext">
									<input type="text" name="orderHgvsCode" id="orderHgvsCode"
										data-options="required:true" readonly="readonly"
										style="background-color: #DDDDDD;" />
								</div>
							</div>
						<div class="item33">
							<div class="itemleft80">生产工厂:</div>
							<div class="righttext">
								<div class="rightselect_easyui">
								<input id="factoryCodeFinishO" name="factoryProduceCode" class="short100"  type="text" disabled="true"/>
								</div>
							</div>
						</div>
						<div class="item33">
							<div class="itemleft80">结算工厂:</div>
							<div class="righttext">
								<div class="rightselect_easyui">
								<input id="factorySettlementCode" name="factorySettlementCode" class="short100"  type="text" disabled="true"/>
								</div>
							</div>
						</div>
						</div>
						<div class="oneline">
							<div class="item33">
								<div class="itemleft80">首样开始时间:</div>
								<div class="righttext">
									<input type="text" name="firstSampleDate" id="firstSampleDate"
										class="easyui-datebox" editable = "false"/>
								</div>
							</div>
							<div class="item33">
							<div class="itemleft80">关联订单号:</div>
							<div class="righttext">
								<input type="text" name="belongCode" id="belongCode"
									readonly="readonly"
									style="background-color: #DDDDDD;"/>
							</div>
						</div>
						</div>
						<div class="oneline">
							<div class="item33">
								<div class="itemleft80">生产计划开始</div>
								<div class="righttext">
									<input type="text" name="manuStartDate" id="manuStartDate"
										class="easyui-datebox" editable = "false"/>
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">装箱计划开始</div>
								<div class="righttext">
									<input type="text" name="packingStartDate"
										id="packingStartDate" class="easyui-datebox" disabled="disabled"/>
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">商检计划开始</div>
								<div class="righttext">
									<input type="text" name="checkStartDate" id="checkStartDate"
										class="easyui-datebox" disabled="disabled"/>
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item33">
								<div class="itemleft80">生产计划结束</div>
								<div class="righttext">
									<input type="text" name="manuEndDate" id="manuEndDate"
										class="easyui-datebox" editable = "false"/>
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">装箱计划结束</div>
								<div class="righttext">
									<input type="text" name="packingEndDate" id="packingEndDate1"
										class="easyui-datebox" disabled="disabled"/>
								</div>
							</div>
							<div class="item33">
								<div class="itemleft80">商检计划结束</div>
								<div class="righttext">
									<input type="text" name="checkEndDate" id="checkEndDate"
										class="easyui-datebox" disabled="disabled"/>
								</div>
							</div>
						</div>
						<div class="item100" align="center">
							<div class="oprationbutt">
								<input type="hidden" name="checkScheduleFlag"
									id="checkScheduleFlag" /> <input id="saveCon" type="button"
									onclick="updatePrepare();" value="保存" />
								<!-- <input id="saveCon" type="button" onclick="hgvsInterface();" value="导入HGVS" /> -->
							</div>
						</div>
					</div>
				</form>
			</div>
			<div region="center" border="false" class="part_zoc">
				<table id="datagrid_contract_one"></table>
			</div>
		</div>
	</div>

</body>
</html>