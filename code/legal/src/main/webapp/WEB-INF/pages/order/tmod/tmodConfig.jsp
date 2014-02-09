<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var tmodConfigAddDialog;
	var tmodConfigAddForm;
	var cdescAdd;
	var tmodConfigEditDialog;
	var tmodConfigEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'tmodConfigAction!datagrid.do',
			title : 'T模式配置列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			singleSelect : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'configId',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.configId;
				}
			}, {
				field : 'configId',
				title : '唯一标识',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.configId;
				}
			}, {
				field : 'tmodName',
				title : 'T模式名称',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.tmodName;
				}
			}, {
				field : 'tmodDesc',
				title : 'T模式描述',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.tmodDesc;
				}
			}, {
				field : 'tmodSql',
				title : 'T模式判定逻辑',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.tmodSql;
				}
			}, {
				field : 'workflowName',
				title : '流程图名称',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.workflowName;
				}
			}, {
				field : 'createBy',
				title : '创建人Id',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.createBy;
				}
			}, {
				field : 'created',
				title : '创建日期',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.created);
				}
			}, {
				field : 'lastUpdBy',
				title : '修改人Id',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.lastUpdBy;
				}
			}, {
				field : 'lastUpd',
				title : '修改日期',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.lastUpd);
				}
			}, {
				field : 'modificationNum',
				title : '修改次数',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.modificationNum;
				}
			}, {
				field : 'executeDesc',
				title : 'T模式判定逻辑描述',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.executeDesc;
				}
			} ] ],
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

		tmodConfigAddForm = $('#tmodConfigAddForm').form({
			url : 'tmodConfigAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					tmodConfigAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		tmodConfigAddDialog = $('#tmodConfigAddDialog').show().dialog({
			title : '添加T模式配置',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					tmodConfigAddForm.submit();
				}
			} ]
		});

		tmodConfigEditForm = $('#tmodConfigEditForm').form({
			url : 'tmodConfigAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					tmodConfigEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			},
			onLoadSuccess:function(){
				//$("#workflowNameEdit").combobox('setValue',$("#workflowNameEdit").val());
			}
		});

		tmodConfigEditDialog = $('#tmodConfigEditDialog').show().dialog({
			title : '编辑T模式配置',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					$("#tmodConfigEditForm").submit();
				}
			} ]
		});

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'T模式配置描述',
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
		searchForm.form('clear');
	}
	function add() {//
		tmodConfigAddForm.form("clear");
		$('div.validatebox-tip').remove();
		//得到主键id
		tmodConfigAddForm.form('load', '${dynamicURL}/tmod/tmodConfigAction!createConfigId.action');
		$("#workflowName").combobox({
			url : '${dynamicURL}/tmod/tmodConfigAction!getAllWorkFlow',
			valueField : 'KEY_',
			textField : 'NAME_'
		});
		tmodConfigAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							ids = ids + "ids=" + rows[i].configId + "&";
						else
							ids = ids + "ids=" + rows[i].configId;
					}
					$.ajax({
						url : 'tmodConfigAction!delete.do',
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
				url : 'tmodConfigAction!showDesc.do',
				data : {
					configId : rows[0].configId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					tmodConfigEditForm.form("clear");
					tmodConfigEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					$("#workflowNameEdit").combobox({
						url : '${dynamicURL}/tmod/tmodConfigAction!getAllWorkFlow',
						valueField : 'KEY_',
						textField : 'NAME_',
						onLoadSuccess:function(){
							$("#workflowNameEdit").combobox('setValue',response.workflowName);
						}
					});
					tmodConfigEditDialog.dialog('open');
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
			url : 'tmodConfigAction!showDesc.do',
			data : {
				configId : row.configId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有T模式配置描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" collapsed="true"
		style="height: 110px; overflow: hidden;" align="left">
		<form id="searchForm">
			<div class="part_zoc">
				<div class="partnavi_zoc">T模式查询</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">T模式名称</div>
						<div class="righttext">
							<input name="tmodName" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">流程图名称：</div>
						<div class="righttext">
							<input type="text" name="workflowName" />
						</div>
					</div>
					<div class="item33">
						<div class="oprationbutt">
							<input type="button" value="查询" onclick="_search();" /> <input
								type="button" value="清空" onclick="cleanSearch();" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="tmodConfigAddDialog"
		style="display: none; width: 800px; height: 300px; overflow: auto;"
		align="center">
		<form id="tmodConfigAddForm">
			<div class="part_zoc">
				<div class="partnavi_zoc">增加T模式定义</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">唯一编码：</div>
						<div class="righttext">
							<input name="configId" type="text" style="width: 155px;"
								readonly="readonly" />
						</div>
					</div>
					<div class="item33 lastitem">
						<div class="itemleft">T模式名称</div>
						<div class="righttext">
							<input name="tmodName" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写T模式名称"
								style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">T模式描述</div>
						<div class="righttext">
							<input name="tmodDesc" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写T模式描述"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33 lastitem">
						<div class="itemleft">T模式判定逻辑</div>
						<div class="righttext">
							<input name="tmodSql" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写T模式判定逻辑"
								style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">流程图名称</div>
						<div class="righttext">
							<input name="workflowName" id="workflowName" type="text"
								class="easyui-combobox" data-options="required:true"
								missingMessage="请选择流程图" style="width: 155px;" />
						</div>
					</div>
					<div class="item33 lastitem">
						<div class="itemleft">T模式判定逻辑描述</div>
						<div class="righttext">
							<input name="executeDesc" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写T模式判定逻辑描述"
								style="width: 155px;" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div id="tmodConfigEditDialog"
		style="display: none; width: 800px; height: 300px;" align="center">
		<form id="tmodConfigEditForm">
			<div class="part_zoc">
				<div class="partnavi_zoc">T模式定义修改</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">唯一编码：</div>
						<div class="righttext">
							<input name="configId" type="text" style="width: 155px;"
								readonly="readonly" />
						</div>
					</div>
					<div class="item33 lastitem">
						<div class="itemleft">T模式名称</div>
						<div class="righttext">
							<input name="tmodName" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写T模式名称"
								style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">T模式描述</div>
						<div class="righttext">
							<input name="tmodDesc" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写T模式描述"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33 lastitem">
						<div class="itemleft">T模式判定逻辑</div>
						<div class="righttext">
							<input name="tmodSql" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写T模式判定逻辑"
								style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">流程图名称</div>
						<div class="righttext">
							<select name="workflowName" id="workflowNameEdit" type="text"
								data-options="required:true" missingMessage="请选择流程图"
								style="width: 155px;"></select>
						</div>
					</div>
					<div class="item33 lastitem">
						<div class="itemleft">T模式判定逻辑描述</div>
						<div class="righttext">
							<input name="executeDesc" type="text" class="easyui-validatebox"
								data-options="required:true" missingMessage="请填写T模式判定逻辑描述"
								style="width: 155px;" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div id="showCdescDialog"
		style="display: none; overflow: auto; width: 500px; height: 400px;">
		<div name="cdesc"></div>
	</div>

</body>
</html>