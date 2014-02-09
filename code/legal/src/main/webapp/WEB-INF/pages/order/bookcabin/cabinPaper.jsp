<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订舱单</title>

<jsp:include page="/common/common_js.jsp"></jsp:include>

<script type="text/javascript">
function printPreview(){
	if( "${mulit}" == null || "${mulit}" == "" ){
		var printBody = $("body").clone();
		printBody = gridToTable(printBody);
		printBody.find(".buttons").remove();
		lodopPrint(printBody);
		setTimeout(function(){parent.HROS.window.close(window.currentappid);},0);	
	}
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
	    height: 70px; 
	    border: 1px solid black;
	}
	
	#header .fh{
	    float: left;
 	    height: 70px;
	    border-right: 1px solid black; 
	}
	.bbfm{
	    float: left;
	    height: 28px;
	    line-height: 28px;
	    margin-right: 10px;
	    border-bottom: 1px dotted black;
	}
	.bbf{
	    float: left;
	    height: 28px;
	    line-height: 28px;
	    border-bottom: 1px dotted black;
	}
	/*******************DataGrid CSS******************/
 	#items td{
 		text-align: center;
 	}
 	.bts{
 		border:0px;
 	    border-top: 2px solid black;
 	}
 	
 	.brd{
 		border-right:1px dotted black;
 	}
	/*******************DataGrid CSS******************/
</style>

</head>
<body onload="javascript:printPreview();">

