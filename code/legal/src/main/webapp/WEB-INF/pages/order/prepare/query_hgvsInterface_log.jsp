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
		datagrid = $('#datagrid').datagrid({
			url : 'queryHgvsInterfaceAction!datagrid.do',
			title : 'HGVS销售订单接口日志',
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
			idField : 'actPrepareCode',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			},{
				field : 'actPrepareCode',
				title : '备货单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return '<a onclick="detailCheck(\''+row.actPrepareCode+'\')" style="color: blue;cursor:pointer;" >'
					+row.actPrepareCode+"</a>";
				}
			}, {
				field : 'orderNum',
				title : '订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderNum;
				}
			},  {
				field : 'materialCode',
				title : '物料',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.materialCode;
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
				field : 'exeDateStr',
				title : '导入时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.exeDateStr;
				}
			}, {
				field : 'manuEndDate',
				title : '生产计划结束时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return dateFormatYMD(row.manuEndDate);
				}
			}, {
				field : 'factoryName',
				title : '生产工厂',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.factoryName;
				}
			}, {
				field : 'countryName',
				title : '国家',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			},{
					field : 'exeFlag',
					title : '是否成功',
					align : 'center',
					sortable : true,
					formatter : function(value, row, index) {
						if(row.exeFlag=="1"){
							return "否";
						}else{
							return "是";
						}
						
					}
				},{
						field : 'exeResult',
						title : '接口返回信息',
						align : 'center',
						sortable : true,
						formatter : function(value, row, index) {
							return row.exeResult;
						}
				} ] ],
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},
			onClickRow : function(rowIndex, rowData) {
				var rowsSelect = datagrid.datagrid('getSelected');
				 $.ajax({
			            url: '${dynamicURL}/prepare/prepareOrderAction!getListprepareOrderbyOrderNum.do',
			            data: {
			                'orderNum': rowsSelect.orderNum
			            },
			            dataType: 'json',
			            success: function(data) {
			                contractDetailForm.form('load', {
								'actPrepareCode' :  data[0].actPrepareCode,
			                    'orderNum': rowsSelect.orderNum,
			                    'contractCode' : data[0].contractCode,
			                    'checkCode' : data[0].checkCode,
			                    'orderBuyoutFlag' : data[0].orderBuyoutFlag
			                });
			            }
			        });
				addprepareOrder();
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
			url:'${dynamicURL}/basic/countryAction!datagrid.do',
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
			},{
				field : 'name',
				title : '国家名称',
				width : 20
			}  ] ]
		});
		///加载工厂信息
		$('#factoryCodeFinish').combogrid({
			url:'${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0',
			textField : 'deptNameCn',
			idField : 'deptCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_FACTORYHISTORY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'deptCode',
				title : '工厂编码',
				width : 20
			},{
				field : 'deptNameCn',
				title : '工厂名称',
				width : 20
			}  ] ]
		});
		prepareOrderDetailDialog = $('#prepareOrderDetailDialog').show()
				.dialog({
					title : '备货单录入',
					modal : true,
					closed : true,
					draggable : false,
					maximizable : true
				});

	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('select').val('');
		searchForm.form("clear");
		datagrid.datagrid('clearSelections');
		datagrid.datagrid('clearChecked');

	}
	function repeatHGVS() {
		var rows = datagrid.datagrid('getSelections');
		var codes = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要将此订单重传HGVS？', function(r) {
				if (r) {
					$.messager.progress({
						text : '数据加载中....',
						interval : 100
					});
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							codes = codes + "codes=" + rows[i].actPrepareCode + "&";
						else
							codes = codes + "codes=" + rows[i].actPrepareCode;
					}
					$.ajax({
						url : 'queryHgvsInterfaceAction!repeatHGVS.do',
						data : codes,
						dataType : 'json',
						success : function(response) {
							if(response.success){
								$.messager.alert('提示','订单导HGVS成功！','info');
								$.messager.progress('close');
								datagrid.datagrid('reload');
								datagrid.datagrid('unselectAll');
								$("#orderHgvsCode").val(response.orderCode);
							}else{
								$.messager.alert('提示','导入失败：'+response.msg,'error');
								$.messager.progress('close');
								datagrid.datagrid('reload');
								datagrid.datagrid('unselectAll');
								$("#orderHgvsCode").val(response.orderCode);
							}
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要重传的记录！', 'error');
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
					$.messager.alert('提示', '没有小备单生成表描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	function export1() {
		$("#searchForm").attr("action",
				"expoertHGVSlogAction!exportHGVSlog.action");
		$("#searchForm").submit();
	}

	function addprepareOrder() {

		query_hgvsInterface_log_detail();
		contractDetailForm.find('input,textarea').attr("readonly", false);
		prepareOrderDetailDialog.dialog("open");

	}
	//显示订单明细
	function detailCheck(actPrepareCode) {
		parent.window.HROS.window
		.createTemp({
			title : "导HGVS明细",
			url : "${dynamicURL}/prepare/importHgvsInterfaceAction!hgvsInterfacedetail.do?prepareOrderQuery.actPrepareCode="
					+ actPrepareCode,
			width : 800,
			height : 400,
			isresize : true,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
		/* prepareOrder_detail();
		$.ajax({
	   	     url:"${dynamicURL}/prepare/queryPrepareAction!queryPrepareInfo.action",
	   	     data:{
	   	    	actPrepareCode:actPrepareCode
	   	    	  },
	   	     dataType:"json",
	   	     type:'post',
	   	     success:function(data){
		   		$("#contractDetailForm").form('load',data);
	   	     }
		});
		$('#datagrid_contract_one').datagrid(
				{url:"${dynamicURL}/prepare/queryPrepareAction!datagridPrepareInfoItem.action",
					queryParams:{actPrepareCode:actPrepareCode}
				});
		prepareOrderDetailDialog.dialog("open"); */
	}
	//模糊查询国家下拉列表
	function _CCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do?name='+ _CCNTEMP+'&countryCode='+_CCNCODE 
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询国家信息输入框
	function _CCNMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/countryAction!datagrid.do'
				});
	}
	//模糊查询工厂下拉列表
	function _FACTORYCCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0&deptNameCn='+ _CCNTEMP+'&deptCode='+_CCNCODE 
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询工厂信息输入框
	function _FACTORYCCNMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/security/departmentAction!datagrid.do?deptParentCode=0'
				});
	}
