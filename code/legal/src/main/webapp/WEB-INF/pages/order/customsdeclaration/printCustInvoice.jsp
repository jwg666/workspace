<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>报关发票</title>

<jsp:include page="/common/common_js.jsp"></jsp:include>

<script type="text/javascript">
var itemGrid;
$(document).ready(function(){
	itemGrid = $("#itemGrid").datagrid({
		fit : true,
		border : false,
		showFooter : true,
		autoRowHeight : true,
        data : ${custInvoicePaper.items},
        fitColumns : true,
        nowrap : true,
		columns : [ [ 
		 	{ field : 'orderCode', title : 'MARKS',rowspan:2,align : 'center',width:100},
		    { title : 'DESCRIPTION OF GOODS',colspan:4,align : 'center',width:120},
	     	{ field : 'prodQuantity', title : 'QUANTITY',rowspan:2,align : 'center',width:100,
		    	formatter:function(value,row,index){
		    		if(row.prodQuantity==0){
		    			return '';
		    		}
	     			return row.prodQuantity+"    "+row.unit;
	     	}} , 
	     	{ field : 'currencyPrice', title : "PRICE",rowspan:2,align : 'center',width:100,
	     		formatter:function(value,row,index){
	     			if(row.currencyPrice>0){
	     				return "<div style='white-space: nowrap;'>"+row.currency+"     "+Number(row.currencyPrice).toFixed(2)+"</div>";
	     			}

	     			return "<div style='white-space: nowrap;'>"+row.currency+"     "+row.currencyPrice+"</div>";
	     	}} , 
	     	{ field : 'currencyAmount', title : 'AMOUNT',rowspan:2,align : 'center',width:100, 
	     		formatter:function(value,row,index){
	     			if(row.currencyAmount>0){
	     				return "<div style='white-space: nowrap;'>"+row.currency+"     "+Number(row.currencyAmount).toFixed(2)+"</div>";
	     			}
	     			return "<div style='white-space: nowrap;'>"+row.currency+"     "+row.currencyAmount+"</div>";
	     	}}
	    	],[
			{field : 'haierProdDesc',title:'GOODS DESC',align : 'center',editor:'text',width:70},
			{field : 'haierModel',title:'HAERI MODEL',align : 'center',editor:'text',width:70,
				formatter:function(value,row,index){return "<div style='word-break:break-all'>"+row.haierModel+"</div>"}
			},
			{field : 'customerModel',title:'CUSTOMER MODEL',align : 'center',editor:'text',width:70,
				formatter:function(value,row,index){return "<div style='word-break:break-all'>"+row.customerModel+"</div>"}	
			},
			{field : 'simpleCode',title:'SIMPLE CODE',align : 'center',editor:'text',width:70}
			] ]
	});
});

function printPreview(){
	//记录打印
	$.ajax({
				url : '${dynamicURL}/actcustinvoice/actCustInvoiceAction!updatePrintFlag.do',
				async : false,
				data : {
						bookCode : ${custInvoicePaper.items.rows[0].bookCode}
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
				}
		});
	var printBody = $("body").clone();
	printBody = gridToTable(printBody);
	printBody.find(".printTable tr").css({"height":"40px"});
	printBody.find(".buttons").remove();
	lodopPrintFullWidth(printBody);
}
</script>


<style type="text/css">
	body{
	    margin: 0px;
	    padding: 0px;
	    color: black;
	    font-size: 14px;
	}
	div{
	    word-wrap: break-word;
	}
	hr{
	    margin-top: 5px;
	    margin-bottom: 10px;
	}
	.textarea{
	    height: 90px;
	    width: 430px;
	    border: 1px dotted black;
	}
	.main{
	    margin : 5px auto 0px auto;
	    overflow: hidden; 
	}
	
	#header{
	    height: 60px; 
	    /* border: 1px solid black; */
	}
	
	#header .fh{
	    float: left;
 	    height: 70px;
	    /* border-right: 1px solid black;  */
	}
	.bbfm{
	    float: left;
	    height: 28px;
	    line-height: 28px;
	    margin-right: 10px;
	    /* border-bottom: 1px dotted black; */
	}
	.bbf{
	    float: left;
	    height: 28px;
	    line-height: 28px;
	    border-bottom: 1px dotted black;
	}
	.bbff{
	    float: left;
	    height: 28px;
	    line-height: 28px;
	    border-bottom: 0px ; 
	}
	/*******************DataGrid CSS******************/
     .datagrid-header{
         border : 0px;
         border-top: 2px solid black;
     }
    .datagrid-header td{
 		border-right:1px dotted black;
    }
 	.datagrid-body td{
 	    border: 0px;
	    word-wrap: break-word;
 		border-right:1px dotted black;
 	}
 	.datagrid-footer{
 	    border-top: 2px solid black;
 	}
 	.datagrid-footer td{
 	    border : 0px;
 	}
	/*******************DataGrid CSS******************/
</style>

