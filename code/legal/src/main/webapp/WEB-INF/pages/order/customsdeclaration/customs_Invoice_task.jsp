<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<style>
textarea{
  width:100%;
  height:50px;
  border:0px;
}
input{
  border-style:none;
  border-bottom-style: solid;
  border-color: black;
  /*  border-bottom-style:solid;
   border-top-style:none;
   border-left-style:none;
   border-right-style:none;  */
   border-width: 1px;
}
</style>
<script type="text/javascript" charset="utf-8">
var datagrid_bookOrderItem;
 $(function() {
	 //$('#datagrid_bookOrderItem').datagrid('getPanel').removeClass('lines-both lines-no lines-right lines-bottom').addClass('border:3px solid');
	 datagrid_bookOrderItem= $('#datagrid_bookOrderItem').datagrid({
		 //url : '${dynamicURL}/bookorder/cabinBookAction!bookDataGrid.do?bookCode=www0', 
		//title : '订舱明细表列表',
		iconCls : 'icon-save',
		rownumbers : true,
		pagePosition : 'bottom',
		pageSize : 6,
		pageList : [ 6,20,50,100,200],
		fit : true,
		fitColumns : true,
		nowrap : false,
		border : false,
		showFooter: true,
		onDblClickRow:onClickRow,
	 	columns : [ [ 
		 {
			field : 'orderCode',
			title : 'Marks',
			align : 'center',
			sortable : true,
			width : 60
		},  {
			field : 'descriptionGoods',
			title : 'Description of Goods',
			align : 'center',
			sortable : true,
			width:120
		}, {
			field : 'prodQuantity',
			title : 'Quantity',
			align : 'center',
			sortable : true,
			width : 100
		}, {
			field : 'currencyPrice',
			title : 'Price',
			align : 'center',
			sortable : true,
			width:120,
			editor:{type:'numberbox',options:{precision:2}},
			formatter:function(value,row,index){
				return row.currency+"     "+row.currencyPrice;
			}
			
		},{
			field : 'currencyAmount',
			title : 'Amount',
			align : 'center',
			sortable : true,
			width : 160,
			editor:{type:'numberbox',options:{precision:2}},
			formatter:function(value,row,index){
				return row.currency+"     "+row.currencyAmount;
			}
		} ]] 
	});
	 $('#orderCodeId').val('${orderCode}');
	 _search();
});
 
 function _search(){
	 var orderCode=document.getElementById('orderCodeId').value;
	 if(orderCode!=null && orderCode!=''){
	 	findBookCode();
	 }
	 findShipPaperCode();
	 var orderType=document.getElementById('orderType').value;
	 var bookCode=document.getElementById('bookCode').value;
	 $.ajax({
	 		url : '${dynamicURL}/custorder/custOrderAction!searchInvoice.do',
	 		  data : {
	 			 orderCode:orderCode
	 		}, 
	 		dataType : 'json',
	 		cache : false,
	 		success : function(response) {
		        $("#searchInvoice").form('clear');
				$("#searchInvoice").form('load', response);
	 		}
	 	});
		 datagrid_bookOrderItem= $('#datagrid_bookOrderItem').datagrid({
			 onSelect: function(rowIndex, rowData){
    			 return rowIndex;
    		 },
			 url : '${dynamicURL}/custorder/custOrderAction!searchDetail.do?orderCode='+orderCode+'&bookCode='+bookCode,
			 toolbar : [{text : '删除行记录',
					iconCls : 'icon-remove',
					handler : function() {
						deleteRows();
					}
				}, '-',{text : '保存行记录',
					iconCls : 'icon-save',
					handler : function() {
						saveRows();
					}
				}, '-',{text : '回退',
					iconCls : 'icon-save',
					handler : function() {
						rollBack();
					}
				}, '-'] 
		 });
 }
 
 function deleteRows(){
	 var rows = datagrid_bookOrderItem.datagrid('getSelections');
	  for( var i = 0; i < rows.length; i++){
 		  var index = datagrid_bookOrderItem.datagrid('getRowIndex',rows[i]);//获取某行的行号
 		  datagrid_bookOrderItem.datagrid('deleteRow',index); //通过行号移除该行
	 } 
 }
 function saveRows(){
	 endEditing();
	 var rows = datagrid_bookOrderItem.datagrid('getRows');
	 var footerRows= datagrid_bookOrderItem.datagrid('getFooterRows');
	 var total=footerRows[0].currencyAmount;
	 var packed=footerRows[1].descriptionGoods;
	 //alert(total+":"+packed);
	 for(var i = 0; i < rows.length; i++){
		 for(var m in rows[i]){
			 if(rows[i][m]==null){
				 rows[i][m]="";
			 } 
			 //alert(rows[i][m]);
		 }
		rows[i].pager="";
	 }
	 var jsonStr = JSON.stringify(rows);
	 //alert(jsonStr);
	 $.ajax({
			url : '${dynamicURL}/actcustinvoice/actCustInvoiceAction!add.do',
			type:"post",
			data : {
				custInvoice : jsonStr,
				total : total,
				packed : packed
			},
			success : function(response) {
				$("#datagrid_bookOrderItem").datagrid('load');
				$("#datagrid_bookOrderItem").datagrid('unselectAll');
				$.messager.show({
					title : '提示',
					msg : '保存行记录成功'
				});
			}
		});
 }
 
 function print(){
	
	 /* $('#datagrid_bookOrderItem').datagrid({
		 pagination : false
	 }); */
	 var printObj = $("#printBody").clone(true);
	 printObj.find("tr#datagridTr").height("auto");
	 var count = lodopPrint(gridToTable(printObj));
 }
 
 var editIndex = undefined;  
 function endEditing(){  
     if (editIndex == undefined){return true}  
     if ($('#datagrid_bookOrderItem').datagrid('validateRow', editIndex)){  
         $('#datagrid_bookOrderItem').datagrid('endEdit', editIndex);  
         editIndex = undefined;  
         return true;  
     } else {  
         return false;  
     }  
 }  
 function onClickRow(index){  
	 var orderType=document.getElementById('orderType').value;
     /* if(orderType=='bz'||orderType=='hg'){
    	 return false;
     } */
	 if (editIndex != index){  
         if (endEditing()){  
             $('#datagrid_bookOrderItem').datagrid('selectRow', index)  
                     .datagrid('beginEdit', index);  
             editIndex = index;  
             $('#datagrid_bookOrderItem').datagrid('unselectAll');
         } else {  
             $('#datagrid_bookOrderItem').datagrid('selectRow', editIndex);        
         }  
     }  
 }  
 function rollBack(){
	 $.ajax({
	 		url : '${dynamicURL}/custorder/custOrderAction!rollBack.do',
	 		  data : {
	 			 bookCode:$("#bookCode").val()
	 		}, 
	 		dataType : 'json',
	 		cache : false,
	 		success : function(response) {
	 			$("#datagrid_bookOrderItem").datagrid('load');
				$("#datagrid_bookOrderItem").datagrid('unselectAll');
				//$("#searchInvoice").find('input,textarea').attr("readonly", true);
				$.messager.show({
					title : '提示',
					msg : '回退完成'
				});
	 		}
	 	});
 }
 //获取订舱编号
 function findBookCode(){
	 var orderCode=document.getElementById('orderCodeId').value;
	 $.ajax({
	 		url : '${dynamicURL}/custorder/custOrderAction!findBookCode.do',
	 		  data : {
	 			 orderCode:orderCode
	 		}, 
	 		dataType : 'json',
	 		async:false,
	 		cache : false,
	 		success : function(response) {
	 			$("#bookCode").val(response.msg);
	 		}
	 	});
 }
