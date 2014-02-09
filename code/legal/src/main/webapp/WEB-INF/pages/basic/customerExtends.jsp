<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">

	$(function() {
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/customerextends/customerExtendsAction!datagrid0.do?customerCode=${customerId}',
			title : '客户${name}基本资料的从表列表',
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
			//idField : 'rowId',
			
			columns : [ [ 
			   {field:'customerCode',title:'客户编码',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.customerCode;
					}
				},				
			   {field:'customerName',title:'客户名称',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.customerName;
					}
				},				
			   {field:'saleOrgCode',title:'销售组织',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.saleOrgCode;
					}
				},				
			   {field:'payLb',title:'付款方式',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.payLb;
					}
				},				
			   {field:'moneyType',title:'付款币种',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.moneyType;
					}
				},				
			   {field:'moneyNum',title:'最大信用额度',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.moneyNum;
					}
				}				
			 ] ]
		});


	});
</script>
</head>
<body class="easyui-layout">
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>	
</body>
</html>