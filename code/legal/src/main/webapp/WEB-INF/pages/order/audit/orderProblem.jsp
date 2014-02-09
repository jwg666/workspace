<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
		orderProblemDatagrid();
	})
	//订单问题datagrid
	function orderProblemDatagrid() {
		//查询列表	
		problemDatagrid = $('#problemDatagrid').datagrid({
			url : '${dynamicURL}/audit/auditLogAction!datagrid.do',
			queryParams : {
				orderNum : '${orderNum==NULL?"-1":""}${orderNum}'
			},
			iconCls : 'icon-save',
			rownumbers : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			fit : true,
			columns : [ [ {
				field : 'orderNum',
				title : '订单号',
				align : 'center',
				sortable : true,
				width : 50,
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			}, {
				field : 'rejection',
				title : '拒绝原因',
				align : 'center',
				sortable : true,
				width : 100,
				formatter : function(value, row, index) {
					return row.rejection;
				}
			}, {
				field : 'rejectionName',
				title : '拒绝人',
				align : 'center',
				sortable : true,
				width : 20,
				formatter : function(value, row, index) {
					return row.rejectionName;
				}
			}, {
				field : 'rejectionDate',
				title : '拒绝时间',
				align : 'center',
				sortable : true,
				width : 30,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.rejectionDate);
				}
			} ] ]
		});
	}
</script>
<div id="orderProblemDialog" style="margin-top: 0%;overflow-x:hidden ">
	<table id="problemDatagrid"></table>
</div>



