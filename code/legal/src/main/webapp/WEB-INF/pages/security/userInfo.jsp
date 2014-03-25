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
			title : '用户列表',
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
				{field:'empCode',title:'用户编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.empCode;
					}
				},
				{field:'name',title:'用户姓名',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.name;
					}
				},	
			   {field:'email',title:'邮件地址',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.email;
					}
				},
				{field:'status',title:'状态',align:'center',sortable:true,
					formatter:function(value,row,index){
						if("0"==row.status){
							return "禁用";
						}else{
							return "启用";
						}
					}
				},				
				{field:'type',title:'类型',align:'center',sortable:true,
					formatter:function(value,row,index){
						if("0"==row.type){
							return "普通账号";
						}else{
							return "域账号";
						}
					}
				},
			   {field:'expiredTime',title:'过期时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.expiredTime);
					}
				},				
			   {field:'gmtCreate',title:'创建时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.gmtCreate);
					}
				},				
			   {field:'gmtModified',title:'最后修改时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.gmtModified);
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
			title : '添加用户',
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
			title : '编辑用户',
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
<body class="easyui-layout zoc">
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 100px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>用户信息维护</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">用户编号：</div>
						<div class="righttext_easyui">
							<input type="text" name="empCode"  />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">用户姓名：</div>
						<div class="righttext">
						<input type="text" name="name"/>
						</div>
					</div>
					<div class="item25">
						<div class="oprationbutt">
							<input type="button" value="查  询" onclick="_search();" />
							<input type="button" value="重  置" onclick="cleanSearch();" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="userInfoAddDialog" style="display: none;width: 500px;height: 300px;">
		<form id="userInfoAddForm" method="post">
		<div style="width: 800px; height: 230px; margin-left: 20px;">
			<table class="tableForm"
					style="margin-top: 20px; margin-left: 27px; width: 550px;">
						<tr>
							<th>用户编码：</th>
							<td>
								<input name="empCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写empCode"  style="width: 155px;"/>						
							</td>
							<th>用户姓名：</th>
							<td>
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写name"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>密码：</th>
							<td>
								<input name="password" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写password"  style="width: 155px;"/>						
							</td>
							<th>邮箱：</th>
							<td>
								<input name="email" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写email"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>类型：</th>
							<td>
								<select name="type">
									<option value="0" selected="selected">普通账号</option>
									<option value="1">域账号</option>
								</select>
							</td>
							<th>过期时间：</th>
							<td>
								<input name="passwordExpireTimeString" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写passwordExpireTimeString"  style="width: 155px;"/>						
							</td>
						</tr>
			</table>
			</div>
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