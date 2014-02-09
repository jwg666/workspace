<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var tmodSetAddDialog;
	var tmodSetAddForm;
	var cdescAdd;
	var tmodSetEditDialog;
	var tmodSetEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'tmodSetAction!datagrid.do',
			queryParams : {
				"activeFlag" : $("#activeFlag").val()
			},
			title : 'T模式配置列表',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			singleSelect : true,
			//idField : 'rowId',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.rowId;
				}
			},

			{
				field : 'tmodId',
				title : 'T模式编号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.tmodId;
				}
			}, {
				field : 'tmodName',
				title : '模式名称',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.tmodName;
				}
			}, {
				field : 'tmodDesc',
				title : '模式描述',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.tmodDesc;
				}
			}, {
				field : 'activeFlag',
				title : '有效标识',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (row.activeFlag == 1) {
						return '有效';
					} else {
						return '无效';
					}
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
				field : 'createdBy',
				title : '创建人',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (row.createdBy == '' || row.createdBy == null) {
						return '无';
					}
					return row.createdBy;
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
				field : 'lastUpdBy',
				title : '修改人',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if (row.lastUpdBy == '' || row.lastUpdBy == null) {
						return '无';
					}
					return row.lastUpdBy;
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

		tmodSetAddForm = $('#tmodSetAddForm').form({
			url : 'tmodSetAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					tmodSetAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		tmodSetAddDialog = $('#tmodSetAddDialog').show().dialog({
			title : '添加T模式配置表',
			modal : true,
			closed : true,
			maximizable : true
		});

		tmodSetEditForm = $('#tmodSetEditForm').form({
			url : 'tmodSetAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					tmodSetEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		tmodSetEditDialog = $('#tmodSetEditDialog').show().dialog({
			title : '编辑T模式配置表',
			modal : true,
			closed : true,
			maximizable : true
		});

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'T模式配置表描述',
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
	var lastIndex;
	function add() {
		tmodSetAddForm.form("clear");
		//tmodSetAddForm.form("load", 'tmodSetAction!maxTmodId.action');
		//T模式名称下拉框
		$("#tmodId").combobox({
			url : '${dynamicURL}/tmod/tmodConfigAction!combox.action?activeFlag=1',
			valueField : 'configId',
			textField : 'tmodName'
		});
		$('div.validatebox-tip').remove();
		$("#actAddDatagrid").datagrid({
			url : 'actSetAction!listAllAct.action',
			title : '业务节点',
			pagination : false,
			rownumbers : true,
			singleSelect : true,
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			
			remoteSort : false,
			singleSelect : true,
			onClickRow : function(i, d) {
				if (i != lastIndex) {
					$("#actAddDatagrid").datagrid('beginEdit', i);
					$("#actAddDatagrid").datagrid('endEdit', lastIndex);
				} else {
					$("#actAddDatagrid").datagrid('beginEdit', i);
				}
				lastIndex = i;
			},
			columns : [ [ {
				field : 'orderBy',
				title : '序号',
				sortable : true,
				sorter : function(a, b) {
					if (parseInt(a) > parseInt(b)) {
						return 1;
					} else {
						return -1;
					}
				}
			}, {
				field : 'actId',
				title : '活动节点编码',
				formatter : function(value, row, index) {
					if (row.actId == null) {
						row.actId = '';
					}
					return row.actId;
				}
			}, {
				field : 'actName',
				title : '活动节点名称'
			}, {
				field : 'autoFlag',
				title : '<a href="#" onclick="selectAllActAdd();return false;">是否执行</a>',
				formatter : function(value, row, index) {
					if (!value == '1') {
						row.autoFlag = '0';
					}
					if (value == "1") {
						return '<input type="checkbox" id="ck'+index+'" checked="checked" />';
					} else {
						return '<input type="checkbox" id="ck'+index+'" />';
					}
				},
				editor : {
					type : 'checkbox',
					options : {
						on : '1',
						off : '0'
					}
				}
			}, {
				field : 'sqlText',
				title : '计算SQL',
				width : 80,
				editor : 'text',
				formatter : function(value, row, index) {
					if (row.sqlText == null) {
						row.sqlText = '';
					}
					return row.sqlText;
				}
			} ] ],
			toolbar : [ {
				text : '还原至修改前',
				handler : function() {
					$("#actAddDatagrid").datagrid('rejectChanges');
				}
			}, '-', {
				text : '结束编辑',
				iconCls : 'icon-remove',
				handler : function() {
					$("#actAddDatagrid").datagrid('endEdit', lastIndex);
				}
			}, '-' ]
		});
		tmodSetAddDialog.dialog('open');
	}
	function edit() {
		var rows = $("#datagrid").datagrid('getSelections');
		if (rows.length != 1) {
			$.messager.alert('消息', '请选择一条T模式记录', 'info', function() {
			});
			return;
		}
		var tmodSetId = rows[0].tmodId;
		tmodSetEditForm.form("clear");
		tmodSetEditForm.form("load", 'tmodSetAction!showDesc.action?tmodId=' + tmodSetId);
		//tmodSetAddForm.form("load", 'tmodSetAction!maxTmodId.action');
		$('div.validatebox-tip').remove();
		$("#actEditDatagrid").datagrid({
			url : 'tmodSetAction!listAllAct.action?tmodId=' + tmodSetId,
			title : '业务节点',
			pagination : false,
			pagePosition : 'bottom',
			rownumbers : true,
			
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			remoteSort : false,
			nowrap : true,
			border : false,
			singleSelect : true,
			onClickRow : function(i, d) {
				if (i != lastIndex) {
					$("#actEditDatagrid").datagrid('beginEdit', i);
					$("#actEditDatagrid").datagrid('endEdit', lastIndex);
				} else {
					$("#actEditDatagrid").datagrid('beginEdit', i);
				}
				lastIndex = i;
			},
			columns : [ [ {
				field : 'orderBy',
				title : '序号',
				sortable : true,
				sorter : function(a, b) {
					if (parseInt(a) > parseInt(b)) {
						return 1;
					} else {
						return -1;
					}
				}
			}, {
				field : 'tmodActId',
				title : '活动节点编码',
				formatter : function(value, row, index) {
					if (row.actId == null) {
						row.actId = '';
					}
					return row.tmodActId;
				}
			}, {
				field : 'actName',
				title : '活动节点名称'
			}, {
				field : 'autoFlag',
				title : '<a href="#" onclick="selectAllActEdit();return false;">是否执行</a>',
				formatter : function(value, row, index) {
					if (!value == '1') {
						row.autoFlag = '0';
					}
					var temp;
					if (value == "1") {
						return '<input type="checkbox" id="ck'+index+'" checked="checked" />'
					} else {
						return '<input type="checkbox" id="ck'+index+'" />'
					}
				},
				editor : {
					type : 'checkbox',
					options : {
						on : '1',
						off : '0'
					}
				}
			}, {
				field : 'sqlText',
				title : '计算SQL',
				width : 80,
				editor : 'text',
				formatter : function(value, row, index) {
					if (row.sqlText == null) {
						row.sqlText = '';
					}
					return row.sqlText;
				}
			} ] ],
			toolbar : [ {
				text : '还原至修改前',
				iconCls : 'icon-add',
				handler : function() {
					$("#actEditDatagrid").datagrid('rejectChanges');
				}
			}, '-', {
				text : '结束编辑',
				iconCls : 'icon-remove',
				handler : function() {
					$("#actEditDatagrid").datagrid('endEdit', lastIndex);
				}
			}, '-' ]
		});
		tmodSetEditDialog.dialog('open');
	}

	//保存T模式
	function save() {
		var ff = $("#tmodSetAddForm").form('validate');
		if (!ff) {
			return;
		}
		$.ajax({
			url : 'tmodSetAction!extistTmod.action',
			dataType : 'json',
			data : {
				"tmodId" : $("#tmodId").combobox('getValue')
			},
			success : function(json) {
				if (json.success) {
					$.messager.alert('提示', 'T模式已存在', 'error', function() {
						$("#tmodId").focus();
					});
				} else {
					$("#actAddDatagrid").datagrid('endEdit', lastIndex);
					var actIds = new Array();
					var sqls = new Array();
					var rows = $("#actAddDatagrid").datagrid('getRows');
					var sf = '{"tmodId":"' + $("#tmodId").combobox('getValue') + '","tmodDesc":"' + $("#tmodDesc").val() + '",';
					sf = sf + '"allAct":[';
					var j = rows.length;
					for ( var i = 0; i < j; i++) {
						if (i < j - 1) {
							sf = sf + '{"actId":"' + rows[i].actId + '","sql":"' + rows[i].sqlText + '","autoFlag":"' + rows[i].autoFlag + '"},';
						} else {
							sf = sf + '{"actId":"' + rows[i].actId + '","sql":"' + rows[i].sqlText + '","autoFlag":"' + rows[i].autoFlag + '"}';
						}
					}
					sf = sf + ']}';
					$.ajax({
						url : 'tmodSetAction!addTmodSet.action',
						data : {
							jsonAct : sf
						},
						dataType : 'json',
						success : function(json) {
							if (json && json.success) {
								$.messager.alert('成功', json.msg, 'info', function() {
									datagrid.datagrid('load');
									tmodSetAddDialog.dialog('close');
								});
							} else {
								$.messager.alert('失败', '操作失败！', 'info', function() {
								});
							}
						}
					});
				}
			}
		});
	}
	//编辑T模式
	function editSave() {
		var ff = $("#tmodSetEditForm").form('validate');
		if (!ff) {
			return;
		}
		var tempFlag_ = true;
		var tmodId_ = $("#tmodId0").val();
		/* if (tmodId_ == $("#tmodId0Hidden").val()) {
			tempFlag_ = false;
		} 
		if (tempFlag_) {
			$.ajax({
				url : 'tmodSetAction!extistTmod.action',
				dataType : 'json',
				data : {
					"tmodName" : tmodId_
				},
				success : function(json) {
					if (json.success) {
						$.messager.alert('提示', 'T模式已存在', 'error', function() {
							$("#tmodId0").focus();
						});
					} else {
						$("#actEditDatagrid").datagrid('endEdit', lastIndex);
						var actIds = new Array();
						var sqls = new Array();
						var rows = $("#actEditDatagrid").datagrid('getRows');
						var sf = '{"tmodId":"' + $("#tmodId0").val() + '","tmodDesc":"' + $("#tmodDesc0").val() + '",';
						sf = sf + '"allAct":[';
						var j = rows.length;
						for ( var i = 0; i < j; i++) {
							if (i < j - 1) {
								sf = sf + '{"actId":"' + rows[i].tmodActId + '","sql":"' + rows[i].sqlText + '","autoFlag":"' + rows[i].autoFlag + '"},';
							} else {
								sf = sf + '{"actId":"' + rows[i].tmodActId + '","sql":"' + rows[i].sqlText + '","autoFlag":"' + rows[i].autoFlag + '"}';
							}
						}
						sf = sf + ']}';
						$.ajax({
							url : 'tmodSetAction!editTmodSet.action',
							data : {
								jsonAct : sf
							},
							dataType : 'json',
							success : function(json) {
								if (json && json.success) {
									$.messager.alert('成功', json.msg, 'info', function() {
										datagrid.datagrid('load');
										tmodSetEditDialog.dialog('close');
									});
								} else {
									$.messager.alert('失败', '操作失败！', 'info', function() {
									});
								}
							}
						});
					}
				}
			});
		}*/
		$("#actEditDatagrid").datagrid('endEdit', lastIndex);
		var actIds = new Array();
		var sqls = new Array();
		var rows = $("#actEditDatagrid").datagrid('getRows');

		var sf = '{"tmodId":"' + $("#tmodId0").val() + '","tmodDesc":"' + $("#tmodDesc0").val() + '",';
		sf = sf + '"allAct":[';
		var j = rows.length;
		for ( var i = 0; i < j; i++) {
			if (i < j - 1) {
				sf = sf + '{"actId":"' + rows[i].tmodActId + '","sql":"' + rows[i].sqlText + '","autoFlag":"' + rows[i].autoFlag + '"},';
			} else {
				sf = sf + '{"actId":"' + rows[i].tmodActId + '","sql":"' + rows[i].sqlText + '","autoFlag":"' + rows[i].autoFlag + '"}';
			}
		}
		sf = sf + ']}';
		$.ajax({
			url : 'tmodSetAction!editTmodSet.action',
			data : {
				jsonAct : sf
			},
			dataType : 'json',
			success : function(json) {
				if (json && json.success) {
					$.messager.alert('成功', json.msg, 'info', function() {
						datagrid.datagrid('load');
						tmodSetEditDialog.dialog('close');
					});
				} else {
					$.messager.alert('失败', '操作失败！', 'info', function() {
					});
				}
			}
		});

	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					$.ajax({
						url : 'tmodSetAction!delete.action',
						data : {
							"tmodId" : rows[0].tmodId
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
			$.messager.alert('提示', '请选择一条要删除的记录！', 'error');
		}
	}
	/* function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url : 'tmodSetAction!showDesc.do',
				data : {
					rowId : rows[0].rowId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					tmodSetEditForm.form("clear");
					tmodSetEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					tmodSetEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	} */
	function showCdesc(index) {
		var rows = datagrid.datagrid('getRows');
		var row = rows[index];
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url : 'tmodSetAction!showDesc.do',
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
					$.messager.alert('提示', '没有T模式配置表描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	function extistTmodName(editFlag) {//是否是编辑页面
		var tmodName_ = '';
		if (editFlag) {
			tmodName_ = $("#tmodName0").val();
			if (tmodName_ == $("#tmodName0Hidden").val()) {
				return false;
			}
		} else {
			tmodName_ = $("#tmodName").val();
		}
		if (tmodName_ == '') {
			return false;
		} else {
			$.ajax({
				url : 'tmodSetAction!extistTmodName.action',
				dataType : 'json',
				data : {
					"tmodName" : tmodName_
				},
				success : function(json) {
					if (json.success) {
						return true;
					} else {
						return false;
					}
				}
			});
		}
	}
	var isAddFlag = true;
	var isEditFlag = true;
	function selectAllActAdd() {
		var dataTable;
		dataTable = $("#actAddDatagrid");
		var rowdata = dataTable.datagrid('getRows');
		var count = rowdata.length;
		for (i = 0; i < count; i++) {
			if (isAddFlag) {
				rowdata[i].autoFlag = '1';
			} else {
				rowdata[i].autoFlag = '0';
			}
		}
		dataTable.datagrid('loadData', rowdata);
		isAddFlag = !isAddFlag;
	}
	function selectAllActEdit() {
		var dataTable;
		dataTable = $("#actEditDatagrid");
		var rowdata = dataTable.datagrid('getRows');
		var count = rowdata.length;
		for (i = 0; i < count; i++) {
			if (isEditFlag) {
				rowdata[i].autoFlag = '1';
			} else {
				rowdata[i].autoFlag = '0';
			}
		}
		dataTable.datagrid('loadData', rowdata);
		isEditFlag = !isEditFlag;
	}
</script>
</head>
<body class="easyui-layout zoc">
	<div region="north" border="false" collapsed="true" title="T模式查询"
		style="height: 80px;">
		<div class="part_zoc">
			<form id="searchForm">
				<div class="oneline">
					<div class="item100">
						<div class="itemleft">T模式名称：</div>
						<div class="righttext">
							<input type="text" name="tmodName" />
						</div>
						<div class="rightcheckbox">
							<input type="checkbox" id="showInvalid" />显示无效 <input
								name="activeFlag" type="hidden" id="activeFlag" value="1">
						</div>
						<div class="righttext">
							<input type="button" value="查询" onclick="_search();" /><input
								type="button" value="清空"
								onclick='$("#searchForm").form("clear");_search();' />
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div region="center">
		<table id="datagrid"></table>
	</div>
	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="tmodSetAddDialog" data-options="resizable:true"
		style="display: none; width: 1000px; height: 550px;">
		<form id="tmodSetAddForm" method="post">
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>基本信息</span>
				</div>
				<div class="oneline">
					<div class="item50">
						<div class="itemleft">模式名称：</div>
						<div class="righttext">

							<input id="tmodId" name="tmodId" style="width: 155px;"
								class="easyui-combobox" required="true" missingMessage="请选择模式名称"></input>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item100">
						<div class="itemleft">模式描述：</div>
						<span><input type="text" id="tmodDesc" name="tmodDesc" /></span>
					</div>
				</div>
				<div class="oneline">
					<div class="item100">
						<input type="button" value="保存" onclick="save()" />
					</div>
				</div>
			</div>
		</form>
		<div style="height: 350px; width: 100%">
			<table id="actAddDatagrid"></table>
		</div>
	</div>

	<div id="tmodSetEditDialog"
		style="display: none; width: 1000px; height: 550px;" align="center">
		<form id="tmodSetEditForm" method="post">
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>基本信息</span>
				</div>
				<div class='oneline'>
					<div class="item50">
						<div class="itemleft">模式名称：</div>
						<div class="righttext">
							<!-- <input type="text" id="tmodName0" name="tmodName"
								class="easyui-validatebox" required="true"
								missingMessage="请输入模式名称" /> -->
							<input id="tmodName0" name="tmodName" style="width: 155px;"
								readonly="readonly"></input>
								<input type="hidden" name="tmodId" id="tmodId0"/>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item100">
						<div class="itemleft">模式描述：</div>
						<span><input type="text" id="tmodDesc0" name="tmodDesc" /></span>
					</div>
				</div>
				<div class="oneline">
					<div class="item100">
						<input type="button" value="保存" onclick="editSave()" />
					</div>
				</div>
			</div>
		</form>
		<div style="height: 350px; width: 100%;">
			<table id="actEditDatagrid"></table>
		</div>
	</div>

	<div id="showCdescDialog"
		style="display: none; overflow: auto; width: 500px; height: 400px;">
		<div name="cdesc"></div>
	</div>

</body>
</html>