//获取抬头
 function findShipPaperCode(){
	 var orderCode=document.getElementById('orderCodeId').value;
	 if(orderCode==null || orderCode==''){
		 return;
	 }
	 $.ajax({
	 		url : '${dynamicURL}/custorder/custOrderAction!findShipPaperCode.do',
	 		async:false,
	 		  data : {
	 			 orderCode:orderCode
	 		}, 
	 		dataType : 'json',
	 		cache : false,
	 		success : function(response) {
	 			$("#shipPaperCode").text(response.msg);
	 		}
	 	});
 }
 //确认发票
 function updateAcceptFlag(){
	 $.ajax({
	 		url : '${dynamicURL}/custorder/custOrderAction!updateAcceptFlag.do',
	 		async:false,
	 		  data : {
	 			 bookCode:$("#bookCode").val()
	 		}, 
	 		dataType : 'json',
	 		cache : false,
	 		success : function(response) {
		 			$.messager.show({
						title : '提示',
						msg : '确认完成'
					});
	 		}
	 	});
 }
</script>
</head>
<body class="easyui-layout zoc">
     <div  region="north" border="false" class="zoc" title="" collapsed="false"  style="height: 80px;overflow: auto;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc">
				<span>综合通知单：</span>
			</div>
			<div class="oneline">
				<div class="item25">
					<div class="itemleft60">订单号：</div>
					<div class="righttext">
						<input name="orderCode" id="orderCodeId" onblur="findBookCode()" type="text" value=""/>
					</div>
				</div>
				<div class="item25">
					<div class="itemleft60">订舱号：</div>
					<div class="righttext">
						<input name="bookCode" id="bookCode" readonly="readonly" type="text" value=""/>
					</div>
				</div>
				<div class="item25 lastitem">
					<div class="itemleft80">发票类型：</div>
						<div class="righttext">
						  <select name="orderType" id="orderType" style="width:140px" >
						    <option value="bz">标准订单</option>
						    <option value="hg">合并报关订单</option>
						    <option value="sj">散件订单</option>
						    <option value="bj">备件订单</option>
						  </select>
						</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item100 lastitem">
					<div class="oprationbutt">
						<input type="button" onclick="_search()" value="查询" />
						<input type="button" onclick="updateAcceptFlag()" value="发票确认" />
						<input type="button" onclick="cleanSearch()" value="取消" />
						<input type="button" onclick="print()" value="打印" />
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center" border="false" class="zoc" title="" collapsed="false"  style="height: 600px;overflow: auto;" align="center" id="printBody">
		<div class="part_zoc zoc" style="width: 700px;">
		<form id="searchInvoice" method="post">
		<table id="tableHeader" style="border-collapse:collapse;">
			<tr>
				<td style="border-style: solid; border-width: 1px">
					<a href="#"><img src="${staticURL}/style/images/logo_login.png" style="height:90px;width:200px"/></a>
					<!-- <textarea name="shipperMan" class="zoc" readonly="readonly" style="resize:none;overflow:hidden"></textarea> -->
				</td>
				<td style="width: 200px"></td>
				<td style="border-style: solid; border-width: 1px">
					<div  id="shipPaperCode" class="zoc" style="overflow:hidden;width: 300px;height:73px"></div>
				</td>
			</tr>
			<tr>
			    <td colspan="3"  align="center" style="height:70px;width:200px;font-size:30px">INVOICE</td>
			</tr>
			<tr>
			  <td colspan="3">
				    <table style="border-collapse:collapse;" style="border-style: solid ;border-width:0px;width:100%">
					    <tr>
							 <td align="right" style="width: 100px" >F:
							 </td>
							 <td colspan="5" align="left" >
							     <input name="currencyConditionFwf" type="text" readonly="readonly" class="zoc" style="width:100px;border-style:dotted;" ></input>
							 </td>
						</tr>
						<tr>
							 <td align="right" >I:
							 </td>
							 <td colspan="5" align="left" >
							    <input name="currencyConditionFfi"  type="text" readonly="readonly" class="zoc" style="width:100px;border-style:dotted;"></input>
							 </td>
						</tr>
						<tr>
						    <td colspan="6" style="height:30px"></td>
						</tr>
						<tr>
						     <td align="right" >L/C NO:</td>
						     <td align="left"  >
							    <input name="payCode" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
							 <td colspan="2" ></td>
							 <td align="right">INVOICE NO:</td>
						     <td align="left" >
							    <input name="invoiceNum" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
						</tr>
						<tr>
						     <td align="right">P/O NO:</td>
						     <td align="left"  >
							    <input name="orderPoCode" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
							 <td align="right" >S/C NO:</td>
						     <td align="left"  >
							    <input name="contractCode" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
							 <td align="right">DATE:</td>
						     <td align="left"  >
							    <input name="orderShipDate" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
						</tr>
						<tr>
						     <td align="right">Ship per s.s:</td>
						     <td align="left"  >
							    <input name="" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
							 <td align="right" >FROM:</td>
						     <td align="left"  >
							    <input name="portStartCode" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
							 <td align="right">TO:</td>
						     <td align="left"  >
							    <input name="portEndCode" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
						</tr>
						<tr>
						      <td></td>
						      <td align="right" >For accountand risk of messrs.</td>
						      <td colspan="4" align="left">
						         <input name="customerName" type="text" readonly="readonly" class="zoc" style="width:400px"></input>
						      </td>
						</tr>
						<!-- <tr>
						     <td colspan="6">
						        <input name="" type="text" readonly="readonly" class="zoc" style="width:1200px"></input>
						     </td>
						</tr>
						<tr>
						     <td colspan="6">
						        <input name="" type="text" readonly="readonly" class="zoc" style="width:1200px"></input>
						     </td>
						</tr> -->
					</table>
			  </td>
			</tr>
			<tr>
			  <td colspan="3" style="height:30px;"></td>
			</tr>
			<tr style="height: 360px;" id="datagridTr">
				<td colspan="3"   style="border-bottom: 1px solid #A4B5C2;border-top: 1px solid #A4B5C2;">
				    <table id="datagrid_bookOrderItem" class="easyui-datagrid">
				    </table>
				</td>
			</tr> 
			<!-- <tr>
			 <td align="right" colspan="2">OTAL PACKED IN  订舱总件数 CTNS</td>
			 <td>
			    <input name="" type="text" readonly="readonly" class="zoc" ></input>
			 </td>
			 <td></td>
			</tr> -->
			<tr>
			 <td colspan="3" style="height:30px"></td>
			</tr>
		</table>
		</form>
		</div>
	</div> 
</body>
</html>