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
			url : 'orderAuditSetAction!datagrid.action',
			title : '订单评审配置列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 15,
			pageList : [ 15, 30, 50],
			fit : true,
			fitColumns : false,
			rownumbers : true,
			nowrap : true,
			border : false,
			columns : [ [ 
				{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.rowId;
						}
				},
			   {field:'subjectA',title:'类别',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.subjectA;
					}
				},				
			   {field:'subjectB',title:'评审项',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.subjectB;
					}
				},				
			   {field:'auditContent',title:'评审描述',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.auditContent;
					}
				},				
			   {field:'promoteDept',title:'推进方式',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.promoteDept;
					}
				},				
			   {field:'code',title:'方法名',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.code;
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
					url = 'orderAuditSetAction!add.action';
				}
				if (updated.length > 0) {
					url = 'orderAuditSetAction!edit.action';
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
						ids.push(rows[i].rowId);
					}
					$.ajax({
						url : 'orderAuditSetAction!delete.action',
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
	<div region="north" border="false" class="zoc"
		style="height: 100px; overflow: auto;" align="left">
		<form id="searchForm" method="post">
			<s:hidden name="loginName" id="loginName" />
			<div class="navhead_zoc">
				<span>订单评审维护</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>操作：</span>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">类别 ：</div>
						<div class="righttext">
							<input id="subjectA" name="subjectA"
								style="width: 160px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">评审项 ：</div>
						<div class="righttext">
							<input id="subjectB" name="subjectB"
								style="width: 160px;" />
						</div>
					</div>
					<div class="item33">
						<div class="oprationbutt">
							<input type="button" value="搜索" onclick="_search();;" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

</div>
</body>
</html>