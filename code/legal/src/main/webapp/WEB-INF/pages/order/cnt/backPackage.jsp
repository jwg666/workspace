<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@taglib
	prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script src="${staticURL}/scripts/baiduTemplate.js"></script>
<style>
table.reportTable tr td,table.reportTable tr th {
	border: 1px solid black;
	border-collapse: collapse;
	line-height: 20px;
/* 	background-color: white; */
}

table.reportTable th {
	FONT-WEIGHT: bold
}

table.reportTable {
	width: 100%;
	border-collapse: collapse;
	background-color: rgb(242, 242, 242);
	background-color: white;
}

table.reportTable input[type="text"] {
	background-color: white;
	border: 0;
}

div.datagrid tr td,table.datagrid tr th {
	border-collapse: collapse;
}

table.datagrid-htable tr.datagrid-header-row td {
	line-height: 20px;
}

table.datagrid-htable tr.datagrid-header-row td div.datagrid-cell {
	white-space: normal;
}
.temp1{
	height: 30px;
	font-family: '微软雅黑';
	FONT-SIZE: 12px; 
	
}
.edittrue{
	background-color: #DDDDDD;
}
</style>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
	var datagrid;
	var contractDetailForm;
	var contractDetailFormBefore;
	var payMoneyFlag;
	var editIndex = undefined;
	var ocode = '${ocode}';
	var dataForm;
	var flag;
	$(function() {
		//查询列表	
		datagrid = $('#datagrid').datagrid({
				url : "${dynamicURL}/actCnt/actCntAction!printBackDatagrid.do?loadingPlanCode="+ ocode,
				fitColumns : true,
				checkOnSelect:false,
				selectOnCheck:false,
				singleSelect : true, 
				nowrap : true,
				border : false,
				idField : 'actCntCode',
				showFooter : true,
				columns : [ [ {
					field : 'shipPaperCode',
					title : '提单号',
					align : 'center',
					width : 70,
					editor : {
						type : 'text'
					},
					formatter : function(value, row, index) {
						return row.shipPaperCode;
					}
				}, {
					field : 'goodsDesc',
					title : '货物名称',
					align : 'center',
					width : 50,
					editor : {
						type : 'text'
					},
					formatter : function(value, row, index) {
						return row.goodsDesc;
					}
				}, {
					field : 'scanQulitity',
					title : '包装件数',
					align : 'center',
					width : 35,
					editor : {
						type : 'numberbox'
					},
					formatter : function(value, row, index) {
						return row.scanQulitity;
					}
				}, {
					field : 'grossWeight',
					title : '毛重(kg)',
					align : 'center',
					width : 35,
					editor : {
						type : 'text'
					},
					formatter : function(value, row, index) {
						return row.grossWeight;
					}
				}, {
					field : 'volume',
					title : '尺码(m³)',
					align : 'center',
					width : 45,
					editor : {
						type : 'text'
					},
					formatter : function(value, row, index) {
						return row.volume;
					}
				}, {
					field : 'orderCode',
					title : '海尔订单号',
					align : 'center',
					width : 50,
					editor : {
						type : 'text'
					},
					formatter : function(value, row, index) {
						return row.orderCode;
					}
				}, {
					field : 'materialCode',
					title : '物料号',
					align : 'center',
					width : 50,
					editor : {
						type : 'text'
					},
					formatter : function(value, row, index) {
						return row.materialCode;
					}
				}, {
					field : 'actCntCode',
					title : '装箱预编号',
					resizable : true,
					align : 'center',
					editor : {
						type : 'text'
					},
					width : 100,
					formatter : function(value, row, index) {
						return row.actCntCode;
					}
				}, {
					field : 'loadLocation',
					title : '装箱工厂',
					resizable : true,
					align : 'center',
					editor : {
						type : 'text'
					},
					width : 100,
					formatter : function(value, row, index) {
						return row.deptNameCn;
					}
				}, {
					field : 'addirmNum',
					title : '装箱单位签章',
					align : 'center',
					width : 60,
					formatter : function(value, row, index) {
						return "";
					}
				}, {
					field : 'packingType',
					title : '',
					align : 'center',
					width : 20,
					formatter : function(value, row, index) {
						return "<a href='javascript:void(0)'  style='color:blue' onclick='appendRow()'>" +
						"增加" + "</a>";
					}
				}, {
					field : 'sendServer',
					title : '',
					align : 'center',
					width : 20,
					formatter : function(value, row, index) {
						return "<a href='javascript:void(0)'  style='color:blue' onclick='deleteRow()'>" +
						"删除" + "</a>";
					}
				}]],
				onClickRow : function(index, rowData) {
					var rdd = datagrid.datagrid('getSelected');
				    var rowss = datagrid.datagrid('getRows');
		    		var scanQulitity = 0;
					var grossWeight = 0;
					var volume = 0;
		    		for(var x = 0; x < rowss.length; x++){
		    			if(rowss[x].scanQulitity == undefined){
		    				rowss[x].scanQulitity = 0;
		    			}
		    			if(rowss[x].grossWeight == undefined){
		    				rowss[x].grossWeight = 0;
		    			}
		    			if(rowss[x].volume == undefined){
		    				rowss[x].volume = 0;
		    			}
		    			scanQulitity = parseInt(rowss[x].scanQulitity) + scanQulitity;
		    			grossWeight = parseFloat(rowss[x].grossWeight) + grossWeight;
		    			volume = parseFloat(rowss[x].volume) + volume;
		    		}
					if(flag == "1"){
						realDelete();
					}else{
						datagrid.datagrid('selectRow', index).datagrid('beginEdit',index);
						
				    	if(rowss.length > 1){
				    		 	//editIndex = undefined;
							if (editIndex != index) {
								if (endEditing()) {
									datagrid.datagrid('selectRow', index).datagrid('beginEdit',index);
									editIndex = index;
								} else {
									datagrid.datagrid('selectRow', editIndex);
								}
							}
							//包装件数
							$("[field='scanQulitity']").find("input").keyup(function(){
								scanQulitity = $(this).val();
								var sumnum = 0;
								//总数的变化    
								for(var kk = 0; kk < rowss.length; kk++){
									if(rowss[kk].scanQulitity == undefined){
										rowss[kk].scanQulitity = 0;
									}
									sumnum = parseInt(rowss[kk].scanQulitity) + sumnum;
								}
								var numss = sumnum - parseInt(rdd.scanQulitity) + parseInt(scanQulitity);
								scanQulitity = numss;
								$('#datagrid').datagrid('reloadFooter',[{goodsDesc: '总计:',scanQulitity : numss, grossWeight : grossWeight,volume : volume}]);
								if(parseInt(scanQulitity) < 0){
									$("[field='scanQulitity']").find("input").val('0');
								}
							});
							//毛重
							$("[field='grossWeight']").find("input").keyup(function(){
								grossWeight = $(this).val();
								var sumnum1 = 0;
								//总数的变化    
								for(var kk = 0; kk < rowss.length; kk++){
									if(rowss[kk].grossWeight == undefined){
										rowss[kk].grossWeight = 0;
									}
									sumnum1 = parseFloat(rowss[kk].grossWeight) + sumnum1;
								}
								var numss1 = sumnum1 - parseFloat(rdd.grossWeight) + parseFloat(grossWeight);
								grossWeight = numss1;
								$('#datagrid').datagrid('reloadFooter',[{goodsDesc: '总计:',scanQulitity : scanQulitity, grossWeight : numss1,volume : volume}]);
								if(parseFloat(grossWeight) < 0){
									$("[field='grossWeight']").find("input").val('0');
								}
							});
							//体积
							$("[field='volume']").find("input").keyup(function(){
								volume = $(this).val();
								var sumnum2 = 0;
								//总数的变化    
								for(var kk = 0; kk < rowss.length; kk++){
									if(rowss[kk].volume == undefined){
										rowss[kk].volume = 0;
									}
									sumnum2 = parseFloat(rowss[kk].volume) + sumnum2;
								}
								var numss2 = sumnum2 - parseFloat(rdd.volume) + parseFloat(volume);
								volume = numss2;
								$('#datagrid').datagrid('reloadFooter',[{goodsDesc: '总计:',scanQulitity : scanQulitity, grossWeight : grossWeight,volume : numss2}]);
								if(parseFloat(volume) < 0){
									$("[field='volume']").find("input").val('0');
								}
							});
				    	}else{
// 				    		var scanQulitity = $("[field='scanQulitity']").find("input").val();
// 							var grossWeight = $("[field='grossWeight']").find("input").val();
// 							var volume = $("[field='volume']").find("input").val();
				    		editIndex = undefined;
							if (editIndex != index) {
								if (endEditing()) {
									datagrid.datagrid('selectRow', index).datagrid('beginEdit',index);
									editIndex = index;
								} else {
									datagrid.datagrid('selectRow', editIndex);
								}
							}
							//包装件数
							$("[field='scanQulitity']").find("input").keyup(function(){
								scanQulitity = $(this).val();
								//总数的变化    
								$('#datagrid').datagrid('reloadFooter',[{goodsDesc: '总计:',scanQulitity : scanQulitity , grossWeight : grossWeight,volume : volume}]);
								if(parseInt(scanQulitity) < 0){
									scanQulitity = 0;
									$("[field='scanQulitity']").find("input").val('0');
									$('#datagrid').datagrid('reloadFooter',[{goodsDesc: '总计:',scanQulitity : '0' , grossWeight : grossWeight,volume : volume}]);
								}
							});
							//毛重
							$("[field='grossWeight']").find("input").keyup(function(){
								grossWeight = $(this).val();
								//总数的变化    
								$('#datagrid').datagrid('reloadFooter',[{goodsDesc: '总计:',scanQulitity : scanQulitity , grossWeight : grossWeight,volume : volume}]);
								if(parseFloat(grossWeight) < 0){
									grossWeight = 0;
									$("[field='grossWeight']").find("input").val('0');
									$('#datagrid').datagrid('reloadFooter',[{goodsDesc: '总计:',scanQulitity : scanQulitity , grossWeight : '0',volume : volume}]);
								}
							});
							//尺码
							$("[field='volume']").find("input").keyup(function(){
								volume = $(this).val();
								//总数的变化    
								$('#datagrid').datagrid('reloadFooter',[{goodsDesc: '总计:',scanQulitity : scanQulitity , grossWeight : grossWeight,volume : volume}]);
								if(parseInt(volume) < 0){
									volume = 0;
									$("[field='volume']").find("input").val('0');
									$('#datagrid').datagrid('reloadFooter',[{goodsDesc: '总计:',scanQulitity : scanQulitity, grossWeight : grossWeight,volume : '0'}]);
								}
							});
// 							var editor_target = $('#datagrid').datagrid('getEditor',{index: index,field:'nowBudgetNumber'}).target;
// 							    editor_target.attr("disabled",true);
						}
					}
			    	flag = "0";
				},
				onDblClickRow: function(index, rowData) {
					datagrid.datagrid('endEdit', index);
					datagrid.datagrid('unselectAll');
				},
			});
		//加载总计部分
		var scanQulititySum = 0;
		var grossWeightSum = 0;
		var volumeSum = 0;
		$.ajax({
			url : "${dynamicURL}/actCnt/actCntAction!printBackDatagrid.do?loadingPlanCode="+ ocode,
			dataType : "json",
			type : 'post',
			async : false,
			success : function(data) {
				for(var p = 0; p < data.length ; p++){
					scanQulititySum = parseInt(data[p].scanQulitity) + scanQulititySum;
					grossWeightSum = parseInt(data[p].grossWeight) + grossWeightSum;
					volumeSum = data[p].volume + volumeSum;
				}
			}
		});
		
		$('#datagrid').datagrid('reloadFooter',[{goodsDesc: '总计:',scanQulitity : scanQulititySum , grossWeight : grossWeightSum,volume : volumeSum}]);
		//判断订单是否过了付款保障
		$.ajax({
			url : "${dynamicURL}/actCnt/actCntAction!printBackForm.do?loadingPlanCode="+ ocode,
			dataType : "json",
			type : 'post',
			async : false,
			success : function(data) {
				 $("#contractDetailForm").form('load',{
					 pickupStation : data.station,
					 backCtnsLocation : data.station,
					 vessel : data.vessel,
					 voyage : data.voyno,
					 containerType : data.containX,
					 containerQuantity : data.containW,
					 sealNum : data.xfh,
				 	 containerNum : data.jzxh,
					 loadDate : data.actcntDate,
					 forwarding : data.agentShip,
					 loadLocation : data.deptNameCn,
					 portDest : data.portName
		   		});
			}
		});
	});

	function printReport() {
		datagrid.datagrid('endEdit', editIndex);
		datagrid.datagrid('unselectAll');
		var listBackPackage = datagrid.datagrid('getData');
		//隐藏增加 删除按钮
		datagrid.datagrid('hideColumn','packingType');
		datagrid.datagrid('hideColumn','sendServer');
		//保存  回箱单主表
		$('#contractDetailForm').form('submit', {
			url:'${dynamicURL}/actCnt/backContainerAction!add.do',
			onSubmit : function(param) {
				param.listBackPackage = JSON.stringify(listBackPackage.rows);
			},
			success:function(data){
			}
		});
		var print = $(".printBody").clone();
		lodopPrintFullWidth(gridToTable(print), "海尔出口装箱理货单");
	}
	
	function appendRow(){
		datagrid.datagrid('endEdit', editIndex);
		datagrid.datagrid('unselectAll');
		datagrid.datagrid('appendRow',{});
	}
	function deleteRow(){
		flag = "1";
		datagrid.datagrid('endEdit', editIndex);
		datagrid.datagrid('unselectAll');

	}
	function realDelete(){
		var row = datagrid.datagrid('getSelected');
		var index = $('#datagrid').datagrid('getRowIndex', row);
		$('#datagrid').datagrid('deleteRow',index);
	}
	
	//行编辑代码
	function endEditing() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#datagrid').datagrid('validateRow', editIndex)) {
			$('#datagrid').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
