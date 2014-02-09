<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var showUploadTemplateDialog;
    var showUploadTemplateForm;
	var searchForm;
	var datagrid;
	var billOrderAddDialog;
	var billOrderAddForm;
	var cdescAdd;
	var billOrderEditDialog;
	var billOrderEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	var lastIndex = 0;

	var startPorts;
	var destPorts;
	var carriers;
	$(function() {
		showUploadTemplateDialog = $('#uploadTemplateDialog').show().dialog({
			title : '上传附件',
			modal : true,
			closed : true,
			collapsible : true,
			buttons : [ {
				text : '上传',
				handler : function() {
					showUploadTemplateForm.submit();
				}
			} ]
		});
		
	 showUploadTemplateForm = $('#uploadTemplateForm').form({
			url : '${dynamicURL}/shipOrder/billOrderAction!saveOrUpdateBillOrders.action',
			success : function(data) {
				var json = $.parseJSON(data);
				var obj = json.obj;
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
				} else {
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
				datagrid.datagrid('reload');
				showUploadTemplateDialog.dialog('close');
			}
		});
		/* //加载下拉框数据
		$.ajax({
			url : '${dynamicURL}/basic/sysLovAction!combox.action?itemType=17',
			type : 'post',
			dataType : 'json',
			async : false,
			success : function(response) {
				startPorts = response;
				//$('#datagrid').datagrid('reload');
			}
		});
		$.ajax({
			url : '${dynamicURL}/basic/portAction!combox.action?activeFlag=1',
			type : 'post',
			dataType : 'json',
			async : false,
			success : function(response) {
				destPorts = response;
				$("#destPort").combobox('loadData', destPorts);
			}
		});
		$.ajax({
			url : '${dynamicURL}/basic/vendorAction!combox.action?vendorType=0&activeFlag=1',
			type : 'post',
			async : false,
			dataType : 'json',
			success : function(response) {
				carriers = response;
				$("#carrier").combobox('loadData', carriers);
			}
		}); */
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'billOrderAction!datagridNew.do',
			title : '提单信息表列表',
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
			idField : 'billCode',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.billCode;
				}
			}, {
				field : 'billCode',
				title : '提单唯一标识',
				align : 'center',
				hidden : true,
				sortable : true,
				formatter : function(value, row, index) {
					return row.billCode;
				}
			}, {
				field : 'billNum',
				title : '提单号',
				width : 20,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.billNum;
				}
			}, {
				field : 'orderNum',
				title : '订单号',
				width : 20,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			}, {
				field : 'bookCode',
				title : '订舱号',
				width : 20,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.bookCode;
				}
			}, {
				field : 'startPort',
				title : '始发港',
				width : 20,
				align : 'center',
				sortable : true
			}, {
				field : 'destPort',
				title : '目的港',
				align : 'center',
				width : 20,
				sortable : true
			}, {
				field : 'carrier',
				title : '船公司',
				align : 'center',
				width : 20,
				sortable : true
			}, {
				field : 'shipDate',
				title : '出运时间',
				width : 20,
				align : 'center',
				sortable : true
			}, {
				field : 'fileName',
				title : '附件名称',
				width : 20,
				align : 'center',
				sortable : true
			}, {
				field : 'takeBillDate',
				title : '提单回收时间',
				align : 'center',
				width : 20,
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.takeBillDate);
				}
			}, {
				field : 'releaseDate',
				title : '放单时间',
				width : 20,
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.releaseDate);
				}
			} ] ],
			toolbar : [ 
            <s:if test='billEmployee=="yes"'>            
			{
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					//弹出增加窗口
					add();
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					//弹出修改窗口
					edit();
				}
			}, '-', {
				text : '上传附件',
				iconCls : 'icon-edit',
				handler : function() {
					//弹出修改窗口
					upfile();
				}
			}, '-', 
			</s:if>
			{
				text : '下载附件',
				iconCls : 'icon-edit',
				handler : function() {
					//弹出修改窗口
					downfile();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ]
		});

		billOrderAddForm = $('#billOrderAddForm').form({
			url : 'billOrderAction!addOrUpdate.do',
			success : function(data) {
			    $.messager.progress('close');
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					billOrderAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			},
			onSubmit:function(){
			    if(billOrderAddForm.form('validate')){
			    	$.messager.progress();
			    }else{
					return false;
			    }
			}
		});

		billOrderAddDialog = $('#billOrderAddDialog').show().dialog({
			title : '添加提单信息表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '保存',
				handler : function() {
					billOrderAddForm.submit();
				}
			} ]
		});

		billOrderEditForm = $('#billOrderEditForm').form({
			url : 'billOrderAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					billOrderEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		billOrderEditDialog = $('#billOrderEditDialog').show().dialog({
			title : '编辑提单信息表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '保存',
				handler : function() {
					billOrderEditForm.submit();
				}
			} ]
		});

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '提单信息表描述',
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
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function add() {
		billOrderAddForm.form("clear");
		$('div.validatebox-tip').remove();
		//初始化下拉框
		billOrderAddDialog.dialog('open');
	}

	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			var r = rows[0];
			$.ajax({
				url : 'billOrderAction!showDesc.action',
				data : {
					billCode : r.billCode
				},
				dataType : 'json',
				type : 'post',
				success : function(data) {
					billOrderEditForm.form('load', data);
					//初始化下拉框的值
					$("#carrier1").combogrid({url:'${dynamicURL}/basic/vendorAction!datagrid.action?vendorCode='+data.carrier});
					$("#carrier1").combogrid('setValue',data.carrier);
					$("#destPort1").combogrid({url:'${dynamicURL}/basic/portAction!datagrid.do?portCode='+data.destPort});
					$("#destPort1").combogrid('setValue',data.destPort);
					
					billOrderEditDialog.dialog('open');
					
					$('#orderDatagrid').datagrid({
						url : 'billOrderAction!getorderBybillNum.action?billCode='+r.billCode,
						title : '提单下订单信息',
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
						idField : 'billCode',
						
						columns : [ [
						    {
							field : 'orderNum',
							title : '订单号',
							width : 20,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return row.orderNum;
							}
						},{
							field : 'billNum',
							title : '提单号',
							width : 20,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return row.billNum;
							}
						}, {
							field : 'startPort',
							title : '始发港',
							width : 20,
							align : 'center',
							sortable : true
						}, {
							field : 'destPort',
							title : '目的港',
							align : 'center',
							width : 20,
							sortable : true
						}, {
							field : 'carrier',
							title : '船公司',
							align : 'center',
							width : 20,
							sortable : true
						} ] ]
					});
					
					$.messager.progress('close');
				},
				beforeSend : function() {
					$.messager.progress();
				}
			});
		} else {
			$.messager.alert('提示', '请选择一条提单记录', 'warning');
		}
	}
	//没有删除功能，维护上放单时间就代表提单已经删除----保留函数
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							ids = ids + "ids=" + rows[i].billCode + "&";
						else
							ids = ids + "ids=" + rows[i].billCode;
					}
					$.ajax({
						url : 'billOrderAction!delete.do',
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

	function showCdesc(index) {
		var rows = datagrid.datagrid('getRows');
		var row = rows[index];
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url : 'billOrderAction!showDesc.do',
			data : {
				billCode : row.billCode
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有提单信息表描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	
	
	//模糊查询船公司下拉列表
	function _VENDORMY(inputId,inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/vendorAction!datagrid.action?vendorNameCn=' + _CCNTEMP+'&vendorCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询船公司信息输入框
	function _VENDORMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/vendorAction!datagrid.action'
				});
	}
	
	//模糊查询目的港下拉列表
	function _PORTMY(inputId,inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/portAction!datagrid.do?englishName=' + _CCNTEMP+'&portCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//上传附件
	function upfile(){
		var rows = datagrid.datagrid('getSelections');
		var billCodes='';
		if(rows!=null&&rows.length>0){
			for(var i=0;i<rows.length;i++){
				if(i==0){
					billCodes=rows[i].billCode;
				}else{
					billCodes=billCodes+','+rows[i].billCode;
				}
			}
			$('#filebillNumId').val(billCodes);
			showUploadTemplateDialog.dialog("open");
		}else{
			$.messager.alert('提示','请至少选中一条数据','warring');
		}
		
	}
	//下载附件
	function downfile(){
		var rows = datagrid.datagrid('getSelections');
		if(rows!=null&&rows.length==1){
			var fileId=rows[0].attachments;
			if(fileId==null||fileId==''){
				$.messager.alert('提示','该提单没有附件','warring');
			}else{
				var downloadfile=$('#downloadfile');
				var url1='${dynamicURL}/basic/downloadFile!downloadFile.action?fileId='+fileId;
				downloadfile.attr("href",url1);
				downloadfile[0].click();
			}

		}else{
			$.messager.alert('提示','只能选中一条数据','warring');
		}
	}
</script>
</head>
<body class="easyui-layout zoc">
    <a href="${dynamicURL}/basic/downloadFile!downloadFile.action" id="downloadfile"></a> 
	<div region="north" border="false" title="过滤条件" collapsed="true"
		style="height: 110px; overflow: hidden;" align="left">
		<form id="searchForm">
			<div class="part_zoc">
				<div class="oneline">
					<div class="item25">
						<div class="itemleft80" >提单号：</div>
						<div class="righttext">
							<input name="billNum"  type="text" class="short50" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80" >订单号：</div>
						<div class="righttext">
							<input name="orderNum"  type="text" class="short50" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80" >订舱号：</div>
						<div class="righttext">
							<input name="bookCode"  type="text" class="short50" />
						</div>
					</div>
					<div class="item25 lastitem">
						<div class="itemleft80">目的港：</div>
						<div class="righttext">
							<input type="text" id="destPort" class="easyui-combogrid short50"
								name="destPort"
								data-options="url:'${dynamicURL}/basic/portAction!datagrid.action',
								idField:'portCode',  
							    textField:'portName',
								panelWidth : 500,
								panelHeight : 220,
								pagination : true,
								pagePosition : 'bottom',
								toolbar : '#_PORTEND',
								rownumbers : true,editable:false,
								pageSize : 5,
								pageList : [ 5, 10 ],
								fit : true,
								fitColumns : true,
								columns : [ [ {
									field : 'portCode',
									title : '目的港编码',
									width : 20
								},{
									field : 'portName',
									title : '目的港名称',
									width : 20
								}]]" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft80">船公司：</div>
						<div class="righttext">
							<input  name="carrier" type="text" id="carrier"
								class="easyui-combogrid short50" data-options="
								url:'${dynamicURL}/basic/vendorAction!datagrid.action',
			 idField:'vendorCode',  
			 textField:'vendorNameCn',
		     panelWidth : 500,
			 panelHeight : 220,
			 pagination : true,
			 pagePosition : 'bottom',
			 toolbar : '#_VENDOR',
			 rownumbers : true,
			 pageSize : 5,
			 pageList : [ 5, 10 ],
			 fit : true,
			 fitColumns : true,
			 editable : false,
			 columns : [ [ {
				field : 'vendorCode',
				title : '运输公司编码',
				width : 20
			 },{
				field : 'vendorNameCn',
				title : '运输公司名称',
				width : 20
			 }  ] ]"
								 />
						</div>
					</div>
					<div class="item25 lastitem">
						<div class="itemleft80">出运时间从：</div>
						<div class="righttext">
							<input type="text" class="easyui-datebox  short50" name="shipDate" /> 
						</div>
					</div>
					<div class="item25 lastitem">
						<div class="itemleft80">到：</div>
						<div class="righttext">
							<input type="text" class="easyui-datebox short50" name="shipDate2" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item100">
						<div class="oprationbutt">
							<input type="button" value="查询" onclick="_search()" /> <input
								type="button" onclick="cleanSearch()" value="清空" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	<div id="billOrderAddDialog"
		style="display: none; width: 1015px; height: 250px;" align="center">
		<form id="billOrderAddForm" method="post">
			<div class="part_zoc">
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">提单号：</div>
						<div class="righttext">
							<input name="billNum" id="billNum0" type="text"
								class="easyui-validatebox" data-options="required:true"
								missingMessage="请填写提单号" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">始发港：</div>
						<div class="righttext">
							<input name="startPort" type="text" id="startPort0"
								class="easyui-combobox"
								data-options="url : '${dynamicURL}/basic/sysLovAction!combox.action?itemType=17',
						valueField : 'itemCode',
						textField : 'itemNameCn',
						required : true,editable:false,
						missingMessage : '请选择始发港'"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">目的港：</div>
						<div class="righttext">
							<input name="destPort" type="text" id="destPort0" class="easyui-combogrid"
								data-options="url:'${dynamicURL}/basic/portAction!datagrid.action',
								idField:'portCode',  
							    textField:'portName',
								panelWidth : 500,
								panelHeight : 220,
								pagination : true,
								pagePosition : 'bottom',
								toolbar : '#_PORTEND0',
								rownumbers : true,
								pageSize : 5,
								required:true,editable:false,
								missingMessage:'请选择目的港',
								pageList : [ 5, 10 ],
								fit : true,
								fitColumns : true,
								columns : [ [ {
									field : 'portCode',
									title : '目的港编码',
									width : 20
								},{
									field : 'portName',
									title : '目的港名称',
									width : 20
								}]]"
								 style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">船公司：</div>
						<div class="righttext">
							<input name="carrier" type="text" id="carrier0" class="easyui-combogrid"
								data-options="url:'${dynamicURL}/basic/vendorAction!datagrid.action',
								 idField:'vendorCode',  
								 textField:'vendorNameCn',
							     panelWidth : 500,
								 panelHeight : 220,
								 pagination : true,
								 pagePosition : 'bottom',
								 toolbar : '#_VENDOR0',
								 rownumbers : true,
								 pageSize : 5,
								 pageList : [ 5, 10 ],
								 fit : true,
								 required:true,
								 fitColumns : true,missingMessage:'请选择船公司',
								 editable : false,
								 columns : [ [ {
									field : 'vendorCode',
									title : '运输公司编码',
									width : 20
								 },{
									field : 'vendorNameCn',
									title : '运输公司名称',
									width : 20
								 }  ] ]"
								 style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">出运时间：</div>
						<div class="righttext">
							<input name="shipDate" type="text" id="shipDate0"
								class="easyui-datebox" data-options="required:true"
								missingMessage="请填写出运时间" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">提单回收时间：</div>
						<div class="righttext">
							<input name="takeBillDate" type="text" id="takeBillDate0"
								class="easyui-datebox" style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">放单时间：</div>
						<div class="righttext">
							<input name="releaseDate" type="text" id="releaseDate0"
								class="easyui-datebox" style="width: 155px;" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div id="billOrderEditDialog"
		style="display: none; width: 1200px; height: 500px;" align="center">
		<div region="north" border="false" title="提单信息" collapsed="false"
		style="height: 100px; overflow: hidden;" align="left">
		<form id="billOrderEditForm" method="post">
			<div class="part_zoc">
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">提单号：</div>
						<div class="righttext">
							<input name="billNum" id="billNum1" type="text"
								class="easyui-validatebox" data-options="required:true"
								missingMessage="请填写提单号" style="width: 155px;" /> <input
								type="hidden" name="billCode" />
								<input type="hidden" name="billNumbeBefor" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">始发港：</div>
						<div class="righttext">
							<input name="startPort" type="text" id="startPort1"
								class="easyui-combobox"
								data-options="url : '${dynamicURL}/basic/sysLovAction!combox.action?itemType=17',
						valueField : 'itemCode',
						textField : 'itemNameCn',
						required : true,editable:false,
						missingMessage : '请选择始发港'"
								style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">目的港：</div>
						<div class="righttext">
							<input name="destPort" type="text" id="destPort1" class="easyui-combogrid"
								data-options="url:'${dynamicURL}/basic/portAction!datagrid.action',
								idField:'portCode',  
							    textField:'portName',
								panelWidth : 500,
								panelHeight : 220,
								pagination : true,
								pagePosition : 'bottom',
								toolbar : '#_PORTEND1',
								rownumbers : true,editable:false,
								pageSize : 5,
								required:true,
								missingMessage:'请选择目的港',
								pageList : [ 5, 10 ],
								fit : true,
								fitColumns : true,
								columns : [ [ {
									field : 'portCode',
									title : '目的港编码',
									width : 20
								},{
									field : 'portName',
									title : '目的港名称',
									width : 20
								}]]"  style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">船公司：</div>
						<div class="righttext">
							<input name="carrier" type="text" id="carrier1" class="easyui-combogrid"
								data-options="url:'${dynamicURL}/basic/vendorAction!datagrid.action',
			 idField:'vendorCode',  
			 textField:'vendorNameCn',
		     panelWidth : 500,
			 panelHeight : 220,
			 pagination : true,
			 pagePosition : 'bottom',
			 toolbar : '#_VENDOR1',
			 rownumbers : true,
			 pageSize : 5,
			 pageList : [ 5, 10 ],
			 fit : true,
			 fitColumns : true,
			 editable : false,
			 missingMessage:'请选择船公司',
			 required:true,
			 columns : [ [ {
				field : 'vendorCode',
				title : '运输公司编码',
				width : 20
			 },{
				field : 'vendorNameCn',
				title : '运输公司名称',
				width : 20
			 }  ] ]"
								 style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">出运时间：</div>
						<div class="righttext">
							<input name="shipDate" type="text" id="shipDate1"
								class="easyui-datebox" data-options="required:true"
								missingMessage="请填写出运时间" style="width: 155px;" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">提单回收时间：</div>
						<div class="righttext">
							<input name="takeBillDate" type="text" id="takeBillDate1"
								class="easyui-datebox" style="width: 155px;" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">放单时间：</div>
						<div class="righttext">
							<input name="releaseDate" type="text" id="releaseDate1"
								class="easyui-datebox" style="width: 155px;" />
						</div>
					</div>
				</div>
			</div>
		</form>
		</div>
			<div region="center" border="false" style="height: 300px;">
			    <table id="orderDatagrid"></table>
		    </div>
	</div>
<!-- 船公司下拉选信息 -->
	<div id="_VENDOR">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">运输公司编号：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">运输公司名称：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_VENDORMY('_VENDORCODE','_VENDORNAME','carrier')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_VENDORMYCLEAN('_VENDORCODE','_VENDORNAME','carrier')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_VENDOR0">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">运输公司编号：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORCODE0" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">运输公司名称：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORNAME0" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_VENDORMY('_VENDORCODE0','_VENDORNAME0','carrier0')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_VENDORMYCLEAN('_VENDORCODE0','_VENDORNAME0','carrier0')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_VENDOR1">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">运输公司编号：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORCODE1" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">运输公司名称：</div>
				<div class="righttext">
					<input class="short50" id="_VENDORNAME1" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_VENDORMY('_VENDORCODE1','_VENDORNAME1','carrier1')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_VENDORMYCLEAN('_VENDORCODE1','_VENDORNAME1','carrier1')" />
				</div>
			</div>
		</div>
	</div>
	
	<!-- 目的港下拉选信息 -->
	<div id="_PORTEND">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">目的港编号：</div>
				<div class="righttext">
					<input class="short50" id="_PORTCODEINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">目的港：</div>
				<div class="righttext">
					<input class="short60" id="_PORTINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_PORTMY('_PORTCODEINPUT','_PORTINPUT','destPort')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_PORTMYCLEAN('_PORTCODEINPUT','_PORTINPUT','destPort')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_PORTEND0">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">目的港编号：</div>
				<div class="righttext">
					<input class="short50" id="_PORTCODEINPUT0" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">目的港：</div>
				<div class="righttext">
					<input class="short60" id="_PORTINPUT0" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_PORTMY('_PORTCODEINPUT0','_PORTINPUT0','destPort0')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_PORTMYCLEAN('_PORTCODEINPUT0','_PORTINPUT0','destPort0')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_PORTEND1">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">目的港编号：</div>
				<div class="righttext">
					<input class="short50" id="_PORTCODEINPUT1" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">目的港：</div>
				<div class="righttext">
					<input class="short60" id="_PORTINPUT1" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_PORTMY('_PORTCODEINPUT1','_PORTINPUT1','destPort1')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_PORTMYCLEAN('_PORTCODEINPUT1','_PORTINPUT1','destPort1')" />
				</div>
			</div>
		</div>
	</div>
	<div id="uploadTemplateDialog" style="margin-top: 1%; width: 500px;">
		<form id="uploadTemplateForm" method="post"
			enctype="multipart/form-data">
			<input name="billCodes" id="filebillNumId" type="hidden"/>
			<table class="tableForm">
				<tr style="margin-top: 3%">
				    
					<th>选择上传的附件:</th>
					<td><s:file name="upload"></s:file></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>