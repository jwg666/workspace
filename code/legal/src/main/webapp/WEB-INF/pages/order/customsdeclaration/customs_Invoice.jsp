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
</style>
<script type="text/javascript" charset="utf-8">
var datagrid_bookOrderItem;
var custInvoiceAddDialog;
var custInvoiceAddForm;
var showLoadExcelInfoForm;
var showLoadExcelDialog;
var printFlag=true;
 $(function() {
	 //$('#datagrid_bookOrderItem').datagrid('getPanel').removeClass('lines-both lines-no lines-right lines-bottom').addClass('border:3px solid');
	 datagrid_bookOrderItem= $('#datagrid_bookOrderItem').datagrid({
		 //url : '${dynamicURL}/bookorder/cabinBookAction!bookDataGrid.do?bookCode=www0', 
		//title : '订舱明细表列表',
		iconCls : 'icon-save',
		rownumbers : true,
		pagePosition : 'bottom',
		pageSize : 30,
		pageList : [ 10,20,30,50,100],
		fit : true,
		fitColumns : true,
		nowrap : false,
		border : false,
		showFooter: true,
		onDblClickRow: onClickRow,
	 	columns : [ [ 
		 {
			field : 'orderCode',
			title : 'Marks',
			align : 'center',
			sortable : true,
			rowspan:2,
			width : 60
		},  {
			field : 'marks',
			title : 'Marks',
			align : 'center',
			hidden : true,
			rowspan:2,
			width : 60
		},  {
			title : 'Description of Goods',
			align : 'center',
			colspan:4,
			sortable : true,
			width:280
		}, {
			field : 'prodQuantity',
			title : 'Quantity',
			align : 'center',
			sortable : true,
			rowspan:2,
			width : 60,
			editor:{type:'numberbox'},
			formatter:function(value,row,index){
				if(row.prodQuantity==null){
					return '';
				}else{
					return row.prodQuantity+"    "+row.unit;
				}
				
			}
		}, {
			field : 'currencyPrice',
			title : 'Price',
			align : 'center',
			rowspan:2,
			sortable : true,
			width:60,
			editor:{type:'numberbox',options:{precision:2}},
			formatter:function(value,row,index){
				if(row.currencyPrice>0){
     				return row.currency+"     "+Number(row.currencyPrice).toFixed(2);
     			}
				return row.currency+"     "+row.currencyPrice;
			}
			
		},{
			field : 'currencyAmount',
			title : 'Amount',
			align : 'center',
			sortable : true,
			rowspan:2,
			width : 60,
			editor:{type:'numberbox',options:{precision:2}},
			formatter:function(value,row,index){
				if(row.currencyAmount>0){
     				return row.currency+"     "+Number(row.currencyAmount).toFixed(2);
     			}
				return row.currency+"     "+row.currencyAmount;
			}
		},{
			field : 'packages',
			title : 'Packages',
			align : 'center',
			sortable : true,
			rowspan : 2,
			editor : {
				type : 'numberbox',
			},
			width : 50,
			formatter : function(value, row, index) {
     			return row.packages;
			},
		},{
			field : 'packagesUnit',
			title : 'Pack Unit',
			align : 'center',
			sortable : true,
			rowspan : 2,
			width : 40,
			editor : {
				type : 'text',
			},
			formatter : function(value, row, index) {
				return row.packagesUnit;
			},
		} ,{
			field : 'unit',
			title : 'UNIT',
			align : 'center',
			sortable : true,
			rowspan:2,
			width : 120,
			hidden : true,
			formatter:function(value,row,index){
				return row.unit;
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
		}],[
				{field : 'haierProdDesc',title:'GOODS DESC',align : 'center',editor:'text',width:70,
					formatter:function(value,row,index){
						if(row.haierProdDesc=="" || row.haierProdDesc==null){
							return row.descGoods;
		     			}
						return row.haierProdDesc;
					}
				},
				{field : 'haierModel',title:'HAERI MODEL',align : 'center',editor:'text',width:70},
				{field : 'customerModel',title:'CUSTOMER MODEL',align : 'center',editor:'text',width:70},
				{field : 'simpleCode',title:'SIMPLE CODE',align : 'center',editor:'text',width:70}
		] ],
		loadFilter : function(data) {
			if (data.total > 0) {
				if(data.rows[0].printFlag=="1"){
					$("#printFlag").html("订单已经打印！");
				}
			} 
			return data;
		}
	});
		custInvoiceAddForm = $('#custInvoiceAddForm').form({
			url : '${dynamicURL}/actcustinvoice/actCustInvoiceAction!addItem.do',
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
		//加载导入excel方法
		showLoadExcelInfoForm = $('#showLoadExcelInfoForm').form({
			url : '${dynamicURL}/actcustinvoice/actCustInvoiceAction!exportCustInvoice.action',
			success : function(data) {
				$.messager.progress('close');
				var json = $.parseJSON(data);
				var obj = json.obj;
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});

					var rowId = obj.rowId;
					datagrid_bookOrderItem.datagrid({
						queryParams : {
							rowId : rowId
						}
					});
					showLoadExcelDialog.dialog('close');
					//$('#searchForm').form('load', obj);
				} else {
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
			}
		});
		showLoadExcelDialog = $('#showLoadExcelDialog').show().dialog({
			title : '导入报关发票',
			modal : true,
			closed : true,
			collapsible : true,
			buttons : [ {
				text : '下载导入模板',
				handler : function() {
					window.location.href = "${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId=40103";
					return false;
				}
			},{
				text : '导入',
				handler : function() {
					if($("#excleFile").val()==""){
						return "请先选择导入的模板！";
					}
					$.messager.progress({
						text : '数据加载中....',
						interval : 100
						});
					showLoadExcelInfoForm.submit();
				}
			} ]
		});
	 <s:if test='custOrderQuery.orderCode!=null&&custOrderQuery.orderCode!=""'>
	 $('#orderCodeId').val('${orderCode}');
	 _search();
	 </s:if>
});
 
 function _search(){
	 var orderCode=document.getElementById('orderCodeId').value;
	 if(orderCode!=null && orderCode!=''){
	 	findBookCode();
	 }
	 findShipPaperCode();
// 	 var orderType=document.getElementById('orderType').value;
	 var bookCode=document.getElementById('bookCode').value;
	 var queryFlag=document.getElementById('queryFlag').value;
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
			 url : '${dynamicURL}/custorder/custOrderAction!searchDetail.do?orderCode='+orderCode+'&bookCode='+bookCode+'&queryFlag='+queryFlag,
			 toolbar : [{
					text : '新增行记录',
					iconCls : 'icon-add',
					handler : function() {
						add();
					}
				}, '-',{
					text : '删除行记录',
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
				}, '-', {
					text : '导入',
					handler : function() {
						exportCustInvoice();
					}
				}, '-'] 
		 });
 }
