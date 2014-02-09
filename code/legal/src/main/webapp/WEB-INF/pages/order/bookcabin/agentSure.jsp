<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<style>
<!--
.ro{
	background-color: #f2f1f1;
}
input,textarea{ 
    border: 1px solid #e7e8ea;
    font-size: 13px;
} 
input,label { vertical-align:middle;} 
-->
</style>


<script type="text/javascript">
    $(document).ready(function(){
    	$('#cabinOrder').datagrid({
    		title:'订舱明细',
            url:'${dynamicURL}/bookorder/cabinAgentItemAction!datagrid.do',
        	queryParams: {
        		"bookCode":"${bookOrderQuery.bookCode}"
        	},
			iconCls : 'icon-save',
			fit : true,
			singleSelect : true,
			fitColumns : true,
			showFooter: true,
			nowrap : true,
			border : false,
			columns : [ [ 
			   { field : 'orderCode', title : '订单编号', width:80}, 
			   { field : 'orderItemCode', title : '行项目号', width:60},  
			   { field : 'prodTname', title : '产品名称', width:60}, 
			   { field : 'haierModel',	title : '产品型号', width:60}, 
			   { field : 'customerModel', title : '客户型号', width:60}, 
			   { field : 'materialCode', title : '物料号', width:60}, 
			   { field : 'hsCode', title : 'HS编码', width:80}, 
			   { field : 'simpleCode', title : 'HROIS编码', width:80}, 
			   { field : 'goodsAmount', title : '数量', width:40}, 
			   { field : 'unit', title : '单位', width:40}, 
			   { field : 'goodsCount', title : '件数', width:40}, 
			   { field : 'deptName', title : '生产工厂', width:80}, 
			   { field : 'cityName', title : '国家', width:80}, 
			   { field : 'goodsGrossWeight', title : '总毛重(Kg)', width:80}, 
			   { field : 'goodsMesurement', title : '总体积(M³)', width:80}, 
			   { field : 'marks', title : '唛头', width:120}, 
			   { field : 'goodsDescription', title : '货描', width:120},
			   { field : 'mergeCustFlag', title : '分组', width:40}
			 ] ]
		});
    	
    	$('#bookAgent').combogrid({
			required:true,
			editable:false,
			url:'${dynamicURL}/basic/vendorAction!datagrid.action?vendorType=3',
			idField:'vendorCode',  
			textField:'vendorNameCn',
			panelWidth : 500,
			panelHeight : 240,
			pagination : true,
			toolbar : '#_VENDOR',
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
    	
    	$('[name="pickUpArea"]').combobox({  
            url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=PICKUP_AREA',
	        valueField:'itemCode',
	        textField:'itemNameCn',
	        editable:false,
	        required:true,
	        panelHeight:140,
	        panelWidth:150
	    }); 
    	
    	$("form").form("validate");
    	$("[name='bookCode']").focus();
    	
	});
	function cabinAgent(){
		var portName = $("#portEndName").val();
		var vendorName = $("#vendorName").val();
		if( portName == "TBD" || portName == "ABX" ){
		    $.messager.alert('系统提示','订舱目的港为【' + portName + "】,不允许此操作!");  
		}else if( vendorName == "TBD" || vendorName == "ABX"){
		    $.messager.alert('系统提示','订舱船公司为【' + vendorName + "】,不允许此操作!");  
		}else if($("form").form("validate")){
		    var bookAgent = $("[name='bookAgent']").val();
		    var bookCode = $("[name='bookCode']").val();
		    var pickUpArea = $("[name='pickUpArea']").val();
			$.messager.progress({text:'系统处理中，请稍等...',interval:200});
		    $.ajax({
			    url : "${dynamicURL}/bookorder/cabinAgentAction!cabinAgent.do",
			    type : 'post',
			    data : {
				    'codes' : bookCode,
				    'pickUpArea' : pickUpArea,
				    'vcode' : bookAgent,
				    'transConfirm' : true
			    },
			    dataType : 'json',
			    success : function(data) {
			    	$.messager.progress('close');
				    if(data.success){
					    parent.window.HROS.window.close(currentappid);
					    customWindow.reloaddata();
				    }else{
					    $.messager.alert('系统提示','该订舱需补录入货通知单，暂不能处理！');  
				    }
			    }
		    });
		}
	}
	
	//模糊查询船公司下拉列表
	function _VENDORMY() {
		var _CCNCODE = $('#_VENDORCODE').val();
		var _CCNTEMP = $('#_VENDORNAME').val();
		$('#bookAgent').combogrid({
			queryParams : {
				vendorNameCn : _CCNTEMP,
				vendorCode : _CCNCODE
			}
		});
	}
	//重置查询船公司信息输入框
	function _VENDORMYCLEAN() {
		$('#_VENDORCODE').val("");
		$('#_VENDORNAME').val("");
		$('#bookAgent').combogrid({ queryParams : {} });
	}
</script>
</head>
<body class="easyui-layout" fit=true style="overflow: hidden;">
	<div data-options="region:'north'" style="height:240px" title="订舱主信息">
	  <form>
			<table style="width: 100%; height:100%; padding: 5px;">
				<tr style="height: 24px;">
					<td width="80px">订舱号:</td>
					<td width="180px"><input name="bookCode" class="ro" readonly="readonly" value="${bookOrderQuery.bookCode}"/></td>
					<td width="80px">经营主体:</td>
					<td width="180px"><input class="ro" readonly="readonly" value="${bookOrderQuery.operators }" /></td>
					<td width="80px">始发港:</td>
					<td width="180px"><input class="ro" readonly="readonly" value="${bookOrderQuery.portStartNameEn }" /></td>
					<td width="80px">目的港:</td>
					<td width="180px"><input id="portEndName" class="ro" readonly="readonly" value="${bookOrderQuery.portEndNameEn }" /></td>
				</tr>
				<tr style="height: 24px;">
					<td>订舱人：</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.createdBy }" /></td>
					<td>发货人:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.bookSendMan }" /></td>
					<td>收货人:</td>
					<td><input class="ro" readonly="readonly" value='${bookOrderQuery.bookReceiveMan }' /></td>
					<td>通知人:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.bookNotifyMan }" /></td>
				</tr>
				<tr style="height: 24px;">
					<td>成交方式:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.orderDealName }" /></td>
					<td>运输方式:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.orderShipmentName }" /></td>
					<td>运输公司:</td>
					<td><input id="vendorName" class="ro" readonly="readonly" value="${bookOrderQuery.vendorName }" /></td>
					<td>代理公司:</td>
					<td><input id="bookAgent" name="bookAgent" /></td>
				</tr>
				<tr>
					<td>启运日期:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.bookShipDateStr }" /></td>
					<td>要求到货期:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.orderCustomDateStr }" /></td>
					<td>提单类型:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.bookGetTimes}"/></td>
					<s:if test="bookOrderQuery.stockNotification != null">
					<td>入货通知单:</td>
					<td colspan="7" align="left">
					   <a href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId=${bookOrderQuery.stockNotification}">下载入货通知单</a>
					</td>
					</s:if>
				</tr>
				<tr style="height: 24px;">
				    <s:if test="%{bookOrderQuery.orderShipment == \"01\"}">
					<td>预算箱型箱量:</td>
					<td><input id="planContainer" type="text" class="ro" value="${bookOrderQuery.container}" readonly="readonly"/></td>
					<td>实际箱型箱量:</td>
					<td>
					    <input id="actContainer" type="text" class="ro" value="${bookOrderQuery.cntContainer}" readonly="readonly"/>
					    <a id="editCnt" href="javascript:editCnt('01');" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-mini-edit'"></a>
					</td>
					</s:if>
					<s:if test="%{bookOrderQuery.orderShipment == \"02\"}">
					<td>SAP总运费:</td>
					<td><input id="planContainer" type="text" class="ro" value="${bookOrderQuery.container}" readonly="readonly"/></td>
					<td>实际总运费:</td>
					<td>
					    <input id="actContainer" type="text" class="ro" value="${bookOrderQuery.cntContainer}" readonly="readonly"/>
					    <a id="editCnt" href="javascript:editCnt('02');" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-mini-edit'"></a>
					</td>
					</s:if>
					<s:if test="%{bookOrderQuery.orderShipment == \"02\"}">
					<td>提货园区:</td>
					<td><input name="pickUpArea" type="text" class="ro" /></td>
					</s:if>
					<s:if test="%{bookOrderQuery.orderShipment == \"01\"}">
					<td></td><td></td>
					</s:if>
				</tr>
				<tr>
					<td height="65">装箱/订舱说明:</td>
					<td colspan="3"><textarea style="height: 60px; width: 494px;" class="ro" readonly="readonly">${bookOrderQuery.bookComments}</textarea></td>
					<td>提单用货物描述:</td>
					<td colspan="3"><textarea style="height: 60px; width: 494px;" class="ro" readonly="readonly">${bookOrderQuery.bookGetComments}</textarea></td>
				</tr>
			</table>
	     </form>
    </div>
	<div data-options="region:'center'" style="height: 200px;">
        <table id="cabinOrder"></table>
	</div>
    <div data-options="region:'south',split:false" style="height:30px; text-align: right;">
        <div><a href="#" class="easyui-linkbutton" onclick="javascript:cabinAgent();" data-options="iconCls:'icon-save'">确认</a></div>
    </div>  
    
    
    
    <!-- 船公司下拉选信息 -->
	<div id="_VENDOR">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">货代公司编号：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">货代公司名称：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询" onclick="_VENDORMY()" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置" onclick="_VENDORMYCLEAN()" />
				</div>
			</div>
		</div>
	</div>
    
</body>
</html>
