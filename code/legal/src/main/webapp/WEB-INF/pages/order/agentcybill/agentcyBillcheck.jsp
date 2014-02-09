<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<style>
table.form_table {
	border: 1px solid #CCCCCC;
	border-collapse: collapse;
	background-color: #f2f2f2;
	position: relative;
}

table.form_table td {
	padding: 2px;
	border-right: 1px solid #C0C0C0;
	border-bottom: 1px solid #C0C0C0;
}

table.main td {
    	height: 21px;
	/* width: 183px; */
}

table.form_table th {
	height: 21px;
/* 	width: 137px; */
	padding: 3px;
	border-bottom: 1px solid #A4B5C2;
	border-right: 1px solid #A4B5C2;
	text-align: left;
}

.noLine {
	BORDER-BOTTOM-COLOR: #666666;
	BORDER-RIGHT-WIDTH: 0px;
	BACKGROUND: Transparent;
	BORDER-TOP-WIDTH: 0px;
	BORDER-BOTTOM-WIDTH: 0px;
	HEIGHT: 18px;
	BORDER-LEFT-WIDTH: 0px;
}
</style>
<script type="text/javascript" charset="utf-8">
var datagrid_detail;
var searchForm;
$(function(){
	searchForm=$('#searchForm').form();
	datagrid_detail = $('#datagrid_detail').datagrid({
		//url : '${dynamicURL}/comprehensiveOrder/comprehensiveOrderAction!searchOrderDetail.do?orderCode=${orderCode}',
		url : '${dynamicURL}/agentcybill/agentcyBillAction!haveItemFeeOforder.do?orderNum=${agentcyBillQuery.orderNum}',
		//rownumbers : true,
		//fit : true,
		//fitColumns : true,
		iconCls : 'icon-save',
		pagination : true,
		pagePosition : 'bottom',
		nowrap : true,
		border : false,
		pageSize : 8,
		pageList : [ 8, 16, 24, 32 ],
		//fit : true,
		singleSelect : true,
		columns : [ [ 
		{
			field : 'rowNum',title : '序号',align : 'center',sortable : true,width :55,
			formatter:function(value,row,index){
	             	return row.rowNum;
	        }
		}, {
			field : 'prodTname',title : '货名',align : 'center',sortable : true,width : 103,
			formatter:function(value,row,index){
             	return row.prodTname;
            }
		}, {
			field : 'haierModel',title : '型号',align : 'center',sortable : true,width : 100,
			formatter:function(value,row,index){
             	return row.haierModel;
        }
		}, {
			field : 'prodQuantity',title : '数量',align : 'center',sortable : true,width : 70,
			formatter:function(value,row,index){
             	return row.prodQuantity;
        }
		}, {
			field : 'currency',title : '原币币种',align : 'center',sortable : true,width : 80,
			formatter:function(value,row,index){
             	return row.currency;
        }
		}, {
			field : 'price',title : '对客户原币单价',align : 'center',sortable : true,width : 85,
			formatter:function(value,row,index){
					return row.price;
        }
		}, {
			field : 'amount',title : '原币总金额',align : 'center',sortable : true,width : 92,
			formatter:function(value,row,index){
				if(row.rowNum==null||(row.rowNum!=null&&row.rowNum!='计算说明')){
					return Number(row.amount).toFixed(4);
				}else{	
             	    return row.amount;
				}
        }
		}, {
			field : 'yuanYunFei',
			title : '原币运费金额',
			align : 'center',
			sortable : true,
			width : 84,
			formatter:function(value,row,index){
				if(row.rowNum==null||(row.rowNum!=null&&row.rowNum!='计算说明')){
             	  return Number(row.yuanYunFei).toFixed(4);
				}else{
					
             	return row.yuanYunFei;
				}
        }
		}, {
			field : 'yuanBaoFei',
			title : '原币保费金额',
			align : 'center',
			sortable : true,
			width : 80,
			formatter:function(value,row,index){
				if(row.rowNum==null||(row.rowNum!=null&&row.rowNum!='计算说明')){
	             	  return Number(row.yuanBaoFei).toFixed(4);
					}else{
						
	             	return row.yuanBaoFei;
					}
        }
		}, {
			field : 'yuanZhiKou',
			title : '原币直扣金额',
			align : 'center',
			sortable : true,
			width : 80,
			formatter:function(value,row,index){
				if(row.rowNum==null||(row.rowNum!=null&&row.rowNum!='计算说明')){
	             	  return Number(row.yuanZhiKou).toFixed(4);
					}else{
						
	             	return row.yuanZhiKou;
					}
        }
		}, {
			field : 'fobPrice',
			title : '原币FOB金额',
			align : 'center',
			sortable : true,
			width : 80,
			formatter:function(value,row,index){
				if(row.rowNum==null||(row.rowNum!=null&&row.rowNum!='计算说明')){
	             	  return Number(row.fobPrice).toFixed(4);
					}else{
						
	             	return row.fobPrice;
					}
        }
		}, {
			field : 'cexchange',
			title : '人民币汇率',
			align : 'center',
			sortable : true,
			width : 80,
			formatter:function(value,row,index){	
	             	return row.cexchange;
        }
		}, {
			field : 'fobAmount',
			title : 'FOB折和人民币',
			align : 'center',
			sortable : true,
			width : 117,
			formatter:function(value,row,index){
				if(row.rowNum==null||(row.rowNum!=null&&row.rowNum!='计算说明')){
	             	  return Number(row.fobAmount).toFixed(4);
					}else{
	             	  return row.fobAmount;
					}
        }
		} ] ],onLoadSuccess:function(data){
			insertfirst();
			var rows=datagrid_detail.datagrid('getRows');
			if(rows){
				var length=rows.length;
				row=rows[length-1];
				var sum=row.fobAmount;
				sumOfFee(Number(sum).toFixed(4));
			}else{
				sumOfFee('0');
			}
			var footRows=datagrid_detail.datagrid('getFooterRows');
			if(footRows){
				for(var i=0;i<footRows.length;i++){
					var footRow=footRows[i];
					setlabels(footRow.page,footRow.pages);
				}
			}
		}
	});
});
function resesizeHeight(){
	datagrid_detail.datagrid('resize',{
		height:function(){return document.body.clientHeight;}
	});
}
//添加第一行的公式数据
function insertfirst(){
	 datagrid_detail.datagrid('insertRow',{
		index:0,
		row:{
			rowNum:'计算说明',
			prodQuantity:'(1)',
			price:'(2)',
			amount:'(3)=(1)*(2)',
			yuanYunFei:'(4)',
			yuanBaoFei:'(5)',
			yuanZhiKou:'(6)',
			fobPrice:'(7)=(3)-<br/>(4)-(5)-(6)',
			cexchange:'(8)',
			fobAmount:'(9)=(7)*(8)' 
		}
	}); 
	
}
function sumOfFee(sum){
	$('#sumOffeeId').html(sum);
}
//修改页数和行数
function setlabels(label1,label2){
	$('#label1').html(label1);
	$('#label2').html(label2);
}


