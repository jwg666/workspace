<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script src="${staticURL}/scripts/baiduTemplate.js"></script>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var datagrid1;
	var datagrid2;
	var prepareOrderAddDialog;
	var prepareOrderAddForm;
	var cdescAdd;
	var prepareOrderEditDialog;
	var prepareOrderDetailDialog; //明细Dialog
	var prepareOrderEditForm;
	var cdescEdit;
	var showCdescDialog;
	var showErrorDialog;
	var iframeDialog;
	var myJson;
	var prepareOrderAppid = null;
	$(function() {
		//设置左分隔符为 <!
		baidu.template.LEFT_DELIMITER='{%';

		//设置右分隔符为 <!  
		baidu.template.RIGHT_DELIMITER='%}';
		//查询列表	
		searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
				url : 'prepareOrderAction!prepareOrderdatagridNeed.do?definitionKey=prepareOrder',
				title : '<s:text name="global.prepareorder.deliveryList">分备货单列表</s:text>',
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
				idField : 'orderCode',
				columns : [ [
						{
							field : 'ck',
							checkbox : true,
							formatter : function(value, row, index) {
								return row.orderCode;
							}
						},
						{
							field : 'orderCode',
							title : '<s:text name="global.order.number">订单号</s:text>',
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								var img;
								if (row.assignee
										&& row.assignee != 'null') {
									img = "<img width='16px' height='16px' title='个人任务' src='${staticURL}/easyui3.2/themes/icons/user.png' />&nbsp;"
								} else {
									img = "<img width='16px' height='16px' title='未认领的组任务' src='${staticURL}/easyui3.2/themes/icons/group.png' />&nbsp;"
								}
								return img
										+ "<a href='javascript:void(0)' id='tooltip_"
										+ row.orderCode
										+ "' class=\"easyui-tooltip\" style='color:blue'   onclick='addprepareOrderByOrderCode(\""
										+ row.orderCode + "\",\""
										+ row.taskId + "\")' >"
										+ row.orderCode + "</a>";

							}
						},
						{
							field : 'deptNameCn',
							title : '<s:text name="orderConfirm.productFactoryText">生产工厂</s:text>',
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return row.deptNameCn;
							}
						},
						{
							field : 'deptname',
							title : '<s:text name="global.order.deptName">经营体</s:text>',
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return row.deptname;
							}
						},
						{
							field : 'countryName',
							title : '<s:text name="global.order.countryName">出口国家</s:text>',
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return row.countryName;
							}
						},
						{
							field : 'orderShipDate',
							title : '<s:text name="credit.lettercredit.pdCarrydate">出运期</s:text>',
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return row.orderShipDate.substring(
										0, 10);
							}
						},
						{
							field : 'itemNameCn',
							title : '<s:text name="global.order.saleArea">市场区域</s:text>',
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return row.itemNameCn;
							}
						},
						{
							field : 'managerName',
							title : '<s:text name="global.order.orderExecManager">产品经理</s:text>',
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return row.managerName;
							}
						},
						{
							field : 'orderHgvsFlag',
							title : '<s:text name="orderConfirm.hgvsFlagText">是否导HGVS</s:text>',
							align : 'center',
							sortable : false,
							formatter : function(value, row, index) {
								if(value=='0'){
									return "否"
								}else if(value='1'){
									return "是";
								}
							}
						},
						{
							field : 'dueDate',
							title : '<s:text name="evaluate.planFinishDate">计划完成时间</s:text>',
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return row.dueDate;
							}
						} ] ],

				toolbar : [ {
					text : '<s:text name="global.prepare.listDelivery">批量分单</s:text>',
					iconCls : 'icon-add',
					handler : function() {
						addListOrderItem();
					}
				}, '-', {
					text : '<s:text name="global.delivery">分单</s:text>',
					iconCls : 'icon-add',
					handler : function() {
						addprepareOrder();
					}
				}, '-', {
					text : '<s:text name="global.prepareorder.releaseDetail">闸口明细</s:text>',
					iconCls : 'icon-edit',
					handler : function() {
						showReleasePage();
					}
				}, '-' ],
				onClickRow : function(rowIndex, rowData) {
					var rowd = datagrid.datagrid('getSelected');
					$('#datagrid1')
							.datagrid(
									{
										url : '${dynamicURL}/prepare/prepareOrderAction!datagridSales.do?orderCodes='
												+ rowd.orderCode
									});
					//加载datagrid1数据时 清空datagrid2 中的数据 
					var item = $('#datagrid2').datagrid('getRows');
					if (item) {
						for ( var i = item.length - 1; i >= 0; i--) {
							var index = $('#datagrid2').datagrid(
									'getRowIndex', item[i]);
							$('#datagrid2').datagrid('deleteRow',
									index);
						}
					}
					$('#datagrid2').datagrid('loadData', {
						total : 0,
						rows : []
					});
				},
				onRowContextMenu : function(e, rowIndex, rowData) {
					e.preventDefault();
					$(this).datagrid('unselectAll');
					$(this).datagrid('selectRow', rowIndex);
					$('#menu').menu('show', {
						left : e.pageX,
						top : e.pageY
					});
				},
				onLoadSuccess : function(data) {
					$("a[id^='tooltip_']").tooltip(
									{
										position : 'bottom',
										content:'<s:text name="global.order.loadMaterial">正在加载物料信息...</s:text>',
										deltaX:90,
										onShow:function(e){
											var tooltip=$(this);
											var orderCode=tooltip.attr("id").replace("tooltip_","");
										 	$.ajax({
												url : "${dynamicURL}/salesOrder/salesOrderItemAction!combox.do",
												data : {
													orderCode : orderCode
												},
												dataType : "json",
												type : 'post',
												success : function(data) {
													var temp={};
													temp["data"]=data;
													var messageHtml=baidu.template('itemList_Template',temp);
													tooltip.tooltip('update',messageHtml);
												}
											}); 
										}
									});
							}
						});
		showErrorDialog = $('#showErrorDialog').show().dialog({
			iconCls : 'icon-search',
			title : '<s:text name="global.order.releaseDetail">订单闸口详情信息</s:text>',
			modal : true,
			closed : true,
			maximizable : true,
			width : 550,
			height : 300,
			buttons : [ {
				text : '关闭',
				iconCls : 'icon-cancel',
				handler : function() {
					showErrorDialog.dialog('close');
				}
			} ]
		});
	});
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}

	function addprepareOrder() {
		var row = datagrid.datagrid('getSelections');
		var dataFlag = "";
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中</s:text>',
			interval : 100
		});
		if (row.length == 1) {
			addprepareOrderByOrderCode(row[0].orderCode, row[0].taskId);
		} else {
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.info.selectData">请选择一条数据！</s:text>', 'error');
		}
		$.messager.progress('close');
	}

	function addprepareOrderByOrderCode(orderCode, taskId) {
		$.ajax({
			url : "${dynamicURL}/prepare/prepareOrderAction!getReleaseFlag.do",
			data : {
				orderCode : orderCode
			},
			dataType : "json",
			type : 'post',
			async : false,
			success : function(data) {
				dataFlag = JSON.stringify(data);
			}
		});
		if ("null" != dataFlag) {
			dataFlag = dataFlag.substring(1, 2);
		}
		if ("2" == dataFlag) {
			$.messager.defaults = {
				ok : "继续",
				cancel : "取消"
			};
			$.messager.confirm('<s:text name="global.form.prompt">提示</s:text>','<s:text name="global.prepareorder.releaseReason">该订单上次申请闸口被拒绝,是否要继续分单?详情查看闸口明细</s:text>',
				function(r) {
					if (r) {
						prepareOrderAppid = parent.window.HROS.window.createTemp({
						appid : prepareOrderAppid,
						title : '<s:text name="global.prepareorder.delivery">备货单分单</s:text>',
						url : "${dynamicURL}/prepare/prepareOrderAction!showNewDialog.do?taskId="+ taskId,
						width : 800,
						height : 400,
						isresize : true,
						isopenmax : true,
						isflash : false,
						customWindow : window
						});
					} else {
					}
			});
		} else if ("1" == dataFlag) {
			prepareOrderAppid = parent.window.HROS.window.createTemp({
				appid : prepareOrderAppid,
				title : '<s:text name="global.prepareorder.delivery">备货单分单</s:text>',
				url : "${dynamicURL}/prepare/prepareOrderAction!showNewDialog.do?taskId="+ taskId,
				width : 800,
				height : 400,
				isresize : true,
				isopenmax : true,
				isflash : false,
				customWindow : window
			});
		} else {
			prepareOrderAppid = parent.window.HROS.window.createTemp({
						appid : prepareOrderAppid,
						title : '<s:text name="global.prepareorder.delivery">备货单分单</s:text>',
						url : "${dynamicURL}/prepare/prepareOrderAction!showNewDialog.do?taskId="+ taskId,
						width : 800,
						height : 400,
						isresize : true,
						isopenmax : true,
						isflash : false,
						customWindow : window
					});
		}

	}

	//为回调函数准备2个全局变量
	var rowsTemp;
	var rowsIndex;
	function addListOrderItem() {
		rowsTemp = datagrid.datagrid('getChecked');
		//for(var i = 0; i < rows.length; i++){
		rowsIndex = 0;
		huidiao();
		//}
	}

	//回调函数
	function huidiao() {
		if (rowsTemp.length <= rowsIndex) {
			rowsTemp = [];
			rowsIndex = 0;
			//reload 必须放在248 huidiao() 在没有执行回调函数,程序还会继续运行，刷新列表，导致回调函数失败
			$('#datagrid').datagrid('unselectAll');
			$('#datagrid').datagrid('reload');
			top.window.showTaskCount();
			return;
		}
		var data = rowsTemp[rowsIndex];
		rowsIndex++;
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中</s:text>',
			interval : 100
		});
		var para = "";
		var logShow = "";
		var kindex = 0;
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  		
		//前期准备
		//form内容加载
		var formData = "";
		$.ajax({
				url : "${dynamicURL}/salesOrder/salesOrderItemAction!getActCntNewForm.do",
				data : {
					taskId : data.taskId
				},
				dataType : "json",
				type : 'post',
				async : false,
				success : function(data) {
					formData = data;
				}
			});
		//明细内容加载
		var datagridData = "";
		$.ajax({
				url : "${dynamicURL}/salesOrder/salesOrderAction!getPrepareDetailPara.do",
				data : {
					taskId : data.taskId
				},
				dataType : "json",
				type : 'post',
				async : false,
				success : function(data) {
					datagridData = data;
				}
			});
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
		//HR认证
		var f = "0";
		for ( var j = 0; j < datagridData.length; j++) {
			if (datagridData[j].hrcode == undefined
					|| datagridData[j].hrcode == null
					|| datagridData[j].hrcode == "") {
				f = "1";
			}
			//如果订单类型为047(样机订单)不需要HR认证
			if (datagridData[j].orderType == "047") {
				f = "0";
			}
		}
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    	
		//滚动计划标示判断,如果释放标示为1直接释放到计划排定
		//释放标示
		var dataFlag = "";
		$.ajax({
			url : "${dynamicURL}/prepare/prepareOrderAction!getReleaseFlag.do",
			data : {
				orderCode : datagridData[0].orderCode
			},
			dataType : "json",
			type : 'post',
			async : false,
			success : function(data) {
				dataFlag = JSON.stringify(data);
			}
		});
		if ("null" != dataFlag) {
			dataFlag = dataFlag.substring(1, 2);
		}
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//数量判断
		var rollplanNum = "";
		var AllocateNum = "";
		var fOne = 0;
		var fTwo = 0;
		var fFour = 0;
		for ( var k = 0; k < datagridData.length; k++) {
			var paras = "";
			paras = datagridData[k].materialCode + "," + formData.manuEndDate
					+ "," + formData.proFactoryCode;
			//抓取这个物料这个时间内滚动计划的数量
			$.ajax({
					url : "${dynamicURL}/prepare/prepareOrderAction!getRollplanNum.do",
					data : {
						paras : paras
					},
					dataType : "json",
					type : 'post',
					async : false,
					success : function(data) {
						rollplanNum = data.obj;
					}
				});
			//抓取要分配生产工厂     在本周已分配数量
			//抓取生产工厂编码

			var parass = "";
			parass = datagridData[k].orderItemId + ","
					+ datagridData[k].materialCode + "," + formData.manuEndDate
					+ "," + formData.proFactoryCode;
			$.ajax({
					url : "${dynamicURL}/prepare/prepareOrderAction!getAllocatedNum.do",
					data : {
						parass : parass
					},
					dataType : "json",
					type : 'post',
					async : false,
					success : function(data) {
						AllocateNum = data.obj;
					}
				});
// 				 	alert(datagridData[k].budgetOrderQuatity);
// 					alert(rollplanNum-AllocateNum);
// 				 	alert(datagridData[k].quantity);
			if (parseInt(rollplanNum - AllocateNum) >= parseInt(datagridData[k].budgetOrderQuatity)) {
				//计划数量  >= 分配数量(剩余数量)
				//进入计划排定
				fOne++;
			} else {
				//进入滚动计划闸口
				fTwo++;
			}
			fFour++;
		}
		//生产计划结束时间  > T+4周 时间 ,直接计划排定
		var t4datetime = "";
		$.ajax({
			url : "${dynamicURL}/prepare/prepareOrderAction!findT4Date.do",
			dataType : "json",
			type : 'post',
			async : false,
			success : function(data) {
				t4datetime = JSON.stringify(data).substring(1, 11);
			}
		});
		var d2 = new Date(formData.manuEndDate);
		var d5 = new Date(t4datetime);
		if (Date.parse(d2) - Date.parse(d5) > 0) {
			dataFlag = "0";
		}
		// 数据为0不允许保存 
        for(var i = 0; i < datagridData.length; i++){
        	if(datagridData[i].quantity == "0"){
        		dataFlag = "2";
        		break;
        	}
        }
