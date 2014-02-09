<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var editRow = undefined;
	var showLoadExcelDialog;
	$(function() {
		//查询列表	
	    searchForm = $('#searchForm').form();
	    datagrid = $('#datagrid').datagrid({
			title : '散件备案信息列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			nowrap : true,
			border : false,
			toolbar : [  {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			},'-', {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					if (editRow != undefined) {
						datagrid.datagrid('endEdit', editRow);
					}
				}
			}, '-'],
			onAfterEdit : function(rowIndex, rowData, changes) {
				var inserted = datagrid.datagrid('getChanges', 'inserted');
				var updated = datagrid.datagrid('getChanges', 'updated');
				if (inserted.length < 1 && updated.length < 1) {
					editRow = undefined;
					datagrid.datagrid('unselectAll');
					return;
				}
				var url = '';
				if (inserted.length > 0) {
					url = 'materialRecordAction!add.action';
				}
				if (updated.length > 0) {
					url = 'materialRecordAction!edit.action';
				}
				rowData.setParts=$("#setParts").val();
				$.ajax({
					url : url,
					data : rowData,
					dataType : 'json',
					success : function(r) {
						if (r.success) {
							datagrid.datagrid('acceptChanges');
							$.messager.show({
								msg : r.msg,
								title : '成功'
							});
							editRow = undefined;
							datagrid.datagrid('reload');
						} else {
							datagrid.datagrid('beginEdit', editRow);
							$.messager.alert('错误', r.msg, 'error');
						}
						datagrid.datagrid('unselectAll');
					}
				});

			}
		});
		queryDatagrid();
		//加载导入excel方法
		showLoadExcelInfoForm = $('#showLoadExcelInfoForm').form({
			url:'materialRecordAction!exportInMaterialRecord.action',
			success:function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					$.messager.progress('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
					$.messager.progress('close');
				}
				showLoadExcelDialog.dialog('close');
				datagrid.datagrid('reload');
			}
		});
		showLoadExcelDialog = $('#showLoadExcelDialog').show().dialog({
	    	title : '导入备案信息',
	    	modal : true,
	    	closed : true,
	    	collapsible : true,
	    	buttons : [{
	    		text : '导入',
	    		handler : function(){
	    			var text=$("#prodTypeCode").combobox('getText');
	    			$.messager.confirm('请确认', '您要导入产品大类为<span style="color:red;">'+text+'</span>的信息？', function(r) {
	    				if (r) {
			    			if($("#excleFile").val()==""){
			    				alert("请选择导出的excel文件！");
			    				return;
			    			}
			    			$.messager.progress({
			    				text : '数据加载中....',
			    				interval : 100
			    				});
			    			showLoadExcelInfoForm.submit();
	    				}
	    			});
	    		}
	    	}]
	    });
	});
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			if (editRow != undefined) {
				datagrid.datagrid('endEdit', editRow);
			}

			if (editRow == undefined) {
				editRow = datagrid.datagrid('getRowIndex', rows[0]);
				datagrid.datagrid('beginEdit', editRow);
				datagrid.datagrid('unselectAll');
			}
		} else {
			$.messager.show({
				msg : '请选择一项进行修改！',
				title : '错误'
			});
		}
	}
	function queryDatagrid(){
		fetchData(); 
	}
	function fetchData() { 
	    var s = ""; 
	    s = "[["; 
	    s += "{field:'brand',title:'品牌',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.brand;}},"; 
	    s += "{field:'haierProdDesc',title:'海尔品名英文',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.haierProdDesc;}},";
	    s += "{field:'haierProdDescCn',title:'海尔品名中文',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.haierProdDescCn;}},";
	    s += "{field:'materialCode',title:'物料号',align:'center',sortable:true,formatter:function(value,row,index){return row.materialCode;}},";			
	    s += "{field:'prodTypeName',title:'产品大类',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.prodTypeName;}},";				
	    s += "{field:'hsCode',title:'海关商品编码',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.hsCode;}},";				
	    s += "{field:'hsName',title:'海关商品名称',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.hsName;}},";	
	    s += "{field:'simpleCode',title:'HROIS简码',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.simpleCode;}},";	
	    s += "{field:'simpleCodeDesc',title:'HROIS描述',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.simpleCodeDesc;}},";	
	    s += "{field:'use',title:'用途',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.use;}},";	
	    s += "{field:'comments',title:'备注',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.comments;}},";
	    if($('#setParts').val()=='1'){
	    	s += "{field : 'rowId',title : 'rowId',align : 'center',sortable : true,hidden : true,formatter : function(value, row, index){return row.rowId;}}";
	    }else{
	    	s += "{field : 'sparePartsCode',title : 'sparePartsCode',align : 'center',sortable : true,hidden : true,formatter : function(value, row, index){return row.sparePartsCode;}}";
	    }
	    
	    $.ajax({
			url : 'materialRecordAction!findAllcolumnName.action',
			async:false,
			data : {
				prodType: $("#prodTypeCode").combobox('getValue'),
				setParts: $("#setParts").val()
				
			},
			dataType : 'json',
			success : function(data) {
				for(var i=0;i<data.length;i++){
					s += ",{field:'"+data[i].columnName.toLowerCase()+"',title:'"+data[i].propertyName+"',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row."+data[i].columnName.toLowerCase()+";}}";			 
				}
			}
		}); 
	    s += "]]";
	    options=datagrid.datagrid("options"); 
	    options.url = 'materialRecordAction!datagrids.do'; 
	    options.queryParams={'prodType':$("#prodTypeCode").combobox('getValue'),
	    		'setParts': $("#setParts").val(),'materialCode':$("#materialCode").val(),
				'hroisCodeIsNull':$("#hroisCodeIsNull").val()};
	    options.columns = eval(s); 
	  
	    datagrid.datagrid(options);
	    datagrid.datagrid('load');    
	     
	} 
	function _search() {
		if($("#prodTypeCode").combobox('getValue')==""){
			alert("请选择产品大类！");
			return;
		}
		queryDatagrid();
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	//导入备案信息
	function exportInMaterialRecord() {
		if($("#prodTypeCode").combobox('getValue')==""){
			alert("请选择需要导入修改的产品大类！");
			return;
		}else{
			$("#excleProdTypeCode").val($("#prodTypeCode").combobox('getValue'));
			$("#excleSetParts").val($("#setParts").val());
		}
		$("#excleFile").val("");
		$('div.validatebox-tip').remove();
		showLoadExcelDialog.dialog('open');
	}
	//导出模板
	function exportTemplate(){
		if($("#prodTypeCode").combobox('getValue')==""){
			alert("请选择需要导出修改的产品大类！");
			return;
		}
		$("#searchForm").attr("action", "materialRecordAction!exportMaterialRecord.action");
		$("#searchForm").submit();
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 120px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>备案信息导入</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">产品大类：</div>
						<div class="righttext_easyui">
						<input name="prodType" class="easyui-combobox short60" id="prodTypeCode"
										style="width: 130px" 
										data-options="valueField:'prodTypeCode',textField:'prodType',url:'${dynamicURL}/basic/prodTypeAction!combox.action'" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">类型：</div>
						<div class="righttext">
						<select name="setParts" id="setParts">
							<option value="1">整机</option>
							<option value="2">散件</option>
						</select>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">物料号：</div>
						<div class="righttext_easyui">
						<input id="materialCode" name="materialCode" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft100">HROIS简码为空：</div>
						<div class="righttext_easyui">
						<select name="hroisCodeIsNull" id="hroisCodeIsNull">
							<option value="">全部</option>
							<option value="Y">是</option>
							<option value="N">否</option>
						</select>
						</div>
					</div>
				</div>
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查  询" onclick="_search();" />
						<input type="button" value="导出模板" onclick="exportTemplate();" />
						<input type="button" value="导  入" onclick="exportInMaterialRecord();" />
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	<div id="showLoadExcelDialog" style="display: none;width: 400px;height: 100px;" align="center">
		<form id="showLoadExcelInfoForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="excleProdTypeCode" name="prodType"/>
			<input type="hidden" id="excleSetParts" name="setParts"/>
		    <table class="tableForm">
				<tr>
					<th>导入Excel信息:</th>
						<td>
						    <s:file id="excleFile" name="excleFile"></s:file>
						</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>