function save(){
	//
	var pringflag=$('#pringFlagId').val();
	if(pringflag==null||pringflag=='0'||pringflag==0){
		//保存状态
		$('#pringFlagId').val('0');
	}
	searchForm.form('submit',{
		url: '${dynamicURL}/agentcybill/agentcyBillAction!saveOrupdateagentcy.do?',
	    //data:'dataType',
	    success : function(json){
	    	var json=$.parseJSON(json);
	    	if(json.success){
	    		$.messager.alert('提示',json.msg,'info',function(){
	    			//代办刷新
					customWindow.reloaddata();
					//代办肯定
					parent.window.HROS.window.close(currentappid);
	    		});
	    	}else{
	    		$.messager.alert('警告',json.msg,'error',function(){
	    		});
	    	}
	    }
	});
}
function printandsave(){
	var count = lodopPrint(gridToTable($("#printBody").clone(true)));
	if(count>0){//确实被打印了
		var pringflag=$('#pringFlagId').val();
		//保存状态
		$('#pringFlagId').val('1');
		searchForm.form('submit',{
			url: '${dynamicURL}/agentcybill/agentcyBillAction!saveOrupdateagentcy.do?',
		    //data:'dataType',
		    success : function(json){
		    	var json=$.parseJSON(json);
		    	if(json.success){
		    		$.messager.alert('提示',json.msg,'info',function(){
		    			//代办刷新
						customWindow.reloaddata();
						//代办肯定
						parent.window.HROS.window.close(currentappid);
		    		});
		    	}else{
		    		$.messager.alert('警告',json.msg,'error',function(){
		    		});
		    	}
		    }
		});
	}
}
//套打
function taoda(){
	 var orderCode=$('#salseOrderCodeid').val();
	 //alert(orderCode);
	if(orderCode!=null&&orderCode!=''){
		window.open("http://hrois.haier.net/report/Report-Guage.do?newReport=true&reportId=c7752950-e45e-4a0f-9b66-d04e981905f4&orderCode="+orderCode);
	} 
}
function printandsave1(){
	$.messager.alert('提示','已经打印过一次','warrning');
}
//还未打印
function printandquxiao(){
	$.messager.alert('提示','没必要取消','warring');
}
//重置打印状态
function printandquxiao1(){
	var orderCode=$('#salseOrderCodeid').val();
	var pringflag=$('#pringFlagId').val();
	//保存状态
	$('#pringFlagId').val('0');
	searchForm.form('submit',{
		url: '${dynamicURL}/agentcybill/agentcyBillAction!printAgein.do?',
	    //data:'dataType',
	    success : function(json){
	    	var json=$.parseJSON(json);
	    	if(json.success){
	    		$.messager.alert('提示','取消成功','info',function(){
	    			//代办刷新
					customWindow.reloaddata();
					//代办肯定
					parent.window.HROS.window.close(currentappid);
					customWindow.detailCheck4(orderCode);
	    		});
	    	}else{
	    		$.messager.alert('警告',json.msg,'error',function(){
	    		});
	    	}
	    }
	});
}
function _search(){
	var orderCode=$('#salseOrderCodeid').val();
	if(orderCode==null||orderCode==''){
		$.messager.alert('提示','请填写订单号','warrning');
	}else{
		$.messager.confirm('提示','是否要刷新此页面',function(r){
			if(r){
				parent.window.HROS.window.close(currentappid);
				//alert(orderCode);
				customWindow.detailCheck4(orderCode);
				
			}
		})
	}
}
//打印预览
function showBeforedayin(){
	//gridToTable datagrid 转换成普通表格
	lodopPreview(gridToTable($("#printBody").clone(true)));
}
</script>
</head>
<body class="easyui-layout zoc">
	<div region="north" border="false" class="zoc" title="" collapsed="false"  style="overflow: auto;" align="left">
		 <form id="searchForm">
		       <s:hidden name="taskId"></s:hidden>
		      <s:hidden name="agentcyBillQuery.agentcyBillId"></s:hidden>
		      <s:hidden name="agentcyBillQuery.agentcyBillCode"></s:hidden>
		      <s:hidden name="orderCode" id="orderCodeId"></s:hidden> 
		      <s:hidden name="agentcyBillQuery.printFlag" id="pringFlagId"></s:hidden>
		      <s:hidden name="agentcyBillQuery.modifyNum"></s:hidden>
		     <%--  <s:textfield name="taskId"></s:textfield>
		      <s:textfield name="agentcyBillQuery.agentcyBillId"></s:textfield>
		      <s:textfield name="agentcyBillQuery.agentcyBillCode"></s:textfield>
		      <s:textfield name="orderCode"></s:textfield>
		      <s:textfield name="agentcyBillQuery.printFlag" id="pringFlagId"></s:textfield>
		      <s:textfield name="agentcyBillQuery.modifyNum"></s:textfield> --%>
		     <div class="oneline">
		         <div class="item25">
						<div class="itemleft80">订单编号:</div>
						<div class="righttext_easyui">
							<s:textfield id="salseOrderCodeid" name="agentcyBillQuery.orderNum" type="text" cssClass="short50">
							</s:textfield>
						</div>
				</div>
				<div class="item25">
							<div class="oprationbutt">
								<input type="button" onclick="_search();" value="查询" /> 
							</div>
				</div>
				<div class="item25">
							<div class="oprationbutt">
			                    <input type="button" onclick="showBeforedayin();" value="打印预览" /> 
			                
							</div>
				</div>
				<div class="item25">
							<div class="oprationbutt">
								<input type="button" onclick="save();" value="保存" /> 
								<input type="button" onclick="taoda();" value="套打" /> 
							</div>
				</div>
				<div class="item25 lastitem">
							<div class="oprationbutt">
								
							</div>
							<s:if test='agentcyBillQuery.printFlag==null||agentcyBillQuery.printFlag=="0"'>
							     <input type="button" onclick="printandsave();" value="正式打印" /> 
							</s:if>
							<s:if test='agentcyBillQuery.printFlag=="1"'>
			                    <input type="button"  onclick="printandsave1();" value="正式打印" /> 
			                </s:if>
			                <s:if test='agentcyBillQuery.printFlag==null||agentcyBillQuery.printFlag=="0"'>
							     <input type="button" onclick="printandquxiao();" value="正式打印取消" /> 
							</s:if>
							<s:if test='agentcyBillQuery.printFlag=="1"'>
			                    <input type="button"  onclick="printandquxiao1();" value="正式打印取消" /> 
			                </s:if>
			                <%-- <s:if test='agentcyBillQuery.printFlag==null||agentcyBillQuery.printFlag=="0"'>
							     <input type="button" onclick="taoda();" value="套打" /> 
							</s:if>
							<s:if test='agentcyBillQuery.printFlag=="1"'>
			                    <input type="button"  onclick="taoda1();" value="套打" /> 
			                </s:if> --%>
			                
				</div>
		     </div>
		 </form>
		 <div>
		     <%-- <s:text name="tishi"></s:text> --%>
		     <s:label name="tishi"></s:label>
		 </div>
	</div>
	<div region="center" border="false" style="overflow: auto;" align="center" class="zoc" id="printBody" >
	     <div class="part_zoc zoc" style="width: 1151px;">
	         <div class="partnavi_zoc" align="center">
				<span>代理出口结算清单列表</span>
			</div>
			<table border="1" cellspacing="1" class="form_table main"
				cellpadding="1" width="1150px"
				style="border-bottom-color: white; border-bottom-width: 1px; 
				border-top-color: white; border-right-color: white;">
			    <tr>
			        <td rowspan="4" colspan="4" style="height: 100%; border-right-width: 1px;">
			            <img src="${staticURL}/style/images/logo_login.png"/>
			        </td>
			        <td rowspan="4" colspan="5" style="height: 100%; border-right-width: 1px;">
			             <div style="padding-left: 100px; border-right-width: 0px; font-family: '微软雅黑'; HEIGHT: 35px; FONT-SIZE: 19px; FONT-WEIGHT: bold">
			                                              代理出口结算清单
			             </div>
			             <div style="padding-left: 0px; border-right-width: 0px; font-family: '宋体'; HEIGHT: 14px; FONT-SIZE: 12px;line-height: 10px">
			                 (共5联，第1联：由海外推财务部核销退税经理存档。
			             </div>
			             <div style="padding-left: 0px; border-right-width: 0px; font-family: '宋体'; HEIGHT: 14px; FONT-SIZE: 12px;line-height: 10px;">
			                                            用于组织"免、抵、退"单证)
			             </div>
			        </td>
			        <td style="width: 80px;">
			                                表号 :
			        </td>
			        <td colspan="3" style="width: 300px;">
			            <s:text name=""></s:text>
			        </td>
			    </tr>
			    <tr>
			        <td style="width: 80px;">
			                           生效期：
			        </td>
			        <td colspan="3" style="width: 300px;">
			            <s:text name=""></s:text>
			        </td>
			    </tr>
			    <tr>
			       <td style="width: 80px;">
			                           编号：
			        </td>
			        <td colspan="3" style="width: 300px;">
			            
			            <s:label name="agentcyBillQuery.agentcyBillCode"></s:label>
			        </td> 
			    </tr>
			    <tr>
			       <td style="width: 80px;">
			                           日期：
			        </td>
			        <td colspan="3" style="width: 300px;">
			             <s:label name="agentcyBillQuery.createDate"></s:label> 
			        </td> 
			    </tr>
			    <tr>
			        <td colspan="13">
			            第<label id="label1" ></label>  页，共  <label id="label2" ></label> 页
			        </td>
			    </tr>
			    <tr>
			        <td colspan="2" style="width: 150px">
			                        委托单位:
			        </td>
			        <td colspan="5" style="width: 400px;">
			            <s:label name="agentcyBillQuery.factoryTaiTou"></s:label>(<s:label name="agentcyBillQuery.shuiHao"></s:label>)
			        </td>
			        <td style="width: 80px;">
			                       应结算日:
			        </td>
			        <td colspan="5" style="width: 460px">
			             <s:label name="agentcyBillQuery.balanceDate"></s:label> 
			        </td>
			    </tr>
			    <tr>
			       <td colspan="2" style="width: 150px;">
			                            出口合同号:
			       </td>
			       <td colspan="2" style="width: 170px;">
			          <s:label name="agentcyBillQuery.contractCode"></s:label> 
			       </td>
			       <td style="width: 80px;">
			                          出口订单号:
			       </td>
			       <td colspan="2" style="width: 160px;">
			           <s:label name="agentcyBillQuery.orderNum"></s:label> 
			       </td>
			       <td style="width: 80px;">
			                          委托合同号:
			       </td>
			       <td colspan="5" style="width: 460px;">
			           <s:label name=""></s:label>
			           &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
			           &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp核:
			       </td>
			    </tr>
			    <tr>
			        <td colspan="2" style="width: 150px;">
			                           备货通知单号:
			        </td>
			        <td colspan="2" style="width: 170px;">
			            <s:label name="agentcyBillQuery.prepareCode"></s:label>
			        </td >
			        <td colspan="1" style="width: 80px;">
			                          综合通知单号:
			        </td>
			        <td colspan="2" style="160px;">
			           <s:label name="agentcyBillQuery.compreNum"></s:label>
			        </td>
			        <td colspan="1" style="width: 80px;">
			                         出口发票号:
			        </td>
			        <td colspan="5" style="width: 460px;">
			            <s:label name="agentcyBillQuery.invoiceNum"></s:label>
			        </td>
			    </tr>
			    <tr>
			        <td colspan="2" style="width: 150px;">
			                        客户名称:
			        </td>
			        <td colspan="5" style="width: 410px">
			            <s:label name="agentcyBillQuery.customerName"></s:label>
			        </td>
			        <td colspan="1" style="width: 80px;">
			                       客户编号:
			        </td>
			        <td colspan="5" style="width: 460px;">
			            <s:label name="agentcyBillQuery.customerCode"></s:label>
			            
			        </td>
			    </tr>
			    <tr>
			        <td colspan="2" style="width: 150px;">
			                        经营主体:
			        </td>
			        <td colspan="5" style="width: 410px">
			            <s:label name="agentcyBillQuery.operators"></s:label>
			        </td>
			        <td colspan="1" style="width: 80px;">
			                       贸易国别/地区:
			        </td>
			        <td colspan="5" style="width: 460px;">
			            <s:label name="agentcyBillQuery.countryName"></s:label>
			            
			        </td>
			    </tr>
			    </table>
			   <table id="datagrid_detail" border="1" cellspacing="1" class="form_table main"
				cellpadding="1" width="1150px"
				style="border-bottom-color: white; border-bottom-width: 1px; 
				border-top-color: white; border-right-color: white;">
			   </table>
			   <table border="1" cellspacing="1" class="form_table main"
				cellpadding="1" width="1150px"
				style="border-bottom-color: white; border-bottom-width: 
				1px; border-top-color: white; border-right-color: white;">
			    <tr>
			        <td colspan="13">代付出口费用项目:</td>
			    </tr>
			    <tr>
			        <td rowspan="3" colspan="2" style="width: 150px;">
			                          项目
			        </td>
			        <td colspan="11">
			            <div style="padding-left: 100px;">
			                                         委托海尔电器产业有限公司代付的出口费用
			            </div>
			        </td>
			    </tr>
			    <tr>
			        <td >
			                         佣金
			        </td>
			        <td >
			                         返利
			        </td>
			        <td >
			                         广告支持
			        </td>
			        <td >
			                         其它
			        </td>
			        <td >
			                         造势广告费
			        </td>
			        <td >
			                         售后服务费
			        </td>
			        <td colspan="2">
			                         贸易公司销售费用
			        </td>
			        <td colspan="3">
			                         小记
			        </td>
			    </tr>
			    <tr>
			        <td >
			                         (1)
			        </td>
			        <td >
			                        (2)
			        </td>
			        <td >
			                         (3)
			        </td>
			        <td >
			                         (4)
			        </td>
			        <td >
			                         (5)
			        </td>
			        <td >
			                         (6)
			        </td>
			        <td colspan="2">
			                         (7)
			        </td>
			        <td colspan="3">
			                         (8)=∑(1)…(7)
			        </td>
			    </tr>
			    <tr>
			        <td colspan="2">
			                          外币a
			        </td>
			        <td >
			                         0
			        </td>
			        <td >
			                        0
			        </td>
			        <td >
			                         0
			        </td>
			        <td >
			                         0
			        </td>
			        <td >
			                         0
			        </td>
			        <td >
			                         0
			        </td>
			        <td colspan="2">
			                         0
			        </td>
			        <td colspan="3">
			                         0
			        </td>
			    </tr>
			    <tr>
			        <td colspan="2">
			                        人民币b
			        </td>
			        <td >
			                         0
			        </td>
			        <td >
			                        0
			        </td>
			        <td >
			                         0
			        </td>
			        <td >
			                         0
			        </td>
			        <td >
			                         0
			        </td>
			        <td >
			                         0
			        </td>
			        <td colspan="2">
			                         0
			        </td>
			        <td colspan="3">
			                         0
			        </td>
			    </tr>
			    <tr>
			        <td rowspan="3" colspan="2">
			            项目
			        </td>
			        <td>
			            产品责任险
			        </td>
			        <td>
			            港杂费
			        </td>
			        <td>
			            商检费
			        </td>
			        <td>
			          报关费
			        </td>
			        <td>
			           信用险
			        </td>
			        <td>
			            贷款利息
			        </td>
			        <td>
			           银行费用
			        </td>
			        <td>
			            其他费用
			        </td>
			        <td colspan="2">
			            小记
			        </td>
			        <td>
			           平台服务费
			        </td>
			    </tr>
			    <tr>
			        <td>
			            (9)
			        </td>
			        <td>
			           (10)
			        </td>
			        <td>
			         (11)
			        </td>
			        <td>
			          (12)
			        </td>
			        <td>
			          (13)
			        </td>
			        <td>
			            (14)
			        </td>
			        <td>
			           (15)
			        </td>
			        <td>
			            (16)
			        </td>
			        <td colspan="2">
			            (17)=∑(9)…(16)
			        </td>
			        <td>
			           (18)
			        </td>
			    </tr>
			    <tr>
			        <td>
			           0
			        </td>
			        <td>
			           0
			        </td>
			        <td>
			         0
			        </td>
			        <td>
			          0
			        </td>
			        <td>
			          0
			        </td>
			        <td>
			          0
			        </td>
			        <td>
			          0
			        </td>
			        <td>
			         0
			        </td>
			        <td colspan="2">
			          0
			        </td>
			        <td>
			         0
			        </td>
			    </tr>
			    <tr>
			        <td colspan="2">计算依据</td>
			        <td colspan="11">定价单</td>
			    </tr>
			    <tr>
			        <td colspan="2">计提比率</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td colspan="2">0</td>
			        <td>0</td>
			    </tr>
			    <tr>
			        <td colspan="2">币种</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td colspan="2">0</td>
			        <td>0</td>
			    </tr>
			    <tr>
			        <td colspan="2">外币a</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td colspan="2">0</td>
			        <td>0</td>
			    </tr>
			    <tr>
			        <td colspan="2">人民币b</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td>0</td>
			        <td colspan="2">0</td>
			        <td>0</td>
			    </tr>
			    <tr>
			        <td colspan="4">扣除代付费用后应支付货款总额:</td>
			        <td colspan="9">
			            <s:label id="sumOffeeId" value="">
			            </s:label>
			        </td>
			    </tr>
			    <tr>
			        <td colspan="3">应申报免抵退日期：</td>
			        <td colspan="3">
			           <s:label name="agentcyBillQuery.yingMianditui"></s:label>
			        </td>
			        <td colspan="2">正式申报免抵退日期：</td>
			        <td colspan="5">
			        <s:label name="agentcyBillQuery.zhengMianditui"></s:label>
			        </td>
			    </tr>
			    <tr>
			       <td colspan="13" style="vertical-align:top;height: 201px;">
			          
			                  <div style="height: 20px;"></div>
			                  <div  style="vertical-align:bottom;height: 50px;" >
			                  <div style="display: inline;width: 120px;">操作 :</div>
			                  <div style="display: inline;width: 300px;"><s:label name="agentcyBillQuery.createName"></s:label>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</div>
			                  <div style="display: inline;width: 120px;">审核:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp </div>
			                  <div style="display: inline;width: 300px;"><s:label name=""></s:label></div>
			                 </div>
			              <div>
			                  备注
			              </div>
			              <div>
			              1、《代理出口结算清单》必须通过定单系统自动生成，除签字外，手写无效；
			              </div>
			              <div>
			              2、《代理出口结算清单》在备妥货且质量合格后，由海外推财务部结算经理生成；
			              </div>
			              <div>
			              3、本结算清单共5联：第1联由海外推财务部退税经理存档，用于组织“免、抵、退”单证;第2联由海外推结算经理与《备货通知
			              </div>
			              <div>
			                                    单》、《质量小结》配齐后登记库存商品、应付帐款明细帐；第3、4联由产品部税务经理用于申报“免、抵、退”预申报及正式申报；第5联转
			              </div>
			              <div>
			                                    各产品部财务部往来帐人员确认销售收入，并登记销售收入明细帐。
			              </div>
			       </td>
			    </tr>
			</table>
	     </div>
	</div>
</body>
</html>