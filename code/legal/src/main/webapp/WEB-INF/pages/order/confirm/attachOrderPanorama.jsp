<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>

<script type="text/javascript">
	var salesOrdeCode = '${orderCode}';
	var orderType = '${orderType}';
	/*全部展开*/
	function expandAll() {
		var node = $('#tree').treegrid('getSelected');
		if (node) {
			$('#tree').treegrid('expandAll', node.id);
		} else {
			$('#tree').treegrid('expandAll');
		}
	}
	/*全部收缩*/
	function collapseAll() {
		var node = $('#tree').treegrid('getSelected');
		if (node) {
			$('#tree').treegrid('collapseAll', node.id);
		} else {
			$('#tree').treegrid('collapseAll');
		}
	}
	/*显示流程图*/
	function showWorkflowDia() {
		var orderCode = $("#orderCode").val();
		if (null != orderCode && orderCode != "") {
			var url = '${dynamicURL}/salesOrder/salesOrderAction!findProidByBusid.action';
			$
					.ajax({
						type : "POST",
						url : url,
						data : {
							orderCode : orderCode
						},
						success : function(json) {
							var proid = $.parseJSON(json).obj;
							if (null != proid && "" != proid) {
								var imgURL = "${dynamicURL}/workflow/processAction!goTrace.do?processInstanceId="
										+ proid;
								parent.window.HROS.window.createTemp({
									title : "订单流程图-订单号" + orderCode,
									url : imgURL,
									width : 600,
									height : 200,
									isresize : false,
									isopenmax : true,
									isflash : false
								});
							}
						}
					});
		}
	}

	$(function() {
		var url = '${dynamicURL}/salesOrder/salesOrderAction!panoramaShow.action';
		$('#iframePanorama').attr('src', url);
		dialog = $('#iframePanorama').show().dialog({
			title : '订单全景图',
			modal : true,
			closed : true,
			minimizable : true,
			maximizable : true,
		});
		dialog.dialog('open');

		$("#orderinfoForm")
				.form(
						{
							onLoadSuccess : function(data) {
								//增加title
						   	    $("#orderinfoForm").find(":text").each(function(){
						   			if($(this).attr("name")!=null && $(this).attr("title")!=null){
						   				$(this).attr("title",$(this).val());
						   			}
						   		});
						   	 //经营体长code和name组合
								var custString = "("+data.orderCustName+")";
								if(data.orderCustNamager != "" && data.orderCustNamager != null){
									custString = custString + data.orderCustNamager;
								}
								$('#orderCustNamager').attr('title',custString);
								//产品经理code和name组合
								var prodString = "("+data.orderProdName+")";
								if(data.orderProdManager != "" && data.orderProdManager != null){
									prodString = prodString + data.orderProdManager;
								}
								$('#orderProdManager').attr('title',prodString);
								//订舱经理code和name组合
								var tranString ="("+data.orderTransManagerName+")"; 
								if(data.orderTransManager != "" && data.orderTransManager != null){
									tranString = tranString + data.orderTransManager;
								}
						   	    $('#orderTransManager').attr('title',tranString);
						   	    //收汇经理code和name组合
						   	    var recString = "("+data.orderRecManagerName+")";
								if(data.orderRecManager != "" && data.orderRecManager != null){
									recString = recString + data.orderRecManager;
								}
								$('#orderRecManager').attr('title',recString);
								//单证经理code和name组合
								var docString = "("+data.docManager+")";
								if(data.docManagerName != "" && data.docManagerName != null){
									docString = docString + data.docManagerName;
								}
						   	    $('#docManagerName').attr('title',docString);
						   	    //订单经理code和name组合
						   	    var orderString = "("+data.orderExecName+")";
								if(data.orderExecManager != "" && data.orderExecManager != null){
									orderString = orderString + data.orderExecManager;
								}
						   	    $('#orderExecManager').attr('title',orderString);
						   	    //收货人code和name组合
								var orderShipString = "("+data.orderShipToName+")";
								if(data.orderShipTo != "" && data.orderShipTo != null){
									orderShipString = orderShipString + data.orderShipTo;
								}
						   	    $('#orderShipTo').attr('title',orderShipString);
						   	    //售达方code和name组合
								var orderSoldString = "("+data.orderSoldToName+")";
								if(data.orderSoldTo != "" && data.orderSoldTo != null){
									orderSoldString = orderSoldString + data.orderSoldTo;
								}
						   	    $('#orderSoldTo').attr('title',orderSoldString);
						   	    //始发港code和name组合
						   	    var portStartString = "("+data.portStartCode+")";
						   	    if(data.portStartName != "" && data.portStartName != null){
						   	    	portStartString = portStartString + data.portStartName;
						   	    }
						   	    $('#portStartName').attr('title',portStartString);
						   	    //目的港code和name组合
						   	    var poartEndString = "("+data.portEndCode+")";
						   	    if(data.portEndName != "" && data.portEndName != null){
						   	    	poartEndString = poartEndString + data.portEndName;
						   	    }
						   	    $('#portEndName').attr('title',poartEndString);
						   	    //运输公司
						   	    var vendorString = "("+data.vendorCode+")";
						   	    if(data.vendorName != "" && data.vendorName != null){
						   	    	vendorString = vendorString + data.vendorName;
						   	    }
						   	    $('#vendorName').attr('title',vendorString);
						   	    //付款条件code和name组合
						   	    var payTermString = "("+data.orderPaymentTerms+")";
						        if(data.orderPaymentTermsName != "" && data.orderPaymentTermsName != null){
						        	payTermString = payTermString + data.orderPaymentTermsName;
						        }
						        $('#orderPaymentTermsName').attr('title',payTermString);
						      //生成工厂code和name组合
						        var factoryString = "("+data.factoryCode+")";
						        if(data.factoryName != "" && data.factoryName != null){
						        	factoryString = factoryString + data.factoryName
						        }
						        $('#factoryName').attr('title',factoryString);
							}
						})
				.form(
						"load",
						"${dynamicURL}/salesOrder/salesOrderAction!loadDataForPanorama?orderCode=${orderCode}");

		$('#tree')
				.treegrid(
						{
							animate : true,
							autoRowHeigh : true,
							collapsible : true,
							idField : 'actId',
							treeField : 'actName',
							url : '${dynamicURL}/salesOrder/salesOrderAction!testTree.action?orderCode=${orderCode}',
							toolbar : [ {
								text : '展开全部',
								iconCls : 'icon-redo',
								handler : function() {
									expandAll();
								}
							}, '-', {
								text : '收缩全部',
								iconCls : 'icon-undo',
								handler : function() {
									collapseAll();
								}
							}, '-', {
								text : '显示流程图',
								iconCls : 'icon-undo',
								handler : function() {
									showWorkflowDia();
								}
							} ],
							columns : [ [ {
								field : 'actName',
								title : '活动名称',
								width : 140
							}, {
								field : 'statusCode',
								title : '状态',
								width : 50
							}, {
								field : 'planStartDate',
								title : '计划开始时间',
								width : 140,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.planStartDate);
								}
							}, {
								field : 'planFinishDate',
								title : '计划完成时间',
								width : 140,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.planFinishDate);
								}
							}, {
								field : 'actualFinishDate',
								title : '实际完成时间',
								width : 140,
								formatter : function(value, row, index) {
									return dateFormatYMD(row.actualFinishDate);
								}
							}, {
								field : 'actUserName',
								title : '责任人',
								width : 50
							}, {
								field : 'actDesc',
								title : '活动描述',
								width : 240,
								formatter : function(value, row, index) {
									if (row.statusCode == 'start') {
										return '开始';
									} else if (row.statusCode == 'end') {
										return '已完成';
									}
								}
							} ] ],
							onBeforeExpand : function(row) {
								var expandOrderCode = $("#orderCode").val();
								var url = "${dynamicURL}/salesOrder/salesOrderAction!testTreeChildren.action?treeId="
										+ row.actId
										+ "&orderCode="
										+ expandOrderCode;
								$("#tree").treegrid("options").url = url;
								return true;
							}
						});
	})
	//下载附件
	function downLoad(){
		var attachmentCode= $('#orderAttachments').val();
		if(attachmentCode == null || attachmentCode == ""){
			$.messager.alert('提示',"此订单没有附件！",'info');
		}else{
			window.location.href="${dynamicURL}/basic/fileUploadAction/downloadFile.do?fileId="+attachmentCode;
		}
	}
	//查询订单号
	function selectOrderAttInfo(){
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		var orderCodeInfo = $('#orderCodeInfo').val();
		if(orderCodeInfo == null || orderCodeInfo == ""){
			$.messager.alert('提示','订单号不能为空,请检查！','info');
		}else{
			$.ajax({
				url:'${dynamicURL}/salesOrder/salesOrderAction!loadDataForPanorama',
				data:{
					orderCode:orderCodeInfo
				},
				type:'post',
				success:function(data){
					var json = $.parseJSON(data);
					if(data == null){
						$.messager.alert('提示','订单号不存在,请检查！','info');
					}else{
						//增加title
				   	    $("#orderinfoForm").find(":text").each(function(){
				   			if($(this).attr("name")!=null && $(this).attr("title")!=null){
				   				$(this).attr("title",$(this).val());
				   			}
				   		});
						$("#orderinfoForm").form('load',json);
						$('#itemDatagrid').datagrid({url:'${dynamicURL}/salesOrder/salesOrderItemAction!orderItemDatagrid.do?orderCode='+orderCodeInfo});
						$('#conditionDatagrid').datagrid({url:'${dynamicURL}/salesOrder/salesOrderConditonAction!datagrid.do?orderCode='+orderCodeInfo});
						$('#packageDatagrid').datagrid({url:'${dynamicURL}/salesOrder/salesOrderPackageAction!combox.do?orderCode='+orderCodeInfo});
						$('#interfaceDatagrid').datagrid({url:'${dynamicURL}/salesOrder/interfaceLogAction!combox.do?orderCode='+orderCodeInfo});
						$('#tree').treegrid({url:'${dynamicURL}/salesOrder/salesOrderAction!testTree.action?orderCode='+orderCodeInfo});
					}
					$.messager.progress('close');
				}
			});
		}
		$.messager.progress('close');
	}
