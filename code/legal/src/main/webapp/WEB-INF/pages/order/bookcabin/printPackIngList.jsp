<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>箱单发票</title>

<jsp:include page="/common/common_js.jsp"></jsp:include>

<script type="text/javascript">
var itemGrid;
$(document).ready(function(){
	itemGrid = $("#itemGrid").datagrid({
		fit : true,
		border : false,
		showFooter : true,
		autoRowHeight : true,
		
        data : ${packingListPaper.items},
        fitColumns : true,
        nowrap : true,
		columns : [ [ 
		 	{ field : 'orderCode', title : 'MARKS',width:100,rowspan:2,align : 'center'},
		    { title : 'DESCRIPTION OF GOODS',width:280,colspan:4},
	     	{ field : 'prodQuantity', title : 'QUANTITY',align : 'center',width:50,rowspan:2,
		    	formatter:function(value,row,index){
		    		if(row.prodQuantity==0){
		    			return '';
		    		}
	     			return row.prodQuantity+" "+row.unit;
	     	}} , 
	     	{ field : 'netWeight', title : "NET WEIGHT",align : 'center',width:60,rowspan:2,
	     		formatter:function(value,row,index){
	     			if(row.netWeight>=0){
	     				return Number(row.netWeight).toFixed(2)+' KGS';
	     			}else{
	     				return '';
	     			}
	     	}} , 
	     	{ field : 'grossWeight', title : 'GROSS WEIGHT',align : 'center',width:60, rowspan:2,
	     		formatter:function(value,row,index){
	     			if(row.grossWeight>=0){
	     				return Number(row.grossWeight).toFixed(2)+' KGS';
	     			}else{
	     				return '';
	     			}
	     			
	     	}}
	    ],[
			{field : 'haierProdDesc',title:'GOODS DESC',align : 'center',editor:'text',width:70,
				formatter : function(value, row, index) {
					if(row.prodModel==null || row.prodModel==""){
						return row.haierProdDesc;
					}
						return row.prodModel;
				}},
			{field : 'haierModel',title:'HAERI MODEL',align : 'center',editor:'text',width:70,
					formatter:function(value,row,index){return "<div style='word-break:break-all'>"+row.haierModel+"</div>"}
			},
			{field : 'customerModel',title:'CUSTOMER MODEL',align : 'center',editor:'text',width:70,
				formatter:function(value,row,index){return "<div style='word-break:break-all'>"+row.customerModel+"</div>"}	
			},
			{field : 'simpleCode',title:'SIMPLE CODE',align : 'center',editor:'text',width:70}
			
			] ],
	});
});

function printPreview(){
	//记录打印
	$.ajax({
					url : '${dynamicURL}/bookorder/packingListAction!updatePrintFlag.do',
					async : false,
					data : {
						bookCode : ${packingListPaper.bookCode}
					},
					dataType : 'json',
					cache : false,
					success : function(response) {
					}
				});
	var printBody = $("body").clone();
	printBody = gridToTable(printBody);
	printBody.find(".printTable tr").css({"height":"40px"});
	printBody.find(".printTable tr").each(function(i){
		if(i>1){
			$(this).find("td").each(function(j){
				if(j>4){
					$(this).css({"textAlign": "right"});					
				}				
			})
		}
	});
	printBody.find(".buttons").remove();
	lodopPrintFullWidth(printBody);
}
</script>


<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	color: black;
	font-size: 14px;
}

div {
	word-wrap: break-word;
}

hr {
	margin-top: 5px;
	margin-bottom: 10px;
}

.textarea {
	height: 90px;
	width: 430px;
	border: 1px dotted black;
}

.main {
	margin: 5px auto 0px auto;
	overflow: hidden;
}

#header {
	height: 70px;
	/* border: 1px solid black; */
}

#header .fh {
	float: left;
	height: 90px;
	/* border-right: 1px solid black; */
}

.bbfm {
	float: left;
	height: 28px;
	line-height: 28px;
	margin-right: 10px;
	/* border-bottom: 1px dotted black; */
}

.bbf {
	float: left;
	height: 28px;
	line-height: 28px;
	border-bottom: 1px dotted black;
}

.bbff {
	float: left;
	height: 28px;
	line-height: 28px;
	border-bottom: 0px;
}
/*******************DataGrid CSS******************/
.datagrid-header {
	border: 0px;
	border-top: 2px solid black;
}

.datagrid-header td {
	border-right: 1px dotted black;
}

