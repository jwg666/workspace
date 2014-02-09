<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="hop" uri="/hoptree-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" src="${staticURL}/scripts/jquery.ztree.all-3.5.js"></script>
<link rel="stylesheet" href="${staticURL}/style/hopCss/hop.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
$.ajaxSetup({
	dataType : 'json'
});
function zTreeOnCheck(event, treeId, treeNode) {
	$("#itemCode").val(treeNode.id);
}

//此函数为ztree中callback函数，请确保该函数定义在hop:tree之前，一般定义在<head>的<script>中即可
</script>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var sysLovAddDialog;
	var sysLovAddForm;
	var cdescAdd;
	var sysLovEditDialog;
	var sysLovEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	var editRow = undefined;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'sysLovAction!datagrid.do',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 15,
			pageList : [ 10, 15, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'rowId',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.rowId;
						}
					},
			   {field:'rowId',title:'唯一标识',align:'center',sortable:true,hidden:true,
					formatter:function(value,row,index){
						return row.rowId;
					}
				},				
			   {field:'itemCode',title:'数据编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.itemCode;
					},
					editor : {
						type : 'validatebox',
						options : {}
					}
				},			
			   {field:'itemNameCn',title:'中文值',align:'center',sortable:true,width:60,
					formatter:function(value,row,index){
						return row.itemNameCn;
					},
					editor : {
						type : 'validatebox',
						options : {}
					}
				},				
			   {field:'itemNameEn',title:'英文值',align:'center',sortable:true,width:60,
					formatter:function(value,row,index){
						return row.itemNameEn;
					},
					editor : {
						type : 'validatebox',
						options : {}
					}
				},				
			   {field:'itemOrderBy',title:'排序',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.itemOrderBy;
					},
					editor : {
						type : 'validatebox',
						options : {}
					}
				},				
			   {field:'itemComment',title:'描述',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.itemComment;
					},
					editor : {
						type : 'validatebox',
						options : {}
					}
				},				
			   {field:'activeFlag',title:'是否有效',align:'center',sortable:true,
					formatter:function(value,row,index){
						if(row.activeFlag=='0') {
							return '无效';
						}
						if(row.activeFlag=='1') {
							return '有效';
						}
					},
					editor : {
						type:'combobox',
						editable: false,
						options:{
							valueField:'value',  
                            textField:'label',
                            panelHeight: 50,
							data: [{
								label: '无效',
								value: '0'
							},{
								label: '有效',
								value: '1'
							}]
						}
					}
				},				
			   {field:'createdBy',title:'创建人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			  		
			   {field:'lastUpdBy',title:'修改人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
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
			}, '-',{
				text : '保存',
				iconCls : 'icon-edit',
				handler : function() {
					save();
				}
			}, '-', {
				text : '取消编辑',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
					datagrid.datagrid('rejectChanges');
					editRow = undefined;
				}
			}, '-' ],
			onDblClickRow : function(rowIndex, rowData) {
				if (editRow != undefined) {
					datagrid.datagrid('endEdit', editRow);
				}
				datagrid.datagrid('beginEdit', rowIndex);
				editRow = rowIndex;
				datagrid.datagrid('unselectAll');
				datagrid.datagrid('selectRow', rowIndex);
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
	function _search(event, treeId, treeNode) {
		var treeObj = $.fn.zTree.getZTreeObj("depTree");
		if(!treeNode.checked){
			treeObj.checkNode(treeNode, true, true,true);
		}
		$("#itemCode").val(treeNode.id);
		datagrid.datagrid('load', {"itemType" : treeNode.id});
		datagrid.datagrid('unselectAll');
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function save(){
		var treeObj = $.fn.zTree.getZTreeObj("depTree");
		var nodes = treeObj.getCheckedNodes(true);
		if(nodes==""){
			$.messager.alert('提示','请选择类型','error');
			return;
		}
		datagrid.datagrid('endEdit', editRow);
		var rows = datagrid.datagrid('getChanges');
		var jsonStr = JSON.stringify(rows);
		var itemCode = $('#itemCode').val();
		$.ajax({
			url:"${dynamicURL}/basic/sysLovAction!add.action?code="+itemCode,
			type:"post",
			data : {listsyslov : jsonStr},
			success : function() {
				datagrid.datagrid('load', {"itemType" : $("#itemCode").val()});
				$.messager.show({
					title : '提示',
					msg : '保存成功！'
				});
				var treeObj = $.fn.zTree.getZTreeObj("depTree");
				var nodes = treeObj.getSelectedNodes();
				if (nodes.length>0) {
					treeObj.reAsyncChildNodes(nodes[0], "refresh");
				}
				datagrid.datagrid('unselectAll');
			}
		});
	}
	function add() {
		if (editRow != undefined) {
			datagrid.datagrid('endEdit', editRow);
			datagrid.datagrid('unselectAll');
		}
		var row = {};
		datagrid.datagrid('appendRow', row);
		editRow = datagrid.datagrid('getRows').length - 1;
		datagrid.datagrid('selectRow', editRow);
		datagrid.datagrid('beginEdit', editRow);
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].rowId+"&";
						else ids=ids+"ids="+rows[i].rowId;
					}
					$.ajax({
						url : 'sysLovAction!delete.do',
						data : ids,
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load', {"itemType" : $("#itemCode").val()});
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
							var treeObj = $.fn.zTree.getZTreeObj("depTree");
							var nodes = treeObj.getSelectedNodes();
							if (nodes.length>0) {
								treeObj.reAsyncChildNodes(nodes[0], "refresh");
							}
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'error');
		}
	}
	function edit() {
		if (editRow != undefined) {
			datagrid.datagrid('endEdit', editRow);
		}
		var rows = datagrid.datagrid('getSelections');
		if(rows.length == 1) {
			editRow = datagrid.datagrid('getRowIndex', rows[0]);
			datagrid.datagrid('beginEdit', editRow);
		}
		else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
</script>
</head>
<body>
	 <div class="easyui-layout" data-options="fit:true" style="height:530px;"> 
        <div data-options="region:'west',split:true" title="数据类型" style="width:300px;">
        	<hop:tree url="${dynamicURL}/basic/syslovTree.do"
					expandUrl="${dynamicURL}/basic/syslovTree.do" 
					async="true" 
					chkType="radio" 
					id="depTree"
					setting="{check: {enable: true, chkStyle: 'radio', radioType: 'all'}, data: {simpleData: { enable: true}}, async: {enable:true, url: getTreeExpandUrl},callback:{onCheck: zTreeOnCheck,onClick: _search} };"
					>
			</hop:tree>
        </div>
        <input type="hidden" name="itemCode" id="itemCode">
        <div data-options="region:'center',title:'数据字典列表',iconCls:'icon-ok'">  
        	<table id="datagrid"></table>
        </div>  
    </div>  
</body>
</html>