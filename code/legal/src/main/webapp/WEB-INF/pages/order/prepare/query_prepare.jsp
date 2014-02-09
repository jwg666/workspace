<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var cdescAdd;
	var cdescEdit;
	var showCdescDialog;
	var prepareOrderDetailDialog; //明细Dialog
	var iframeDialog;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		//产品大类下拉框
	  $('#prodType').combogrid({
			url : '${dynamicURL}/basic/prodTypeAction!datagrid.action',
			idField : 'prodType',
			textField : 'prodType',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_PRODTYPESELECT',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ {
				field : 'prodTypeCode',
				title : '产品大类编号',
				width : 10
			}, {
				field : 'prodType',
				title : '产品大类名称',
				width : 10
			} ] ]
		});
	
	//产品经理
		$('#managerName').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do',
			textField : 'empName',
			idField : 'empName',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_PROD',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			editable : false,
			columns : [ [ {
				field : 'empCode',
				title : '员工编号',
				width : 20
			},{
				field : 'empName',
				title : '员工姓名',
				width : 20
			}  ] ]
		}); 
		//加载经营体信息
		$('#deptCode').combogrid({
			url:'${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=1',
			idField:'deptNameCn',  
		    textField:'deptNameCn',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_DEPTHISTORY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'deptCode',
				title : '经营体编号',
				width : 20
			},{
				field : 'deptNameCn',
				title : '经营体名称',
				width : 20
			}  ] ]
		});
		
		datagrid = $('#datagrid').datagrid({
			url : 'queryPrepareAction!datagrid.do',
			title : '备货单查询',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			singleSelect : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			//fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'actPrepareCode',
			
			frozenColumns : [ [
					{
						field : 'actPrepareCode',
						title : '备货单号',
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return '<a onclick="detailCheck(\''
									+ row.actPrepareCode
									+ '\')" style="color: blue;cursor:pointer;" >'
									+ row.actPrepareCode
									+ "</a>";
						}
					}, {
						field : 'created',
						title : '分备单时间',
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return dateFormatYMD(row.created);
						}
					},{
						field : 'orderNum',
						title : '订单号',
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.orderNum;
						}
					}
					] ],
			columns : [ [{
				field : 'materialCode',
				title : '物料号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			},{
				field : 'haierModer',
				title : '海尔型号',
				align : 'center',
				formatter : function(value, row, roindex) {
					return row.haierModer;
				}
			}, {
				field : 'customerModel',
				title : '客户型号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customerModel;
				}
			}, {
				field : 'addirmNum',
				title : '特技单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.addirmNum;
				}
			}, {
				field : 'quantity',
				title : '数量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.quantity;
				}
			},{
				field : 'orderFinishedCount',
				title : '完工数量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderFinishedCount;
				}
			},{
				field : 'orderShipDate',
				title : '系统出运期',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.orderShipDate);
				}
			}, {
				field : 'packingEndDate',
				title : '系统交货期',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.packingEndDate);
				}
			},{
				field : 'bookShipDate',
				title : '下货纸出运期',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.bookShipDate);
				}
			}, 
			{
				field : 'contractCode',
				title : '合同号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.contractCode;
				}
			},
			{
				field : 'orderHgvsCode',
				title : 'HGVS编号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderHgvsCode;
				}
			}, {
				field : 'checkCode',
				title : '商检批次号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.checkCode;
				}
			},{
				field : 'deptCode',
				title : '经营体',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.deptCode;
				}
			},  {
				field : 'salesChennel',
				title : '销售区域',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.salesChennel;
				}
			},{
				field : 'factoryName',
				title : '生产工厂',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.factoryName;
				}
			}, {
				field : 'prodType',
				title : '产品组',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.prodType;
				}
			},{
				field : 'orderPoCode',
				title : '客户PO号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderPoCode;
				}
			},{
				field : 'custname',
				title : '客户名称',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.custname;
				}
			},{
				field : 'countryName',
				title : '国家',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			},{
				field : 'schFinishFate',
				title : '计划排定结束时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.schFinishFate);
				}
			},{
				field : 'payFinishDate',
				title : '付款通过时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.payFinishDate);
				}
			}, {
				field : 'actualFinishDate',
				title : '接单时间(订单评审通过时间)',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.actualFinishDate);
				}
			}, {
				field : 'manuStartDate',
				title : '计划开始时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.manuStartDate);
				}
			},{
				field : 'managerName',
				title : '产品经理',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.managerName;
				}
			}] ],
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

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '小备单生成表描述',
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
		//加载国家信息
		$('#countryCodeFinish').combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_COUNTRYHISTORY',
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
		//加载工厂信息
		$('#factoryCodeFinish').combogrid({
			url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0',
			textField : 'deptNameCn',
			idField : 'deptCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pageSize : 300,
			pageList : [ 300 ],
			pagePosition : 'bottom',
			toolbar : '#_FACTORYHISTORY',
			rownumbers : true,
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'deptCode',
				title : '工厂编码',
				width : 20
			}, {
				field : 'deptNameCn',
				title : '工厂名称',
				width : 20
			} ] ]
		});

		prepareOrderDetailDialog = $('#prepareOrderDetailDialog').show().dialog({
			title : '备货单详情',
			modal : true,
			closed : true,
			draggable : false,
			maximizable : true
		});
	});
	var orderCodeD;
	var factoryPCode;
	//显示订单明细
	function detailCheck(actPrepareCode) {
		$.ajax({
			url : "${dynamicURL}/prepare/queryPrepareAction!queryPrepareInfo.action",
			data : {
				actPrepareCode : actPrepareCode
			},
			dataType : "json",
			type : 'post',
			async : false,
			success : function(data) {
				orderCodeD = data.orderNum;
				factoryPCode = data.factoryProduceCode;
				$("#contractDetailForm").form('load', data);
			}
		});
		prepareOrder_detail(orderCodeD);
		$('#datagrid_contract_one').datagrid({
			url : "${dynamicURL}/prepare/queryPrepareAction!datagridPrepareInfoItem.action",
			queryParams : {
				actPrepareCode : actPrepareCode
			}
		});
		prepareOrderDetailDialog.dialog("open");
	}
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							ids = ids + "ids=" + rows[i].actPrepareCode + "&";
						else
							ids = ids + "ids=" + rows[i].actPrepareCode;
					}
					$.ajax({
						url : 'prepareOrderAction!delete.do',
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
			url : 'prepareOrderAction!showDesc.do',
			data : {
				actPrepareCode : row.actPrepareCode
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]')
							.html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有生成描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	function export1() {
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$("#searchForm").attr("action","expoertQuweyPrepareAction!exportQuweyPrepare.action");
		$("#searchForm").submit();
		$.messager.progress('close');
	}
	function export2() {
		var rows = datagrid.datagrid('getSelected');
		actCntAppid = parent.window.HROS.window.createTemp({
			title:"出口备货单跟踪表",
			url:"${dynamicURL}/prepare/prepareOrderAction!printPrepareOrder.do?ocode="+rows.orderNum,
			width:800,height:400,isresize:true,isopenmax:true,isflash:false,customWindow : window
			});
		}
	//模糊查询国家下拉列表
	function _CCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do?name='
					+ _CCNTEMP + '&countryCode=' + _CCNCODE
		});
	}
	//重置查询国家信息输入框
	function _CCNMYCLEAN(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do'
		});
	}
	//模糊查询工厂下拉列表
	function _FACTORYCCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0&deptNameCn='
					+ _CCNTEMP + '&deptCode=' + _CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询工厂信息输入框
	function _FACTORYCCNMYCLEAN(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0'
		});
	}
	//产品大类
	function _prodtypedatagrid(inputId,codeid, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		var code=$('#'+codeid).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/prodTypeAction!datagrid.action?prodTypeCode=' + _CCNTEMP+'&prodType='+code
		});
	}
	
	//模糊查询产品经理下拉列表
	function _getProdManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询产品经理下拉列表
	function _cleanProdManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询经营体下拉列表
	function _getDeptMent(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=1&deptNameCn=' + _CCNTEMP+'&deptCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询经营体下拉列表
	function _cleanDeptMent(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=1'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
</script>
</head>
<body class="easyui-layout">
	<jsp:include page="query_prepareOrder_detail.jsp" />
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 170px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>备货单查询</span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>查询与操作：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">订单编号：</div>
						<div class="righttext">
							<input id="orderNum" name="orderNum" type="text"
								style="width: 130px;margin-left: 20px;" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">备货单号：</div>
						<div class="righttext">
							<input id="actPrepareCode" name="actPrepareCode" type="text"
								style="width: 125px;margin-left: 20px;" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">国家：</div>
						<div class="rightselect_easyui">
							<input id="countryCodeFinish" name="countryCode" class="short50"
								type="text" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft60">工厂：</div>
						<div class="rightselect_easyui">
							<input id="factoryCodeFinish" name="factoryProduceCode"
								class="short100" type="text" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">是否已议付：</div>
						<div class="rightselect_easyui">
							<select name="roshFlag">
								<option value="">全部</option>
								<option value="1">是</option>
								<option value="0">否</option>
							</select>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft80">分备单时间从：</div>
						<div class="rightselect_easyui">
							<input id="createPrepareDateStar" name="createPrepareDateStar"
								style="width: 130px" class="easyui-datebox" editable="false" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">至：</div>
						<div class="rightselect_easyui">
							<input id="createPrepareDateEnd" name="createPrepareDateEnd"
								style="width: 120px;margin-left: 1px;" class="easyui-datebox" editable="false" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">接单时间从：</div>
						<div class="rightselect_easyui">
							<input id="creatStarDate" name="creatStarDate"
								style="width: 120px" class="easyui-datebox" editable="false" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">至：</div>
						<div class="rightselect_easyui">
							<input id="creatEndDate" name="creatEndDate" style="width: 120px"
								class="easyui-datebox" editable="false" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">产品组</div>
						<div class="rightselect_easyui">
							<input id="prodType" name="prodType" style="width: 120px"
								/>
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">产品经理</div>
						<div class="rightselect_easyui">
							<input id="managerName" name="managerName"
								style="width: 130px;margin-left: 20px;" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft80">实际出运期</div>
						<div class="rightselect_easyui">
							<input id="packingEndDate" name="packingEndDate"
								style="width: 120px" class="easyui-datebox" editable="false" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">销售区域</div>
						<div class="rightselect_easyui">
							<input name="salesChennel" class="easyui-combobox short60" id = "salesChennel"
								style="width: 120px" data-options="valueField:'itemNameCn',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.action?itemType=3'" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">经营体</div>
						<div class="rightselect_easyui">
							<input id="deptCode" name="deptCode" style="width: 120px"/>
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">商检批次号</div>
						<div class="righttext">
							<input id="checkCode" name="checkCode" type="text"
								style="width: 130px;margin-left: 20px;" />
						</div>
					</div>
				</div>
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查  询" onclick="_search();" /> <input
							type="button" value="重  置" onclick="cleanSearch();" /> <input
							type="button" value="导  出" onclick="export1();" /><input
							type="button" value="打  印" onclick="export2();" />
					</div>
				</div>
			</div>
		</form>
	</div>

	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="showCdescDialog"
		style="display: none; overflow: auto; width: 500px; height: 400px;">
		<div name="cdesc"></div>
	</div>

	<div id="iframeDialog"
		style="display: none; overflow: auto; width: 600px; height: 400px;">
		<iframe name="iframe" id="iframe" src="#" scrolling="auto"
			frameborder="0" style="width: 100%; height: 100%;"> </iframe>
	</div>
	<div id="_COUNTRYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="_COUNTRYCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCNMY('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryCodeFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('_COUNTRYCODEHISTORY','_COUNTRYINPUTHISTORY','countryCodeFinish')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_FACTORYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">工厂编号：</div>
				<div class="righttext">
					<input class="short50" id="_FACTORYCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">工厂名称：</div>
				<div class="righttext">
					<input class="short60" id="_FACTORYINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_FACTORYCCNMY('_FACTORYCODEHISTORY','_FACTORYINPUTHISTORY','factoryCodeFinish')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_FACTORYCCNMYCLEAN('_FACTORYCODEHISTORY','_FACTORYINPUTHISTORY','factoryCodeFinish')" />
				</div>
			</div>
		</div>
	</div>
	
	<div id="_PRODTYPESELECT">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">产品大类编码：</div>
				<div class="righttext">
					<input class="short60" id="_prodtypeCodeId" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">产品大类名称：</div>
				<div class="righttext">
					<input class="short60" id="_prodTypeNameId" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_prodtypedatagrid('_prodtypeCodeId','_prodTypeNameId','prodType')" />
				</div>
			</div>
		</div>
	</div>
	
	<!-- 产品经理下拉选信息 -->
	<div id="_PROD">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_PRODCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">产品经理：</div>
				<div class="righttext">
					<input class="short50" id="_PRODINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getProdManager('_PRODCODE','_PRODINPUT','managerName')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanProdManager('_PRODCODE','_PRODINPUT','managerName')" />
				</div>
			</div>
		</div>
	</div>
<div id="_DEPTHISTORY">
	    <div class="oneline">
		    <div class="item25">
				<div class="itemleft100">经营体编号：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">经营体名称：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTNAMEHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getDeptMent('_DEPTMENTCODEHISTORY','_DEPTMENTNAMEHISTORY','deptCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanDeptMent('_DEPTMENTCODEHISTORY','_DEPTMENTNAMEHISTORY','deptCode')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>