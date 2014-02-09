<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var cdBudgetAddDialog;
	var cdBudgetAddForm;
	var cdescAdd;
	var cdBudgetEditDialog;
	var cdBudgetEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		
		 $('#employeeid').combobox({   
			url:'budgetAction!combox0.do',   
			valueField:'EMPCODE',   
			textField:'NAME'  
			}); 
		 $('#employeeid2').combobox({   
			url:'budgetAction!combox0.do',   
			valueField:'EMPCODE',   
			textField:'NAME'  
			}); 
		 $('#employeeid1').combobox({   
			url:'budgetAction!combox0.do',   
			valueField:'EMPCODE',   
			textField:'NAME'  
			}); 

	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'budgetAction!datagrid0.do',
			
			title : '样机预算体基本信息列表',
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
			//idField : 'id',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.sapCode;
						}
					},
			   {field:'sapCode',title:'产品经理sap编码',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.sapCode;
					}
				},				
			   {field:'budgetName',title:'预算体名称',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.budgetName;
					}
				},				
			   {field:'budgetCode',title:'预算体编码',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.budgetCode;
					}
				},				
			   {field:'employeeName',title:'产品经理',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.employeeName;
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

		cdBudgetAddForm = $('#cdBudgetAddForm').form({
			url : 'budgetAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				/* var json1 = $.parseJSON({"msg":"门哥你终于成功了！！"});
				console.info(json1); */
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					cdBudgetAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
			}
		});

		cdBudgetAddDialog = $('#cdBudgetAddDialog').show().dialog({
			title : '添加CD_BUDGET',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					cdBudgetAddForm.submit();
				}
			},
			             {
				text: '取消',
				handler:function(){
					cdBudgetAddDialog.dialog('close');
				}
			             }]
		});
		
		
		

		cdBudgetEditForm = $('#cdBudgetEditForm').form({
			url : 'budgetAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					cdBudgetEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
			}
		});

		cdBudgetEditDialog = $('#cdBudgetEditDialog').show().dialog({
			title : '编辑CD_BUDGET',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					cdBudgetEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'CD_BUDGET描述',
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
		//从新加载datagrid并将form序列化作为参数替换queryParams传给后台
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function add() {
		//将新增窗口的form中的input和textarea标签中的数据清空。
		cdBudgetAddForm.find('input,textarea').val('');
		$('div.validatebox-tip').remove();
		//打开新增模态窗口
		cdBudgetAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var sapCodes = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							sapCodes=sapCodes+"sapCodes="+rows[i].sapCode+"&";
						else sapCodes=sapCodes+"sapCodes="+rows[i].sapCode;
					}
					$.ajax({
						url : 'budgetAction!delete.do',
						data : sapCodes,
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
				url : 'budgetAction!showDesc.do',
				data : {
					sapCode : rows[0].sapCode
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					cdBudgetEditForm.find('input,textarea').val('');
					cdBudgetEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					cdBudgetEditDialog.dialog('open');
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
			url : 'budgetAction!showDesc.do',
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
					$.messager.alert('提示', '没有CD_BUDGET描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
</script>
</head>
<body class="easyui-layout">
	<div class="zoc" region="north" border="false" collapsible="true"
					title="样机预算体信息" collapsed="false" style="height: 90px; overflow: hidden;">
		<form id="searchForm">
		<div class="oneline">
		    <div class="item25">
					<div class="itemleft80">sap编码:</div>
					<div class="righttext_easyui">
						<input name="cdBudgetQuery.sapCode" type="text" class="short50"/>
					</div>
				</div>
		    <div class="item25">
					<div class="itemleft80">预算体编码:</div>
					<div class="righttext_easyui">
						<input name="cdBudgetQuery.budgetCode" type="text" class="short50"/>
					</div>
				</div>
		    <div class="item25">
					<div class="itemleft80">预算体名称:</div>
					<div class="righttext_easyui">
						<input name="cdBudgetQuery.budgetName" type="text" class="short50"/>
					</div>
			</div>
		    <div class="item25">
					<div class="itemleft80">产品经理名称:</div>
					<div class="righttext_easyui">
						<input name="cdBudgetQuery.employeeName" id="employeeid" type="text" class="short50"/>
					</div>
			</div>
			<div class="item25">
					<div class="oprationbutt">
						<input type="button" onclick="_search();" value="查询" /> 
						<input	type="button" onclick="cleanSearch();" value="重置" />
					</div>
			</div>
		</div>		
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

	<div id="cdBudgetAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="cdBudgetAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>产品经理sap编码</th>
							<td>
							<input name="sapCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写产品经理sap编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>预算体名称</th>
							<td>
							<input name="budgetName" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写预算体名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>预算体编码</th>
							<td>
							<input name="budgetCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写预算体编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>产品经理</th>
							<td>
							<input name="employeeName" type="text" id="employeeid1"  style="width: 155px;"/>
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="cdBudgetEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="cdBudgetEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>产品经理sap编码</th>
							<td>
							<input name="sapCode" readonly="readonly" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写产品经理sap编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>预算体名称</th>
							<td>
<input name="budgetName" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写预算体名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>预算体编码</th>
							<td>
<input name="budgetCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写预算体编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>产品经理</th>
							<td>
<input name="employeeName" type="text" id="employeeid2" style="width: 155px;"/>
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