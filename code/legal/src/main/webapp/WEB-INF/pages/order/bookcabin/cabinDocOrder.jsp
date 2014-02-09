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

.editAble { 
	position: absolute;
	width: 230px;
	height: 100px;
	margin-top: -10px;
	margin-left: -70px;
	overflow: visible;
}
.basic { 
	resize: none;
	height: 20px;
	width: 150px;
	overflow: hidden;
}
-->
</style>


<script type="text/javascript">
    $(document).ready(function(){
    	var params = "";
        $(${codes}).each(function(i,code){
        	params += "codes=" + code + "&";
        });
    	
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
    	
    	$("#lcView").combogrid({
    		idField:'lcNum',
    	    textField:'lcNum',
    	    editable : false,
    	    required : true,
    	    panelWidth:500,
    	    url : '${dynamicURL}/credit/appendixAction!getAppendixByOrderCode.do?'+params,
    	    frozenColumns : [[
                {field:'lcNum',title:'编码',width:100}, 
   		        {field:'lcDeliverydate',title:'最迟出运期',width:80}, 
    	    ]],
		    columns:[[  
		        {field:'lcShipper',title:'发货人',width:180},  
		        {field:'lcConsignee',title:'收货人',width:180},  
		        {field:'lcNotifyParty',title:'通知人',width:180}, 
		        {field:'lcShippingmark',title:'唛头',width:60}, 
		   ]],
		   onSelect : function( index, row ){
			   $("[name='bookSendMan']").val(row.lcShipper);
			   $("[name='bookReceiveMan']").val(row.lcConsignee);
			   $("[name='bookNotifyMan']").val(row.lcNotifyParty);
			   $("[name='bookGetComments']").val(row.lcDescriptionofgoods);
		   },
		   onRowContextMenu : function(e, index, row){
			   e.preventDefault();
			   window.open("${dynamicURL}/credit/lettercreditAction!openCreditDetail.do?lcNum="+row.lcNum);
		   },
		   onLoadSuccess : function(data){
			   if( data != null && data.rows != null &&data.rows.length > 0 ){
				   $('#btnSure').linkbutton("enable");
			   }
		   }
	    });
    	
    	$("[name='bookReceiveMan'],[name='bookSendMan']").validatebox({ 
	    	required: true,
    		validType: 'length[0,255]'  
    	}).hover( function () {
    		$(this).removeClass("basic");
    		$(this).addClass("editAble");
    	},function () {
    		$(this).removeClass("editAble");
    		$(this).addClass("basic");
    	});
    	
    	$("[name='bookNotifyMan']").validatebox({ 
	    	required: true,
    		validType: 'length[0,400]'  
    	}).hover( function () {
    		$(this).removeClass("basic");
    		$(this).addClass("editAble");
    	},function () {
    		$(this).removeClass("editAble");
    		$(this).addClass("basic");
    	});

    	$("[name='bookGetComments']").validatebox({ 
    		validType: 'length[0,1000]'  
    	});
    });
    
    function cabinDocConfirm(){
    	
    	if( $("[name='cabinForm']").form("validate") ){
        	var params = $("[name='cabinForm']").serialize();
    		$.messager.progress({text:'系统处理中，请稍等...',interval:200});
        	$.ajax({
        		url : '${dynamicURL}/bookorder/cabinDocConfirmAction!cabinDocApply.do',
        		type : 'post',
        		data : params,
        		dataType : 'json',
        		success : function(data){
    				$.messager.progress("close");
    				if( data.success ){
    			    	$.messager.alert("系统提示","操作成功，订舱已进入下一节点！");
    				    parent.window.HROS.window.close(currentappid);
    				    customWindow.reloaddata();
    				}else{
    					$.messager.alert( "系统提示","操作失败，" + data.msg );
    				}
        		}
        	});
    	}
    }
</script>
</head>
<body class="easyui-layout" fit=true style="overflow: hidden;">
	<div data-options="region:'north'" style="height:240px" title="订舱主信息">
	  <form name="cabinForm">
			<table style="width: 100%; height:100%; padding: 5px;">
				<tr style="height: 24px;">
					<td width="80px">订舱号:</td>
					<td width="180px"><input class="ro" name="bookCode" readonly="readonly" value="${bookOrderQuery.bookCode}" /></td>
					<td width="80px">经营主体:</td>
					<td width="180px"><input class="ro" readonly="readonly" value="${bookOrderQuery.operators }" /></td>
					<td width="80px">始发港:</td>
					<td width="180px"><input class="ro" readonly="readonly" value="${bookOrderQuery.portStartNameEn }" /></td>
					<td width="80px">目的港:</td>
					<td width="180px"><input class="ro" readonly="readonly" value="${bookOrderQuery.portEndNameEn }" /></td>
				</tr>
				<tr style="height: 24px;">
					<td>订舱人:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.createdBy }" /></td>
					<td>发货人:</td>
					<td><textarea class="basic" name="bookSendMan">${bookOrderQuery.bookSendMan }</textarea></td>
					<td>收货人:</td>
					<td><textarea class="basic" name="bookReceiveMan">${bookOrderQuery.bookReceiveMan }</textarea></td>
					<td>通知人:</td>
					<td><textarea class="basic" name="bookNotifyMan">${bookOrderQuery.bookNotifyMan }</textarea></td>
				</tr>
				<tr style="height: 24px;">
					<td>成交方式:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.orderDealName }" /></td>
					<td>运输方式:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.orderShipmentName }" /></td>
					<td>运输公司:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.vendorName }" /></td>
					<td>代理公司:</td>
					<td><input class="ro" readonly="readonly" value="${bookOrderQuery.bookAgentName }" /></td>
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
					</td>
					</s:if>
					<s:if test="%{bookOrderQuery.orderShipment == \"02\"}">
					<td>SAP总运费:</td>
					<td><input id="planContainer" type="text" class="ro" value="${bookOrderQuery.container}" readonly="readonly"/></td>
					<td>实际总运费:</td>
					<td>
					    <input id="actContainer" type="text" class="ro" value="${bookOrderQuery.cntContainer}" readonly="readonly"/>
					</td>
					</s:if>
					<td>信用证:</td>
					<td colspan="3">
						<input type="text" id="lcView" name="lcNum" class="ro" value="${bookOrderQuery.lcNum}"/>
					</td>
				</tr>
				<tr>
					<td height="65">装箱/订舱说明:</td>
					<td colspan="3"><textarea style="height: 60px; width: 494px;" class="ro" readonly="readonly">${bookOrderQuery.bookComments}</textarea></td>
					<td>提单用货物描述:</td>
					<td colspan="3"><textarea name="bookGetComments" style="height: 60px; width: 494px;">${bookOrderQuery.bookGetComments}</textarea></td>
				</tr>
			</table>
	     </form>
    </div>
	<div data-options="region:'center'" style="height: 200px;">
        <table id="cabinOrder"></table>
	</div>
    <div data-options="region:'south',split:false" style="height:30px; text-align: right;">
        <div><a id="btnSure" href="#" class="easyui-linkbutton" onclick="javascript:cabinDocConfirm();" data-options="iconCls:'icon-save',disabled:true">确认</a></div>
    </div>  
</body>
</html>