//	    该订单在订单主表中 到HGVS 的标示是否为0，如果为0，则直接释放 到计划排定
		$.ajax({
		 	url : "${dynamicURL}/salesOrder/salesOrderAction!getOrderListByorderCode.do",
		   	data:{
		   		orderCode : datagridData[0].orderCode
		   	    },
		  	dataType:"json",
		   	type:'post',
		   	async:false,
		   	success:function(data){
		   		if(data[0].orderHgvsFlag == "0"){
		   			dataFlag = "0";
		   		}
		   	}
		 });
		 //备货单工厂过滤
		 //生产工厂 CODE formData.proFactoryCode
		 var factoryFlagList;
        $.ajax({
        	url : "${dynamicURL}/prepare/prepareOrderAction!findFactoryFilter.do",
   		  	dataType:"json",
   		   	type:'post',
   		   	async:false,
   		   	success:function(dataFactory){
   		   		for(var m = 0; m < dataFactory.length; m++){
   		   			if(formData.proFactoryCode == dataFactory[m].itemName){
   		   				factoryFlagList = "1";
   		   			}
   		   		}
   		   	}
   		 });
		 
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
		//$.messager.defaults.async = false;
		//数据录入
		var listPrepareOrder = "";
		if (f == "1") {
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.order.hrNotNull">HR认证信息不允许为空!</s:text>', 'error', huidiao);
			$.messager.progress('close');
		} else {
			if ("0" == dataFlag) {
				//进入计划排定
				$.ajax({
						url : "${dynamicURL}/prepare/prepareOrderAction!addworkflowToNextList.do",
						data : {
							taskId : data.taskId,
							'listPrepareOrder' : JSON.stringify(datagridData)
						},
						dataType : "json",
						type : 'post',
						async : false,
						success : function(data) {
							$.messager.progress('close');
						}
					});
				$.messager.progress('close');
				$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', data.orderCode + '<s:text name="global.info.saveSuccess">保存成功</s:text>','info', huidiao);
			}else if ("2" == dataFlag){
				$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.prepareorder.problemQuatity">备货单分配数量有问题请联系管理员!</s:text>','info', huidiao);
	    		$.messager.progress('close');
	    	}else {
				if(factoryFlagList == "1"){
					//进入计划排定
					$.ajax({
						url : "${dynamicURL}/prepare/prepareOrderAction!addworkflowToNextList.do",
						data : {
							taskId : data.taskId,
							'listPrepareOrder' : JSON.stringify(datagridData)
						},
						dataType : "json",
						type : 'post',
						async : false,
						success : function(data) {
							$.messager.progress('close');
						}
					});
					$.messager.progress('close');
					$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', data.orderCode + '<s:text name="global.info.saveSuccess">保存成功</s:text>','info', huidiao);
				}else{
					if (fFour == (fOne + fTwo) && fTwo > 0) {
						$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', data.orderCode + '<s:text name="global.prepareorder.needRelease">订单需要闸口释放,请选择分单进行分备货单操作!</s:text>', 'error', huidiao);
					} else if (fFour == fOne) {
						//进入计划排定
						$.ajax({
							url : "${dynamicURL}/prepare/prepareOrderAction!addworkflowToNextList.do",
							data : {
								taskId : data.taskId,
								'listPrepareOrder' : JSON.stringify(datagridData)
							},
							dataType : "json",
							type : 'post',
							async : false,
							success : function(data) {
								$.messager.progress('close');
							}
						});
					$.messager.progress('close');
					$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', data.orderCode + '<s:text name="global.info.saveSuccess">保存成功</s:text>','info', huidiao);	
					}
				}
			}
		}
		$.messager.progress('close');
	}
	//备货单闸口信息详情
	function showReleasePage() {
		var rows = datagrid.datagrid('getChecked');
		if (rows.length == 1) {
			prepareOrder_detail(rows[0].orderCode);
			showErrorDialog.dialog('open');
		} else {
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.info.selectData">请选择一条数据！</s:text>', 'error');
		}

	}

	//刷新代办和已完成代办
	function reloaddata() {
		datagrid.datagrid('unselectAll');
		datagrid.datagrid('reload');
		top.window.showTaskCount();
	}
