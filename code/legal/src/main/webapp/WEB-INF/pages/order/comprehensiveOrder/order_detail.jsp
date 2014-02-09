<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<style>
table.form_table {
	border: 1px solid #CCCCCC;
	border-collapse: collapse;
	background-color: #f2f2f2;
	position: relative;
}

table.form_table td {
	padding: 2px;
	border-right: 1px solid #C0C0C0;
	border-bottom: 1px solid #C0C0C0;
}

table.main td {
	width: 171px;
}

table.form_table th {
	height: 21px;
	width: 137px;
	padding: 3px;
	border-bottom: 1px solid #A4B5C2;
	border-right: 1px solid #A4B5C2;
	text-align: left;
}

.noLine {
	BORDER-BOTTOM-COLOR: #666666;
	BORDER-RIGHT-WIDTH: 0px;
	BACKGROUND: Transparent;
	BORDER-TOP-WIDTH: 0px;
	BORDER-BOTTOM-WIDTH: 0px;
	HEIGHT: 18px;
	BORDER-LEFT-WIDTH: 0px;
}
</style>
<script type="text/javascript" charset="utf-8">
	var comprehensiveOrderForm;
	var datagrid_detail;
	var datagrid_toolbar;
	$(function() {
		comprehensiveOrderForm = $("#comprehensiveOrderForm").form();
		datagrid_toolbar = $('#datagrid_toolbar').datagrid({
			border : false,
			pagination : false,
		    toolbar : [ {
				text : '<s:text name="global.info.print" >打印</s:text>',
				iconCls : 'icon-edit',
				handler : function() {
					dayin();
					//$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>', '维护中...', 'info');
				}
			}, '-' ]
	    });
		$.ajax({
			url : '${dynamicURL}/comprehensiveOrder/comprehensiveOrderAction!orderShowDesc.do?orderCode=${orderCode}',
			dataType : 'json',
			cache : false,
			success : function(response) {
				comprehensiveOrderForm.form('clear');
				comprehensiveOrderForm.form('load', response);
			/* 	//运费
				var arg1=comprehensiveOrderForm.find("input[name='zfConditionValue']").val();
				//保费
				var arg2=comprehensiveOrderForm.find("input[name='zkConditionValue']").val();
				var arg3=$("#fobAmountsId").val();
				var arg4=(arg1*100+arg2*100+arg3*100)/100;
				comprehensiveOrderForm.find("input[name='FOB']").val(arg3);
				comprehensiveOrderForm.find("input[name='CIFCFR']").val(arg4); */
				datagrid_detail = $('#datagrid_detail').datagrid({
					url : '${dynamicURL}/comprehensiveOrder/comprehensiveOrderAction!searchOrderDetail.do?orderCode=${orderCode}',
					rownumbers : true,
					fit : true,
					fitColumns : true,
					nowrap : true,
					border : false,
					singleSelect : true,
					idField : 'orderCode',
					showFooter : true,
					columns : [ [ 
					{
						field : 'prodType',title : '<s:text name="order.comprehensive.prodtype" >货名</s:text>',align : 'center',sortable : true,width : 90
					}, {
						field : 'haierModel',title : '海尔型号',align : 'center',sortable : true,width : 90
					}, {
						field : 'customerModel',title : '客户型号',align : 'center',sortable : true,width : 90
					}, {
						field : 'prodQuantity',title : '<s:text name="pcm.form.count" >数量</s:text>',align : 'center',sortable : true,width : 90
					}, {
						field : 'grossWeight',title : '<s:text name="order.comprehensive.grossWeight" >每件毛重</s:text>(KG)',align : 'center',sortable : true,width : 90,
						formatter:function(value,row,index){
							//return row.grossWeight;
							if(row.grossWeight==null||row.grossWeight==''||row.grossWeight=='/'){
								return row.grossWeight;
							}else{						
								return Number(row.grossWeight).toFixed(2);
							}
			        }
					}, {
						field : 'sumGrossWeight',title : '<s:text name="order.comprehensive.sumGrossWeight" >总毛重</s:text>',align : 'center',sortable : true,width : 90,
						formatter:function(value,row,index){
							if(row.sumGrossWeight==null||row.sumGrossWeight==''){
								return row.sumGrossWeight;
							}else{						
							    return Number(row.sumGrossWeight).toFixed(2);
							}
			        }
					}, {
						field : 'grossValue',title : '<s:text name="order.comprehensive.grossValue" >每件尺码</s:text>(m3)',align : 'center',sortable : true,width : 90,
						formatter:function(value,row,index){
							if(row.grossValue==null||row.grossValue==''||row.grossValue=='/'){
								return row.grossValue;
							}else{						
							    return Number(row.grossValue).toFixed(2);
							}
			        }
					}, {
						field : 'sumGrossValue',title : '<s:text name="order.comprehensive.sumGrossValue" >总尺码</s:text>(m3)',align : 'center',sortable : true,width : 90,
						formatter:function(value,row,index){
							if(row.sumGrossValue==null||row.sumGrossValue==''){
								return row.sumGrossValue
							}else{						
							    return Number(row.sumGrossValue).toFixed(2);
							}
			        }
					}, {
						field : 'standardContainerId',
						title : '<s:text name="order.comprehensive.standardContainerId" >相关装箱图号</s:text>',
						align : 'center',
						sortable : true,
						width : 90
					}, {
						field : 'price',
						title : '<s:text name="order.comprehensive.price" >原币单价</s:text>',
						align : 'center',
						sortable : true,
						width : 90,
						formatter:function(value,row,index){
							if(row.price==null||row.price==''||row.price=='/'){
								return row.price;
							}else{						
							    return Number(row.price).toFixed(2);
							}
			        }
					}, {
						field : 'amount',
						title : '<s:text name="order.comprehensive.amount" >原币总额</s:text>',
						align : 'center',
						sortable : true,
						width : 90,
						formatter:function(value,row,index){
							if(row.amount==null||row.amount==''){
								return row.amount;
							}else{						
							    return Number(row.amount).toFixed(2);
							}
			        }
					}, /* {
						field : 'fobPrice',
						title : '<s:text name="order.comprehensive.fobPrice" >原币FOB单价</s:text>',
						align : 'center',
						sortable : true,
						width : 90,
						formatter:function(value,row,index){
							if(row.price==null||row.price==''||row.price=='/'){
								return row.fobPrice;
							}else{						
							    return Number(row.fobPrice).toFixed(2);
							}
			        }
					}, {
						field : 'fobAmount',
						title : '<s:text name="order.comprehensive.fobAmount" >原币FOB总额</s:text>',
						align : 'center',
						sortable : true,
						width : 90,
						formatter:function(value,row,index){
							return Number(row.fobAmount).toFixed(2);
			        }
					}, */ {
						field : 'custPrice',
						title : '原币采购单价',
						align : 'center',
						sortable : true,
						width : 90,
						formatter:function(value,row,index){
							if(row.custPrice==null||row.custPrice==''||row.custPrice=='/'){
								return row.custPrice;
							}else{						
							    return Number(row.custPrice).toFixed(2);
							}
			        }
					}, {
						field : 'custAmount',
						title : '原币采购总额',
						align : 'center',
						sortable : true,
						width : 90,
						formatter:function(value,row,index){
							return Number(row.custAmount).toFixed(2);
			        }
					} ] ],
				/* 	loadFilter : function(data) {
						$("#fobAmountsId").val(data.footer[0].fobAmount);
						return data;
					}, */
					onLoadSuccess:function(data){
						//FOB的计算有可能有点问题
						//comprehensiveOrderForm.find("input[name='FOB']").val(Number(data.footer[0].fobAmount).toFixed(2));
						//comprehensiveOrderForm.find("input[name='CIFCFR']").val(Number(data.footer[0].amount).toFixed(2));
						//转化运费
						$('#zfConditionValueId').val(Number($('#zfConditionValueId').val()).toFixed(2));
						//转化保费
						$('#zkConditionValueId').val(Number($('#zkConditionValueId').val()).toFixed(2));
						//折扣
						$('#sktoConditionValueId').val(Number($('#sktoConditionValueId').val()).toFixed(2));
						//广告费
						$('#zk05ConditionValueId').val(Number($('#zk05ConditionValueId').val()).toFixed(2));
						//原币采购总额
						$('#conditionValueId').val(Number($('#conditionValueId').val()).toFixed(2));
						//议付金额
						$('#yfamountId').val(Number($('#yfamountId').val()).toFixed(2));
						//fob总额
						$('#fobamountid').val(Number($('#fobamountid').val()).toFixed(2));
						//cif总额
						$('#cifAmountid').val(Number($('#cifAmountid').val()).toFixed(2));
						var detalType=$('#orderDealTypeId').val();
						if(detalType!=null&&detalType=='FOB'){
							$('#cifAmountid').val('/');
						}
						if(detalType!=null&&detalType=='FTC'){
						     document.getElementById('yunfeNamecodeiid').innerHTML="THC费";
						}
					}
				});
			}
		});
		
	});
	//打印
	function dayin(){
		//var count = lodopPrint(gridToTable($("#printBody").clone(true)));
		var printbody = $("#printBody").clone(true);
		printbody.find("#datagridTr td").height("auto");
		lodopPrintFullWidth(gridToTable(printbody));
	}
