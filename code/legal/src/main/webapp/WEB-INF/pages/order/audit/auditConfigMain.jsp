<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var auditConfigMainAddDialog;
	var auditConfigMainAddForm;
	var cdescAdd;
	var auditConfigMainEditDialog;
	var auditConfigMainEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	var addDatagrid;
	var editDatagrid;
	$(function() {
		//查询列表	
		queryAddDatagrid();
		queryEditDatagrid();
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'auditConfigMainAction!datagrid.do',
			title : '闸口信息维护',
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
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.auditConfId;
				}
			}, {
				field : 'configDesc',
				title : '配置描述',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.configDesc;
				}
			}, {
				field : 'priorityLevel',
				title : '优先级',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.priorityLevel;
				}
			}, {
				field : 'activeFlag',
				title : '有效标识',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (row.activeFlag == "1") {
						return "有效";
					} else {
						return "无效";
					}
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

		auditConfigMainAddForm = $('#auditConfigMainAddForm').form({
			url : 'auditConfigMainAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					auditConfigMainAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		auditConfigMainAddDialog = $('#auditConfigMainAddDialog').show()
				.dialog({
					title : '添加闸口信息',
					modal : true,
					closed : true,
					maximizable : true
				});

		auditConfigMainEditForm = $('#auditConfigMainEditForm').form({
			url : 'auditConfigMainAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					auditConfigMainEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		auditConfigMainEditDialog = $('#auditConfigMainEditDialog').show()
				.dialog({
					title : '编辑闸口信息',
					modal : true,
					closed : true,
					maximizable : true
				});

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'CD_AUDIT_CONFIG_MAIN描述',
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
	function queryAddDatagrid() {
		addDatagrid = $('#addDatagrid').datagrid({
			url : 'orderAuditSetAction!datagrid.action',
			title : '订单评审闸口配置列表',
			iconCls : 'icon-save',
			fit : true,
			fitColumns : false,
			rownumbers : true,
			nowrap : true,
			border : false,
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.rowId;
				}
			}, {
				field : 'subjectA',
				title : '类别',
				align : 'left',
				sortable : false,
				width : 80,
				formatter : function(value, row, index) {
					return row.subjectA;
				}
			}, {
				field : 'subjectB',
				title : '评审项',
				align : 'left',
				sortable : false,
				width : 80,
				formatter : function(value, row, index) {
					return row.subjectB;
				}
			}, {
				field : 'auditContent',
				title : '评审描述',
				align : 'left',
				sortable : false,
				width : 260,
				formatter : function(value, row, index) {
					return row.auditContent;
				}
			}, {
				field : 'promoteDept',
				title : '推进方式',
				align : 'left',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.promoteDept;
				}
			}, {
				field : 'code',
				title : '方法名',
				align : 'left',
				sortable : false,
				width : 200,
				formatter : function(value, row, index) {
					return row.code;
				}
			} ] ]
		});

	}
	function queryEditDatagrid() {
		editDatagrid = $('#editDatagrid').datagrid({
			url : 'orderAuditSetAction!datagrid.action',
			title : '订单评审闸口配置列表',
			iconCls : 'icon-save',
			fit : true,
			fitColumns : false,
			rownumbers : true,
			nowrap : true,
			border : false,
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.rowId;
				}
			}, {
				field : 'subjectA',
				title : '类别',
				align : 'left',
				sortable : false,
				width : 80,
				formatter : function(value, row, index) {
					return row.subjectA;
				}
			}, {
				field : 'subjectB',
				title : '评审项',
				align : 'left',
				sortable : false,
				width : 80,
				formatter : function(value, row, index) {
					return row.subjectB;
				}
			}, {
				field : 'auditContent',
				title : '评审描述',
				align : 'left',
				sortable : false,
				width : 260,
				formatter : function(value, row, index) {
					return row.auditContent;
				}
			}, {
				field : 'promoteDept',
				title : '推进方式',
				align : 'left',
				sortable : false,
				width : 85,
				formatter : function(value, row, index) {
					return row.promoteDept;
				}
			}, {
				field : 'code',
				title : '方法名',
				align : 'left',
				sortable : false,
				width : 200,
				formatter : function(value, row, index) {
					return row.code;
				}
			} ] ]
		});
	}
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function add() {
		auditConfigMainAddForm.form("clear");
		addDatagrid.datagrid('unselectAll');
		$('div.validatebox-tip').remove();
		auditConfigMainAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							ids = ids + "ids=" + rows[i].auditConfId + "&";
						else
							ids = ids + "ids=" + rows[i].auditConfId;
					}
					$.ajax({
						url : 'auditConfigMainAction!delete.do',
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
		editDatagrid.datagrid('unselectAll');
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url : 'auditConfigMainAction!showDesc.do',
				data : {
					auditConfId : rows[0].auditConfId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					auditConfigMainEditForm.form("clear");
					auditConfigMainEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					auditConfigMainEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
			$.ajax({
				url : 'auditConfigMainAction!queryAuditDatil.do',
				data : {
					auditConfId : rows[0].auditConfId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					var rows = editDatagrid.datagrid('getRows');
					for ( var i = 0; i < rows.length; i++) {
						for ( var j = 0; j < response.length; j++) {
							if (response[j].auditSetId == rows[i].rowId) {
								var index = editDatagrid.datagrid(
										'getRowIndex', rows[i]);
								editDatagrid.datagrid('checkRow', index);
							}
						}
					}
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
			url : 'auditConfigMainAction!showDesc.do',
			data : {
				auditConfId : row.auditConfId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]')
							.html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager
							.alert('提示', '没有CD_AUDIT_CONFIG_MAIN描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	//新增闸口
	function addAudit() {
		//获取被选中的闸口
		var rows = addDatagrid.datagrid('getChecked');
		var ids = "";
		for ( var i = 0; i < rows.length; i++) {
			if (i != rows.length - 1)
				ids = ids + rows[i].rowId + ",";
			else
				ids = ids + rows[i].rowId;
		}
		$("#auditSetIds").val(ids);
		auditConfigMainAddForm.submit();
	}
	//修改闸口
	function editAudit() {
		//获取被选中的闸口
		var rows = editDatagrid.datagrid('getChecked');
		var ids = "";
		for ( var i = 0; i < rows.length; i++) {
			if (i != rows.length - 1)
				ids = ids + rows[i].rowId + ",";
			else
				ids = ids + rows[i].rowId;
		}
		$("#editAuditSetIds").val(ids);
		auditConfigMainEditForm.submit();
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" class="zoc"
		style="height: 100px; overflow: auto;" align="left">
		<form id="searchForm" method="post">
			<s:hidden name="loginName" id="loginName" />
			<div class="navhead_zoc">
				<span>订单评审维护</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>操作：</span>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">配置描述：</div>
						<div class="righttext">
							<input name="configDesc" type="text" class="easyui-validatebox"
								data-options="" missingMessage="请填写配置描述" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">优先级：</div>
						<div class="rightselect">
							<select name="priorityLevel">
								<option value="">全部</option>
								<option value="1">级别1</option>
								<option value="2">级别2</option>
								<option value="3">级别3</option>
							</select>
						</div>
					</div>
					<div class="item33">
						<div class="oprationbutt">
							<input type="button" value="搜索" onclick="_search();;" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>


	<div id="auditConfigMainAddDialog"
		style="display: none; width: 1000px; height: 500px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',split:true,border:false"
				style="height: 100px; overflow: hidden;">
				<form id="auditConfigMainAddForm" method="post">
					<input type="hidden" id="auditSetIds" name="auditSetIds" />
					<div class="part_zoc">
						<div class="oneline">
							<div class="item33">
								<div class="itemleft">配置描述：</div>
								<div class="righttext">
									<input name="configDesc" type="text" class="easyui-validatebox"
										data-options="" missingMessage="请填写配置描述" style="width: 155px;" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft">优先级：</div>
								<div class="rightselect">
									<select name="priorityLevel">
										<option value="1">级别1</option>
										<option value="2">级别2</option>
										<option value="3">级别3</option>
									</select>
								</div>
							</div>
							<div class="item33">
								<div class="itemleft">有效标识：</div>
								<div class="rightselect">
									<select name="activeFlag">
										<option value="1">有效</option>
										<option value="0">无效</option>
									</select>
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item100">
								<div class="itemleft">逻辑SQL：</div>
								<div class="righttext">
									<input name="logicSql" type="text" class="long100" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item100">
								<div class="oprationbutt">
									<input type="button" value="新增" onclick="addAudit();" />
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div region="center" border="false" class="part_zoc">
				<table id="addDatagrid"></table>
			</div>
		</div>
	</div>
	<div id="auditConfigMainEditDialog"
		style="display: none; width: 1000px; height: 500px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',split:true,border:false"
				style="height: 100px; overflow: hidden;">
				<form id="auditConfigMainEditForm" method="post">
					<input type="hidden" name="auditConfId" /> <input type="hidden"
						id="editAuditSetIds" name="auditSetIds" />
					<div class="part_zoc">
						<div class="oneline">
							<div class="item33">
								<div class="itemleft">配置描述：</div>
								<div class="righttext">
									<input name="configDesc" type="text" class="easyui-validatebox"
										data-options="" missingMessage="请填写配置描述" style="width: 155px;" />
								</div>
							</div>
							<div class="item33">
								<div class="itemleft">优先级：</div>
								<div class="rightselect">
									<select name="priorityLevel">
										<option value="1">级别1</option>
										<option value="2">级别2</option>
										<option value="3">级别3</option>
									</select>
								</div>
							</div>
							<div class="item33">
								<div class="itemleft">有效标识：</div>
								<div class="rightselect">
									<select name="activeFlag">
										<option value="1">有效</option>
										<option value="0">无效</option>
									</select>
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item100">
								<div class="itemleft">逻辑SQL：</div>
								<div class="righttext">
									<input name="logicSql" type="text" class="long100" />
								</div>
							</div>
						</div>
						<div class="oneline">
							<div class="item100">
								<div class="oprationbutt">
									<input type="button" value="修改" onclick="editAudit();" />
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div region="center" border="false" class="part_zoc">
				<table id="editDatagrid"></table>
			</div>
		</div>
	</div>

	<div id="showCdescDialog"
		style="display: none; overflow: auto; width: 500px; height: 400px;">
		<div name="cdesc"></div>
	</div>

	<div id="iframeDialog"
		style="display: none; overflow: auto; width: 600px; height: 400px;">
		<iframe name="iframe" id="iframe" src="#" scrolling="auto"
			frameborder="0" style="width: 100%; height: 100%;"> </iframe>
	</div>
</body>
</html>