<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var factoryConfAddDialog;
	var factoryConfAddForm;
	var cdescAdd;
	var factoryConfEditDialog;
	var factoryConfEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
	    //编辑生产工厂变量
	    var produceFactoryParam = "";
	    //编辑结算工厂变量
	    var accountsFactoryParam = "";
		datagrid = $('#datagrid').datagrid({
			url : 'factoryConfAction!datagrid.do',
			title : '生产工厂与结算工厂列表',
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
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.id;
						}
					},
			   {field:'productFactoryCode',title:'生产工厂编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.productFactoryCode;
					}
				},
			   {field:'productFactoryName',title:'生产工厂名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.productFactoryName;
					}
				},
			   {field:'accountsFactoryCode',title:'结算工厂编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.accountsFactoryCode;
					}
				},
			   {field:'accountsFactoryName',title:'结算工厂名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.accountsFactoryName;
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
			}, '-' ]
		});

		factoryConfAddForm = $('#factoryConfAddForm').form({
			url : 'factoryConfAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					factoryConfAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		factoryConfAddDialog = $('#factoryConfAddDialog').show().dialog({
			title : '添加生产工厂和结算工厂',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					var produceCode = $('#productFactoryCode').combogrid('getValue');
					var accountsCode =  $('#accountsFactoryCode').combogrid('getValue');
					if(produceCode == "" || produceCode == null){
						$.messager.alert('提示','生产工厂不能为空,请检查！','info');
					}else if(accountsCode == "" || accountsCode == null){
						$.messager.alert('提示','结算工厂不能为空,请检查！','info');
					}else{
						factoryConfAddForm.submit();	
					}
				}
			} ]
		});

		factoryConfEditForm = $('#factoryConfEditForm').form({
			url : 'factoryConfAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					factoryConfEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});
		
		factoryConfEditDialog = $('#factoryConfEditDialog').show().dialog({
			title : '编辑生产工厂和结算工厂',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					var produceCode = $('#productFactoryEditCode').combogrid('getValue');
					var accountsCode =  $('#accountsFactoryEditCode').combogrid('getValue');
					if(produceCode == "" || produceCode == null){
						$.messager.alert('提示','生产工厂不能为空,请检查！','info');
					}else if(accountsCode == "" || accountsCode == null){
						$.messager.alert('提示','结算工厂不能为空,请检查！','info');
					}else{
						factoryConfEditForm.submit();
					}
				}
			} ]
		});
		
		//加载生产工厂下拉列表
		$('#productFactoryCode').combogrid({
			 url:'${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0',
			 idField:'deptCode',  
			 textField:'deptNameCn',
		     panelWidth : 500,
			 panelHeight : 220,
			 pagination : true,
			 pagePosition : 'bottom',
			 toolbar : '#_ProductFactory',
			 rownumbers : true,
			 pageSize : 5,
			 pageList : [ 5, 10 ],
			 fit : true,
			 fitColumns : true,
			 editable : false,
			 columns : [ [ {
				field : 'deptCode',
				title : '生产工厂编码',
				width : 20
			 },{
				field : 'deptNameCn',
				title : '生产工厂名称',
				width : 20
			 }  ] ]
		});
		
		//加载结算工厂下拉列表
		$('#accountsFactoryCode').combogrid({
			 url:'${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0',
			 idField:'deptCode',  
			 textField:'deptNameCn',
		     panelWidth : 500,
			 panelHeight : 220,
			 pagination : true,
			 pagePosition : 'bottom',
			 toolbar : '#_AccountsFactory',
			 rownumbers : true,
			 pageSize : 5,
			 pageList : [ 5, 10 ],
			 fit : true,
			 fitColumns : true,
			 editable : false,
			 columns : [ [ {
				field : 'deptCode',
				title : '生产工厂编码',
				width : 20
			 },{
				field : 'deptNameCn',
				title : '生产工厂名称',
				width : 20
			 }  ] ]
		});
		
		//加载编辑生产工厂下拉列表
		var urlProduceFactory = "";
		if(produceFactoryParam == "" || produceFactoryParam == null){
			urlProduceFactory = '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0';
		}
		$('#productFactoryEditCode').combogrid({
			 url:urlProduceFactory,
			 idField:'deptCode',  
			 textField:'deptNameCn',
		     panelWidth : 500,
			 panelHeight : 220,
			 pagination : true,
			 pagePosition : 'bottom',
			 toolbar : '#_ProductEditFactory',
			 rownumbers : true,
			 pageSize : 5,
			 pageList : [ 5, 10 ],
			 fit : true,
			 fitColumns : true,
			 editable : false,
			 columns : [ [ {
				field : 'deptCode',
				title : '生产工厂编码',
				width : 20
			 },{
				field : 'deptNameCn',
				title : '生产工厂名称',
				width : 20
			 }  ] ]
		});
		
		//加载编辑结算工厂下拉列表
		var urlAccountsFactory = "";
		if(accountsFactoryParam == "" || accountsFactoryParam == null){
			urlAccountsFactory = '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0';
		}
		$('#accountsFactoryEditCode').combogrid({
			 url:urlAccountsFactory,
			 idField:'deptCode',  
			 textField:'deptNameCn',
		     panelWidth : 500,
			 panelHeight : 220,
			 pagination : true,
			 pagePosition : 'bottom',
			 toolbar : '#_AccountsEditFactory',
			 rownumbers : true,
			 pageSize : 5,
			 pageList : [ 5, 10 ],
			 fit : true,
			 fitColumns : true,
			 editable : false,
			 columns : [ [ {
				field : 'deptCode',
				title : '生产工厂编码',
				width : 20
			 },{
				field : 'deptNameCn',
				title : '生产工厂名称',
				width : 20
			 }  ] ]
		});
		
		//查询生产工厂下拉列表
		$('#productFactorySearchCode').combogrid({
			 url:'${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0',
			 idField:'deptCode',  
			 textField:'deptNameCn',
		     panelWidth : 500,
			 panelHeight : 220,
			 pagination : true,
			 pagePosition : 'bottom',
			 toolbar : '#_ProductSearchFactory',
			 rownumbers : true,
			 pageSize : 5,
			 pageList : [ 5, 10 ],
			 fit : true,
			 fitColumns : true,
			 editable : false,
			 columns : [ [ {
				field : 'deptCode',
				title : '生产工厂编码',
				width : 20
			 },{
				field : 'deptNameCn',
				title : '生产工厂名称',
				width : 20
			 }  ] ]
		});
		
		//查询结算工厂下拉列表
		$('#accountsFactorySearchCode').combogrid({
			 url:'${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0',
			 idField:'deptCode',  
			 textField:'deptNameCn',
		     panelWidth : 500,
			 panelHeight : 220,
			 pagination : true,
			 pagePosition : 'bottom',
			 toolbar : '#_AccountsSearchFactory',
			 rownumbers : true,
			 pageSize : 5,
			 pageList : [ 5, 10 ],
			 fit : true,
			 fitColumns : true,
			 editable : false,
			 columns : [ [ {
				field : 'deptCode',
				title : '生产工厂编码',
				width : 20
			 },{
				field : 'deptNameCn',
				title : '生产工厂名称',
				width : 20
			 }  ] ]
		});

	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function add() {
		factoryConfAddForm.form("clear");
		$('div.validatebox-tip').remove();
		factoryConfAddDialog.dialog('open');
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
						url : 'factoryConfAction!delete.do',
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
				url : 'factoryConfAction!showDesc.do',
				data : {
					id : rows[0].id
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					factoryConfEditForm.form("clear");
					//赋值生产工厂变量
					$('#productFactoryEditCode').combogrid({url:'${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0&deptCode='+response.productFactoryCode});
					//赋值结算工厂变量
					$('#accountsFactoryEditCode').combogrid({url:'${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0&deptCode='+response.accountsFactoryCode});
					factoryConfEditForm.form('load', response);
					factoryConfEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
	//模糊查询生产工厂下拉列表
	function _ProductFactoryMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'+'&deptCode='+_CCNCODE+'&deptNameCn='+_CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询生产工厂输入框
	function _ProductFactoryCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'
				});
	}
	//模糊查询结算工厂下拉列表
	function _AccountsFactoryMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'+'&deptCode='+_CCNCODE+'&deptNameCn='+_CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询结算工厂输入框
	function _AccountsFactoryCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'
				});
	}
	
	//模糊查询生产工厂下拉列表
	function _ProductSearchFactoryMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'+'&deptCode='+_CCNCODE+'&deptNameCn='+_CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询生产工厂输入框
	function _ProductSearchFactoryCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'
				});
	}
	
	//模糊查询结算工厂下拉列表
	function _AccountsSearchFactoryMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'+'&deptCode='+_CCNCODE+'&deptNameCn='+_CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询结算工厂输入框
	function _AccountsSearchFactoryCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'
				});
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" collapsed="true"  style="height: 55px;overflow: hidden;" align="left">
		<form id="searchForm">
			 <div class="part_zoc">
		        <div class="oneline">
		             <div class="item33">
					     <div class="itemleft100">生产工厂：</div>
					     <div class="rightselect_easyui">
						     <input id="productFactorySearchCode" name="productFactoryCode" style="width:200px" editable="false" />
					     </div>
				     </div>
				     <div class="item33">
					     <div class="itemleft100">结算工厂：</div>
						 <div class="rightselect_easyui">
						     <input id="accountsFactorySearchCode" name="accountsFactoryCode" style="width:200px" editable="false" />
						 </div>
				     </div>
				      <div class="item33 lastitem">
				        <div class="oprationbutt">
				            <input type="button" value="查  询" onclick="_search()"/>
				            <input type="button" value="重  置" onclick="cleanSearch()"/>
				        </div>
				    </div>
		         </div>
		    </div>
		</form>
	</div>
	
	<div region="center" border="false" class="part_zoc">
		<table id="datagrid"></table>
	</div>

	<div id="factoryConfAddDialog" style="display: none;width: 400px;height: 150px; overflow: hidden;" align="center" >
		<form id="factoryConfAddForm" method="post">
		    <div class="part_zoc">
		        <div class="oneline">
		             <div class="item33">
					     <div class="itemleft100">生产工厂：</div>
					     <div class="rightselect_easyui">
						     <input id="productFactoryCode" name="productFactoryCode" style="width:200px" editable="false" />
					     </div>
				     </div>
		         </div>
		         <div class="oneline">
		             <div class="item33">
					     <div class="itemleft100">结算工厂：</div>
						 <div class="rightselect_easyui">
						     <input id="accountsFactoryCode" name="accountsFactoryCode" style="width:200px" editable="false" />
						 </div>
				     </div>
		         </div>
		    </div>
		</form>
	</div>

	<div id="factoryConfEditDialog" style="display: none;width: 400px;height: 150px;overflow: hidden;" align="center">
		<form id="factoryConfEditForm" method="post">
		    <input id="id"  name="id"  type="hidden">
			<div class="part_zoc" style="margin:0px 0px 0px 0px;">
		         <div class="oneline">
		             <div class="item33">
					     <div class="itemleft100">生产工厂：</div>
					     <div class="rightselect_easyui">
						     <input id="productFactoryEditCode" name="productFactoryCode" style="width:200px" editable="false" />
					     </div>
				     </div>
		         </div>
		         <div class="oneline">
		             <div class="item33">
					     <div class="itemleft100">结算工厂：</div>
						 <div class="rightselect_easyui">
						     <input id="accountsFactoryEditCode" name="accountsFactoryCode" style="width:200px" editable="false" />
						 </div>
				     </div>
		         </div>
		     </div>
		</form>
	</div>
	 <!-- 生产工厂下拉选信息 -->
	<div id="_ProductFactory">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">生产工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_PFACTORYCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">生产工厂名称：</div>
				<div class="righttext">
					<input class="short50" id="_PFACTORYNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_ProductFactoryMY('_PFACTORYCODE','_PFACTORYNAME','productFactoryCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_ProductFactoryCLEAN('_PFACTORYCODE','_PFACTORYNAME','productFactoryCode')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 结算工厂下拉选信息 -->
	<div id="_AccountsFactory">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">生产工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_AFACTORYCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">生产工厂名称：</div>
				<div class="righttext">
					<input class="short50" id="_AFACTORYNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_AccountsFactoryMY('_AFACTORYCODE','_AFACTORYNAME','accountsFactoryCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_AccountsFactoryCLEAN('_AFACTORYCODE','_AFACTORYNAME','accountsFactoryCode')" />
				</div>
			</div>
		</div>
	</div>
	
	 <!-- 编辑生产工厂下拉选信息 -->
	<div id="_ProductEditFactory">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">生产工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_PFACTORYEDITCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">生产工厂名称：</div>
				<div class="righttext">
					<input class="short50" id="_PFACTORYEDITNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_ProductFactoryMY('_PFACTORYEDITCODE','_PFACTORYEDITNAME','productFactoryEditCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_ProductFactoryCLEAN('_PFACTORYEDITCODE','_PFACTORYEDITNAME','productFactoryEditCode')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 编辑结算工厂下拉选信息 -->
	<div id="_AccountsEditFactory">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">生产工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_AFACTORYEDITCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">生产工厂名称：</div>
				<div class="righttext">
					<input class="short50" id="_AFACTORYEDITNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_AccountsFactoryMY('_AFACTORYEDITCODE','_AFACTORYEDITNAME','accountsFactoryEditCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_AccountsFactoryCLEAN('_AFACTORYEDITCODE','_AFACTORYEDITNAME','accountsFactoryEditCode')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 查询生产工厂下拉选信息 -->
	<div id="_ProductSearchFactory">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">生产工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_PFACTORYSEARCHCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">生产工厂名称：</div>
				<div class="righttext">
					<input class="short50" id="_PFACTORYSEARCHNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_ProductSearchFactoryMY('_PFACTORYSEARCHCODE','_PFACTORYSEARCHNAME','productFactorySearchCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_ProductSearchFactoryCLEAN('_PFACTORYSEARCHCODE','_PFACTORYSEARCHNAME','productFactorySearchCode')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 查询结算工厂下拉选信息 -->
	<div id="_AccountsSearchFactory">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">生产工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_AFACTORYSEARCHCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">生产工厂名称：</div>
				<div class="righttext">
					<input class="short50" id="_AFACTORYSEARCHNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_AccountsSearchFactoryMY('_AFACTORYSEARCHCODE','_AFACTORYSEARCHNAME','accountsFactorySearchCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_AccountsSearchFactoryCLEAN('_AFACTORYSEARCHCODE','_AFACTORYSEARCHNAME','accountsFactorySearchCode')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>