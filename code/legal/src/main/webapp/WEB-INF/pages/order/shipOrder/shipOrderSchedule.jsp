<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var historyDatagrid;
	var orderCheckDialog;
	var orderCheckForm;
	var dialog;
	
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		searchHistoryForm = $('#searchHistoryForm').form();
		
		//custCodeId客户编号
		$('#custCodeId').combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action',
			idField:'customerId',
			textField : 'name',
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
		$('#hiscustCodeId').combogrid({
			url : '../basic/customerAction!datagrid0.action',
			idField:'customerId',
			textField : 'name',
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
		
		
		//加载国家信息
		$('#countryIdtask').combogrid({
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
				width : 20
			},{
				field : 'name',
				title : '国家名称',
				width : 20
			}  ] ]
		});
		//加载国家信息
		$('#countryIdHistory').combogrid({
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
				width : 20
			},{
				field : 'name',
				title : '国家名称',
				width : 20
			}  ] ]
		});
		//加载目的港信息
		$('#endPortIdtask').combogrid({
		    url:'${dynamicURL}/basic/portAction!datagrid.action',
			idField:'portCode',  
		    textField:'portName',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_PORTEND',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'portCode',
				title : '目的港编码',
				width : 20
			},{
				field : 'englishName',
				title : '目的港名称',
				width : 20
			}  ] ]
		});
		
		//加载目的港信息
		$('#endPortIdHistory').combogrid({
			 url:'${dynamicURL}/basic/portAction!datagrid.action',
				idField:'portCode',  
			    textField:'portName',
				panelWidth : 500,
				panelHeight : 220,
				pagination : true,
				pagePosition : 'bottom',
				toolbar : '#_PORTENDHISTORY',
				rownumbers : true,
				pageSize : 5,
				pageList : [ 5, 10 ],
				fit : true,
				fitColumns : true,
				columns : [ [ {
					field : 'portCode',
					title : '目的港编码',
					width : 20
				},{
					field : 'englishName',
					title : '目的港名称',
					width : 20
				}  ] ]
		});
		
		//运输公司
		$('#shipNametaskId').combogrid({
			url : '${dynamicURL}/basic/vendorAction!datagrid0.do',
			idField : 'vendorCode',
			textField : 'vendorNameCn',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_VENDERTASK',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			//required:true,
			columns : [ [ {
				field : 'vendorCode',
				title : '船公司编号',
				width : 10
			}, {
				field : 'vendorNameCn',
				title : '船公司名称',
				width : 10
			} ] ]
		});
		//运输公司
		$('#shipCompanyHistory').combogrid({
			url : '${dynamicURL}/basic/vendorAction!datagrid0.do',
			idField : 'vendorCode',
			textField : 'vendorNameCn',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_VENDERHISTORY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			//required:true,
			columns : [ [ {
				field : 'vendorCode',
				title : '船公司编号',
				width : 10
			}, {
				field : 'vendorNameCn',
				title : '船公司名称',
				width : 10
			} ] ]
		});
		historyDatagrid=$("#orderHistoryList").datagrid({
			url : '${dynamicURL}/shipOrder/shipOrderAction!showHistorySchedule.do?',
			rownumbers : true,
			// 				pagination : true,
			// 				pagePosition : 'bottom',
			// 				rownumbers : true,
			// 				pageSize : 10,
			// 				pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			pagination:true,
			pageList:[10],
			nowrap : true,
			border : false,
			//idField : 'kdOrderId',
			
			scrollbarSize:10,
			onDblClickRow : function(rowIndex, rowData) {
				detailCheck(rowIndex);
			},
			toolbar : [ {
				text : '重传HOP(创建PO)',
				iconCls : 'icon-check',
				handler : function() {
					quickchuans();
				}
			}
			<s:if test='ifoem==null||ifoem==""||ifoem=="yes"'>
			,{
				text : '重传HOP(装船发运)',
				iconCls : 'icon-check',
				handler : function() {
					quickchuans1();
				}
			}
			</s:if>
			],
			frozenColumns:[ [ 
			    {field:'ck',checkbox:true,
					formatter:function(value,row,index){
						return row.kdOrderId;
					}
				}/* ,{
					field : 'prepareCode',
					title : '备货单号',
					align : 'center',	
					width : 100,
					formatter : function(value, row, index) {
						return row.prepareCode;
					}	
				} */,{
				field : 'orderCode',
				title : '订单号',
				align : 'center',			
				width : 120,
				formatter : function(value, row, index) {
					
					return "<a href='javascript:void(0)' style='color:blue' onclick='detailCheck2(\""+row.orderCode+"\",\""+row.taskName+"\")'> "+row.orderCode+"</a>";
				}
			}, {
				field : 'bookCode',
				title : '订舱号',
				align : 'center',
				width : 110,
				formatter : function(value, row, index) {
					return row.bookCode;
				}
			}, {
				field : 'taskName',
				title : '代办事项名称',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return row.taskName;
				}
			}, {
				field : 'orderShipDate',
				title : '出运期',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderShipDate);
				}
			}, {
				field : 'shipDate',
				title : '实际出运日期',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.shipDate);
				}
			}
			 ] ],
			columns : [ [ 
				{
					field : 'yfNum',
					title : '议付发票号',
					align : 'center',
					
					width : 100,
					formatter : function(value, row, index) {
						return row.yfNum;
					}
				},{
					field : 'billNum',
					title : '提单号',
					align : 'center',
					
					width : 100,
					formatter : function(value, row, index) {
						return row.billNum;
					}
				},
              {
				field : 'prodType',
				title : '产品大类',
				align : 'center',
				
				width : 100,
				formatter : function(value, row, index) {
					return row.prodType;
				}
			},{
				field : 'orderType',
				title : '订单类型',
				align : 'center',
				
				width : 100,
				formatter : function(value, row, index) {
					return row.orderType;
				}
			},{
				field : 'vendorName',
				title : '船公司',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return row.vendorName;
				}
			},{
				field : 'contractCode',
				title : '合同编号',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.contractCode;
				}
			}, {
				field : 'orderCustomDate',
				title : '要求到货期',
				align : 'center',

				width : 150,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderCustomDate);
				}
			}, {
				field : 'currency',
				title : '币种',
				align : 'center',

				width : 50,
				formatter : function(value, row, index) {
					return row.currency;
				}
			}, {
				field : 'paymentItems',
				title : '付款条件',
				align : 'center',

				width : 200,
				formatter : function(value, row, index) {
					return row.paymentItems;
				}
			}, {
				field : 'saleOrgName',
				title : '销售组织',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.saleOrgName;
				}
			}, {
				field : 'orderPoCode',
				title : '客户订单号',
				align : 'center',

				width : 200,
				formatter : function(value, row, index) {
					return row.orderPoCode;
				}
			}, {
				field : 'deptName',
				title : '经营体',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.deptName;
				}
			}, {
				field : 'customerManager',
				title : '经营体长',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.customerManager;
				}
			}, {
				field : 'startPort',
				title : '始发港',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.startPort;
				}
			}, {
				field : 'endPort',
				title : '目的港',
				align : 'center',

				width : 150,
				formatter : function(value, row, index) {
					return row.endPort;
				}
			}, {
				field : 'saleArea',
				title : '市场区域',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return '待定';
				}
			}, {
				field : 'customerName',
				title : '客户名称',
				align : 'center',
				width : 200,
				formatter : function(value, row, index) {
					return row.customerName;
				}
			}, {
				field : 'countryName',
				title : '出口国家',
				align : 'center',

				width : 80,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			}, {
				field : 'detailType',
				title : '成交方式',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.detailType;
				}
			}, {
				field : 'execmanagerName',
				title : '订单执行经理',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.execmanagerName;
				}
			}, {
				field : 'prodName',
				title : '产品经理',
				align : 'center',

				width : 80,
				formatter : function(value, row, index) {
					return row.prodName;
				}
			}, {
				field : 'transManager',
				title : '储运经理',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.transManager;
				}
			}, {
				field : 'docManager',
				title : '单证经理',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.docManager;
				}
			}, {
				field : 'recManager',
				title : '收汇经理',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.recManager;
				}
			},
			{
				field : 'trace',
				title : '流程追踪',
				align : 'center',
				width : 80,
				formatter : function(value, row, index) {
					return "<a href='javascript:void(0)' style='color:blue' onclick='traceImg1("+index+")'>流程跟踪</a>";
				}
			}
			 ] ],
			 onDblClickRow : function(rowIndex, rowData) {
					showDesc(rowData.orderCode);
				}
		});
		
		
		datagrid=$("#orderCheckList").datagrid({
			url : '${dynamicURL}/shipOrder/shipOrderAction!showShipMentSchedule.do',
			rownumbers : true,
			// 				pagination : true,
			// 				pagePosition : 'bottom',
			// 				rownumbers : true,
			// 				pageSize : 10,
			// 				pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			pagination:true,
			pageList:[10],
			nowrap : true,
			border : false,
			//idField : 'kdOrderId',
			
			scrollbarSize:10,
			onDblClickRow : function(rowIndex, rowData) {
				detailCheck(rowIndex);
			},
			toolbar : [ {
				text : '出运',
				iconCls : 'icon-check',
				handler : function() {
					quickCheck();
				}
			}/* , '-', {
				text : '申领',
				iconCls : 'icon-apply',
				handler : function() {
					quickApply();
				}} */  ,'-',/*  {
					text : '创建工作流',
					iconCls : 'icon-check',
					handler : function(){
						creatProcess();
					}
				}   */  ],
			frozenColumns:[ [ 
			    {field:'ck',checkbox:true,
					formatter:function(value,row,index){
					return row.kdOrderId;
					}
				}/* ,{
					field : 'prepareCode',
					title : '备货单号',
					align : 'center',	
					width : 100,
					formatter : function(value, row, index) {
					return row.prepareCode;
					}	
				} */,{
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				
				width : 120,
				formatter : function(value, row, index) {
					 var img;
					if(row.assignee&&row.assignee!='null'){
					img="<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
					}else{
					img="<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
					} 
					return "<a href='javascript:void(0)' style='color:blue' onclick='detailCheck1(\""+row.taskId+"\",\""+row.assignee+"\",\""+row.orderCode+"\",\""+row.taskName+"\")'> "+img+row.orderCode+"</a>";
				}
			}, {
				field : 'bookCode',
				title : '订舱号',
				align : 'center',
				width : 110,
				formatter : function(value, row, index) {
					return row.bookCode;
				}
			},{
				field : 'dueDate',
				title : '计划完成时间',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.dueDate);
				}
			}, {
				field : 'orderShipDate',
				title : '订单出运期',
				align : 'center',
				width : 100,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderShipDate);
				}
			} ,  {
				field : 'bookShipDate',
				title : '实际(订舱)出运日期',
				align : 'center',
				width : 150,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.bookShipDate);
				}
			} 
			 ] ],
			columns : [ [ {
				field : 'prodType',
				title : '产品大类',
				align : 'center',
				
				width : 100,
				formatter : function(value, row, index) {
					return row.prodType;
				}
			},{
				field : 'orderType',
				title : '订单类型',
				align : 'center',
				
				width : 100,
				formatter : function(value, row, index) {
					return row.orderType;
				}
			},{
				field : 'vendorName',
				title : '船公司',
				align : 'center',
				
				width : 100,
				formatter : function(value, row, index) {
					return row.vendorName;
				}
			},{
				field : 'contractCode',
				title : '合同编号',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.contractCode;
				}
			}, {
				field : 'orderCustomDate',
				title : '要求到货期',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderCustomDate);
				}
			}, {
				field : 'currency',
				title : '币种',
				align : 'center',

				width : 50,
				formatter : function(value, row, index) {
					return row.currency;
				}
			}, {
				field : 'paymentItems',
				title : '付款条件',
				align : 'center',

				width : 200,
				formatter : function(value, row, index) {
					return row.paymentItems;
				}
			}, {
				field : 'saleOrgName',
				title : '销售组织',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.saleOrgName;
				}
			}, {
				field : 'orderPoCode',
				title : '客户订单号',
				align : 'center',

				width : 200,
				formatter : function(value, row, index) {
					return row.orderPoCode;
				}
			}, {
				field : 'deptName',
				title : '经营体',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.deptName;
				}
			}, {
				field : 'customerManager',
				title : '经营体长',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.customerManager;
				}
			}, {
				field : 'startPort',
				title : '始发港',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.startPort;
				}
			}, {
				field : 'endPort',
				title : '目的港',
				align : 'center',

				width : 150,
				formatter : function(value, row, index) {
					return row.endPort;
				}
			}, {
				field : 'saleArea',
				title : '市场区域',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return '待定';
				}
			}, {
				field : 'customerName',
				title : '客户名称',
				align : 'center',
				width : 200,
				formatter : function(value, row, index) {
					return row.customerName;
				}
			}, {
				field : 'countryName',
				title : '出口国家',
				align : 'center',

				width : 80,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			}, {
				field : 'detailType',
				title : '成交方式',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.detailType;
				}
			}, {
				field : 'execmanagerName',
				title : '订单执行经理',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.execmanagerName;
				}
			}, {
				field : 'prodName',
				title : '产品经理',
				align : 'center',

				width : 80,
				formatter : function(value, row, index) {
					return row.prodName;
				}
			}, {
				field : 'transManager',
				title : '储运经理',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.transManager;
				}
			}, {
				field : 'docManager',
				title : '单证经理',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.docManager;
				}
			}, {
				field : 'recManager',
				title : '收汇经理',
				align : 'center',

				width : 100,
				formatter : function(value, row, index) {
					return row.recManager;
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
				onDblClickRow : function(rowIndex, rowData) {
					showDesc(rowData.orderCode);
				}
		});
	});
	//显示订单明细信息
	function showDesc(orderCode) {
		parent.window.HROS.window.createTemp({
			title : "订单号:" + orderCode,
			url : "${dynamicURL}/salesOrder/salesOrderAction!goSalesOrderDetailItem.action?orderCode=" + orderCode,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false
		});
	}
	function traceImg1(rowIndex){
		var obj=$("#orderHistoryList").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title:obj.taskName+"-订单号:"+obj.orderCode+"-流程图",
			url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+obj.processinstanceId,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	function traceImg(rowIndex){
		var obj=$("#orderCheckList").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
			title:obj.taskName+"-订单号:"+obj.orderCode+"-流程图",
			url:"${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+obj.processinstanceId,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	function _search() {
		$("#orderCheckList").datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		$("#orderCheckList").datagrid('load', {});
		searchForm.form('clear');
	}
	
	function _historySearch() {
		$("#orderHistoryList").datagrid('load', sy.serializeObject(searchHistoryForm));
	}
	function cleanHistorySearch() {
		$("#orderHistoryList").datagrid('load', {});
		searchHistoryForm.form('clear');
	}

	function detailCheck(rowIndex) {
		var obj=$("#orderCheckList").datagrid("getData").rows[rowIndex];
		parent.window.HROS.window.createTemp({
		title:obj.name+"-订单号:"+obj.kdOrderNum,
		url:"${dynamicURL}/courier/orderAction!goOrderCheck.do?aduitFlag=0&taskId="+obj.taskId,
		width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
	//启动一个工作流(暂时)
	function creatProcess(){
		var salesOrderCoder=$('#ordernumberid').val();
		$.ajax({
			url : '${dynamicURL}/shipOrder/shipOrderAction!create.do?',
		    data:{
		    	orderNum : salesOrderCoder
		    },
		    dataType:'json',
		    success:function(data){
		    	if(data.success){
		    		$.messager.alert('提示',data.msg,'info');
		    	}else{
		    		$.messager.alert('提示',data.msg,'info');
		    	}
		    }
		});
	}
	function hideCheckSearch(){
		$("#checkSearch").layout("collapse","north");
	}
	function hideHistorySearch(){
		
		$("#historySearch").layout("collapse","north");
	}
	//出运详细办理
	function detailCheck1(taskId,assignee,orderCode,taskname){
		
		
		//alert(taskId);
		$.ajax({
			url : '${dynamicURL}/shipOrder/shipOrderAction!ifcanchuyun.action',
			data : {
				taskId : taskId
			},
			dataType : 'json',
			cache : false,
			success : function(json){
				if(json.success){
					var url='${dynamicURL}/shipOrder/shipOrderAction!goShipMent.action?taskId='+taskId+'&orderCode='+orderCode+'&assignee='+assignee;
					//var url='${dynamicURL}/shipOrder/shipOrderAction!goShipMent.action?taskId='+taskId;
					parent.window.HROS.window.close('shipOrder_'+taskId);
					//打开详细办理页面
					parent.window.HROS.window.createTemp({
						title:taskname+":-订单号:"+orderCode,
						url:url,
						appid:'shipOrder_'+taskId,
						width:1000,height:500,isresize:false,isopenmax:false,isflash:false,customWindow:window});
				}else{
					$.messager.alert('提示',json.msg,'warring');
				}
			}
		});
	}
	function detailCheck2(orderCode,taskname){
		var url='${dynamicURL}/shipOrder/shipOrderAction!goShipMent.action?&orderCode='+orderCode;
		//var url='${dynamicURL}/shipOrder/shipOrderAction!goShipMent.action?taskId='+taskId;
		parent.window.HROS.window.close('shipOrder_'+orderCode);
		//打开详细办理页面
		parent.window.HROS.window.createTemp({
			title:taskname+":-订单号:"+orderCode,
			url:url,
			appid:'shipOrder_'+orderCode,
			width:1000,height:500,isresize:false,isopenmax:false,isflash:false,customWindow:window});
	}
	function quickCheck(){
		var rows = datagrid.datagrid('getSelections');
		var taskIds='';
		if(rows.length>1){
			for ( var i = 0; i < rows.length; i++) {
				if(i!=rows.length-1)
					//将taskid和assignee封装起来传到后台
					taskIds=taskIds+"taskIds="+rows[i].taskId+":"+rows[i].assignee+"&";
				else {
					taskIds=taskIds+"taskIds="+rows[i].taskId+":"+rows[i].assignee;
				}
			}
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			//任务的批量办理
			$.ajax({
				url  : '${dynamicURL}/shipOrder/shipOrderAction!quickCheck.action',
				data : taskIds,
				dataType : 'json',
				success : function (data){
					$.messager.progress('close');
					if(data.success){
						$.messager.show({
							title :'提示',
							msg:data.msg
						});
						reloaddata();
					}else{
						$.messager.alert('警告',data.msg,'error');
					}
				}
			});
		}else if(rows.length==1){
			detailCheck1(rows[0].taskId,rows[0].assignee,rows[0].orderCode,rows[0].taskName);
		}else{
			$.messager.alert('提示','请先选中要执行的任务','warring');
		}
	}
	//任务批量认领
	function quickApply(){
		var rows = datagrid.datagrid('getSelections');
		var taskIds='';
		if(rows.length>0){
			for ( var i = 0; i < rows.length; i++) {
				if(i!=rows.length-1)
					taskIds=taskIds+"taskIds="+rows[i].taskId+"&";
				else {
					taskIds=taskIds+"taskIds="+rows[i].taskId;
				}
			}
			//任务的批量认领
			$.ajax({
				url  : '${dynamicURL}/shipOrder/shipOrderAction!haveTask.action',
				data : taskIds,
				dataType : 'json',
				success : function (data){
					if(data.success){
						$.messager.show({
							title :'提示',
							msg:data.msg
						})
						reloaddata();
					}else{
						$.messager.alert('警告',data.msg,'error');
					}
				}
			});
		}else{
			$.messager.alert('提示','请先选中要认领的任务','warring');
		}
	}
	//刷新代办和已完成代办
	function reloaddata(){
		datagrid.datagrid('reload');
		historyDatagrid.datagrid('reload');
		top.window.showTaskCount();
	}
	//重传hop创建po接口
	function quickchuans(){
		var rows = $('#orderHistoryList').datagrid('getSelections');
		var codes='';
		if(rows==null||rows.length==0){
			$.messager.alert('提示','请选中数据','warring');
		}
        for(var i=0;i<rows.length;i++){
        	if(i!=(rows.length-1)){
        		codes=codes+rows[i].orderCode+',';
        	}else{
        		codes=codes+rows[i].orderCode;
        	}
        }
    	$.messager.progress({
    		text : '数据传输中....',
    		interval : 100
    	});
        $.ajax({
        	url:'${dynamicURL}/shipOrder/shipOrderAction!reChuYun.action',
        	data:{
        		orderCode:codes
        	},
        	dataType:'json',
        	success:function(json){
				$.messager.progress('close');
        		if(json.success){
        			$.messager.alert('提示',json.msg,'info');
        		}else{
        			$.messager.alert('提示',json.msg,'error');
        		}
        	}
        });
	}
	//重传hop（装船发运接口）
	function quickchuans1(){
		var rows = $('#orderHistoryList').datagrid('getSelections');
		var codes='';
		if(rows==null||rows.length==0){
			$.messager.alert('提示','请选中数据','warring');
		}
        for(var i=0;i<rows.length;i++){
        	if(i!=(rows.length-1)){
        		codes=codes+rows[i].orderCode+',';
        	}else{
        		codes=codes+rows[i].orderCode;
        	}
        }
    	$.messager.progress({
    		text : '数据传输中....',
    		interval : 100
    	});
        $.ajax({
        	url:'${dynamicURL}/shipOrder/shipOrderAction!reChuYun1.action',
        	data:{
        		orderCode:codes
        	},
        	dataType:'json',
        	success:function(json){
				$.messager.progress('close');
        		if(json.success){
        			$.messager.alert('提示',json.msg,'info');
        		}else{
        			$.messager.alert('提示',json.msg,'error');
        		}
        	}
        });
	}
	//模糊查询国家下拉列表
	function _CCNMYCOUNTRY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.action?name='+ _CCNTEMP+'&countryCode='+_CCNCODE 
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询国家信息输入框
	function _CCNMYCOUNTRYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/countryAction!datagrid.do'
				});
	}
	
	//模糊查询目的港下拉列表
	function _PORTMY(inputId,inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/portAction!datagrid.do?englishName=' + _CCNTEMP+'&portCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询目的港下拉列表
	function _PORTMY(inputId,inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/portAction!datagrid.do?englishName=' + _CCNTEMP+'&portCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//查询船公司的下拉
	function VENDOR_PORTMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/vendorAction!datagrid0.do?vendorNameCn=' + _CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	function _CCNMY(inputId,codeq,selectId) {
		var _CCNTEMP = $('#' + inputId).val();
		var code=$('#'+codeq).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action?name=' + _CCNTEMP+'&customerId='+code
		});
	}

	  function _CCNMYCHONZHI(inputId,codeq,selectId) {
			$('#' + inputId).val('');
			$('#'+codeq).val('');
			$('#' + selectId).combogrid({
				url : '${dynamicURL}/basic/customerAction!datagrid0.action'
			});
		}
