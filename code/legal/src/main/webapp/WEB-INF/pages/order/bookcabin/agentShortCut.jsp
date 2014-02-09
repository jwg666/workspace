<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>

<script type="text/javascript">
$(document).ready(function(){
	var orderShipment = "${bookOrderQuery.orderShipment}";
	$('#agentGridII').combogrid({
		required:true,
		editable:false,
		url:'${dynamicURL}/basic/vendorAction!datagrid.action?vendorType=3',
		idField:'vendorCode',  
		textField:'vendorNameCn',
		panelWidth : 500,
		panelHeight : 240,
		pagination : true,
		toolbar : '#agentTools',
		rownumbers : true,
		pageSize : 5,
		pageList : [ 5, 10 ],
		fit : true,
		fitColumns : true,
		columns : [ [ {
			field : 'vendorCode',
			title : '货代公司编码',
			width : 20
		},{
			field : 'vendorNameCn',
			title : '货代公司名称',
			width : 20
		}  ] ]
	});
	if( orderShipment == "01" ){
		$(".pickUpArea").remove();
	}else{
		$('#pickUpArea').combobox({  
	        url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=PICKUP_AREA',
	        valueField:'itemCode',
	        textField:'itemNameCn',
	        editable:false,
	        required:true,
	        panelHeight:140,
	        panelWidth:151
	    }); 
	}
});

//模糊查询船公司下拉列表
function searchAgent() {
	var agentCode = $('#agentCode').val();
	var agentName = $('#agentName').val();
	$('#agentGridII').combogrid({
		queryParams : {
			vendorNameCn : agentName,
			vendorCode : agentCode
		}
	});
	//$('#' + inputId).val(_CCNTEMP);
}
//重置查询船公司信息输入框
function cleanAgent() {
	$('#agentCode').val("");
	$('#agentName').val("");
	$('#agentGridII').combogrid({ queryParams : {} });
}
</script>

<div style="width: 440px; height: 30px; margin: 20px 5px auto 10px;">
	<form id="shortCustForm">
		<div style="width: 420; height: 30px;">
			<div style="width: 60px; float: left;">货代公司:</div>
			<div style="width: 160px; float: left;">
				<input id="agentGridII" name="vcode">
			</div>
			
			<div class="pickUpArea" style="width: 60px; float: left; text-align: right;">提货园区:</div>
			<div class="pickUpArea" style="width: 160px; float: left;">
				<input id="pickUpArea" name="pickUpArea">
			</div>
		</div>
 	</form>
 </div>
	  
<!-- 船公司下拉选信息 -->
<div id="agentTools">
	<div class="oneline">
	     <div class="item25">
			<div class="itemleft60">货代编号：</div>
			<div class="righttext">
				<input class="short50" id="agentCode" type="text" />
			</div>
		</div>
		<div class="item25">
			<div class="itemleft60">货代名称：</div>
			<div class="righttext">
				<input class="short50" id="agentName" type="text" />
			</div>
		</div>
	</div>
	<div class="oneline">
		<div class="item25">
			<div align="right">
				<input type="button" value="查询" onclick="searchAgent()" />
			</div>
		</div>
		<div class="item25">
			<div class="lefttext">
				<input type="button" value="重置" onclick="cleanAgent()" />
			</div>
		</div>
	</div>
</div>
</body>
</html>