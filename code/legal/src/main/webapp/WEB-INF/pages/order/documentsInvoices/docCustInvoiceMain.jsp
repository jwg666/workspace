<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
.layout-panel-center input{background-image: url(${staticURL}/style/demo/img/ibg.png);}
</style>
<script type="text/javascript" charset="utf-8">
var datagrid_bookOrderItem;
var custInvoiceAddDialog;
var custInvoiceAddForm;
var showLoadExcelInfoForm;
var showLoadExcelDialog;
var printFlag=true;
var editIndex = undefined;
var editRow;
var datagrid_toolbar;
var invoiceFrom;
var saveFlag;
 $(function() {
		datagrid_toolbar = $('#datagrid_toolbar').datagrid({
			border : false,
			pagination : false,
			toolbar : [{
				text : '保存发票',
				iconCls : 'icon-search',
				handler : function() {
					_saveCustInvoiceList();
				}
			},'-',  {
				text : '打印/导出',
				iconCls : 'icon-edit',
				handler : function() {
					appletPrint();
				}
			}, '-' ]
		});
		 invoiceFrom=$('#invoiceFrom').form({
				url : '${dynamicURL}/documentsInvoices/docCustInvoiceMainAction!saveDocumentsInvoices.do',
				async : false,
				success : function(data) {
							if(saveFlag=='T'){
								//window.open("http://10.135.12.138:7011/report/Report-Guage.do?reportId=c40a3d7b-5625-482d-8657-46c3701f18ae&negoInvoiceNum="+$("#negoInvoiceNum").val());
								window.open("http://hrois.haier.net/report/Report-Guage.do?reportId=c40a3d7b-5625-482d-8657-46c3701f18ae&negoInvoiceNum="+$("#negoInvoiceNum").val());
							}else{
								$.messager.show({
								title : '成功',
								msg : '保存成功！'
								});
							}
							saveFlag='F';
					datagrid_bookOrderItem.datagrid('reload');
				}
			});
	 datagrid_bookOrderItem= $('#datagrid_bookOrderItem').datagrid({
		url : '${dynamicURL}/documentsInvoices/docCustInvoiceDetailAction!datagrid.do?negoInvoiceNum=' + document.getElementById('negoInvoiceNum').value, 
		//title : '订舱明细表列表',
		iconCls : 'icon-save',
		rownumbers : true,
		pagination : true,
		pagePosition : 'bottom',
		pageSize : 30,
		pageList : [ 10,20,30,50,100],
		fit : true,
		fitColumns : true,
		nowrap : true,
		border : false,
		showFooter: true,
		onDblClickRow: onClickRow,
	 	columns : [ [ 
		 {
			field : 'marks',
			title : 'Marks',
			align : 'center',
			sortable : true,
			width : 100,
			editor:{type:'text'},
		},  {
			field : 'orderNum',
			title : 'orderNum',
			align : 'center',
			hidden : true,
			width : 100
		}, {
			field : 'orderPoCode',
			title : 'orderPoCode',
			align : 'center',
			hidden : true,
			width : 100
		},{field : 'descGoods',title:'GOODS DESC',align : 'center',editor:'text',width:70,
			editor : {
				type : 'text'
			},
			formatter : function(value, row, index) {
				return row.descGoods;
			}
		},{
			field : 'customerModel',
			title : 'Description of Goods',
			align : 'center',
			sortable : true,
			width:160,
			editor:{type:'text'},
			formatter:function(value,row,index){
				return row.customerModel;
			}
		}, {
			field : 'quantity',
			title : 'Quantity',
			align : 'center',
			sortable : true,
			width : 100,
			editor:{type:'numberbox'},
			formatter:function(value,row,index){
				if(row.quantity<0){
					return '';
				}
					return row.quantity;
			}
		},{
			field : 'unit',
			title : 'UNIT',
			align : 'center',
			sortable : true,
			width : 60,
			//hidden : true,
			editor:{type:'text'},
			formatter:function(value,row,index){
				return row.unit;
			}
		} , {
			field : 'price',
			title : 'Price',
			align : 'center',
			sortable : true,
			width:100,
			editor:{type:'numberbox',options:{precision:2}},
			formatter:function(value,row,index){
				if(row.price<0){
					return '';
				}
     			return row.currency+"     "+Number(row.price).toFixed(2);
			}
			
		},{
			field : 'amount',
			title : 'Amount',
			align : 'center',
			sortable : true,
			width : 100,
			editor:{type:'numberbox',options:{precision:2}},
			formatter:function(value,row,index){
				if(row.amount<0){
					return '';
				}
				return row.currency+"     "+Number(row.amount).toFixed(2);
			}
		},{
			field : 'packages',
			title : 'Packages',
			align : 'center',
			sortable : true,
			editor : {
				type : 'numberbox',
			},
			width : 100,
			formatter : function(value, row, index) {
     			return row.packages;
			},
		},{
			field : 'packagesUnit',
			title : 'Pack Unit',
			align : 'center',
			sortable : true,
			width : 100,
			editor : {
				type : 'text',
			},
			formatter : function(value, row, index) {
				return row.packagesUnit;
			},
		} ,{
			field : 'printFlag',
			title : 'printFlag',
			align : 'center',
			sortable : true,
			hidden : true,
			formatter : function(value, row, index) {
				return row.printFalg;
			}
		}]],
		toolbar : [{
			text : '新增',
			iconCls : 'icon-add',
			handler : function() {
				add();
			}
		}, '-',{
			text : '删除',
			iconCls : 'icon-remove',
			handler : function() {
				deleteRows();
			}
		}, '-',{text : '回退',
			iconCls : 'icon-save',
			handler : function() {
				rollBack();
			}
		}, '-'],
		onLoadSuccess : function(data) {
			 _search();
		}
	});
		custInvoiceAddForm = $('#custInvoiceAddForm').form({
			url : '${dynamicURL}/documentsInvoices/docCustInvoiceDetailAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid_bookOrderItem.datagrid('reload');
					custInvoiceAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		custInvoiceAddDialog = $('#custInvoiceAddDialog').show().dialog({
			title : '添加报关发票',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					custInvoiceAddForm.submit();
				}
			} ]
		});
});
 
 function _search(){
		 var invoiceNum=document.getElementById('negoInvoiceNum').value;
		 if(invoiceNum!=null && invoiceNum!=''){
			 $.ajax({
			 		url : '${dynamicURL}/documentsInvoices/docCustInvoiceMainAction!searchInvoice.do',
			 		  data : {
			 			 negoInvoiceNum:invoiceNum
			 		}, 
			 		async : false,
			 		dataType : 'json',
			 		cache : false,
			 		success : function(response) {
				        //$("#searchInvoice").form('clear');
						$("#invoiceFrom").form('load', response);
			 		}
			 	});
		 }
 }

