<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var grantorAddDialog;
	var grantorAddForm;
	var cdescAdd;
	var grantorEditDialog;
	var grantorEditForm;
	var cdescEdit;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'grantorAction!datagrid.do',
			title : '我的权限托管记录列表',
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
			idField : 'id',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.id;
						}
					},
			   {field:'id',title:'唯一标识',align:'center',sortable:true,hidden:true,width:80,
					formatter:function(value,row,index){
						return row.id;
					}
				},				
			   {field:'grantorName',title:'授权人',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.grantorName;
					}
				},				
			   {field:'trusteeName',title:'托管人',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.trusteeName;
					}
				},				
			   {field:'startTime',title:'托管开始',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return dateFormatYMD(row.startTime);
					}
				},				
			   {field:'expiredTime',title:'托管结束',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return dateFormatYMD(row.expiredTime);
					}
				},				
			   {field:'state',title:'状态',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						if(row.state=="1"){
							return "有效";
						}else{
							return "无效";
						}
					}
				},				
			   {field:'created',title:'创建时间',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'createdBy',title:'创建人',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'lastUpdBy',title:'修改人',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'lastUpd',title:'修改时间',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
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
		//用户1
		$('#User_CODE').combogrid({
			url : 'grantorAction!searchUser.do',
			textField : 'name',
			idField : 'empCode',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_User',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ 
			    {field:'empCode',title:'员工号',align:'center',sortable:true,width:100,},
			    {field:'name',title:'用户名',align:'left',sortable:true,width:100,}
			] ]
		});
		//用户2
		$('#User_CODEB').combogrid({
			url : 'grantorAction!searchUser.do',
			textField : 'name',
			idField : 'empCode',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_UserB',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ 
				    {field:'empCode',title:'员工号',align:'center',sortable:true,width:100,},
				    {field:'name',title:'用户名',align:'left',sortable:true,width:100,}
			] ]
		});
		//用户添加
		$('#User_CODEADD').combogrid({
			url : 'grantorAction!searchUser.do',
			textField : 'name',
			idField : 'empCode',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_UserADD',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ 
					{field:'empCode',title:'员工号',align:'center',sortable:true,width:100,},
					{field:'name',title:'用户名',align:'left',sortable:true,width:100,}
	          ] ]
		});
		//用户编辑
		$('#User_CODEEDIT').combogrid({
			url : 'grantorAction!searchUser.do',
			textField : 'name',
			idField : 'empCode',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_UserEDIT',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ 
				    {field:'empCode',title:'员工号',align:'center',sortable:true,width:100,},
				    {field:'name',title:'用户名',align:'left',sortable:true,width:100,}
			] ]
		});
		//被托管列表
			grantsearchForm = $('#grantsearchForm').form();
			grantdatagrid = $('#grantdatagrid').datagrid({
			url : 'grantorAction!grantdatagrid.do',
			title : '我被托管记录列表',
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
			idField : 'id',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.id;
						}
					},
			   {field:'id',title:'唯一标识',align:'center',sortable:true,hidden:true,
					formatter:function(value,row,index){
						return row.id;
					}
				},				
			   {field:'grantorName',title:'授权人',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.grantorName;
					}
				},				
			   {field:'trusteeName',title:'托管人',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.trusteeName;
					}
				},				
			   {field:'startTime',title:'托管开始',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return dateFormatYMD(row.startTime);
					}
				},				
			   {field:'expiredTime',title:'托管结束',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return dateFormatYMD(row.expiredTime);
					}
				},				
			   {field:'state',title:'状态',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						if(row.state=="1"){
							return "有效";
						}else{
							return "无效";
						}
					}
				},				
			   {field:'created',title:'创建时间',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'createdBy',title:'创建人',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'lastUpdBy',title:'修改人',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'lastUpd',title:'修改时间',align:'center',sortable:true,width:80,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				}				
			 ] ],
			
		});
		grantorAddForm = $('#grantorAddForm').form({
			url : 'grantorAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					grantorAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg :  json.msg
					});
				}
			}
		});

		grantorAddDialog = $('#grantorAddDialog').show().dialog({
			title : '添加托管记录',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					grantorAddForm.submit();
				}
			} ]
		});
		
		grantorEditForm = $('#grantorEditForm').form({
			url : 'grantorAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					grantorEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '编辑失败！'
					});
				}
			}
		});

		grantorEditDialog = $('#grantorEditDialog').show().dialog({
			title : '编辑托管记录',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					grantorEditForm.submit();
				}
			} ]
		});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	
	function historySearch(){
		grantdatagrid.datagrid('load', sy.serializeObject(grantsearchForm));
	}
	function historyClean(){
		grantsearchForm.form('clear');
		grantdatagrid.datagrid('load', sy.serializeObject(grantsearchForm));
	}
	function hiddenHistorySearch(){
		$("#HistorySearch").layout("collapse","north");
	}
	function add() {
		grantorAddForm.form("clear");
		$('div.validatebox-tip').remove();
		grantorAddDialog.dialog('open');
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
						url : 'grantorAction!delete.do',
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
				url : 'grantorAction!showDesc.do',
				data : {
					id : rows[0].id
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					grantorEditForm.form("clear");
					grantorEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					grantorEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/grantorAction!searchUser.action?user.name=' + _CCNTEMP
		});
		$('#' + inputId).val(_CCNTEMP);
	}
