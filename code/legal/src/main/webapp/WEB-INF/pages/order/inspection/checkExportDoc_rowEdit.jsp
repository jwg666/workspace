<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
			url : 'checkExportDocAction!datagrid.action?orderNumT='+'${orderNumT}',
			title : '出口备案',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 20,
			pageList : [ 10, 20, 30, 40, 50, 100 ],
			fit : true,
			fitColumns : false,
			rownumbers : true,
			nowrap : true,
			border : false,
			idField : 'obid',
			
			columns : [ [ {
				field : 'rowId',
				title : '',
				hidden : true,
				formatter : function(value, row, index) {
					return row.rowId;
				}
			}, {
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.orderCode;
				}
			}, {
				field : 'itemNameCn',
				title : '订单类型',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.itemNameCn;
				}
			}, {
				field : 'docCode',
				title : '备案项目号',
				align : 'center',
				sortable : false,
				width : 85,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.docCode;
				}
			}, {
				field : 'docMaterialCode',
				title : '备案物料号',
				align : 'center',
				sortable : false,
				width : 100,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.docMaterialCode;
				}
			}, {
				field : 'goodsCode',
				title : '商品编码',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.goodsCode;
				}
			}, {
				field : 'versionNo',
				title : '版本号',
				align : 'center',
				sortable : false,
				width : 85,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.versionNo;
				}
			}, {
				field : 'haierProdDesc',
				title : '备案品名',
				align : 'center',
				sortable : false,
				width : 100,
				formatter : function(value, row, index) {
					return row.haierProdDesc;
				}
			}, {
				field : 'typeNo',
				title : '规格型号',
				align : 'center',
				sortable : false,
				width : 85,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.typeNo;
				}
			}, {
				field : 'goodsUnit',
				title : '单位',
				align : 'center',
				sortable : false,
				width : 85,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.goodsUnit;
				}
			}, {
				field : 'comment',
				title : '备注',
				align : 'center',
				sortable : false,
				width : 85,
				editor : {
					type : 'validatebox',
					options : {}
				},
				formatter : function(value, row, index) {
					return row.comment;
				}
			}, {
				field : 'materialCode',
				title : '物料号',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			}, {
				field : 'haierModel',
				title : '型号',
				align : 'center',
				sortable : false,
				width : 100,
				formatter : function(value, row, index) {
					return row.haierModel;
				}
			}, {
				field : 'customerModel',
				title : '客户型号',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.customerModel;
				}
			},{
				field : 'prodQuantity',
				title : '数量',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.prodQuantity;
				}
			},
			{
				field : 'prodType',
				title : '产品名称',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.prodType;
				}
			}, {
				field : 'countryName',
				title : '国家',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			}, {
				field : 'planFinishDate',
				title : '报关时间',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.planFinishDate);
				}
			}, {
				field : 'orderShipDate',
				title : '船期',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderShipDate);
				}
			}
			, {
				field : 'booksNum',
				title : '账册号',
				align : 'center',
				sortable : false,
				width : 85,
				editor : {
					type : 'text'
				},
				formatter : function(value, row, index) {
					return row.booksNum;
				}
			}
			, {
				field : 'deptNameCn',
				title : '工厂',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.deptNameCn;
				}
			}
			, {
				field : 'username',
				title : '订单执行经理',
				align : 'center',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.username;
				}
			}] ],
			toolbar : [ {
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
				$.ajax({
					url : 'checkExportDocAction!checkEmp.action',
					dataType : 'json',
					success : function(r) {
						if (r.success) {
							$.messager.show({
								msg : "只有进口服务部可以进行修改！",
								title : '失败'
							});
						} else {
							if (editRow != undefined) {
								datagrid.datagrid('endEdit', editRow);
							}

							if (editRow == undefined) {
								//changeEditorEditRow();/*改变editor*/
								datagrid.datagrid('beginEdit', rowIndex);
								editRow = rowIndex;
								datagrid.datagrid('unselectAll');
							}
						}
					}
				});
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
					url = 'checkExportDocAction!add.action';
				}
				if (updated.length > 0) {
					url = 'checkExportDocAction!edit.action';
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
		});
		//加载导入excel方法
		showLoadExcelInfoForm = $('#showLoadExcelInfoForm').form({
			url:'checkExportDocAction!inputCheckExportPlan.action',
			success:function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
				} else {
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
				showLoadExcelDialog.dialog('close');
				datagrid.datagrid('reload');
			}
		});
		showLoadExcelDialog = $('#showLoadExcelDialog').show().dialog({
	    	title : '导入出运备案信息',
	    	modal : true,
	    	closed : true,
	    	collapsible : true,
	    	buttons : [{
	    		text : '导入',
	    		handler : function(){
	    			$.messager.confirm('请确认', '您要导入出运备案的信息？', function(r) {
	    				if (r) {
			    			if($("#excleFile").val()==""){
			    				alert("请选择导出的excel文件！");
			    				return;
			    			}
			    			showLoadExcelInfoForm.submit();
	    				}
	    			});
	    		}
	    	}]
	    });

	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}

	function edit() {
		$.ajax({
			url : 'checkExportDocAction!checkEmp.action',
			dataType : 'json',
			success : function(r) {
				if (r.success) {
					$.messager.show({
						msg : "只有进口服务部可以进行修改！",
						title : '失败'
					});
				} else {
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
			}
		});
	}
	//导出模板
	function exportTemplate(){
		$("#searchForm").attr("action", "checkExportDocAction!export.action");
		$("#searchForm").submit();
	}
	//导入备案信息
	function inputCheckExportPlan() {
		$("#excleFile").val("");
		$('div.validatebox-tip').remove();
		showLoadExcelDialog.dialog('open');
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 100px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>出口备案</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">订单编号：</div>
						<div class="righttext">
							<input id="orderCode" name="orderCode" type="text" value="${orderNumT}"
								style="width: 125px" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">备案项目号：</div>
						<div class="righttext">
							<input id="docCode" name="docCode" type="text"
								style="width: 125px" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft100">已有备案号：</div>
						<div class="righttext_easyui">
						<select name="docCodeIsNull" id="docCodeIsNull">
							<option value="">全部</option>
							<option value="Y">是</option>
							<option value="N">否</option>
						</select>
						</div>
					</div>
					<div class="item33">
					<div class="oprationbutt">
						<input type="button" value="查  询" onclick="_search();" /> 
						<input type="button" value="导出填写模板" onclick="exportTemplate();" /> 
						<input type="button" value="导入模板" onclick="inputCheckExportPlan();" />
					</div>
					</div>
			</div>
			</div>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	<div id="showLoadExcelDialog" style="display: none;width: 400px;height: 100px;" align="center">
		<form id="showLoadExcelInfoForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="excleProdTypeCode" name="prodType"/>
			<input type="hidden" id="excleSetParts" name="setParts"/>
		    <table class="tableForm">
				<tr>
					<th>导入Excel信息:</th>
						<td>
						    <s:file id="excleFile" name="excleFile"></s:file>
						</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>