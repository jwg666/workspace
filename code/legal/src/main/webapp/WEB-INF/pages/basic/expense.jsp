<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var expenseAddDialog;
	var expenseAddForm;
	var cdescAdd;
	var expenseEditDialog;
	var expenseEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'expenseAction!datagrid.do',
			title : '费用科目信息列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'expenseId',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.expenseId;
						}
					},
			   /* {field:'expenseId',title:'唯一标识符',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.expenseId;
					}
				},		 */		
			   {field:'expenseName',title:'费用科目名称',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.expenseName;
					}
				},				
			   {field:'expenseCode',title:'费用科目编码',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.expenseCode;
					}
				},				
			   {field:'expenseContent',title:'BCC费用科目与罗工系统对照',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.expenseContent;
					}
				},				
			   {field:'parentId',title:'上级科目ID',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.parentId;
					}
				},				
			   {field:'activeFlag',title:'有效标识  ',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.activeFlag=='1'){
							return '有效';
						}
						if(row.activeFlag=='0'){
							return '无效';
						}
						return row.activeFlag;
					}
				}/* ,				
			   {field:'createdBy',title:'createdBy',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'created',title:'created',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'lastUpd',title:'lastUpd',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				},				
			   {field:'lastUpdBy',title:'lastUpdBy',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'modificationNum',title:'modificationNum',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.modificationNum;
					}
				},				
			   {field:'ifDamager',title:'ifDamager',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.ifDamager;
					}
				} */				
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
				/* $('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				}); */
			}
		});

 		expenseAddForm = $('#expenseAddForm').form({
			url : 'expenseAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					expenseAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
			}
		});

		expenseAddDialog = $('#expenseAddDialog').show().dialog({
			title : '添加费用科目信息',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					expenseAddForm.submit();
				}
			} ]
		});
		
		
		

		expenseEditForm = $('#expenseEditForm').form({
			url : 'expenseAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					expenseEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
			}
		});

		expenseEditDialog = $('#expenseEditDialog').show().dialog({
			title : '编辑费用科目信息',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					expenseEditForm.submit();
				}
			} ]
		});
 

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '费用科目信息描述',
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
		searchForm.form('clear');
		datagrid.datagrid('load', {});
		//searchForm.find('input').val('');
	}
	 function add() {
		expenseAddForm.find('input,textarea').val('');
		$('div.validatebox-tip').remove();
		expenseAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var expenseIds = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							expenseIds=expenseIds+"expenseIds="+rows[i].expenseId+"&";
						else expenseIds=expenseIds+"expenseIds="+rows[i].expenseId;
					}
					$.ajax({
						url : 'expenseAction!delete.do',
						data : expenseIds,
						dataType : 'json',
						success : function(response) {
							if(response.success){
								datagrid.datagrid('reload');
								datagrid.datagrid('unselectAll');
								$.messager.show({
									title : '提示',
									msg : response.msg
								});
							}else{
								$.messager.show({
									title : '提示',
									msg : response.msg
								});
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
				url : 'expenseAction!showDesc.do',
				data : {
					expenseId : rows[0].expenseId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					expenseEditForm.find('input,textarea').val('');
					expenseEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					expenseEditDialog.dialog('open');
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
			url : 'expenseAction!showDesc.do',
			data : {
				expenseId : row.expenseId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有费用科目信息描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	} 
</script>
</head>
<body class="easyui-layout zoc">
	<div class="zoc" region="north" border="false" collapsed="false"
		style="height: 80px; overflow: hidden;" align="left">
		<form id="searchForm">
		    <div class="partnavi_zoc">
				<span>费用科目查询：</span>
			</div>
			<div class="oneline">
			   <div class="item33">
					<div class="itemleft">费用科目名称 : </div>
					<div class="righttext">
						<input type="text" name="expenseName" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">费用科目编码: </div>
					<div class="righttext">
						<input type="text" name="expenseCode" />
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft">上级科目: </div>
					<div class="righttext">
						<input type="text" name="parentId" />
					</div>
				</div>
			</div>
			<div class="item100 lastitem">
				<div class="oprationbutt">
					<input type="button" onclick="_search();" value="查  询" /> <input
						type="button" onclick="cleanSearch();" value="取消" />
				</div>
			</div>
			<!-- <table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>查询字段需要手工修改</th>
					<td><input name="expenseId" style="width:155px;" /></td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td><input name="ccreatedatetimeStart" class="easyui-datebox" editable="false" style="width: 155px;" />至<input name="ccreatedatetimeEnd" class="easyui-datebox" editable="false" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>最后修改时间</th>
					<td><input name="cmodifydatetimeStart" class="easyui-datebox" editable="false" style="width: 155px;" />至<input name="cmodifydatetimeEnd" class="easyui-datebox" editable="false" style="width: 155px;" /><a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">过滤</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">取消</a></td>
				</tr>
			</table> -->
		</form>
	</div>
	
	<div class="zoc" region="north" border="false" collapsed="false"
		style="height: 0px; overflow: auto;" align="left"></div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="expenseAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="expenseAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>费用科目名称</th>
							<td>
							<input name="expenseName" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写费用科目名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>费用科目编码</th>
							<td>
							<input name="expenseCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写费用科目编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>BCC费用科目与罗工系统对照</th>
							<td>
							<input name="expenseContent" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写BCC费用科目与罗工系统对照"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>上级科目ID</th>
							<td>
							<input name="parentId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写上级科目ID"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>有效标识  1=有效，0=无效</th>
							<td>
							<input name="activeFlag" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写有效标识  1=有效，0=无效"  style="width: 155px;"/>
							</td>
						</tr>
			</table>
		</form>
	</div>

	<div id="expenseEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="expenseEditForm" method="post">
			<table class="tableForm">
						    <s:hidden name="expenseId"></s:hidden>
						<th>费用科目名称</th>
							<td>
                 <input name="expenseName" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写费用科目名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>费用科目编码</th>
							<td>
                 <input name="expenseCode" readonly="readonly" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写费用科目编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>BCC费用科目与罗工系统对照</th>
							<td>
<input name="expenseContent" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写BCC费用科目与罗工系统对照"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>上级科目ID</th>
							<td>
<input name="parentId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写上级科目ID"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>有效标识  1=有效，0=无效</th>
							<td>
<input name="activeFlag" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写有效标识  1=有效，0=无效"  style="width: 155px;"/>
							</td>
						</tr>
            <s:hidden name="modificationNum"></s:hidden>
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