.datagrid-body td {
	border: 0px;
	word-wrap: break-word;
	border-right: 1px dotted black;
}

.datagrid-footer {
	border-top: 2px solid black;
}

.datagrid-footer td {
	border: 0px;
}
/*******************DataGrid CSS******************/
</style>

</head>
<body>
<div style="width: 980px; height: 40px">
</div>
	<div class="main" style="width: 980px;">
		<div id="header">
			<div class="fh"
				style="width: 200px; text-align: center; line-height: 60px;">
				<img src="${staticURL}/style/images/logo_login.png" />
			</div>
			<div class="fh"
				style="width: 430px; text-align: center; line-height: 60px;">
				<b style="font-size: 38px">PACKING LIST</b>
			</div>
			<div class="fh" style="width: 316px; float: left; border: 0px;">
				<div style="width: 300px;"></div>
			</div>
		</div>
		<hr>
		<!-- 订单基本信息 -->
		<div style="width: 100%; height: 150px;">
			<!-- 订单基础信息  开始-->
			<div style="float: left; width: 970px;">
				<div style="height: 28px;"></div>
				<div style="height: 28px;"></div>
				<div style="height: 28px;">
					<div style="float: left; width: 646px;">
						<div class="bbfm" style="width: 150px;">SHIPPING MARKS:</div>
						<div class="bbff" style="width: 150px;">&nbsp;</div>
					</div>
					<div style="float: left; width: 323px;">
						<div class="bbfm" style="width: 90px;">NO:</div>
						<div class="bbf" style="width: 190px;">${packingListPaper.invoiceNum}&nbsp;</div>
					</div>
				</div>
				<div style="height: 28px;">
					<div style="float: left; width: 646px;">
						<div contenteditable="true"  style="width: 600px;border: 1px dotted black;min-height: 28px;">
							
						</div>
					</div>
					<div style="float: left; width: 323px;">
						<div class="bbfm" style="width: 90px;">DATE:</div>
						<div class="bbf" style="width: 190px;">
							${packingListPaper.orderShipStringDate}
							&nbsp;
						</div>
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
		<div style="width: 100%; height: 150px;">
			<div style="float: left; width: 970px;">
				<div style="height: 28px;"></div>
				<div style="height: 28px;">
					<div style="float: left; width: 323px;">
						<div class="bbfm" style="width: 90px;"></div>
						<div class="bbff" style="width: 220px;"></div>
					</div>
					<div style="float: left; width: 323px;">
						<div class="bbfm" style="width: 90px;">SHIPPED ON:</div>
						<div class="bbf" style="width: 220px;">${packingListPaper.orderShipStringDate}&nbsp;</div>
					</div>
					<div style="float: left; width: 323px;">
						<div class="bbfm" style="width: 90px;"></div>
						<div style="width: 190px;float: left;height: 28px;line-height: 28px;border-bottom: 1px dotted white;">&nbsp;</div>
					</div>
				</div>
				<div style="height: 28px;">
					<div style="float: left; width: 323px;">
						<div class="bbfm" style="width: 60px;"></div>
						<div class="bbff" style="width: 220px;"></div>
					</div>
					<div style="float: left; width: 323px;">
						<div class="bbfm" style="width: 90px;">SHIPPED BY:</div>
						<div class="bbf" style="width: 220px;">${packingListPaper.itemNameCn}</div>
					</div>
					<div style="float: left; width: 323px;">
						<div class="bbfm" style="width: 90px;"></div>
						<div style="width: 190px;float: left;height: 28px;line-height: 28px;border-bottom: 1px dotted white;">&nbsp;</div>
					</div>
				</div>
				<div style="height: 28px;">
					<div style="float: left; width: 323px;">
						<div class="bbfm" style="width: 60px;"></div>
						<div class="bbff" style="width: 220px;"></div>
					</div>
					<div style="float: left; width: 323px;">
						<div class="bbfm" style="width: 90px;">PO NO.:</div>
						<div class="bbf" style="width: 220px;">${packingListPaper.orderPoCode}</div>
					</div>
					<div style="float: left; width: 323px;">
						<div class="bbfm" style="width: 90px;"></div>
						<div class="bbff" style="width: 190px;">&nbsp;</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 订单明细 -->
		<br>
		<div class="buttons" style="text-align: right;">
			<a href="#" class="easyui-linkbutton"
				onclick="javascript:printPreview();"
				data-options="iconCls:'icon-print'">打印</a>
		</div>
	</div>
</body>
</html>