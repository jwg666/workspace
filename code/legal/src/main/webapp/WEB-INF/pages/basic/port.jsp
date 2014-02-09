<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var editRow = undefined;
	var datagrid;
	//接收datagrid的中标编号下拉列表数据
	var countryData =[];
	$(function() {

		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'portAction!datagrid.action',
			title : '港口信息列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 15,
			pageList : [ 15, 20, 30, 40, 50, 100 ],
			fit : true,
			fitColumns : true,
			rownumbers : true,
			nowrap : false,
			border : false,
			idField : 'obid',
			
			columns : [ [ 
				{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.obid;
						}
				},
			   {field:'countryId',title:'国家ID',align:'center',sortable:false,
			  	    editor : {
							type : 'combobox',
							options : {
								valueField:'countryCode',  
		                        textField:'name',
		                        data:countryData,
	    						panelHeight:200,
	    						panelWidth:100
							}
					},
					formatter:function(value,row,index){
						if(countryData.length == 0){
							return row.countryId;
						}else{
							for(var i = 0; i < countryData.length; i++){
								 if (countryData[i].countryCode == value){ 
						    	    return countryData[i].countryCode;
								 }
							}
						}
					}
				},				
			   {field:'portCode',title:'港口编码',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.portCode;
					}
				},				
			   {field:'portName',title:'港口名称',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.portName;
					}
				},				
			   {field:'englishName',title:'英文名称',align:'center',sortable:false,
			  	    editor : {
							type : 'validatebox',
							options : {}
					},
					formatter:function(value,row,index){
						return row.englishName;
					}
				},
			   {field:'route',title:'航线',align:'center',sortable:false,
					formatter:function(value,row,index){
						return row.route;
					}
				},	
			   {field:'activeFlag',title:'有效标志',align:'center',sortable:false,
			  	    editor : {
			  	    	type:'combobox',
						editable: false,
						options:{
							valueField:'value',  
                            textField:'label',
                            panelHeight: 50,
							data: [{
								label: '有效',
								value: '1'
							},{
								label: '无效',
								value: '0'
							}]
						}
					},
					formatter:function(value,row,index){
							if(row.activeFlag=="1"){
								return "有效";
							}else{
								return "无效";
							}
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
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					if (editRow != undefined) {
						datagrid.datagrid('endEdit', editRow);
					}
				}
			}, '-', {
				text : '取消编辑',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
					datagrid.datagrid('rejectChanges');
					editRow = undefined;
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ],
			onDblClickRow : function(rowIndex, rowData) {
				if (editRow != undefined) {
					datagrid.datagrid('endEdit', editRow);
				}

				if (editRow == undefined) {
					changeEditorEditRow();/*改变editor*/
					datagrid.datagrid('beginEdit', rowIndex);
					editRow = rowIndex;
					datagrid.datagrid('unselectAll');
				}
			},
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
					url = 'portAction!add.action';
				}
				if (updated.length > 0) {
					url = 'portAction!edit.action';
				}

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
							/*datagrid.datagrid('rejectChanges');*/
							datagrid.datagrid('beginEdit', editRow);
							$.messager.alert('错误', r.msg, 'error');
						}
						datagrid.datagrid('unselectAll');
					}
				});

			},
		});
		//加载国家信息
		$('#countryCode').combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_COUNTRY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 20
			}, {
				field : 'name',
				title : '国家名称',
				width : 20
			} ] ]
		});
		
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form("clear");
	}
	
	function add() {
		if (editRow != undefined) {
			datagrid.datagrid('endEdit', editRow);
		}
		if (editRow == undefined) {
			datagrid.datagrid('unselectAll');
			var row = {
				cid : sy.UUID()
			};
			datagrid.datagrid('appendRow', row);
			editRow = datagrid.datagrid('getRows').length - 1;
			datagrid.datagrid('selectRow', editRow);
			datagrid.datagrid('beginEdit', editRow);
			//加载国家信息
			$.ajax({
		   	     url:'${dynamicURL}/basic/countryAction!combox.do',
		   	     dataType:"json",
		   	     success:function(data){
		   	    	 var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'countryId'}).target;
		   	    	 editor_target.combobox('loadData',data);
		   	    	 countryData = editor_target.combobox('getData');
		   	     }
			});
		}
	}
	function del() {
		if (editRow != undefined) {
			datagrid.datagrid('endEdit', editRow);
			return;
		}
		var rows = datagrid.datagrid('getSelections');
		var ids = [];
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].rowId);
					}
					$.ajax({
						url : 'portAction!delete.action',
						data : {
							ids : ids.join(',')
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
			if (editRow != undefined) {
				datagrid.datagrid('endEdit', editRow);
			}

			if (editRow == undefined) {
				editRow = datagrid.datagrid('getRowIndex', rows[0]);
				datagrid.datagrid('beginEdit', editRow);
				datagrid.datagrid('unselectAll');
				//加载国家信息
				$.ajax({
			   	     url:'${dynamicURL}/basic/countryAction!combox.do',
			   	     dataType:"json",
			   	     success:function(data){
			   	    	 var editor_target = $('#datagrid').datagrid('getEditor',{index:editRow,field:'countryId'}).target;
			   	    	 editor_target.combobox('loadData',data);
			   	    	 countryData = editor_target.combobox('getData');
			   	     }
				});
			}
		} else {
			$.messager.show({
				msg : '请选择一项进行修改！',
				title : '错误'
			});
		}
	}
	//模糊查询国家下拉列表
	function _CCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid(
				{
					url : '${dynamicURL}/basic/countryAction!datagrid.do?name='
							+ _CCNTEMP + '&countryCode=' + _CCNCODE
				});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询国家信息输入框
	function _CCNMYCLEAN(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do'
		});
	}
</script>
</head>
<body class="easyui-layout">
	<div class="zoc" region="north" border="false" collapsible="true"
		style="height: 110px; overflow: hidden;">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>港口信息</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
				<div class="item25">
						<div class="itemleft60">港口名称：</div>
						<div class="righttext">
							<input id="portName" name="portName" type="text"
								style="width: 125px" />
						</div>
					</div>
					
					<div class="item25">
						<div class="itemleft60">英文名称：</div>
						<div class="righttext">
							<input id="englishName" name="englishName" type="text"
								style="width: 125px" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">港口编码：</div>
						<div class="righttext">
							<input id="portCode" name="portCode" type="text"
								style="width: 125px" />
						</div>
					</div>
					<div class="item25">
					    <div class="itemleft60">国家：</div>
						<div class="rightselect_easyui">
							<input id="countryCode" name="countryId" class="short50" type="text" />
						</div>				
					</div>
					<div class="item25">
						<div class="itemleft60">是否有效：</div>
						<div class="righttext">
							<select id="activeFlag" name="activeFlag">
								<option value="">全部</option>
								<option value="0">无效</option>
								<option value="1">有效</option>
							</select>
						</div>
					</div>
				</div>
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查  询" onclick="_search();" />
						<input type="button" value="重  置" onclick="cleanSearch();" />
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	
	<!-- 国家下拉选 -->
	<div id="_COUNTRY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="_COUNTRYCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCNMY('_COUNTRYCODE','_COUNTRYINPUT','countryCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('_COUNTRYCODE','_COUNTRYINPUT','countryCode')" />
				</div>
			</div>
		</div>
	</div>

</body>
</html>