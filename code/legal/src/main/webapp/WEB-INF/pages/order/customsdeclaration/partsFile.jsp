<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var partsFileAddDialog;
	var partsFileAddForm;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/custorder/partsFileAction!datagridDetail.do',
			title : '报关明细列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'orderCode',
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.rowId;
						}
					},
			   {field:'bookCode',title:'订舱号',align:'center',sortable:true,
						formatter:function(value,row,index){
							return row.bookCode;
						}
			   },
			   {field:'orderCode',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
			   {field:'custDetail',title:'报关明细--附件',align:'center',sortable:true,
					formatter:function(value,row,index){
						if(row.custDetailName != null && row.custDetailName != ""){
							return "<a href='javascript:void(0)' style='color:blue' onclick='downCust(\""+value+"\")'>"+row.custDetailName+"</a>";	
						}else{
							return row.custDetailName;
						}
						
					}
				},				
			   {field:'changeProof',title:'换证凭条--附件',align:'center',sortable:true,
					formatter:function(value,row,index){
						if(row.changeProofName != null && row.changeProofName != ""){
							return "<a href='javascript:void(0)' style='color:blue' onclick='downProof(\""+value+"\")'>"+row.changeProofName+"</a>";	
						}else{
							return row.changeProofName;
						}
						
					}
				},
			   {field:'checkCode',title:'商检编号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.checkCode;
					}
			   },
			   {field:'orderShipDate',title:'订单出运期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderShipDate;
					}
			   },
			   {field:'bookShipDate',title:'下货纸船期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.bookShipDate;
					}
			   },
			   {field:'countryName',title:'国家',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.countryName;
					}
			   },
			   {field:'orderExeManagerName',title:'订单经理',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderExeManagerName;
					}
			   },
			   {field:'orderProdManagerName',title:'产品经理',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderProdManagerName;
					}
			   },
			   {field:'soldToName',title:'客户名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.soldToName;
					}
			   },
			   {field:'prodTypeName',title:'产品大类',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prodTypeName;
					}
			   }
			 ] ],
			toolbar : [ {
				text : '未齐',
				iconCls : 'icon-add',
				handler : function() {
					queryNoNeat();
				}
			}, '-', {
				text : '已齐',
				iconCls : 'icon-remove',
				handler : function() {
					queryNeat();
				}
			}, '-', {
				text : '上传',
				iconCls : 'icon-edit',
				handler : function() {
				    uploadInfo();
				}
			} ]
		});

		partsFileAddForm = $('#partsFileAddForm').form({
			url : '${dynamicURL}/custorder/partsFileAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid({url:'${dynamicURL}/custorder/partsFileAction!datagridDetail.do'});
					partsFileAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		partsFileAddDialog = $('#partsFileAddDialog').show().dialog({
			title : '添加报关明细',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					//报关资料附件
					var custDetailFileParm = $('#custDetailFile').val();
					if(custDetailFileParm == "" || custDetailFileParm == null){
						$.messager.alert('提示','报关明细附件不能为空,请检查！','info');
					}else{
						partsFileAddForm.submit();
					}
				}
			} ]
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
		
		//加载订单执行经理信息
		$('#orderExeManager')
				.combogrid(
						{
							url : '${dynamicURL}/salesOrder/salesOrderAction!selectAllOrderManager.do',
							textField : 'empName',
							idField : 'empCode',
							panelWidth : 500,
							panelHeight : 220,
							pagination : true,
							pagePosition : 'bottom',
							toolbar : '#_ORDERHISTORY',
							rownumbers : true,
							pageSize : 5,
							pageList : [ 5, 10 ],
							fit : true,
							fitColumns : true,
							columns : [ [ {
								field : 'empCode',
								title : '员工编号',
								width : 20
							}, {
								field : 'empName',
								title : '员工姓名',
								width : 20
							} ] ]
						});
		//加载产品经理信息
		$('#orderProdManager')
				.combogrid(
						{
							url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do',
							textField : 'empName',
							idField : 'empCode',
							panelWidth : 500,
							panelHeight : 220,
							pagination : true,
							pagePosition : 'bottom',
							toolbar : '#_PRODHISTORY',
							rownumbers : true,
							pageSize : 5,
							pageList : [ 5, 10 ],
							fit : true,
							fitColumns : true,
							columns : [ [ {
								field : 'empCode',
								title : '员工编号',
								width : 20
							}, {
								field : 'empName',
								title : '员工姓名',
								width : 20
							} ] ]
						});

	});
	
	function downCust(custDetailCode){
		window.location.href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId="+custDetailCode;
	}
	
	function downProof(proofCode){
		window.location.href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId="+proofCode;
	}

	function _search() {
		var custOrderCode = $("#orderNum").val();
		//国家code
		var countryParam = $('#countryCode').combogrid('getValue');
		//订单经理code
		var exeManagerParam = $('#orderExeManager').combogrid('getValue');
	    //产品经理code
	    var prodManagerParam = $('#orderProdManager').combogrid('getValue');
	    //订舱号code
	    var bookCodeParm =$('#bookCode').val();
		datagrid.datagrid({url:'${dynamicURL}/custorder/partsFileAction!datagridDetail.do?orderNum='+custOrderCode+'&countryCode='+countryParam+'&orderExeManager='+exeManagerParam+'&orderProdManager='+prodManagerParam+'&bookCode='+bookCodeParm
		                  });
	}
	function cleanSearch() {
		datagrid.datagrid({url:'${dynamicURL}/custorder/partsFileAction!datagridDetail.do'});
		searchForm.form('clear');
		//国家code
		$('#countryCode').combogrid('clear');
		//订单经理code
		$('#orderExeManager').combogrid('clear');
	    //产品经理code
	    $('#orderProdManager').combogrid('clear');
	}
	function uploadInfo() {
		var rows = datagrid.datagrid('getChecked');
		if(rows.length == 0){
			$.messager.alert("提示",'请选择订单上传文件!','info');
		}else if(rows.length > 1){
			$.messager.alert("提示",'请选择一个订单进行文件上传!','info');
		}else{
			partsFileAddForm.form("clear");
			partsFileAddDialog.dialog('open');
			$('#orderCode').val(rows[0].orderCode);
		}
	}
	//未齐
	function queryNoNeat() {
		var custOrderCode = $("#orderNum").val();
		//国家code
		var countryParam = $('#countryCode').combogrid('getValue');
		//订单经理code
		var exeManagerParam = $('#orderExeManager').combogrid('getValue');
	    //产品经理code
	    var prodManagerParam = $('#orderProdManager').combogrid('getValue');
	    //订舱号code
	    var bookCodeParm =$('#bookCode').val();
		datagrid.datagrid({url:'${dynamicURL}/custorder/partsFileAction!datagridNoNeat.do?orderNum='+custOrderCode+'&countryCode='+countryParam+'&orderExeManager='+exeManagerParam+'&orderProdManager='+prodManagerParam+'&bookCode='+bookCodeParm
		                  });
	}
	//已齐
	function queryNeat() {
		var custOrderCode = $("#orderNum").val();
		//国家code
		var countryParam = $('#countryCode').combogrid('getValue');
		//订单经理code
		var exeManagerParam = $('#orderExeManager').combogrid('getValue');
	    //产品经理code
	    var prodManagerParam = $('#orderProdManager').combogrid('getValue');
	    //订舱号code
	    var bookCodeParm =$('#bookCode').val();
		datagrid.datagrid({url:'${dynamicURL}/custorder/partsFileAction!datagridNeat.do?orderNum='+custOrderCode+'&countryCode='+countryParam+'&orderExeManager='+exeManagerParam+'&orderProdManager='+prodManagerParam+'&bookCode='+bookCodeParm
		                  });
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
	//模糊查询订单经理下拉列表
	function _getOrderManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId)
				.combogrid(
						{
							url : '${dynamicURL}/salesOrder/salesOrderAction!selectAllOrderManager.do?empName='
									+ _CCNTEMP + '&empCode=' + _CCNCODE
						});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询订单经理下拉列表
	function _cleanOrderManager(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId)
				.combogrid(
						{
							url : '${dynamicURL}/salesOrder/salesOrderAction!selectAllOrderManager.do'
						});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//模糊查询产品经理下拉列表
	function _getProdManager(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId)
				.combogrid(
						{
							url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do?empName='
									+ _CCNTEMP + '&empCode=' + _CCNCODE
						});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询产品经理下拉列表
	function _cleanProdManager(inputId, inputName, selectId) {
		$('#' + inputId).val("");
		$('#' + inputName).val("");
		$('#' + selectId)
				.combogrid(
						{
							url : '${dynamicURL}/salesOrder/salesOrderAction!selectOrderProdManager.do'
						});
		//$('#' + inputId).val(_CCNTEMP);
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" collapsed="false"  style="height: 105px" >
		<form id="searchForm">
		    <div class="part_zoc" style="margin:0px 0px 0px 0px;">
		        <div class="partnavi_zoc">
					<span>查询条件：</span>
				</div>
		        <div class="oneline">
		             <div class="item33">
						<div class="itemleft100">订单号：</div>
						<div class="righttext">
							<input id="orderNum" name="orderNum"  type="text" class="short80"/>
						</div>
				    </div>
					<div class="item33">
						<div class="itemleft100">订舱号：</div>
						<div class="righttext">
							<input id="bookCode" name="bookCode" class="short80" type="text" />
						</div>
					</div>
					<div class="item33 lastitem">
						<div class="itemleft100">国家：</div>
						<div class="rightselect_easyui">
							<input id="countryCode" name="countryCode" class="short80" type="text" />
						</div>
					</div>
		        </div>
		        <div class="oneline">
		            <div class="item33">
						<div class="itemleft100">订单经理：</div>
						<div class="rightselect_easyui">
							<input id="orderExeManager" name="orderExeManager" class="short80" type="text" />
						</div>						
					</div>
					<div class="item33 lastitem">
					    <div class="itemleft100">产品经理：</div>
						<div class="rightselect_easyui">
							<input id="orderProdManager" name="orderProdManager" class="short80" type="text" />
						</div>				
					</div>
		        </div>
		        <div class="oneline">
		             <div class="item50 lastitem">
				          <div class="oprationbutt">
				              <input type="button" value="查  询" onclick="_search()"/>
				              <input type="button" value="重  置" onclick="cleanSearch()"/>
				          </div>
				     </div>
		        </div>
		    </div>
		</form>
	</div>
	
	<div region="center"  style="padding:5px;background:#eee;">
		<table id="datagrid"></table>
	</div>

	<div id="partsFileAddDialog" style="display: none;width: 400px;height: 180px; overflow: hidden;" align="center">
		<form id="partsFileAddForm" method="post" enctype="multipart/form-data">
			 <div class="part_zoc" style="margin:0px 0px 0px 0px;">
		         <div class="oneline">
		             <div class="item50">
					    <div class="itemleft100">订单编号：</div>
						<div class="righttext">
							<input id="orderCode" name="orderNum"   type="text"  maxlength="32" style="background-color: #EBEBE4"  
							    readonly="true"/>
					    </div>
				     </div>
		         </div>
		         <div class="oneline">
		             <div class="item50">
					    <div class="itemleft100">报关明细--附件：</div>
						<div class="righttext">
						    <s:file id="custDetailFile" name="custDetailFile"  />
					    </div>
				     </div>
		         </div>
		         <div class="oneline">
		             <div class="item50">
					    <div class="itemleft100">换证凭条--附件：</div>
						<div class="righttext">
						    <s:file id="changeProofFile" name="changeProofFile"   />
					    </div>
				     </div>
		         </div>
		         <div class="oneline">
		             <div class="item50">
					    <div class="itemleft100">商检编号：</div>
						<div class="righttext">
							<input id="checkCode" name="checkCode"   type="text" maxlength="64" />
					    </div>
				     </div>
		         </div>
		     </div>
		</form>
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
	<div id="_ORDERHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_ORDERMANAGERCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">订单经理：</div>
				<div class="righttext">
					<input class="short60" id="_ORDERMANAGERINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getOrderManager('_ORDERMANAGERCODEHISTORY','_ORDERMANAGERINPUTHISTORY','orderExeManager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanOrderManager('_ORDERMANAGERCODEHISTORY','_ORDERMANAGERINPUTHISTORY','orderExeManager')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_PRODHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">编号：</div>
				<div class="righttext">
					<input class="short50" id="_PRODCODEHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">产品经理：</div>
				<div class="righttext">
					<input class="short60" id="_PRODINPUTHISTORY" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getProdManager('_PRODCODEHISTORY','_PRODINPUTHISTORY','orderProdManager')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanProdManager('_PRODCODEHISTORY','_PRODINPUTHISTORY','orderProdManager')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>