//新增
	function add() {
		custInvoiceAddForm.form("clear");
		$("#addNegoInvoiceCode").val($("#negoInvoiceNum").val());
		$('div.validatebox-tip').remove();
		_saveCustInvoiceList();
		custInvoiceAddDialog.dialog('open');
	}
	
 function deleteRows(){
	 if(printFlag){
		 var rows = datagrid_bookOrderItem.datagrid('getSelections');
		  for( var i = 0; i < rows.length; i++){
	 		  var index = datagrid_bookOrderItem.datagrid('getRowIndex',rows[i]);//获取某行的行号
	 		  datagrid_bookOrderItem.datagrid('deleteRow',index); //通过行号移除该行
		 } 
	 }
 }
 //保存发票
 function _saveCustInvoiceList(){
	 endEditing();
		var rows = datagrid_bookOrderItem.datagrid('getRows');
		if (rows.length > 0) {
			var jsonStr = JSON.stringify(rows)
			$("#jsonStr").val(jsonStr);
			invoiceFrom.submit();
		}
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
	 if (editIndex != index){  
         if (endEditing()){  
             $('#datagrid_bookOrderItem').datagrid('selectRow', index).datagrid('beginEdit', index);  
             editIndex = index;  
             $('#datagrid_bookOrderItem').datagrid('unselectAll');
         } else {  
             $('#datagrid_bookOrderItem').datagrid('selectRow', editIndex);        
         }  
     }  
 }  
 function rollBack(){
		//回滚行记录
		var negoInvoiceNum = $("#negoInvoiceNum").val();
		 $.ajax({
			 url : '${dynamicURL}/documentsInvoices/docCustInvoiceMainAction!deleteByNegoInvoiceNum.do',
		 		  data : {
		 			 negoInvoiceNum:$("#negoInvoiceNum").val()
		 		}, 
		 		dataType : 'json',
		 		cache : false,
		 		success : function(response) {
		 			$("#datagrid_bookOrderItem").datagrid('load');
					$("#datagrid_bookOrderItem").datagrid('unselectAll');
					$.messager.show({
						title : '提示',
						msg : '回退完成'
					});
		 		}
		 	});
 }
	//套打
	function appletPrint(){
		 saveFlag='T';
		_saveCustInvoiceList();
	}