</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true" >
		<div title="出运待办">
			<!--展开之后的content-part所显示的内容-->
				<div id="checkSearch"  class="easyui-layout" fit="true">
	            <div class=" zoc" title="过滤条件" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 130px; overflow: hidden;">
					<form id="searchForm">
						<div class="oneline">
							<div class="item25">
								<div class="itemleft80">订单号:</div>
								<div class="righttext_easyui">
									<input id="ordernumberid" name="orderNum" type="text" class="short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">客户:</div>
								<div class="righttext_easyui">
									<input name="custCode" id="custCodeId" type="text" class="short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">出口国家:</div>
								<div class="righttext_easyui">
									<input name="countryCode" type="text" class="short50" id="countryIdtask"
										 />
								</div>
							</div>
							
						</div>
						<div class="oneline">
						    <div class="item25">
								<div class="itemleft80">船公司:</div>
								<div class="righttext_easyui">
									<input name="vendorCode" type="text" class="short50" id="shipNametaskId"
										 />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">订单出运时间从:</div>
								<div class="righttext_easyui">
									<input type="text" name="fromShipDate" class="easyui-datebox short50"
										 editable="false" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">到</div>
								<div class="righttext_easyui">
									<input type="text" name="toShipDate" class="easyui-datebox short50"
										 editable="false" />
								</div>
							</div>
							
						</div>
						<div class="oneline">
						    <div class="item25">
								<div class="itemleft80">目的港:</div>
								<div class="righttext_easyui">
									<input name="endPortCode" type="text" id="endPortIdtask" class="short50"
										 />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">订舱号:</div>
								<div class="righttext_easyui">
									<input name="bookCode" type="text" id="bookCodeid" class="short50"
										 />
								</div>
							</div>
						    <div class="item25 lastitem">
								<div class="oprationbutt">
								<input type="button" onclick="_search();" value="查  询" /> 
								<input type="button" onclick="cleanSearch();" value="重置" /> 
								</div>
							</div>
						</div>
					</form>
				</div>

				<div region="center" border="false">
					<table id="orderCheckList"></table>
				</div>
				<div id="orderCheckDialog"
					style="display: none; width: 1280px; height: 610px;" align="center">
					<form id="orderCheckForm" method="post">
						<input type="hidden" name="kdOrderId" /> <input type="hidden"
							name="taskId" />
						
					</form>
				</div>
			</div>
		</div>

		<div title="已完成出运">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch"  class="easyui-layout" fit="true">
	            <div class=" zoc" title="过滤条件" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 150px; overflow: hidden;">
					<form id="searchHistoryForm">
						<div class="oneline">
							<div class="item25">
								<div class="itemleft80">订单号:</div>
								<div class="righttext_easyui">
									<input name="orderNum" type="text" class="short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">客户:</div>
								<div class="righttext_easyui">
									<input name="custCode" id="hiscustCodeId" type="text" class="short50" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">出口国家:</div>
								<div class="righttext_easyui">
									<input name="countryCode" type="text" class="short50" id="countryIdHistory"
										/>
								</div>
							</div>
						</div>
						<div class="oneline">
						    <div class="item25">
								<div class="itemleft80">船公司:</div>
								<div class="righttext_easyui">
									<input name="vendorCode" type="text" class="short50" id="shipCompanyHistory"
										/>
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">出运时间从:</div>
								<div class="righttext_easyui">
									<input type="text" name="fromShipDate" class="easyui-datebox short50"
										 editable="false" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">到</div>
								<div class="righttext_easyui">
									<input type="text" name="toShipDate" class="easyui-datebox short50"
										 editable="false" />
								</div>
							</div>
						</div>
						<div class="oneline">
						    <div class="item25">
								<div class="itemleft80">议付发票号:</div>
								<div class="righttext_easyui">
									<input name="yfNum" type="text" id="yfNumid" class="short50"
										 />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">提单号:</div>
								<div class="righttext_easyui">
									<input name="billNum" type="text" id="billNumid" class="short50"
										 />
								</div>
							</div>
						    <div class="item25">
								<div class="itemleft80">目的港:</div>
								<div class="righttext_easyui">
									<input name="endPortCode" type="text" id="endPortIdtask" class="short50"
										 />
								</div>
							</div>
						   
						</div>
						<div class="oneline">
						     <div class="item25">
								<div class="itemleft80">订舱号:</div>
								<div class="righttext_easyui">
									<input name="bookCode" type="text" id="bookCodeid" class="short50"
										 />
								</div>
							</div>
						     <div class="item25 lastitem">
								<div class="oprationbutt">
								<input type="button" onclick="_historySearch();" value="查  询" /> 
								<input type="button" onclick="cleanHistorySearch();" value="重置" /> 
								</div>
							</div>
						</div>
					</form>
				</div>

				<div region="center" border="false">
				 	<table id="orderHistoryList" ></table> 
				</div>
				
				
				<div id="iframeDialog" style="display: none;overflow: auto;width: 1200px;height: 500px;">
	            <iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:99%;">
                </iframe>
                </div>
                
                
				<div id="orderCheckDialog"
					style="display: none; width: 1280px; height: 610px;" align="center">
					<form id="orderCheckForm" method="post">
						<input type="hidden" name="kdOrderId" /> <input type="hidden"
							name="taskId" />
						
					</form>
				</div>
			</div>
		</div>
	</div>
	 <div id="_CNNQUERY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPTCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
		    <div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('_CNNINPUT','_CNNINPTCODE','custCodeId')" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="重置"
						onclick="_CCNMYCHONZHI('_CNNINPUT','_CNNINPTCODE','custCodeId')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_CNNQUERYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPTCODEhis" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPUThis" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
		    <div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('_CNNINPUThis','_CNNINPTCODEhis','hiscustCodeId')" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="重置"
						onclick="_CCNMYCHONZHI('_CNNINPUT','_CNNINPTCODE','hiscustCodeId')" />
				</div>
			</div>
		</div>
	</div> 
	
	<!-- 国家下拉选 -->
	 <div id="_COUNTRY">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="_COUNTRYCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCNMYCOUNTRY('_COUNTRYCODE','_COUNTRYINPUT','countryIdtask')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCOUNTRYCLEAN('_COUNTRYCODE','_COUNTRYINPUT','countryIdtask')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_COUNTRYHISTORY">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="_COUNTRYCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCNMYCOUNTRY('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryIdHistory')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCOUNTRYCLEAN('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryIdHistory')" />
				</div>
			</div>
		</div>
	</div> 
	
	<!-- 目的港下拉选信息 -->
	<div id="_PORTEND">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">目的港编号：</div>
				<div class="righttext">
					<input class="short50" id="_PORTCODEINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">目的港：</div>
				<div class="righttext">
					<input class="short60" id="_PORTINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_PORTMY('_PORTCODEINPUT','_PORTINPUT','endPortIdtask')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_PORTMYCLEAN('_PORTCODEINPUT','_PORTINPUT','portEndCode')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_PORTENDHISTORY">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">目的港编号：</div>
				<div class="righttext">
					<input class="short50" id="_PORTCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">目的港：</div>
				<div class="righttext">
					<input class="short60" id="_PORTINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_PORTMY('_PORTCODEHISTORY','_PORTINPUTHISTORY','endPortIdHistory')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_PORTMYCLEAN('_PORTCODEHISTORY','_PORTINPUTHISTORY','endPortIdHistory')" />
				</div>
			</div>
		</div>
	</div>
		<div id="_VENDERTASK">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">船公司：</div>
				<div class="righttext">
					<input class="short60" id="VENDOR_COMPANY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="VENDOR_PORTMY('VENDOR_COMPANY','shipNametaskId')" />
				</div>
			</div>
		</div>
	</div>
		<div id="_VENDERHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">船公司：</div>
				<div class="righttext">
					<input class="short60" id="COMPANYHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="VENDOR_PORTMY('COMPANYHISTORY','shipCompanyHistory')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>