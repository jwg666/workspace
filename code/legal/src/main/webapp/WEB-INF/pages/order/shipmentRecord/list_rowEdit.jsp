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
			url : 'shipmentRecordAction!datagrid.action',
			title : '出运计划备案表列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 50,
			pageList : [ 10, 20, 30, 40, 50, 100 ],
			fit : true,
			fitColumns : false,
			rownumbers : true,
			nowrap : false,
			border : false,
			idField : 'obid',
			sortName : '',
			sortOrder : 'desc',
			columns : [ [ 
				{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.obid;
						}
				},
			   {field:'shipmentRecordId',title:'ROWID',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.shipmentRecordId;
					}
				},				
			   {field:'tradeMode',title:'贸易方式',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.tradeMode;
					}
				},				
			   {field:'orderCode',title:'订单号',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
			   {field:'accountNo',title:'账册号',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.accountNo;
					}
				},				
			   {field:'itemNo',title:'项号',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.itemNo;
					}
				},				
			   {field:'recordMaterialsNo',title:'备案物料号',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.recordMaterialsNo;
					}
				},				
			   {field:'versionNumber',title:'版本号',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.versionNumber;
					}
				},				
			   {field:'recordName',title:'备案品名',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.recordName;
					}
				},				
			   {field:'commodityCode',title:'商品编码',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.commodityCode;
					}
				},				
			   {field:'specifications',title:'备案规格',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.specifications;
					}
				},				
			   {field:'orderType',title:'订单类型',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.orderType;
					}
				},				
			   {field:'factoryCode',title:'生产工厂代码',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.factoryCode;
					}
				},				
			   {field:'salesOrderNo',title:'销售订单号',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.salesOrderNo;
					}
				},				
			   {field:'materialCode',title:'物料号',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.materialCode;
					}
				},				
			   {field:'haierModelCode',title:'工厂型号',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.haierModelCode;
					}
				},				
			   {field:'customerModelCode',title:'客户型号',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.customerModelCode;
					}
				},				
			   {field:'declarationName',title:'报关品名',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.declarationName;
					}
				},				
			   {field:'parameter',title:'参数',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.parameter;
					}
				},				
			   {field:'quantity',title:'数量',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {required:true}
					},
					formatter:function(value,row,index){
						return row.quantity;
					}
				},				
			   {field:'price',title:'单价',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {required:true}
					},
					formatter:function(value,row,index){
						return row.price;
					}
				},				
			   {field:'total',title:'总价',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {required:true}
					},
					formatter:function(value,row,index){
						return row.total;
					}
				},				
			   {field:'countryCode',title:'国家',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.countryCode;
					}
				},				
			   {field:'clearanceTime',title:'报关时间',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.clearanceTime);
					}
				},				
			   {field:'shipment',title:'船期',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.shipment);
					}
				},				
			   {field:'orderExecution',title:'订单执行',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.orderExecution;
					}
				},				
			   {field:'remarks',title:'备注',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.remarks;
					}
				},				
			   {field:'submitTime',title:'提交备案时间',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.submitTime);
					}
				},				
			   {field:'acceptTime',title:'备案接单时间',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.acceptTime);
					}
				},				
			   {field:'acceptEmpcode',title:'接单人',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.acceptEmpcode;
					}
				},				
			   {field:'recordEndTime',title:'备案完成时间',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.recordEndTime);
					}
				},				
			   {field:'customsEndDate',title:'报关完成时间',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.customsEndDate);
					}
				},				
			   {field:'customsCode',title:'报关单号',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.customsCode;
					}
				},				
			   {field:'returnDate',title:'退回时间',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.returnDate);
					}
				},				
			   {field:'returnReason',title:'退回原因',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.returnReason;
					}
				},				
			   {field:'returnEmpcode',title:'退回人',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.returnEmpcode;
					}
				},				
			   {field:'unusualConfirmDate',title:'异常确认时间',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.unusualConfirmDate);
					}
				},				
			   {field:'unusualConfirmReason',title:'异常确认原因',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.unusualConfirmReason;
					}
				},				
			   {field:'unusualConfirmEmpcode',title:'异常确认人',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.unusualConfirmEmpcode;
					}
				},				
			   {field:'statusFlag',title:'状态标志',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.statusFlag;
					}
				},				
			   {field:'createDate',title:'创建时间',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.createDate);
					}
				},				
			   {field:'createEmpcode',title:'创建人',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.createEmpcode;
					}
				},				
			   {field:'lastDate',title:'最后修改时间',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastDate);
					}
				},				
			   {field:'lastEmpcode',title:'最后修改人',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.lastEmpcode;
					}
				},				
			   {field:'other',title:'其他',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.other;
					}
				}				
			   ] ],
			toolbar : [ {
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					add();
				}
			}, '-', {
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
					url = 'shipmentRecordAction!add.action';
				}
				if (updated.length > 0) {
					url = 'shipmentRecordAction!edit.action';
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
		var ids = [];
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].obid);
					}
					$.ajax({
						url : 'shipmentRecordAction!delete.action',
						data : {
							ids : ids.join(',')
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
	<div region="north" border="false" title="搜索条件" style="height: 60px;overflow: hidden;" align="left">
		<form id="searchForm">
			<table>
				<tr>
					<td>查询字段<input name="cname" style="width:100px;" />&nbsp;</td>
					<td>创建时间<input name="ccreatedatetimeStart" class="easyui-datetimebox" editable="false" style="width: 100px;" />至<input name="ccreatedatetimeEnd" class="easyui-datetimebox" editable="false" style="width: 100px;" /></td>
					<td>最后修改时间</td>
					<td><input name="cmodifydatetimeStart" class="easyui-datetimebox" editable="false" style="width: 100px;" />至<input name="cmodifydatetimeEnd" class="easyui-datetimebox" editable="false" style="width: 100px;" /><a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">搜索</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">取消</a></td>
				</tr>
			</table>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>
</body>
</html>