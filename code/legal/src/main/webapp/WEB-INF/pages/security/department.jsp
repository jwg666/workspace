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
<title>Insert title here</title>
<script>
$.ajaxSetup({
	dataType : 'json'
});
function zTreeOnCheck(event, treeId, treeNode){
	if(treeNode.checked == true){
		if(treeNode.id=="0"||treeNode.id=="-111"){
			$("#deptParentCode").val("-1");
			$("#ParentCodeEdit").val("-1");
			
		}else{
			$("#deptParentCode").val(treeNode.id);
			$("#ParentCodeEdit").val(treeNode.id);
		}
		if(treeNode.id=="-111"){
			$("#dept").val("1");
		}else{
			$("#dept").val(treeNode.id);
		}
	}else{
		$("#deptParentCode").val('-1');
		$("#ParentCodeEdit").val('-1');
	}
}
//此函数为ztree中callback函数，请确保该函数定义在hop:tree之前，一般定义在<head>的<script>中即可
</script>
<script type="text/javascript" charset="utf-8">
    var searchForm;
    var searchUserForm;
	var datagrid;
	var cdDepartmentAddDialog;
	var cdDepartmentAddForm;
	var cdescAdd;
	var cdDepartmentEditDialog;
	var cdDepartmentEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	var searchUserDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'departmentAction!datagrid.do',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			//fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'rowId',
			
			frozenColumns : [[     
				{field:'ck',checkbox:true,
					formatter:function(value,row,index){
						return row.rowId;
					}
				},
				{field:'rowId',title:'唯一标识,UUID,GUID',align:'center',sortable:true,hidden:true,
					formatter:function(value,row,index){
						return row.rowId;
					}
				},				
				{field:'deptCode',title:'组织部门编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.deptCode;
					}
				},				
				{field:'deptType',title:'组织类型',align:'center',sortable:true,
					formatter:function(value,row,index){
						if(row.deptType=="1"){
							return "经营体";
						}else if(row.deptType=="0"){
							return "工厂";
						}else{
							return row.deptType;
						}
					}
				},				
				{field:'deptNameCn',title:'组织中文名',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.deptNameCn;
					}
				},				
				{field:'deptNameEn',title:'组织英文名',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.deptNameEn;
					}
				}
             ]],
			columns : [ [ 
			   {field:'deptOwner',title:'组织负责人编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.deptOwner;
					}
				},
				{field:'operators',title:'工厂经营主体',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.operators;
					}
				},				
			   {field:'operatorsCode',title:'经营主体编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.operatorsCode;
					}
				},				
			   {field:'checkCode',title:'商检批次号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.checkCode;
					}
				},
				{field:'hgvsCode',title:'HGVS工厂编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.hgvsCode;
					}
				},
				{field:'deptName',title:'对应WMS服务器',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.deptName;
					}
				},
				{field:'storeLocation',title:'库存工位',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.storeLocation;
					}
				},
				{field:'taxbackName',title:'公司抬头',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.taxbackName;
					}
				},
				{field:'taxbackCode',title:'税号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.taxbackCode;
					}
				},
			   {field:'activeFlag',title:'是否有效',align:'center',sortable:true,
					formatter:function(value,row,index){
						if(row.activeFlag==1){
							return "有效";
						}else{
							return "无效";
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
				}
			 ] ],
			toolbar : [ {
				text : '增加部门',
				iconCls : 'icon-add',
				handler : function() {
					add();
				}
			}, '-',{
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
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ],
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
		cdDepartmentAddForm = $('#cdDepartmentAddForm').form({
			url : 'departmentAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					cdDepartmentAddForm.form('clear');
					datagrid.datagrid('reload');
					cdDepartmentAddDialog.dialog('close');
					var treeObj = $.fn.zTree.getZTreeObj("depTree");
					var nodes = treeObj.getSelectedNodes();
					if (nodes.length>0) {
						treeObj.reAsyncChildNodes(nodes[0], "refresh");
					}
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		cdDepartmentAddDialog = $('#cdDepartmentAddDialog').show().dialog({
			title : '添加组织类型',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					var dept = $("#dept").val();
					$('#deptType').val(dept);
					if(dept.length>1){
						$.messager.alert('提示','只能给工厂货经营体添加部门','');
						return false;
					}
					cdDepartmentAddForm.submit();
				}
			} ]
		});

		cdDepartmentEditForm = $('#cdDepartmentEditForm').form({
			url : 'departmentAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					cdDepartmentEditDialog.dialog('close');
					var treeObj = $.fn.zTree.getZTreeObj("depTree");
					var nodes = treeObj.getSelectedNodes();
					if (nodes.length>0) {
						treeObj.reAsyncChildNodes(nodes[0], "refresh");
					}
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		cdDepartmentEditDialog = $('#cdDepartmentEditDialog').show().dialog({
			title : '编辑组织类型',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					cdDepartmentEditForm.submit();
				}
			} ]
		});

	});

	function _search(event, treeId, treeNode) {
		datagrid.datagrid('load', {"deptParentCode" : treeNode.id});
		var treeObj = $.fn.zTree.getZTreeObj("depTree");
		if(!treeNode.checked){
			treeObj.checkNode(treeNode, true, true,true);
			if(treeNode.checked == true){
				$("#ParentCode").val(treeNode.id);
			}else{
				$("#ParentCode").val('-1');
			}
		}
		datagrid.datagrid('unselectAll');
	}
	function search(){
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function add() {
		var dept = $("#dept").val();
		var deptParentCode =  $("#deptParentCode").val();
		if(dept=="0"){
			$('#deptType').val("工厂");
		}else{
			$('#deptType').val("经营体");
		}
		$('#ParentCode').val(deptParentCode);
		
		if(dept == ""){
			$.messager.alert('提示','请选择类型','');
			return false;
		}
		cdDepartmentAddDialog.dialog('open');
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
						url : 'departmentAction!delete.do',
						data : ids,
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
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
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url : 'departmentAction!showDesc.do',
				data : {
					rowId : rows[0].rowId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					cdDepartmentEditForm.form("clear");
					cdDepartmentEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					cdDepartmentEditDialog.dialog('open');
					$.messager.progress('close');
					
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
</script>

</head>
<body class="easyui-layout">
	<div class="zoc" collapsed="true" data-options="region:'north',title:'查询',split:true" style="height:60px;">
		<form id="searchForm">
			<div class="oneline">
                <div class="item33">
                    <div class="itemleft60">组织：</div>
                    <div class="righttext">
                    	<input name="deptCode" class="easyui-combobox" style="width: 200px;"
					 			data-options="valueField:'deptCode',textField:'deptNameCn',url:'${dynamicURL}/security/departmentAction!combox.do'" />
                    </div>
                </div>
                <div class="item25">
                   <div class="itemleft60">中文名称：</div>
                   <div class="righttext_easyui">
						<input name="deptNameCn" type="text" class="easyui-validatebox"/>
					</div>
                </div>
                 <div class="item25 lastitem">
	                  <div class="oprationbutt">
						<input type="button" onclick="search()" value="查询" />
						<input type="button" onclick="cleanSearch()" value="取消" />
					  </div>
                </div>
             </div>
		</form>
	</div>  
   	<div data-options="region:'west',title:'组织类型',split:true" style="width:350px;">
	    <hop:tree url="${dynamicURL}/basic/departmentTree.do"
			expandUrl="${dynamicURL}/basic/departmentTree.do"  
			async="true"  
			chkType="radio"  
			id="depTree" 
			setting="{check: {enable: true, chkStyle: 'radio', radioType: 'all'}, data: {simpleData: { enable: true}}, async: {enable:true, url: getTreeExpandUrl},callback:{onCheck: zTreeOnCheck,onClick: _search}};" 
			> 
		</hop:tree> 
       </div>
       <div data-options="region:'center',title:'组织类型列表'" style="padding:5px;background:#eee;">
       	<table id="datagrid"></table>
       </div> 
       <input type="hidden" id="dept" />
       <input type="hidden" id="deptParentCode" />
       <input type="hidden" id="ParentCodeEdit" />
       <div id="cdDepartmentAddDialog" style="display: none;width: 520px;height: 420px;" align="center">
		<form id="cdDepartmentAddForm" method="post">
			<table class="tableForm" style="width: 500px">
				<tr>
					<th>组织部门编码：</th>
					<td>
						<input name="deptParentCode" id="ParentCode" type="hidden" />
						<input name="deptCode" type="text" class="easyui-validatebox" data-options="required:true"missingMessage="请填写组织部门编码"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
					<th>组织类型：</th>
					<td>
						<input id="deptType" name="deptType" readonly="readonly" type="text" class="easyui-validatebox" data-options=""  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
					<th>组织中文名：</th>
					<td>
						<input name="deptNameCn" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写组织中文名"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
					<th>组织英文名：</th>
					<td>
						<input name="deptNameEn" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写组织英文名"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
					<th>组织负责人编码：</th>
					<td>
						<input name="deptOwner" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写组织负责人编码"  style="width: 155px;"/>						
					</td>
				</tr>
				<tr>
					<th>工厂经营主体：</th>
						<td>
							<input name="operators" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写工厂经营主体"  style="width: 155px;"/>
						</td>
					</tr>
					<tr>
					<th>经营主体编码：</th>
						<td>
							<input name="operatorsCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写经营主体编码"  style="width: 155px;"/>
						</td>
					</tr>
					<tr>
					<th>商检批次号：</th>
						<td>
							<input name="checkCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写商检批次号"  style="width: 155px;"/>
						</td>
					</tr>
					<tr>
						<th>HGVS工厂编码：</th>
						<td>
							<input name="hgvsCode" type="text" class="easyui-validatebox"  style="width: 155px;"/>
						</td>
					</tr>
					<tr>
						<th>对应WMS服务器：</th>
						<td>
							<input name="wmsServer" class="easyui-combobox"
						 				data-options="valueField:'dbId',textField:'deptName',url:'${dynamicURL}/datatrans/dbLinkAction!combox.do?dbUseType=1'" />
						
						</td>
					</tr>
					<tr>
						<th>库存工位：</th>
						<td>
							<input name="storeLocation" type="text" class="easyui-validatebox"  style="width: 155px;"/>
						</td>
					</tr>
					<tr>
						<th>公司抬头：</th>
						<td>
							<input name="taxbackName" type="text" class="easyui-validatebox"  style="width: 155px;"/>
						</td>
					</tr>
					<tr>
						<th>税号：</th>
						<td>
							<input name="taxbackCode" type="text" class="easyui-validatebox"  style="width: 155px;"/>
						</td>
					</tr>
					<tr>
					<th>是否有效：</th>
					<td>
						<select name="activeFlag" style="width: 155px;">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
					</td>
					</tr>
			</table>
		</form>
	</div>
	<div id="cdDepartmentEditDialog" style="display: none;width: 520px;height: 420px;" align="center">
		<form id="cdDepartmentEditForm" method="post">
			<table class="tableForm" style="width: 500px">
				<tr>
				<th>组织部门编码：</th>
					<td>
						<input name="rowId" type="hidden" />
						<input name="createdBy" type="hidden"/>
						<input name="created" type="hidden"/>
						<input name="deptParentCode" id="ParentCode_edit" type="hidden" />
						<input name="deptCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写组织部门编码"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>组织类型：</th>
					<td>
						<select name="deptType" style="width: 160px;">
							<option value="0">工厂</option>
							<option value="1">经营体</option>
						</select>
				</tr>
				<tr>
				<th>组织中文名：</th>
					<td>
						<input name="deptNameCn" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写组织中文名"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>组织英文名：</th>
					<td>
						<input name="deptNameEn" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写组织英文名"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>组织负责人编码：</th>
					<td>
						<input name="deptOwner" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写组织负责人编码"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>工厂经营主体：</th>
					<td>
						<input name="operators" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写工厂经营主体"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
				<th>经营主体编码：</th>
					<td>
						<input name="operatorsCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写经营主体编码"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
					<th>商检批次号：</th>
					<td>
						<input name="checkCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写商检批次号"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
					<th>HGVS工厂编码：</th>
					<td>
						<input name="hgvsCode" type="text" class="easyui-validatebox"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
					<th>对应WMS服务器：</th>
					<td>
						<input name="wmsServer" class="easyui-combobox"
						 				data-options="valueField:'dbId',textField:'deptName',url:'${dynamicURL}/datatrans/dbLinkAction!combox.do?dbUseType=1'" />
					</td>
				</tr>
				<tr>
					<th>库存工位：</th>
					<td>
						<input name="storeLocation" type="text" class="easyui-validatebox"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
					<th>公司抬头：</th>
					<td>
						<input name="taxbackName" type="text" class="easyui-validatebox"  style="width: 155px;"/>
					</td>
				</tr>
				<tr>
					<th>税号：</th>
					<td>
						<input name="taxbackCode" type="text" class="easyui-validatebox"  style="width: 155px;"/>
					</td>
					</tr>
				<tr>
					<th>是否有效：</th>
					<td>
						<select name="activeFlag" style="width: 155px;">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body> 
</html>