</script>
</head>
<body class="easyui-layout zoc">
     <div  region="north" border="false" class="zoc" title="" collapsed="false"  style="height: 80px;overflow: auto;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc">
				<span>发票：</span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft80">议付发票号：</div>
					<div class="righttext">
						<input  id="negoInvoiceNum" value="${docCustInvoiceMainQuery.negoInvoiceNum}" readonly="readonly" type="text" />
					</div>
				</div>
			</div>
		</form>
		<div class="datagrid-toolbar">
			<table id="datagrid_toolbar" style="height: 28px;"></table>
		</div>
	</div>
	<div region="center" id="printBody" border="false"
		style="overflow: auto;" class="zoc" align="center">
	<div class="part_zoc zoc" style="width: 1200px;">
			<div class="partnavi_zoc" align="left">
				<span>发票</span>
			</div>
		<form id="invoiceFrom" method="post">
		<s:hidden name="docCustInvoiceDetailList" id="jsonStr"/>
		<table id="tableHeader" style="border-collapse:collapse; width: 100%;">
			<tr>
				<td width="40%">
					<a href="#"><img src="${staticURL}/style/images/logo_login.png" /></a>
				</td>
				<td class="t-head" align="center"
							style="padding-top: 30px;text-align: center; font-family: arial, 微软雅黑; font-size: 40px; font-weight: bold;" align="center" >INVOICE</td>
				<td align="right" >
					<br/>
					&nbsp;&nbsp;&nbsp;<textarea class="zoc" style="overflow:hidden;width: 80%;height: 100%;font-size:15px" id="shipPaperCode" name="negoInvoiceTitle"></textarea>
				</td>
			</tr>
			<tr>
			    <td style="height:30px;font-size:30px"></td>
			</tr>
			<tr>
			  <td colspan="3" align="center">
				    <table  style="border-style: solid ;border-width:0px;width:90%;border-collapse:collapse;">
					   <tr>
						     <th align="center" style="font-size:15px"> <input name="freightName" type="text"  style="width:70px;border-style:none"></th>
						     <td><input name="currency" type="text"  style="width:30px;border-style:none"><input name="freightPrice" type="text"  style="width:160px;border-style:none"></input></td>
							 <td colspan="2" ></td>
							 <th align="left" colspan="2" style="font-size:15px">NO:&nbsp;&nbsp;<input name="negoInvoiceNum" type="text"  style="width:160px;" class="zoc" /></th>
						</tr>
						<tr>
						     <th align="center" style="font-size:15px"><input name="premiumName" type="text" style="width:70px;border-style:none"></th>
						     <td><input name="currencyI" type="text"  style="width:30px;border-style:none"><input name="premiumPrice" type="text"  style="width:160px;border-style:none"></input></td>
							 <td colspan="2" ></td>
							 <th align="left" colspan="2" style="font-size:15px">DATE:<input name="negoInvoicenumDate" type="text" class="easyui-datebox zoc" style="width:160px"></input></th>
						</tr>
						<tr>
						     <th align="left" colspan="2" style="font-size:15px">L/C NO:<input name="orderPaymentMethod" type="text"  style="width:300px"></input></th>
							  <th align="left" colspan="2" style="font-size:15px">FROM: <input name="portStart" type="text"  style="width:350px"></input></th>
							 <th align="left" colspan="2" style="font-size:15px">TO:<input name="portEnd" type="text"  style="width:180px"></input></th>
						</tr>
						<tr>
						     <th align="left" colspan="6" style="font-size:15px">P/O NO:
							    <input name="orderPoCode" id="orderPoCode" type="text"  style="width:900px"></input>
							 </th>
						</tr>
						<tr>
						     <th align="left" colspan="6" style="font-size:15px">Haier internal S/O No:
							    <input name="orderNums" id="orderNums" type="text"  style="width:750px"></input>
							 </th>
						</tr>
						<tr>
						      <th align="left" colspan="6" style="font-size:15px">FOR ACCOUNTAND RISK OF MESSRS.<input name="custname" type="text"  style="width:700px"></input></th>
						</tr>
						<tr>
						      <th align="right" colspan="6" style="font-size:15px"><input name="customerInfo" type="text"  style="width:500px;padding-right: 310px"></input></th>
						</tr>
						<tr>
							 <th align="right" colspan="4" style="font-size:15px">DEAL TYPE:</th>
						     <td align="left"  colspan="2" style="font-size:15px">
							    <input name="orderDealConditions" type="text"  style="width:200px"></input>
							 </td>
						</tr>
						<tr>
							 <th align="left" style="font-size:15px"  width="70px">货描前:</th>
						     <td align="left"  colspan="5" style="font-size:15px">
							    <input name="descriptionBefore" type="text"  style="width:950px"></input>
							 </td>
						</tr>
						<tr>
							 <th align="left" style="font-size:15px" width="70px">货描后:</th>
						     <td align="left"  colspan="5" style="font-size:15px">
							    <input name="descriptionAfter" type="text"  style="width:950px"></input>
							 </td>
						</tr>
					</table>
			  </td>
			</tr>
			<tr>
			  <td colspan="3" style="height:30px;"></td>
			</tr>
			<tr style="height: 360px;width: 900px" id="datagridTr">
				<td colspan="3"   style="border-bottom: 1px solid #A4B5C2;border-top: 1px solid #A4B5C2;">
				    <table id="datagrid_bookOrderItem" class="easyui-datagrid">
				    </table>
				</td>
			</tr> 
			<tr>
			 <td colspan="3" style="height:30px"></td>
			</tr>
		</table>
		</form>
		</div>
	</div> 
		<div id="custInvoiceAddDialog" style="display: none;width: 800px;height: 230px;overFlow-x: hidden;" align="center">
		<form id="custInvoiceAddForm" method="post">
			<div class="part_zoc zoc">
						<div class="oneline">
							<div class="itemleft60">订单号:</div>
							<div class="righttext">
								<input name="orderNum" type="text" class="easyui-validatebox"   missingMessage="请填写订单号"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">唛头:</div>
							<div class="righttext">
								<input name="marks" type="text" class="easyui-validatebox"  missingMessage="请填写唛头"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">货描:</div>
							<div class="righttext">
								<input name="descGoods" type="text" class="easyui-validatebox"  missingMessage="请填写货描"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">客户型号:</div>
							<div class="righttext">
								<input name="customerModel" type="text" class="easyui-validatebox"  missingMessage="请填写客户型号"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">数量:</div>
							<div class="righttext">
								<input name="quantity" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写数量"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">单位:</div>
							<div class="righttext">
								<input name="unit" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写????"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">单价:</div>
							<div class="righttext">
								<input name="price" type="text" class="easyui-validatebox"  missingMessage="请填写单价"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">总价:</div>
							<div class="righttext">
								<input name="amount" type="text" class="easyui-validatebox"  missingMessage="请填写单价"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">币种:</div>
							<div class="righttext">
								<input name="currency" type="text" class="easyui-validatebox"  missingMessage="请填写币种"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">件数:</div>
								<div class="righttext">
									<input name="packages" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写件数"  style="width: 155px;"/>						
							    </div>
							<div class="itemleft60">件数单位:</div>
								<div class="righttext">
									<input name="packagesUnit"  type="text" class="easyui-validatebox"  missingMessage="请填写单位"  style="width: 155px;"/>						
								</div>
							<div class="itemleft60">发票号:</div>
							<div class="righttext">
								<input name="negoInvoiceNum" id="addNegoInvoiceCode" readonly="readonly" type="text" style="width: 155px;"/>						
							</div>
						</div>
			</div>
		</form>
	</div>
	<div id="showLoadExcelDialog"
		style="display: none; width: 400px; height: 150px;" align="center">
		<form id="showLoadExcelInfoForm" method="post"
			enctype="multipart/form-data">
			<table class="tableForm">
				<tr>
					<th>订舱单号:</th>
					<td><s:textfield name="bookCode" id="exportBookCode" readonly="true"></s:textfield></td>
				</tr>
				<tr>
					<th>导入报关发票信息:</th>
					<td><s:file name="excleFile" id="excleFile"></s:file></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>