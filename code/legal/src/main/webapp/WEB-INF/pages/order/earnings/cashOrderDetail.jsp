<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
$(function(){
	var orderNum=$('#orderNumId').val();
	datagrid = $('#datagrid').datagrid({
		url : '${dynamicURL}/cashorder/cashOrderAction!confitemDategrid0.do?orderNum='+orderNum,
		title : '<s:text name="order.info.detail">明细信息</s:text>',
		iconCls : 'icon-save',
		//pagination : true,
		pagePosition : 'bottom',
		rownumbers : true,
		pageSize : 10,
		pageList : [ 10, 20, 30, 40 ],
		fit : true,
		fitColumns : true,
		nowrap : true,
		border : false,
		//idField : 'orderCode',
		
		
		columns : [ [ 
/* 		{field:'ck',checkbox:true,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				}, */
			{field:'orderNum',title:'<s:text name="global.order.number">订单号</s:text>',align:'center',sortable:true,width:80,
				formatter:function(value,row,index){
					return row.orderNum;
				}
			},
			{field:'cashType',title:'回款类型',align:'center',sortable:true,width:80,
				formatter:function(value,row,index){
					return row.cashType;
				}
			},
		   {field:'payMethodName',title:'付款方式',align:'center',sortable:true,width:80,
				formatter:function(value,row,index){
					return row.payMethodName;
				}
			},				
		   {field:'cashMoney',title:'金额',align:'center',sortable:true,width:150,
				formatter:function(value,row,index){
					return row.cashMoney;
				}
			},
			{field:'currency',title:'币种',align:'center',sortable:true,width:60,
				formatter:function(value,row,index){
					return row.currency;
				}
			},
			{field:'currencyName',title:'币种名称',align:'center',sortable:true,width:60,
				formatter:function(value,row,index){
					return row.currencyName
				}
			},
			{field:'payCode',title:'款项编号',align:'center',sortable:true,width:90,
				formatter:function(value,row,index){
					return row.payCode;
				}
			},
			{field:'ifshouhui',title:'是否已收汇',align:'center',sortable:true,width:90,
				formatter:function(value,row,index){
					if(row.cashType!=null&&row.cashType=='H'){
						return '已收';
					}else{
						return '未收';
					}
				}
			}
		 ] ]
	});
});
function finishCashOrder(){
	var prodrows=datagrid.datagrid('getRows');
	var prodMayList=JSON.stringify(prodrows);
	var taskId=$('#taskIdId').val();
	var orderNum=$('#orderNumId').val();
	$.ajax({
		url:'${dynamicURL}/cashorder/cashOrderAction!saveAndStopTask.action',
		data:{
			cashOrderList:prodMayList,
			taskId:taskId,
			orderNum:orderNum
		},
		dataType:'json',
		success:function(data){
			if(data.success){
				$.messager.alert('提示',data.msg,'info',function(){
					customWindow.reloaddatagrid();
					parent.window.HROS.window.close('cash_'+taskId);
				});
			}else{
				$.messager.alert('警告',data.msg,'error');
			}
		}
	});
}
</script>
</head>
<body class="easyui-layout zoc">

	<div class=" zoc" region="north" border="false" title="过滤条件" collapsed="false"  style="height: 110px;overflow: hidden;" align="left">
	     	 <form id="wanchengshouhui">
	     	 <s:hidden id="taskIdId" name="taskId"></s:hidden>
	     	 <div class="oneline">
	            	<div class="item25">
	                    <div class="itemleft60">订单号:</div>
	                    <div class="righttext">
	                    	<s:textfield type="text" id="orderNumId" name="orderNum" readonly="readonly"></s:textfield>
	                    </div>
	                </div>
	            	<div class="item25">
	                    <div class="itemleft60">客户:</div>
	                    <div class="righttext">
	                    	<s:textfield type="text"  name="cashOrderQuery.customerName" readonly="readonly"></s:textfield>
	                    </div>
	                </div>
	            	<div class="item25">
	                    <div class="itemleft60">经营体:</div>
	                    <div class="righttext">
	                    	<s:textfield type="text"  name="cashOrderQuery.deptName" readonly="readonly"></s:textfield>
	                    </div>
	                </div>
	            	<div class="item25">
	                    <div class="itemleft60">经营体长:</div>
	                    <div class="righttext">
	                    	<s:textfield type="text"  name="cashOrderQuery.deptManager" readonly="readonly"></s:textfield>
	                    </div>
	                </div>
	                
	         </div>
	         <div class="oneline">
	                <div class="item25">
	                    <div class="itemleft60">产品经理:</div>
	                    <div class="righttext">
	                    	<s:textfield type="text"  name="cashOrderQuery.prodManager" readonly="readonly"></s:textfield>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60">订单执行:</div>
	                    <div class="righttext">
	                    	<s:textfield type="text" name="cashOrderQuery.orderExeManager" readonly="readonly"></s:textfield>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60">出口国家:</div>
	                    <div class="righttext">
	                    	<s:textfield type="text"  name="cashOrderQuery.countryName" readonly="readonly"></s:textfield>
	                    </div>
	                </div>
	         
	         </div>
	         <div class="oneline">
	                 <div class="item100 lastitem">
								<div class="oprationbutt">
								<s:if test='taskId!=null&&task!=""'>
								<input type="button"  onclick="finishCashOrder();" value="完成收汇" />
								</s:if> 
								</div>
				    </div>
	         </div>
	         </form>
	</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

</body>
</html>
