<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>订单锁定</title>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var confPayOrderAddDialog;
	var confPayOrderAddForm;
	var cdescAdd;
	var confPayOrderEditDialog;
	var confPayOrderEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		var code=$('#_customerId').val();
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP+'&customerId='+code
		});
	}
	function countryse(inputId,selectId){
		var name = $('#' + inputId).val()
		var code=$('#countryCodeId').val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do?name=' + name+'&countryCode='+code
		});
	}
	$(function() {
		
		//custCodeId客户编号
		$('#custCodeId').combogrid({
			url : '../basic/customerAction!datagrid0.action',
			idField : 'customerId',
			textField : 'name',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_CNNQUERY',
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
				field : 'customerId',
				title : '客户编号',
				width : 10
			}, {
				field : 'name',
				title : '客户名称',
				width : 10
			} ] ]
		});
		$('#countryId').combogrid({
			url : '${dynamicURL}/basic/countryAction!datagrid.do',
			idField : 'countryCode',
			textField : 'name',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_COUNTRY',
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
				field : 'countryCode',
				title : '国家编号',
				width : 10
			}, {
				field : 'name',
				title : '国家名称',
				width : 10
			} ] ]
		});
		
		iframeDialog = $('#iframeDialog').show().dialog({
			title : 'POP弹出页面',
			modal : true,
			closed : true,
			width:1000,
			hehgth:700
		});
		
	    //查询列表	
	    searchForm = $('#searchForm').form();
		
		datagrid = $('#datagrid').datagrid({
	    	url : '../salesOrder/salesOrderAction!financeLockSalesOrder.action',
			title : '订单列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			//fitColumns : true,
			nowrap : true,
			border : false,
			//singleSelect : true,
			//idField : 'rowId',
			
			toolbar : [ {
				text : '锁定',
				iconCls : 'icon-add',
				handler : function() {
					lockSalesOrder();
				}
			}, '-', {
				text : '解锁',
				iconCls : 'icon-remove',
				handler : function() {
					unlockSalesOrder();
				}
			}, '-', {
				text : '客户锁定或解锁',
				iconCls : 'icon-remove',
				handler : function() {
					showdetail();
				}
			},'-' ],
			frozenColumns : [ [ 
              {
	             field : 'ck',
	             checkbox : true,
	             formatter : function(value, row, index) {
		         return row.kdOrderId;
	          }
              },
			   {field:'ORDER_CODE',title:'订单号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.ORDER_CODE;
					}
				},
			   {field:'FINLOCKID',title:'锁定或解锁备注',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.FINLOCKID!=null&&row.FINLOCKID!=''){
							return "<a href='javascript:void(0)' style='color:blue' onclick='showlockReason(\""
							+ row.ORDER_CODE
							+ "\")'> "
							+ "查看" + "</a>";
						}else{
							return '无';
						}
					}
				},				
				{
					field : 'CONTRACT_CODE',
					title : '合同编号',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.CONTRACT_CODE;
					}
				}, {
					field : 'ORDER_SHIP_DATE',
					title : '出运期',
					align : 'center',

					width : 90,
					formatter : function(value, row, index) {
						return dateFormatYMD(row.ORDER_SHIP_DATE);
					}
				}, {
					field : 'ORDER_CUSTOM_DATE',
					title : '要求到货期',
					align : 'center',

					width : 90,
					formatter : function(value, row, index) {
						return dateFormatYMD(row.ORDER_CUSTOM_DATE);
					}
				}, {
					field : 'CURRENCY',
					title : '币种',
					align : 'center',

					width : 50,
					formatter : function(value, row, index) {
						return row.CURRENCY;
					}
				},{
					field : 'ORDER_TYPE',
					title : '订单类型',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
							return row.ORDER_TYPE;
					}
				},{
					field : 'ORDER_AUDIT_FLAG',
					title : '订单状态',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						if(row.ORDER_AUDIT_FLAG==null){
							return '订单补录';
						}else if(row.ORDER_AUDIT_FLAG=='0'){
							return '订单确认完成';
						}else if(row.ORDER_AUDIT_FLAG=='1'){
							return '订单审核完成';
						}else if(row.ORDER_AUDIT_FLAG=='3'){
							return '调度单锁定状态';
						}else if(row.ORDER_AUDIT_FLAG=='4'){
							return '订单锁定';
						}else if(row.ORDER_AUDIT_FLAG=='2'){
							return '订单删除';
						}else{
							return row.ORDER_AUDIT_FLAG;
						}
						//return row.ORDER_AUDIT_FLAG;
					}
				}					
			 ] ],
			 columns : [ [ {
					field : 'SALE_ORG_NAME',
					title : '销售组织',
					align : 'center',

					width : 130,
					formatter : function(value, row, index) {
						return row.SALE_ORG_NAME;
					}
				}, {
					field : 'ORDER_PO_CODE',
					title : '客户订单号',
					align : 'center',

					width : 150,
					formatter : function(value, row, index) {
						return row.ORDER_PO_CODE;
					}
				}, {
					field : 'DEPT_NAME',
					title : '经营体',
					align : 'center',

					width : 120,
					formatter : function(value, row, index) {
						return row.DEPT_NAME;
					}
				}, {
					field : 'CUSTOMER_MANAGER',
					title : '经营体长',
					align : 'center',

					width : 120,
					formatter : function(value, row, index) {
						return row.CUSTOMER_MANAGER;
					}
				}, {
					field : 'START_PORT',
					title : '始发港',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.START_PORT;
					}
				}, {
					field : 'END_PORT',
					title : '目的港',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.END_PORT;
					}
				}, {
					field : 'saleArea',
					title : '市场区域',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return '待定';
					}
				}, {
					field : 'CUSTOMER_NAME',
					title : '客户名称',
					align : 'center',
					width : 150,
					formatter : function(value, row, index) {
						return row.CUSTOMER_NAME;
					}
				}, {
					field : 'COUNTRY_NAME',
					title : '出口国家',
					align : 'center',

					width : 120,
					formatter : function(value, row, index) {
						return row.COUNTRY_NAME;
					}
				}, {
					field : 'DETAIL_TYPE',
					title : '成交方式',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.DETAIL_TYPE;
					}
				}, {
					field : 'EXECMANAGER_NAME',
					title : '订单执行经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.EXECMANAGER_NAME;
					}
				}, {
					field : 'PROD_NAME',
					title : '产品经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.PROD_NAME;
					}
				}, {
					field : 'TRANS_MANAGER',
					title : '储运经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.TRANS_MANAGER;
					}
				}, {
					field : 'DOC_MANAGER',
					title : '单证经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.DOC_MANAGER;
					}
				}, {
					field : 'REC_MANAGER',
					title : '收汇经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.REC_MANAGER;
					}
				} ] ]
			
		});

	});
	//展示锁定和解锁信息
     function showlockReason(orderNum){
    	var url='${dynamicURL}/payorder/finLockAction!goFinLock.do?orderNum='+orderNum;
    	parent.window.HROS.window.createTemp({
    		title:"订单:"+orderNum+"-锁定信息",
    		url:url,
    		width:500,height:300,isresize:true,isopenmax:false,isflash:false});
    } 
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function _cleanSearch() {
		searchForm.form('clear');
		datagrid.datagrid('load', sy.serializeObject(searchForm));
		
	}
	function showdetail(){
		var url='${dynamicURL}/basic/customerAction!gocustomerLock.action';
		$('#iframe').attr('src',url);
		dialog=$('#iframeDialog').show().dialog({
			title : "客户锁定查询",
			modal : true,
			closed : true,
			minimizable : true,
			maximizable : true
		});
		$("#iframeDialog").dialog("open");
	}
	function lockSalesOrder(){
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要锁定所选订单？', function(r) {
				if (r) {
					
					var lockResion=$('#lockResion').val();
					//alert(lockResion);
					if(lockResion==null||lockResion==''){
						$.messager.alert('警告','请填写锁定理由','warning');
						return;
					}
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].ORDER_CODE+"&";
						else ids=ids+"ids="+rows[i].ORDER_CODE+"&lockRession="+lockResion;
					}
					$.messager.progress({
				    text : '数据加载中....',
				    interval : 100
			        });
					$.ajax({
						url : '../salesOrder/salesOrderAction!lockSalesOrder.do',
						data:ids,
						dataType : 'json',
						success : function(response) {
							$.messager.progress('close');
							if(response.success){
								/* $.messager.show({
									title : '提示',
									msg : response.msg
								}); */
								$.messager.alert('提示',response.msg,'info');
								datagrid.datagrid('reload');
								datagrid.datagrid('unselectAll');
							}else{
								/* $.messager.show({
									title : '提示',
									msg : response.msg
								}); */
								$.messager.alert('警告',response.msg,'error');
							}
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要锁定的订单！', 'error');
		}
	}
	function unlockSalesOrder(){
		var rows = datagrid.datagrid('getSelections');
		
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要解锁所选订单？', function(r) {
				if (r) {
					var lockResion=$('#lockResion').val();
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].ORDER_CODE+"&";
						else ids=ids+"ids="+rows[i].ORDER_CODE+"&lockRession="+lockResion;
					}
					$.messager.progress({
					    text : '数据加载中....',
					    interval : 100
				        });
					$.ajax({
						url : '../salesOrder/salesOrderAction!unLockSalesOrder.do',
						data : ids,
						dataType : 'json',
						success : function(response) {
							$.messager.progress('close');
							if(response.success){
								/* $.messager.show({
									title : '提示',
									msg : response.msg
								}); */
								$.messager.alert('提示',response.msg,'info');
								datagrid.datagrid('reload');
								datagrid.datagrid('unselectAll');
							}else{
								/* $.messager.show({
									title : '提示',
									msg : response.msg
								}); */
								$.messager.alert('警告',response.msg,'error');
							}
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要解锁的订单！', 'error');
		}
	}
</script>
</head>
<body class="easyui-layout zoc">
<div region="north" border="false" title="过滤条件" collapsed="true"  style="height: 150px;overflow: hidden;" align="left">
	<div data-options="region:'north'"  border="false" class="zoc" collapsed="false"  style="height: 169px;width : 100%;overflow: auto;" align="left">
		<form id="searchForm">
			<div class="navhead_zoc"><span>订单查询</span></div>
			<div class="part_zoc" region="north">
			<div class="oneline">
			     <div class="item25">
				    <div class="itemleft80">
					    客户
					</div>
					<div class="righttext">
					<input id="custCodeId" name="orderSoldTo" type="text" class="short50" />
					</div>
				 </div>
			      <div class="item25">
								<div class="itemleft80">订单类型:</div>
								<div class="righttext_easyui">
									<input name="orderType" type="text"
										class="short50 easyui-combobox"
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=0'" />
								</div>
				  </div>
			     <div class="item25">
				    <div class="itemleft80">
					    订单号
					</div>
					<div class="righttext">
					<input name="orderCode" type="text" class="short50" />
					</div>
				 </div>
				  <div class="item25">
								<div class="itemleft80">出口国家:</div>
								<div class="righttext_easyui">
									<input name="countryCode" type="text"
										class="easyui-combobox short50"
										id="countryId" />
								</div>
							</div>
			    </div>
			    <div class="oneline">
			       
				 <div class="item25">
				    <div class="itemleft80">
					   订单创建时间  从
					</div>
					<div class="righttext">
					<input name="createdStart" class="easyui-datetimebox short50"  type="text" />
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					    到
					</div>
					<div class="righttext">
					<!-- <div class="rightbutt"><input name="createdEnd" class="short50"  type="image" src="img/more.png" /></div> -->
					<input name="createdEnd" class="easyui-datetimebox short50"  type="text" /> 
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					    锁定状态
					</div>
					<div class="righttext">
					    <input class="easyui-combobox short50" type="text"  name="orderAuditFlag" data-options="
		                   valueField: 'code',
		                   textField: 'name',
		                   data: [{
			               code: '4',
			               name: '已锁定'
		                   },{
			               code: 'wei',
			               name: '未锁定'
		                   }
		                   ,{
			               code: 'all',
			               name: '全部订单'
		                   }]" />
					</div>
				 </div>
				 
				 <div class="item25">
				    <div class="itemleft80">
					   出运状态
					</div>
					<div class="righttext">
					    <input class="easyui-combobox short50" type="text"  name="shipFlag" data-options="
		                   valueField: 'code',
		                   textField: 'name',
		                   data: [{
			               code: 'start',
			               name: '未出运'
		                   },{
			               code: 'end',
			               name: '已出运'
		                   }
		                   ,{
			               code: 'all',
			               name: '全部订单'
		                   }]" />
					</div>
				 </div>
				 
			   </div>
			</div>
		</form>
		        <div class="oneline">
			        <div class="item100">
				        <div class="oprationbutt">
					       <input type="button" value="查询" onclick="_search();"/>
					       <input type="button" value="清空" onclick="_cleanSearch();"/>
				        </div>
				    </div>
			     </div>
	</div>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	<div region="south" border="false" style="height: 50px">
	    <div class="oneline">
			     <div class="item100">
				    <div class="itemleft">
					   订单锁定原因:
					</div>
					<div class="righttext">
					<input id="lockResion" class="long100" type="text" />
					</div>
				 </div>
				 </div>
	</div>
	
	<div id="iframeDialog" style="display: none;overflow: auto;width: 700px;height: 400px;">
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:99%;">
    </iframe>
    </div>
    
<div id="_CNNQUERY">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">客户编号：</div>
				<div class="righttext">
					<input class="short30" id="_customerId" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short30" id="_CNNINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('_CNNINPUT','custCodeId')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_COUNTRY">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short30" id="countryCodeId" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名称：</div>
				<div class="righttext">
					<input class="short30" id="countryNameId" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="countryse('countryNameId','countryId')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>