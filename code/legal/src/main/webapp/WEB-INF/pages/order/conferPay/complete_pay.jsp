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
	var orderCheckList;
	var conferPayDialogForm;
	var sopOrderCheckList;
	var sopConferPayDialogForm;
	var sopCreateHistoryList;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
	    searchHistoryForm = $('#searchHistoryForm').form();
	    orderCheckList = $('#orderCheckList').datagrid({
			url : 'conferpayAction!checkTask.do?definitionKey=${definitionKey}',
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
			idField : 'ORDER_CODE',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.orderCode;
						}
					},
			   {field:'ORDER_CODE',title:'订单编号',align:'center',sortable:true,
					formatter:function(value,row,index){
						var img;
						if(row.ORDER_TYPE=='9'){//如果是收费备件订单，属于人工节点
							if(row.assignee&&row.assignee!='null'){
								img="<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
							}else{
								img="<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
							}
						}else{
							img=''
						}
						return "<a href='javascript:void(0)' style='color:blue' >"+img+row.ORDER_CODE+"</a>";
					}
				},	
				{field:'ORDER_TYPE_NAME',title:'订单类型',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.ORDER_TYPE_NAME;
					}
				},
			   {field:'ORDER_PO_CODE',title:'客户PO NO.',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.ORDER_PO_CODE;
					}
				},				
			   {field:'ORDER_SETTLEMENT_TYPE',title:'订单结算类型',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.ORDER_SETTLEMENT_TYPE;
					}
				},								
			   {field:'DEPT_NAME',title:'经营体',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.DEPT_NAME;
					}
				},				
			   {field:'COUNTRY_NAME',title:'出口国家',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.COUNTRY_NAME;
					}
				},				
			   {field:'PROD_MANAGER',title:'产品经理',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.PROD_MANAGER;
					}
				},				
			   {field:'CUSTOMER_NAME',title:'客户',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.CUSTOMER_NAME;
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
			 toolbar:[
				{
					text : '完成议付(收费备件订单)',
					iconCls : 'icon-ok',
					handler : function() {
						conferPayComplete();
					}
				}, '-', {
					text : '获取HOPE议付信息(其他订单类型)',
					iconCls : 'icon-ok',
					handler : function() {
						conferPay();
					}
			}, '-'],
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
	    sopOrderCheckList = $('#sopOrderCheckList').datagrid({
			url : 'conferpayAction!checkTask.do?definitionKey=${definitionKey}&sopFlag=1',
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
			idField : 'ORDER_CODE',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.orderCode;
						}
					},
			   {field:'ORDER_CODE',title:'订单编号',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						var img;
						if(row.ORDER_TYPE=='9'){//如果是收费备件订单，属于人工节点
							if(row.assignee&&row.assignee!='null'){
								img="<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
							}else{
								img="<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
							}
						}else{
							img=''
						}
						return "<a href='javascript:void(0)' style='color:blue' >"+img+row.ORDER_CODE+"</a>";
					}
				},	
				{field:'ORDER_TYPE_NAME',title:'订单类型',align:'center',width:110,
					formatter:function(value,row,index){
						return row.ORDER_TYPE_NAME;
					}
				},
			   {field:'ORDER_PO_CODE',title:'客户PO NO.',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						return row.ORDER_PO_CODE;
					}
				},				
			   {field:'ORDER_SETTLEMENT_TYPE',title:'订单结算类型',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						return row.ORDER_SETTLEMENT_TYPE;
					}
				},								
			   {field:'DEPT_NAME',title:'经营体',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						return row.DEPT_NAME;
					}
				},				
			   {field:'COUNTRY_NAME',title:'出口国家',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						return row.COUNTRY_NAME;
					}
				},				
			   {field:'PROD_MANAGER',title:'产品经理',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						return row.PROD_MANAGER;
					}
				},				
			   {field:'CUSTOMER_NAME',title:'客户',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						return row.CUSTOMER_NAME;
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
			 toolbar:[
				{
					text : '完成议付(收费备件订单)',
					iconCls : 'icon-ok',
					handler : function() {
						sopConferPayComplete();
					}
				}, '-'],
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
			   {field:'orderCode',title:'订单编号',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
			   {field:'orderPoCode',title:'客户PO NO.',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderPoCode;
					}
				},				
			   {field:'orderSettlementType',title:'订单结算类型',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderSettlementType;
					}
				},				
			   {field:'factoryName',title:'经营主体',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.factoryName;
					}
				},				
			   {field:'deptName',title:'经营体',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.deptName;
					}
				},				
			   {field:'countryName',title:'出口国家',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.countryName;
					}
				},				
			   {field:'orderProdManager',title:'产品经理',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderProdManager;
					}
				},				
			   {field:'customerName',title:'终端客户',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.customerName;
					}
				},
				{field:'negoInvoiceNum',title:'议付发票号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.negoInvoiceNum;
					}
				}
			 ] ],
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
	    sopCreateHistoryList = $('#sopCreateHistoryList').datagrid({
			url : 'conferpayAction!histroyConferTask.do?definitionKey=${definitionKey}&taskType=my&taskId=${taskId}&sopFlag=1',
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
			   {field:'orderCode',title:'订单编号',align:'center',sortable:true,width:110,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
			   {field:'orderPoCode',title:'客户PO NO.',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderPoCode;
					}
				},				
			   {field:'orderSettlementType',title:'订单结算类型',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderSettlementType;
					}
				},				
			   {field:'factoryName',title:'经营主体',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.factoryName;
					}
				},				
			   {field:'deptName',title:'经营体',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.deptName;
					}
				},				
			   {field:'countryName',title:'出口国家',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.countryName;
					}
				},				
			   {field:'orderProdManager',title:'产品经理',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderProdManager;
					}
				},				
			   {field:'customerName',title:'终端客户',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.customerName;
					}
				},
				{field:'negoInvoiceNum',title:'议付发票号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.negoInvoiceNum;
					}
				}
			 ] ],
			 toolbar:[
						{
							text : '回退',
							iconCls : 'icon-ok',
							handler : function() {
								rollBreak();
							}
						}, '-'],
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
	});
	function rollBreak(){
		var rows = sopCreateHistoryList.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要将当前所选订单完成议付？', function(r) {
				if (r) {
					var orderCodes="";
					var taskIds="";
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1) {
							orderCodes = orderCodes + rows[i].orderCode+",";
							taskIds = taskIds + rows[i].executionId+",";
						} else {
							orderCodes = orderCodes+ rows[i].orderCode;
							taskIds = taskIds+ rows[i].executionId;
						}
					}
					$.ajax({
						url : 'negoOrderAction!rollBreakConferPay.do',
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
								sopCreateHistoryList.datagrid('load');
								sopCreateHistoryList.datagrid('unselectAll');
								$.messager.progress('close');
							}else{
								$.messager.alert('提示', response.msg, 'error');
							}
						}
					});
				}
			});
		}else {
			$.messager.alert('提示', '请选择要回退的订单！', 'error');
		}
	}
	//完成议付
	function sopConferPayComplete(){
		var rows = sopOrderCheckList.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要将当前所选订单完成议付？', function(r) {
				if (r) {
					var orderCodes="";
					var taskIds="";
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1) {
							orderCodes = orderCodes + rows[i].ORDER_CODE+",";
							taskIds = taskIds + rows[i].EXECUTION_ID+",";
						} else {
							orderCodes = orderCodes+ rows[i].ORDER_CODE;
							taskIds = taskIds+ rows[i].EXECUTION_ID;
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
								sopOrderCheckList.datagrid('load');
								sopOrderCheckList.datagrid('unselectAll');
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
	//完成议付
	function conferPayComplete(){
		var rows = orderCheckList.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要将当前所选订单完成议付？', function(r) {
				if (r) {
					var orderCodes="";
					var taskIds="";
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1) {
							orderCodes = orderCodes + rows[i].ORDER_CODE+",";
							taskIds = taskIds + rows[i].EXECUTION_ID+",";
						} else {
							orderCodes = orderCodes+ rows[i].ORDER_CODE;
							taskIds = taskIds+ rows[i].EXECUTION_ID;
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
								orderCheckList.datagrid('load');
								orderCheckList.datagrid('unselectAll');
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
				if (response.success) {
					$.messager.show({
						title : '成功',
						msg : '获取HOPE议付信息完成'
					});
				}else{
					$.messager.alert('提示', response.msg, 'error');
				}
				
				$('div.validatebox-tip').remove();
				orderCheckList.datagrid('load');
				orderCheckList.datagrid('unselectAll');
				$.messager.progress('close');
			}
		});
	}
	function traceImg(rowIndex){
		var obj=$("#orderCheckList").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title:obj.ORDER_TYPE_NAME+"-订单号:"+obj.ORDER_CODE+"-流程图",
			url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+obj.PROCESSINSTANCE_ID,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	
	function _search(){
		$('#orderCheckList').datagrid({url:"conferpayAction!checkTask.do?definitionKey=${definitionKey}&"+searchForm.serialize()});
	}
	function hiddenSearchForm(){
		$("#checkSearch").layout("collapse","north");
	}
	function cleanSearch(){
		$('#orderCheckList').datagrid({url:"conferpayAction!checkTask.do?definitionKey=${definitionKey}"});
		searchForm.form('clear');
	}
	function _sopSearch(){
		$('#sopOrderCheckList').datagrid({url:"conferpayAction!checkTask.do?definitionKey=${definitionKey}&sopFlag=1&"+searchForm.serialize()});
	}
	function sopHiddenSearchForm(){
		$("#sopCheckSearch").layout("collapse","north");
	}
	function sopCleanSearch(){
		$('#sopOrderCheckList').datagrid({url:"conferpayAction!checkTask.do?definitionKey=${definitionKey}&sopFlag=1"});
		searchForm.form('clear');
	}
	function historySearch(){
		$('#createHistoryList').datagrid({url:"conferpayAction!histroyConferTask.do?definitionKey=${definitionKey}&taskType=my&"+searchHistoryForm.serialize()});
	}
	function hiddenHistorySearch(){
		$("#checkHistorySearch").layout("collapse","north");
	}
	function historyClean(){
		$('#createHistoryList').datagrid({url:"conferpayAction!histroyConferTask.do?definitionKey=${definitionKey}&taskType=my"});
		searchHistoryForm.form('clear');
	}
	function sopHistorySearch(){
		$('#sopCreateHistoryList').datagrid({url:"conferpayAction!histroyConferTask.do?definitionKey=${definitionKey}&taskType=my&sopFlag=1&"+searchHistoryForm.serialize()});
	}
	function sopHiddenHistorySearch(){
		$("#sopCheckHistorySearch").layout("collapse","north");
	}
	function sopHistoryClean(){
		$('#sopCreateHistoryList').datagrid({url:"conferpayAction!histroyConferTask.do?definitionKey=${definitionKey}&taskType=my&sopFlag=1"});
		searchHistoryForm.form('clear');
	}
</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true" >
		<div title="待办审批">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:53px; overflow: hidden;">
					<form id="searchForm">
					<div class="partnavi_zoc"><span>订单查询：</span></div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">订单号：</div>
			                <div class="righttext"><input name="orderCode"  class="orderAutoComple"/></div>
						</div>
						<div class="item50 lastitem">
				           	<div class="oprationbutt">
				                <input type="button" onclick="_search()" value="过滤" />
				                <input type="button" onclick="cleanSearch()" value="取消" />
				                <input type="button" onclick="hiddenSearchForm()" value="隐藏" />
				            </div>         
				        </div>
					</div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="orderCheckList"></table>
				</div>
			</div>
		</div>
		<div title="已完成的审批">
			<!--展开之后的content-part所显示的内容-->
			<!-- <table id="createHistoryList" ></table> -->
			<div id="checkHistorySearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:53px; overflow: hidden;">
					<form id="searchHistoryForm">
					<div class="partnavi_zoc"><span>订单查询：</span></div>
					<div class="oneline">
						<div class="item25">
							<div class="itemleft80">议付发票号：</div>
			                <div class="righttext"><input name="negoInvoiceNum"  style="width: 130px;"/></div>
						</div>
						<div class="item25">
							<div class="itemleft60">订单号：</div>
			                <div class="righttext"><input name="orderCode" class="orderAutoComple"/></div>
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
		<div title="备件订单待办审批">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:53px; overflow: hidden;">
					<form id="searchForm">
					<div class="partnavi_zoc"><span>订单查询：</span></div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">订单号：</div>
			                <div class="righttext"><input name="orderCode"  class="orderAutoComple"/></div>
						</div>
						<div class="item50 lastitem">
				           	<div class="oprationbutt">
				                <input type="button" onclick="_sopSearch()" value="过滤" />
				                <input type="button" onclick="sopCleanSearch()" value="取消" />
				                <input type="button" onclick="sopHiddenSearchForm()" value="隐藏" />
				            </div>         
				        </div>
					</div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="sopOrderCheckList"></table>
				</div>
			</div>
		</div>
		<div title="已完成的备件订单审批">
			<!--展开之后的content-part所显示的内容-->
			<!-- <table id="createHistoryList" ></table> -->
			<div id="checkHistorySearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:53px; overflow: hidden;">
					<form id="searchHistoryForm">
					<div class="partnavi_zoc"><span>订单查询：</span></div>
					<div class="oneline">
						<div class="item25">
							<div class="itemleft80">议付发票号：</div>
			                <div class="righttext"><input name="negoInvoiceNum"  style="width: 130px;"/></div>
						</div>
						<div class="item25">
							<div class="itemleft60">订单号：</div>
			                <div class="righttext"><input name="orderCode" class="orderAutoComple"/></div>
						</div>
						<div class="item33 lastitem">
				           	<div class="oprationbutt">
				                <input type="button" onclick="sopHistorySearch()" value="过滤" />
				                <input type="button" onclick="sopHistoryClean()" value="取消" />
				                <input type="button" onclick="sopHiddenHistorySearch()" value="隐藏" />
				            </div>         
				        </div>
					</div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="sopCreateHistoryList"></table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>