</script>
</head>
<body>
	<div id="tabs_id" class="easyui-tabs" data-options="fit:true">
		<div title="我委托的">
			<!--展开之后的content-part所显示的内容-->
			<div id="checkSearch" class="easyui-layout" fit="true">
				<div region="north" class="zoc" border="false" title="查询" collapsed="true"  style="height: 60px;overflow: hidden;" align="left">
					<form id="searchForm">
			            <div class="oneline">
			                <div class="item25">
			                    <div class="itemleft60">托管人：</div>
			                    <div class="righttext">
			   						<input type="text" class="easyui-combobox short100" id="User_CODE" name="trusteeCode"></input>
			                    	 <!-- <input type="text" name="trusteeCode"> -->
			                    </div>
			                </div>
			                <div class="item25">
			                    <div class="itemleft60">托管开始时间：</div>
			                    <div class="righttext">
									<input name="startTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写托管开始"  style="width: 155px;"/>
			                    </div>
			                </div>
			                 <div class="item25">
			                    <div class="itemleft60">托管结束时间：</div>
			                    <div class="righttext">
									<input name="expiredTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写托管结束"  style="width: 155px;"/>
			                    </div>
			                </div>
			                <div class="item25 lastitem">
			                    <div class="oprationbutt">
			                        <input type="button" onclick="_search()" value="过滤" />
			                        <input type="button" onclick="cleanSearch()" value="取消" />
			                    </div>
			                </div>
			             </div>
			        </form>
				</div>
				<div region="center" border="false">
					<table id="datagrid" ></table>
				</div>
			</div>
		</div>
		<div title="我被委托的">
			<!--展开之后的content-part所显示的内容-->
			<div id="HistorySearch" class="easyui-layout" fit="true">
				<div region="north" class="zoc" border="false" title="查询" collapsed="true"  style="height: 60px;overflow: hidden;" align="left">
					<form id="grantsearchForm">
			            <div class="oneline">
			                <div class="item25">
			                    <div class="itemleft60">授权人：</div>
			                    <div class="righttext">
  			   						 <input type="text" class="easyui-combobox short100" id="User_CODEB" name="grantorCode"></input>
			                    </div>
			                </div>
			                <div class="item25">
			                    <div class="itemleft60">托管开始时间：</div>
			                    <div class="righttext">
									<input name="startTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写托管开始"  style="width: 155px;"/>
			                    </div>
			                </div>
			                 <div class="item25">
			                    <div class="itemleft60">托管结束时间：</div>
			                    <div class="righttext">
									<input name="expiredTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写托管结束"  style="width: 155px;"/>
			                    </div>
			                </div>
			                <div class="item25 lastitem">
			                    <div class="oprationbutt">
			                        <input type="button" onclick="historySearch()" value="过滤" />
			                        <input type="button" onclick="historyClean()" value="取消" />
			                        <input type="button" onclick="hiddenHistorySearch()" value="隐藏" />
			                    </div>
			                </div>
			             </div>
					</form>
				</div>
				<div region="center" border="false">
					<table id="grantdatagrid" ></table>				
				</div>
			</div>
		</div>
	</div>
	<div id="grantorAddDialog" style="display: none;width: 600px;height: 330px;" align="center">
		<form id="grantorAddForm" style="height: 100%" class="zoc" method="post">
			<div class="oneline">
                <div class="item25">
                    <div class="itemleft60">托管人：</div>
                    <div class="righttext">
 						<input type="text" class="easyui-combobox short100" id="User_CODEADD" name="trusteeCode"></input>
                    </div>
                </div>
                <div class="item25 lastitem">
                    <div class="itemleft60">托管开始：</div>
                    <div class="righttext">
						<input name="startTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写托管开始"  style="width: 155px;"/>
                    </div>
                </div>
			</div>
			<div class="oneline">
                <div class="item25">
                    <div class="itemleft60">托管结束：</div>
                    <div class="righttext">
						<input name="expiredTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写托管结束"  style="width: 155px;"/>
                    </div>
                </div>
                <div class="item25 lastitem">
                    <div class="itemleft60 lastitem">状态：</div>
                    <div class="righttext">
						<select name="state" style="width: 155px;">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>							
		            </div>
                </div>
			</div>
		</form>
	</div>
	<div id="grantorEditDialog" style="display: none;width: 600px;height: 350px;" align="center">
		<form id="grantorEditForm" method="post" class="zoc" style="height: 100%">
			<div class="oneline">
                <div class="item25">
                    <div class="itemleft60">托管人：</div>
                    <div class="righttext">
 						<input type="hidden" name="id"></input>
 						<input type="text" class="easyui-combobox short100" id="User_CODEEDIT" name="trusteeCode"></input>
                    </div>
                </div>
                <div class="item25 lastitem">
                    <div class="itemleft60">托管开始：</div>
                    <div class="righttext">
						<input name="startTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写托管开始"  style="width: 155px;"/>
                    </div>
                </div>
			</div>
			<div class="oneline">
                <div class="item25">
                    <div class="itemleft60">托管结束：</div>
                    <div class="righttext">
						<input name="expiredTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写托管结束"  style="width: 155px;"/>
                    </div>
                </div>
                <div class="item25 lastitem">
                    <div class="itemleft60 lastitem">状态：</div>
                    <div class="righttext">
						<select name="state" style="width: 155px;">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>							
		            </div>
                </div>
			</div>
			<div class="oneline">
                <div class="item25">
                    <div class="itemleft60">创建时间：</div>
                    <div class="righttext">
						<input name="created" type="text" readonly="readonly" class="easyui-validatebox" data-options="" missingMessage="请填写创建时间"  style="width: 155px;"/>
                    </div>
                </div>
                <div class="item25 lastitem">
                    <div class="itemleft60 lastitem">创建人：</div>
                    <div class="righttext">
						<input name="createdBy" type="text" readonly="readonly" class="easyui-validatebox" data-options="" missingMessage="请填写创建人"  style="width: 155px;"/>
		            </div>
                </div>
			</div>
			<div class="oneline">
                <div class="item25">
                    <div class="itemleft60">修改时间：</div>
                    <div class="righttext">
						<input name="lastUpd" type="text" class="easyui-validatebox" readonly="readonly" data-options="" missingMessage="请填写修改时间"  style="width: 155px;"/>
                    </div>
                </div>
                <div class="item25 lastitem">
                    <div class="itemleft60 lastitem">修改人：</div>
                    <div class="righttext">
						<input name="lastUpdBy" type="text" readonly="readonly" class="easyui-validatebox" data-options="" missingMessage="请填写修改人"  style="width: 155px;"/>
		            </div>
                </div>
			</div>
		</form>
	</div>
	<div id="_User">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">用户名：</div>
				<div class="righttext">
					<input class="short60" id="userEmpCode" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('userEmpCode','User_CODE')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_UserB">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">用户名：</div>
				<div class="righttext">
					<input class="short60" id="userEmpCodeB" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('userEmpCodeB','User_CODEB')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_UserADD">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">用户名：</div>
				<div class="righttext">
					<input class="short60" id="userEmpCodeADD" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('userEmpCodeADD','User_CODEADD')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_UserEDIT">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">用户名：</div>
				<div class="righttext">
					<input class="short60" id="userEmpCodeEDIT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('userEmpCodeEDIT','User_CODEEDIT')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>