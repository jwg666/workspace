<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var prodTypeAddDialog;
	var prodTypeAddForm;
	var cdescAdd;
	var prodTypeEditDialog;
	var prodTypeEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'prodTypeAction!datagrid.do',
			title : '产品组信息列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10, 15, 20 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'id',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.id;
						}
					},
			   {field:'productTypeId',title:'产品组唯一标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.productTypeId;
					}
				},				
			   {field:'prodTypeCode',title:'编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prodTypeCode;
					}
				},				
			   {field:'classifyCode',title:'classifyCode',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.classifyCode;
					}
				},				
			   {field:'prodType',title:'类型',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prodType;
					}
				},				
			   {field:'activeFlag',title:'有效标志',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.activeFlag;
					}
				},				
			   {field:'name',title:'名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.name;
					}
				},				
			   {field:'alias',title:'别名',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.alias;
					}
				},				
			   {field:'prodCont',title:'prodCont',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prodCont;
					}
				},				
			   {field:'comments',title:'描述',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.comments;
					}
				},				
			   {field:'temp1Char',title:'temp1Char',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.temp1Char;
					}
				},				
			   {field:'temp2Char',title:'temp2Char',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.temp2Char;
					}
				},				
			   {field:'temp3Char',title:'temp3Char',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.temp3Char;
					}
				},				
			   {field:'checkBacthNum',title:'checkBacthNum',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.checkBacthNum;
					}
				},				
			   {field:'cpcPerson',title:'cpcPerson',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.cpcPerson;
					}
				},				
			   {field:'auditer',title:'审批人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.auditer;
					}
				},				
			   {field:'auditFlagId',title:'‘0’',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.auditFlagId;
					}
				},				
			   {field:'createdBy',title:'创建人Id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'created',title:'创建日期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'lastUpd',title:'修改日期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				},				
			   {field:'lastUpdBy',title:'修改人Id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'modificationNum',title:'修改次数',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.modificationNum;
					}
				},				
			   {field:'ifDamager',title:'ifDamager',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.ifDamager;
					}
				},				
			   {field:'sapCode',title:'SAP编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.sapCode;
					}
				}				
			 ] ],
			/* toolbar : [ {
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
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ], */
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

		prodTypeAddForm = $('#prodTypeAddForm').form({
			url : 'prodTypeAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					prodTypeAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		prodTypeAddDialog = $('#prodTypeAddDialog').show().dialog({
			title : '添加CD_PROD_TYPE',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					prodTypeAddForm.submit();
				}
			} ]
		});
		
		
		

		prodTypeEditForm = $('#prodTypeEditForm').form({
			url : 'prodTypeAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					prodTypeEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		prodTypeEditDialog = $('#prodTypeEditDialog').show().dialog({
			title : '编辑CD_PROD_TYPE',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					prodTypeEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'CD_PROD_TYPE描述',
			modal : true,
			closed : true,
			maximizable : true
		});

		iframeDialog = $('#iframeDialog').show().dialog({
			title : 'POP弹出页面',
			modal : true,
			closed : true,
			maximizable : true
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
		prodTypeAddForm.find('input,textarea').val('');
		$('div.validatebox-tip').remove();
		prodTypeAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].productTypeId+"&";
						else ids=ids+"ids="+rows[i].productTypeId;
					}
					$.ajax({
						url : 'prodTypeAction!delete.do',
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
				url : 'prodTypeAction!showDesc.do',
				data : {
					id : rows[0].id
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					prodTypeEditForm.find('input,textarea').val('');
					prodTypeEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					prodTypeEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
	function showCdesc(index) {
		var rows = datagrid.datagrid('getRows');
		var row = rows[index];
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url : 'prodTypeAction!showDesc.do',
			data : {
				id : row.id
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有CD_PROD_TYPE描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" collapsed="false"  style="height: 150px;overflow: hidden;" align="left">
		<form id="searchForm">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>产品组名称</th>
					<td><input name="prodTypeQuery.name" style="width:155px;" /></td>
					<th>产品组别名</th>
					<td><input name="prodTypeQuery.alias" style="width:155px;" /></td>
				</tr>
				<tr>
					<th>审批人</th>
					<td><input name="prodTypeQuery.auditer" style="width:155px;" /></td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td><input name="prodTypeQuery.fromCreated" class="easyui-datebox" editable="false" style="width: 155px;" />至
					<input name="prodTypeQuery.toCreated" class="easyui-datebox" editable="false" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>最后修改时间</th>
					<td><input name="prodTypeQuery.fromLastUpd" class="easyui-datebox" editable="false" style="width: 155px;" />至
					<input name="prodTypeQuery.toLastUpd" class="easyui-datebox" editable="false" style="width: 155px;" />
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">过滤</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">取消</a></td>
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

	<div id="prodTypeAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="prodTypeAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>产品组唯一标识</th>
							<td>
							<input name="productTypeId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写产品组唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>编码</th>
							<td>
							<input name="prodTypeCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>classifyCode</th>
							<td>
							<input name="classifyCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写classifyCode"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>类型</th>
							<td>
							<input name="prodType" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写类型"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>有效标志</th>
							<td>
							<input name="activeFlag" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写有效标志"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>名称</th>
							<td>
							<input name="name" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>别名</th>
							<td>
							<input name="alias" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写别名"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>prodCont</th>
							<td>
							<input name="prodCont" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写prodCont"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>描述</th>
							<td>
							<input name="comments" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写描述"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>temp1Char</th>
							<td>
							<input name="temp1Char" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写temp1Char"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>temp2Char</th>
							<td>
							<input name="temp2Char" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写temp2Char"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>temp3Char</th>
							<td>
							<input name="temp3Char" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写temp3Char"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>checkBacthNum</th>
							<td>
							<input name="checkBacthNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写checkBacthNum"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>cpcPerson</th>
							<td>
							<input name="cpcPerson" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写cpcPerson"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>审批人</th>
							<td>
							<input name="auditer" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写审批人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>‘0’</th>
							<td>
							<input name="auditFlagId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写‘0’"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>创建人Id</th>
							<td>
							<input name="createdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写创建人Id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>创建日期</th>
							<td>
							<input name="created" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写创建日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>修改日期</th>
							<td>
							<input name="lastUpd" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写修改日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>修改人Id</th>
							<td>
							<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写修改人Id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>修改次数</th>
							<td>
							<input name="modificationNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写修改次数"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>ifDamager</th>
							<td>
							<input name="ifDamager" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写ifDamager"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>SAP编码</th>
							<td>
							<input name="sapCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写SAP编码"  style="width: 155px;"/>
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="prodTypeEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="prodTypeEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>产品组唯一标识</th>
							<td>
							<input name="productTypeId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写产品组唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>编码</th>
							<td>
<input name="prodTypeCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>classifyCode</th>
							<td>
<input name="classifyCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写classifyCode"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>类型</th>
							<td>
<input name="prodType" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写类型"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>有效标志</th>
							<td>
<input name="activeFlag" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写有效标志"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>名称</th>
							<td>
<input name="name" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>别名</th>
							<td>
<input name="alias" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写别名"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>prodCont</th>
							<td>
<input name="prodCont" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写prodCont"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>描述</th>
							<td>
<input name="comments" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写描述"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>temp1Char</th>
							<td>
<input name="temp1Char" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写temp1Char"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>temp2Char</th>
							<td>
<input name="temp2Char" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写temp2Char"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>temp3Char</th>
							<td>
<input name="temp3Char" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写temp3Char"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>checkBacthNum</th>
							<td>
<input name="checkBacthNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写checkBacthNum"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>cpcPerson</th>
							<td>
<input name="cpcPerson" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写cpcPerson"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>审批人</th>
							<td>
<input name="auditer" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写审批人"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>‘0’</th>
							<td>
<input name="auditFlagId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写‘0’"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建人Id</th>
							<td>
<input name="createdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写创建人Id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建日期</th>
							<td>
<input name="created" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写创建日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改日期</th>
							<td>
<input name="lastUpd" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写修改日期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改人Id</th>
							<td>
<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写修改人Id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>修改次数</th>
							<td>
<input name="modificationNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写修改次数"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>ifDamager</th>
							<td>
<input name="ifDamager" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写ifDamager"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>SAP编码</th>
							<td>
<input name="sapCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写SAP编码"  style="width: 155px;"/>
							</td>
						</tr>
			</table>
		</form>
	</div>

	<div id="showCdescDialog" style="display: none;overflow: auto;width: 500px;height: 400px;">
		<div name="cdesc"></div>
	</div>
	
	<div id="iframeDialog" style="display: none;overflow: auto;width: 600px;height: 400px;">
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:100%;">
    </iframe>
</div>
</body>
</html>