 <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>

		<jsp:include page="/common/common_js.jsp"></jsp:include>
		<style type="">
.part_zoc {
	margin: 0 0px 0px;
}
</style>

		<script type="text/javascript" charset="utf-8">
		var datagrid;
		var reasonData;
		/* 缓存修改类型 */
		var typeData;
		/* 根据修改类型id 获取text */
		var typeDataMap={};
		/* 根据修改类型Id 获取修改类型 */
		var editDatatypeMap={};
		var canSubmit=true;
		/* 组code 缓存 */
		var groupMap={};
		var groupMapCount={};
		var gobal_group_code;
		var gobal_flag=true;
		var userCheckMapList={};

		/* 行编辑器 缓存 订单号：正在编辑的行号 */
		var rowEditMap={};
		/* 当前用的权限组 */
		var cuUserCode=${cuUserGroupCodeString};
		/*0：初始化  1：正在执行自动勾选  2：自动勾选成功*/
		var status=0;

		function getTypeDataMap(data) {
			for ( var i = 0; i < data.length; i++) {
				typeDataMap[data[i].id] = data[i].text;
				editDatatypeMap[data[i].id] = data[i].typeType;
				for ( var j = 0; j < data[i].children.length; j++) {
					typeDataMap[data[i].children[j].id] = data[i].children[j].text;
					editDatatypeMap[data[i].children[j].id] = data[i].children[j].typeType;
				}
			}
		}

		$(function() {
			$.ajax({
				url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=ORDER_EDIT&activeFlag=1',
				dataType : 'json',
				async:false,
				success : function(response) {
					reasonData=response;
				}
			});
			$.ajax({
				url:'${dynamicURL}/orderedit/typeConfAction!treegrid.do',
				data:{"activeFlag":"1"},
				dataType : 'json',
				async:false,
				success : function(response) {
					typeData=response;
					getTypeDataMap(typeData);
					<s:if test="batchNo!=null&&orderEditItemJSON.length()!=null">
					var replybachOrders="";
					if(orderEditJSON){
						for(var order in orderEditJSON){
							replybachOrders=replybachOrders+","+order;
						}
					  $.ajax({
						  url : '${dynamicURL}/salesOrder/salesOrderAction!showAllOrderDatagrid.do',
							dataType : 'json',
							data:{"bachOrders":replybachOrders,"showNotEnd":true,"bachAdd":true},
							success : function(response) {
								var selectrows=response.rows;
								if(selectrows.length>0){
									for(var i=0;i<selectrows.length;i++){
									addOrder(selectrows[i]);
									}
								}
								/* 不执行重新选择重做节点的逻辑 */
								gobal_flag=false;
								updateRodoNodeIds(false);
							}
						});
					}
					</s:if>
				}
			});
			
			$("#inputOrderCodes").dialog({
				title : '批量输入订单',
				modal : true,
				<s:if test="batchNo!=null&&orderEditItemJSON.length()!=0">
			closed : true,
			</s:if>
			   <s:else>
			closed : false,   
			   </s:else>
				minimizable : false,
				maximizable : true,
				maximized : false
			});

			datagrid = $('#datagrid').datagrid({
				title : '订单信息列表',
				iconCls : 'icon-save',
				fit : true,
				pagination : false,
				pagePosition : 'bottom',
				rownumbers : true,
				pageSize : 5,
				nowrap : true,
				border : false,
				idField : 'orderCode',
				toolbar: [
					{
						iconCls: 'icon-add',
						text:'增加订单',
						handler: function(){
							$("#inputOrderCodes").dialog("open",true);
						}
					},'-',
				  {
					iconCls: 'icon-add',
					text:'查询',
					handler: function(){
						var url="${dynamicURL}/orderedit/orderEditAction!goSearchOrder.do"
						if($('#iframe').attr('src')!=url){
						$('#iframe').attr('src', url);
						}
						dialog = $('#iframeDialog').show().dialog({
							title : '修改订单选择',
							modal : true,
							closed : true,
							minimizable : true,
							maximizable : true,
							maximized : true
						});
						dialog.dialog('open');
						
					}
				},'-',{
					iconCls: 'icon-remove',
					text:'删除',
					handler: function(){
						var selectrows=datagrid.datagrid("getSelections");
						for(var i=selectrows.length-1;i>=0;i--){
							var rowData=selectrows[i];
							var index=datagrid.datagrid("getRowIndex",rowData);
							datagrid.datagrid("deleteRow",index);
							$("#editItem").datagrid("deleteRow",index);
							$("#nodeTable").tabs('close',index);
						}
						
					}
				},'-',{
					iconCls: 'icon-reload',
					text:'<a id="tootips" href="javascript:void(0)" >复制修改项到其他订单</a>',
					handler: function(){
						$.messager
						.confirm('提示', '你确定要把当前订单的修改项复制到其他订单？',
								function(r) {
									if (r) {
										var orderCode = $($('#nodeTable').tabs('getSelected'))
												.panel("options").title;
										saveEdit(orderCode);

										var oldDatas = datagrid.datagrid("getData").rows;
										var editItemList = $("#item_" + orderCode).edatagrid(
												"getData").rows;
										var redoList = $("#redo_" + orderCode).datagrid(
												"getSelections");

										for ( var i = 0; i < oldDatas.length; i++) {
											var oderEdit = {};
											var oderEditdata = oldDatas[i];
											// 订单号
											if (oderEditdata.orderCode !== orderCode) {
												saveEdit(oderEditdata.orderCode);
												// jQuery.extend({}, editItemList);
												var newEditItemList = [];
												$.extend(true, newEditItemList, editItemList);
												for(var index=0;index<newEditItemList.length;index++){
													var newEditItem=newEditItemList[index];
													if(editDatatypeMap[newEditItem.editItem]=='adjust'){
														newEditItem["beforEdit"]=oderEditdata.orderShipDate;
														//newEditItem["afterEdit"]="";
													}
												}
												$("#item_" + oderEditdata.orderCode).edatagrid(
														"loadData", newEditItemList);
												for ( var j = 0; j < redoList.length; j++) {
													$("#redo_" + oderEditdata.orderCode)
															.datagrid("selectRecord",
																	redoList[j].id);
												}
											}
										}
										$("#submit_apply").hide();
										$("#lock_edit").show();
									}
								});
					}
				}],
				<%@ include file="/WEB-INF/pages/salesorder/_orderColums.jsp" %>,
				// 双击跳转到订单全景图
				onDblClickRow : function(rowIndex, rowData) {
					showPanorama(rowData.orderCode,rowData.orderType);
				}
			});
			
			$('#user_role').datagrid({
				pageSize : 10,
				height : 315,
				singleSelect : false,
				fit : true,
				fitColumns : true,
				nowrap : true,
				border : false,
				idField : 'id',
				columns : [ [ {
					field : 'groupName',
					title : '角色名称',
					width : 100
				}, {
					field : 'empCode',
					title : '角色人员',
					width : 150,
					editor : {
						type : "singlecombogrid",
						options : {
							fit : true,
							required : true,
							panelWidth : 320,
							panelHeigh : 320,
							hasDownArrow : true,
							toolbar : '#tb',
							idField : "empCode",
							textField : "name",
							idField : "empCode",
							columns : [ [ {
								field : 'name',
								title : '姓名',
								width : 100
							}, {
								field : 'empCode',
								title : '员工号',
								width : 100
							} ] ],
							pagination : false
						}
					},
					formatter : function(value, row, index) {
						return row.empCode;
					}
				} ] ],
				onLoadSuccess : function(data) {
				}
			});

			$('#tootips').tooltip({
				position : 'right',
				content : '<span style="color:#fff">点击这个按钮可以把当前订单的修改项复制到其他订单了！！</span>',
				onShow : function() {
					$(this).tooltip('tip').css({
						backgroundColor : '#666',
						borderColor : '#666'
					});
				}
			}).tooltip("show");
			$("#nodeTable").tabs({
				fit : true,
				title : '要重做的节点'
			});

			$('#uploadFile').form({
				url : '${dynamicURL}/basic/fileUploadAction/uplaodFile.do',
				onSubmit : function() {
					canSubmit = false;
				},

				success : function(data) {
					var json = $.parseJSON(data);
					$("#uploadFileId").val(json.obj.id);
					canSubmit = true;
				}
			});
				
		});
		var  orderEditJSON
		var  orderEditItemJSON
		<s:if test="batchNo!=null&&orderEditItemJSON.length()!=null">
		 orderEditJSON=${orderEditJSON};
		 orderEditItemJSON=${orderEditItemJSON};
		</s:if>



		function getChangeType() {
			var value = $("#changeTypeCode").combobox("getValue");
			var datas = $("#changeTypeCode").combobox("getData");
			var record;
			for ( var i = 0; i < datas.length; i++) {
				if (datas[i].id == value) {
					record = datas[i];
					break;
				}
			}
			return record;
		}

		// 增加修改订单
		function addOrder(data) {
			var oldDatas = datagrid.datagrid("getData").rows;
			var hasSelect = false;
			for ( var i = 0; i < oldDatas.length; i++) {
				if (oldDatas[i].orderCode == data.orderCode) {
					hasSelect = true;
					break;
				}
			}
			if (!hasSelect) {
				datagrid.datagrid("appendRow", data);
				$("#nodeTable")
						.tabs(
								'add',
								{
									fit : true,
									title : data.orderCode,
									content : "<div class=\"easyui-layout\" data-options=\"fit:true\" id='layout_"
											+ data.orderCode
											+ "'>"
											+ "<div data-options=\"region:'center',title:'修改项',split:true\" style=\"\"><table id='item_"
											+ data.orderCode
											+ "'></table></div>"
											+ "<div data-options=\"region:'east',title:'选择重做活动',collapsed:false\" style=\"width:305px;padding:5px;background:#eee;\"><table id='redo_"
											+ data.orderCode
											+ "'></table></div> </div>",
									closed : false
								});
				$.parser.parse('#edit_' + data.orderCode);
				var redoOrderDatagrid = $("#redo_" + data.orderCode);
				redoOrderDatagrid
						.datagrid({
							url : "${dynamicURL}/orderedit/orderEditAction!findRedoNode.do?orderCode="
									+ data.orderCode,
							fit : true,
							idField : "id",
							checkOnSelect : true,
							selectOnCheck : true,
							onLoadSuccess : function(data) {
								var orderCode = $(this).attr("id").replace("redo_", "");
								if (orderEditJSON && orderEditJSON[orderCode]) {
									var redoList = orderEditJSON[orderCode].redoList;
									for ( var i = 0; i < redoList.length; i++) {
										$(this)
												.datagrid("selectRecord",
														redoList[i].id);
									}
								}
							},
							columns : [ [ {
								field : 'ck',
								checkbox : true,
								width : 120,
								align : 'center'

							}, {
								field : 'name',
								title : '活动名称',
								width : 120,
								align : 'center'

							}, {
								field : 'end',
								title : '完成时间',
								width : 120,
								align : 'center'
							} ] ],
							onUnselect : function(rowIndex, rowData) {
								var groupJson = rowData.groupMap;
								for ( var i = 0; i < groupJson.length; i++) {
									var count = groupMapCount[groupJson[i].code];
									if (count && count <= 1) {
										delete groupMap[groupJson[i].code];
										groupMapCount[groupJson[i].code] = 0;
									} else if (count && count > 1) {
										groupMapCount[groupJson[i].code] = count - 1;
									}
								}
								if (gobal_flag) {
									updateGroupList();
								}
							},
							onCheck: function(rowIndex, rowData) {
								if($("#submit_apply").is(":hidden")&&status!=1){
									$.messager.alert('提示',"请先【锁定修改项】"); 
									$(this).datagrid("uncheckRow",rowIndex);
									$(this).datagrid("unselectRow",rowIndex);
									return false;
								} 
							},
							onSelect : function(rowIndex, rowData) {
								if($("#submit_apply").is(":hidden")&&status!=1){
									$.messager.alert('提示',"请先【锁定修改项】"); 
									$(this).datagrid("uncheckRow",rowIndex);
									$(this).datagrid("unselectRow",rowIndex);
									return false;
								} 
								var groupJson = rowData.groupMap;
								for ( var i = 0; i < groupJson.length; i++) {
									groupMap[groupJson[i].code] = groupJson[i].name;
									var count = groupMapCount[groupJson[i].code];
									if (count) {
										groupMapCount[groupJson[i].code] = count + 1;
									} else {
										groupMapCount[groupJson[i].code] = 1;
									}
								}
								if (gobal_flag) {
									updateGroupList();
								}
							}
						});
				if (orderEditJSON) {
					if(orderEditJSON[data.orderCode] && orderEditJSON[data.orderCode].redoList){
						var orderRedoList = orderEditJSON[data.orderCode].redoList;
						for ( var m = 0; m < orderRedoList.length; m++) {
							redoOrderDatagrid.datagrid("selectRecord", orderRedoList[m].id);
						}
					}
				}
				// typeData
				$("#item_" + data.orderCode + "")
						.edatagrid(
								{
									fit : true,
									fitColumns : true,
									toolbar : [
											{
												iconCls : 'icon-add',
												text : "增加修改项",
												handler : function() {
													var orderCode = getCurrOrderCode();
													var datagrid = $("#item_"+ orderCode);
													datagrid.edatagrid("appendRow", {"reson":"Q22"});
													var index = datagrid
															.edatagrid("getData").total - 1;
													datagrid
															.edatagrid("editRow", index);
												}
											},
											'-',
											{
												iconCls : 'icon-remove',
												text : "删除修改项",
												handler : function() {
													var orderCode = getCurrOrderCode();
													var itemDatagrid = $("#item_"
															+ orderCode);
													var checkedRows = itemDatagrid
															.edatagrid("getChecked");
													for ( var i = checkedRows.length - 1; i >= 0; i--) {
														var index = itemDatagrid
																.edatagrid(
																		"getRowIndex",
																		checkedRows[i]);
														itemDatagrid.edatagrid(
																"deleteRow", index);
													}
													$("#submit_apply").hide();
													$("#lock_edit").show();
												}
											},
											'-',
											{
												iconCls : 'icon-save',
												text : "<a  id='tooltip_"
														+ data.orderCode
														+ "' class='easyui-tooltip'>保存编辑</a>",
												handler : function() {
													saveAllEdit();
													// var orderCode=getCurrOrderCode();
													// saveAllEdit(orderCode);
												}
											},
											'-',
											{
												iconCls : 'icon-back',
												text : "取消编辑",
												handler : function() {
													var orderCode = getCurrOrderCode();
													var datagrid = $("#item_"
															+ orderCode);
													datagrid.edatagrid("cancelRow");
													saveAllEdit();
												}
											}, '-', {
												iconCls : 'icon-save',
												text : "锁定修改项",
												handler : function() {
													lockEdit();
												}
											} ],
									columns : [ [
											{
												field : 'ck',
												title : '修改项',
												align : 'center',
												checkbox : true

											},
											{
												field : 'editItem',
												title : '修改小项',
												width : 120,
												align : 'center',
												editor : {
													type : "combotree",
													options : {
														required : true,
														data : typeData,
														onChange : function(newValue,
																oldValue) {
														},
														onSelect : function(node) {
															var orderCode = getCurrOrderCode();
															var rowIndex = rowEditMap[orderCode];
															var newValue = node.id;
															var selectedParent = false;
															var parentNode;
															var selectNode;
															for ( var i = 0; i < typeData.length; i++) {
																// 选择了父节点，给予提示
																if (typeData[i].id == newValue) {
																	selectedParent = true;
																	break;
																}
																for ( var j = 0; j < typeData[i].children.length; j++) {
																	if (typeData[i].children[j].id == newValue) {
																		parentNode = typeData[i];
																		selectNode = typeData[i].children[j];
																		break;
																	}
																}
															}
															var ed = $(
																	"#item_"
																			+ orderCode)
																	.edatagrid(
																			"getEditor",
																			{
																				index : rowIndex,
																				field : 'editItem'
																			});
															if (selectedParent) {
																$.messager.alert('提示',
																		'请选择子节点');
																 $(ed.target).combotree(
																		"clear");
															} else {
																if (parentNode
																		&& selectNode) {
																	$(ed.target).combotree(
																	"setText",parentNode.text + "-"
																	+ selectNode.text);
																	
																	var beforEdit = $(
																			"#item_"
																					+ orderCode)
																			.edatagrid(
																					"getEditor",
																					{
																						index : rowIndex,
																						field : 'beforEdit'
																					});
																	var afterEdit = $(
																			"#item_"
																					+ orderCode)
																			.edatagrid(
																					"getEditor",
																					{
																						index : rowIndex,
																						field : 'afterEdit'
																					});

																	// 如果选择正确 判断是否是调T
																	var type = selectNode.typeType;
																	if ("adjust" == type) {
																		// 获取订单的当前出运期
																		var orderCodeDatas = datagrid
																				.datagrid("getData").rows;
																		var orderCodeData = null;
																		for ( var i = 0; i < orderCodeDatas.length; i++) {
																			if (orderCodeDatas[i].orderCode == orderCode) {
																				orderCodeData = orderCodeDatas[i];
																			}
																		}
																		$(
																				beforEdit.target)
																				.val(
																						dateFormatYMD(orderCodeData.orderShipDate));
																		$(
																				afterEdit.target)
																				.val(
																						dateFormatYMD(orderCodeData.orderShipDate));
																	} else {
																		$(
																				beforEdit.target)
																				.val("");
																		$(
																				afterEdit.target)
																				.val("");
																	}
																}
															}
														}
													}
												},
												formatter : function(value, row, index) {
													if (value) {
														var selectedParent = false;
														var paentNode;
														for ( var i = 0; i < typeData.length; i++) {
															// 选择了父节点，给予提示
															if (typeData[i].id == value) {
																selectedParent = true;
																break;
															}
															for ( var j = 0; j < typeData[i].children.length; j++) {
																if (typeData[i].children[j].id == value) {
																	paentNode = typeData[i];
																	break;
																}
															}
														}
														if (selectedParent) {
															$.messager.alert('提示',
																	'请选择子节点');
														}
														return paentNode.text + "-"
																+ typeDataMap[value];
													} else {
														return "";
													}
												}

											},
											{
												field : 'reson',
												title : '修改原因',
												width : 120,
												align : 'center',
												editor : {
													type : "combobox",
													options : {
														data : reasonData,
														required : true,
														value:"Q22",
														valueField : 'itemCode',
														textField : 'itemNameCn'
													}
												},
												formatter : function(value, row, index) {
													if (value) {
														for ( var i = 0; i < reasonData.length; i++) {
															if (reasonData[i].itemCode == value) {
																return reasonData[i].itemNameCn;
															}
														}
													}
												}
											}

											, {
												field : 'beforEdit',
												title : '修改前',
												width : 120,
												editor : {
													type : "text",
													options : {}
												},
												align : 'center'
											}, {
												field : 'afterEdit',
												title : '修改后',
												width : 120,
												editor : {
													type : "text",
													options : {}
												},
												align : 'center'
											}

									] ],
									onDblClickRow : function(rowIndex, rowData) {
										$(this).datagrid('beginEdit', rowIndex);
									},
									onAfterEdit : function(rowIndex, rowData) {
										var orderCode = getCurrOrderCode();
										rowEditMap[orderCode] = null;
									},
									onBeforeEdit : function(rowIndex, rowData) {
										var orderCode = getCurrOrderCode();
										$("#tooltip_" + orderCode)
												.tooltip(
														{
															position : 'top',
															content : '<span style="color:#fff">订单号：'
																	+ orderCode
																	+ '编辑完成后一定要先保存 并且锁定修改项才能进行后续操作！！</span>',
															onShow : function() {
																$(this)
																		.tooltip('tip')
																		.css(
																				{
																					backgroundColor : '#666',
																					borderColor : '#666'
																				});
															}
														}).tooltip("show");
										$("#submit_apply").hide();
										$("#lock_edit").show();
										rowEditMap[orderCode] = rowIndex;
										// $("#layout_"+orderCode).layout("collapse","east");
									}
								});
				if (orderEditItemJSON)
					$("#item_" + data.orderCode + "").datagrid("loadData",
							orderEditItemJSON[data.orderCode]);

				/*
				 * if(orderEditJSON){ var userCheckList=orderEditJSON.userCheckList;
				 * $('#user_'+data.orderCode).edatagrid("loadData",userCheckList); }
				 */
			}
		}

		/*
		 * 锁定编辑
		 */

		function lockEdit() {
			if (saveAllEdit()) {
				status=1;
				updateRodoNodeIds(true);
				$("#submit_apply").show();
				$("#lock_edit").hide();
				status=2;
			}
		}
		/* 显示流程图 */
		function showWorkflowDia(orderCode) {
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
										isresize : true,
										isopenmax : true,
										isflash : false
									});
								}
							}
						});
			}
		}

		function updateRodoNodeIds(needCheckReod) {
			groupMap = {};
			groupMapCount = {};
			gobal_flag = false;
			var oldDatas = datagrid.datagrid("getData").rows;
			for ( var x = 0; x < oldDatas.length; x++) {
				var orderCode = oldDatas[x].orderCode;
				// $("#layout_"+orderCode).layout("expand","east");
				var redoDatagrid = $("#redo_" + orderCode);
				var data = $("#item_" + orderCode + "").datagrid("getData").rows;
				redoDatagrid.datagrid("unselectAll");
				for ( var j = 0; j < data.length; j++) {
					for ( var k = 0; k < typeData.length; k++) {
						for ( var l = 0; l < typeData[k].children.length; l++) {
							if (data[j].editItem == typeData[k].children[l].id) {
								/**
								 * 勾选需要重做的节点
								 */
								if (needCheckReod) {
									var typeBackNodeConfs = typeData[k].children[l].typeBackNodeConfs;
									if (typeBackNodeConfs&& typeData[k].children[l].typeType != 'complate') {
										for ( var i = 0; i < typeBackNodeConfs.length; i++) {
											var typeBackNodeConf = typeBackNodeConfs[i];
											redoDatagrid.datagrid("selectRecord",
													typeBackNodeConf.nodeId.replace(
															"#", ""));
										}
									}
								}
								/**
								 * 增加需要评审的人员
								 */

								var needCheckRole = typeData[k].children[l].switchRoleItems;
								if (needCheckRole != null && needCheckRole != '') {
									var roleCodeArray = needCheckRole.split(",");
									var roleNameArray = typeData[k].children[l].switchRoleItemNames
											.split(",");
									if (roleCodeArray.length == roleNameArray.length) {
										for ( var m = 0; m < roleCodeArray.length; m++) {
											groupMap[roleCodeArray[m]] = roleNameArray[m];
											var count = groupMapCount[roleCodeArray[m]];
											if (count) {
												groupMapCount[roleCodeArray[m]] = count + 1;
											} else {
												groupMapCount[roleCodeArray[m]] = 1;
											}
										}
									}
								}
							}
						}
					}
				}
			}
			gobal_flag = true;
			updateGroupList();
		}

		function updateGroupList() {
			var index_ = 0;
			var groupDatas = [];
			for ( var i in groupMap) {
				// 如果本身自己是这个角色 则不需要审核
				var cuUserNotCode = false;
				if (cuUserCode.length < 4) {
					for ( var q = 0; q < cuUserCode.length; q++) {
						if (cuUserCode[q] == i) {
							cuUserNotCode = true;
						}
					}
				}
				if (!cuUserNotCode) {
					var groupData = {};
					groupData["index"] = index_;
					groupData["groupName"] = groupMap[i];
					groupData["groupCode"] = i;
					groupData["name"] = "请选择";
					groupDatas[index_] = groupData;
					index_++;
				}
			}

			var userRoledatagrid = $('#user_role');
			var gridDatas = userRoledatagrid.datagrid("getData").rows;
			var length = gridDatas.length;
			// 移除多余的
			for ( var j = 0; j < length; j++) {
				var has = false;
				for ( var i = 0; i < groupDatas.length; i++) {
					if (gridDatas[j]
							&& gridDatas[j].groupCode == groupDatas[i].groupCode) {
						has = true;
					}
				}
				if (!has) {
					userRoledatagrid.datagrid("deleteRow", userRoledatagrid.datagrid(
							"getRowIndex", gridDatas[j]));
					// userRoledatagrid.datagrid("beginEdit",userRoledatagrid.datagrid("getData").total-1);
				}
			}

			if (orderEditJSON) {

				for ( var orderCode in orderEditJSON) {
					userCheckList = orderEditJSON[orderCode].userCheckList;
					break;
				}
				if (userCheckList) {
					for ( var z = 0; z < userCheckList.length; z++) {
						var userCheck = userCheckList[z];
						userCheckMapList[userCheck.groupCode] = userCheck;
					}
				}
			}

			// 追加新增加的
			for ( var i = 0; i < groupDatas.length; i++) {
				var has = false;
				for ( var j = 0; j < gridDatas.length; j++) {
					if (gridDatas[j].groupCode == groupDatas[i].groupCode) {
						has = true;
					}
				}

				if (!has) {
					userRoledatagrid.datagrid("appendRow", groupDatas[i]);
					var beginIndex = userRoledatagrid.datagrid("getData").total - 1;
					userRoledatagrid.datagrid("beginEdit", beginIndex);
					var ed = userRoledatagrid.datagrid("getEditor", {
						index : beginIndex,
						field : 'empCode'
					});
					var g = $(ed.target).combogrid("grid");
					var textbox=$(ed.target).combogrid("textbox")[0];
					
					textBoxInput= function(){
						if(searchValue!=''){
						var searchValue=this.value;
						var tempCombo=$(this).parent().prev(".combogrid-f");
						var tempGrid=tempCombo.combogrid("grid");
						var rows=tempGrid.datagrid("getData").rows;
						for(var q=0;q<rows.length;q++){
							var vsString=rows[q].name+rows[q].empCode;
							if(vsString.indexOf(searchValue,0)!=-1){
								tempGrid.datagrid("selectRecord",rows[q].empCode);
								//$(this).combogrid("setValue",rows[q].empCode);
								//$(this).combogrid("setValue",rows[q].empCode);
								}
							}
						tempCombo.combogrid("showPanel");
						}
					}; 
					 if("\v"=="v"){//判断IE
						textbox.onpropertychange = textBoxInput;
					}
					else{
						textbox.addEventListener("input", textBoxInput, false); 
					} 
					g.datagrid("options").url = '${dynamicURL}/orderedit/orderEditAction!findAllUserGroupByGroup.do?groupCode='
							+ groupDatas[i].groupCode;
					if (userCheckMapList && orderEditJSON) {
						if(userCheckMapList[groupDatas[i].groupCode]){
						$(ed.target).combogrid("setValue", userCheckMapList[groupDatas[i].groupCode].empCode);
						$(ed.target).combogrid("setText", userCheckMapList[groupDatas[i].groupCode].name);
						}
					}
				}
			}
		}

		function getCurrOrderCode() {
			return $($('#nodeTable').tabs('getSelected')).panel("options").title;

		}
		function saveEdit(orderCode) {
			var itemDatagrid = $("#item_" + orderCode);
			var total = datagrid.datagrid("getData").total;
			if (rowEditMap[orderCode] != null) {
				total = total + 1;
			}
			var saveValidateResult = true;
			for ( var i = 0; i < total; i++) {
				if (itemDatagrid.datagrid("validateRow", i)) {
					// 进入各种校验
					itemDatagrid.datagrid("endEdit", i);
					// return true;
				} else {
					$.messager.alert("保存失败", "订单号：" + orderCode + "有必填项");
					saveValidateResult = false;
					break;
				}
			}
			return saveValidateResult;
		}

		function saveAllEdit() {
			var oldDatas = datagrid.datagrid("getData").rows;
			for ( var i = 0; i < oldDatas.length; i++) {
				var oderEditdata = oldDatas[i];
				var result = saveEdit(oderEditdata.orderCode);
				if (!result) {
					return false;
				}
			}
			var allResult = true;
			// 必填校验完毕 进入各种闸口校验
			// 运费校验
			var freightObj = {};
			var needValidtaFreight = false;
			for ( var i = 0; i < oldDatas.length; i++) {
				var oderEditdata = oldDatas[i];
				var editRows = $("#item_" + oderEditdata.orderCode)
						.edatagrid("getData").rows;
				for ( var j = 0; j < editRows.length; j++) {
					var editRow = editRows[j];
					if (editDatatypeMap[editRow.editItem] == 'adjust') {
						// 获取出运期
						freightObj[oderEditdata.orderCode] = editRow;
						needValidtaFreight = true;
					}
				}
			}
			if (needValidtaFreight) {
				$.messager.progress({
					text : '正在校验数据....',
					interval : 100
				});
				$.ajax({
							url : '${dynamicURL}/salesOrder/salesOrderAction!validateUpdateFeight',
							dataType : 'json',
							async:false,
							data : {
								"bachOrders" : JSON.stringify(freightObj)
							},
							success : function(response) {
								// $.messager.alert(response.success?'成功':'失败',response.msg);
								if (!response.success) {
									var validateResult = response.obj;
									for ( var validateOrder in validateResult) {
										$.messager
												.alert(
														validateOrder + "运费校验不通过",
														"当前订单运费("
																+ validateResult[validateOrder].oldFeight
																+ "USD)小于调T之后的运费("
																+ validateResult[validateOrder].newFeight
																+ "USD)");
									}
									allResult = false;
									// canSubmit=false;
									// $("#submit_apply").hide();
								}
							}
						});
				if (allResult) {
					$.ajax({
								url : '${dynamicURL}/salesOrder/salesOrderAction!validateLCShipDate',
								dataType : 'json',
								async:false,
								data : {
									"bachOrders" : JSON.stringify(freightObj)
								},
								success : function(response) {
									$.messager.progress('close');
									// $.messager.alert(response.success?'成功':'失败',response.msg);
									if (!response.success&&obj) {
										var validateResult = response.obj;
										$.messager.alert("提示", response.msg);
										allResult = false;
									}
								}
							});
				} else {
					$.messager.progress('close');
				}
			}
			return allResult;
		}
		function submitFile() {
			var fileValue = $('#upload').val();
			if (fileValue && fileValue != '') {
				$('#uploadFile').submit();
			}
		}

		function submitApply() {
			if (canSubmit) {
				$.messager.progress({
					text : '正在提交....',
					interval : 100
				});
				var oldDatas = datagrid.datagrid("getData").rows;
				var json = [];
				var descripbleValue = $("#descripble").val();

				if (descripbleValue == '' || descripbleValue == null) {
					$.messager.progress('close');
					$.messager.alert("提示", "请填写修改描述");
					return;
				}
				var uploadFileId = $("#uploadFileId").val();
				var userRoleDatagrid = $('#user_role');
				var userCheckList = userRoleDatagrid.datagrid("getData").rows;
				// $(ed.target).datebox('setValue', '5/4/2012');
				var isAllow = true;
				for ( var i = 0; i < userCheckList.length; i++) {
					var ed = userRoleDatagrid.datagrid("getEditor", {
						index : i,
						field : 'empCode'
					});
					var selectEmpCode = $(ed.target).combo("getValue");
					if (!selectEmpCode) {
						isAllow = false;
						break;
					} else {
						// $('#user_role').datagrid("")
						var localData = $(ed.target).combogrid("grid").datagrid(
								"getRows");
						for ( var j = 0; j < localData.length; j++) {
							if (localData[j].empCode == selectEmpCode) {
								userCheckList[i]["name"] = localData[j].name
								userCheckList[i]["empCode"] = localData[j].empCode
							}
						}
					}
				}
				if (!isAllow) {
					$.messager.progress('close');
					$.messager.alert("提示", "请选择评审人员！");
					return;
				}
				for ( var i = 0; i < oldDatas.length; i++) {
					var oderEdit = {};
					var oderEditdata = oldDatas[i];
					// 订单号
					oderEdit["orderCode"] = oderEditdata.orderCode;
					saveEdit(oderEditdata.orderCode);

					oderEdit["editItemList"] = $("#item_" + oderEditdata.orderCode)
							.edatagrid("getData").rows;
					oderEdit["redoList"] = $("#redo_" + oderEditdata.orderCode)
							.datagrid("getSelections");
					if (oderEdit["editItemList"].length < 1) {
						$.messager.progress('close');
						$.messager.alert("提示", oderEditdata.orderCode + "请选择修改项！");
						return;
					}
					oderEdit["userCheckList"] = userCheckList;
					oderEdit["uploadFileId"] = uploadFileId;
					oderEdit["descripbleValue"] = descripbleValue;
					json[i] = oderEdit;
				}
				// console.log(JSON.stringify(json));
				$.messager.progress({
					text : '正在提交....',
					interval : 100
				});
				// console.log(JSON.stringify(json));
				$.ajax({
					url : '${dynamicURL}/orderedit/orderEditAction!newOrderEdit',
					dataType : 'json',
					data : {
						"jsonString" : JSON.stringify(json)
					},
					success : function(response) {
						$.messager.progress('close');
						$.messager.alert(response.success ? '成功' : '失败', response.msg);
						if (response.success) {
							canSubmit = false;
							$("#submit_apply").hide();
						}
					}
				});

			}
		}

		function showPanorama(id, orderType) {
			var url = '${dynamicURL}/salesOrder/salesOrderAction!panoramaShow.action?orderCode='
					+ id + '&orderType=' + orderType;
			$('#iframe').attr('src', url);
			dialog = $('#iframeDialog').show().dialog({
				title : '订单全景图',
				modal : true,
				closed : true,
				minimizable : true,
				maximizable : true,
				maximized : true
			});
			dialog.dialog('open');
		}

		function bachAddOrder() {
			$.messager.progress({
				text : '正在添加....',
				interval : 100
			});
			$
					.ajax({
						url : '${dynamicURL}/salesOrder/salesOrderAction!showAllOrderDatagrid.do',
						dataType : 'json',
						data : {
							"bachOrders" : $("#bachOrders").val(),"bachAdd":true
						},
						success : function(response) {
							var selectrows = response.rows;
							for ( var i = 0; i < selectrows.length; i++) {
								addOrder(selectrows[i]);
							}
							$("#inputOrderCodes").dialog('close');
							$.messager.progress('close');
							$.messager.alert('添加成功', '成功添加了【' + response.total
									+ '】 票订单!<br/>(如果有未添加成功的订单,可能该订单已经被挂起)', 'info');
						}
					});

		}
	