</script>
</head>
<body class="easyui-layout zoc">
	<div region="north" border="false" class="zoc" title="" collapsed="false"  style="overflow: auto;" align="left">
		<div class="datagrid-toolbar">
			<table id="datagrid_toolbar" style="height: 28px;"></table>
		</div>
	</div>
	<div region="center" border="false" style="overflow: auto;" align="center" class="zoc" id="printBody" >
		<div class="part_zoc zoc" style="width: 1098px;">
			<div class="partnavi_zoc" align="left">
				<span><s:text name="order.comprehensive.comprehensiveOrder" >综合通知单</s:text></span>
			</div>
			<input name="fobAmounts" id='fobAmountsId' type="hidden"/>
		<form id="comprehensiveOrderForm">
		
			<table border="0" cellspacing="0" class="form_table main"
				cellpadding="0" width="1100px"
				style="border-bottom-color: white; border-bottom-width: 0px; border-top-color: white; border-right-color: white;">
				<tr>
					<td rowspan="3" style="height: 100%; border-right-width: 0px;"
						colspan="2" width="20%">
						<img src="${staticURL}/style/images/logo_login.png"/>
					</td>
					<td rowspan="3" colspan="4"
						style="padding-left: 138px; border-right-width: 0px; font-family: '微软雅黑'; HEIGHT: 35px; FONT-SIZE: 19px; FONT-WEIGHT: bold"><s:text name="order.comprehensive.title" >货物出库、出运、会计核算综合通知单</s:text></td>
					<td style="border-bottom-width: 0px; height: 18px;"></td>
				</tr>
				<tr>
					<td style="border-bottom-width: 0px;"><s:text name="order.comprehensive.compreNum" >综合通知单号</s:text></td>
				</tr>
				<tr>
					<td><input type="text" class="noLine" readonly="readonly"
						name="compreNum" /></td>
				</tr>
				<tr>
					<th><s:text name="order.comprehensive.operators" >经营单位</s:text>:</th>
					<td colspan="2"><input type="text" class="noLine"
						readonly="readonly" name="operators" style="width: 100%;" /></td>
					<th><s:text name="order.comprehensive.orderPoCode" >客户PO NO</s:text>:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="orderPoCode" style="width: 100%;"/></td>
					<th><s:text name="order.info.orderDealType" >成交方式</s:text>:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="orderDealType" id="orderDealTypeId" /></td>
				</tr>
				<tr>
					<th nowrap="nowrap"><s:text name="order.comprehensive.actprepareCode" >货物通知单号</s:text>:</th>
					<td colspan="2"><input type="text" class="noLine"
						readonly="readonly" name="actPrepareCode" style="width: 100%;" /></td>
					<th><s:text name="global.order.number" >订单号</s:text>:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="orderCode" /></td>
					<th><s:text name="order.contract.contractCode" >合同号</s:text>:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="contractCode" /></td>
				</tr>
				<tr>
					<th><s:text name="global.order.customerName" >客户名称</s:text>:</th>
					<td colspan="2"><input type="text" class="noLine"
						readonly="readonly" name="customerName" style="width: 100%;" /></td>
					<th><s:text name="global.order.customerCode" >客户编号</s:text>:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="customerCode" /></td>
					<th><s:text name="order.comprehensive.itemNameCn" >贸易国别/地区</s:text>:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="itemNameCn" /></td>
				</tr>
				<!-- 		<tr> -->
				<!-- 			<th rowspan="3">付款保障:</th> -->
				<!-- 			<th style="border-right-width: 0px;border-right-color: white;">[&nbsp;]L/C,L/C No.:</th> -->
				<!-- 			<td><input type="text" class="noLine" readonly="readonly" name=""/></td> -->
				<!-- 			<th style="border-right-width: 0px;">[&nbsp;]T/T,预付，水单号:</th> -->
				<!-- 			<td colspan="3"><input type="text" class="noLine" readonly="readonly" name=""/></td> -->
				<!-- 		</tr> -->
				<!-- 		<tr> -->
				<!-- 			<th nowrap="nowrap" style="border-right-width: 0px;">[&nbsp;]D/A,D/P,编号:</th> -->
				<!-- 			<td><input type="text" class="noLine" readonly="readonly" name=""/></td> -->
				<!-- 			<th colspan="4">[&nbsp;]免费（需要由市场部负责人签字 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;）</th> -->
				<!-- 		</tr> -->
				<!-- 		<tr> -->
				<!-- 			<th colspan="6">[&nbsp;]其它</th> -->
				<!-- 		</tr> -->
				<tr>
					<th rowspan="3"><s:text name="global.order.payment" >付款保障</s:text>:</th>
					<td colspan="2"><input type="text" class="noLine"
						readonly="readonly" name="payment1" style="width: 100%;" /></td>
					<td colspan="2"><input type="text" class="noLine"
						readonly="readonly" name="payment2" style="width: 100%;" /></td>
					<td colspan="2"><input type="text" class="noLine"
						readonly="readonly" name="payment3" style="width: 100%;" /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" class="noLine"
						readonly="readonly" name="payment4" style="width: 100%;" /></td>
					<td colspan="2"><input type="text" class="noLine"
						readonly="readonly" name="payment5" style="width: 100%;" /></td>
					<td colspan="2"><input type="text" class="noLine"
						readonly="readonly" name="payment6" style="width: 100%;" /></td>
				</tr>
				<tr>
					<th colspan="4" align="left" style="border-right-width: 0">[&nbsp;]<s:text name="order.comprehensive.free" >免费（需要由市场部负责人签字）</s:text></th>
					<!-- <th colspan="2" ></th> -->
					<th colspan="2" align="left">[&nbsp;]<s:text name="global.info.other" >其它</s:text></th>
				</tr>
				<tr>
					<th colspan="2"
						style="border-right-width: 0px; border-right-color: white;"><s:text name="order.comprehensive.notfree" >非预付、非免费条件的付款周期</s:text>：
					</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="paymentPeriod" style="width: 60px; text-align: center;" /><s:text name="global.info.day" >天</s:text></td>
					<th><s:text name="global.order.orderCustNamager" >市场经理</s:text>:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="orderCustNamager" /></td>
					<th><s:text name="global.order.orderExecManager" >产品经理</s:text>:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="orderExecManager" /></td>
				</tr>
			</table>
			<table border="0" cellspacing="0" class="form_table" cellpadding="0"
				width="1100px"
				style="border-bottom-color: white; border-bottom-width: 0px; border-top-width: 0px; border-right-color: white;">

				<tr>
					<th><s:text name="order.comprehensive.portStartCode" >起运口岸</s:text></th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="portStartCode" /></td>
					<th><s:text name="order.comprehensive.portEndCode" >到达口岸</s:text>:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="portEndCode" /></td>
					<th><s:text name="order.comprehensive.orderShipDate" >要求出运期</s:text>:</th>
					<td colspan="2"><input type="text" class="noLine"
						readonly="readonly" name="orderShipDateString" /></td>
				</tr>
				<tr>
					<th colspan="7" style="border-bottom-width: 1px solid #A4B5C2;"><s:text name="order.comprehensive.coefficient" >装箱难度系数</s:text>：<s:text name="order.comprehensive.total" >共</s:text>
						&nbsp;<input type="text" class="noLine" readonly="readonly"
						name="" style="width: 60px;" />&nbsp;<s:text name="order.comprehensive.box" >箱</s:text>， <s:text name="order.comprehensive.totalcoefficient " >总系数</s:text>：&nbsp;<input
						type="text" class="noLine" readonly="readonly" name=""
						style="width: 60px;" />&nbsp; &nbsp;&nbsp; <s:text name="global.order.ecurrency" >币种</s:text>：&nbsp;<input
						type="text" class="noLine" readonly="readonly" name="currency"
						style="width: 60px;" />&nbsp; <label id="yunfeNamecodeiid">运费</label>：&nbsp;<input type="text"
						class="noLine" readonly="readonly" name="zfConditionValue" id="zfConditionValueId"
						style="width: 60px;" />&nbsp; &nbsp;&nbsp; <s:text name="global.order.zkConditionValue" >原币保费</s:text>：&nbsp;&nbsp;<input
						type="text" class="noLine" readonly="readonly"
						name="zkConditionValue" id="zkConditionValueId" style="width: 60px;" /> &nbsp;&nbsp;
						<s:text name="order.comprehensive.sktoConditionValue" >折扣</s:text>：&nbsp;&nbsp;<input type="text" class="noLine"
						readonly="readonly" name="sktoConditionValue" id="sktoConditionValueId" style="width: 60px;" />
					</th>
				</tr>
				<tr id="datagridTr">
					<td colspan="7"
						style="border-bottom-width: 0px; border-top-width: 0px; height: 200px;">
							<table id="datagrid_detail"></table> 
					</td>
				</tr>
				<tr id="datagridTr1">
					<th colspan="4"><s:text name="order.comprehensive.zk05ConditionValue" >品牌广告费</s:text>: &nbsp;&nbsp;<input type="text"
						class="noLine" readonly="readonly" name="zk05ConditionValue" id="zk05ConditionValueId"/></th>
					<th colspan="3"><s:text name="order.comprehensive.contrainer" >总装箱用量</s:text>: &nbsp;&nbsp;&nbsp; <input type="text"
						class="noLine" readonly="readonly" name="contrainer"
						style="text-align: center;" />
					</th>
				</tr>
				<tr>
					<th><s:text name="pcm.model.invoice" >发票号</s:text>:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="invoiceNum" /></td>
						<th>客户发票金额:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="yfamount" id="yfamountId"/></td>
					<th><s:text name="order.comprehensive.cif/cfr" >CIF/CFR净值</s:text>:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="currency" style="width: 70px;"/>
						<input type="text" class="noLine" readonly="readonly"
						name="cifAmount" id="cifAmountid" style="width: 100px; text-align: left;" />
					</td>
<!-- 					<th>USD:<input type="text" class="noLine" readonly="readonly" -->
<!-- 						name="" style="width: 100px; text-align: right;" /></th> -->
				</tr>
				<tr>
					<th><s:text name="order.comprehensive.shipment.date" >实际装运日期</s:text>:</th>
					<td ><input type="text" class="noLine"
						readonly="readonly" name="orderShipDateString" /></td>
					
						<th>议付金额:</th>
					<td><input type="text" class="noLine" readonly="readonly"
						name="conditionValue" id="conditionValueId"/></td>
					<th><s:text name="order.comprehensive.fob" >FOB净值</s:text>:</th>
					<td>
						<input type="text" class="noLine" readonly="readonly"
						name="currency" style="width: 70px;"/>
						<input type="text" class="noLine" readonly="readonly"
						name="fobamount" id="fobamountid" style="width: 100px; text-align: left;" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	</div>
</body>
</html>