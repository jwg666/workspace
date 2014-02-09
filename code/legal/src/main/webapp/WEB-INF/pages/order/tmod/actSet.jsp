<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var actSetAddDialog;
	var actSetAddForm;
	var cdescAdd;
	var actSetEditDialog;
	var actSetEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'actSetAction!datagrid.do',
			queryParams : {
				"activeFlag" : $("#activeFlag").val()
			},
			title : 'T模式活动',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			singleSelect:true,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			//idField : 'rowId',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.rowId;
				}
			}, {
				field : 'actId',
				title : '活动编号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.actId;
				}
			}, {
				field : 'actName',
				title : '活动名称',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.actName;
				}
			}, {
				field : 'actDesc',
				title : '活动描述',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.actDesc;
				}
			}, {
				field : 'activeFlag',
				title : '有效标识',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (value == "1") {
						return '有效';
					} else {
						return '无效';
					}
				}
			}, {
				field : 'parRow',
				title : '父节点',
				align : 'center',
				sortable : true
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

		actSetAddForm = $('#actSetAddForm').form({
			url : 'actSetAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.alert('成功', json.msg, "info", function() {
						$("#actSetAddDialog").dialog('close');
					});
					datagrid.datagrid('reload');
					actSetAddDialog.dialog('close');
				} else {
					$.messager.alert('失败', '操作失败！', 'info', function() {
					});
				}
			}
		});

		actSetAddDialog = $('#actSetAddDialog').show().dialog({
			title : '添加CD_ACT_SET',
			modal : true,
			closed : true,
			maximizable : true,
		});

		actSetEditForm = $('#actSetEditForm').form({
			url : 'actSetAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					actSetEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		actSetEditDialog = $('#actSetEditDialog').show().dialog({
			title : '编辑CD_ACT_SET',
			modal : true,
			closed : true,
			maximizable : true,
		});

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'CD_ACT_SET描述',
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
	function loadParRow() {//加载上级节点下拉框数据
		$("#parRowCombobox").combobox({
			url : 'actSetAction!combox0.action',
			valueField : 'actId',
			textField : 'actName'
		});
	}
	function loadParRow1() {//加载上级节点下拉框数据
		$("#parRowCombobox1").combobox({
			url : 'actSetAction!combox0.action',
			valueField : 'actId',
			textField : 'actName'
		});
	}
	function _search() {
		if ($("#showInvalid").attr('checked') == 'checked') {
			$("#activeFlag").val('');
		} else {
			$("#activeFlag").val('1');
		}
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function add() {
		actSetAddForm.form("clear");
		$('div.validatebox-tip').remove();
		loadParRow();
		$("#parRowCombobox").combobox('select', 0);
		$("#actSetAddForm").form('load', 'actSetAction!maxActId.action');
		actSetAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length == 1) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {

					$.ajax({
						url : 'actSetAction!delete.do',
						data : {
							"rowId" : rows[0].rowId
						},
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
				url : 'actSetAction!showDesc.do',
				data : {
					rowId : rows[0].rowId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					actSetEditForm.form("clear");
					actSetEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					actSetEditDialog.dialog('open');
					loadParRow1();
					$("#parRowCombobox1").combobox('select', response.parRow);
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
			url : 'actSetAction!showDesc.do',
			data : {
				rowId : row.rowId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有CD_ACT_SET描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	function extistActName(editFlag) {//是否是编辑页面
		var actName_ = '';
		if (editFlag) {
			actName_ = $("#actName0").val();
			if (actName_ == $("#actName0Hidden").val()) {
				return;
			}
		} else {
			actName_ = $("#actName").val();
		}
		if (actName_ == '') {
			return;
		} else {
			$.ajax({
				url : 'actSetAction!extistActName.action',
				dataType : 'json',
				data : {
					"actName" : actName_
				},
				success : function(json) {
					if (json.success) {
						$.messager.alert('提示', '活动名已存在，请重新录入', 'error', function() {
							if (editFlag) {
								$("#actName0").focus();
							} else {
								$("#actName").focus();
							}
						});
					}
				}
			});
		}
	}
</script>
</head>
<body class="zoc">
	<div class="navhead_popover_zoc">
		<span>T模式活动管理</span>
	</div>
	<div class="part_zoc">
		<div class="partnavi_zoc">
			<span>基本信息</span>
		</div>
		<form id="searchForm">
			<div class="oneline">
				<div class="item50">
					<div class="itemleft">活动名称：</div>
					<div class="righttext">
						<input name="actName" />
					</div>
				</div>
				<div class="item50">
					<div class="itemleft">活动编号：</div>
					<div class="righttext">
						<input name="actId" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="rightcheckbox">
					<input type="checkbox" id="showInvalid" value="1">显示无效 <input
						id="activeFlag" type="hidden" name="activeFlag" value="1" />
				</div>
			</div>
			<div class="oneline">
				<div class="item100">
					<div>
						<input type="button" value="查询" onclick="_search();" /> <input
							type="button" value="清空"
							onclick='$("#searchForm").form("clear");_search();' />
					</div>
				</div>
			</div>
		</form>
	</div>
	<div style="height: 400px;">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="actSetAddDialog"
		style="display: none; width: 800px; height: 300px;">
		<div class="part_zoc">
			<form id="actSetAddForm" method="post">
				<input type="hidden" name="rowId" value="自动生成" readonly="readonly" />
				<div class="partnavi_zoc">
					<span>增加T模式活动：</span>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">活动编号：</div>
						<div class="righttext">
							<input type="text" name="actId" class="easyui-validatebox"
								required="true" missingMessage="请输入活动名称" />
						</div>
					</div>
					<div class="item33 lastitem">
						<div class="itemleft">活动名称：</div>
						<div class="righttext">
							<input id="actName" type="text" name="actName"
								class="easyui-validatebox" required="true"
								missingMessage="请输入活动名称" onchange="extistActName(false);" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">活动描述：</div>
						<div class="righttext">
							<input type="text" name="actDesc" class="easyui-validatebox"
								required="true" missingMessage="请输入活动描述"></input>
						</div>
					</div>
					<div class="item33 lastitem">
						<div class="itemleft">计算SQL：</div>
						<div class="righttext">
							<input type="text" name="sqlText" class="easyui-validatebox"
								required="true" missingMessage="请输入计算SQL"></input>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">有效状态：</div>
						<span> <input type="checkbox" name="activeFlag" value="1"
							checked="checked" />
						</span>
					</div>
					<div class="item33 lastitem">
						<div class="itemleft">上级节点：</div>
						<div class="righttext">
							<input type="text" id="parRowCombobox" name="parRow"> </input>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33 lastItem">
						<div class="itemleft">序号：</div>
						<div class="righttext">
							<input type="text" name="orderBy" class="easyui-numberbox"
								required="true" missingMessage="请输入活动序号" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item100 lastitem" align="center">
						<div class="oprationbutt">
							<input type="button" value="保存" onclick="actSetAddForm.submit();" />
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div id="actSetEditDialog"
		style="display: none; width: 800px; height: 300px;">
		<form id="actSetEditForm" method="post">
			<div class="part_zoc">
				<input name="rowId" type="hidden" readonly="readonly" />
				<div class="partnavi_zoc">
					<span>修改T模式活动：</span>
				</div>
				<div class="oneline">
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">活动编号：</div>
							<div class="righttext">
								<input id="actId0" name="actId" class="easyui-validatebox"
									required="true" missingMessage="请输入活动编号" />
							</div>
						</div>
						<div class="item33 lastitem">
							<div class="itemleft">活动名称：</div>
							<div class="righttext">
								<input id="actName0" name="actName" class="easyui-validatebox"
									required="true" missingMessage="请输入活动名称"
									onchange="extistActName(true);" /> <input type="hidden"
									id="actName0Hidden">
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">活动描述：</div>
							<div class="righttext">
								<input type="text" id="actDesc0" name="actDesc"
									class="easyui-validatebox" required="true"
									missingMessage="请输入活动描述"></input>
							</div>
						</div>
						<div class="item33 lastitem">
							<div class="itemleft">计算SQL：</div>
							<div class="righttext">
								<input type="text" name="sqlText" class="easyui-validatebox"
									required="true" missingMessage="请输入计算SQL"></input>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft">有效状态：</div>
							<span> <input type="checkbox" name="activeFlag" value="1" />
							</span>
						</div>
						<div class="item33 lastitem">
							<div class="itemleft">上级节点：</div>
							<div class="righttext">
								<input type="text" id="parRowCombobox1" name="parRow"> </input>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33 lastItem">
							<div class="itemleft">序号：</div>
							<div class="righttext">
								<input type="text" name="orderBy" class="easyui-numberbox"
									required="true" missingMessage="请输入活动序号" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item100 lastitem" align="center">
							<div class="oprationbutt">
								<input type="button" value="保存"
									onclick="actSetEditForm.submit();" />
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

	<div id="iframeDialog"
		style="display: none; overflow: auto; width: 600px; height: 400px;">
		<iframe name="iframe" id="iframe" src="#" scrolling="auto"
			frameborder="0" style="width: 100%; height: 100%;"> </iframe>
	</div>
</body>
</html>