//导入报关发票
	function exportCustInvoice() {
		showLoadExcelInfoForm.form('clear');
		$('div.validatebox-tip').remove();
		showLoadExcelDialog.dialog('open');
		$("#exportBookCode").val($("#bookCode").val());
	}
//新增
	function add() {
		custInvoiceAddForm.form("clear");
		$("#addBookCode").val($("#bookCode").val());
		$('div.validatebox-tip').remove();
		custInvoiceAddDialog.dialog('open');
	}
	
 function deleteRows(){
	 checkEmp();
	 if(printFlag){
		 var rows = datagrid_bookOrderItem.datagrid('getSelections');
		  for( var i = 0; i < rows.length; i++){
	 		  var index = datagrid_bookOrderItem.datagrid('getRowIndex',rows[i]);//获取某行的行号
	 		  datagrid_bookOrderItem.datagrid('deleteRow',index); //通过行号移除该行
		 } 
	 }
 }
 function saveRows(){
	 checkEmp();
	 if(printFlag){
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
				async : false,
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
 }
 //打印预览
 function print(){
	//保存
	$.ajax({
			url : '${dynamicURL}/actcustinvoice/actCustInvoiceAction!checkIsSave.do',
			async : false,
			data : {
				bookCode : $("#bookCode").val()
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
			//如果已经保存就不再进行保存
				if(response.success){
					saveRows();
				}
			}
		});
	 var orderCode=document.getElementById('orderCodeId').value;
	 if(orderCode!=null && orderCode!=''){
	 	findBookCode();
	 }
	 var bookCode=document.getElementById('bookCode').value;
	 parent.window.HROS.window.createTemp({
	 	title:"报关发票打印预览",
	 	url:'${dynamicURL}/custorder/custOrderAction!printCustInvoice.do?orderCode='+orderCode+'&bookCode='+bookCode,
	 	width:800,height:400,isresize:false,isopenmax:true,isflash:false,customWindow : window});

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
// 	 var orderType=document.getElementById('orderType').value;
     /* if(orderType=='bz'||orderType=='hg'){
    	 return false;
     } */
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
	 checkEmp();
	 if(printFlag){
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
	 			$("#shipPaperCode").html(response.msg);
	 		}
	 	});
 }
 //确认发票
 function updateAcceptFlag(){
	 $.ajax({
	 		url : '${dynamicURL}/actcustinvoice/actCustInvoiceAction!updateAcceptFlag.do',
	 		async:false,
	 		  data : {
	 			 bookCode:$("#bookCode").val()
	 		}, 
	 		dataType : 'json',
	 		cache : false,
	 		success : function(response) {
	 			if(response.success){
					$.messager.show({
						title : '提示',
						msg : '确认完成'
					});
				}else{
					$.messager.show({
						title : '提示',
						msg : response.msg
					});
				}
	 		}
	 	});
 }
	function checkEmp(){
		$
		.ajax({
			url : '${dynamicURL}/actcustinvoice/actCustInvoiceAction!checkEmp.do',
			async : false,
			data : {
				bookCode : $("#bookCode").val()
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if(response.success){
					printFlag= true;
				}else{
					$.messager.show({
						title : '提示',
						msg : response.msg
					});
					printFlag= false;
				}
			}
		});
	}
	//套打
	function appletPrint(){
		//保存
		$.ajax({
				url : '${dynamicURL}/actcustinvoice/actCustInvoiceAction!checkIsSave.do',
				async : false,
				data : {
					bookCode : $("#bookCode").val()
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
				//如果已经保存就不再进行保存
					if(response.success){
						saveRows();
					}
				}
			});
		//记录打印
		$.ajax({
				url : '${dynamicURL}/actcustinvoice/actCustInvoiceAction!updatePrintFlag.do',
				async : false,
				data : {
						bookCode : $("#bookCode").val()
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
				}
		});
		if($("#bookCode").val().indexOf("-")>=0){
			var bookCode=$("#bookCode").val().split("-");
			window.open("http://hrois.haier.net/report/Report-Guage.do?reportId=ff41cc19-e8ca-4f9c-95f9-7996e06ba164&silent=yes&isResultant=false&book_code="+bookCode[0]+"&falg="+bookCode[1]);
		}else{
			window.open("http://hrois.haier.net/report/Report-Guage.do?reportId=ff41cc19-e8ca-4f9c-95f9-7996e06ba164&silent=yes&isResultant=false&book_code="+$("#bookCode").val());
		}
		//打印
		//window.open("http://hrois.haier.net/report/unieap/pages/report/jsp/show/Print.jsp?reportId=&silent=yes&isResultant=false&book_code="+$("#bookCode").val());
	}
