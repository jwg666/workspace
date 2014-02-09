<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function(){
	queryDatagrid();
})
//备货单查询
function queryDatagrid(){
	$('#queryEndPrepareOrderDatagrid').datagrid({
		rownumbers : true,
		fit : true,
//		fitColumns : true,
//		pagination : true,
		pagePosition : 'bottom',
		pageSize : 10,
		pageList : [ 10, 20, 30, 40 ],
		nowrap : true,
		border : false,
		idField : 'materialCode',
		singleSelect : true,
		columns : [ [ {
			field : 'factoryName',
			title : '工厂',
			align : 'center',
			sortable : true,
			width : 210,
			formatter : function(value, row, index) {
				return row.factoryName;
			}
		}, {
			field : 'materialCode',
			title : '物料号',
			align : 'center',
			sortable : true,
			width : 80,
			formatter : function(value, row, index) {
				return row.materialCode;
			}
		}, {
			field : 'weekN',
			title : 'T+N周',
			align : 'center',
			sortable : true,
			width : 60,
			formatter : function(value, row, index) {
				return row.weekN;
			}
		}, {
			field : 'actualQuantity',
			title : '评审数量',
			align : 'center',
			sortable : true,
			width : 60,
			styler: function(value,row,index){
				return 'color:red;'
			},
			formatter : function(value, row, index) {
				return row.actualQuantity;
			}
		}, {
			field : 'prepareQuantity',
			title : '已分配数量',
			align : 'center',
			sortable : true,
			width : 70,
			styler: function(value,row,index){
				return 'color:red;';
			},
			formatter : function(value, row, index) {
				return row.prepareQuantity;
			}
		}, {
			field : 'quantity',
			title : '本次数量',
			align : 'center',
			sortable : true,
			width : 60,
			styler: function(value,row,index){
				return 'color:red;'
			},
			formatter : function(value, row, index) {
				return row.quantity;
			}
		}, {
			field : 'diffQuantity',
			title : '差异数量',
			align : 'center',
			sortable : true,
			width : 60,
			styler: function(value,row,index){
				return 'background-color:#ffee00;color:red;';
			},
			formatter : function(value, row, index) {
				return row.diffQuantity;
			}
		} ] ]
	});
}
</script>
<div id="queryPrepareDialog" style="margin-top: 0%;">
	<table id="queryEndPrepareOrderDatagrid"></table>
</div>



