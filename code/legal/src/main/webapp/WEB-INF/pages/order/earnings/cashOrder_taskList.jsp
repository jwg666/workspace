<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
	    datagrid = $('#datagrid').datagrid({
			url : 'cashOrderAction!checkTask.do?definitionKey=${definitionKey}',
			title : '<s:text name="order.earnings.list.name">收汇列表</s:text>',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			nowrap : true,
			border : false,
			idField : 'orderCode',
			
			
			frozenColumns:[ [ 
 				{field:'ck',checkbox:true,
 					formatter:function(value,row,index){
 						return row.orderCode;
 					}
 				},
 				{field:'orderCode',title:'<s:text name="global.order.number">订单编号</s:text>',align:'center',sortable:true,width:100,
 					formatter:function(value,row,index){
 						var img;
						if(row.assignee&&row.assignee!='null'){
						img="<img width='16px' height='16px' title='<s:text name='global.info.mytask'>个人任务</s:text>' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
						}else{
						img="<img width='16px' height='16px' title='<s:text name='global.info.grouptask'>未认领的组任务</s:text>' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
						}
						return "<a href='javascript:void(0)' style='color:blue' onclick='detailCheck1(\""+row.taskId+"\")'>"+img+row.orderCode+"</a>";
 					}
 				},{
 					field : 'dueDate',
 					title : '计划完成时间',
 					align : 'center',
 					width : 100,
 					formatter : function(value, row, index) {
 						return dateFormatYMD(row.dueDate);
 					}
 				},
 				{field:'customerName',title:'<s:text name="global.order.customerName">客户名称</s:text>',align:'center',sortable:true,width:200,
 					formatter:function(value,row,index){
 						return row.customerName;
 					}
 				},
 				{field:'countryName',title:'<s:text name="global.order.countryName">出口国家</s:text>',align:'center',sortable:true,width:80,
 					formatter:function(value,row,index){
 						return row.countryName;
 					}
 				},
 				{field:'orderShipDate',title:'<s:text name="global.order.orderShipDate">出运时间</s:text>',align:'center',sortable:true,width:120,
 					formatter:function(value,row,index){
 						return row.orderShipDate;
 					}
 				}
 			] ],
 			columns : [ [ 
 				{field:'amount',title:'<s:text name="global.order.amount">付款保障金额</s:text>',align:'center',sortable:true,width:80,
 					formatter:function(value,row,index){
 						return row.amount;
 					}
 				},
 				{field:'paymentMethod',title:'<s:text name="global.order.paymentMethod">付款方式</s:text>',align:'center',sortable:true,width:70,
 					formatter:function(value,row,index){
 						return row.paymentMethod;
 					}
 				},
 			   {field:'payCode',title:'<s:text name="global.order.payCode">款项编号</s:text>',align:'center',sortable:true,width:100,
 					formatter:function(value,row,index){
 						return row.payCode;
 					}
 				},
 				{field:'ecreated',title:'<s:text name="order.earnings.ecreated">收汇时间</s:text>',align:'center',sortable:true,width:120,
 					formatter:function(value,row,index){
 						return row.ecreated;
 					}
 				},
 				{field:'cashMoney',title:'<s:text name="global.order.earnings.cashMoney">收汇金额</s:text>',align:'center',sortable:true,width:70,
 					formatter:function(value,row,index){
 						return row.cashMoney;
 					}
 				},
 			   {field:'ecurrency',title:'<s:text name="global.order.ecurrency">币种</s:text>',align:'center',sortable:true,width:70,
 					formatter:function(value,row,index){
 						return row.ecurrency;
 					}
 				},
 				{field:'taskId',title:'任务id',align:'center',sortable:true,width:90,hidden:true,
					formatter:function(value,row,index){
						return row.taskId;
					}
				},
 				{
					field : 'trace',
					title : '<s:text name="global.order.trace">流程跟踪</s:text>',
					align : 'center',
					width : 80,
					formatter : function(value, row, index) {
						return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg("+index+")'><s:text name='global.order.trace'>流程跟踪</s:text></a>";
					}
				}
 				
 			 ] ],
			/*  toolbar : [ {
					text : '<s:text name="order.earning.adopt">收汇通过</s:text>',
					iconCls : 'icon-check',
					handler : function() {
						revoke();
					}
				}, '-'], */
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
		//客户编号
		$('#CUSTOMER_CODE0').combogrid({
			url : '../basic/customerAction!datagrid0.action',
			textField : 'name',
			idField : 'customerId',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_CNNQUERYHISTORY',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ {
				field : 'name',
				title : '<s:text name="global.order.customerName">客户名称</s:text>',
				width : 20
			} ] ]
		});
		
		//加载国家信息
		$('#countryCode').combogrid({
			url:'${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_COUNTRY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 20,
				hidden : true
			},{
				field : 'name',
				title : '国家名称',
				width : 20
			}  ] ]
		});
		//已完成代办
	    searchHistoryForm = $('#searchHistoryForm').form();
	    historydatagrid = $('#historydatagrid').datagrid({
			url : 'cashOrderAction!histroyTask.do?definitionKey=${definitionKey}',
			title : '<s:text name="order.earnings.list.name">收汇列表</s:text>',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			nowrap : true,
			border : false,
			idField : 'orderNum',
			
			
			frozenColumns:[ [ 
				{field:'ck',checkbox:true,
					formatter:function(value,row,index){
						return row.orderNum;
					}
				},
				{field:'orderCode',title:'<s:text name="global.order.number">订单编号</s:text>',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},
				{field:'customerName',title:'<s:text name="global.order.customerName">客户名称</s:text>',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.customerName;
					}
				},
				{field:'countryName',title:'<s:text name="global.order.countryName">出口国家</s:text>',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.countryName;
					}
				},
				{field:'orderShipDate',title:'<s:text name="global.order.orderShipDate">出运时间</s:text>',align:'center',sortable:true,width:120,
					formatter:function(value,row,index){
						return row.orderShipDate;
					}
				},
			] ],
			columns : [ [ 
				{field:'amount',title:'<s:text name="global.order.amount">付款保障金额</s:text>',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.amount;
					}
				},
				{field:'paymentMethod',title:'<s:text name="global.order.paymentMethod">付款方式</s:text>',align:'center',sortable:true,width:70,
					formatter:function(value,row,index){
						return row.paymentMethod;
					}
				},
			   {field:'payCode',title:'<s:text name="global.order.payCode">款项编号</s:text>',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.payCode;
					}
				},
				{field:'ecreated',title:'<s:text name="order.earnings.ecreated">收汇时间</s:text>',align:'center',sortable:true,width:120,
					formatter:function(value,row,index){
						return row.ecreated;
					}
				},
				{field:'cashMoney',title:'<s:text name="global.order.cashMoney">收汇金额</s:text>',align:'center',sortable:true,width:70,
					formatter:function(value,row,index){
						return row.cashMoney;
					}
				},
			   {field:'ecurrency',title:'<s:text name="global.order.ecurrency">币种</s:text>',align:'center',sortable:true,width:70,
					formatter:function(value,row,index){
						return row.ecurrency;
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
	    
	    
	  	//客户编号
		$('#CUSTOMER_CODE').combogrid({
			url : '../basic/customerAction!datagrid0.action',
			textField : 'name',
			idField : 'customerId',
			panelWidth : 500,
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
			columns : [ [ {
				field : 'name',
				title : '<s:text name="global.order.customerName">客户名称</s:text>',
				width : 20
			} ] ]
		});
		//加载国家信息
		$('#countryCodeFinish').combogrid({
			url:'${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_COUNTRYHISTORY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 20,
				hidden : true
			},{
				field : 'name',
				title : '国家名称',
				width : 20
			}  ] ]
		});
	});
	function detailCheck1(taskId){
		/* $.ajax({
			url : '${dynamicURL}/workflow/scheduleUrlAndTitleAction!titleAndUrl.action',
			data : {
				taskId : taskId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				idOfTask=response.taskId
				parent.window.HROS.window.close('zhps_'+taskId);
				var url='${dynamicURL}'+response.url+'&assignee='+assignee;
				//var url='techOrderAction!goModelManagerCheck.action';
				var appid = parent.window.HROS.window.createTemp({
					title:taskName+":-订单出运:"+orderCode,
					url:url,
					appid: 'zhps_'+taskId,
					width:1000,height:500,isresize:false,isopenmax:false,isflash:false,customWindow:window});
				//parent.window.HROS.window.close(appid);
			}
		}); */
		var url='${dynamicURL}/cashorder/cashOrderAction!goCashOrderDetail.action?taskId='+taskId;
		//var url='${dynamicURL}/shipOrder/shipOrderAction!goShipMent.action?taskId='+taskId;
		parent.window.HROS.window.close('cash_'+taskId);
		//打开详细办理页面
		parent.window.HROS.window.createTemp({
			title:'订单收汇',
			url:url,
			appid:'cash_'+taskId,
			width:1000,height:500,isresize:false,isopenmax:false,isflash:false,customWindow:window});
	}
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do?name=' + _CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	function traceImg(rowIndex){
		var obj=$("#datagrid").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title:obj.name+"-订单号:"+obj.orderCode+"-流程图",
			url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+obj.procInstId,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	function revoke(){
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		var taskIds = "";
		if (rows.length > 0) {
			$.messager.confirm('<s:text name="global.info.please.confirm">请确认</s:text>', '<s:text name="order.earning.complete.selected">您要通过当前收汇</s:text>？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1) {
							ids = ids + "ids=" + rows[i].lcNum + "&";
							taskIds = taskIds + "taskIds=" + rows[i].taskId
									+ "&";
						} else {
							ids = ids + "ids=" + rows[i].lcNum;
							taskIds = taskIds + "taskIds=" + rows[i].taskId;
						}
					}
					$.ajax({
						url : 'cashOrderAction!revoke.do',
						data : ids + "&" + taskIds,
						dataType : 'json',
						type : "post",
						success : function(response) {
							alert
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '<s:text name="global.form.prompt">提示</s:text>',
								msg : response.msg
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="order.earning.please.select.cashorder">请选择要通过的收汇</s:text>！', 'error');
		}
	}
	function _search() {
		datagrid.datagrid({url:"cashOrderAction!checkTask.do?definitionKey=${definitionKey}&"+searchForm.serialize()});
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function hiddenSearchForm(){
		$("#checkSearch").layout("collapse","north");
	}
	function historySearch(){
		historydatagrid.datagrid({url:"cashOrderAction!histroyTask.do?definitionKey=${definitionKey}&"+searchHistoryForm.serialize()});
	}
	function historyClean(){
		searchHistoryForm.form('clear');
		historydatagrid.datagrid({url:"cashOrderAction!histroyTask.do?definitionKey=${definitionKey}"});
	}
	function hiddenHistorySearch(){
		$("#HistorySearch").layout("collapse","north");
	}
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action?name=' + _CCNTEMP
		});
		$('#' + inputId).val(_CCNTEMP);
	}
	function reloaddatagrid(){
		datagrid.datagrid('reload');
	}
