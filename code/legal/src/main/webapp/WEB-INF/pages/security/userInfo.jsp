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
				text : '保存',
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

	<div id="userInfoAddDialog" style="display: none;width: 600px;height: 160px;">
		<form id="userInfoAddForm" method="post">
		<div style="width: 500px; height: 160px; margin-left: 20px;">
			<div class="part_popover_zoc" style="width: 500px;">
						<div class="oneline">
							<div class="itemleft60">用户编码：</div>
							<div class="righttext">
								<input name="empCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写empCode"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">用户姓名：</div>
							<div class="righttext">
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写name"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">密码：</div>
							<div class="righttext">
								<input name="password" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写password"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">邮箱：</div>
							<div class="righttext">
								<input name="email" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写email"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">类型：</div>
							<div class="righttext" style="width: 160px">
								<select  name="type" >
									<option value="0" selected="selected">普通账号</option>
									<option value="1">域账号</option>
								</select>
							</div>
							<div class="itemleft60">过期时间：</div>
							<div class="righttext">
								<input name="expiredTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写passwordExpireTimeString"  style="width: 155px;"/>						
							</div>
						</div>
			</div>
			</div>
		</form>
	</div>

	<div id="userInfoEditDialog" style="display: none;width: 600px;height: 160px;" align="center">
		<form id="userInfoEditForm" method="post">
		<input type="hidden" name="id"/>
			<div style="width: 500px; height: 160px; margin-left: 20px;">
			<div class="part_popover_zoc" style="width: 500px;">
						<div class="oneline">
							<div class="itemleft60">用户编码：</div>
							<div class="righttext">
								<input name="empCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写empCode"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">用户姓名：</div>
							<div class="righttext">
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写name"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">密码：</div>
							<div class="righttext">
								<input name="password" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写password"  style="width: 155px;"/>						
							</div>
							<div class="itemleft60">邮箱：</div>
							<div class="righttext">
								<input name="email" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写email"  style="width: 155px;"/>						
							</div>
						</div>
						<div class="oneline">
							<div class="itemleft60">类型：</div>
							<div class="righttext" style="width: 160px">
								<select  name="type">
									<option value="0" selected="selected">普通账号</option>
									<option value="1">域账号</option>
								</select>
							</div>
							<div class="itemleft60">过期时间：</div>
							<div class="righttext">
								<input name="passwordExpireTimeString" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写passwordExpireTimeString"  style="width: 155px;"/>						
							</div>
						</div>
			</div>
			</div>
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