</script>
</head>
<body class="easyui-layout zoc">
     <div  region="north" border="false" class="zoc" title="" collapsed="false"  style="height: 80px;overflow: auto;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc">
				<span>报关发票：</span>
			</div>
			<div class="oneline">
				<div class="item25">
					<div class="itemleft60">订单号：</div>
					<div class="righttext">
						<input name="orderCode" id="orderCodeId" onblur="findBookCode()" type="text" value="" class="orderAutoComple"/>
					</div>
				</div>
				<div class="item25">
					<div class="itemleft60">订舱号：</div>
					<div class="righttext">
						<input name="bookCode" id="bookCode" readonly="readonly" type="text" value=""/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft100">是否按整机提报：</div>
					<div class="rightselect_easyui">
						<select id="queryFlag" name="queryFlag">
							<option value="0">是</option>
							<option value="1">否</option>
						</select>
					</div>
					<div class="itemleft100">(散件订单)</div>
				</div>
				<div class="item33">
					<div class="itemleft100" id="printFlag" style="color: red;"></div>
				</div>
				<!-- <div class="item25 lastitem">
					<div class="itemleft80">发票类型：</div>
						<div class="righttext">
						  <select name="orderType" id="orderType" style="width:140px" >
						    <option value="bz">标准订单</option>
						    <option value="hg">合并报关订单</option>
						    <option value="sj">散件订单</option>
						    <option value="bj">备件订单</option>
						  </select>
						</div>
				</div> -->
			</div>
			<div class="oneline">
				<div class="item100 lastitem">
					<div class="oprationbutt">
						<input type="button" onclick="_search()" value="查询" />
						<input type="button" onclick="updateAcceptFlag()" value="发票确认" />
						<input type="button" onclick="print()" value="打印预览" />
						<input type="button" onclick="appletPrint()" value="套打/导出" />
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center" border="false" class="zoc" title="" collapsed="false"  style="height: 600px;overflow: auto;" align="center" id="printBody">
		<div class="part_zoc zoc" >
		<form id="searchInvoice" method="post">
		<table id="tableHeader" style="border-collapse:collapse; width: 75%;">
			<tr>
				<td style="border-style: solid; border-width: 1px">
					<a href="#"><img src="${staticURL}/style/images/logo_login.png" style="height:90px;width:200px"/></a>
					<!-- <textarea name="shipperMan" class="zoc" readonly="readonly" style="resize:none;overflow:hidden"></textarea> -->
				</td>
				<td style="width: 200px;font-size:40px" align="center">INVOICE</td>
				<td style="border-style: solid; border-width: 1px">
					<div  id="shipPaperCode" class="zoc"  style="overflow:hidden;width: 340px;height:73px">
					</div>
				</td>
			</tr>
			<tr>
			    <td colspan="3"   style="height:70px;font-size:30px"></td>
			</tr>
			<tr>
			  <td colspan="3">
				    <table  style="border-style: solid ;border-width:0px;width:100%;border-collapse:collapse;">
					    <tr>
							 <th align="right"  >F:
							 </th>
							 <td colspan="5" align="left" >
							     <input name="currencyConditionFwf" type="text" readonly="readonly" class="zoc" style="width:100px;border-style:dotted;" ></input>
							 </td>
						</tr>
						<tr>
							 <th align="right" >I:
							 </th>
							 <td colspan="5" align="left" >
							    <input name="currencyConditionFfi"  type="text" readonly="readonly" class="zoc" style="width:100px;border-style:dotted;"></input>
							 </td>
						</tr>
						<tr>
						    <td colspan="6" style="height:30px"></td>
						</tr>
						<tr>
						     <th align="left" >L/C NO:</th>
						     <td align="left"  >
							    <input name="payCode" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
							 <td colspan="2" ></td>
							 <th align="left">INVOICE NO:</th>
						     <td align="left" >
							    <input name="invoiceNum" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
						</tr>
						<tr>
						     <th align="left">P/O NO:</th>
						     <td align="left"  >
							    <input name="orderPoCode" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
							 <th align="left" >S/C NO:</th>
						     <td align="left"  >
							    <input name="contractCode" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
							 <th align="left">DATE:</th>
						     <td align="left"  >
							    <input name="orderShipDate" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
						</tr>
						<tr>
						     <th align="left">SHIP PER S.S:</th>
						     <td align="left"  >
							    <input name="" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
							 <th align="left" >FROM:</th>
						     <td align="left"  >
							    <input name="portStartCode" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
							 <th align="left">TO:</th>
						     <td align="left"  >
							    <input name="portEndCode" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
						</tr>
						<tr>
						     <th align="left">SETTLEMENT TYPE:</th>
						     <td align="left"  >
							    <input name="orderSettlementType" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
							 </td>
							 <td align="left" ></td>
						     <td align="left"  >
							 </td>
							 <td align="left"></td>
						     <td align="left"  >
							 </td>
						</tr>
						<tr>
						      <th align="left" colspan="2">FOR ACCOUNTAND RISK OF MESSRS.</th>
						      <td colspan="4" align="left">
						         <input name="customerName" type="text" readonly="readonly" class="zoc" style="width:470px"></input>
						      </td>
						</tr>
						<tr>
							 <td align="right" colspan="5">DEAL TYPE:</td>
						     <td align="left"  >
							    <input name="orderDealType" type="text" readonly="readonly" class="zoc" style="width:160px"></input>
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
		<div id="custInvoiceAddDialog" style="display: none;width: 800px;height: 230px;overFlow-x: hidden;" align="center">
		<form id="custInvoiceAddForm" method="post">
			<div class="part_zoc zoc">
						<div class="oneline">
							<div class="itemleft60">订单号:</div>
							<div class="righttext">
								<input name="marks" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">唛头:</div>
							<div class="righttext">
								<input name="orderNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写唛头"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">货描:</div>
							<div class="righttext">
								<input name="descGoods" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写货描"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">海尔型号:</div>
							<div class="righttext">
								<input name="haierModel" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写海尔型号"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">客户型号:</div>
							<div class="righttext">
								<input name="customerModel" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写客户型号"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">简码:</div>
							<div class="righttext">
								<input name="simpleCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写简码"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">数量:</div>
							<div class="righttext">
								<input name="quantity" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写数量"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">单位:</div>
							<div class="righttext">
								<input name="unit" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写????"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">订舱号:</div>
							<div class="righttext">
								<input name="bookCode" id="addBookCode" type="text" class="easyui-validatebox"  missingMessage="请填写订舱号"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">单价:</div>
							<div class="righttext">
								<input name="price" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写单价"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">总价:</div>
							<div class="righttext">
								<input name="amount" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写单价"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">币种:</div>
							<div class="righttext">
								<input name="currency" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写币种"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">件数:</div>
								<div class="righttext">
									<input name="packages" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写件数"  style="width: 155px;"/>						
							    </div>
							<div class="itemleft60">件数单位:</div>
								<div class="righttext">
									<input name="packagesUnit"  type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写单位"  style="width: 155px;"/>						
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