</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true" >
		<div title="收汇待办">
			<!--展开之后的content-part所显示的内容-->
						<div id="checkSearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:80px; overflow: hidden;">
					<form id="searchForm">
			      		<div class="partnavi_zoc"><span><s:text name="global.info.queriesAndoperations">查询与操作</s:text>：</span></div>
			            <div class="oneline">
				            <div class="item25">
								<div class="itemleft60"><s:text name="global.order.number">订单号</s:text></div>
								<div class="rightselect_easyui">
									<input name="orderNum" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft60"><s:text name="global.order.customerName">客户名称</s:text></div>
								<div class="rightselect_easyui">
<!-- 									<input name="customerName" class="easyui-combobox" style="width:170px;" -->
<%-- 									 	data-options="valueField:'customerId',textField:'name',url:'${dynamicURL}/basic/customerAction!combox.do'" /> --%>
									<input type="text" class="easyui-combobox short100"
										id="CUSTOMER_CODE0" name="customerName"></input>
								</div>
							</div>
							<div class="item25">
								<div class="itemleft60">国家：</div>
								<div class="rightselect_easyui">
									<input id="countryCode" name="countryCode" class="short50"  type="text" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft60"><s:text name="global.order.orderShipDate">出运时间</s:text></div>
								<div class="rightselect_easyui">
									<input name=orderShipDate class="easyui-datebox" editable="false" style="width: 155px;" />
								</div>
							</div>
							<div class="item50 lastitem">
			                    <div class="oprationbutt">
			                        <input type="button" onclick="_search()" value="<s:text name="global.form.filter">过滤</s:text>" />
			                        <input type="button" onclick="cleanSearch()" value="<s:text name="global.form.cancel">取消</s:text>" />
			                        <input type="button" onclick="hiddenSearchForm()" value="<s:text name="pcm.distributor.state_hidden">隐藏</s:text>" />
			                    </div>
				             </div>
						</div>
			        </form>
				</div>
				<div region="center" border="false">
					<table id="datagrid" ></table>
				</div>
			</div>
		</div>
		<div title="收汇已完成">
			<!--展开之后的content-part所显示的内容-->
				<div id="HistorySearch" class="easyui-layout" fit="true">
				<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="true" style="height:80px; overflow: hidden;">
					<form id="searchHistoryForm">
						<div class="partnavi_zoc"><span><s:text name="global.info.queriesAndoperations">查询与操作</s:text>：</span></div>
			            <div class="oneline">
				            <div class="item25">
								<div class="itemleft60"><s:text name="global.order.number">订单号</s:text></div>
								<div class="rightselect_easyui">
									<input name="orderNum" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft60"><s:text name="global.order.customerName">客户名称</s:text></div>
								<div class="rightselect_easyui">
