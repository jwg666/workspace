<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var editRow = undefined;
	var datagrid;
	$(function() {

		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'orderMergeAction!searchHistoryDatagrid.action',
			title : '已合并报关的订单列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 20,
			pageList : [ 10, 20, 30, 40, 50, 100 ],
			fit : true,
			fitColumns : false,
			rownumbers : true,
			nowrap : false,
			border : false,
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.obid;
				}
			}, {
				field : 'orderNum',
				title : '订单号',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			}, {
				field : 'mergeOrderNum',
				title : '被合并订单号',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.mergeOrderNum;
				}
			}, {
				field : 'orderLinecode',
				title : '订单行项目号',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.orderLinecode;
				}
			}, {
				field : 'haierModel',
				title : '海尔型号',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.haierModel;
				}
			}, {
				field : 'customerModel',
				title : '客户型号',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.customerModel;
				}
			}, {
				field : 'materialCode',
				title : '物料号',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			},{
				field : 'mergeMaterial',
				title : '合并物料编码',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.mergeMaterial;
				}
			},{
				field : 'simpleCode',
				title : '简码',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.simpleCode;
				}
			},
			{
				field : 'haierProdDesc',
				title : '货描',
				align : 'center',
				sortable : false,
				width : 160,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.haierProdDesc;
				}
			} ] ],
			columns : [ [ {
				field : 'quantity',
				title : '数量',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.quantity;
				}
			}, {
				field : 'piece',
				title : '件数',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.piece;
				}
			},{
				field : 'unit',
				title : '单位',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.unit;
				}
			}, {
				field : 'price',
				title : '单价',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.price;
				}
			}, {
				field : 'amount',
				title : '总额',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.amount;
				}
			}, {
				field : 'custPrice',
				title : '报关单价',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.custPrice;
				}
			}, {
				field : 'custAmount',
				title : '报关总额',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.custAmount;
				}
			}, {
				field : 'netWeight',
				title : '净重',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.netWeight;
				}
			}, {
				field : 'grossWeight',
				title : '毛重',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.grossWeight;
				}
			}, {
				field : 'value',
				title : '体积',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.value;
				}
			}, {
				field : 'mergeRole',
				title : '合并规则',
				align : 'center',
				sortable : false,
				width : 260,
				formatter : function(value, row, index) {
					return row.mergeRole;
				}
			} ] ],
			toolbar : [ {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					del();
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, '-', {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					if (editRow != undefined) {
						datagrid.datagrid('endEdit', editRow);
					}
				}
			}, '-', {
				text : '取消编辑',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
					datagrid.datagrid('rejectChanges');
					editRow = undefined;
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ],
			onDblClickRow : function(rowIndex, rowData) {
				if (editRow != undefined) {
					datagrid.datagrid('endEdit', editRow);
				}

				if (editRow == undefined) {
					changeEditorEditRow();/*改变editor*/
					datagrid.datagrid('beginEdit', rowIndex);
					editRow = rowIndex;
					datagrid.datagrid('unselectAll');
				}
			},
			onAfterEdit : function(rowIndex, rowData, changes) {
				var inserted = datagrid.datagrid('getChanges', 'inserted');
				var updated = datagrid.datagrid('getChanges', 'updated');
				if (inserted.length < 1 && updated.length < 1) {
					editRow = undefined;
					datagrid.datagrid('unselectAll');
					return;
				}

				var url = '';
				if (inserted.length > 0) {
					url = 'orderMergeAction!add.action';
				}
				if (updated.length > 0) {
					url = 'orderMergeAction!edit.action';
				}

				$.ajax({
					url : url,
					data : rowData,
					dataType : 'json',
					success : function(r) {
						if (r.success) {
							datagrid.datagrid('acceptChanges');
							$.messager.show({
								msg : r.msg,
								title : '成功'
							});
							editRow = undefined;
							datagrid.datagrid('reload');
						} else {
							/*datagrid.datagrid('rejectChanges');*/
							datagrid.datagrid('beginEdit', editRow);
							$.messager.alert('错误', r.msg, 'error');
						}
						datagrid.datagrid('unselectAll');
					}
				});

			},
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

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}

	function add() {
		if (editRow != undefined) {
			datagrid.datagrid('endEdit', editRow);
		}

		if (editRow == undefined) {
			datagrid.datagrid('unselectAll');
			var row = {
				cid : sy.UUID()
			};
			/*datagrid.datagrid('insertRow', {
				index : 0,
				row : row
			});
			editRow = 0;
			datagrid.datagrid('selectRow', editRow);
			datagrid.datagrid('beginEdit', editRow);*/
			datagrid.datagrid('appendRow', row);
			editRow = datagrid.datagrid('getRows').length - 1;
			datagrid.datagrid('selectRow', editRow);
			datagrid.datagrid('beginEdit', editRow);
		}
	}
	function del() {
		if (editRow != undefined) {
			datagrid.datagrid('endEdit', editRow);
			return;
		}
		var rows = datagrid.datagrid('getSelections');
		var ordeCodes = [];
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ordeCodes.push(rows[i].orderNum);
					}
					$.ajax({
						url : 'orderMergeAction!delete.action',
						data : {
							ordeCodes : ordeCodes.join(',')
						},
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
			if (editRow != undefined) {
				datagrid.datagrid('endEdit', editRow);
			}

			if (editRow == undefined) {
				editRow = datagrid.datagrid('getRowIndex', rows[0]);
				datagrid.datagrid('beginEdit', editRow);
				datagrid.datagrid('unselectAll');
			}
		} else {
			$.messager.show({
				msg : '请选择一项进行修改！',
				title : '错误'
			});
		}
	}
</script>
</head>
<body class="easyui-layout">
	<div class="zoc" region="north" border="false" collapsible="true"
		collapsed="false" style="height: 100px;">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>合并报关</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">订单编号：</div>
						<div class="righttext">
							<input id="orderNum" name="orderNum" type="text"
								style="width: 145px" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft100">被合并订单号：</div>
						<div class="righttext">
							<input id="mergeOrderNum" name="mergeOrderNum" type="text"
								style="width: 145px" />
						</div>
					</div>
					<div class="item33">
						<div class="oprationbutt">
							<input type="button" value="查  询" onclick="_search();" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

</body>
</html>