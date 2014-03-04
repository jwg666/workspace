<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var legalApplicantAddDialog;
	var legalApplicantAddForm;
	var cdescAdd;
	var legalApplicantEditDialog;
	var legalApplicantEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'legalApplicantAction!datagrid.do',
			title : 'legalApplicant列表',
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
			sortName : 'id',
			sortOrder : 'desc',
			frozenColumns:[[
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
				{field:'姓名',title:'姓名',align:'center',sortable:true,
				formatter:function(value,row,index){
					return row.name;
				}
				},				
				{field:'性别',title:'性别',align:'center',sortable:true,
				formatter:function(value,row,index){
					if(row.gender=="m"){
						return "男";
					}else {
						return "女";
					}
				}
				},				
				{field:'生日',title:'生日',align:'center',sortable:true,
				formatter:function(value,row,index){
					return dateFormatYMD(row.birthday);
				}
				},				
				{field:'民族',title:'民族',align:'center',sortable:true,
				formatter:function(value,row,index){
					return row.nationId;
				}
				},				
				{field:'证件号码',title:'证件号码',align:'center',sortable:true,
				formatter:function(value,row,index){
					return row.identifyid;
				}
				},				
				{field:'户口所在地',title:'户口所在地',align:'center',sortable:true,
				formatter:function(value,row,index){
					return row.birthPlace;
				}
				},				
				{field:'目前居住地',title:'目前居住地',align:'center',sortable:true,
				formatter:function(value,row,index){
					return row.livePlace;
				}
				},				
				{field:'邮政编码',title:'邮政编码',align:'center',sortable:true,
				formatter:function(value,row,index){
					return row.postCode;
				}
				},				
				{field:'电话号码',title:'电话号码',align:'center',sortable:true,
				formatter:function(value,row,index){
					return row.phone;
				}
				},				
				{field:'工作单位',title:'工作单位',align:'center',sortable:true,
				formatter:function(value,row,index){
					return row.company;
				}
				},				
				{field:'教育水平',title:'教育水平',align:'center',sortable:true,
				formatter:function(value,row,index){
					return row.eduLevelId;
				}
				}
			]],
			columns : [[ 
							
			   {field:'代理人',title:'代理人',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.agentId;
					}
				},				
			   {field:'创建时间',title:'创建时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.createTime);
					}
				},				
			   {field:'申请人人群类别',title:'申请人人群类别',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.categoryId;
					}
				},				
			   {field:'是否经济困难',title:'是否经济困难',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.ifFinancialDifficulty;
					}
				}				
			 ]],
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

		legalApplicantAddForm = $('#legalApplicantAddForm').form({
			url : 'legalApplicantAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					legalApplicantAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		legalApplicantAddDialog = $('#legalApplicantAddDialog').show().dialog({
			title : '添加LegalApplicant',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					legalApplicantAddForm.submit();
				}
			} ]
		});
		
		
		

		legalApplicantEditForm = $('#legalApplicantEditForm').form({
			url : 'legalApplicantAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					legalApplicantEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		legalApplicantEditDialog = $('#legalApplicantEditDialog').show().dialog({
			title : '编辑LegalApplicant',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					legalApplicantEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'LegalApplicant描述',
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
		legalApplicantAddForm.form("clear");
		$('div.validatebox-tip').remove();
		legalApplicantAddDialog.dialog('open');
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
						url : 'legalApplicantAction!delete.do',
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
				url : 'legalApplicantAction!showDesc.do',
				data : {
					id : rows[0].id
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					legalApplicantEditForm.form("clear");
					legalApplicantEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					legalApplicantEditDialog.dialog('open');
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
			url : 'legalApplicantAction!showDesc.do',
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
					$.messager.alert('提示', '没有LegalApplicant描述！', 'error');
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

	<div id="legalApplicantAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="legalApplicantAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>id</th>
							<td>
								<input name="id" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>姓名</th>
							<td>
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写name"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>性别</th>
							<td>
								<input name="gender" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写gender"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>生日</th>
							<td>
								<input name="birthday" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写birthday"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>民族</th>
							<td>
								<input name="nationId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写nationId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>证件号码</th>
							<td>
								<input name="identifyid" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写identifyid"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>户口所在地</th>
							<td>
								<input name="birthPlace" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写birthPlace"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>目前居住地</th>
							<td>
								<input name="livePlace" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写livePlace"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>邮政编码</th>
							<td>
								<input name="postCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写postCode"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>电话号码</th>
							<td>
								<input name="phone" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写phone"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>工作单位</th>
							<td>
								<input name="company" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写company"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>教育水平</th>
							<td>
								<input name="eduLevelId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写eduLevelId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>代理人</th>
							<td>
								<input name="agentId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写agentId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建时间</th>
							<td>
								<input name="createTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写createTime"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>申请人人群类别</th>
							<td>
								<input name="categoryId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写categoryId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>是否经济困难</th>
							<td>
								<input name="ifFinancialDifficulty" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写ifFinancialDifficulty"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="legalApplicantEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="legalApplicantEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>id</th>
							<td>
								<input name="id" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>姓名</th>
							<td>
								<input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写name"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>性别</th>
							<td>
								<input name="gender" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写gender"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>生日</th>
							<td>
								<input name="birthday" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写birthday"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>民族</th>
							<td>
								<input name="nationId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写nationId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>证件号码</th>
							<td>
								<input name="identifyid" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写identifyid"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>户口所在地</th>
							<td>
								<input name="birthPlace" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写birthPlace"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>目前居住地</th>
							<td>
								<input name="livePlace" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写livePlace"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>邮政编码</th>
							<td>
								<input name="postCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写postCode"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>电话号码</th>
							<td>
								<input name="phone" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写phone"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>工作单位</th>
							<td>
								<input name="company" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写company"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>教育水平</th>
							<td>
								<input name="eduLevelId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写eduLevelId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>代理人</th>
							<td>
								<input name="agentId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写agentId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>创建时间</th>
							<td>
								<input name="createTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写createTime"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>申请人人群类别</th>
							<td>
								<input name="categoryId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写categoryId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>是否经济困难</th>
							<td>
								<input name="ifFinancialDifficulty" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写ifFinancialDifficulty"  style="width: 155px;"/>
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