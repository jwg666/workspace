<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var editRow = undefined;
	var datagrid;
	var proTypeCombox=[];
	var columnNameCombox;
	$(function() {
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'customRecordSetAction!datagrid.action',
			title : '备案信息维护',
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
			columns : [ [ 
				{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.obid;
						}
				},
			   {field:'prodTypeCode',title:'产品大类',align:'center',sortable:false,width : 150,
			  	    editor : {
			  	    	type:'combobox',
						editable: false,
						options:{
						    valueField:'prodTypeCode',  
                            textField:'prodType',
                            data:proTypeCombox,
                            onChange: function (newValue,oldValue) {
                            	var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'setParts'}).target;
                            	columnComboboxs(newValue,editor_target.combobox("getValue"));
                            }
						}
					},
					formatter:function(value,row,index){
				    	return row.proTypeName;
					}
				},		
				 {field:'setParts',title:'整机/散件',align:'center',sortable:false,width : 85,
			  	    editor : {
			  	    	type:'combobox',
						editable: false,
						options:{
						    valueField:'id',  
                            textField:'value',
                            panelHeight: 50,
                            data:[{'id':'1','value':'整机'},
                                  {'id':'2','value':'散件'}],
                            onChange: function (newValue,oldValue) {
                                 var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'prodTypeCode'}).target;
                                 columnComboboxs(editor_target.combobox("getValue"),newValue);
                              }
						}
					},
					formatter:function(value,row,index){
						if (row.setParts == "1") {
							return "整机";
						} else if (row.setParts == "2") {
							return "散件";
						} else {
							return "";
						}
					}
				},			
			   {field:'propertyName',title:'属性名',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.propertyName;
					}
				},		
				{field:'propertyDesc',title:'属性描述',align:'center',sortable:false,width : 85,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.propertyDesc;
					}
				},		
			   {field:'columnName',title:'列名',align:'center',sortable:false,width : 85,
			  	    editor : {
			  	    	type:'combobox',
						editable: false,
						options:{
							data:columnNameCombox,
						    valueField:'columnId',  
                            textField:'columnValue'
                           
						}
					},
					formatter:function(value,row,index){
						return row.columnName;
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
				$.ajax({
					url : 'customRecordSetAction!checkUpdate.action',
					data : rowData,
					dataType : 'json',
					success : function(r) {
						/* if (r.success) {
							$.messager.alert("提示","修改后的数据重复，请重新修改提交!","error");
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('rejectChanges');
							editRow = undefined;
							return;
						}else{ */
							var url = '';
							if (inserted.length > 0) {
								url = 'customRecordSetAction!add.action';
							}
							if (updated.length > 0) {
								url = 'customRecordSetAction!edit.action';
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
										datagrid.datagrid('beginEdit', editRow);
										$.messager.alert('错误', r.msg, 'error');
									}
									datagrid.datagrid('unselectAll');
								}
							});
						//}
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
				cid : sy.UUID(),
				setParts:'1'
			};
			datagrid.datagrid('appendRow', row);
			editRow = datagrid.datagrid('getRows').length - 1;
			datagrid.datagrid('selectRow', editRow);
			datagrid.datagrid('beginEdit', editRow);
			//显示产品大类下拉
			prodTypeComboboxs();
			//显示列名下拉
			//columnComboboxs(rows[0].prodTypeCode,rows[0].setParts);
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
						ids.push(rows[i].customRecordId);
					}
					$.ajax({
						url : 'customRecordSetAction!delete.action',
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
				//显示产品大类下拉
				prodTypeComboboxs();
				//显示列名下拉
				columnComboboxs(rows[0].prodTypeCode,rows[0].setParts);
				datagrid.datagrid('unselectAll');
				//datagrid.datagrid('loadData');
			}
		} else {
			$.messager.show({
				msg : '请选择一项进行修改！',
				title : '错误'
			});
		}
	}
	function prodTypeComboboxs(){
		//显示产品大类下拉
		var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'prodTypeCode'}).target;
		$.ajax({
    	     url:'${dynamicURL}/basic/prodTypeAction!combox.do',
    	     dataType:"json",
    	     success:function(data){
    	    	 editor_target.combobox('loadData',data);
    	    	 proTypeCombox = editor_target.combobox('getData');
    	     }
		});
	}
	function columnComboboxs(prodTypeCode,setParts){
		//显示列名下拉信息
		var editor_target_columnName = $('#datagrid').datagrid('getEditor',{index:editRow,field:'columnName'}).target;
		$.ajax({
    	     url:'customRecordSetAction!columnCombox.do',
    	     data : {
    	    	 prodTypeCode : prodTypeCode,
    	    	 setParts:setParts
				},
    	     dataType:"json",
    	     success:function(data){
    	    	 editor_target_columnName.combobox('loadData',data);
 				 columnNameCombox = editor_target_columnName.combobox('getData');
    	     }
		});
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 120px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>备案属性维护</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">产品大类：</div>
						<div class="righttext_easyui">
						<input name="prodTypeCode" class="easyui-combobox short60"
										style="width: 130px" 
										data-options="valueField:'prodTypeCode',textField:'prodType',url:'${dynamicURL}/basic/prodTypeAction!combox.action'" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">类型：</div>
						<div class="righttext">
						<select name="setParts">
							<option value="1">整机</option>
							<option value="2">散件</option>
						</select>
						</div>
					</div>
				</div>
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查  询" onclick="_search();" />
					</div>
				</div>
			</div>
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