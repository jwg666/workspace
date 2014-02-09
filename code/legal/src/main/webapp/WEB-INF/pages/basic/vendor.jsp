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
			url : 'vendorAction!datagrid.action',
			title : '供应商信息',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 15,
			pageList : [ 15, 30, 40, 50, 100 ],
			fit : true,
			fitColumns : true,
			rownumbers : true,
			nowrap : false,
			border : false,
			idField : 'obid',
			
			columns : [ [ 
				{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.obid;
						}
				},
			   {field:'vendorCode',title:'供应商编码',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.vendorCode;
					}
				},				
			   {field:'vendorType',title:'供应商类型',align:'center',sortable:false,
			  	    editor : {
			  	    	type:'combobox',
						editable: false,
						options:{
							valueField:'value',  
                            textField:'label',
                            panelHeight: 50,
							data: [{
								label: '船公司',
								value: '0'
							},{
								label: '报关行',
								value: '1'
							},{
								label: '商检代理商',
								value: '2'
							},{
								label: '货代',
								value: '3'
							},{
								label: '空运',
								value: '4'
							}]
						}
					},
					formatter:function(value,row,index){
						if(row.vendorType=="0"){
							return "船公司";
						}else if(row.vendorType=="1"){
							return "报关行";
						}else if(row.vendorType=="2"){
							return "商检代理商";
						}else if(row.vendorType=="3"){
							return "货代";
						}else if(row.vendorType=="4"){
							return "空运";
						}
					}
				},				
			   {field:'vendorNameCn',title:'中文名',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.vendorNameCn;
					}
				},				
			   {field:'vendorNameEn',title:'英文名',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.vendorNameEn;
					}
				},				
			   {field:'activeFlag',title:'是否有效',align:'center',sortable:false,
			  	    editor : {
			  	    	type:'combobox',
						editable: false,
						options:{
							valueField:'value',  
                            textField:'label',
                            panelHeight: 50,
							data: [{
								label: '有效',
								value: '1'
							},{
								label: '无效',
								value: '0'
							}]
						}
					},
					formatter:function(value,row,index){
						if(row.activeFlag=="1"){
							return "有效";
						}else{
							return "无效";
						}
					}
				},				
			   {field:'orderBy',title:'排序值',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.orderBy;
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
					url = 'vendorAction!add.action';
				}
				if (updated.length > 0) {
					url = 'vendorAction!edit.action';
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
		searchForm.form("clear");
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
						ids.push(rows[i].rowId);
					}
					$.ajax({
						url : 'vendorAction!delete.action',
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
	<div class="zoc" region="north" border="false" collapsible="true"
		style="height: 110px; overflow: hidden;">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>供应商信息</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
				<div class="item25">
					<div class="itemleft60">供应商名称：</div>
						<div class="righttext">
							<input id="vendorNameCn" name="vendorNameCn" type="text"
								style="width: 125px" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">供应商编码：</div>
						<div class="righttext">
							<input id="vendorCode" name="vendorCode" type="text"
								style="width: 125px" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">供应商类型：</div>
						<div class="righttext">
							<select id="vendorType" name="vendorType">
								<option value="">全部</option>
								<option value="0">船公司</option>
								<option value="1">报关行</option>
								<option value="2">商检代理商</option>
								<option value="3">货代</option>
								<option value="4">空运</option>
							</select>
						</div>
					</div>
				</div>
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查  询" onclick="_search();" />
						<input type="button" value="重  置" onclick="cleanSearch();" />
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