</script>

</head>
<body>
	<div>
		<form id="contractDetailForm" class="printBody" method="post">
			<div style="width: 1151px; margin: 0 auto;">
				<div align="center">
					<span>海尔出口装箱理货单</span> <input id="printButton" type="button"
						value="打  印" onclick="printReport(this.style.display='none')"
						style="width: 60px; height: 22px;" />
				</div>
				<div style="margin: 0 auto;" class='zoc'>
					<table class="reportTable">
						<tr>
							<td colspan="2" height="50px;" width="25%"
								style="height: 100%; border-right-width: 1px;"><img
								src="${staticURL}/style/images/logo_login.png"
								style="margin-left: 60px;" /></td>
							<td colspan="6" height="50px;" width="75%">
								<div id="flga"
									style="font-family: '微软雅黑';FONT-SIZE: 19px; FONT-WEIGHT: bold; margin-left: 200px;">
									海尔出口装箱理货单</div>
							</td>
						</tr>
						<tr>
							<td class = "temp1" align="center" colspan="1">提箱场站</td>
							<td class = "temp1" colspan="1"><input id = "pickupStation" name = "pickupStation" type="text" readonly="readonly"/></td>
							<td class = "temp1" align="center" colspan="1">返箱地点</td>
							<td class = "temp1" style="background-color: #DDDDDD" colspan="1"><input id = "backCtnsLocation" name = "backCtnsLocation" type="text" style="background-color: #DDDDDD"/></td>
							<td class = "temp1" align="center" style="width: 150px;">船名</td>
							<td class = "temp1" colspan="1"><input id = "vessel" name = "vessel" type="text" readonly="readonly"/></td>
							<td class = "temp1" align="center" colspan="1">航次</td>
							<td class = "temp1" ><input id = "voyage" name = "voyage" type="text" readonly="readonly" /></td>
						</tr>
						<tr>
							<td class = "temp1" align="center">箱型</td>
							<td class = "temp1"><input id = "containerType" name = "containerType" type="text" readonly="readonly"/></td>
							<td class = "temp1" align="center">箱量</td>
							<td class = "temp1">
							<input id = "" name = "" type="text" readonly="readonly" value="1"/>
							</td>
							<td class = "temp1" align="center">集装箱号</td>
							<td class = "temp1" style="background-color: #DDDDDD"><input id = "containerNum" name = "containerNum" type="text" style="background-color: #DDDDDD"/></td>
							<td class = "temp1" align="center">铅封号</td>
							<td class = "temp1" style="background-color: #DDDDDD"><input id = "sealNum" name = "sealNum" type="text" style="background-color: #DDDDDD"/></td>
						</tr>
						<tr>
							<td class = "temp1" align="center">装箱日期</td>
							<td class = "temp1"><input id = "loadDate" name = "loadDate" type="text" readonly="readonly"/></td>
							<td class = "temp1" align="center" style="width: 80px">船公司</td>
							<td class = "temp1"><input id = "forwarding" name = "forwarding" type="text" style="width: 200px;" readonly="readonly"/></td>