</script>
	</head>
	<body>
		<div class="easyui-layout" data-options="fit:true">
			<div region="north" border="false" class="zoc" collapsed="false"
				style="height: 200px; overflow: auto;" align="left">
				<table id="datagrid"></table>
			</div>

			<div region="center" border="false" title="修改详细" class="part_zoc">
				<div class="easyui-layout" id="layout_order" data-options="fit:true">
					<div region="center" data-options="" border="false" class="zoc">
						<div id="nodeTable"></div>
					</div>
					<div region="east"
						data-options="region:'center',title:'选择评审人员',split:true"
						style="width: 400px;">
						<div id='user_role'></div>
					</div>
				</div>
			</div>
			<div region="south" style="height: 100px; margin-left: 0px"
				border="false" class="part_zoc">
				<div style="width: 70%; float: left; height: 100%">
					<div class="partnavi_zoc">
						<span>描述：</span>
					</div>
					<textarea id="descripble" style="width: 100%; height: 80px">${orderEdit.remark}</textarea>
				</div>
				<div style="width: 30%; float: left; height: 100%">
					<div class="oneline">
						<div class="item66" style="400px">
							<div class="itemleft60">
								上传附件：
							</div>
							<div class="righttext">
								<form id="uploadFile" enctype="multipart/form-data"
									method="post">
									${orderEdit.appendix}
									<input id="upload" onchange="submitFile()" type="file"
										name="upload" data-options="" class="short80" />
									<input type="hidden" id="uploadFileId"
										value="${orderEdit.appendix}" />
								</form>
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="oprationbutt">
								<a id="submit_apply" style="display: none;" href="javascript:void(0)">
								<input type="button" onclick="submitApply()" value="提交申请" />
								</a>
								<a id="lock_edit"  href="javascript:void(0)">
								<input type="button" onclick="lockEdit()" value="锁定修改项" />
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="iframeDialog"
			style="display: none; overflow: auto; width: 800px; height: 500px;">
			<iframe name="iframe" id="iframe" src="" scrolling="auto"
				frameborder="0" style="width: 100%; height: 100%;">
			</iframe>
		</div>
		<div id="inputOrderCodes" style="width: 400px;height:200ox">
			用,空格,换行分割,每次最多添加36票订单，可多次添加<br />
		<center>
			<textarea id="bachOrders" style="width: 381px; height: 210px;"></textarea>
		
			<a href="javascript:void(0)" onclick="bachAddOrder()"
				class="easyui-linkbutton" data-options="iconCls:'icon-search'">添加</a>
		</center>
		</div>
		
	</body>
</html>