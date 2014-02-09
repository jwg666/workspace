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
	var proTypeCombox=[];
	var interpretationCombobox=[];
	var hroisCodeCombobox=[];
	var commodityCodeCombobox=[];
	var exportInspectionCombobox=[];
	var declarationNameCombobox=[];
	var recordProdTypebobox=[];
	$(function() {
		//查询列表	
	    searchForm = $('#searchForm').form();
	    datagrid = $('#datagrid').datagrid({
			title : '备案信息列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			singleSelect : true,
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
			url:'materialRecordAction!exportInMaterial.action',
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
				recordProdType();
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
		var f = "";
	    var s = ""; 
	    f = "[["; 
	    f += "{field:'rowId',title:'标志号',align:'center',sortable:true,formatter:function(value,row,index){return row.rowId;}},";
	    f += "{field:'materialCode',title:'物料号',align:'center',sortable:true,formatter:function(value,row,index){return row.materialCode;}},";
	    f += "{field:'brand',title:'品牌',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.brand;}},";
	    f += "{field:'haierProductCode',title:'海尔型号',align:'center',sortable:true,formatter:function(value,row,index){return row.haierProductCode;}},";
	    f += "{field:'prodCode',title:'客户型号',align:'center',sortable:true,formatter:function(value,row,index){return row.prodCode;}},";
	    f += "{field:'haierProdDesc',title:'海尔品名英文',align:'center',sortable:true,editor:{type:'text'},formatter:function(value,row,index){return row.haierProdDesc;}}";
	    f += "]]";
	    s = "[["; 
	    s += "{field:'column14',title:'物料类',align:'center',sortable:true,editor:{";
	    s += "type:'combobox',options:{valueField:'id',textField:'value',panelHeight: 50,data:[{'id':'1','value':'整机'}]}},";
	    s += "formatter:function(value,row,index){if (row.column14 == '1') {return '整机';} else if (row.column14 == '2'){return '散件';} else {return '';}}},";
	    s += "{field:'column15',title:'备案大类',align:'center',sortable:true,editor:{";
	    s += "type:'combobox', options:{ editable: false,valueField:'prodtype',  textField:'prodtype',";
	    s += "data:recordProdTypebobox,onChange: function (newValue,oldValue) {prodTypeComboboxs(newValue);}}";
	    s += "},formatter:function(value,row,index){return row.column15;}}";				
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
					if("column1"==data[i].columnName.toLowerCase() || "column4"==data[i].columnName.toLowerCase()){
						s += ",{field:'"+data[i+1].columnName.toLowerCase()+"',title:'"+data[i].propertyDesc+"',align:'center',sortable:true,";
						//输入值修改限定
						
						s += "editor:{type:'text'},";
						s += "formatter:function(value,row,index){return row."+data[i+1].columnName.toLowerCase()+"+' "+data[i+2].propertyDesc+"';}}";
					}
					if("column3"==data[i].columnName.toLowerCase()){
						s += ",{field:'"+data[i].columnName.toLowerCase()+"',title:'"+data[i].propertyDesc+"',align:'center',sortable:true,hidden:true,";
						s += "editor:{type:'text'},";
						s += "formatter:function(value,row,index){return '"+data[i].propertyDesc+"';}}";
					}
				}
			}
		}); 
	    s += ",{field:'column16',title:'产品组',width:100, align:'center',sortable:false,editor:{";
	    s += "type:'combobox', options:{editable: false, valueField:'prodgroup',  textField:'prodgroup',";
	    s += "data:proTypeCombox,onChange: function (newValue,oldValue) {var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column15'}).target;interpretationComboboxs(newValue,editor_target.combobox('getValue'));}}";
	    s += " },formatter:function(value,row,index){return row.column16;}},";	
	    s += "{field:'column17',title:'标识简码解释',width:240,align:'center',sortable:true,editor:{";
	    s += "type:'combobox', options:{ editable: false,valueField:'codeInterpretation',  textField:'codeInterpretation',";
	    s += "data:interpretationCombobox,onChange: function (newValue,oldValue) {var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column16'}).target;hroisCodeComboboxs(newValue,editor_target.combobox('getValue'));}}";
	    s += "},formatter:function(value,row,index){return row.column17;}},";
	    s += "{field:'simpleCode',title:'HROIS简码',width:150,align:'center',sortable:true,editor:{";
	    s += "type:'combobox', options:{ editable: false,valueField:'hroisCode',  textField:'hroisCode',";
	    s += "data:hroisCodeCombobox,onChange: function (newValue,oldValue) {var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column16'}).target;";
	    s += "var editor_targetI = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column17'}).target;commodityCodeComboboxs(editor_targetI.combobox('getValue'),editor_target.combobox('getValue'));}}";
	    s += "},formatter:function(value,row,index){return row.simpleCode;}},";	
	    s += "{field:'hsCode',title:'海关商品编码',width:150,align:'center',sortable:true,editor:{";
		s += "type:'combobox', options:{editable: false,valueField:'commodityCode',  textField:'commodityCode',";
	    s += "data:commodityCodeCombobox,onChange: function (newValue,oldValue) {var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column16'}).target;";
	    s += "var editor_targetI = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column17'}).target;exportInspectionComboboxs(editor_targetI.combobox('getValue'),editor_target.combobox('getValue'));}}";
	    s += "},formatter:function(value,row,index){return row.hsCode;}},";
	    s += "{field:'column18',title:'出口商检',align:'center',sortable:true,editor:{";
	    s += "type:'combobox', options:{ editable: false,valueField:'exportInspection',  textField:'exportInspection',";
	    s += "data:exportInspectionCombobox,onChange: function (newValue,oldValue) {var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column16'}).target;";
	    s += "var editor_targetI = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column17'}).target;declarationNameComboboxs(editor_targetI.combobox('getValue'),editor_target.combobox('getValue'));}}";
	    s += "},formatter:function(value,row,index){return row.column18;}},";	
	    s += "{field:'column19',title:'报关品名',width:150,align:'center',sortable:true,editor:{";
	    s += "type:'combobox',options:{ editable: false,valueField:'declarationName',  textField:'declarationName',";
	    s += "data:declarationNameCombobox,onChange: function (newValue,oldValue) {var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column16'}).target;}}";
	    s += "},formatter:function(value,row,index){return row.column19;}},";	
	    s += "{field:'column20',title:'关键参数',align:'center',sortable:true,formatter:function(value,row,index){return row.column20;}}";
	    s += "]]";
	    options=datagrid.datagrid("options"); 
	    options.url = 'materialRecordAction!datagrids.do'; 
	    options.queryParams={'prodType':$("#prodTypeCode").combobox('getValue'),
	    		'setParts': $("#setParts").val(),'materialCode':$("#materialCode").val(),
				'hroisCodeIsNull':$("#hroisCodeIsNull").val()};
	    options.frozenColumns=eval(f);
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
		$("#searchForm").attr("action", "materialRecordAction!exportMaterial.action");
		$("#searchForm").submit();
	}
	function prodTypeComboboxs(prodtype){
		//显示产品组下拉
		var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column16'}).target;
		$.ajax({
    	     url:'${dynamicURL}/inspection/recordMaterialAction!combox.do?flag=group',
    	     dataType:"json",
    	     data : {
    	    	 prodtype : prodtype
				},
    	     success:function(data){
    	    	 editor_target.combobox('loadData',data);
    	    	 proTypeCombox = editor_target.combobox('getData');
    	    	 editor_target.combobox('select',data[0].prodgroup);
    	     }
		});
	}
	//备案大类
	function recordProdType(){
		//显示产品组下拉
		var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column15'}).target;
		editor_target.combobox('setValue','');
		$.ajax({
    	     url:'${dynamicURL}/inspection/recordMaterialAction!combox.do?flag=recordProdType',
    	     dataType:"json",
    	     success:function(data){
    	    	 editor_target.combobox('loadData',data);
    	    	 recordProdTypebobox = editor_target.combobox('getData');
    	    	 editor_target.combobox('select',data[0].prodtype);
    	     }
		});
	}
	function interpretationComboboxs(prodGroup,prodType){
		//显示产品组下拉
		var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column17'}).target;
		editor_target.combobox('setValue','');
		$.ajax({
    	     url:'${dynamicURL}/inspection/recordMaterialAction!combox.do?flag=interpretation',
    	     dataType:"json",
    	     data : {
    	    	 prodgroup : prodGroup,
    	    	 prodtype  : prodType
				},
    	     success:function(data){
    	    	 editor_target.combobox('loadData',data);
    	    	 interpretationCombobox = editor_target.combobox('getData');
    	    	 editor_target.combobox('select',data[0].codeInterpretation);
    	     }
		});
	}
	function hroisCodeComboboxs(interpretation,prodGroup){
		//显示简码下拉
		var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'simpleCode'}).target;
		editor_target.combobox('setValue','');
		$.ajax({
    	     url:'${dynamicURL}/inspection/recordMaterialAction!combox.do?flag=hroisCode',
    	     dataType:"json",
    	     data : {
    	    	 prodgroup : prodGroup,
    	    	 codeInterpretation:interpretation
				},
    	     success:function(data){
    	    	 editor_target.combobox('loadData',data);
    	    	 hroisCodeCombobox = editor_target.combobox('getData');
    	    	 editor_target.combobox('select',data[0].hroisCode);
    	     }
		});
	}
	function commodityCodeComboboxs(interpretation,prodGroup){
		//显示简码下拉
		var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'hsCode'}).target;
		editor_target.combobox('setValue','');
		$.ajax({
    	     url:'${dynamicURL}/inspection/recordMaterialAction!combox.do?flag=commodityCode',
    	     dataType:"json",
    	     data : {
    	    	 prodgroup : prodGroup,
    	    	 codeInterpretation:interpretation
				},
    	     success:function(data){
    	    	 editor_target.combobox('loadData',data);
    	    	 commodityCodeCombobox = editor_target.combobox('getData');
    	    	 editor_target.combobox('select',data[0].commodityCode);
    	     }
		});
	}
	function exportInspectionComboboxs(interpretation,prodGroup){
		//显示简码下拉
		var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column18'}).target;
		editor_target.combobox('setValue','');
		$.ajax({
    	     url:'${dynamicURL}/inspection/recordMaterialAction!combox.do?flag=exportInspection',
    	     dataType:"json",
    	     data : {
    	    	 prodgroup : prodGroup,
    	    	 codeInterpretation:interpretation
				},
    	     success:function(data){
    	    	 editor_target.combobox('loadData',data);
    	    	 exportInspectionCombobox = editor_target.combobox('getData');
    	    	 editor_target.combobox('select',data[0].exportInspection);
    	     }
		});
	}
	function declarationNameComboboxs(interpretation,prodGroup){
		//显示简码下拉
		var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'column19'}).target;
		editor_target.combobox('setValue','');
		$.ajax({
    	     url:'${dynamicURL}/inspection/recordMaterialAction!combox.do?flag=declarationName',
    	     dataType:"json",
    	     data : {
    	    	 prodgroup : prodGroup,
    	    	 codeInterpretation:interpretation
				},
    	     success:function(data){
    	    	 editor_target.combobox('loadData',data);
    	    	 declarationNameCombobox = editor_target.combobox('getData');
    	    	 editor_target.combobox('select',data[0].declarationName);
    	     }
		});
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
				<s:hidden name="setParts" value="1"/>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">产品大类：</div>
						<div class="righttext_easyui">
						<input name="prodType" class="easyui-combobox short60" id="prodTypeCode"
										style="width: 130px" 
										data-options="valueField:'prodTypeCode',textField:'prodType',url:'${dynamicURL}/basic/prodTypeAction!comboxRecord.action'" />
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