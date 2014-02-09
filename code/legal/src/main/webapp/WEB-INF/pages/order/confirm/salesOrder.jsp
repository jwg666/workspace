<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	$(function() {
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!showAllOrderDatagrid.do',
			title : '订单信息列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			nowrap : true,
			border : false,
			idField : 'orderCode',
			
			frozenColumns : [ [
			{
				field:'ck',
				checkbox:true,
				formatter:function(value,row,index){
					return row.orderCode;
				}
			},
			{
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return "<a href='javascript:void(0)' style='color:blue' onclick='showPanorama(\""+row.orderCode+"\",\""+row.orderType+"\")'> "+row.orderCode+"</a>";
				}
			},
			{
				field : 'orderTypeName',
				title : '订单类型',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderTypeName;
				}
			},
			{
				field : 'contractCode',
				title : '合同编号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.contractCode;
				}
			},
			{
				field : 'orderShipDate',
				title : '出运期',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return dateFormatYMD(row.orderShipDate);
				}
			},
			{
				field : 'orderCustomDate',
				title : '要求到货期',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return dateFormatYMD(row.orderCustomDate);
				}
			},
			{
				field : 'orderDealName',
				title : '成交方式',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.orderDealName;
				}
			}]],
			columns:[ [ 
			{
				field : 'currencyName',
				title : '币种',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.currencyName;
				}
			},
			{
				field : 'orderPaymentTermsName',
				title : '付款条件',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.orderPaymentTermsName;
				}
			},
			{
				field : 'salesOrgName',
				title : '销售组织',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.salesOrgName;
				}
			}, 
			{
				field : 'countryName',
				title : '国家',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.countryName;
				}
			},
			{
				field : 'orderSoldToName',
				title : '客户',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderSoldToName;
				}
			},
			{
				field : 'orderPoCode',
				title : '客户订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderPoCode;
				}
			},
			{
				field : 'deptName',
				title : '经营体',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.deptName;
				}
			},
			{
			    field : 'portStartName',
			    title : '始发港',
			    align : 'center',
			    sortable : true,
			    formatter : function(value, row, index){
			    	return row.portStartName;
			    }
			},
			{
			    field : 'portEndName',
			    title : '目的港',
			    align : 'center',
			    sortable : true,
			    formatter : function(value, row, index){
			    	return row.portEndName;
			    }
			},
			{
				field : 'vendorName',
				title : '船公司',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.vendorName;
				}
			},
			{
				field : 'taskname',
				title : '活动节点',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.taskname;
				}
			},
			{
				field : 'prepareOrderDate',
				title : '分备货单时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index){
					return dateFormatYMD(row.prepareOrderDate);
				}
			},
			{
				field : 'payOrderDate',
				title : '付款保障时间',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index){
					return dateFormatYMD(row.payOrderDate);
				}
			},
			{
				field : 'orderAuditFlag',
				title : '流程跟踪图',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return "<a href='javascript:void(0)' style='color:blue' onclick='showWorkflowDia(\""+row.orderCode+"\")'>"+"流程跟踪图</a>"
				}
			} ] ],
			toolbar : [{
				 text : '导出',
				 iconCls : 'icon-add',
				 handler : function(){
				   	var getCheckData = $('#datagrid').datagrid('getChecked');
				   	if(getCheckData.length){
				   		var jsonString = JSON.stringify(getCheckData);
					   	$('#jsonStr').val(jsonString);
					   /*  $('#jsonForm').form('submit',{
							url:'${dynamicURL}/salesOrder/salesOrderAction!downLoadOrderTemp.do'
						});  */
					   	//var clone = $('#jsonForm').clone();
						$('#jsonForm').attr("target","_blank");
						$('#jsonForm').attr("method","post");
						$('#jsonForm').attr("action",'${dynamicURL}/salesOrder/salesOrderAction!downLoadOrderTemp.do');
						$('#jsonForm').submit();
				   	}else{
				   	    $.messager.alert('提示',"请选择一条数据进行导出！",'info');
				   	}
				 }
		  },'-',{
			  text : '清除所有选项',
			  iconCls : 'icon-cancel',
			  handler : function(){
				  $('#datagrid').datagrid("clearSelections").datagrid("clearChecked");
			  }
		  },'-',{
			  text : '导出所有订单',
			  iconCls : 'icon-add',
			  handler : function(){
					//var clone = $('#searchForm').clone();
					$('#searchForm').attr("target","_blank");
					$('#searchForm').attr("method","post");
					$('#searchForm').attr("action",'${dynamicURL}/salesOrder/salesOrderAction!downLoadOrderTemp.do');
					$('#searchForm').submit();
			  }
		  }],
		  onLoadSuccess:function(){
			  
		  }
			/* ,
			//双击跳转到订单全景图
			onDblClickRow : function(rowIndex, rowData) {
				showPanorama(rowData.orderCode,rowData.orderType);
			} */
		});
		//加载合同信息
		$('#contractCode').combobox({
			url:'salesOrderAction!selectContractInfo.do',
			valueField:'contractCode',  
		    textField:'contractCode'
		});
		//加载经营体信息
		$('#deptCode').combogrid({
			url:'${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=1',
			idField:'deptCode',  
		    textField:'deptNameCn',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_DEPT',
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
		//加载目的港信息
		$('#portEndCode').combogrid({
		    url:'${dynamicURL}/basic/portAction!datagrid.action',
			idField:'portCode',  
		    textField:'englishName',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_PORTEND',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'portCode',
				title : '目的港编码',
				width : 20
			},{
				field : 'englishName',
				title : '目的港名称',
				width : 20
			}  ] ]
		});
		//加载国家信息
		$('#countryCode').combogrid({
			url:'${dynamicURL}/basic/countryAction!datagrid.do',
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
			},{
				field : 'name',
				title : '国家名称',
				width : 20
			}  ] ]
		});
		//加载经营体长信息
		$('#orderCustNamager').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectOrderCustManager.do',
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_CUST',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
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
		//加载产品经理信息
		$('#orderProdManager').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do',
			textField : 'empName',
			idField : 'empCode',
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
		//加载订单执行经理信息
		$('#orderExecManager').combogrid({
			url:'${dynamicURL}/salesOrder/salesOrderAction!selectOrderManagerByDept.do',
			textField : 'empName',
			idField : 'empCode',
		    panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_ORDER',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
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
		//加载活动节点
		$('#actNameId').combobox({
			url:'${dynamicURL}/tmod/actSetAction!listAllAct.do',
			valueField:'actName',  
		    textField:'actName',
		    editable : false
		});
		//加载订单类型
		$('#orderTypeName').combobox({
			url:'${dynamicURL}/basic/sysLovAction!orderTypeList.do',
		    valueField: 'itemCode',
		    textField: 'itemNameCn',
		    panelWidth : 150,
		    multiple : true
		});

	});
	//跳转到订单全景图页面
	function showPanorama(id,orderType) {
		var url = '${dynamicURL}/salesOrder/salesOrderAction!panoramaShow.action?orderCode=' + id + '&orderType=' + orderType;
		parent.window.HROS.window.createTemp({
			title:"订单全景图-订单号"+id,
			url:url,
			width:800,height:400,isresize:false,isopenmax:true,isflash:false});
	}
   	/*显示流程图*/
   	function showWorkflowDia(orderCode) {
	   if(null != orderCode && orderCode != "") {
		   var url = '${dynamicURL}/salesOrder/salesOrderAction!findProidByBusid.action';
		   $.ajax({
			   type: "POST",
			   url: url,
			   data: {orderCode:orderCode},
			   success: function(json){
			     var proid = $.parseJSON(json).obj;
			     if(null != proid && "" != proid) {
			    	 var imgURL = "${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="+proid;
			    	 parent.window.HROS.window.createTemp({
							title:"订单流程图-订单号"+orderCode,
							url:imgURL,
							width:600,height:200,isresize:true,isopenmax:true,isflash:false});
			     }
			   }
		   });
	   }
   	} 
	
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
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
	//模糊查询目的港下拉列表
	function _PORTMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/portAction!datagrid.do?englishName=' + _CCNTEMP+'&portCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询目的港信息输入框
	function _PORTMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/portAction!datagrid.do'
				});
	}
	//模糊查询经营体长下拉列表
	function _getCustManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderCustManager.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询经营体长下拉列表
	function _cleanCustManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderCustManager.do'
		});
		//$('#' + inputId).val(_CCNTEMP);
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
	//模糊查询订单经理下拉列表
	function _getOrderManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderManagerByDept.do?empName=' + _CCNTEMP+'&empCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询订单经理下拉列表
	function _cleanOrderManager(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderManagerByDept.do'
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
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 180px; overflow: auto;" align="left">
		<form  id="jsonForm" method="post" enctype="multipart/form-data">
		    <input  type="hidden"  id="jsonStr"  name="jsonStr" />
		</form>
		<form id="searchForm">
			<div class="navhead_zoc">
				<span><s:text name="res.DingDanChaXun">订单查询 </s:text></span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span><s:text name="order.confirm.controlInfo">查询与操作</s:text>：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">订单编号：</div>
						<div class="righttext">
							<input id="orderCode" name="dimOrderCode"  type="text"  class="short80"
								 />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">合同编号：</div>
						<div class="rightselect_easyui">
							<input id="contractCode" name="contractCode"  class="short80"  type="text" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">订单经理：</div>
						<div class="rightselect_easyui">
						    <input id="orderExecManager" name="orderExecManager"  class="short80" type="text"
								      />
						</div>
					</div>
				    <div class="item25">
						<div class="itemleft60">产品经理：</div>
						<div class="rightselect_easyui">
							<input id="orderProdManager" name="orderProdManager"  type="text"  class="short80"
								 />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">客户订单号：</div>
						<div class="rightselect_easyui">
							<input id="orderPoCode" name="orderPoCode"  type="text"  class="short80"
								 />
						</div>
					</div>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft60">经营体：</div>
						<div class="rightselect_easyui">
							<input id="deptCode" name="deptCode"  type="text"  class="short80" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">经营体长：</div>
						<div class="rightselect_easyui">
							<input id="orderCustNamager" name="orderCustNamager" type="text"  class="short80" />
						</div>
					</div>
					  <div class="item25">
						<div class="itemleft60">国家：</div>
						<div class="rightselect_easyui">
							<input id="countryCode" name="countryCode" type="text"  class="short80" />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">目的港：</div>
						<div class="rightselect_easyui">
							<input id="portEndCode" name="portEndCode" type="text"  class="short80" />
						</div>
					</div>
				</div>
				<div class="oneline"> 
				    <div class="item25">
				        <div class="itemleft60">订单类型：</div>
						<div class="rightselect_easyui">
							<input id="orderTypeName" name="orderTypeName" type="text" class="short80">
						</div>
				    </div>
				    <div class="item25">
				        <div class="itemleft60">活动节点：</div>
						<div class="rightselect_easyui">
							<input id="actNameId" name="actNameId" type="text" class="short80">
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft60">创建日期：</div>
						<div class="rightselect_easyui">
							<input id="createdStart" name="createdStart" style="width:132px"
								class="easyui-datebox" editable="false"  />
						</div>
					</div>
					<div class="item25">
						<div class="itemleft60">到：</div>
						<div class="rightselect_easyui">
							<input id="createdEnd" name="createdEnd"  style="width:132px"
								class="easyui-datebox" editable="false"  />
						</div>
					</div>
				</div>
				<div class="item100">
			        <div class="oprationbutt">
				        <input type="button" value="<s:text name="global.form.search">查询</s:text>" onclick="_search();"/>
				        <input type="button" value="<s:text name="global.reset">重置</s:text>"  onclick="cleanSearch();"/>
			       </div>
		        </div>
			</div>
		</form>
	</div>

	<div region="center" border="false" class="part_zoc">
		<table id="datagrid"></table>
	</div>
	
	<div id="iframeDialog"
		style="display: none; overflow: auto; width: 800px; height: 500px;">
		<iframe name="iframe" id="iframe" src="#" scrolling="auto"
			frameborder="0" style="width: 100%; height: 100%;"> </iframe>
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
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_CCNMY('_COUNTRYCODE','_COUNTRYINPUT','countryCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_CCNMYCLEAN('_COUNTRYCODE','_COUNTRYINPUT','countryCode')" />
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
				<div class="itemleft100">目的港名称：</div>
				<div class="righttext">
					<input class="short50" id="_PORTINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_PORTMY('_PORTCODEINPUT','_PORTINPUT','portEndCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_PORTMYCLEAN('_PORTCODEINPUT','_PORTINPUT','portEndCode')" />
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
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_getOrderManager('_ORDERMANAGERCODE','_ORDERMANAGERINPUT','orderExecManager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_cleanOrderManager('_ORDERMANAGERCODE','_ORDERMANAGERINPUT','orderExecManager')" />
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
					<input class="short60" id="_PRODINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_getProdManager('_PRODCODE','_PRODINPUT','orderProdManager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_cleanProdManager('_PRODCODE','_PRODINPUT','orderProdManager')" />
				</div>
			</div>
		</div>
	</div>
	 <!-- 经营体长下拉选信息 -->
	<div id="_CUST">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_CUSTCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">经营体长：</div>
				<div class="righttext">
					<input class="short60" id="_CUSTINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_getCustManager('_CUSTCODE','_CUSTINPUT','orderCustNamager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_cleanCustManager('_CUSTCODE','_CUSTINPUT','orderCustNamager')" />
				</div>
			</div>
		</div>
	</div>
	<!-- 经营体下拉信息 -->
	<div id="_DEPT">
	    <div class="oneline">
		    <div class="item25">
				<div class="itemleft100">经营体编号：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">经营体名称：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="<s:text name="global.form.search">查询</s:text>"
						onclick="_getDeptMent('_DEPTMENTCODE','_DEPTMENTNAME','deptCode')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="<s:text name="global.reset">重置</s:text>"
						onclick="_cleanDeptMent('_DEPTMENTCODE','_DEPTMENTNAME','deptCode')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>