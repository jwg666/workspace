<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var paymentTermsEditDialog;
	var paymentTermsAddDialog;
	var paymentTermsEditForm;
	var paymentTermsAddForm;
	var cdescEdit;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/payorder/paymentTermsAction!datagrid.do',
			title : '付款条件列表',
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
			idField : 'termsCode',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.termsCode;
						}
					},
			   {field:'termsCode',title:'付款条件编码',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.termsCode;
					}
				},				
			   {field:'termsDesc',title:'付款条件描述',align:'center',sortable:true,width:200,
					formatter:function(value,row,index){
						return row.termsDesc;
					}
				},				
			   {field:'payNum',title:'付款次数',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.payNum;
					}
				},				
			   {field:'payOneRate',title:'一次付款比例',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.payOneRate;
					}
				},				
			   {field:'payOneMethod',title:'一次付款方式',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.payOneMethod+(row.payOneMethodName==null?"":"("+row.payOneMethodName+")");
					}
				},				
			   {field:'payOnePeriod',title:'一次付款周期',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.payOnePeriod;
					}
				},				
			   {field:'paySecendRate',title:'二次付款比例',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.paySecendRate;
					}
				},				
			   {field:'paySecendMethod',title:'二次付款方式',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.paySecendMethod!=null){
							return row.paySecendMethod+(row.paySecendMethodName==null?"":"("+row.paySecendMethodName+")");
						}
					}
				},				
			   {field:'paySecendPeriod',title:'二次付款周期',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.paySecendPeriod;
					}
				},				
			   {field:'priority',title:'优先级',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.priority;
					}
				},				
			   {field:'docFlag',title:'发货状态',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.docFlag=="1"){
							return "生产不发货";
						}else if(row.docFlag=="2"){
							return "发货不寄单";
						}else{
							return row.docFlag;
						}
					}
				},				
			   {field:'activeFlag',title:'是否有效',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.activeFlag==1){
							return "有效";
						}else{
							return "无效";
						}
					}
				},				
			   {field:'createdBy',title:'创建人',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'lastUpdBy',title:'修改人',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				}			
			 ] ]
			<s:if test='ifcanEdit!=null&&ifcanEdit=="yes"'>
			,
			toolbar : [ {
				text : '新增',
				iconCls : 'icon-edit',
				handler : function() {
					add();
				}
			}, '-',{
				text : '编辑',
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
			</s:if>
		});

		paymentTermsAddForm = $('#paymentTermsAddForm').form({
			url : 'paymentTermsAction!addPayments.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					paymentTermsAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
			}
		});
		paymentTermsEditForm = $('#paymentTermsEditForm').form({
			url : 'paymentTermsAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					paymentTermsEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
			}
		});

		paymentTermsAddDialog = $('#paymentTermsAddDialog').show().dialog({
			title : '新增付款条件',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					var num = $('#payNumid').val();
					if(num!=null&&num==2){
						var flag = $('#docFlagid').combobox('getValue');
						if(flag!=null&&flag!=""){
							paymentTermsAddForm.submit();
						}else{
							$.messager.show({
				                title:'提醒',  
				                msg:'您选择的付款次数为2，请填写发货类型',  
				                showType:'slide'  
				            }); 
						}
 					}else{
						paymentTermsAddForm.submit();
 					}
				}
			} ]
		});
		paymentTermsEditDialog = $('#paymentTermsEditDialog').show().dialog({
			title : '编辑付款条件',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					var num = $('#payNum').val();
					if(num!=null&&num==2){
						var flag = $('#docFlag').combobox('getValue');
						if(flag!=null&&flag!=""){
							paymentTermsEditForm.submit();
						}else{
							$.messager.show({  
				                title:'提醒',  
				                msg:'您选择的付款次数为2，请填写发货类型',  
				                showType:'slide'  
				            }); 
						}
 					}else{
						paymentTermsEditForm.submit();
 					}
				}
			} ]
		});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].termsCode+"&";
						else ids=ids+"ids="+rows[i].termsCode;
					}
					$.ajax({
						url : 'paymentTermsAction!delete.do',
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
	function add(){
		paymentTermsAddForm.form('clear');
		paymentTermsAddDialog.dialog('open');
	}
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url : 'paymentTermsAction!showDesc.do',
				data : {
					termsCode : rows[0].termsCode
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					paymentTermsEditForm.form("clear");
					paymentTermsEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					paymentTermsEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" collapsed="true"  style="height: 60px;overflow: hidden;" align="left">
		<form id="searchForm">
			<table class="tableForm datagrid-toolbar" style="width: 70%;height: 100%;">
				<tr>
					<th>付款条件编码：</th>
					<td>
						<input name="termsCode" style="width:80px;" />
					</td>
					<th>一次付款方式：</th>
					<td>
						<input name="payOneMethod" style="width:80px;" />
					</td>
					<th>二次付款方式：</th>
					<td>
						<input name="paySecendMethod" style="width:80px;" />
					</td>
					<th>付款次数：</th>
					<td>
						<input name="payNum" style="width:50px;" />
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">过滤</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">取消</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	<div id="paymentTermsEditDialog" style="display: none;width: 600px;height: 410px;" align="center">
		<form id="paymentTermsEditForm" method="post">
			<table class="tableForm" style="width: 500px;">
						<tr>
						<th>付款条件编码:</th>
							<td>
								<input name="termsCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写付款条件编码"  style="width: 155px;" readonly="readonly"/>
							</td>
						</tr>
						<tr>
						<th>付款条件描述:</th>
							<td>
								<input name="termsDesc" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写付款条件描述"  style="width: 155px;" />
							</td>
						</tr>
						<tr>
						<th>付款次数:</th>
							<td>
								<input name="payNum" id="payNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写付款次数"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>一次付款比例:</th>
							<td>
								<input style="width: 155px;" type="text" id="payOneRate" name="payOneRate"  />
							</td>
						</tr>
						<tr>
						<th>一次付款方式:</th>
							<td>
								<input id="payOneMethod" name="payOneMethod" class="easyui-combobox" style="width: 160px;"
						 			data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/payorder/paymentTermsAction!getMethodList.do'" />
							</td>
						</tr>
						<tr>
						<th>一次付款周期:</th>
							<td>
								<input name="payOnePeriod"  type="text" class="easyui-validatebox" data-options="" missingMessage="请填写一次付款周期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>二次付款比例:</th>
							<td>
								<input style="width: 155px;" type="text" name="paySecendRate" id="paySecendRate"  />
							</td>
						</tr>
						<tr>
						<th>二次付款方式:</th>
							<td>
								<input id="paySecendMethod" name="paySecendMethod" id="paySecendMethod" class="easyui-combobox" style="width: 160px;"
						 			data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/payorder/paymentTermsAction!getMethodList.do'" />
							</td>
						</tr>
						<tr>
						<th>二次付款周期:</th>
							<td>
								<input name="paySecendPeriod" id="paySecendPeriod" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写二次付款周期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>优先级:</th>
							<td>
								<input  name="priority" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写优先级"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>1 生产不发货 2发货不寄单 </th>
							<td>
								<select id="docFlag" class="easyui-combobox" style="width: 160px" name="docFlag">
									<option value="1">生产不发货</option>
									<option value="2">发货不寄单</option>
								</select>
							</td>
						</tr>
						<tr>
						<th>是否有效:</th>
							<td>
								<select style="width: 160px" name="activeFlag">
									<option value="1">有效</option>
									<option value="0">无效</option>
								</select>
							</td>
						</tr>
						<tr>
			</table>
		</form>
	</div>

    <div id="paymentTermsAddDialog" style="display: none;width: 600px;height: 410px;" align="center">
		<form id="paymentTermsAddForm" method="post">
			<table class="tableForm" style="width: 500px;">
						<tr>
						<th>付款条件编码:</th>
							<td>
								<input name="termsCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写付款条件编码"  style="width: 155px;" />
							</td>
						</tr>
						<tr>
						<th>付款条件描述:</th>
							<td>
								<input name="termsDesc" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写付款条件描述"  style="width: 155px;" />
							</td>
						</tr>
						<tr>
						<th>付款次数:</th>
							<td>
								<input name="payNum" id="payNumid" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写付款次数"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>一次付款比例:</th>
							<td>
								<input style="width: 155px;" type="text" id="payOneRate" name="payOneRate" />
							</td>
						</tr>
						<tr>
						<th>一次付款方式:</th>
							<td>
								<input id="payOneMethod" name="payOneMethod" class="easyui-combobox" style="width: 160px;"
						 			data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/payorder/paymentTermsAction!getMethodList.do'" />
							</td>
						</tr>
						<tr>
						<th>一次付款周期:</th>
							<td>
								<input name="payOnePeriod"  type="text" class="easyui-validatebox" data-options="" missingMessage="请填写一次付款周期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>二次付款比例:</th>
							<td>
								<input style="width: 155px;" type="text" name="paySecendRate" id="paySecendRate"  />
							</td>
						</tr>
						<tr>
						<th>二次付款方式:</th>
							<td>
								<input id="paySecendMethod" name="paySecendMethod" id="paySecendMethod" class="easyui-combobox" style="width: 160px;"
						 			data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/payorder/paymentTermsAction!getMethodList.do'" />
							</td>
						</tr>
						<tr>
						<th>二次付款周期:</th>
							<td>
								<input name="paySecendPeriod" id="paySecendPeriod" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写二次付款周期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>优先级:</th>
							<td>
								<input  name="priority" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写优先级"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>1 生产不发货 2发货不寄单 </th>
							<td>
								<select id="docFlagid" class="easyui-combobox" style="width: 160px" name="docFlag">
									<option value="1">生产不发货</option>
									<option value="2">发货不寄单</option>
								</select>
							</td>
						</tr>
						<tr>
						<th>是否有效:</th>
							<td>
								<select style="width: 160px" name="activeFlag">
									<option value="1">有效</option>
									<option value="0">无效</option>
								</select>
							</td>
						</tr>
						<tr>
			</table>
		</form>
	</div>

</body>
</html>