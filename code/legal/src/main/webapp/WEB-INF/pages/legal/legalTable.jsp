<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var legalCaseAddDialog;
	var legalCaseAddForm;
	var cdescAdd;
	var legalCaseEditDialog;
	var legalCaseEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'legalCaseAction!applicantDatagrid.do',
			title : '案件申请列表',
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
			//idField : 'id',
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.applicantId;
						}
					},
			   {field:'applicantId',title:'申请人信息编号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.applicantId;
					}
				},				
			   {field:'applicantName',title:'申请人姓名',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.applicantName;
					}
				},				
			   {field:'createTime',title:'创建时间',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.createTime);
					}
				},				
			   {field:'identifyid',title:'申请人身份证号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.identifyid;
					}
				},				
			   {field:'phone',title:'申请人电话号码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.phone;
					}
				},				
			   {field:'agentName',title:'代理人姓名',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.agentName;
					}
				},				
			   {field:'agentId',title:'代理人信息id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.agentId;
					}
				},				
			   {field:'caseId',title:'申诉案情id',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.caseId;
					}
				},				
			   {field:'instId',title:'是否提交',align:'center',sortable:true,
					formatter:function(value,row,index){
						if(row.instId==null||row.instId==''){
							return '否';
						}else{
							return '是';
						}
					}
				}				
			 ] ],
			toolbar : [ {
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					addtemp();
				}
			}/* , '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					del();
				}
			} */, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edittemp();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ],
			onDblClickRow : function(rowIndex, rowData) {
				showdetail(rowData);
			}
		});

		legalCaseAddForm = $('#legalCaseAddForm').form({
			url : 'legalCaseAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					legalCaseAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		legalCaseAddDialog = $('#legalCaseAddDialog').show().dialog({
			title : '添加LegalCase',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					legalCaseAddForm.submit();
				}
			} ]
		});
		
		
		

		legalCaseEditForm = $('#legalCaseEditForm').form({
			url : 'legalCaseAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					legalCaseEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		legalCaseEditDialog = $('#legalCaseEditDialog').show().dialog({
			title : '编辑LegalCase',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					legalCaseEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : 'LegalCase描述',
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
    //录入备案上报信息
	function addtemp(){
			var url = "../legal/legalAction!stepOne.do";
			$('#iframe').attr('src', url);
			dialog = $('#iframeDialog').show().dialog({
				title : '详细信息',
				modal : true,
				closed : true,
				minimizable : true,
				maximizable : true
			});
			$("#iframeDialog").dialog("open");
	}
    function showdetail(row){
				var caseId =row.caseId;
				var applicantId =row.applicantId;
				var agentId =row.agentId;
				var url = '../legal/legalAction!stepTwo.do?applicantId='+applicantId;
				if(agentId!=null&&agentId!=''){
					url=url+'&agentId='+agentId;
				}
				if(caseId!=null&&caseId!=''){
					url=url+'&caseId='+caseId;
				}
				//var url = "../legal/legalAction!stepOne.do?applicantId="+applicantId;
				//alert(url);
				$('#iframe').attr('src', url);
				dialog = $('#iframeDialog').show().dialog({
					title : '详细信息',
					modal : true,
					closed : true,
					minimizable : true,
					maximizable : true
				});
				$("#iframeDialog").dialog("open");
    }
	function edittemp(){
		var rows = datagrid.datagrid('getSelections');
		if(rows.length==0){
			$.messager.alert('提示','请选择一条数据修改','warring');
		}else if(rows.length>1){
			$.messager.alert('提示','只能选中一条数据修改','warring');
		}else{
			var instId=rows[0].instId;
			if(instId!=null){
				$.messager.alert('提示','该申请已经提交无法再次修改');
			}else{
				var caseId =rows[0].caseId;
				var applicantId =rows[0].applicantId;
				var agentId =rows[0].agentId;
				var url = '../legal/legalAction!stepOne.do?applicantId='+applicantId;
				if(agentId!=null&&agentId!=''){
					url=url+'&agentId='+agentId;
				}
				if(caseId!=null&&caseId!=''){
					url=url+'&caseId='+caseId;
				}
				//var url = "../legal/legalAction!stepOne.do?applicantId="+applicantId;
				//alert(url);
				$('#iframe').attr('src', url);
				dialog = $('#iframeDialog').show().dialog({
					title : '详细信息',
					modal : true,
					closed : true,
					minimizable : true,
					maximizable : true
				});
				$("#iframeDialog").dialog("open");
			}
		}

	}
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function add() {
		legalCaseAddForm.form("clear");
		$('div.validatebox-tip').remove();
		legalCaseAddDialog.dialog('open');
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
						url : 'legalCaseAction!delete.do',
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
				url : 'legalCaseAction!showDesc.do',
				data : {
					id : rows[0].id
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					legalCaseEditForm.form("clear");
					legalCaseEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					legalCaseEditDialog.dialog('open');
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
			url : 'legalCaseAction!showDesc.do',
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
					$.messager.alert('提示', '没有LegalCase描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	function clasedialog(){
		$("#iframeDialog").dialog("close");
		_search();
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

	<div id="legalCaseAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="legalCaseAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>id</th>
							<td>
								<input name="id" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>applicantId</th>
							<td>
								<input name="applicantId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写applicantId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>agentId</th>
							<td>
								<input name="agentId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写agentId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>description</th>
							<td>
								<input name="description" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写description"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>reasonId</th>
							<td>
								<input name="reasonId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写reasonId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>signiturePath</th>
							<td>
								<input name="signiturePath" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写signiturePath"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>createTime</th>
							<td>
								<input name="createTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写createTime"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>createBy</th>
							<td>
								<input name="createBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写createBy"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>caseFrom</th>
							<td>
								<input name="caseFrom" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写caseFrom"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>applyDate</th>
							<td>
								<input name="applyDate" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写applyDate"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>applyTypeId</th>
							<td>
								<input name="applyTypeId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写applyTypeId"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>applyTypeProcess</th>
							<td>
								<input name="applyTypeProcess" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写applyTypeProcess"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="legalCaseEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="legalCaseEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>id</th>
							<td>
								<input name="id" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写id"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>applicantId</th>
							<td>
								<input name="applicantId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写applicantId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>agentId</th>
							<td>
								<input name="agentId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写agentId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>description</th>
							<td>
								<input name="description" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写description"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>reasonId</th>
							<td>
								<input name="reasonId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写reasonId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>signiturePath</th>
							<td>
								<input name="signiturePath" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写signiturePath"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>createTime</th>
							<td>
								<input name="createTime" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写createTime"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>createBy</th>
							<td>
								<input name="createBy" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写createBy"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>caseFrom</th>
							<td>
								<input name="caseFrom" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写caseFrom"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>applyDate</th>
							<td>
								<input name="applyDate" type="text" class="easyui-datetimebox" data-options="" missingMessage="请填写applyDate"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>applyTypeId</th>
							<td>
								<input name="applyTypeId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写applyTypeId"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>applyTypeProcess</th>
							<td>
								<input name="applyTypeProcess" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写applyTypeProcess"  style="width: 155px;"/>
							</td>
						</tr>
			</table>
		</form>
	</div>

	<div id="showCdescDialog" style="display: none;overflow: auto;width: 500px;height: 400px;">
		<div name="cdesc"></div>
	</div>
	
	<div id="iframeDialog" style="display: none;overflow: auto;width: 1200px;height: 530px;">
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:99%;height:99%;">
    </iframe>
</div>
</body>
</html>