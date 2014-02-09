<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
var searchForm;
var datagrid;
var orderBackConfAddDialog;
var orderBackConfAddForm;
var cdescAdd;
var orderBackConfEditDialog;
var orderBackConfEditForm;
var cdescEdit;
var showCdescDialog;
var iframeDialog;
$(function() {
    //查询列表	
    searchForm = $('#searchForm').form();
	datagrid = $('#datagrid').datagrid({
		url : '${dynamicURL}/orderedit/orderBackConfAction!datagrid.do',
		title : '订单修改后重做节点配置表',
		iconCls : 'icon-save',
		pagination : true,
		singleSelect: true,
		pagePosition : 'bottom',
		rownumbers : true,
		pageSize : 10,
		pageList : [ 10, 20, 30, 40 ],
		fit : true,
		fitColumns : true,
		nowrap : true,
		border : false,
		idField : 'id',
		columns : [ [ 
		   {field:'beforeTmodel',title:'修改前T模式',align:'center',width:120,editor:{type:'combobox',options:{
			   url:'${dynamicURL}/tmod/tmodConfigAction!combox.do?activeFlag=1',
			   required:true,
               editable:false,
			   multiple:false,  
               valueField:'configId',
               textField:'tmodName',
               panelHeight:'auto',
               onLoadSuccess:function(){
            	   var value = $(this).combobox("getValue");
            	   if(value!=null){
            		   //reloadNode(value);    		   
            	   }
               },
               onSelect:function(record){
            	   if(record.configId != null){
            		   reloadNode(record.configId);
            	   }
               }
			   }},
				formatter:function(value,row,index){
					return row.beforeTmodelName;
				}
			},				
		   {field:'beforeNode',title:'修改前工作流节点',align:'center',width:120,editor:{type:'combobox',options:{
				   required:true,
	               editable:false,
				   multiple:false,  
	               valueField:'id',
	               textField:'name',
	               panelHeight:'auto',
            	   onLoadSuccess:function(){
            		   var row = datagrid.datagrid("getRows")[editIndex];
            		   if(!hasBackNodeLoad && row!=null && row.beforeTmodel!=null){
            			   hasBackNodeLoad =true;
	            		   $(this).combobox("reload","${dynamicURL}/tmod/tmodConfigAction!listNodes.do?configId="+row.beforeTmodel);
            		   }
                   }
		  		 }},
				formatter:function(value,row,index){
					return row.beforeNode;
				}
			},				
		   {field:'nodeCodes',title:'需要重做的节点',align:'center',width:300,editor:{type:'multiplecombobox',options:{
	               editable:false,
				   multiple:true,  
	               valueField:'id',
	               textField:'name',
	               panelHeight:'auto',
            	   onLoadSuccess:function(){
            		   var row = datagrid.datagrid("getRows")[editIndex];
            		   if(!hasNodesLoad && row!=null && row.beforeTmodel!=null){
            			   hasNodesLoad =true;
	            		   $(this).combobox("reload","${dynamicURL}/tmod/tmodConfigAction!listNodes.do?configId="+row.beforeTmodel);
            		   }
                   }
		  		 }},
				formatter:function(value,row,index){
					return row.nodeCodes;
				}
			},				
		   {field:'activeFlag',title:'有效标识',align:'center',width:60,editor:{type:'checkbox',options:{on:'1',off:'0'}},
				formatter:function(value,row,index){
					if( row.activeFlag && row.activeFlag =='1'){
						return '有效';
					}
					return '无效';
				}
			},				
		   {field:'createDate',title:'创建时间',align:'center',width:60,
				formatter:function(value,row,index){
					return dateFormatYMD(row.createDate);
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
			text : '保存',
			iconCls : 'icon-save',
			handler : function() {
				save();
			}
		}, '-', {
			text : '取消修改',
			iconCls : 'icon-save',
			handler : function() {
				reject();
			}
		}, '-' ],
		onDblClickRow: onDbClickRow,
		onRowContextMenu : function(e, rowIndex, rowData) {
			e.preventDefault();
			if(endEditing()){
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
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

function del() {
	var rows = datagrid.datagrid('getSelections');
	var ids = "";
	if (rows.length > 0) {
		$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
			if (r) {
				for ( var i = 0; i < rows.length; i++) {
					if(i!=rows.length-1)
						ids=ids+"ids="+rows[i].id+"&";
					else ids=ids+"ids="+rows[i].id;
				}
				$.ajax({
					url : 'orderBackConfAction!delete.do',
					data : ids,
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
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url : '${dynamicURL}/orderedit/orderBackConfAction!showDesc.do',
			data : {
				id : rows[0].id
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				orderBackConfEditForm.find('input,textarea').val('');
				orderBackConfEditForm.form('load', response);
				$('div.validatebox-tip').remove();
				orderBackConfEditDialog.dialog('open');
				$.messager.progress('close');
			}
		});
	} else {
		$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
	}
}

var editIndex = undefined;
var hasBackNodeLoad = false;
var hasNodesLoad = false;
function endEditing(){
	if (editIndex == undefined){return true}
	if (datagrid.datagrid('validateRow', editIndex)){
		var ed = datagrid.datagrid('getEditor', {index:editIndex,field:'beforeTmodel'});
		var beforeTmodelName = $(ed.target).combobox("getText");
		datagrid.datagrid('getRows')[editIndex]['beforeTmodelName'] = beforeTmodelName;
		datagrid.datagrid('endEdit', editIndex);
		editIndex = undefined;
		hasBackNodeLoad = false;
		hasNodesLoad = false;
		return true;
	} else {
		return false;
	}
}
function onDbClickRow(index){
	if (editIndex != index){
		if (endEditing()){
			editIndex = index;
			datagrid.datagrid('selectRow', index)
					.datagrid('beginEdit', index);
		} else {
			datagrid.datagrid('selectRow', editIndex);
		}
	}
}
function add(){
	if (endEditing()){
		datagrid.datagrid('appendRow',{activeFlag:'1'});
		editIndex = datagrid.datagrid('getRows').length-1;
		datagrid.datagrid('selectRow', editIndex)
				.datagrid('beginEdit', editIndex);
	}
}
function save(){
	if (endEditing()){
		var changesRows = datagrid.datagrid('getChanges');
		if(changesRows.length>0){
			var jsonStr = JSON.stringify(changesRows);
			$.ajax({
				url : '${dynamicURL}/orderedit/orderBackConfAction!saveOrUpdate.do',
				data : {
					orderBackConfList :jsonStr
				},
				dataType : 'json',
				cache : false,
				type:'post',
				success : function(json) {
					if (json.success) {
						$.messager.show({
							title : '成功',
							msg : json.msg
						});
						datagrid.datagrid('reload');
					} else {
						var msg = json.msg;
						if(msg==null||msg.length<1){
							msg ='操作失败！';
						}
						$.messager.show({
							title : '失败',
							msg : msg
						});
					}
				}
			});
		}
	}
}

function reject(){
	datagrid.datagrid('rejectChanges');
	editIndex = undefined;
}

function reloadNode(configId){
	var ed = datagrid.datagrid('getEditor', {index:editIndex,field:'beforeNode'});
	$(ed.target).combobox("reload","${dynamicURL}/tmod/tmodConfigAction!listNodes.do?configId="+configId);
	ed = datagrid.datagrid('getEditor', {index:editIndex,field:'nodeCodes'});
	$(ed.target).combobox("reload","${dynamicURL}/tmod/tmodConfigAction!listNodes.do?configId="+configId);
	$(ed.target).combobox('setValues', []);
}
</script>
</head>
<body class="easyui-layout zoc">
  <div class="zoc" region="north" border="false" collapsed="false"  style="height: 65px;overflow: auto;" align="left" >
        <form id="searchForm">
            <div class="navhead_zoc" style="min-width:0px"><span>订单修改配置大类</span></div>
            <div class="part_zoc" style="min-width:0px">
            	<div class="oneline">	
					<div class="item33">
						<div class="itemleft80">T模式：</div>
						<div class="righttext">
						    <input type="text" class="easyui-combobox" name="beforeTmodel" data-options="
									url:'${dynamicURL}/tmod/tmodConfigAction!combox.do?activeFlag=1',
				              	 	editable:false,
							   		multiple:false,  
				               		valueField:'configId',
				               		textField:'tmodName',
				               		panelHeight:'auto',
							">
						</div>
					</div>
					<div class="item25 lastitem">
						<div class="oprationbutt">
							<input type="button" onclick="_search();" value="查  询">
							<input type="button" onclick="cleanSearch();" value="重置">
						</div>
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