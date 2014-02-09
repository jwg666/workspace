<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	var datagridDetail;
	var showErrorDialog;
	function prepareOrder_detail(orderCodeDel) {
		datagridDetail = $('#datagridDetail').datagrid({
			url : 'prepareOrderAction!prepareOrderReleaseDel.do?orderCode='+orderCodeDel,
			rownumbers : true,
			fit : true,
// 			fitColumns : true,
// 			pagination : true,
			pagePosition : 'bottom',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			nowrap : true,
			border : false,
			singleSelect : true,
			idField : 'orderNum',
			
			columns : [ [ 
			   {
				field : 'orderNum',
				title : '订单号',
				align : 'center',
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			}, {
				field : 'releaseName',
				title : '审核人',
				align : 'center',
				formatter : function(value, row, index) {
					return row.releaseName;
				}
			}, {
				field : 'releaseDate',
				title : '审核时间',
				align : 'center',
				formatter : function(value, row, roindex) {
					return row.releaseDate;
				}
			}, {
				field : 'meatialCode',
				title : '拒绝原因(订单状态)',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.meatialCode;
				}
			} , {
				field : 'releaseFlag',
				title : '闸口标示',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if("2" == row.releaseFlag){
						return "订单被拒绝";
					}else if("1" == row.releaseFlag){
						return "订单等待审核中";
					}else if("0" == row.releaseFlag){
						return "订单审核通过";
					}
				}
			}] ]
		});
	}
</script>
<div id="showErrorDialog" style="margin-top: 1%;">
	<table id="datagridDetail"></table>
</div>



