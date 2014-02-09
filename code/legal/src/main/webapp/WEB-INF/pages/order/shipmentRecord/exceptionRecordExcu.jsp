<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	//异常
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
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid(
				{
					url : '${dynamicURL}/shipmentRecord/shipmentRecordAction!datagrid2.do?statusFlag=4',
					title : '异常信息列表',
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
					}, {
						field : 'orderCode',
						title : '订单号',width:100,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.orderCode;
						}
					}, {
						field : 'orderType',
						title : '订单类型',width:100,
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.orderType;
						}
					}, {
						field : 'haierModelCode',
						title : '工厂型号',
						align : 'center',width:100,
						sortable : true,
						formatter : function(value, row, index) {
							return row.haierModelCode;
						}
					}, {
						field : 'customerModelCode',
						title : '客户型号',
						align : 'center',width:100,
						sortable : true,
						formatter : function(value, row, index) {
							return row.customerModelCode;
						}
					}, {
						field : 'haierModelCode',
						title : '工厂型号',
						align : 'center',width:100,
						sortable : true,
						formatter : function(value, row, index) {
							return row.haierModelCode;
						}
					}, {
						field : 'customerModelCode',
						title : '客户型号',
						align : 'center',
						sortable : true,width:100,
						formatter : function(value, row, index) {
							return row.customerModelCode;
						}
					}, {
						field : 'haierModelCode',
						title : '工厂型号',
						align : 'center',
						sortable : true,width:100,
						formatter : function(value, row, index) {
							return row.haierModelCode;
						}
					} ] ],
					columns : [ [
							{
								field : 'shipmentRecordId',
								title : 'ROWID',
								align : 'center',
								sortable : true,
								hidden : true,width:100,
								formatter : function(value, row, index) {
									return row.shipmentRecordId;
								}
							},
							{
								field : 'recordName',
								title : '备案品名',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.recordName;
								}
							},
							{
								field : 'orderType',
								title : '订单类型',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.orderType;
								}
							},
							{
								field : 'salesOrderNo',
								title : '销售订单号',
								align : 'center',
								sortable : true,width:100,
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
								field : 'customerModelCode',
								title : '客户型号',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.customerModelCode;
								}
							},
							{
								field : 'declarationName',
								title : '报关品名',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.declarationName;
								}
							},
							{
								field : 'parameter',
								title : '参数',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.parameter;
								}
							},
							{
								field : 'quantity',
								title : '数量',width:100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.quantity;
								}
							},
							{
								field : 'price',
								title : '单价',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.price;
								}
							},
							{
								field : 'total',
								title : '总价',width:100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.total;
								}
							},
							{
								field : 'countryCode',
								title : '国家',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.countryCode;
								}
							},
							{
								field : 'clearanceTime',
								title : '报关时间',width:100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.clearanceTime);
								}
							},
							{
								field : 'shipment',
								title : '船期',width:100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.shipment);
								}
							},
							{
								field : 'orderExecution',
								title : '订单执行',width:100,
								align : 'center',
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
							},
							{
								field : 'submitTime',
								title : '提交备案时间',
								align : 'center',
								sortable : true,width:100,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.submitTime);
								}
							},
							{
								field : 'acceptTime',
								title : '备案接单时间',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.acceptTime);
								}
							},
							{
								field : 'acceptEmpcode',
								title : '接单人',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.acceptEmpcode;
								}
							},
							{
								field : 'returnDate',
								title : '退回时间',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.returnDate);
								}
							},
							{
								field : 'returnReason',
								title : '退回原因',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									if (row.returnReason != null && row.returnReason != '') {
										var ra = '';
										if (row.returnReason.length > 4) {
											ra = row.returnReason.substring(0, 4) + '...';
											return "<a href='javascript:void(0)' id='tooltip_b" + row.shipmentRecordId
													+ "'  style='color:blue' class='easyui-tooltip'  >" + ra + "</a>";
										} else {
											return row.returnReason;
										}
									} else {
										return ''
									}
								}
							}, {
								field : 'returnEmpcode',
								title : '退回人',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.returnEmpcode;
								}
							}, {
								field : 'createDate',
								title : '创建时间',width:100,
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.createDate);
								}
							}, {
								field : 'createEmpcode',
								title : '创建人',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.createEmpcode;
								}
							}, {
								field : 'lastDate',
								title : '最后修改时间',
								align : 'center',
								sortable : true,width:100,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.lastDate);
								}
							}, {
								field : 'lastEmpcode',
								title : '最后修改人',
								align : 'center',width:100,
								sortable : true,
								formatter : function(value, row, index) {
									return row.lastEmpcode;
								}
							}, {
								field : 'other',
								title : '其他',
								align : 'center',
								sortable : true,
								formatter : function(value, row, index) {
									return row.other;
								}
							} ] ],
					toolbar : [ {
						text : '取消选中',
						iconCls : 'icon-undo',
						handler : function() {
							datagrid.datagrid('unselectAll');
						}
					}, '-', {
						text : '导出',
						iconCls : 'icon-edit',
						handler : function() {
							exportExcel();
						}
					}, '-', {
						text : '异常处理',
						iconCls : 'icon-edit',
						handler : function() {
							rollBack();
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
			url : 'shipmentRecordAction!confirmExceptionBack.action',
			onSubmit : function() {
			},
			success : function(data) {
				putBackDialog.dialog('close');
				datagrid.datagrid('load', sy.serializeObject(searchForm));
			}
		});

		putBackDialog = $('#putBackDialog').dialog({
			title : '确认异常原因',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '确认异常',
				handler : function() {
					if ($("#unusualConfirmReasonId").val() == '') {
						$.messager.confirm('提示', '没有填写处理意见，是否继续？', function(r) {
							if (r) {
								putBackForm.submit();
							}
						});
					}
					putBackForm.submit();
				}
			} ]
		});

		uploadExcelDialog = $('#uploadExcelDialog').dialog({
			title : '导入备案信息',
			modal : true,
			closed : true,
			collapsible : true,
			buttons : [ /* {
			            																			text : '下载导入模板',
			            																			handler : function() {
			            																				window.location.href = "${dynamicURL}/basic/fileUploadAction/downloadFileByItemCode.do?itemCode=KDBIDINFO";
			            																				return false;
			            																			}
			            																		},  */{
				text : '导入',
				handler : function() {
					var fileName = $("#excleFile").val();
					if ('' === fileName || null == fileName) {
						$.messager.alert('提示', '请选择文件', 'info');
						return;
					} else {
						//var r =/\.[^\.]+/.exec(fileName);
						// 						 if('.xls'==r ||'.xlsx'==r || '.xlsm'==r || '.xlsb'==r ){
						// 							upLoadExcelForm.submit();  
						var three = fileName.split(".");
						var last = three[three.length - 1];
						if (last == 'xlsx') {
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
				var json = $.parseJSON(data);
				var obj = json.obj;
				if (json && json.success) {
					$.messager.progress('close');
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('load');
					uploadExcelDialog.dialog('close');
					// 					$('#searchForm').form('load', obj);
				} else {
					$.messager.progress('close');
					$.messager.show({
						title : '失败',
						msg : json.msg
					});
				}
			}
		});
	});
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	//根据订单好获得列表中订单的备注
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
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 0) {
			$.messager.alert('提示', '请选择要退回的记录', 'error');
		} else {
			var ids = '';
			var l = rows.length;
			for ( var i = 0; i < l; i++) {
				if (i == l - 1) {
					ids = ids + "ids=" + rows[i].shipmentRecordId;
				} else {
					ids = ids + "ids=" + rows[i].shipmentRecordId + "&";
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
					} else {
						$.messager.alert('提示', '操作失败', 'error');
					}
				}
			});
		}
	}

	//备案退回
	function putBack() {
		//打开一个退回页面，可以书写公共原因
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 0) {
			$.messager.alert('提示', '请选择要确认异常的记录', 'error')
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
	function exportExcel() {
		$("#searchForm").attr("action", "shipmentRecordAction!exportExceptionEx.action");
		$("#searchForm").submit();
	}
	//重做，退回到未备案
	function rollBack() {
		//弹出退回原因填写框
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 0) {
			$.messager.alert('提示', '请选择要确认的记录', 'error')
		} else {

			//把所有的id拼成input
			$("#hiddenDivId").empty();
			for ( var i = 0; i < rows.length; i++) {
				$("#hiddenDivId").append('<input name="ids" value="'+rows[i].shipmentRecordId+'" />')
			}
			putBackDialog.dialog('open');
		}
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
							<input name="empCode" value="${empCode}" type="hidden" />
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

	<div id="showCdescDialog"
		style="display: none; overflow: auto; width: 500px; height: 400px;">
		<div name="cdesc"></div>
	</div>
	<div id="putBackDialog" style="width: 500px; height: 200px;"
		align="center">
		<form id="putBackForm" method="post">
			<table>
				<tr>
					<td valign="top">异常确认原因:</td>
					<td><textarea rows="6" cols="50" name="unusualConfirmReason"
							id="unusualConfirmReasonId"></textarea></td>
				</tr>
			</table>
			<div style="visibility: hidden;" id="hiddenDivId"></div>
		</form>
	</div>
</body>
</html>