</head>
<body>
<div style="width: 980px;height: 40px;">
</div>
<div class="main" style="width: 980px;">
    <div id="header">
        <div class="fh" style="width:200px; text-align: center; line-height: 60px;">
            <img src="${staticURL}/style/images/logo_login.png"/>
        </div>
        <div class="fh" style="width:430px; text-align: center; line-height: 60px;">
            <b style="font-size: 38px">INVOICE</b>
        </div>
        <div class="fh" style="width: 340px; float: left; border: 0px;">
            <div style="width: 340px;">${custInvoicePaper.shipPaperCode}</div>
        </div>
    </div>
    <hr>
    <!-- 订单基本信息 -->
	<div style="width: 100%; height: 370px;">
		<!-- 订单基础信息  开始-->
		<div style="float: left; width: 970px;">
		<div style="height: 28px;"></div>
		<div style="height: 28px;"></div>
			<div style="height: 28px;">
				<div class="bbfm" style="width: 120px;">F:&nbsp;&nbsp;${custInvoicePaper.custOrderQuery.currencyConditionFwf}</div>
				<div class="bbff" style="width: 840px;"></div>
			</div>
			<div style="height: 28px;float: left;">
				<div class="bbfm" style="width: 120px;">I:&nbsp;&nbsp;${custInvoicePaper.custOrderQuery.currencyConditionFfi}</div>
				<div class="bbff" style="width: 840px;"></div>
			</div>
			<div style="height: 28px;"></div>
			<div style="height: 28px;"></div>
			<div style="height: 28px;">
				<div style="float: left; width: 323px;">
					<div class="bbfm" style="width: 60px;">L/C NO:</div>
					<div class="bbf" style="width: 220px;">${custInvoicePaper.custOrderQuery.payCode}&nbsp;</div>
				</div>
				<div style="float: left; width: 323px;">
					<div class="bbff" style="width: 80px;"></div>
					<div class="bbff" style="width: 200px;">&nbsp;</div>
				</div>
				<div style="float: left; width: 323px;">
					<div class="bbfm" style="width: 90px;">INVOICE NO:</div>
					<div class="bbf" style="width: 190px;">${custInvoicePaper.custOrderQuery.invoiceNum}&nbsp;</div>
				</div>
			</div>
			<div style="height: 28px;">
				<div style="float: left; width: 323px;">
					<div class="bbfm" style="width: 60px;">P/O NO:</div>
					<div class="bbf" style="width: 220px;">${custInvoicePaper.custOrderQuery.orderPoCode}&nbsp;</div>
				</div>
				<div style="float: left; width: 323px;">
					<div class="bbfm" style="width: 80px;">S/C NO:</div>
					<div class="bbf" style="width: 200px;">${custInvoicePaper.custOrderQuery.contractCode}&nbsp;</div>
				</div>
				<div style="float: left; width: 323px;">
					<div class="bbfm" style="width: 90px;">DATE:</div>
					<div class="bbf" style="width: 190px;">${custInvoicePaper.custOrderQuery.orderShipDateStr}&nbsp;</div>
				</div>
			</div>
			<div style="height: 28px;">
				<div style="float: left; width: 323px;">
					<div class="bbfm" style="width: 110px;">SHIP PER S.S:</div>
					<div class="bbf" style="width: 170px;">&nbsp;</div>
				</div>
				<div style="float: left; width: 323px;">
					<div class="bbfm" style="width: 80px;">FROM:</div>
					<div class="bbf" style="width: 200px;">${custInvoicePaper.custOrderQuery.portStartCode}&nbsp;</div>
				</div>
				<div style="float: left; width: 323px;">
					<div class="bbfm" style="width: 90px;">TO:</div>
					<div class="bbf" style="width: 190px;">${custInvoicePaper.custOrderQuery.portEndCode}&nbsp;</div>
				</div>
			</div>
			<div style="height: 28px;">
				<div style="float: left; width: 323px;">
					<div class="bbfm" style="width: 120px;">SETTLEMENT TYPE:</div>
					<div class="bbf" style="width: 170px;">${custInvoicePaper.custOrderQuery.orderSettlementType}&nbsp;</div>
				</div>
				<div style="float: left; width: 323px;">
					<div class="bbff" style="width: 80px;"></div>
					<div class="bbff" style="width: 200px;">&nbsp;</div>
				</div>
				<div style="float: left; width: 323px;">
					<div class="bbff" style="width: 90px;"></div>
					<div class="bbff" style="width: 190px;">&nbsp;</div>
				</div>
			</div>
			<div style="height: 28px;">
				<div style="float: left; width: 970px;">
					<div class="bbfm" style="width: 230px;">FOR ACCOUNTAND RISK OF MESSRS:</div>
					<div class="bbf" style="width: 700px;">${custInvoicePaper.custOrderQuery.customerName}&nbsp;</div>
				</div>
			</div>
			<div style="height: 28px;">
				<div style="float: left; width: 323px;">
					<div class="bbff" style="width: 120px;"></div>
					<div class="bbff" style="width: 170px;">&nbsp;</div>
				</div>
				<div style="float: left; width: 323px;">
					<div class="bbff" style="width: 80px;"></div>
					<div class="bbff" style="width: 200px;">&nbsp;</div>
				</div>
				<div style="float: left; width: 323px;">
					<div class="bbfm" style="width: 90px;">DEAL TYPE:</div>
					<div class="bbf" style="width: 190px;">${custInvoicePaper.custOrderQuery.orderDealType}&nbsp;</div>
				</div>
			</div>
		</div>
		<!-- 订单基础信息右侧  结束-->
	</div>
	<!-- 订单基本信息  -->
	<!-- 订单明细 -->
	<div title="订单明细">
	    <table id="itemGrid"></table>
	</div>
	<!-- 订单明细 -->
	<br>
    <div class="buttons" style="text-align: right;">
        <a href="#" class="easyui-linkbutton" onclick="javascript:printPreview();" data-options="iconCls:'icon-print'">打印</a>
    </div>
</div>
</body>
</html>