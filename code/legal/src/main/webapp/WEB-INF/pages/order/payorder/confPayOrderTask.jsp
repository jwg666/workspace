<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var itemDatagrid;
	var confPayOrderAddDialog;
	var confPayOrderAddForm;
	var cdescAdd;
	var confPayOrderEditDialog;
	var confPayOrderEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!datagridForTask.do',
			title : '付款保障表列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			fit : true,
			checkOnSelect:false,
			selectOnCheck:false,
			singleSelect : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
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
			   {field:'actConfPayCode',title:'订单编号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
			   {field:'orderCustName',title:'经营体长',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderCustName;
					}
				},				
			   {field:'saleAreaName',title:'市场区域',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.saleAreaName;
					}
				},				
			   {field:'countryName',title:'出口国家',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.countryName;
					}
				},				
			   {field:'customerName',title:'客户名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.customerName;
					}
				},				
			   {field:'orderPaymentMethodName',title:'付款方式',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderPaymentMethodName;
					}
				},				
			   {field:'orderPaymentTermsName',title:'付款条件',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderPaymentTermsName;
					}
				},				
			   {field:'orderPaymentCycle',title:'付款周期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderPaymentCycle;
					}
				},				
			   {field:'amount',title:'总金额',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.amount;
					}
				},				
			   {field:'balance',title:'未付款金额',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.balance;
					}
				}				
			 ] ],
			onDblClickRow : function(rowIndex,rowData){
				itemDatagrid.datagrid({url:'${dynamicURL}/salesOrder/salesOrderItemAction!datagirdForItem.do',queryParams:{
					orderCode:rowData.orderCode
				}});
			}, 
			toolbar : [ {
				text : '批量过付款',
				iconCls : 'icon-add',
				handler : function() {
					batchPayMoney();
				}
			}, '-', {
				text : '过付款',
				iconCls : 'icon-remove',
				handler : function() {
					payMoney();
				}
			}]
		});

		itemDatagrid = $('#itemDatagrid').datagrid({
			pagination : true,
			title : '付款明细',
			pagePosition : 'bottom',
			rownumbers : true,
			fit : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'orderItemLinecode',
			
			
			columns : [ [ 
			   {field:'orderItemLinecode',title:'行项目号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderItemLinecode;
					}
				},				
			   {field:'orderCode',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
			   {field:'prodTname',title:'产品大类',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prodTname;
					}
				},				
			   {field:'materialCode',title:'物料号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.materialCode;
					}
				},				
			   {field:'prodQuantity',title:'数量',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prodQuantity;
					}
				},				
			   {field:'price',title:'单价',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.price;
					}
				},				
			   {field:'currency',title:'币种',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.currency;
					}
				},				
			   {field:'amount',title:'总额',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.amount;
					}
				}				
			 ] ]
		});
		
		confPayOrderAddForm = $('#confPayOrderAddForm').form({
			url : 'confPayOrderAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					confPayOrderAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		confPayOrderAddDialog = $('#confPayOrderAddDialog').show().dialog({
			title : '添加付款保障表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					confPayOrderAddForm.submit();
				}
			} ]
		});

		confPayOrderEditForm = $('#confPayOrderEditForm').form({
			url : 'confPayOrderAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					confPayOrderEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		confPayOrderEditDialog = $('#confPayOrderEditDialog').show().dialog({
			title : '编辑付款保障表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					confPayOrderEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '付款保障表描述',
			modal : true,
			closed : true,
			maximizable : true
		});

		iframeDialog = $('#iframeDialog').show().dialog({
			title : 'POP弹出页面',
			modal : true,
			closed : true,
			maximizable : true
		});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function add() {
		confPayOrderAddForm.form("clear");
		$('div.validatebox-tip').remove();
		confPayOrderAddDialog.dialog('open');
	}
	
	/*过付款*/
	function payMoney() {
		var checkedRows = datagrid.datagrid('getChecked');
		var len = checkedRows.length;
		var orderCode;
		//如果选择多条，则需要批量过付款
		if(1 < len) {
			$.messager.alert('提示', '请您批量过付款！', 'warn');
		}else{
			orderCode = checkedRows[0].orderCode;
			var isOverdue = false;
			
			$.ajax({
			   type: "POST",
			   url: "${dynamicURL}/salesOrder/salesOrderAction!singlePayMoneyOverdue.action?orderCode="+orderCode,
			   dataType:'json',
			   success: function(json){
			     if(json.msg != ""){
			    	 $.messager.show({
						title : '提示',
						msg : json.msg
					 });
			     }else{
			    	 var url = "${dynamicURL}/salesOrder/salesOrderAction!forwardPayMoney.action?orderCode="+orderCode;
					 $('#iframe').attr('src', url);
					 iframeDialog = $('#iframeDialog').show().dialog({
						title : '过付款',
						modal : true,
						closed : true,
						minimizable : true,
						maximizable : true,
					 });
					 iframeDialog.dialog('open');
			     }
			   }
			});
		}
	}
	
	/*批量过付款*/
	function batchPayMoney() {
		//var ids = "";
		var checkedRows = datagrid.datagrid('getChecked');
		var jsonStr = JSON.stringify(checkedRows);
		var url = "${dynamicURL}/salesOrder/salesOrderAction!batchPayMoney.action";
		$.ajax({
		   type: "POST",
		   url: url,
		   data:{"batchPayMoneyList":jsonStr},
		   dataType:'json',
		   success: function(json){
			   $.messager.show({
					title : '提示',
					msg : json.msg
			   });
		   }
		});
	}
	
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].actConfPayCode+"&";
						else ids=ids+"ids="+rows[i].actConfPayCode;
					}
					$.ajax({
						url : 'confPayOrderAction!delete.do',
						data : ids,
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'error');
		}
	}
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url : 'confPayOrderAction!showDesc.do',
				data : {
					actConfPayCode : rows[0].actConfPayCode
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					confPayOrderEditForm.form("clear");
					confPayOrderEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					confPayOrderEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
	function showCdesc(index) {
		var rows = datagrid.datagrid('getRows');
		var row = rows[index];
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url : 'confPayOrderAction!showDesc.do',
			data : {
				actConfPayCode : row.actConfPayCode
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有付款保障表描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout">
	
	<div region="center" border="false" class="zoc">
		<table id="datagrid"></table>
	</div>
	
	<div region="south" border="false" style="height:250px;margin-top:10px;" class="zoc">
		<table id="itemDatagrid"></table>
	</div>

	<div id="iframeDialog" style="display: none;overflow: auto;width: 600px;height: 400px;">
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:100%;">
    </iframe> 
</div>
</body>
</html>