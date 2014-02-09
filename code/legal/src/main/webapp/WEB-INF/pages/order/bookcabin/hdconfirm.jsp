<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var hdconfirmAddDialog;
	var hdconfirmAddForm;
	var cdescAdd;
	var hdconfirmEditDialog;
	var hdconfirmEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'hdconfirmAction!datagrid.do',
			title : '货代确认接单列表',
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
			idField : 'bookCode',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.bookCode;
						}
					},
			   {field:'bookCode',title:'订舱编号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.bookCode;
					}
				},				
			   {field:'orderShipDate',title:'出运时间',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.orderShipDate);
					}
				},				
			   {field:'orderCustomDate',title:'客户要求到货时间',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.orderCustomDate);
					}
				},				
			   {field:'portStartCode',title:'始发港编号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.portStartCode;
					}
				},				
			   {field:'portEndCode',title:'目的港编号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.portEndCode;
					}
				},				
			   {field:'goodsGrossWeight',title:'毛重',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.goodsGrossWeight;
					}
				},				
			   {field:'goodsMesurement',title:'体积',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.goodsMesurement;
					}
				},				
			   {field:'goodsShipPrice',title:'运费',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.goodsShipPrice;
					}
				},				
			   {field:'actCntCode',title:'预算箱型',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.actCntCode;
					}
				},				
			   {field:'budgetQuantity',title:'预算箱量',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.budgetQuantity;
					}
				},
				{field:'taskIds',title:'任务id',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.taskIds;
					}
				}
			 ] ],
	 		toolbar : [ {
				text : '接单',
				iconCls : 'icon-ok',
				handler : function() {
					accept();
				}
			}, '-', {
				text : '拒绝',
				iconCls : 'icon-cancel',
				handler : function() {
					refuse();
				}
			}, '-'/*, {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' */], 
			/* onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			} */
		});
		

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'ACT_HDCONFIRM描述',
			modal : true,
			closed : true,
			maximizable : true
		});

		
	});
	
	function accept(){
		var rows = datagrid.datagrid('getSelections');
		var allTaskIds = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要接受所选订舱单？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							allTaskIds=allTaskIds+"allTaskIds="+rows[i].taskIds+"&";
						else allTaskIds=allTaskIds+"allTaskIds="+rows[i].taskIds;
					}
					$.ajax({
						url : 'hdconfirmAction!accept.do',
						data : allTaskIds,
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '接单成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要接单的记录！', 'error');
		}
	}
	
	function refuse(){
		var rows = datagrid.datagrid('getSelections');
		var allTaskIds = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要拒接所选订舱单？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							allTaskIds=allTaskIds+"allTaskIds="+rows[i].taskIds+"&";
						else allTaskIds=allTaskIds+"allTaskIds="+rows[i].taskIds;
					}
					$.ajax({
						url : 'hdconfirmAction!accept.do',
						data : allTaskIds,
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '拒接成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要拒接的记录！', 'error');
		}
	}

</script>
</head>
<body class="easyui-layout">
	<div class="zoc" region="north" border="false" collapsed="false"
		style="height: 0px; overflow: auto;" align="left"></div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>


	<div id="showCdescDialog" style="display: none;overflow: auto;width: 500px;height: 400px;">
		<div name="cdesc"></div>
	</div>
	
	<div id="iframeDialog" style="display: none;overflow: auto;width: 600px;height: 400px;">
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:100%;">
    </iframe>
</div>
</body>
</html>