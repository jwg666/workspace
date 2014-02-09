<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<style type="text/css">
table.form_table {
	border: 1px solid #CCCCCC;
	border-collapse: collapse;
	background-image: url(${staticURL}/style/demo/img/ibg.png);
	position:relative;
}
table.form_table td {
	padding: 2px;
	border-right: 1px solid #C0C0C0;
	border-bottom: 1px solid #C0C0C0;
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
/* 	BORDER-BOTTOM-COLOR: #666666; */
	BORDER-RIGHT-WIDTH: 0px;
	BORDER-TOP-WIDTH: 0px;
	BORDER-BOTTOM-WIDTH: 0px;
	BORDER-LEFT-WIDTH: 0px;
 	BACKGROUND: Transparent; 
}
</style>
<script type="text/javascript" charset="utf-8">
    var createHistoryList;
	var createCheckList;
	var createConferPayDialog;//生成议付发票Dialog\
	var conferPayDialogForm;
	var querySendWaiteTaskList;
	var querySendHistroyTaskList;
	var sendSearchForm;
	var sendHistroySearchForm;
	var searchForm;
	var searchHistoryForm;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
	    sendSearchForm= $('#sendSearchForm').form();
		sendHistroySearchForm= $('#sendHistroySearchForm').form();
	    searchHistoryForm = $('#searchHistoryForm').form();
	    createCheckList = $('#createCheckList').datagrid({
			url : 'conferpayAction!waiteConferTask.do?definitionKey=conferPayInvoice&taskType=my&taskId=${taskId}',
			//title : 'CD_CONFERPAY列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 15,
			pageList : [ 15, 20, 30, 50, 100, 150 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'orderCode',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.orderCode;
						}
					},
			   {field:'orderCode',title:'订单编号',align:'center',sortable:true,width:150,
					formatter:function(value,row,index){
						var img;
						if(row.assignee&&row.assignee!='null'){
						img="<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
						}else{
						img="<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
						}
						return "<a href='javascript:void(0)' style='color:blue' >"+img+row.orderCode+"</a>";
					}
				},				
			   {field:'orderPoCode',title:'客户PO NO.',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.orderPoCode;
					}
				},				
			   {field:'ordertypename',title:'订单结算类型',align:'center',sortable:true,width:120,
					formatter:function(value,row,index){
						return row.ordertypename;
					}
				},				
			   {field:'operators',title:'经营主体',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.operators;
					}
				},				
			   {field:'depname',title:'经营体',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.depname;
					}
				},				
			   {field:'ctyname',title:'出口国家',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.ctyname;
					}
				},				
			   {field:'orderProdManager',title:'产品经理',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderProdManager;
					}
				},				
			   {field:'cusname',title:'终端客户',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.cusname;
					}
				},
				{
					field : 'trace',
					title : '流程追踪',
					align : 'center',
					width : 80,
					formatter : function(value, row, index) {
						return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg("+index+")'>流程跟踪</a>";
					}
				}
			 ] ],
			 toolbar : [ {
				 text : '申领',
	 				iconCls : 'icon-apply',
	 				handler : function() {
	 					quickApply();
	 				}
			}, '-', {
				text : '生成议付发票',
				iconCls : 'icon-ok',
				handler : function() {
					check();
				}
			}, '-' ] ,
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
	  //展示订单信息
		 $('#findOrderItemsList').datagrid({
				title : '明细',
				iconCls : 'icon-save',
				pagination : true,
				pagePosition : 'bottom',
				rownumbers : true,
				pageSize : 50,
				pageList : [30, 50 ],
				fit: true,
				fitColumns : true,
				showFooter: true,
				nowrap : true,
				border : false,
				idField : 'orderCode',
				columns : [ [ 
				   {field:'orderCode',title:'订单号',align:'center',sortable:true,width:200,
						formatter:function(value,row,index){
							return row.orderCode;
						}
					},				
				   {field:'operators',title:'经营主体',align:'center',sortable:true,width:120,
						formatter:function(value,row,index){
							return row.operators;
						}
					},				
				   {field:'materialCode',title:'产品名称',align:'center',sortable:true,width:200,
						formatter:function(value,row,index){
							return row.materialCode;
						}
					},				
				   {field:'prodQuantity',title:'订单数量',align:'center',sortable:true,width:100,
						formatter:function(value,row,index){
							return row.prodQuantity;
						}
					},				
				   {field:'amount',title:'客户发票金额',align:'center',sortable:true,width:100,
						formatter:function(value,row,index){
							return Number(row.amount).toFixed(2);
						}
					},				
				   {field:'custamount',title:'议付金额',align:'center',sortable:true,width:100,
						formatter:function(value,row,index){
							return Number(row.custamount).toFixed(2);
						}
					}			
				 ] ]					
			});
	  //单证经理
		$('#docManager').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectAttachOrderManager.do',
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_DOC',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		});
		//custCodeId客户编号
		$('#custCodeId').combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
			idField:'customerId',
			textField : 'name',
			panelWidth : 600,
			panelHeight : 220,
			toolbar : '#_CNNQUERY',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ 
			  {
				field : 'customerId',
				title : '客户编号',
				width : 10
			},{
				field : 'name',
				title : '客户名称',
				width : 10
			}] ]
		});
		 //单证经理
		$('#docManagerHis').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectAttachOrderManager.do',
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_DOCHIS',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		});
		//custCodeId客户编号
		$('#custCodeIdHis').combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
			idField:'customerId',
			textField : 'name',
			panelWidth : 600,
			panelHeight : 220,
			toolbar : '#_CNNQUERYHIS',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ 
			  {
				field : 'customerId',
				title : '客户编号',
				width : 10
			},{
				field : 'name',
				title : '客户名称',
				width : 10
			}] ]
		});
		querySendHistroyTaskList=$('#querySendHistroyTaskList').datagrid({
			url : 'conferpayAction!querySendHistroyTask.do?definitionKey=conferPayInvoice&taskType=my&taskId=${taskId}',
			//title : 'CD_CONFERPAY列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 15,
			pageList : [ 15, 20, 30, 50, 100, 150 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'orderCode',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.orderCode;
						}
					},
			   {field:'orderCode',title:'订单编号',align:'center',sortable:true,width:150,
					formatter:function(value,row,index){
						var img;
						if(row.assignee&&row.assignee!='null'){
						img="<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
						}else{
						img="<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
						}
						return "<a href='javascript:void(0)' style='color:blue' >"+img+row.orderCode+"</a>";
					}
				},				
			   {field:'orderPoCode',title:'客户PO NO.',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.orderPoCode;
					}
				},				
			   {field:'ordertypename',title:'订单结算类型',align:'center',sortable:true,width:120,
					formatter:function(value,row,index){
						return row.ordertypename;
					}
				},				
			   {field:'operators',title:'经营主体',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.operators;
					}
				},				
			   {field:'depname',title:'经营体',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.depname;
					}
				},				
			   {field:'ctyname',title:'出口国家',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.ctyname;
					}
				},				
			   {field:'orderProdManager',title:'产品经理',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderProdManager;
					}
				},				
			   {field:'cusname',title:'终端客户',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.cusname;
					}
				},
				{
					field : 'trace',
					title : '流程追踪',
					align : 'center',
					width : 80,
					formatter : function(value, row, index) {
						return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg("+index+")'>流程跟踪</a>";
					}
				}
			 ] ],
			 toolbar : [  ] ,
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
		querySendWaiteTaskList=$('#querySendWaiteTaskList').datagrid({
			url : 'conferpayAction!querySendWaiteTask.do?definitionKey=conferPayInvoice&taskType=my&taskId=${taskId}',
			//title : 'CD_CONFERPAY列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 15,
			pageList : [ 15, 20, 30, 50, 100, 150 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'orderCode',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.orderCode;
						}
					},
			   {field:'orderCode',title:'订单编号',align:'center',sortable:true,width:150,
					formatter:function(value,row,index){
						var img;
						if(row.assignee&&row.assignee!='null'){
						img="<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
						}else{
						img="<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
						}
						return "<a href='javascript:void(0)' style='color:blue' >"+img+row.orderCode+"</a>";
					}
				},				
			   {field:'orderPoCode',title:'客户PO NO.',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.orderPoCode;
					}
				},				
			   {field:'ordertypename',title:'订单结算类型',align:'center',sortable:true,width:120,
					formatter:function(value,row,index){
						return row.ordertypename;
					}
				},				
			   {field:'operators',title:'经营主体',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.operators;
					}
				},				
			   {field:'depname',title:'经营体',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.depname;
					}
				},				
			   {field:'ctyname',title:'出口国家',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.ctyname;
					}
				},				
			   {field:'orderProdManager',title:'产品经理',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderProdManager;
					}
				},				
			   {field:'cusname',title:'终端客户',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.cusname;
					}
				},
				{field:'sendFlag',title:'是否可以寄单',align:'center',sortable:true,width:150,
					formatter:function(value,row,index){
						if(row.sendflag=='0'){
							return "不可寄单";
						}else{
							return "可寄单";
						}
					}
				},	
				{
					field : 'trace',
					title : '流程追踪',
					align : 'center',
					width : 80,
					formatter : function(value, row, index) {
						return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg("+index+")'>流程跟踪</a>";
					}
				}
			 ] ],
			 toolbar : [ {
				text : '寄单',
				iconCls : 'icon-ok',
				handler : function() {
					openConferPaySend();
				}
			}, '-' ] ,
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
	    createHistoryList = $('#createHistoryList').datagrid({
			url : 'conferpayAction!histroyConferTask.do?definitionKey=${definitionKey}&taskType=my&taskId=${taskId}',
			//title : 'CD_CONFERPAY列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'orderCode',
			
			singleSelect:true,
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.orderCode;
						}
					},
			   {field:'orderCode',title:'订单编号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
			   {field:'orderPoCode',title:'客户PO NO.',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.orderPoCode;
					}
				},				
			   {field:'ordertypename',title:'订单结算类型',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderSettlementType;
					}
				},				
			   {field:'operators',title:'经营主体',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.factoryName;
					}
				},				
			   {field:'depname',title:'经营体',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.depname;
					}
				},				
			   {field:'ctyname',title:'出口国家',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.ctyname;
					}
				},				
			   {field:'orderProdManager',title:'产品经理',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderProdManager;
					}
				},				
			   {field:'customerName',title:'终端客户',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.customerName;
					}
				},
				{field:'negoInvoiceNum',title:'议付发票号',align:'center',sortable:true,width:130,
					formatter:function(value,row,index){
						return row.negoInvoiceNum;
					}
				}
			 ] ],
			 toolbar : [ {
				text : '重传',
				iconCls : 'icon-ok',
				handler : function() {
					repeatJco();
				}
			}, '-', {
				text : '修改议付发票号',
				iconCls : 'icon-ok',
				handler : function() {
					checkHis();
				}
			}] ,
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
	  //页面加载的时候判断议付待办类型
		if('${definitionKey}'=='getNegoInfoFromHope'){
			//如果是完成议付
			createCheckList.datagrid({
				toolbar:[{
					 text : '申领',
		 				iconCls : 'icon-apply',
		 				handler : function() {
		 					quickApply();
		 				}
				}, '-', {
					text : '完成议付',
					iconCls : 'icon-ok',
					handler : function() {
						conferPayComplete();
					}
				}, '-', {
					text : '获取HOPE议付信息',
					iconCls : 'icon-ok',
					handler : function() {
						conferPay();
					}
				}, '-']
			});
		};
	});
	//申领
	function quickApply(){
		var rows = createCheckList.datagrid('getSelections');
		var ids = "";
		var taskIds = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要申领当前议付待办？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1) {
							taskIds = taskIds + "taskIds=" + rows[i].taskId
									+ "&";
						} else {
							taskIds = taskIds + "taskIds=" + rows[i].taskId;
						}
					}
					$.ajax({
						url : 'conferpayAction!apply.do',
						data : taskIds,
						dataType : 'json',
						type : "post",
						success : function(response) {
							createCheckList.datagrid('load');
							createCheckList.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : response.msg
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要申领的议付待办！', 'error');
		}
	}
	//打开生成议付发票Dialog
	function openConferPay(){
		conferPayDialogForm=$('#conferPayDialogForm').form({
			url : 'negoOrderAction!saveNegoOrder.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					$('div.validatebox-tip').remove();
					createConferPayDialog.dialog('close');
					createCheckList.datagrid('load');
					createHistoryList.datagrid('load');
					createCheckList.datagrid('unselectAll');
					$.messager.progress('close');
				} else {
					createCheckList.datagrid('load');
					createHistoryList.datagrid('load');
					if(json.msg==null||json.msg==''){
						json.msg = '操作失败！'
					}
					$.messager.alert({
						title : '失败',
						msg : json.msg
					});
				}
			}
		});
		createConferPayDialog= $('#createConferPayDialog').show().dialog({
			title : '生成议付发票',
			modal : true,
			closed : true,
			maximizable : true,
 			maximized:true,
			buttons:[{
				text:'保存',
				handler:function(){
					conferPayDialogForm.submit();
				}
			},{
				text:'取消',
				handler:function(){
					conferPayDialogForm.form('clear');
					$('div.validatebox-tip').remove();
					createConferPayDialog.dialog('close');
				}
			}]
		});
		var rows = createCheckList.datagrid('getSelections');
		if (rows.length > 0) {
			var orderCodes="";
			var taskIds="";
			for ( var i = 0; i < rows.length; i++) {
				if (i != rows.length - 1) {
					orderCodes = orderCodes + rows[i].orderCode+",";
					taskIds = taskIds + rows[i].taskId+",";
				} else {
					orderCodes = orderCodes+ rows[i].orderCode;
					taskIds = taskIds+ rows[i].taskId;
				}
			}
			$.ajax({
				url : 'negoOrderAction!orderShowDesc.do',
				data : {
					orderCodes:orderCodes,
					taskIds:taskIds
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					conferPayDialogForm.form('clear');
					conferPayDialogForm.form('load', response);
					createConferPayDialog.dialog('open');
					$.messager.progress('close');
				}
			});
			 $('#findOrderItemsList').datagrid({
					url : 'negoOrderAction!findOrderItems.do?orderCodes='+orderCodes
			 });
		}else {
			$.messager.alert('提示', '请选择要生成议付发票的订单！', 'error');
		}
	}
	function sendCheck(){
		var rows = querySendWaiteTaskList.datagrid('getChecked');
		if (rows.length > 0) {
			var orderCodes="";
			var taskIds="";
			for ( var i = 0; i < rows.length; i++) {
				if (i != rows.length - 1) {
					orderCodes = orderCodes + rows[i].orderCode+",";
					taskIds = taskIds + rows[i].taskId+",";
				} else {
					orderCodes = orderCodes+ rows[i].orderCode;
					taskIds = taskIds+ rows[i].taskId;
				}
			}
			  $.ajax({
					url:'conferpayAction!check.do',
					data : {
						orderCodes:orderCodes,
						ids:taskIds
					},
					dataType : 'json',
					success : function(response){
						if (response.success) {
				 			 $.messager.show({
				 				title : '提示',
				 				msg : response.msg
				 			});
				 			openConferPayUpdate();
						} else {
							$.messager.alert('提示', response.msg, 'error');
						}
					}
			}); 
		}else{
			$.messager.alert('提示', '请选择订单！', 'error');
		}
	}
	function checkHis(){
		var rows = createHistoryList.datagrid('getChecked');
		if (rows.length > 0) {
			var orderCodes="";
			var taskIds="";
			for ( var i = 0; i < rows.length; i++) {
				if (i != rows.length - 1) {
					orderCodes = orderCodes + rows[i].orderCode+",";
					taskIds = taskIds + rows[i].taskId+",";
				} else {
					orderCodes = orderCodes+ rows[i].orderCode;
					taskIds = taskIds+ rows[i].taskId;
				}
			}
			  $.ajax({
					url:'conferpayAction!check.do',
					data : {
						orderCodes:orderCodes,
						ids:taskIds
					},
					dataType : 'json',
					success : function(response){
						if (response.success) {
				 			 $.messager.show({
				 				title : '提示',
				 				msg : response.msg
				 			});
				 			openConferPayUpdate();
						} else {
							$.messager.alert('提示', response.msg, 'error');
						}
					}
			}); 
		}else{
			$.messager.alert('提示', '请选择要修改议付发票号的订单！', 'error');
		}
	}
	//打开修改议付发票Dialog
	function openConferPayUpdate(){
		conferPayDialogForm=$('#conferPayDialogForm').form({
			url : 'negoOrderAction!saveNegoOrder.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					$('div.validatebox-tip').remove();
					createConferPayDialog.dialog('close');
					createCheckList.datagrid('load');
					createHistoryList.datagrid('load');
					createCheckList.datagrid('unselectAll');
					querySendWaiteTaskList.datagrid('load');
					$.messager.progress('close');
				} else {
					if(json.msg==null||json.msg==''){
						json.msg = '操作失败！'
					}
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
			}
		});
		createConferPayDialog= $('#createConferPayDialog').show().dialog({
			title : '修改议付发票',
			modal : true,
			closed : true,
			maximizable : true,
// 			maximized:true,
			buttons:[{
				text:'保存',
				handler:function(){
					conferPayDialogForm.submit();
				}
			},{
				text:'取消',
				handler:function(){
					conferPayDialogForm.form('clear');
					$('div.validatebox-tip').remove();
					createConferPayDialog.dialog('close');
				}
			}]
		});
		var rows = createHistoryList.datagrid('getSelections');
		if (rows.length > 0) {
			var orderCodes="";
			var taskIds="";
			for ( var i = 0; i < rows.length; i++) {
				if (i != rows.length - 1) {
					orderCodes = orderCodes + rows[i].orderCode+",";
					taskIds = taskIds + rows[i].taskId+",";
				} else {
					orderCodes = orderCodes+ rows[i].orderCode;
					taskIds = taskIds+ rows[i].taskId;
				}
			}
			$.ajax({
				url : 'negoOrderAction!orderShowDesc.do',
				data : {
					orderCodes:orderCodes,
					taskIds:taskIds
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					conferPayDialogForm.form('clear');
					conferPayDialogForm.form('load', response);
					createConferPayDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		}else {
			$.messager.alert('提示', '请选择要生成议付发票的订单！', 'error');
		}
	}
	//寄单
	function openConferPaySend(){
		var rows = querySendWaiteTaskList.datagrid('getSelections');
		if (rows.length > 0) {
			var orderCodes="";
			var taskIds="";
			for ( var i = 0; i < rows.length; i++) {
				if (i != rows.length - 1) {
					orderCodes = orderCodes + rows[i].orderCode+",";
					taskIds = taskIds + rows[i].taskId+",";
				} else {
					orderCodes = orderCodes+ rows[i].orderCode;
					taskIds = taskIds+ rows[i].taskId;
				}
			}
			$.ajax({
				url : 'negoOrderAction!orderSend.do',
				data : {
					orderCodes:orderCodes,
					taskIds:taskIds
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					$.messager.show({
		 				title : '提示',
		 				msg : response.msg
		 			});
					querySendWaiteTaskList.datagrid('load');
				}
			});
		}else {
			$.messager.alert('提示', '请选择要生成议付发票的订单！', 'error');
		}
	}
	//
	function check(){
		var rows = createCheckList.datagrid('getChecked');
		if (rows.length > 0) {
			var orderCodes="";
			var taskIds="";
			for ( var i = 0; i < rows.length; i++) {
				if (i != rows.length - 1) {
					orderCodes = orderCodes + rows[i].orderCode+",";
					taskIds = taskIds + rows[i].taskId+",";
				} else {
					orderCodes = orderCodes+ rows[i].orderCode;
					taskIds = taskIds+ rows[i].taskId;
				}
			}
			  $.ajax({
					url:'conferpayAction!check.do',
					data : {
						orderCodes:orderCodes,
						ids:taskIds
					},
					dataType : 'json',
					success : function(response){
						if (response.success) {
				 			 $.messager.show({
				 				title : '提示',
				 				msg : response.msg
				 			});
				 			openConferPay();
						} else {
							$.messager.alert('提示', response.msg, 'error');
						}
					}
			}); 
		}else{
			$.messager.alert('提示', '请选择要生成议付发票的订单！', 'error');
		}
	}
	//完成议付
	function conferPayComplete(){
		var rows = createCheckList.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要将当前所选订单完成议付？', function(r) {
				if (r) {
					var orderCodes="";
					var taskIds="";
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1) {
							orderCodes = orderCodes + rows[i].orderCode+",";
							taskIds = taskIds + rows[i].taskId+",";
						} else {
							orderCodes = orderCodes+ rows[i].orderCode;
							taskIds = taskIds+ rows[i].taskId;
						}
					}
					$.ajax({
						url : 'negoOrderAction!conferPayComplete.do',
						data : {
							orderCodes:orderCodes,
							taskIds:taskIds
						},
						dataType : 'json',
						cache : false,
						success : function(response) {
							if (response.success) {
								$.messager.show({
									title : '成功',
									msg : response.msg
								});
								$('div.validatebox-tip').remove();
								createCheckList.datagrid('load');
								createCheckList.datagrid('unselectAll');
								$.messager.progress('close');
							}else{
								$.messager.alert('提示', response.msg, 'error');
							}
						}
					});
				}
			});
		}else {
			$.messager.alert('提示', '请选择要完成议付的订单！', 'error');
		}
	}
	//获取HOPE议付信息
	function conferPay(){
		$.ajax({
			url : 'negoOrderAction!conferPay.do',
			dataType : 'json',
			cache : false,
			success : function(response) {
				$.messager.show({
					title : '成功',
					msg : '获取HOPE议付信息完成'
				});
				$('div.validatebox-tip').remove();
				createCheckList.datagrid('load');
				createCheckList.datagrid('unselectAll');
				$.messager.progress('close');
			}
		});
	}
	function traceImg(rowIndex){
		var obj=$("#createCheckList").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title:obj.orderSettlementType+"-订单号:"+obj.orderCode+"-流程图",
			url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+obj.processinstanceId,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	
	function repeatJco(){
		var rows = createHistoryList.datagrid('getSelections');
		var orderCode="";
		if (rows.length == 1) {
			orderCode=rows[0].orderCode;
			$.ajax({
				url:'conferpayAction!repeatJco.do',
				data : {
					orderCode:orderCode
				},
				dataType : 'json',
				success : function(response){
					$.messager.show({
		 				title : '提示',
		 				msg : response.msg
		 			});
				}
			}); 
		}else{
			$.messager.alert('提示', '请选择要重传的订单！', 'error');
		}
	}
	
	
	function _search(){
		createCheckList.datagrid('load', sy.serializeObject(searchForm));
	}
	function _sendSearch(){
		querySendWaiteTaskList.datagrid('load', sy.serializeObject(sendSearchForm));
	}
	function _sendHistroySearch(){
		querySendHistroyTaskList.datagrid('load', sy.serializeObject(sendHistroySearchForm));
	}
	function sendCleanSearch(){
		querySendWaiteTaskList.datagrid('load', {});
		sendSearchForm.form("clear");
		querySendWaiteTaskList.datagrid('clearSelections');
		querySendWaiteTaskList.datagrid('clearChecked');
	}
	function sendHistroyCleanSearch(){
		querySendHistroyTaskList.datagrid('load', {});
		sendHistroySearchForm.form("clear");
		querySendHistroyTaskList.datagrid('clearSelections');
		querySendHistroyTaskList.datagrid('clearChecked');
	}
	function hiddenSearchForm(){
		$("#checkSearch").layout("collapse","north");
	}
	function cleanSearch(){
		createCheckList.datagrid('load', {});
		searchForm.form("clear");
		createCheckList.datagrid('clearSelections');
		createCheckList.datagrid('clearChecked');
	}
	function historySearch(){
		createHistoryList.datagrid('load', sy.serializeObject(searchHistoryForm));
	}
	function hiddenHistorySearch(){
		$("#checkHistorySearch").layout("collapse","north");
	}
	function historyClean(){
		createHistoryList.datagrid('load', {});
		searchHistoryForm.form("clear");
		createHistoryList.datagrid('clearSelections');
		createHistoryList.datagrid('clearChecked');
		//$('#createHistoryList').datagrid({url:"conferpayAction!histroyConferTask.do?definitionKey=${definitionKey}&taskType=my"});
	}
	//模糊查询单证经理下拉列表
	function _getDocManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectAttachOrderManager.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
	}
	//重置查询单证经理下拉列表
	function _cleanDocManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectAttachOrderManager.do'
		});
	}
	function CCNMY(inputId,inputId2,selectId) {
		var _CCNTEMP = $('#' + inputId).val();
		var _CCNTEMP2 = $('#' + inputId2).val();
		var url = '${dynamicURL}/basic/customerAction!datagrid0.action?name=' + _CCNTEMP;
		if("" != _CCNTEMP2) {
			url = url + '&customerId=' + _CCNTEMP2;
		}
		$('#' + selectId).combogrid({
			url : url
		});
	}