</script>
</head>
<jsp:include page="prepareReleaseDel.jsp" />
<body class="easyui-layout">
	<div region="north" border="false" collapsible="true" collapsed="true"
		class="zoc" title="查询条件" style="height: 150px; overflow: auto;">
		<form id="searchForm">
			<div class="navhead_zoc">
				<span><s:text name="global.prepareorder.deliver">分备货单</s:text></span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span><s:text name="global.info.queriesAndoperations">查询与操作</s:text>：</span>
				</div>
				<div class="oneline">
					<div class="item25">
						<div class="itemleft80"><s:text name="global.order.number">订单号</s:text> ：</div>
						<div class="righttext">
							<input type="text" class="short50" name="orderCode"
								id="orderCode" />
						</div>
					</div>
					<div class="item25">
						<div class="oprationbutt">
							<input type="button" onclick="_search();" value="查  询" /> <input
								type="button" onclick="cleanSearch();" value="重置" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center" border="false" class="zoc">
		<table id="datagrid"></table>
	</div>
	<script id='itemList_Template' type="text/template">
		<table cellspacing="0" cellpadding="0" style="width: 350px;padding: 0;margin: 0" class="table2">
			<tbody><tr>
				<th style="height: 23px;">海尔型号</th>
				<th style="height: 23px;">客户型号</th>
				<th style="height: 23px;">物料号</th>
				<th style="height: 23px;">特技单号</th>
				<th style="height: 23px;">数量</th>
			</tr>

		{%  for(var i=0;i<data.length;i++){ %}
			<tr class="bgc1">
				<td>{%= data[i].haierModel %}</td>
				<td>{%= data[i].customerModel %}</td>
				<td>{%= data[i].materialCode %}</td>
				<td>{%= data[i].affirmNum %}</td>
				<td>{%= data[i].prodQuantity %}</td>
			</tr>
		
		{% }  %}

		</tbody></table>
</script>
</body>
</html>