</script>
</head>
<body class="easyui-layout">
	<%-- <jsp:include page="query_prepareOrder_detail.jsp" /> --%>
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 150px; overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span>HGVS销售订单接口日志</span>
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
								style="width: 125px" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">备货单号：</div>
						<div class="righttext">
							<input id="actPrepareCode" name="actPrepareCode" type="text"
								style="width: 125px" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">国家：</div>
						<div class="rightselect_easyui">
							<input id="countryCodeFinish" name="countryCode" class="short50"  type="text" />
						</div>
					</div>
					<div class="item33">
						<div class="itemleft60">工厂：</div>
						<div class="rightselect_easyui">
							<input id="factoryCodeFinish" name="factoryProduceCode" class="short50"  type="text" />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft80">分备货单从：</div>
						<div class="rightselect_easyui">
							<input id="creatStarDate" name="creatStarDate"
								style="width: 120px" class="easyui-datebox" editable="false" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">到：</div>
						<div class="rightselect_easyui">
							<input id="creatEndDate" name="creatEndDate" style="width: 120px"
								class="easyui-datebox" editable="false" />
						</div>
					</div>
				</div>
				<div class="item100">
					<div class="oprationbutt">
						<input type="button" value="查  询" onclick="_search();" /> <input
							type="button" value="重  置" onclick="cleanSearch();" /> <input
							type="button" value="导  出" onclick="export1();" /> <input
							type="button" value="重传HGVS" onclick="repeatHGVS();" />
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
</body>
</html>