</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true" >
		<div title="待办审批">
			<!--展开之后的content-part所显示的内容-->
			<!-- <div>
			</div>
			<table id="createCheckList" ></table> -->
			
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:113px; overflow: hidden;">
					<form id="searchForm">
					<div class="partnavi_zoc"><span>查询与操作：</span></div>
					<div class="oneline">
						<div class="item25">
							<div class="itemleft60">订单号：</div>
			                <div class="righttext"><input name="orderCode" /></div>
						</div>
						<div class="item25">
							<div class="itemleft60">出运期：</div>
							<div class="rightselect_easyui">
							<input id="orderShipDateStart" name="orderShipDateStart"
								style="width: 120px;margin-left: 1px;" class="easyui-datebox" editable="false" />
							</div>
						</div>
						<div class="item25">
							<div class="itemleft60">至：</div>
							<div class="rightselect_easyui">
							<input id="orderShipDateStart" name="orderShipDateEnd"
								style="width: 120px;margin-left: 1px;" class="easyui-datebox" editable="false" />
							</div>
						</div>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft60">市场中心：</div>
				                <div class="righttext">	<input name="saleArea" class="easyui-combobox short60"
										style="width: 130px" 
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.action?itemType=3'" /></div>
							</div>
							<div class="item25">
								<div class="itemleft60">客户：</div>
				                <div class="righttext_easyui">
									<input type="text" class="short50" name="customerCode" id="custCodeId"/>
								</div>
							</div>
							<div class="item25">
								<div class="itemleft60">单证经理：</div>
				                <div class="rightselect_easyui">
								<input id="docManager" name="docManager"   type="text" class="short50" />
							    </div>
							   </div>
						</div>
						<div class="oneline">
							<div class="item25">
									<div class="itemleft60">提单号：</div>
					                <div class="righttext_easyui">
									<input id="billNum" name="billNum"   type="text" class="short50" />
								    </div>
						    </div>
					        <div class="item33">
					                <input type="button" onclick="_search()" value="过滤" />
					                <input type="button" onclick="cleanSearch()" value="取消" />
					                <input type="button" onclick="hiddenSearchForm()" value="隐藏" />
					        </div>         
				        </div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="createCheckList"></table>
				</div>
			</div>
		</div>
		<div title="已完成的审批">
			<!--展开之后的content-part所显示的内容-->
			<!-- <table id="createHistoryList" ></table> -->
			<div id="checkHistorySearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:103px; overflow: hidden;">
					<form id="searchHistoryForm">
					<div class="partnavi_zoc"><span>查询与操作：</span></div>
					<div class="oneline">
						<div class="item25">
							<div class="itemleft60">议付发票号：</div>
			                <div class="righttext"><input name="negoInvoiceNum" /></div>
						</div>
						<div class="item25">
							<div class="itemleft60">订单号：</div>
			                <div class="righttext"><input name="orderCode" /></div>
						</div>
						<div class="item25">
							<div class="itemleft60">出运期：</div>
							<div class="rightselect_easyui">
							<input id="orderShipDateStart" name="orderShipDateStart"
								style="width: 120px;margin-left: 1px;" class="easyui-datebox" editable="false" />
							</div>
						</div>
						<div class="item25">
							<div class="itemleft60">至：</div>
							<div class="rightselect_easyui">
							<input id="orderShipDateStart" name="orderShipDateEnd"
								style="width: 120px;margin-left: 1px;" class="easyui-datebox" editable="false" />
							</div>
						</div>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft60">市场中心：</div>
				                <div class="righttext">	<input name="saleArea" class="easyui-combobox short60"
										style="width: 130px" 
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.action?itemType=3'" /></div>
							</div>
							<div class="item25">
								<div class="itemleft60">客户：</div>
				                <div class="righttext_easyui">
									<input type="text" class="short50" name="customerCode" id="custCodeIdHis"/>
								</div>
							</div>
							<div class="item25">
								<div class="itemleft60">单证经理：</div>
				                <div class="rightselect_easyui">
								<input id="docManagerHis" name="docManager"   type="text" class="short50" />
							    </div>
							   </div>
						<div class="item33 lastitem">
				           	<div class="oprationbutt">
				                <input type="button" onclick="historySearch()" value="过滤" />
				                <input type="button" onclick="historyClean()" value="取消" />
				                <input type="button" onclick="hiddenHistorySearch()" value="隐藏" />
				            </div>         
				        </div>
				        </div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="createHistoryList"></table>
				</div>
			</div>
		</div>
		<div title="未寄单订单">
			<div id="sendCheckSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:113px; overflow: hidden;">
					<form id="sendSearchForm">
					<div class="partnavi_zoc"><span>查询与操作：</span></div>
					<div class="oneline">
						<div class="item25">
							<div class="itemleft60">订单号：</div>
			                <div class="righttext"><input name="orderCode" /></div>
						</div>
						<div class="item25">
							<div class="itemleft60">出运期：</div>
							<div class="rightselect_easyui">
							<input id="orderShipDateStart" name="orderShipDateStart"
								style="width: 120px;margin-left: 1px;" class="easyui-datebox" editable="false" />
							</div>
						</div>
						<div class="item25">
							<div class="itemleft60">至：</div>
							<div class="rightselect_easyui">
							<input id="orderShipDateStart" name="orderShipDateEnd"
								style="width: 120px;margin-left: 1px;" class="easyui-datebox" editable="false" />
							</div>
						</div>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft60">市场中心：</div>
				                <div class="righttext">	<input name="saleArea" class="easyui-combobox short60"
										style="width: 130px" 
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.action?itemType=3'" /></div>
							</div>
							<div class="item25">
								<div class="itemleft60">客户：</div>
				                <div class="righttext_easyui">
									<input type="text" class="short50" name="customerCode" id="custCodeId"/>
								</div>
							</div>
							<div class="item25">
								<div class="itemleft60">单证经理：</div>
				                <div class="rightselect_easyui">
								<input id="docManager" name="docManager"   type="text" class="short50" />
							    </div>
							   </div>
						</div>
						<div class="item33 lastitem">
				           	<div class="oprationbutt">
				                <input type="button" onclick="_sendSearch()" value="过滤" />
				                <input type="button" onclick="sendCleanSearch()" value="取消" />
				                <input type="button" onclick="hiddenSearchForm()" value="隐藏" />
				            </div>         
				        </div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="querySendWaiteTaskList"></table>
				</div>
			</div>
		</div>
		<div title="已寄单订单">
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:113px; overflow: hidden;">
					<form id="sendHistroySearchForm">
					<div class="partnavi_zoc"><span>查询与操作：</span></div>
					<div class="oneline">
						<div class="item25">
							<div class="itemleft60">订单号：</div>
			                <div class="righttext"><input name="orderCode" /></div>
						</div>
						<div class="item25">
							<div class="itemleft60">出运期：</div>
							<div class="rightselect_easyui">
							<input id="orderShipDateStart" name="orderShipDateStart"
								style="width: 120px;margin-left: 1px;" class="easyui-datebox" editable="false" />
							</div>
						</div>
						<div class="item25">
							<div class="itemleft60">至：</div>
							<div class="rightselect_easyui">
							<input id="orderShipDateStart" name="orderShipDateEnd"
								style="width: 120px;margin-left: 1px;" class="easyui-datebox" editable="false" />
							</div>
						</div>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft60">市场中心：</div>
				                <div class="righttext">	<input name="saleArea" class="easyui-combobox short60"
										style="width: 130px" 
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.action?itemType=3'" /></div>
							</div>
							<div class="item25">
								<div class="itemleft60">客户：</div>
				                <div class="righttext_easyui">
									<input type="text" class="short50" name="customerCode" id="custCodeId"/>
								</div>
							</div>
							<div class="item25">
								<div class="itemleft60">单证经理：</div>
				                <div class="rightselect_easyui">
								<input id="docManager" name="docManager"   type="text" class="short50" />
							    </div>
							   </div>
						</div>
						<div class="item33 lastitem">
				           	<div class="oprationbutt">
				                <input type="button" onclick="_sendHistroySearch()" value="过滤" />
				                <input type="button" onclick="sendHistroyCleanSearch()" value="取消" />
				                <input type="button" onclick="hiddenSearchForm()" value="隐藏" />
				            </div>         
				        </div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="querySendHistroyTaskList"></table>
				</div>
			</div>
		</div>
	</div>
	<div id="createConferPayDialog"
		style="display: none; width: 900px; height: 429px;">
		<form id="conferPayDialogForm">
			<input name="taskIds" type="hidden"/>
			<table  style="width: 100%;" class="form_table">
				<tr>
					<th>发票号:</th>
					<td><input name="invoiceNum" class="noLine" readonly="readonly"></td>
					<th>合同号:</th>
					<td><input name="contractCode" class="noLine" readonly="readonly"></td>
				</tr>
				<tr>
					<th>经营体:</th>
					<td><input name="deptName" class="noLine" readonly="readonly"></td>
					<th>经营体长:</th>
					<td><input name="orderCustNamager" class="noLine" readonly="readonly"></td>
				</tr>
				<tr>
					<th>订单经理:</th>
					<td><input name="orderExecManager" class="noLine" readonly="readonly"></td>
					<th>制发票时间:</th>
					<td><input name="created" class="noLine" readonly="readonly"></td>
				</tr>
				<tr>
					<th>制单人:</th>
					<td><input name="createdBy" class="noLine" readonly="readonly"></td>
					<th>议付单据发票号:</th>
					<td><input name="negoInvoiceNum" class="easyui-validatebox" data-options="required:true,validType:'length[0,40]'" missingMessage="请填写议付单据发票号!"></td>
				</tr>
				<tr>
					<th>议付通过:</th>
					<td colspan="3"><input name="orderNegoSubject"  class="noLine" readonly="readonly" style="width:99%;"></td>
				</tr>
				<tr>
					<th>订单号:</th>
					<td colspan="3"><input name="orderCodes"  class="noLine" readonly="readonly" style="width:99%;"></td>
				</tr>
				<tr>
					<th>备注:</th>
					<td colspan="2"><textarea style="width:99%;height: 40px;" rows="10" cols="155"  name="remark"></textarea></td>
				</tr>
			</table>
		</form>
		<div region="center" style="height: 300px">
			<table id="findOrderItemsList"></table>
		</div>
	</div>
		 <!-- 单证经理下拉选信息 -->
	<div id="_DOC">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_DOCCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">单证经理：</div>
				<div class="righttext">
					<input class="short50" id="_DOCINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getDocManager('_DOCCODE','_DOCINPUT','docManager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanDocManager('_DOCCODE','_DOCINPUT','docManager')" />
				</div>
			</div>
		</div>
	</div>
		<div id="_CNNQUERY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUT2" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名称：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item100">
				<div class="oprationbutt">
					<input type="button" value="查询"
						onclick="CCNMY('_CNNINPUT','_CNNINPUT2','custCodeId')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_DOCHIS">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_DOCCODEHIS" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">单证经理：</div>
				<div class="righttext">
					<input class="short50" id="_DOCINPUTHIS" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getDocManager('_DOCCODEHIS','_DOCINPUTHIS','docManagerHis')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanDocManager('_DOCCODEHIS','_DOCINPUTHIS','docManagerHis')" />
				</div>
			</div>
		</div>
	</div>
		<div id="_CNNQUERYHIS">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUT2HIS" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名称：</div>
				<div class="righttext">
					<input class="short50" id="_CNNINPUTHIS" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item100">
				<div class="oprationbutt">
					<input type="button" value="查询"
						onclick="CCNMY('_CNNINPUTHIS','_CNNINPUT2HIS','custCodeIdHis')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>