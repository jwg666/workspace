<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	//正在办理
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var shipmentRecordAddDialog;
	var shipmentRecordAddForm;
	var cdescAdd;
	var shipmentRecordEditDialog;
	var shipmentRecordEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	var putBackDialog;
	var putBackForm;
	var upLoadExcelDialog; //导入模板Dialog
	var showmessagers;
	var lastIndex;
	$(function() {
		
		
		showmessagers = $('#showmessagers').show().dialog({
			title : '校验提示',
			modal : true,
			closed : true,
			height:300,
			weight:200,
			maximizable : true
		});
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid(
				{
					url : '${dynamicURL}/shipmentRecord/shipmentRecordAction!datagrid0.do?statusFlag=2',
					title : '出运计划备案表列表',
					iconCls : 'icon-save',
					pagination : true,
					pagePosition : 'bottom',
					rownumbers : true,
					pageSize : 10,
					pageList : [ 10, 20, 30, 40 ],
					fit : true,
					fitColumns : false,
					nowrap : true,
					border : false,
					//idField : 'shipmentRecordId',
					//sortName : 'createDt',
					//sortOrder : 'desc',
					frozenColumns : [ [ {
						field : 'ck',
						checkbox : true,
						formatter : function(value, row, index) {
							return row.shipmentRecordId;
						}
					},
					{field:'shipmentRecordId',title:'ROWID',align:'center',width:100,
						formatter:function(value,row,index){
							return row.shipmentRecordId;
						}
					},
					{
						field : 'tradeMode',
						title : '贸易方式',
						align : 'center',
						width : 100,
						sortable : true,
						formatter : function(value, row, index) {
							return row.tradeMode;
						},editor:{
							 type:'text',
							 options:{
							     required:true  
							  }
							  
							}
					}
					, {
						field : 'orderCode',
						title : '订单号',
						align : 'center',
						sortable : true,
						width : 100,
						formatter : function(value, row, index) {
							return row.orderCode;
						}
					},{field:'accountNo',title:'账册号',align:'center',width:100,
						formatter:function(value,row,index){
							return row.accountNo;
						},editor:{
							 type:'text',
							 options:{
							     required:true  
							  }
							  
							}
					},{field:'itemNo',title:'项号',align:'center',width:100,
						formatter:function(value,row,index){
							return row.itemNo;
						},editor:{
							 type:'text',
							 options:{
							     required:true  
							  }
							  
							}
					},{field:'recordMaterialsNo',title:'备案物料号',align:'center',width:100,
						formatter:function(value,row,index){
							return row.recordMaterialsNo;
						},editor:{
							 type:'text',
							 options:{
							     required:true  
							  }
							  
							}
					},{field:'versionNumber',title:'版本号',align:'center',width:100,
						formatter:function(value,row,index){
							return row.versionNumber;
						},editor:{
							 type:'text',
							 options:{
							     required:true  
							  }
							  
							}
					}] ],
					columns : [ [
							{field:'recordName',title:'备案品名',align:'center',width:100,
					formatter:function(value,row,index){
						return row.recordName;
					},editor:{
						 type:'text',
						 options:{
						     required:true  
						  }
						  
						}
				},{field:'commodityCode',title:'商品编码',align:'center',width:100,
					formatter:function(value,row,index){
						return row.commodityCode;
					},editor:{
						 type:'text',
						 options:{
						     required:true  
						  }
						  
						}
				},{field:'specifications',title:'备案规格',align:'center',width:100,
					formatter:function(value,row,index){
						return row.specifications;
					},editor:{
						 type:'text',
						 options:{
						     required:true  
						  }
						  
						}
				}, {
					field : 'acceptTime',
					title : '备案接单时间',
					align : 'center',
					width : 100,
					sortable : true,
					formatter : function(value, row, index) {
						return dateFormatYMD(row.acceptTime);
					},editor:{
						 type:'datebox',
						 options:{
						     required:true  
						  }
						  
						}
				}, {
					field : 'acceptEmpcode',
					title : '接单人',
					width : 100,
					align : 'center',
					sortable : true,
					formatter : function(value, row, index) {
						return row.acceptEmpcode;
					},editor:{
						 type:'text',
						 options:{
						     required:true  
						  }
						  
						}
				}
				,
				{field:'hsCode',title:'物料海关商品编码',align:'center',width:100,
					formatter:function(value,row,index){
						return row.hsCode;
					}
				},
				{field:'prodType',title:'产品大类',align:'center',width:100,
					formatter:function(value,row,index){
						return row.prodType;
					}
				}, {
					field : 'orderType',
					title : '订单类型',
					align : 'center',
					sortable : true,
					width : 100,
					formatter : function(value, row, index) {
						return row.orderType;
					}
				}, {
					field : 'factoryCode',
					title : '生产工厂代码',
					align : 'center',
					sortable : true,
					width : 100,
					formatter : function(value, row, index) {
						return row.factoryCode;
					}
				}, {
					field : 'haierModelCode',
					title : '工厂型号',
					align : 'center',
					width : 100,
					sortable : true,
					formatter : function(value, row, index) {
						return row.haierModelCode;
					}
				}, {
					field : 'customerModelCode',
					title : '客户型号',
					align : 'center',
					sortable : true,
					width : 100,
					formatter : function(value, row, index) {
						return row.customerModelCode;
					}
				} ,

							{
								field : 'salesOrderNo',
								title : '销售订单号',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.salesOrderNo;
								}
							},		
							{field:'materialCode',title:'物料号(套机)',align:'center',width:100,
								formatter:function(value,row,index){
									return row.materialCode;
								}
							},
							{field:'materialCodeWai',title:'外机',align:'center',width:100,
								formatter:function(value,row,index){
									return row.materialCodeWai;
								}
							},
							{field:'materialCodeNei',title:'内机',align:'center',width:200,
								formatter:function(value,row,index){
									return row.materialCodeNei;
								}
							},

							{
								field : 'declarationName',
								title : '报关品名',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.declarationName;
								}
							},
							{
								field : 'parameter',
								title : '参数',
								width : 100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.parameter;
								}
							},
							{
								field : 'quantity',
								title : '数量',
								width : 100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.quantity;
								}
							},
							{
								field : 'price',
								title : '单价',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.price;
								}
							},
							{
								field : 'total',
								title : '总价',
								width : 100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.total;
								}
							},
							{
								field : 'countryCode',
								title : '国家',
								width : 100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.countryCode;
								}
							},
							{
								field : 'clearanceTime',
								title : '报关时间',
								width : 100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.clearanceTime);
								}
							},
							{
								field : 'shipment',
								title : '船期',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.shipment);
								}
							},
							{
								field : 'orderExecution',
								title : '订单执行',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.orderExecution;
								}
							},
							{
								field : 'remarks',
								title : '备注',
								align : 'center',
								width : 100,
								formatter : function(value, row, index) {
									if (row.remarks != null && row.remarks != '') {
										var ra = '';
										if (row.remarks.length > 4) {
											ra = row.remarks.substring(0, 4) + '...';
											return "<a href='javascript:void(0)' id='tooltip_a" + row.shipmentRecordId
													+ "'  style='color:blue' class='easyui-tooltip'  >" + ra + "</a>";
										} else {
											return row.remarks;
										}
									} else {
										return ''
									}
								}
							}, {
								field : 'submitTime',
								title : '提交备案时间',
								align : 'center',
								sortable : true,
								width : 100,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.submitTime);
								}
							}, {
								field : 'clearanceTimeTrue',
								title : '报关完成时间',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.clearanceTimeTrue);
								}
							}, {
								field : 'customsCode',
								title : '报关单号',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.customsCode;
								}
							}, {
								field : 'createDate',
								title : '创建时间',
								width : 100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.createDate);
								}
							}, {
								field : 'createEmpcode',
								title : '创建人',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.createEmpcode;
								}
							}, {
								field : 'lastDate',
								title : '最后修改时间',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.lastDate);
								}
							}, {
								field : 'lastEmpcode',
								title : '最后修改人',
								align : 'center',
								width : 100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.lastEmpcode;
								}
							}, {
								field : 'other',
								title : '其他',
								width : 100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.other;
								}
							} ] ],
					toolbar : [ {
						text : '保存',
						iconCls : 'icon-remove',
						handler : function() {
							save();
						}
					}, '-', {
						text : '取消选中',
						iconCls : 'icon-undo',
						handler : function() {
							datagrid.datagrid('unselectAll');
						}
					}, '-', {
						text : '退回',
						iconCls : 'icon-edit',
						handler : function() {
							putBack();
						}
					}, '-', {
						text : '备案完成',
						iconCls : 'icon-edit',
						handler : function() {
							access();
						}
					}, '-', {
						text : '导入',
						iconCls : 'icon-edit',
						handler : function() {
							importExcel();
						}
					}, '-', {
						text : '导出',
						iconCls : 'icon-edit',
						handler : function() {
							exportExcel();
						}
					} ],
					onLoadSuccess : function(data) {
						$("a[id^='tooltip_a']").tooltip({
							position : 'bottom',
							content : '正在加载...',
							deltaX : 90,
							onShow : function(e) {
								var tooltip = $(this);
								var shipmentRecordId = tooltip.attr("id").replace("tooltip_a", "");
								var aa = getCommenta(shipmentRecordId);
								//alert(dd);
								var messageHtmla = '<div>' + aa + '</div>'
								tooltip.tooltip('update', messageHtmla);
							}
						});
						$("a[id^='tooltip_b']").tooltip({
							position : 'bottom',
							content : '正在加载...',
							deltaX : 90,
							onShow : function(e) {
								var tooltip = $(this);
								var shipmentRecordId = tooltip.attr("id").replace("tooltip_b", "");
								var aa = getCommentb(shipmentRecordId);
								//alert(dd);
								var messageHtmla = '<div>' + aa + '</div>'
								tooltip.tooltip('update', messageHtmla);
							}
						});
					},
					//点击列来开启行编辑或弹出窗口
				 onDblClickRow:function(i,field,value){
					 if(lastIndex!=null&&i!=lastIndex){
						 //行编辑
							datagrid.datagrid('beginEdit', i);
							datagrid.datagrid('endEdit', lastIndex);
						} else {
								datagrid.datagrid('beginEdit', i);
						}
						lastIndex = i;
				}
				});

		shipmentRecordEditForm = $('#shipmentRecordEditForm').form({
			url : 'shipmentRecordAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					shipmentRecordEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		shipmentRecordEditDialog = $('#shipmentRecordEditDialog').show().dialog({
			title : '编辑出运计划备案表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					shipmentRecordEditForm.submit();
				}
			} ]
		});
		putBackForm = $("#putBackForm").form({
			url : 'shipmentRecordAction!putBack.action',
			onSubmit : function() {
			},
			success : function(data) {
				putBackDialog.dialog('close');
				//datagrid.datagrid('load', sy.serializeObject(searchForm));
				window.parent.fshua2and3and4();
			}
		});

		putBackDialog = $('#putBackDialog').dialog({
			title : '退回原因',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '确认退回',
				handler : function() {
					//判断是否填写退回原因
					var returnReason=$('#returnReasonId').val();
					var rows = datagrid.datagrid('getSelections');
					if(rows!=null&&rows.length>0){
						var shipmentList=JSON.stringify(rows);
						$.messager.progress({
							text : '数据加载中....',
							interval : 100
						});
						$.ajax({
							url:'${dynamicURL}/shipmentRecord/shipmentRecordAction!updateReturnByOrderNum.action',
							type:'post',
							data:{
								returnReason:returnReason,
								shipmentList:shipmentList
							},
							dataType:'json',
							success:function(json){
								$.messager.progress('close');
								if(json.success){
									$.messager.alert('提示',json.msg,'info');
									//datagrid.datagrid("reload");
									parent.fshua2and4();
									putBackDialog.dialog('close');
									
								}else{
									$.messager.alert('提示',json.msg,'error');
								}
							}
						});
					}else{
						$.messager.alert('提示','请至少选中一条数据','warring');
					}
				}
			} ]
		});

		uploadExcelDialog = $('#uploadExcelDialog').dialog({
			title : '导入备案信息',
			modal : true,
			closed : true,
			collapsible : true,
			buttons : [ 
			{
				text : '导入',
				handler : function() {
					var fileName = $("#excelFileId").val();
					if ('' === fileName || null == fileName) {
						$.messager.alert('提示', '请选择文件', 'info');
						return;
					} else { 
						var three = fileName.split(".");
						var last = three[three.length - 1];
						if (last == 'xlsx') {
							 $.messager.progress({
								text : '数据加载中....',
								interval : 100
							}); 
							upLoadExcelForm.submit();
						} else {
							$.messager.alert('提示', '文件类型不匹配', 'info');
							return;
						}
					}
				}
			} ]
		});

		//加载导入excel方法
		upLoadExcelForm = $('#upLoadExcelForm').form({
			url : 'shipmentRecordAction!uploadBackInfo.action',
			success : function(data) {
				$.messager.progress('close');
				var json = $.parseJSON(data);
				var obj = json.obj;
				 if (json && json.success) {
					
					 var mmsg=json.msg;
					
					if(mmsg == null||mmsg == ''){
						 var msfs='';
						 var mmeess=obj.split(','); 
						 for(var i=0;i<mmeess.length;i++){
								msfs=msfs+'<tr><td>'+mmeess[i]+'</td></tr>';
							}
						$('#showmessagerid').html(msfs); 
						showmessagers.dialog('open');
					}else{
						$.messager.alert('提示',json.msg,'info');
					}
					window.parent.fshua2and3and4();
					uploadExcelDialog.dialog('close'); 
					//$('#searchForm').form('load', obj);
				} else {
					
					$.messager.alert('提示',json.msg,'error');
				} 
			}
		});
		//加载生产工厂下拉列表
		$('#factoryCodeId').combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0',
			idField : 'deptCode',
			textField : 'deptNameCn',
			panelWidth : 500,
			panelHeight : 235,
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
			}, {
				field : 'deptNameCn',
				title : '生产工厂名称',
				width : 20
			} ] ]
		});
		//加载订单执行经理信息
		$('#orderExecutionId').combogrid({
			url : '${dynamicURL}/viallorderview/viAllOrderViewAction!ddzxdatagrid.action',
			textField : 'NAME',
			idField : 'EMPCODE',
			panelWidth : 500,
			panelHeight : 235,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_ORDER',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'EMPCODE',
				title : '员工编号',
				width : 20
			}, {
				field : 'NAME',
				title : '员工姓名',
				width : 20
			} ] ]
		});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	//根据订单号获得列表中订单的备注
	function getCommenta(shipmentRecordId) {
		var rows = datagrid.datagrid('getRows');
		if (rows != null && rows.length > 0) {
			for ( var i = 0; i < rows.length; i++) {
				if (rows[i].shipmentRecordId == shipmentRecordId) {
					return rows[i].remarks;
				}
			}
		} else {
			return '';
		}
		return '';
	}
	//根据订单号获得列表中订单的退回原因
	function getCommentb(shipmentRecordId) {
		var rows = datagrid.datagrid('getRows');
		if (rows != null && rows.length > 0) {
			for ( var i = 0; i < rows.length; i++) {
				if (rows[i].shipmentRecordId == shipmentRecordId) {
					return rows[i].returnReason;
				}
			}
		} else {
			return '';
		}
		return '';
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							ids = ids + "ids=" + rows[i].shipmentRecordId + "&";
						else
							ids = ids + "ids=" + rows[i].shipmentRecordId;
					}
					$.ajax({
						url : 'shipmentRecordAction!delete.do',
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

	//备案通过
	function access() {
		$.messager.confirm('提示', '确定备案通过?', function(r) {
			if (r) {
				var rows = datagrid.datagrid('getSelections');
				if (rows.length == 0) {
					$.messager.alert('提示', '请选择要退回的记录', 'error');
				} else {
					var ids = '';
					var l = rows.length;
					for ( var i = 0; i < l; i++) {
						if (i == l - 1) {
							ids = ids + "ids=" + rows[i].orderCode;
						} else {
							ids = ids + "ids=" + rows[i].orderCode + "&";
						}
					}
					$.ajax({
						url : 'shipmentRecordAction!completeBack.action',
						data : ids,
						dataType : 'json',
						type : 'post',
						success : function(response) {
							if (response && response.success) {
								$.messager.alert('提示', '操作成功', 'info');
								parent.fshua2and3();
							} else {
								$.messager.alert('提示', '操作失败', 'error');
							}
						}
					});
				}
			}
		});
	}

	//备案退回
	function putBack() {
		//打开一个退回页面，可以书写公共原因
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 0) {
			$.messager.alert('提示', '请选择要退回的记录', 'error')
		} else {
			//把所有的id拼成input
			$("#hiddenDivId").empty();
			for ( var i = 0; i < rows.length; i++) {
				$("#hiddenDivId").append('<input name="ids" value="'+rows[i].shipmentRecordId+'" />')
			}
			putBackDialog.dialog('open');
		}
	}

	function importExcel() {
		uploadExcelDialog.dialog('open');
	}
	/* //备案完成
	function access(){
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 0) {
			$.messager.alert('提示', '请选择要退回的记录', 'error');
		} else {
			var ids=new Array();
			for(var r in rows){
				ids.push(r.shipmentRecordId);
			}
			$.ajax({
				url:'shipmentRecordAction!completeBack.action',
				data:{'ids':ids},
				dataType:'json',
				type:'post',
				success:function(response){
					
				}
			});
		}
	} */
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function exportExcel() {
		$("#searchForm").attr("action", "shipmentRecordAction!exportDealing.action");
		$("#searchForm").submit();
	}
	//模糊查询生产工厂下拉列表
	function _ProductFactoryMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0' + '&deptCode=' + _CCNCODE + '&deptNameCn=' + _CCNTEMP
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询生产工厂输入框
	function _ProductFactoryCLEAN(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.do?deptType=0'
		});
	}
	//模糊查询订单经理下拉列表
	function _getOrderManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/viallorderview/viAllOrderViewAction!ddzxdatagrid.action?name=' + _CCNTEMP + '&empCode=' + _CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询订单经理下拉列表
	function _cleanOrderManager(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/viallorderview/viAllOrderViewAction!ddzxdatagrid.action'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	
	function save(){
		datagrid.datagrid('endEdit', lastIndex);
		var shipMentRows=datagrid.datagrid('getChanges');
		var shipmentList='';
		if(shipMentRows!=null&&shipMentRows.length>0){
			shipmentList=JSON.stringify(shipMentRows);
		}else{
			$.messager.alert('提示','没有需要保存的数据','warring');
			return;
		}
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url:'${dynamicURL}/shipmentRecord/shipmentRecordAction!updateFinishDelings.action',
			type:'post',
			data:{
				shipmentList:shipmentList
			},
			dataType:'json',
			success:function(json){
				$.messager.progress('close');
				if(json.success){
					$.messager.alert('提示',json.msg,'info');
					datagrid.datagrid("reload");
				}else{
					$.messager.alert('提示',json.msg,'error');
				}
			}
		});
      }
	
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" title="过滤条件" collapsed="true"
		style="height: 110px; overflow: hidden;" align="left">
		<div class="part_zoc">
			<form id="searchForm">
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">订单号：</div>
						<div class="righttext">
							<input name="orderCode" id="orderCodeId" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">保税经理：</div>
						<div class="righttext">
							<input name="" id="" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">生产工厂：</div>
						<div class="righttext">
							<input name="factoryCode" id="factoryCodeId" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft">销售订单号：</div>
						<div class="righttext">
							<input name="salesOrderNo" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">船期：</div>
						<div class="righttext">
							<input name="shipment" class="easyui-datebox" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft">订单执行经理：</div>
						<div class="righttext">
							<input name="empCode" id="orderExecutionId" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item100 lastitem">
						<div class="oprationbutt">
							<input type="button" onclick="_search()" value="查询" /> <input
								type="button" onclick="cleanSearch()" value="清空" />
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="putBackDialog" style="width: 500px; height: 200px;"
		align="center">
		<form id="putBackForm" method="post">
			<table>
				<tr>
					<td valign="top">退回原因:</td>
					<td><textarea rows="6" cols="50" name="returnReason"
							id="returnReasonId"></textarea></td>
				</tr>
			</table>
			<div style="visibility: hidden;" id="hiddenDivId"></div>
		</form>
	</div>
	<div id="shipmentRecordEditDialog"
		style="display: none; width: 500px; height: 300px;" align="center">
		<form id="shipmentRecordEditForm" method="post">
			<table class="tableForm">
				<tr>
					<th>ROWID</th>
					<td><input name="shipmentRecordId" type="text"
						class="easyui-validatebox" data-options="required:true"
						missingMessage="请填写ROWID" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>贸易方式</th>
					<td><input name="tradeMode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写贸易方式" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>订单号</th>
					<td><input name="orderCode" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写订单号"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>账册号</th>
					<td><input name="accountNo" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写账册号"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>项号</th>
					<td><input name="itemNo" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写项号"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>备案物料号</th>
					<td><input name="recordMaterialsNo" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写备案物料号" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>版本号</th>
					<td><input name="versionNumber" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写版本号"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>备案品名</th>
					<td><input name="recordName" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写备案品名" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>商品编码</th>
					<td><input name="commodityCode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写商品编码" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>备案规格</th>
					<td><input name="specifications" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写备案规格" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>订单类型</th>
					<td><input name="orderType" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写订单类型" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>生产工厂代码</th>
					<td><input name="factoryCode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写生产工厂代码" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>销售订单号</th>
					<td><input name="salesOrderNo" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写销售订单号" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>物料号</th>
					<td><input name="materialCode" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写物料号"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>工厂型号</th>
					<td><input name="haierModelCode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写工厂型号" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>客户型号</th>
					<td><input name="customerModelCode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写客户型号" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>报关品名</th>
					<td><input name="declarationName" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写报关品名" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>参数</th>
					<td><input name="parameter" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写参数"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>数量</th>
					<td><input name="quantity" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写数量"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>单价</th>
					<td><input name="price" type="text" class="easyui-validatebox"
						data-options="" missingMessage="请填写单价" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>总价</th>
					<td><input name="total" type="text" class="easyui-validatebox"
						data-options="" missingMessage="请填写总价" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>国家</th>
					<td><input name="countryCode" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写国家"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>报关时间</th>
					<td><input name="clearanceTime" type="text"
						class="easyui-datebox" data-options="" missingMessage="请填写报关时间"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>船期</th>
					<td><input name="shipment" type="text" class="easyui-datebox"
						data-options="" missingMessage="请填写船期" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>订单执行</th>
					<td><input name="orderExecution" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写订单执行" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>备注</th>
					<td><input name="remarks" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写备注"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>提交备案时间</th>
					<td><input name="submitTime" type="text"
						class="easyui-datebox" data-options="" missingMessage="请填写提交备案时间"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>备案接单时间</th>
					<td><input name="acceptTime" type="text"
						class="easyui-datebox" data-options="" missingMessage="请填写备案接单时间"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>接单人</th>
					<td><input name="acceptEmpcode" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写接单人"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>备案完成时间</th>
					<td><input name="recordEndTime" type="text"
						class="easyui-datebox" data-options="" missingMessage="请填写备案完成时间"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>报关完成时间</th>
					<td><input name="customsEndDate" type="text"
						class="easyui-datebox" data-options="" missingMessage="请填写报关完成时间"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>报关单号</th>
					<td><input name="customsCode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写报关单号" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>退回时间</th>
					<td><input name="returnDate" type="text"
						class="easyui-datebox" data-options="" missingMessage="请填写退回时间"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>退回原因</th>
					<td><input name="returnReason" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写退回原因" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>退回人</th>
					<td><input name="returnEmpcode" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写退回人"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>异常确认时间</th>
					<td><input name="unusualConfirmDate" type="text"
						class="easyui-datebox" data-options="" missingMessage="请填写异常确认时间"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>异常确认原因</th>
					<td><input name="unusualConfirmReason" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写异常确认原因" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>异常确认人</th>
					<td><input name="unusualConfirmEmpcode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写异常确认人" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>状态标志</th>
					<td><input name="statusFlag" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写状态标志" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>创建时间</th>
					<td><input name="createDate" type="text"
						class="easyui-datebox" data-options="" missingMessage="请填写创建时间"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>创建人</th>
					<td><input name="createEmpcode" type="text"
						class="easyui-validatebox" data-options="" missingMessage="请填写创建人"
						style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>最后修改时间</th>
					<td><input name="lastDate" type="text" class="easyui-datebox"
						data-options="" missingMessage="请填写最后修改时间" style="width: 155px;" />
					</td>
				</tr>
				<tr>
					<th>最后修改人</th>
					<td><input name="lastEmpcode" type="text"
						class="easyui-validatebox" data-options=""
						missingMessage="请填写最后修改人" style="width: 155px;" /></td>
				</tr>
				<tr>
					<th>其他</th>
					<td><input name="other" type="text" class="easyui-validatebox"
						data-options="" missingMessage="请填写其他" style="width: 155px;" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="showCdescDialog"
		style="display: none; overflow: auto; width: 500px; height: 400px;">
		<div name="cdesc"></div>
	</div>

	<div id="uploadExcelDialog" style="width: 400px; height: 100px;"
		align="center">
		<form id="upLoadExcelForm" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<th>导入备案信息:</th>
					<td><s:file id="excelFileId" name="excelFile"></s:file></td>
				</tr>
			</table>
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
						onclick="_ProductFactoryMY('_PFACTORYCODE','_PFACTORYNAME','factoryCodeId')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_ProductFactoryCLEAN('_PFACTORYCODE','_PFACTORYNAME','factoryCodeId')" />
				</div>
			</div>
		</div>
	</div>
	<!-- 订单经理下拉选信息 -->
	<div id="_ORDER">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_ORDERMANAGERCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">订单经理：</div>
				<div class="righttext">
					<input class="short60" id="_ORDERMANAGERINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getOrderManager('_ORDERMANAGERCODE','_ORDERMANAGERINPUT','orderExecutionId')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanOrderManager('_ORDERMANAGERCODE','_ORDERMANAGERINPUT','orderExecutionId')" />
				</div>
			</div>
		</div>
	</div>
	
	<div id="showmessagers" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="auditLogAddForm" method="post">
		    <input type="hidden" name="taskIdOfaudit" id="taskIdOfauditId"/>
			<table class="table2" cellpadding="0" cellspacing="0"  id="showmessagerid" border="1">
			</table>
		</form>
	</div>
</body>
</html>