</script>
</head>
<body>
	<div class="easyui-layout" style="width: 100%; height: 550px;">
		<div id="tMod" data-options="region:'center',fit:'true'" title="T模式"
			class="zoc">
			<table id="tree" class="easyui-treegrid">

			</table>
		</div>

		<div data-options="region:'west',split:true" class="zoc"
			style="width: 1020px;" title="订单基本信息">
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span>▼基本信息：</span>
				</div>
				<form  method="post">
				    <div class="oneline">
				        <div class="item33">
				            <div class="itemleft100">订单号：</div>
				            <div class="righttext">
				                <input id="orderCodeInfo" name="orderCodeInfo"  type="text"   maxlength="32"/>
				            </div>
				        </div>
				        <div class="item33 lastitem">
				            <div class="oprationbutt">
				                <input type="button" value="查  询" onclick="selectOrderAttInfo()"/>
  				            </div>
				        </div>
				    </div>
				</form>
				<form id="orderinfoForm" method="post">
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">订单编号：</div>
							<div class="righttext">
								<input id="orderCode" name="orderCode" disabled="true" title=""
									type="text" class="short50" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">订单类型：</div>
							<div class="righttext">
								<input id="orderType" name="orderType" disabled="true"
									type="text" class="short50" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">创建日期：</div>
							<div class="righttext">
								<input id="orderCreateDate" name="orderCreateDate"
									disabled="true" type="text" class="short50" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">销售大区：</div>
							<div class="righttext">
								<input id="saleAreaName" name="saleAreaName" disabled="true" type="text"  title=""
									class="short50" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">终端客户订单号：</div>
							<div class="righttext">
								<input id="orderPoCode" name="orderPoCode" disabled="true" title=""
									class="short50" type="text" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">出口国家：</div>
							<div class="righttext">
								<input id="countryName" name="countryName" class="short50" title=""
									disabled="true" type="text" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">收货人：</div>
							<div class="righttext">
								<input id="orderShipTo" name="orderShipTo" class="short50" title=""
									disabled="true" type="text" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">售达方：</div>
							<div class="righttext">
								<input id="orderSoldTo" name="orderSoldTo" class="short50"  title=""
									disabled="true" type="text" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">运输方式：</div>
							<div class="righttext">
								<input id="orderShipmentName" name="orderShipmentName"
									class="short50" disabled="true" type="text" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">始发港：</div>
							<div class="righttext">
								<input id="portStartName" name="portStartName" class="short50"
									disabled="true" type="text" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">目的港：</div>
							<div class="righttext">
								<input id="portEndName" name="portEndName" class="short50"  title=""
									disabled="true" type="text" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">运输公司：</div>
							<div class="righttext">
								<input id="vendorName" name="vendorName" class="short50" title=""
									disabled="true" type="text" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">出运时间：</div>
							<div class="righttext">
								<input id="orderShipDate" name="orderShipDate" class="short50"
									disabled="true" type="text" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">币种：</div>
							<div class="righttext">
								<input id="currencyName" name="currencyName" disabled="true"
									type="text" class="short50" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">兑美元汇率：</div>
							<div class="righttext">
								<input id="toUsaExchange" name="toUsaExchange" disabled="true"
									type="text" class="short50" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">兑人民币汇率：</div>
							<div class="righttext">
								<input id="toCnyExchange" name="toCnyExchange" disabled="true"
									type="text" class="short50" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">经营体：</div>
							<div class="righttext">
								<input id="deptName" name="deptName" type="text" class="short50" title=""
									disabled="true" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">成交方式：</div>
							<div class="righttext">
								<input id="orderDealType" name="orderDealType" type="text"
									class="short50" disabled="true" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">订单经理：</div>
							<div class="righttext">
								<input id="orderExecManager" name="orderExecManager" type="text"
									class="short50" disabled="true" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">经营体长：</div>
							<div class="righttext">
								<input id=orderCustNamager name="orderCustNamager" type="text"
									class="short50" disabled="true" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">产品经理：</div>
							<div class="righttext">
								<input id="orderProdManager" name="orderProdManager" type="text"
									class="short50" disabled="true" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">订舱经理：</div>
							<div class="righttext">
								<input id="orderTransManager" name="orderTransManager"
									type="text" class="short50" disabled="true" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">收汇经理：</div>
							<div class="righttext">
								<input id="orderRecManager" name="orderRecManager" type="text"
									class="short50" disabled="true" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">单证经理：</div>
							<div class="righttext">
								<input id="docManagerName" name="docManagerName" type="text"
									class="short50" disabled="true" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">要求到货日：</div>
							<div class="righttext">
								<input id="orderCustomDate" name="orderCustomDate" type="text"
									disabled="true" class="short50" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">订单付款周期：</div>
							<div class="righttext">
								<input id="orderPaymentCycle" name="orderPaymentCycle"
									type="text" disabled="true" class="short50" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">订单付款方式：</div>
							<div class="righttext">
								<input id="orderPaymentMethodName" name="orderPaymentMethodName"
									type="text" disabled="true" class="short50" />
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">订单付款条件：</div>
							<div class="rightselect_easyui">
								<input id="orderPaymentTermsName" name="orderPaymentTermsName"  title=""
									type="text" disabled="true" class="short50" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">T模式：</div>
							<div class="righttext">
								<input id="tmodelName" name="tmodelName" class="short50"  title=""
									type="text" disabled="true" />
							</div>
						</div>
						 <div class="item33">
				           <div class="itemleft100">生产工厂：</div>
						   <div class="righttext">
						       <input id="factoryName" name="factoryName"  type="text" disabled="true"  class="short50" />
						    </div>
				       </div>
					</div>
					<div class="oneline">
					    <div class="item33">
							<div class="itemleft100">整机订单号：</div>
							<div class="righttext">
						        <input id="spZor" name="spZor"  type="text" disabled="true"  class="short50" />
						    </div>
						</div>
					    <div class="item33">
							<div class="itemleft100">附件：</div>
							<div class="righttext">
						        <input  type="hidden"  id="orderAttachments"  name="orderAttachments" />
						        <div class="oprationbutt">
			                         <input type="button" value="下载附件" onclick="downLoad();"/>
			                     </div>
						    </div>
						</div>
					</div>
				</form>
			</div>
			<jsp:include page="attachmentOrderDetailData.jsp" />
		</div>
	</div>
	</div>
</body>
</html>