<!-- 									<input name="customerName" class="easyui-combobox" style="width:170px;" -->
<%-- 									 	data-options="valueField:'customerId',textField:'name',url:'${dynamicURL}/basic/customerAction!combox.do'" /> --%>
								<input type="text" class="easyui-combobox short100"
											id="CUSTOMER_CODE" name="customerName"></input>
								</div>
							</div>
							 <div class="item25">
								<div class="itemleft60">国家：</div>
								<div class="rightselect_easyui">
									<input id="countryCodeFinish" name="countryCode" class="short50"  type="text" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item25">
								<div class="itemleft60"><s:text name="global.order.orderShipDate">出运时间</s:text></div>
								<div class="rightselect_easyui">
									<input name=orderShipDate class="easyui-datebox" editable="false" style="width: 155px;" />
								</div>
							</div>
							<div class="item50 lastitem">
			                    <div class="oprationbutt">
			                        <input type="button" onclick="historySearch()" value="<s:text name="global.form.filter">过滤</s:text>" />
			                        <input type="button" onclick="historyClean()" value="<s:text name="global.form.cancel">取消</s:text>" />
			                        <input type="button" onclick="hiddenHistorySearch()" value="<s:text name="pcm.distributor.state_hidden">隐藏</s:text>" />
			                    </div>
				            </div>
						</div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="historydatagrid" ></table>
				</div>
			</div>
		</div>
	</div>
	<div id="_CNNQUERY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60"><s:text name="global.order.customerName">客户名称</s:text>：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="<s:text name="global.form.select">查询</s:text>"
						onclick="_CCNMY('_CNNINPUT','CUSTOMER_CODE')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_CNNQUERYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60"><s:text name="global.order.customerName">客户名称</s:text>：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPUTHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="<s:text name="global.form.select">查询</s:text>"
						onclick="_CCNMY('_CNNINPUTHISTORY','CUSTOMER_CODE0')" />
				</div>
			</div>
		</div>
	</div>
	
		<!-- 国家下拉选 -->
	<div id="_COUNTRY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('_COUNTRYINPUT','countryCode')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_COUNTRYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUTHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('_COUNTRYINPUTHISTORY','countryCodeFinish')" />
				</div>
			</div>
		</div>
	</div>
	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="add();" iconCls="icon-add"><s:text name="global.info.add">增加</s:text></div>
		<div onclick="del();" iconCls="icon-remove"><s:text name="global.form.delete">删除</s:text></div>
		<div onclick="edit();" iconCls="icon-edit"><s:text name="global.form.edit">编辑</s:text></div>
	</div>
</body>
</html>