<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>箱单分配明细</title>
<script type="text/javascript">
$(function() {
	//报关行
	$('#custCompany').combogrid({
		url : '${dynamicURL}/basic/vendorAction!datagrid2.do',
		idField : 'vendorCode',
		textField : 'vendorNameCn',
		panelWidth : 500,
		panelHeight : 220,
		pagination : true,
		pagePosition : 'bottom',
		toolbar : '#_VENDER',
		rownumbers : true,
		pageSize : 5,
		pageList : [ 5, 10 ],
		fit : true,
		fitColumns : true,
		required:true,
		columns : [ [ {
			field : 'vendorCode',
			title : '报关行编号',
			width : 10
		}, {
			field : 'vendorNameCn',
			title : '报关行名称',
			width : 10
		} ] ]
	});
    searchForm = $('#searchForm').form();

	datagrid = $('#datagrid').datagrid({
				url : 'custOrderAction!checkTaskBybookCode0.do?definitionKey=packageBillAssign&bookCode='+$('#bookCode').val()+'&mergeCustFlag='+$('#mergeCustFlagId').val(),
				title : '<s:text name="order.info.detail">明细信息</s:text>',
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
				idField : 'orderCode',
				
				
				columns : [ [ 
				{field:'ck',checkbox:true,
							formatter:function(value,row,index){
								return row.orderCode;
							}
						},
					{field:'bookCode',title:'<s:text name="order.bookcabin.bookCode">订舱号</s:text>',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							return row.bookCode;
						}
					},
					{field:'orderCode',title:'<s:text name="global.order.number">订单编号</s:text>',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							return row.orderCode;
						}
					},
					{field:'haierModel',title:'<s:text name="specialschema.haierModel">海尔型号</s:text>',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							return row.haierModel;
						}
					},
				   {field:'customerModel',title:'<s:text name="specialschema.oemType">客户型号</s:text>',align:'center',sortable:true,width:80,
						formatter:function(value,row,index){
							return row.customerModel;
						}
					},				
				   {field:'materialCode',title:'<s:text name="contract.detail.materialCode">物料号</s:text>',align:'center',sortable:true,width:150,
						formatter:function(value,row,index){
							return row.materialCode;
						}
					},				
				   {field:'currency',title:'币种',align:'center',sortable:true,width:150,
						formatter:function(value,row,index){
							return row.currency;
						}
					},
					{field:'prodQuantity',title:'<s:text name="pcm.form.count">数量</s:text>',align:'center',sortable:true,width:60,
						formatter:function(value,row,index){
							return row.prodQuantity;
						}
					},
					{field:'price',title:'<s:text name="order.custorder.price">单价</s:text>',align:'center',sortable:true,width:60,
						formatter:function(value,row,index){
							return Number(row.price).toFixed(2);
						}
					},
					{field:'amount',title:'<s:text name="credit.lettercredit.lcTotal">总额</s:text>',align:'center',sortable:true,width:90,
						formatter:function(value,row,index){
							return Number(row.amount).toFixed(2);
						}
					},
					{field:'freight',title:'<s:text name="global.order.zfConditionValue">运费</s:text>',align:'center',sortable:true,width:60,
						formatter:function(value,row,index){
							return Number(row.freight).toFixed(2);
						}
					},
					{field:'premium',title:'<s:text name="credit.lettercredit.pdCommsion">保费</s:text>',align:'center',sortable:true,width:60,
						formatter:function(value,row,index){
							return Number(row.premium).toFixed(2);
						}
					},
					{field:'custprice',title:'<s:text name="order.custorder.custprice">报关单价</s:text>',align:'center',sortable:true,width:60,
						formatter:function(value,row,index){
							return Number(row.custprice).toFixed(2);
						}
					},
					{field:'custAmount',title:'报关金额',align:'center',sortable:true,width:60,
						formatter:function(value,row,index){
							return Number(row.custAmount).toFixed(2);
						}
					},
					{field:'taskId',title:'任务id',align:'center',sortable:true,width:90,hidden:true,
						formatter:function(value,row,index){
							return row.taskId;
						}
					},
					{field:'assignee',title:'订舱经理',align:'center',sortable:true,width:90,
						formatter:function(value,row,index){
							return row.assignee;
						}
					},
					{field:'mergeCustFlag',title:'报关合并标识',align:'center',sortable:true,width:90,
						formatter:function(value,row,index){
							return row.mergeCustFlag;
						}
					}
				 ] ],
				 onLoadSuccess:function(data){
					//获得抬头信息(抬头信息存放在footer中)
					var footer=datagrid.datagrid('getFooterRows');
					if(footer!=null&&footer.length>0){
						searchForm.form('load',footer[0]);
					}
					var bookCode=$('#bookCode').val();
					var msg=$('#mergeCustFlagId').val();
					if(msg!=null&&msg!=''){
						$('#bookCodeandCust').val(bookCode+'-'+msg);
					}else{
						$('#bookCodeandCust').val(bookCode);
					}
					$('#amountId').val(Number($('#amountId').val()).toFixed(2));
					$('#freightId').val(Number($('#freightId').val()).toFixed(2));
					$('#premiumId').val(Number($('#premiumId').val()).toFixed(2));
					$('#totalId').val(Number($('#totalId').val()).toFixed(2));
					
				},
				onDblClickRow : function(rowIndex, rowData) {
					if (editRow != undefined) {
						datagrid.datagrid('endEdit', editRow);
					}
					datagrid.datagrid('beginEdit', rowIndex);
					editRow = rowIndex;
					datagrid.datagrid('unselectAll');
					datagrid.datagrid('selectRow', rowIndex);
				},
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
});
function save(){
	var company = $('#custCompany').combobox('getValue');
	var orderCode =  "";
	var rows = datagrid.datagrid('getRows');
	var taskIds = "";
	var bookCode = $('#bookCode').val();
	var assignee1=$('#assigneeid').val();
	//sassignee1='123';
	var men='A';
	var mergeCustFlag='';
	for ( var i = 0; i < rows.length; i++) {
		mergeCustFlag=rows[0].mergeCustFlag;
		if(i!=rows.length-1){
			orderCode=orderCode+rows[i].orderCode+",";
			taskIds=taskIds+rows[i].taskId+",";
			
		}
		else{
			taskIds=taskIds+rows[i].taskId;
			orderCode=orderCode+rows[i].orderCode;
		} 
	}
	if(men=='B'){
		$.messager.confirm('提示','此订舱号下有其他人的任务是否一同报关',function(r){
			if(r){
				$.messager.progress({
					text : '数据加载中....',
					interval : 500
				});
				$.ajax({
					url : 'custOrderAction!addCustCompany.do',
					//同步
					//async:false,
					data : {
						bookCode : bookCode,
						custCompany : company,
						orderCode:orderCode,
						taskId:taskIds,
						mergeCustFlag:mergeCustFlag
					},
					dataType : 'json',
					success : function(data) {
						$.messager.progress('close');
						if(data.success){
							$.messager.alert('<s:text name="global.form.prompt">提示</s:text>',data.msg,'info',function(){
								window.parent.HROS.window.close(currentappid);  //关闭当前页，刷新任务列表页
								customWindow.refreshTask();
							});
						}else{
							$.messager.alert('<s:text name="global.form.prompt">提示</s:text>',data.msg,'info');
						}
					}
					
				});
			}
		});
	}else{
		$.messager.progress({
			text : '数据加载中....',
			interval : 500
		});
		$.ajax({
			url : 'custOrderAction!addCustCompany.do',
			//同步
			//async:false,
			data : {
				bookCode : bookCode,
				custCompany : company,
				orderCode:orderCode,
				taskId:taskIds,
				mergeCustFlag:mergeCustFlag
			},
			dataType : 'json',
			success : function(data) {
				$.messager.progress('close');
				if(data.success){
					$.messager.alert('<s:text name="global.form.prompt">提示</s:text>',data.msg,'info',function(){
						window.parent.HROS.window.close(currentappid);  //关闭当前页，刷新任务列表页
						customWindow.refreshTask();
					});
				}else{
					$.messager.alert('<s:text name="global.form.prompt">提示</s:text>',data.msg,'info');
				}
			}
			
		});
	}
	 	  
}
function VENDOR_PORTMY(inputId, selectId) {
	var _CCNTEMP = $('#' + inputId).val()
	$('#' + selectId).combogrid({
		url : '${dynamicURL}/basic/vendorAction!datagrid2.do?vendorNameCn=' + _CCNTEMP
	});
	//$('#' + inputId).val(_CCNTEMP);
}
</script>
</head>
<body class="easyui-layout zoc">
		<div class="zoc" region="north" border="false" collapsible="true"
					collapsed="false" style="height: 130px;">
			<input type="hidden" id="taskId_id" name="taskId" value="${taskId}">
			<form id="searchForm">
			<s:hidden id="assigneeid" name="custOrderQuery.assignee"></s:hidden>
			
	        	<div class="partnavi_zoc"><span><s:text name="order.custorder.packagebill.detail">箱单分配明细</s:text>：</span></div>
	            <div class="oneline">
	            	<div class="item25">
	                    <div class="itemleft60"><s:text name="order.bookcabin.bookCode">订舱号</s:text>：</div>
	                    <div class="righttext">
	                    	<s:textfield type="text" id="bookCodeandCust" name="bookCodeandCust" readonly="readonly"></s:textfield>
	                    	<s:textfield type="hidden" id="bookCode" name="bookCode" readonly="readonly"></s:textfield>
	                    	<s:textfield type="hidden" id="mergeCustFlagId" name="mergeCustFlag" readonly="readonly"></s:textfield>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60"><s:text name="global.order.customerName">客户名称</s:text>：</div>
	                    <div class="righttext">
	                    	<input type="text" readonly="readonly" name="customerName"/>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60"><s:text name="global.order.countryName">出口国家</s:text>：</div>
	                    <div class="righttext_easyui">
							<input type="text" readonly="readonly" name="countryName"/>
						</div>
	                </div>
	                <div class="item25 lastitem">
	                    <div class="itemleft60"><s:text name="order.info.orderDealType">成交方式</s:text>：</div>
	                    <div class="righttext_easyui">
							<input type="text" readonly="readonly" name="orderDealType"/>
						</div>
	                </div>
	             </div>
	             <div class="oneline">
	             	<div class="item25">
	                    <div class="itemleft60"><s:text name="order.confirm.portStart">始发港</s:text>:</div>
	                    <div class="righttext">
	                    	<input type="text" readonly="readonly" name="protStartName"/>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60"><s:text name="order.confirm.portEnd">目的港</s:text>:</div>
	                    <div class="righttext">
	                    	<input type="text" readonly="readonly" name="protEndName"/>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60"><s:text name="global.order.orderShipDate">出运时间</s:text>:</div>
	                    <div class="righttext">
	                    	<input type="text" readonly="readonly" name="orderShipDate"/>
	                    </div>
	                </div>
	                <div class="item25 lastitem">
	                    <div class="itemleft60"><s:text name="global.order.deptName">经营体</s:text>：</div>
	                    <div class="righttext">
	                    	<input type="text" readonly="readonly" name="deptName"/>
	                    </div>
	                </div>
	            </div>
	            <div class="oneline">
	            	<div class="item25">
	                    <div class="itemleft60"><s:text name="order.custorder.custAmount">报关货值</s:text>：</div>
	                    <div class="righttext">
	                    	<input type="text" id="amountId" readonly="readonly" name="amount"/>
	                    </div>
	                </div>
	            	<div class="item25">
	                    <div class="itemleft60"><s:text name="global.order.zfConditionValue">运费</s:text>：</div>
	                    <div class="righttext">
	                    	<input type="text" readonly="readonly" id="freightId" name="freight"/>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60"><s:text name="credit.lettercredit.pdCommsion">保费</s:text>:</div>
	                    <div class="righttext">
	                    	<input type="text" readonly="readonly" id="premiumId" name="premium"/>
	                    </div>
	                </div>
	                <div class="item25 lastitem">
	                    <div class="itemleft60"><s:text name="order.custorder.custtotal">报关总额</s:text>：</div>
	                    <div class="righttext">
	                    	<input type="text" readonly="readonly" id="totalId" name="total"/>
	                    </div>
	                </div>
	            </div>
	            <div class="oneline">
	            	<div class="item25 lastitem">
	                    <div class="itemleft60"><s:text name="order.custorder.custCompany">报关行</s:text>：</div>
	                    <div  class="righttext">
	                    <input id="custCompany" name="custCompany" class="short60" 
								 />
						<!-- <font color="red">*</font> -->
	                    </div>
	                </div>
	                <%-- <s:textfield name="custOrderQuery.assignee"></s:textfield> --%>
	                <div class="item25 lastitem">
	                   <div class="oprationbutt">
	                        <input type="button" onclick="save()" value="<s:text name="global.form.save">保存</s:text>" />
			           </div>
	                </div>
	            </div>		
	        </form>
	   </div>
	   <div region="center" border="false">
		<table id="datagrid" ></table>
	   </div>
	   <div id="_VENDER">
		<div class="oneline">
			<div class="item25">
			    <!-- <div class="itemleft60">报关行编码：</div>
				<div class="righttext">
					<input class="short50" id="VENDOR_" type="text" />
				</div> -->
				<div class="itemleft60">报关行名称：</div>
				<div class="righttext">
					<input class="short50" id="VENDOR_PORTINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="VENDOR_PORTMY('VENDOR_PORTINPUT','custCompany')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>