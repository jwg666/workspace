<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>商务中心审核订单</title>
<jsp:include page="/common/common_js.jsp" />
<script type="text/javascript">
var datagrid;
var orderNum;
var salesOrderSaveForm;
var auditLogAddDialog;
var auditLogAddForm;
$(function() {
	//加载装运方法信息
	$('#orderTransType').combobox({
		url:'${dynamicURL}/salesOrder/salesOrderAction!selectTransType.action',
		valueField:'itemCode',  
	    textField:'itemNameCn'
	});
	$.ajax({
  	     url:"${dynamicURL}/salesOrder/salesOrderAction!selectSalesOrderDetail.action",
  	     data:{
  	    	    orderCode:'${orderNum}'
  	    	  },
  	     dataType:"json",
  	     type:'post',
  	     success:function(data){
	   		$("#salesOrderSaveForm").form('load',data);
	   	    //增加title
	   	    $("#salesOrderSaveForm").find(":text").each(function(){
	   			if($(this).attr("name")!=null && $(this).attr("title")!=null){
	   				$(this).attr("title",$(this).val());
	   			}
	   		});
	   	    ///经营体长code和name组合
			var custString = "("+data.orderCustNamager+")";
			if(data.orderCustName != "" && data.orderCustName != null){
				custString = custString + data.orderCustName;
			}
			$('#orderCustName').attr('title',custString);
			//产品经理code和name组合
			var prodString = "("+data.orderProdManager+")";
			if(data.orderProdName != "" && data.orderProdName != null){
				prodString = prodString + data.orderProdName;
			}
			$('#orderProdName').attr('title',prodString);
			//订舱经理code和name组合
			var tranString ="("+data.orderTransManager+")"; 
			if(data.orderTransManagerName != "" && data.orderTransManagerName != null){
				tranString = tranString + data.orderTransManagerName;
			}
	   	    $('#orderTransManagerName').attr('title',tranString);
	   	    //收汇经理code和name组合
	   	    var recString = "("+data.orderRecManager+")";
			if(data.orderRecManagerName != "" && data.orderRecManagerName != null){
				recString = recString + data.orderRecManagerName;
			}
			$('#orderRecManagerName').attr('title',recString);
			//单证经理code和name组合
			var docString = "("+data.docManager+")";
			if(data.docManagerName != "" && data.docManagerName != null){
				docString = docString + data.docManagerName;
			}
	   	    $('#docManagerName').attr('title',docString);
	   	    //订单经理code和name组合
	   	    var orderString = "("+data.orderExecManager+")";
			if(data.orderExecName != "" && data.orderExecName != null){
				orderString = orderString + data.orderExecName;
			}
	   	    $('#orderExecName').attr('title',orderString);
	     	//收货人code和name组合
			var orderShipString = "("+data.orderShipTo+")";
			if(data.orderShipToName != "" && data.orderShipToName != null){
				orderShipString = orderShipString + data.orderShipToName;
			}
	   	    $('#orderShipToName').attr('title',orderShipString);
	   	    //售达方code和name组合
			var orderSoldString = "("+data.orderSoldTo+")";
			if(data.orderSoldToName != "" && data.orderSoldToName != null){
				orderSoldString = orderSoldString + data.orderSoldToName;
			}
	   	    $('#orderSoldToName').attr('title',orderSoldString);
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
  	     }
	});
	auditLogAddDialog = $('#auditLogAddDialog').show().dialog({
		title : '请填写审核不通过理由',
		modal : true,
		closed : true,
		height:300,
		weight:200,
		maximizable : true,
		buttons : [ {
			text : '提交',
			handler : function() {
				auditLogAddForm.submit();
			}
		} ]
	});
	auditLogAddForm = $('#auditLogAddForm').form({
		url : '${dynamicURL}/audit/auditLogAction!saveLog.do',
		success : function(data) {
			var json = $.parseJSON(data);
			if (json && json.success) {
				$.messager.alert('提示',json.msg,'info');
				//代办刷新
				customWindow.reloaddata();
				//关闭当前页
				parent.window.HROS.window.close(currentappid);
			} else {
				$.messager.alert('提示',json.msg,'error');
			}
		}
	});
	orderNum=$('#orderCode').val();
datagrid = $('#datagrid').datagrid({
	url : 'auditDetailAction!datagrid0.action?orderNum='+orderNum,
	title : '明细信息',
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
	showFooter:true,
	//idField : 'rowId',
	columns : [ [ 
	   {field:'prodType',title:'产品大类',align:'center',sortable:true,
			formatter:function(value,row,index){
				return row.prodType;
			}
		},				
	   {field:'haierModel',title:'海尔型号',align:'center',sortable:true,
			formatter:function(value,row,index){
				return row.haierModel;
			}
		},				
	   {field:'customerModel',title:'客户型号',align:'center',sortable:true,
			formatter:function(value,row,index){
				return row.customerModel;
			}
		},				
	   {field:'affirmNum',title:'特技单号',align:'center',sortable:true,
			formatter:function(value,row,index){
				return row.affirmNum;
			}
		},				
	   {field:'materialCode',title:'物料号',align:'center',sortable:true,
			formatter:function(value,row,index){
				return row.materialCode;
			}
		},				
	   {field:'price',title:'单价',align:'center',sortable:true,
			formatter:function(value,row,index){
				return row.price;
			}
		},				
	   {field:'prodQuantity',title:'数量',align:'center',sortable:true,
			formatter:function(value,row,index){
				return row.prodQuantity;
			}
		},				
	   {field:'amount',title:'总金额',align:'center',sortable:true,
			formatter:function(value,row,index){
				return row.amount;
			}
		} , {field:'hrNum',title:'HR认证号',align:'center',sortable:true,
			formatter:function(value,row,index){
				return row.hrNum;
			}
		} , {field:'hrDate',title:'HR有效期',align:'center',sortable:true,
			formatter:function(value,row,index){
				return dateFormatYMD(row.hrDate);
			}
		} , {field:'delisting',title:'是否下市',align:'center',sortable:true,
			formatter:function(value,row,index){
				//return row.delisting;
				if(row.delisting=='1'){
					return '是';
				}else{
					return '否';
				}
			}
		} , {field:'haveBom',title:'是否有bom',align:'center',sortable:true,
			formatter:function(value,row,index){
				if(row.haveBom=='1'){
					return '有';
				}else if(row.haveBom=='0'){
					return '没有';
				}else{
				    return row.haveBom;					
				}
			}
		}, {field:'failureRate',title:'故障率',align:'center',sortable:true,
			formatter:function(value,row,index){
				
				if(row.failureRate=='Y'){
					return "小于标准";
				}else if(row.failureRate=='N'){
					return "高于标准";
				}else{
					return row.failureRate;
				}
			}
		}, {field:'qualityProblem',title:'质量问题',align:'center',sortable:true,
			formatter:function(value,row,index){
				if(row.qualityProblem=='Y'){
					return '无';
				}else if(row.qualityProblem=='N'){
					return "有";
				}
				return row.qualityProblem;
			}
		}, {field:'haveRollPlan',title:'滚动计划',align:'center',sortable:true,
			formatter:function(value,row,index){
				if(row.haveRollPlan=='Y'){
					return "有";
				}else if(row.haveRollPlan=='N'){
					return "无";
				}
				return row.haveRollPlan;
			}
		}/* , {field:'cwFlag',title:'价值评审结果',align:'center',sortable:true,
			formatter:function(value,row,index){
				if(row.cwFlag=='1'&&row.prodType!='总结'){
					return "通过";
				}else if(row.prodType!='总结') {
					return "不通过";
				}
			}
		}	 */			
	 ] ]
});
});
function dayin(){
	var printObj = $("#printBody").clone(true);
	printObj.width(1220);
	printObj.find("#optBnts").remove();
	printObj = gridToTable(printObj);
	printObj.find("#datagridDiv table").addClass("table2").width("100%").parent().addClass("part_zoc").width("100%");
	var count = lodopPrintAutoWidth(printObj);
}
//商务经理审核通过
function check(){
	 var taskId=$('#taskId').val();
	var assignee=$('#assignee').val();
	$.messager.progress({
		text : '数据加载中....',
		interval : 100
	    });
	$.ajax({
		url : '${dynamicURL}/audit/auditMainAction!bussinessManagerCheckOrder.do',
		data : {
			orderNum : orderNum,
			taskId : taskId,
			assignee:assignee
		},
		dataType : 'json',
		cache : false,
		success : function(response){
			$.messager.progress('close');
			if(response.success){
				$.messager.alert('提示',response.msg,'info',function(){
					//代办刷新
					customWindow.reloaddata();
					//关闭当前页
					parent.window.HROS.window.close(currentappid);
				});
				
			}else{
				$.messager.alert('提示',response.msg,'error');
			}
		}
	}); 
}
//订单执行经理审核拒绝
function checkrefuse1(){
	 var taskId=$('#taskId').val();
	 var url = '${dynamicURL}/audit/auditLogAction!goAuditLog.action?taskId='+taskId;
		//var url='techOrderAction!goModelManagerCheck.action';
		parent.window.HROS.window.close('yijian' + taskId);
		var appid = parent.window.HROS.window.createTemp({
			title : "商务审核意见",
			url : url,
			appid : 'yijian' + taskId,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : false,
			isflash : false,
			customWindow : window
		});
}
function checkrefuse() {
	auditLogAddForm.form("clear");
	$('#orderNumId').val($('#orderCode').val());
	$('#taskIdOfauditId').val($('#taskId').val());
	$.ajax({
		url:'${dynamicURL}/audit/auditMainAction!getuserName.do',
		dataType:'json',
		success:function(json){
			if(json.success){
				$('#rejectionNameId').val(json.obj);
				auditLogAddDialog.dialog('open');
			}else{
				$.messager.alert('提示','无法识别当前登录人','error');
			}
		}
	});
}
function downLoad(){
	var filePath=$('#file').val();
	//var filePath='dd';
	var downloadfile=$('#downloadfile')
	//downloadfile[0].click();
	$.ajax({
		url : '${dynamicURL}/audit/auditMainAction!ifCanBeDownLoad.action',
		type:'post',
		data :{
			fileId : filePath
		},
		dataType : 'json',
		success : function(response){
			if(!response.success){
				$.messager.alert('提示',response.msg,'warning');
			}else if(response.success){
				downloadfile[0].click();
			}
		}
		
	}); 
	
}
//手动出发订单评审
function pingshen(){
	var orderNum =$('#orderCode').val();
	$.ajax({
		url:'${dynamicURL}/audit/auditMainAction!review.do',
		data:{
			orderNum:orderNum
		},
		dataType:'json',
		success:function(data){
			if(data.success){
				//评审成功
				$.messager.alert('提示',data.msg,'info',function(){
					parent.showdetail(orderNum);
				});
			}else if(data.msg=='评审没有通过'){
				//评审失败
                 $.messager.alert('提示',data.msg,'info',function(){
                	 parent.showdetail(orderNum);
				});
			}else{
				//评审出现异常
               $.messager.alert('提示',data.msg,'error');
			}
		}
	});
	
}
function remarkssave(remarkid){
	var orderNum =$('#orderCode').val();
	var remarks=$('#'+remarkid).val();
	if(remarks!=null&&remarks!=''){
		$.ajax({
			url:'${dynamicURL}/audit/auditMainAction!saveremnarks.do',
			data:{
				orderNum:orderNum,
				remarks:remarks,
				auditItem:remarkid
			},
			dataType:'json',
			success:function(json){
				if(json.success){
					$.messager.alert('提示',json.msg,'info');
				}else{
					$.messager.alert('提示',json.msg,'error');
				}
			}
		});
	}else{
		$.messager.alert('提示','不能为空','warring');
	}
}
</script>
</head>
<body>
	<s:hidden name="rowId"/>
	<s:hidden name="taskId" id="taskId"/>
	<s:hidden name="assignee" id="assignee"></s:hidden>
	<s:hidden name="salesOrder.orderAttachments" id="file"></s:hidden>
	<%-- <s:textfield name="rowId"></s:textfield>
	<s:textfield name="taskId"></s:textfield> --%>
	<div  style="overflow: auto;min-width: 1220px" align="center" class="zoc" id="printBody" >
	<div class="part_zoc">
	<div class="navhead_zoc"><span>订单评审结果</span></div>
	<div class="oneline" id="optBnts">
         <div class="item33">
		 <div class="oprationbutt">
			  <input type="button" value="打印" onclick="dayin();"/>
			  <s:if test='taskId!=null&&taskId!=""'>
			     <input type="button" value="审核通过" onclick="check();"/>
			      <input type="button" value="审核拒绝" onclick="checkrefuse();"/>
			  </s:if>
			   <s:if test='ifReview=="yes"'>
			      <input type="button" value="订单评审" onclick="pingshen();"/>
			   </s:if>
		 </div>
		 </div>
	</div>
			<div class="partnavi_zoc"> 
				<span>基本信息</span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">订单号:</div>
					<div class="rightselect_easyui">
						<s:textfield name="salesOrder.orderCode" readonly="true" id="orderCode"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">客户订单号：</div>
					<div class="righttext">
						<s:textfield name="salesOrder.orderPoCode" readonly="true" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">订单类型：</div>
					<div class="righttext">
						<s:textfield name="salesOrder.orderTypeName" readonly="true"/>
					</div>
				</div>
			</div>
			
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">合同客户：</div>
					<div class="righttext">
						<s:textfield name="salesOrder.orderShipTo" readonly="true"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">是否贸易公司：</div>
					<div class="righttext">
						<s:textfield name="salesOrder.orderExpressFlag" readonly="true"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">付款保障：</div>
					<div class="righttext">
						<s:textfield name="salesOrder.orderNegoSubject" readonly="true"/>
					</div>
				</div>
			</div>
			<div class="oneline">
			    <div class="item100">
					<div class="itemleft">备注:</div>
					<div class="righttext_easyui">
						<s:textfield id="commentsid" name="salesOrder.comments" type="text" cssClass="long100">
						</s:textfield>
					</div>
				</div> 
			    <%-- <div class="item100">
					<div class="itemleft">备注：</div>
					<div class="righttext">
						<s:textfield name="salesOrder.comments" readonly="true"/>
					</div>
				</div> --%>
			</div>
    <table  class="table2" cellpadding="0" cellspacing="0">
    <tr class="trnavi">
        <th colspan="2" >项目</th>
        <th style="width: 200px">内容</th>
        <th style="width: 150px">评审数值</th>
        <th >评审评价</th>
        <th style="width: 200px">评审备注</th>
        <th >推进方式</th>
    </tr>
    <s:iterator value="listOrderAuditSet" id="a">
        <tr>
       <s:if test="#a.counta!=0">
           <td rowspan="<s:property value="#a.counta"/>">
               <s:property value="#a.subjectA"/>
           </td>
       </s:if>
       <s:if test="#a.countb!=0">
           <td rowspan="<s:property value="#a.countb"/> ">
               <s:property value="#a.subjectB"/>
           </td>
       </s:if>
        <td>
           <s:property value="#a.auditContent"/>
          </td>
       <s:if test="#a.countc==2">
        <td style="background-color: #EE9A00;" >
           <s:property value="#a.auditValue" />
        </td>
       </s:if><s:else>
           <td >
           <s:property value="#a.auditValue" escape="false" />
          </td>
       </s:else>
       <td>
           <s:property value="#a.auditMainValue"/>
       </td>
       
        <s:if test="#a.countd==2">
        <td>
                <div class="rightselect_easyui">
				    <input name="<s:property value="#a.code"/>" value="<s:property value="#a.remarks"/>" id="<s:property value="#a.code"/>" />
				</div>
				<div class="oprationbutt">
				    <input type="button" value="提交" onclick="remarkssave('<s:property value="#a.code"/>');"/>
				</div>
       </td>
       </s:if><s:else>
           <td>
           <s:property value="#a.remarks"/>
           </td>
       </s:else>
       <td>
           <s:property value="#a.promoteDept" escape="false"/>
       </td>
       </tr>
    </s:iterator>
       <tr class="trnavi" style="border-top: 1px solid #979a9d;">
        <td>订单最终评审结果:</td>
        <td><s:textfield name="auditResults" readonly="true"></s:textfield></td>
        <td>订单审核人:</td>
        <td><s:textfield name="salesOrder.orderCustNamager" readonly="true"></s:textfield></td>
        <td>&nbsp;　</td>
        <td>&nbsp;　</td>
       </tr>
       <tr class="trnavi" style="border-top: 1px solid #979a9d;">
        <td>订单最终评审时间:</td>
        <td><s:textfield name="auditDate" readonly="true"></s:textfield></td>
        <td>附件:${salesOrder.fileName} </td>
        <td>
        	<div class="item25 lastitem">
	            <div class="righttext">
				   <a href="${dynamicURL}/basic/downloadFile!downloadFile.action?fileId=${salesOrder.orderAttachments}" id="downloadfile"></a> 
				  <div class="oprationbutt">
				      <input type="button" value="下载附件" onclick="downLoad();"/>
				  </div>
	            </div>
            </div>
        </td> 
        <td>&nbsp;　</td>
        <td>&nbsp;　</td>
       </tr>
    </table>
    <%-- <div class="oneline">
        <div class="item33">
        <div class="itemleft">
                                 订单最终评审结果:
           </div>
           <div class="righttext">
           <s:textfield name="auditResults" readonly="true"></s:textfield>
           </div>
        </div>
        <div class="item33">
            <div class="itemleft">
                                 订单审核人:
           </div>
           <div class="righttext">
              <s:textfield name="salesOrder.orderCustNamager" readonly="true"></s:textfield>
           </div>
        </div>
        <div class="item33"></div>
    </div>
    <div class="oneline">
        <div class="item33">
         <div class="itemleft">
                                 订单最终评审时间:
          </div>
           <div class="righttext">
            <s:textfield name="auditDate" readonly="true"></s:textfield>
            </div>
        </div>
        <div class="item33">
         <div class="itemleft">
                                附件:
          </div>
           <div class="righttext">
			   ${salesOrder.fileName}
            </div>
        </div>
        <div class="item33">
           <div class="righttext">
			   <a href="${dynamicURL}/basic/downloadFile!downloadFile.action?fileId=${salesOrder.orderAttachments}" id="downloadfile"></a> 
			  <div class="oprationbutt">
			      <input type="button" value="下载附件" onclick="downLoad();"/>
			  </div>
            </div>
        </div>
    </div> --%>
    </div>
    
    <div region="north"   split="true" style="height:298px;"  collapsed="false" >
        <form id="salesOrderSaveForm" method="post" enctype="multipart/form-data">
        <input  type="hidden"  name="multipeOrder"  id="multipeOrder" />
        <input  type="hidden"  name="orderType"  id="orderType" />
	        <div class="part_zoc" >
	            <s:hidden id="orderCode" name="orderCode" />
				<div class="partnavi_zoc">
					<span>订单状态：</span>
				</div>
	        	<table  class="table2 " cellpadding="0" cellspacing="0" id="formDivId">
		        	<tr class="trnavi" style="border-top: 1px solid #979a9d;">
		        		<td>是否导HGVS：</td>
		        		<td colspan="2"><input id="orderHgvsFlag" name="orderHgvsFlag" class="short30"  type="checkbox" onclick="loadOrderNoHGVS();"  value="1"/></td>
		        		<td>外销快递：</td>
		        		<td colspan="2"><input id="orderExpressFlag" name="orderExpressFlag" class="short50"  type="checkbox" value="1"  onclick="loadOrderYesExpress();"/></td>
		        		<td>是否商检：</td>
		        		<td colspan="3"><input id="orderInspectionFlag" name="orderInspectionFlag" class="short50"  onclick="loadOrderNoCheck();" type="checkbox" value="1"/></td>
		        	</tr>
					<tr >
				    
							<td>订单编号：</td>
							<td>
								<input id="orderCode" name="orderCode"  disabled="true"  type="text" 
									class="short50" />
							</td>
					
							<td>合同编号：</td>
							<td>
								<input id="contractCode" name="contractCode"  disabled="true" type="text"  
									class="short50" />
							</td>
				    
							<td>订单类型：</td>
							<td>
								<input id="orderTypeName" name="orderTypeName"  disabled="true" type="text" 
									class="short50" />
							</td>
					
							<td>创建日期：</td>
							<td>
								<input id="orderCreateDate" name="orderCreateDate"  disabled="true"  type="text" 
									class="short50" />
							</td>
					
							<td>销售组织：</td>
							<td>
								<input id="salesOrgName" name="salesOrgName"  disabled="true" type="text" title=""  
									class="short50" />
							</td>
				</tr>
				<tr>
					
							<td>销售大区：</td>
							<td>
								<input id="saleAreaName" name="saleAreaName"  disabled="true" type="text" title=""  
									class="short50" />
							</td>
					
							<td>经营体：</td>
							<td>
								<input id="deptName" name="deptName"  disabled="true" type="text"  title=""  
									class="short50" />
							</td>
					
							<td>经营体长：</td>
							<td>
								<input id="orderCustName" name="orderCustName"  disabled="true" type="text" title=""  
									class="short50" />
							</td>
					
							<td>产品经理：</td>
							<td>
								<input id="orderProdName" name="orderProdName"  disabled="true" type="text" title=""
									class="short50" />
							</td>
							<td>订舱经理：</td>
							<td>
								<input id="orderTransManagerName" name="orderTransManagerName"  disabled="true" type="text" title=""
									class="short50" />
							</td>
				</tr>
				<tr>
				
						<td>收汇经理：</td>
						<td>
							<input id="orderRecManagerName" name="orderRecManagerName"  disabled="true" type="text" title=""
								class="short50" />
						</td>
					
				        <td>单证经理：</td>
						<td>
							<input id="docManagerName" name="docManagerName"  disabled="true" type="text"  title=""
									class="short50" />
						</td>
				    
						<td>订单经理：</td>
						<td>
							<input id="orderExecName" name="orderExecName"  disabled="true" type="text"  title=""
								class="short50" />
						</td>
				    
							<td>是否买断：</td>
							<td>
								<input id="orderBuyoutFlag" name="orderBuyoutFlag"  type="checkbox"  disabled="true" 
									class="short80"  type="text" value="1"/>
							</td>
							<td>是否锁定汇率：</td>
							<td>
								<input id="orderLockexchangeFlag" name="orderLockexchangeFlag"  type="checkbox"  disabled="true"
									class="short80" type="text" value="1"/>
							</td>
				</tr>
				<tr>
					
				         <td>终端客户订单号：</td>
						 <td>
								<input id="orderPoCode" name="orderPoCode"  disabled="true" title=""
									class="short50" type="text" />
						 </td>
				     
				         <td>总运费：</td>
						 <td>
								<input id="freight" name="freight"  disabled="true"
									class="short50" type="text" />
						 </td>
				    
						<td>出口国家：</td>
						<td>
							<input id="countryName" name="countryName" class="short50"  disabled="true" type="text" title=""/>
						</td>
					
						<td>收货人：</td>
						<td>
							<input id="orderShipToName" name="orderShipToName" class="short50" disabled="true" type="text"  title=""/>
						</td>
						<td>售达方：</td>
						<td>
							<input id="orderSoldToName" name="orderSoldToName" class="short50"  disabled="true" type="text" title=""/>
						</td>
				</tr>
				<tr>
					 
						<td>运输方式：</td>
						<td>
							<input id="orderShipmentName" name="orderShipmentName" class="short50"  disabled="true" type="text" />
						</td>
				    
						<td>始发港：</td>
						<td>
							<input id="portStartName" name="portStartName" class="short50"  disabled="true" type="text"  title=""/>
						</td>
				     
						<td>目的港：</td>
						<td>
							<input id="portEndName" name="portEndName" class="short50"  disabled="true"  type="text" title=""/>
						</td>
				    
						<td>运输公司：</td>
						<td>
							<input id="vendorName" name="vendorName" class="short50"  disabled="true" type="text" title=""/>
						</td>
						<td>出运时间：</td>
						<td>
							<input id="orderShipDate" name="orderShipDate" class="short50"  disabled="true" type="text" />
						</td>
					</tr>
				<tr>
				    
						<td>要求到货日：</td>
						<td>
							<input id="orderCustomDate" name="orderCustomDate" class="short50"  disabled="true" type="text" />
						</td>
				      
				        <td>成交方式：</td>
						<td>
							<input id="orderDealName" name="orderDealName"  disabled="true" type="text"
									class="short50" />
						</td>
				    
							<td>兑美元汇率：</td>
							<td>
								<input id="toUsaExchange" name="toUsaExchange"  disabled="true" type="text"
									class="short50" />
							</td>
					
							<td>兑人民币汇率：</td>
							<td>
								<input id="toCnyExchange" name="toCnyExchange"  disabled="true" type="text"
									class="short50" />
							</td>
					
				        <td>币种：</td>
						<td>
							<input id="currency" name="currency"  disabled="true" type="text"
						  		 class="short50" />
						</td>
				</tr>
				<tr>
				     
				        <td>订单付款周期：</td>
						<td>
								<input id="orderPaymentCycle" name="orderPaymentCycle"  disabled="true" type="text"
									class="short50" />
						</td>
				    
				        <td>合同付款方式：</td>
						<td>
							<input id="contractPaytypeName" name="contractPaytypeName"  disabled="true" type="text"
								class="short50" />
						</td>
				    
				        <td>订单付款方式：</td>
						<td>
							<input id="orderPaymentMethodName" name="orderPaymentMethodName"  disabled="true" type="text"
								class="short50" />
						</td>
				    
				        <td>订单付款条件：</td>
							<td>
								<input id="orderPaymentTermsName" name="orderPaymentTermsName"  disabled="true" type="text" title=""
									style="width: 100px"  />
							</td>
				    
				        <td>合同付款条件：</td>
							<td>
								<input id="contractPayConditionName" name="contractPayConditionName"  disabled="true" title=""
									style="width: 100px"  type="text" />
							</td>
				</tr>
		 </table>
		 </div>
		</form>
	</div>
    
    <div region="center" border="false" style="height: 200px" id="datagridDiv">
		<table id="datagrid"></table>
	</div>
	
	<div id="auditLogAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="auditLogAddForm" method="post">
		    <input type="hidden" name="taskIdOfaudit" id="taskIdOfauditId"/>
			<table class="tableForm">
						<tr>
							<th>订单号</th>
							<td>
								<input id="orderNumId" name="orderNum" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写订单号"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>拒绝人</th>
							<td>
								<input id="rejectionNameId" name="rejectionName" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写拒绝人"  style="width: 155px;"/>						
							</td>
						</tr>
						<tr>
							<th>拒绝原因</th>
							<td>
							    <textarea name="rejection" rows="10" cols="35"></textarea>
								<!-- <input name="rejection" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写拒绝原因"  style="width: 155px;"/>	 -->					
							</td>
						</tr>
			</table>
		</form>
	</div>
	</div>
</body>
</html>