<!-- 							<td class = "temp1" align="center">装货地点</td> -->
<!-- 							<td class = "temp1" style="background-color: #DDDDDD"><input id = "loadLocation" name = "loadLocation" type="text" style="background-color: #DDDDDD"/></td> -->
							<td class = "temp1" align="center">目的港</td>
							<td class = "temp1"><input id = "portDest" name = "portDest" type="text" readonly="readonly"/></td>
						</tr>
						<tr>
							<td colspan="8" class = "temp1">
								<table id ="datagrid"></table>
							</td>
						</tr>
						<tr style="height: 50px;">
							<td colspan="2">确认装箱信息准确无误：（此项由发货人确认）</td>
							<td colspan="6"><input type="text" id = "consignor" name = "consignor"></input></td>
						</tr>
						<tr style="height: 50px;">
							<td colspan="1" align="center">拖车公司：</td>
							<td class = "edittrue" colspan="1"><input type="text" id = "trailer" name = "trailer" style="background-color: #DDDDDD"></input></td>
							<td align="center">车号：</td>
							<td class = "edittrue" colspan="1" style="width :100px;"><input type="text" id = "carNum" name = "carNum" style="background-color: #DDDDDD"></input></td>
							<td colspan="1" align="center" width="100px;">司机电话：</td>
							<td class = "edittrue" colspan="1"><input type="text" id = "driverPhone" name = "driverPhone" style="background-color: #DDDDDD"></input></td>
							<td style = "width: 200px;" align="center">司机确认（确定该箱符合装货要求并已关闭箱锁）</td>
							<td colspan="1" style = "width: 150px;"><input type="text" id = "driverConfirm" name = "driverConfirm"></input></td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</div>
</body>
</html>