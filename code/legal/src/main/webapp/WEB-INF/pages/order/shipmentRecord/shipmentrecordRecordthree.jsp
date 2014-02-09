<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
	var lastIndex;
	var showSpecialCntItemDialog;
	var showSpecialCntItemForm;
	var showmessagers;
	$(function() {
		showmessagers = $('#showmessagers').show().dialog({
			title : '校验提示',
			modal : true,
			closed : true,
			height:300,
			weight:200,
			maximizable : true
		});
		//生产工厂下拉框
	    $('#factoryCodeequalId').combobox({
		       url:'${dynamicURL}/security/departmentAction!selectDealType.action',   
		       valueField:'deptCode',   
		       textField:'deptNameCn',
		       multiple:false
		  });
	  //订单执行经理
	     $('#ddzxId').combogrid({
			url : '${dynamicURL}/viallorderview/viAllOrderViewAction!ddzxdatagrid.action',
			idField : 'NAME',
			textField : 'NAME',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_DDZXJL',
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
				field : 'EMPCODE',
				title : '经理工号',
				width : 10
			}, {
				field : 'NAME',
				title : '经理名字',
				width : 10
			} ] ]
		}); 
		
	    //查询列表	
	    searchForm = $('#searchForm').form();
	    showSpecialCntItemForm = $('#importSpecialCntItemForm').form({});
	    showSpecialCntItemDialog = $('#importSpecialCntItemDialog').show().dialog({
			title : '选中对应的Excel',
			modal : true,
			closed : true,
			collapsible : true,
			buttons : [ {
				text : '导入',
				handler : function() {
					$.messager.progress({
						text : '数据加载中....',
						interval : 100
					});
					showSpecialCntItemForm.form('submit',{
						url : '${dynamicURL}/shipmentRecord/shipmentRecordAction!importshipmentFinish.do',
					    success : function(data) {
					    	$.messager.progress('close');
					    	var json = JSON.parse(data);
					    	if(json.success){
					    		if(json.msg==null||json.msg==''){
					    			$.messager.alert('提示','导入成功','info');
					    			datagrid.datagrid('reload');
						    		showSpecialCntItemDialog.dialog("close");
					    		}else{
					    			var mmeess=json.msg.split(',');
									var msfs='';
									if(mmeess!=null&&mmeess.length>0){
										for(var i=0;i<mmeess.length;i++){
											msfs=msfs+'<tr><td>'+mmeess[i]+'</td></tr>';
										}
									}else{
										msfs='<tr><td>'+message+'</td></tr>';
									}
					    			$('#showmessagerid').html(msfs);
									showmessagers.dialog('open');
					    		}
					    	}else{
					    		$.messager.alert('提示',json.msg,'warring');
					    	}
						}
					});
				}
			} ]
		});
	    
	  //加载国家信息
		$('#countryIdtask').combogrid({
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
	    
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/shipmentRecord/shipmentRecordAction!datagrid3.do',
			title : '出运计划备案表列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			//fitColumns : true,
			nowrap : false,
			border : false,
			//idField : 'shipmentRecordId',
			//sortName : 'createDt',
			//sortOrder : 'desc',
			frozenColumns:[[ 
				{field:'ck',checkbox:true,
					formatter:function(value,row,index){
						return row.shipmentRecordId;
					}
				},
				{field:'shipmentRecordId',title:'ROWID',align:'center',width:100,
				formatter:function(value,row,index){
					return row.shipmentRecordId;
				}
				},				
				{field:'tradeMode',title:'贸易方式',align:'center',width:100,
				formatter:function(value,row,index){
					return row.tradeMode;
				},editor:{
					 type:'text',
					 options:{
					     required:true  
					  }
					  
					}
				},				
				{field:'orderCode',title:'订单号',align:'center',width:100,
				formatter:function(value,row,index){
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
				}
			]],
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
				},
				{field:'orderType',title:'订单类型',align:'center',width:150,
					formatter:function(value,row,index){
						return row.orderType;
					}
				},{field:'factoryCode',title:'生产工厂代码',align:'center',width:100,
					formatter:function(value,row,index){
						return row.factoryCode;
					}
				},{field:'salesOrderNo',title:'销售订单号',align:'center',width:100,
					formatter:function(value,row,index){
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
				{field:'haierModelCode',title:'工厂型号',align:'center',width:200,
					formatter:function(value,row,index){
						return row.haierModelCode;
					}
				},
				{field:'customerModelCode',title:'客户型号',align:'center',width:200,
					formatter:function(value,row,index){
						return row.customerModelCode;
					}
				},
				{field:'declarationName',title:'报关品名',align:'center',width:100,
					formatter:function(value,row,index){
						return row.declarationName;
					}
				},
				{field:'parameter',title:'参数',align:'center',width:100,
					formatter:function(value,row,index){
						return row.parameter;
					}
				},
				{field:'propertyName',title:'参数单位',align:'center',width:200,
					formatter:function(value,row,index){
						return row.propertyName;
					}
				},
				   {field:'quantity',title:'数量',align:'center',width:100,
					formatter:function(value,row,index){
						return row.quantity;
					}
				},	
				{field:'price',title:'单价',align:'center',width:100,
					formatter:function(value,row,index){
						return row.price;
					}
				},
				{field:'countryCode',title:'国家',align:'center',width:100,
					formatter:function(value,row,index){
						return row.countryCode;
					}
				},
				{field:'clearanceTime',title:'报关时间',align:'center',width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.clearanceTime);
					}
				},				
			   {field:'shipment',title:'船期',align:'center',width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.shipment);
					}
				},
				{field:'orderExecution',title:'订单执行',align:'center',width:100,
					formatter:function(value,row,index){
						return row.orderExecution;
					}
				},				
			   {field:'remarks',title:'备注',align:'center',width:100,
					formatter:function(value,row,index){
						if(row.remarks!=null&&row.remarks!=''){
							var ra='';
							if(row.remarks.length>4){
								ra=row.remarks.substring(0,4)+'...';
								return "<a href='javascript:void(0)' id='tooltip_a"
								+ row.shipmentRecordId
								+ "'  style='color:blue' class='easyui-tooltip'  >"+ra+"</a>";
							}else{
								return row.remarks;
							}
						}else{
							return ''
						}
					}
				},
			   {field:'submitTime',title:'提交备案时间',align:'center',width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.submitTime);
					}
				},
			   {field:'unusualConfirmReason',title:'订单执行反馈',align:'center',width:100,
					formatter:function(value,row,index){
						if(row.unusualConfirmReason!=null&&row.unusualConfirmReason!=''){
							var confirm='';
							if(row.unusualConfirmReason.length>4){
								confirm=row.unusualConfirmReason.substring(0,4)+'...';
								return "<a href='javascript:void(0)' id='tooltip_c"
								+ row.shipmentRecordId
								+ "'  style='color:blue' class='easyui-tooltip'  >"+confirm+"</a>";
							}else{
								return row.unusualConfirmReason;
							}
						}else{
							return ''
						}
					}
				},
			   {field:'unusualConfirmDate',title:'订单执行回馈时间',align:'center',width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.unusualConfirmDate);
					}
				},
			   {field:'acceptTime',title:'备案接单时间',align:'center',width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.acceptTime);
					}
				},
			   {field:'acceptEmpcode',title:'备案接单人',align:'center',width:100,
					formatter:function(value,row,index){
						return row.acceptEmpcode;
					}
				},
			   {field:'recordEndTime',title:'备案完成时间',align:'center',width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.recordEndTime);
					}
				},
			   {field:'clearanceTimeTrue',title:'报关完成时间',align:'center',width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.clearanceTimeTrue);
					}
				},
			   {field:'customsCode',title:'报关单号',align:'center',width:100,
					formatter:function(value,row,index){
						return row.customsCode;
					}
				}
			 ] ],
			toolbar : [ {
				text : '保存',
				iconCls : 'icon-remove',
				handler : function() {
					save();
				}
			}, '-',{
				text : '导出备案信息修改模版',
				iconCls : 'icon-undo',
				handler : function() {
					daochu();
				}
			}, '-', {
				text : '导入备案案信息修改模版',
				iconCls : 'icon-undo',
				handler : function() {
					importCNTItem();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ],onLoadSuccess : function(data) {
				$("a[id^='tooltip_a']").tooltip(
						{
							position : 'bottom',
							content:'正在加载...',
							deltaX:90,
							onShow:function(e){
								var tooltip=$(this);
								var shipmentRecordId=tooltip.attr("id").replace("tooltip_a","");
								var aa=getCommenta(shipmentRecordId);
								//alert(dd);
								var messageHtmla='<div>'+aa+'</div>'
								tooltip.tooltip('update',messageHtmla);
							}
						});
				$("a[id^='tooltip_b']").tooltip(
						{
							position : 'bottom',
							content:'正在加载...',
							deltaX:90,
							onShow:function(e){
								var tooltip=$(this);
								var shipmentRecordId=tooltip.attr("id").replace("tooltip_b","");
								var bb=getCommentb(shipmentRecordId);
								//alert(dd);
								var messageHtmlb='<div>'+bb+'</div>'
								tooltip.tooltip('update',messageHtmlb);
							}
						});
				$("a[id^='tooltip_c']").tooltip(
						{
							position : 'bottom',
							content:'正在加载...',
							deltaX:90,
							onShow:function(e){
								var tooltip=$(this);
								var shipmentRecordId=tooltip.attr("id").replace("tooltip_c","");
								var cc=getCommentc(shipmentRecordId);
								//alert(cc);
								var messageHtmla='<div>'+cc+'</div>'
								tooltip.tooltip('update',messageHtmla);
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

		shipmentRecordAddForm = $('#shipmentRecordAddForm').form({
			url : 'shipmentRecordAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					shipmentRecordAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		shipmentRecordAddDialog = $('#shipmentRecordAddDialog').show().dialog({
			title : '添加出运计划备案表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					shipmentRecordAddForm.submit();
				}
			} ]
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
				text : '提交',
				handler : function() {
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
									datagrid.datagrid("reload");
									shipmentRecordEditDialog.dialog('close');
									
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


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '出运计划备案表描述',
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
	//根据订单好获得列表中订单的备注
	function getCommenta(shipmentRecordId){
		var rows=datagrid.datagrid('getRows');
		if(rows!=null&&rows.length>0){
			for(var i=0;i<rows.length;i++){
				if(rows[i].shipmentRecordId==shipmentRecordId){
					return rows[i].remarks;
				}
			}
		}else{
			return '';
		}
		return '';
	}
	//根据订单好获得列表中订单的备注
	function getCommentb(shipmentRecordId){
		var rows=datagrid.datagrid('getRows');
		if(rows!=null&&rows.length>0){
			for(var i=0;i<rows.length;i++){
				if(rows[i].shipmentRecordId==shipmentRecordId){
					return rows[i].returnReason;
				}
			}
		}else{
			return '';
		}
		return '';
	}
	//根据订单好获得列表中订单的备注
	function getCommentc(shipmentRecordId){
		var rows=datagrid.datagrid('getRows');
		if(rows!=null&&rows.length>0){
			for(var i=0;i<rows.length;i++){
				if(rows[i].shipmentRecordId==shipmentRecordId){
					return rows[i].unusualConfirmReason;
				}
			}
		}else{
			return '';
		}
		return '';
	}
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function add() {
		shipmentRecordAddForm.form("clear");
		$('div.validatebox-tip').remove();
		shipmentRecordAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].shipmentRecordId+"&";
						else ids=ids+"ids="+rows[i].shipmentRecordId;
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
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url : 'shipmentRecordAction!showDesc.do',
				data : {
					shipmentRecordId : rows[0].shipmentRecordId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					shipmentRecordEditForm.form("clear");
					shipmentRecordEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					shipmentRecordEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
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
			url : 'shipmentRecordAction!showDesc.do',
			data : {
				shipmentRecordId : row.shipmentRecordId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有出运计划备案表描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
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
				url:'${dynamicURL}/shipmentRecord/shipmentRecordAction!updateFinish.action',
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
	//由未办理进入正在办理
	function hege(){
		var rows = datagrid.datagrid('getSelections');
		if(rows!=null&&rows.length>0){
			var shipmentList=JSON.stringify(rows);
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url:'${dynamicURL}/shipmentRecord/shipmentRecordAction!updatestatuss.action',
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
		}else{
			$.messager.alert('提示','请至少选中一条数据','warring');
		}
		
	}
	//出运备案不合格，需要订单执行重新备案
	function buhege(){
		var rows = datagrid.datagrid('getSelections');
		if(rows!=null&&rows.length>0){			
		    shipmentRecordEditDialog.dialog('open');
		}else{
			$.messager.alert('提示','请至少选中一条数据','warring');
		}
	}
	//模糊查询国家下拉列表
	function _CCNMYCOUNTRY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.action?name='+ _CCNTEMP+'&countryCode='+_CCNCODE 
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询国家信息输入框
	function _CCNMYCOUNTRYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/countryAction!datagrid.do'
				});
	}
	
	function daochu(){
		var url='${dynamicURL}/shipmentRecord/shipmentRecordAction!exportShipmentRecordFinish.do';
		$('#searchForm').form('submit',{
			url:url
		});
	}
	function importCNTItem() {	
		showSpecialCntItemDialog.dialog("open");
	}
	
	//订单执行经理
	function _ddzxjldatagrid(inputId,codeid, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		var code=$('#'+codeid).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/viallorderview/viAllOrderViewAction!ddzxdatagrid.action?empCode=' + _CCNTEMP+'&name='+code
		});
	}
</script>
</head>
<body class="easyui-layout">
	<div class=" zoc" title="过滤条件" region="north" border="false" collapsible="true"
					collapsed="true" style="height: 120px; overflow: hidden;">
		<form id="searchForm">
			<div class="oneline">
						<div class="item25">
							<div class="itemleft80">订单号:</div>
							<div class="righttext_easyui">
								<input id="orderCodeid" name="orderCode" type="text" class="short50" />
							</div>
						</div>
						<div class="item25">
							<div class="itemleft80">物料号:</div>
							<div class="righttext_easyui">
								<input name="materialCode" id="materialCodeId" type="text" class="short50" />
							</div>
						</div>
						<div class="item25">
							<div class="itemleft80">出口国家:</div>
							<div class="righttext_easyui">
								<input name="countryCode" type="text" class="short50" id="countryIdtask"
									 />
							</div>
						</div>
						
						<div class="item25">
						    <div class="itemleft80">是否和并报关</div>
							<div class="righttext">
							    <input class="easyui-combobox short50" type="text"  name="shipmentType" data-options="
				                   valueField: 'code',
				                   textField: 'name',
				                   data: [{
					               code: '2',
					               name: '是'
				                   },{
					               code: '1',
					               name: '否'
				                   }
				                   ,{
					               code: '',
					               name: '全部订单'
				                   }]" />
							</div>
				 		</div>
						
			</div>
			
			<div class="oneline">
			            <div class="item25">
						    <div class="itemleft80">生产工厂编号</div>
							<div class="righttext_easyui">
								<input name="factoryCode" id="factoryCodeId" type="text" class="short50" />
							</div>
				 		</div>
				 		<div class="item25">
						    <div class="itemleft80">生产工厂名称</div>
							<div class="righttext_easyui">
								<input name="factoryCodeequal" id="factoryCodeequalId" type="text" class="short50" />
							</div>
				 		</div>
				 		<div class="item25">
						    <div class="itemleft80">销售订单号</div>
							<div class="righttext_easyui">
								<input name="salesOrderNo" id="salesOrderNoId" type="text" class="short50" />
							</div>
				 		</div>
				 		<div class="item25">
						    <div class="itemleft80">订单执行</div>
							<div class="righttext_easyui">
								<input name="unusualConfirmEmpcode" id="ddzxId" type="text" class="short50" />
							</div>
				 		</div>
			</div>
			
			<div class="oneline">
			        <div class="item25 lastitem">
						<div class="oprationbutt">
						<input type="button" onclick="_search();" value="查  询" /> 
						<input type="button" onclick="cleanSearch();" value="重置" /> 
						</div>
					</div>
			</div>
		</form>
	</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	<div id="shipmentRecordAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="shipmentRecordAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>ROWID</th>
							<td>
								<input name="shipmentRecordId" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写ROWID"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>贸易方式</th>
							<td>
								<input name="tradeMode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写贸易方式"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>订单号</th>
							<td>
								<input name="orderCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>账册号</th>
							<td>
								<input name="accountNo" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写账册号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>项号</th>
							<td>
								<input name="itemNo" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写项号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>备案物料号</th>
							<td>
								<input name="recordMaterialsNo" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备案物料号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>版本号</th>
							<td>
								<input name="versionNumber" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写版本号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>备案品名</th>
							<td>
								<input name="recordName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备案品名"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>商品编码</th>
							<td>
								<input name="commodityCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写商品编码"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>备案规格</th>
							<td>
								<input name="specifications" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备案规格"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>订单类型</th>
							<td>
								<input name="orderType" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单类型"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>生产工厂代码</th>
							<td>
								<input name="factoryCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写生产工厂代码"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>销售订单号</th>
							<td>
								<input name="salesOrderNo" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写销售订单号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>物料号</th>
							<td>
								<input name="materialCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写物料号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>工厂型号</th>
							<td>
								<input name="haierModelCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写工厂型号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>客户型号</th>
							<td>
								<input name="customerModelCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写客户型号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>报关品名</th>
							<td>
								<input name="declarationName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写报关品名"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>参数</th>
							<td>
								<input name="parameter" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写参数"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>数量</th>
							<td>
								<input name="quantity" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写数量"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>单价</th>
							<td>
								<input name="price" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写单价"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>总价</th>
							<td>
								<input name="total" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写总价"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>国家</th>
							<td>
								<input name="countryCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写国家"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>报关时间</th>
							<td>
								<input name="clearanceTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写报关时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>船期</th>
							<td>
								<input name="shipment" type="text" class="easyui-datebox" data-options="" missingMessage="请填写船期"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>订单执行</th>
							<td>
								<input name="orderExecution" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单执行"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>备注</th>
							<td>
								<input name="remarks" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写备注"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>提交备案时间</th>
							<td>
								<input name="submitTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写提交备案时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>备案接单时间</th>
							<td>
								<input name="acceptTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写备案接单时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>接单人</th>
							<td>
								<input name="acceptEmpcode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写接单人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>备案完成时间</th>
							<td>
								<input name="recordEndTime" type="text" class="easyui-datebox" data-options="" missingMessage="请填写备案完成时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>报关完成时间</th>
							<td>
								<input name="customsEndDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写报关完成时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>报关单号</th>
							<td>
								<input name="customsCode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写报关单号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>退回时间</th>
							<td>
								<input name="returnDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写退回时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>退回原因</th>
							<td>
								<input name="returnReason" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写退回原因"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>退回人</th>
							<td>
								<input name="returnEmpcode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写退回人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>异常确认时间</th>
							<td>
								<input name="unusualConfirmDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写异常确认时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>异常确认原因</th>
							<td>
								<input name="unusualConfirmReason" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写异常确认原因"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>异常确认人</th>
							<td>
								<input name="unusualConfirmEmpcode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写异常确认人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>状态标志</th>
							<td>
								<input name="statusFlag" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写状态标志"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建时间</th>
							<td>
								<input name="createDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写创建时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>创建人</th>
							<td>
								<input name="createEmpcode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写创建人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>最后修改时间</th>
							<td>
								<input name="lastDate" type="text" class="easyui-datebox" data-options="" missingMessage="请填写最后修改时间"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>最后修改人</th>
							<td>
								<input name="lastEmpcode" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写最后修改人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>其他</th>
							<td>
								<input name="other" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写其他"  style="width: 155px;"/>						
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="shipmentRecordEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="shipmentRecordEditForm" method="post">
			<table class="tableForm">
				<tr>
				    <th>回退原因</th>
					<td>
					    <textarea id="returnReasonId"  name="returnReason" name="rejection" rows="10" cols="35"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>

    <div id="importSpecialCntItemDialog" style="margin-top: 1%; width: 500px;">
		<form id="importSpecialCntItemForm" method="post"
			enctype="multipart/form-data">
			<table class="tableForm">
				<tr style="margin-top: 3%">
					<th>选择未备案模板Excel:</th>
					<td><s:file name="excelFile"></s:file></td>
				</tr>
			</table>
			<input type="hidden" id="specialCntProdQueryList"> 
		</form>
	</div>

	<div id="showCdescDialog" style="display: none;overflow: auto;width: 500px;height: 400px;">
		<div name="cdesc"></div>
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
						onclick="_CCNMYCOUNTRY('_COUNTRYCODE','_COUNTRYINPUT','countryIdtask')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCOUNTRYCLEAN('_COUNTRYCODE','_COUNTRYINPUT','countryIdtask')" />
				</div>
			</div>
		</div>
	</div>
	
	<div id="_DDZXJL">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">经理工号：</div>
				<div class="righttext">
					<input class="short60" id="_ddzxjlcodeId" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">经理名字：</div>
				<div class="righttext">
					<input class="short60" id="_ddzxjlnameId" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_ddzxjldatagrid('_ddzxjlcodeId','_ddzxjlnameId','ddzxId')" />
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