<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var editRow = undefined;
	var datagrid;
	var countryData;
	$(function() {
		$.ajax({
			url:'${dynamicURL}/basic/customerAwareAction!getCountryData.action',
			dataType : 'json',
			async:false,
			success : function(response) {
				countryData=response;
			}
		});
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'customerAwareAction!datagrid.action',
			title : '客户列表',
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
							return row.id;
						}
				},
						
			   {field:'customerCode',title:'客户编码',align:'center',sortable:false,width : 185,
			  	    editor : {
							type : 'singlecombogrid',
							options : {
								data :countryData,
								required : true,
								panelWidth : 500,
								panelHeight : 220,
								pagination : true,
								fit : true,
								fitColumns : true,
								pagePosition : 'bottom',
								pageSize : 5,
								pageList : [ 5, 10 ],
								valueField : 'customerCode',
								idField	:'customerCode',
								textField:'customerCode',
								loadFilter:pagerFilter,
								columns : [ [ {
									field : 'customerCode',
									title : '客户编号',
									width : 20
								}, {
									field : 'customerName',
									title : '客户名称',
									width : 20
								} ] ]

							}
					},
					formatter:function(value,row,index){
						return row.customerCode;
					}
				},				
			   {field:'customerName',title:'客户名称',align:'center',sortable:false,width : 185,			  	   
					formatter:function(value,row,index){
						return row.customerName;
					}
				},	
				
				{field:'createBy',title:'创建人',align:'center',sortable:false,width : 85,			  	   
					formatter:function(value,row,index){
						return row.createBy;
					}
				},
			   {field:'createTime',title:'创建时间',align:'center',sortable:false,width : 85,			  	   
					formatter:function(value,row,index){
						return dateFormatYMD(row.createTime);
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
					url = 'customerAwareAction!add.action';
				}
				if (updated.length > 0) {
					url = 'customerAwareAction!edit.action';
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
						ids.push(rows[i].id);
					}
					$.ajax({
						url : 'customerAwareAction!delete.action',
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
	function pagerFilter(data){
        if (typeof data.length == 'number' && typeof data.splice == 'function'){    // is array
            data = {
                total: data.length,
                rows: data
            }
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            onSelectPage:function(pageNum, pageSize){
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh',{
                    pageNumber:pageNum,
                    pageSize:pageSize
                });
                dg.datagrid('loadData',data);
            }
        });
        if (!data.originalRows){
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    }
</script>

</head>
<body class="easyui-layout">
	
	<div class="zoc" region="north" border="false" collapsible="true"
					title="查询" collapsed="false" style="height: 90px; overflow: hidden;">
					        <form id="searchForm">			
		    <div class="oneline">
				<div class="item25">
					<div class="itemleft80">客户编码:</div>
					<div class="righttext_easyui">
						<input name="customerCode"  id="customerCode"  type="text" style="width: 130px;"/>						
					</div>
				</div>	
				<div class="item25">
					<div class="itemleft80">客户名称:</div>
					<div class="righttext_easyui">
						<input name="customerName"  id="customerName"  type="text" style="width: 130px;"/ >						
					</div>
				</div>			
			   <div class="item25">
					<div class="oprationbutt">
						<input type="button" onclick="_search();" value="查  询" /> 
						<input type="button" onclick="cleanSearch();" value="重置" />
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