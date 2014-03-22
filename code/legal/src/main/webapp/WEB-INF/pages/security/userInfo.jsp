<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var userInfoAddDialog;
	var userInfoAddForm;
	var cdescAdd;
	var userInfoEditDialog;
	var userInfoEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'userInfoAction!datagrid.do',
			title : 'UserInfo列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			idField : 'id',
			sortName : 'createDt',
			sortOrder : 'desc',
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.id;
						}
					},
			   {field:'id',title:'id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.id;
					}
				},				
			   {field:'createBy',title:'createBy',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createBy;
					}
				},				
			   {field:'currentLoginIp',title:'currentLoginIp',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.currentLoginIp;
					}
				},				
			   {field:'deletedFlag',title:'deletedFlag',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.deletedFlag;
					}
				},				
			   {field:'email',title:'email',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.email;
					}
				},				
			   {field:'empCode',title:'empCode',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.empCode;
					}
				},				
			   {field:'encode',title:'encode',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.encode;
					}
				},				
			   {field:'expiredTime',title:'expiredTime',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.expiredTime);
					}
				},				
			   {field:'gmtCreate',title:'gmtCreate',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.gmtCreate);
					}
				},				
			   {field:'gmtModified',title:'gmtModified',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.gmtModified);
					}
				},				
			   {field:'languageCode',title:'languageCode',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.languageCode;
					}
				},				
			   {field:'languageId',title:'languageId',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.languageId;
					}
				},				
			   {field:'lastLoginIp',title:'lastLoginIp',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastLoginIp;
					}
				},				
			   {field:'lastLoginTime',title:'lastLoginTime',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastLoginTime);
					}
				},				
			   {field:'lastModifiedBy',title:'lastModifiedBy',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastModifiedBy;
					}
				},				
			   {field:'loginAttemptTimes',title:'loginAttemptTimes',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.loginAttemptTimes;
					}
				},				
			   {field:'loginFaildTime',title:'loginFaildTime',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.loginFaildTime);
					}
				},				
			   {field:'memberId',title:'memberId',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.memberId;
					}
				},				
			   {field:'name',title:'name',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.name;
					}
				},				
			   {field:'password',title:'password',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.password;
					}
				},				
			   {field:'passwordExpireTime',title:'passwordExpireTime',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.passwordExpireTime);
					}
				},				
			   {field:'passwordFirstModifiedFlag',title:'passwordFirstModifiedFlag',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.passwordFirstModifiedFlag;
					}
				},				
			   {field:'status',title:'status',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.status;
					}
				},				
			   {field:'timezoneCode',title:'timezoneCode',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.timezoneCode;
					}
				},				
			   {field:'timezoneId',title:'timezoneId',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.timezoneId;
					}
				},				
			   {field:'type',title:'type',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.type;
					}
				},				
			   {field:'usingFlag',title:'usingFlag',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.usingFlag;
					}
				},				
			   {field:'expiredTimeString',title:'expiredTimeString',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.expiredTimeString;
					}
				},				
			   {field:'gmtCreateString',title:'gmtCreateString',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.gmtCreateString;
					}
				},				
			   {field:'gmtModifiedString',title:'gmtModifiedString',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.gmtModifiedString;
					}
				},				
			   {field:'lastLoginTimeString',title:'lastLoginTimeString',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastLoginTimeString;
					}
				},				
			   {field:'loginFaildTimeString',title:'loginFaildTimeString',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.loginFaildTimeString;
					}
				},				
			   {field:'passwordExpireTimeString',title:'passwordExpireTimeString',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.passwordExpireTimeString;
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

		userInfoAddForm = $('#userInfoAddForm').form({
			url : 'userInfoAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					userInfoAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		userInfoAddDialog = $('#userInfoAddDialog').show().dialog({
			title : '添加UserInfo',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					userInfoAddForm.submit();
				}
			} ]
		});
		
		
		

		userInfoEditForm = $('#userInfoEditForm').form({
			url : 'userInfoAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					userInfoEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		userInfoEditDialog = $('#userInfoEditDialog').show().dialog({
			title : '编辑UserInfo',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					userInfoEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'UserInfo描述',
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
		userInfoAddForm.form("clear");
		$('div.validatebox-tip').remove();
		userInfoAddDialog.dialog('open');
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
						url : 'userInfoAction!delete.do',
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
				url : 'userInfoAction!showDesc.do',
				data : {
					id : rows[0].id
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					userInfoEditForm.form("clear");
					userInfoEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					userInfoEditDialog.dialog('open');
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
			url : 'userInfoAction!showDesc.do',
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
					$.messager.alert('提示', '没有UserInfo描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" collapsed="true"  style="height: 110px;overflow: hidden;" align="left">
		<form id="searchForm">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>查询字段需要手工修改</th>
					<td><input name="hotelid" style="width:155px;" /></td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td><input name="ccreatedatetimeStart" class="easyui-datebox" editable="false" style="width: 155px;" />至<input name="ccreatedatetimeEnd" class="easyui-datebox" editable="false" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>最后修改时间</th>
					<td><input name="cmodifydatetimeStart" class="easyui-datebox" editable="false" style="width: 155px;" />至<input name="cmodifydatetimeEnd" class="easyui-datebox" editable="false" style="width: 155px;" /><a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">过滤</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">取消</a></td>
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

	<div id="userInfoAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="userInfoAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>id</th>
							<td>
								<input name="id" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>createBy</th>
							<td>
								<input name="createBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写createBy"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>currentLoginIp</th>
							<td>
								<input name="currentLoginIp" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写currentLoginIp"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>deletedFlag</th>
							<td>
								<input name="deletedFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写deletedFlag"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>email</th>
							<td>
								<input name="email" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写email"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>empCode</th>
							<td>
								<input name="empCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写empCode"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>encode</th>
							<td>
								<input name="encode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写encode"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>expiredTime</th>
							<td>
								<input name="expiredTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写expiredTime"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>gmtCreate</th>
							<td>
								<input name="gmtCreate" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写gmtCreate"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>gmtModified</th>
							<td>
								<input name="gmtModified" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写gmtModified"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>languageCode</th>
							<td>
								<input name="languageCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写languageCode"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>languageId</th>
							<td>
								<input name="languageId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写languageId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>lastLoginIp</th>
							<td>
								<input name="lastLoginIp" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写lastLoginIp"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>lastLoginTime</th>
							<td>
								<input name="lastLoginTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写lastLoginTime"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>lastModifiedBy</th>
							<td>
								<input name="lastModifiedBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写lastModifiedBy"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>loginAttemptTimes</th>
							<td>
								<input name="loginAttemptTimes" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写loginAttemptTimes"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>loginFaildTime</th>
							<td>
								<input name="loginFaildTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写loginFaildTime"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>memberId</th>
							<td>
								<input name="memberId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写memberId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>name</th>
							<td>
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写name"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>password</th>
							<td>
								<input name="password" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写password"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>passwordExpireTime</th>
							<td>
								<input name="passwordExpireTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写passwordExpireTime"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>passwordFirstModifiedFlag</th>
							<td>
								<input name="passwordFirstModifiedFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写passwordFirstModifiedFlag"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>status</th>
							<td>
								<input name="status" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写status"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>timezoneCode</th>
							<td>
								<input name="timezoneCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写timezoneCode"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>timezoneId</th>
							<td>
								<input name="timezoneId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写timezoneId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>type</th>
							<td>
								<input name="type" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写type"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>usingFlag</th>
							<td>
								<input name="usingFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写usingFlag"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>expiredTimeString</th>
							<td>
								<input name="expiredTimeString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写expiredTimeString"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>gmtCreateString</th>
							<td>
								<input name="gmtCreateString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写gmtCreateString"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>gmtModifiedString</th>
							<td>
								<input name="gmtModifiedString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写gmtModifiedString"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>lastLoginTimeString</th>
							<td>
								<input name="lastLoginTimeString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写lastLoginTimeString"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>loginFaildTimeString</th>
							<td>
								<input name="loginFaildTimeString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写loginFaildTimeString"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>passwordExpireTimeString</th>
							<td>
								<input name="passwordExpireTimeString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写passwordExpireTimeString"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="userInfoEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="userInfoEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>id</th>
							<td>
								<input name="id" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>createBy</th>
							<td>
								<input name="createBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写createBy"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>currentLoginIp</th>
							<td>
								<input name="currentLoginIp" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写currentLoginIp"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>deletedFlag</th>
							<td>
								<input name="deletedFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写deletedFlag"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>email</th>
							<td>
								<input name="email" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写email"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>empCode</th>
							<td>
								<input name="empCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写empCode"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>encode</th>
							<td>
								<input name="encode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写encode"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>expiredTime</th>
							<td>
								<input name="expiredTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写expiredTime"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>gmtCreate</th>
							<td>
								<input name="gmtCreate" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写gmtCreate"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>gmtModified</th>
							<td>
								<input name="gmtModified" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写gmtModified"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>languageCode</th>
							<td>
								<input name="languageCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写languageCode"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>languageId</th>
							<td>
								<input name="languageId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写languageId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>lastLoginIp</th>
							<td>
								<input name="lastLoginIp" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写lastLoginIp"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>lastLoginTime</th>
							<td>
								<input name="lastLoginTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写lastLoginTime"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>lastModifiedBy</th>
							<td>
								<input name="lastModifiedBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写lastModifiedBy"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>loginAttemptTimes</th>
							<td>
								<input name="loginAttemptTimes" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写loginAttemptTimes"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>loginFaildTime</th>
							<td>
								<input name="loginFaildTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写loginFaildTime"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>memberId</th>
							<td>
								<input name="memberId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写memberId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>name</th>
							<td>
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写name"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>password</th>
							<td>
								<input name="password" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写password"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>passwordExpireTime</th>
							<td>
								<input name="passwordExpireTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写passwordExpireTime"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>passwordFirstModifiedFlag</th>
							<td>
								<input name="passwordFirstModifiedFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写passwordFirstModifiedFlag"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>status</th>
							<td>
								<input name="status" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写status"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>timezoneCode</th>
							<td>
								<input name="timezoneCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写timezoneCode"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>timezoneId</th>
							<td>
								<input name="timezoneId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写timezoneId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>type</th>
							<td>
								<input name="type" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写type"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>usingFlag</th>
							<td>
								<input name="usingFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写usingFlag"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>expiredTimeString</th>
							<td>
								<input name="expiredTimeString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写expiredTimeString"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>gmtCreateString</th>
							<td>
								<input name="gmtCreateString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写gmtCreateString"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>gmtModifiedString</th>
							<td>
								<input name="gmtModifiedString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写gmtModifiedString"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>lastLoginTimeString</th>
							<td>
								<input name="lastLoginTimeString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写lastLoginTimeString"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>loginFaildTimeString</th>
							<td>
								<input name="loginFaildTimeString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写loginFaildTimeString"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>passwordExpireTimeString</th>
							<td>
								<input name="passwordExpireTimeString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写passwordExpireTimeString"  style="width: 155px;"/>
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