<div class="main" style="width: 980px;">
    <div id="header">
        <div class="fh" style="width:200px; text-align: center; line-height: 60px;">
            <img src="${staticURL}/style/images/logo_login.png"/>
        </div>
        <div class="fh" style="width:560px; text-align: center; line-height: 60px;">
            <b style="font-size: 38px">订舱单</b>
        </div>
        <div class="fh" style="width: 216px; float: right; border: 0px;">
            <div style="height: 23px; width: 216px; border-bottom: 1px solid black; line-height: 23px;">表号：</div>
            <div style="height: 23px; width: 216px; border-bottom: 1px solid black; line-height: 23px;">单号：${cabinPaper.BOOK_CODE}</div>
            <div style="height: 23px; width: 216px; line-height: 23px;">打印日期：${cabinPaper.CURRENT_DATE}</div>
        </div>
    </div>
    <hr>
    <!-- 订单基本信息 -->
	<div style="width: 100%; height: 360px;">
        <!-- 订单基本信息左侧  开始 -->
		<div style="float: left; width: 450px;">
			<div style="height: 115px;">
				<div>Shipper（发货人）</div>
				<div class="textarea">${cabinPaper.BOOK_SEND_MAN}</div>
			</div>
			<div style="height: 115px;">
				<div>Consignee（收货人）</div>
				<div class="textarea">${cabinPaper.BOOK_RECEIVE_MAN}</div>
			</div>
			<div style="height: 115px;">
				<div>Notify（通知人）</div>
				<div class="textarea">${cabinPaper.BOOK_NOTIFY_MAN}</div>
			</div>
		</div>
        <!-- 订单基本信息左侧  结束 -->
		<!-- 订单基础信息右侧  开始-->
		<div style="float: right; width: 520px;">
			<div style="height: 26px;">
				<div class="bbfm" style="width: 90px;">B/L(提单号):</div>
				<div class="bbf" style="width: 420px;">${cabinPaper.BILL_NUM}&nbsp;</div>
			</div>
			<div style="height: 26px;">
				<div class="bbfm" style="width: 110px;">inv.no(发票号):</div>
				<div class="bbf" style="width: 400px;">${cabinPaper.INVOICE_NUM}&nbsp;</div>
			</div>
			<div style="height: 26px;">
				<div class="bbfm" style="width: 140px;">L/C NO.(信用证号):</div>
				<div class="bbf" style="width: 370px;">${cabinPaper.LC_NUM}&nbsp;</div>
			</div>
			<div style="height: 26px;">
				<div class="bbfm" style="width: 200px;">frt.co.,(船公司或货代公司):</div>
				<div class="bbf" style="width: 310px;">${cabinPaper.VENDOR_NAME_EN}</div>
			</div>
			<div style="height: 26px;">
				<div style="float: left; width: 300px;">
					<div class="bbfm" style="width: 140px;">pay way(付款方式):</div>
					<div class="bbf" style="width: 140px;">${cabinPaper.ORDER_PAYMENT_METHOD_NAME}</div>
				</div>
				<div style="float: left; width: 220px;">
					<div class="bbfm" style="width: 140px;">bar.gain(成交方式):</div>
					<div class="bbf" style="width: 70px;">${cabinPaper.ORDER_DEAL_TYPE_NAME}</div>
				</div>
			</div>
			<div style="height: 26px;">
				<div class="bbfm" style="width: 180px;">req.(最迟订舱完成时间):</div>
				<div class="bbf" style="width: 330px;">${cabinPaper.PLAN_FINISH_DATE}&nbsp;</div>
			</div>
			<div style="height: 26px;">
				<div class="bbfm" style="width: 170px;">ship date(要求出运期):</div>
				<div class="bbf" style="width: 340px;">${cabinPaper.ORDER_SHIP_DATE}&nbsp;</div>
			</div>
			<div style="height: 26px;">
				<div class="bbfm" style="width: 170px;">cust date(要求到货期):</div>
				<div class="bbf" style="width: 340px;">${cabinPaper.ORDER_CUSTOM_DATE}&nbsp;</div>
			</div>
			<div style="height: 26px;">
				<div class="bbfm" style="width: 130px;">场站/联系人/电话:</div>
				<div class="bbf" style="width: 380px;">${cabinPaper.STATION}/${cabinPaper.CONTACTS_MAN}/${cabinPaper.CONTACTS_PHONE}</div>
			</div>
			<div style="height: 26px;">
				<div style="float: left; width: 290px;">
					<div class="bbfm" style="width: 110px;">type(提单类型):</div>
					<div class="bbf" style="width: 160px;">${cabinPaper.BOOK_GET_TIMES}</div>
				</div>
				<div style="float: left; width: 230px;">
					<div class="bbfm" style="width: 100px;">Country(国家):</div>
					<div class="bbf" style="width: 120px;">${cabinPaper.COUNTRY_NAME}</div>
				</div>
			</div>
			<div style="height: 26px;">
				<div class="bbfm" style="width: 130px;">箱型箱量合计:</div>
				<div class="bbf" style="width: 380px;">${cabinPaper.CONTAINERS}</div>
			</div>
		</div>
		<!-- 订单基础信息右侧  结束-->
	</div>
	<!-- 订单基本信息  -->
	
	<!-- 港口信息 -->
	<div title="gangkou" style="height: 90px;">
		<div style="height: 20px;">
			<div style="width: 300px; float: left;">Ocean Vessel (船名)</div>
			<div style="width: 150px; float: left;">Voy.No. (航次)</div>
			<div style="width: 300px; float: left;">Port Of Loading (装货港)</div>
		</div>
		<div style="height: 20px; border-bottom: 2px solid black;">
			<div style="width: 300px; height:24px; float: left;">${cabinPaper.VESSEL}</div>
			<div style="width: 150px; height:24px; float: left;">${cabinPaper.VOYNO}</div>
			<div style="width: 300px; height:24px; float: left;">${cabinPaper.PORT_START}</div>
		</div>
		<div style="height: 20px;">
			<div style="width: 260px; float: left;">Port Of Dischange (卸货港)</div>
			<div style="width: 260px; float: left;">Place Of Delivery (交货地点)</div>
			<div style="width: 460px; float: left;">Final Destination for the Merchant's Reference (目的地)</div>
		</div>
		<div style="height: 20px;">
			<div style="width: 260px; height:24px; float: left;">${cabinPaper.SHIP_DOWN_PORT}</div>
			<div style="width: 260px; height:24px; float: left;">${cabinPaper.PORT_END}</div>
			<div style="width: 460px; height:24px; float: left;">${cabinPaper.SHIP_DESTINATION}</div>
		</div>
	</div>
	<!-- 港口信息 -->
	<!-- 订单明细 -->
	<div id="items">
	    <table style="font-size: 12px;width: 100%; border-collapse: collapse;" cellpadding="0px">
			<tbody>
				<tr class="bts" style="height: 18px; line-height: 18px;">
					<td class="brd" style="width: 84px;"><span>order no.<br>订单号</span></td>
					<td class="brd" style="width: 114px;"><span>department<br>生产事业部</span></td>
					<td class="brd" style="width: 80px;"><span>hs code<br>HS编码</span></td>
					<td class="brd" style="width: 94px;"><span>Prod code<br>产品型号</span></td>
					<td class="brd" style="width: 90px;"><span>No. of p'kgs<br>件数</span></td>
					<td class="brd" style="width: 90px;"><span>Gross Weight<br>毛重(公斤)</span></td>
					<td class="brd" style="width: 90px;"><span>Measurement<br>尺码(立方米)</span></td>
					<td class="brd" style="width: 135px;"><span>Marks<br>唛头</span></td>
					<td style="width: 140px;"><span>Description of Goods<br>包装种类与货描</span></td>
				</tr>
				<s:iterator value="cabinPaper.items.rows" id="row">
					<tr style="height: 24px; line-height: 24px;">
						<td class="brd">${ORDER_CODE}</td>
						<td class="brd">${DEPT_NAME_CN}</td>
						<td class="brd">${HS_CODE}</td>
						<td class="brd">${CUSTOMER_MODEL}</td>
						<td class="brd">${GOODS_COUNT} CTNS</td>
						<td class="brd">${GOODS_GROSS_WEIGHT}</td>
						<td class="brd">${GOODS_MESUREMENT}</td>
						<td class="brd">${MARKS}</td>
						<td>${GOODS_DESC}</td>
					</tr>
				</s:iterator>
				<s:iterator value="cabinPaper.items.footer" id="row">
					<tr class="bts" >
						<td></td>
						<td></td>
						<td></td>
						<td style="text-align: right;">合计:</td>
						<td>${GOODS_COUNT}</td>
						<td>${GOODS_GROSS_WEIGHT}</td>
						<td>${GOODS_MESUREMENT}</td>
						<td></td>
						<td></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</div>
	<!-- 订单明细 -->
	<br>
	<div style="height: 85px;">
	    <div>客户PO：</div>
	    <div style="width: 978px; height: 50px; border: 1px dotted black;">${cabinPaper.BOOK_PO_CODE}</div>
	</div>
	<div style="height: 85px;">
	    <div>注意事项：</div>
	    <div style="width: 978px; height: 50px; border: 1px dotted black;">${cabinPaper.BOOK_GET_COMMENTS}</div>
	</div>
	<div style="height: 85px;">
	    <div>订舱说明：</div>
	    <div style="width: 978px; height: 50px; border: 1px dotted black;">${cabinPaper.BOOK_COMMENTS}</div>
	</div>
	<hr>
	<div style="height: 20px;line-height: 20px;">
	    <div style="width: 25%; float: left;">
	        <label>订单经理：${cabinPaper.ORDER_EXEC_MANAGER_NAME}</label>
	    </div>
	    <div style="width: 25%; float: left;">
	        <label>产品经理：${cabinPaper.ORDER_PROD_MANAGER_NAME}</label>
	    </div>
	    <div style="width: 25%; float: left;">
	        <label>单证经理：${cabinPaper.ORDER_DOC_MANAGER_NAME}</label>
	    </div>
	    <div style="width: 25%; float: left;">
	        <label>订舱经理：${cabinPaper.ORDER_TRANS_MANAGER_NAME}</label>
	    </div>
	</div>
	<br>
    <div class="buttons" style="text-align: right;">
        <a href="#" class="easyui-linkbutton" onclick="javascript:printPreview();" data-options="iconCls:'icon-print'">打印</a>
    </div>
</div>
</body>
</html>