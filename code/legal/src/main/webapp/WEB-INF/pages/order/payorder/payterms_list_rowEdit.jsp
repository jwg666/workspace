<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
			url : 'paymentTermsAction!datagrid.action',
			title : '付款条件列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 50,
			pageList : [ 10, 20, 30, 40, 50, 100 ],
			fit : true,
			fitColumns : false,
			rownumbers : true,
			nowrap : true,
			border : false,
			idField : 'obid',
			
			columns : [ [ 
				{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.obid;
						}
				},
			   {field:'termsCode',title:'付款条件编码',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.termsCode;
					}
				},				
			   {field:'payNum',title:'付款次数',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {required:true}
					},
					formatter:function(value,row,index){
						return row.payNum;
					}
				},				
			   {field:'termsDesc',title:'付款条件描述',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.termsDesc;
					}
				},				
			   {field:'payOneRate',title:'一次付款比例',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {required:true}
					},
					formatter:function(value,row,index){
						return row.payOneRate;
					}
				},				
			   {field:'payOneMethod',title:'一次付款方式',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.payOneMethod;
					}
				},				
			   {field:'paySecendRate',title:'二次付款比例',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {required:true}
					},
					formatter:function(value,row,index){
						return row.paySecendRate;
					}
				},				
			   {field:'paySecendMethod',title:'二次付款方式',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.paySecendMethod;
					}
				},				
			   {field:'payThirdRate',title:'三次付款比例',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {required:true}
					},
					formatter:function(value,row,index){
						return row.payThirdRate;
					}
				},				
			   {field:'payThirdMethod',title:'三次付款方式',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.payThirdMethod;
					}
				},				
			   {field:'payFourthRate',title:'四次付款比例',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {required:true}
					},
					formatter:function(value,row,index){
						return row.payFourthRate;
					}
				},				
			   {field:'payFourthMethod',title:'四次付款方式',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.payFourthMethod;
					}
				},				
			   {field:'priority',title:'优先级',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.priority;
					}
				},				
			   {field:'docFlag',title:'1 生产不发货 2发货不寄单',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.docFlag;
					}
				},				
			   {field:'activeFlag',title:'1=有效，0=无效',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.activeFlag;
					}
				},				
			   {field:'createdBy',title:'创建人Id',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'created',title:'创建日期',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'lastUpdBy',title:'修改人Id',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'lastUpd',title:'修改日期',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'datebox',
							options : {}
					},
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				},				
			   {field:'modificationNum',title:'修改次数',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {required:true}
					},
					formatter:function(value,row,index){
						return row.modificationNum;
					}
				},				
			   {field:'payPeriod',title:'付款周期',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {required:true}
					},
					formatter:function(value,row,index){
						return row.payPeriod;
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
					url = 'paymentTermsAction!add.action';
				}
				if (updated.length > 0) {
					url = 'paymentTermsAction!edit.action';
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
						url : 'paymentTermsAction!delete.action',
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