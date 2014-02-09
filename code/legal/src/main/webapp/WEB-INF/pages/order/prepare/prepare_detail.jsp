<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@taglib
	prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<style>
	table.reportTable tr td,table.reportTable tr th {
		border: 1px solid #979a9d;
		border-collapse: collapse;
		line-height: 20px;
		background-color: white;
	}
	
	table.reportTable th {
		FONT-WEIGHT: bold
	}
	
	table.reportTable {
		width: 100%;
		border-collapse: collapse;
		background-color: rgb(242, 242, 242);
	}
	table.reportTable input[type="text"]{
		background-color: white;
		border: 0;
	}
	
	div.datagrid tr td,table.datagrid tr th{
		border-collapse: collapse;
	}
	table.datagrid-htable tr.datagrid-header-row td{
		line-height: 20px;
	}
	table.datagrid-htable tr.datagrid-header-row td div.datagrid-cell{
		white-space:normal;
	}
		</style>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
var datagrid;
var contractDetailForm;
var contractDetailFormBefore;
var payMoneyFlag;
var ocode = '${ocode}';
var dataForm;
$(function() {
    //查询列表	
	datagrid = $('#datagrid').datagrid({
 		url : "${dynamicURL}/prepare/prepareOrderAction!printPrepareOrderDatagrid.do?orderNum="+ocode,
		//fit : true,
		fitColumns : true,
		nowrap : false,
		//border : false,
		idField : 'orderCode',
		columns : [ [ 	             	             	             
		   {field:'haierModer',title:'工厂型号',align:'center',width:80, 
				formatter:function(value,row,index){
					return row.haierModer;
				}
			},				
		   {field:'customerModel',title:'客户型号',align:'center',width:80,
				formatter:function(value,row,index){
					return row.customerModel;
				}
			},
			{field:'prodQuantity',title:'数量',align:'center',width:80,
				formatter:function(value,row,index){
					return row.prodQuantity;
				}
			},				
		   {field:'conditRate',title:'结算价',align:'center',width:80,
				formatter:function(value,row,index){
					return row.conditRate;
				}
			},
			{field:'cusName',title:'其中躺放',align:'center',width:80,
				formatter:function(value,row,index){
					return "";
				}
			},
		   {field:'orderTypeName',title:'装箱图号',align:'center',width:80,
				formatter:function(value,row,index){
					return "";
				}
			},				
		   {field:'contractcode',title:'该类型出口次国家此客户是否第一次',resizable:true,align:'center',width:80,
				formatter:function(value,row,index){
					return "n";
				}
			},				
		   {field:'addirmNum',title:'特殊技术要求确认单号',align:'center',width:80,
				formatter:function(value,row,index){
					return row.addirmNum;
				}
			},				
		   {field:'orderCustomDate',title:'出口产品可变项编号',align:'center',width:80,
				formatter:function(value,row,index){
					return "/";
				}
			},				
		   {field:'orderDealTypeName',title:'所属产品类型(注1)',align:'center',width:80,
				formatter:function(value,row,index){
					return "";
				}
			},				
		   {field:'orderShipDate',title:'要求出运期',align:'center',width:80,
				formatter:function(value,row,index){
					return row.orderShipDate.substring(0,10);
				}
			},				
		   {field:'orderpaymentsterms',title:'特殊检验类型',align:'center',width:80,
				formatter:function(value,row,index){
					return "/";
				}
			},				
		   {field:'salesOrgCodeName',title:'备货完成时应同时提供的文件',align:'center',width:80,
				formatter:function(value,row,index){
					return "";
				}
			},				
		   {field:'counName',title:'标准备货期',align:'center',width:80,
				formatter:function(value,row,index){
					return "0";
				}
			},				
		   {field:'actualFinishDate',title:'要求备妥货时间',align:'center',width:80,
				formatter:function(value,row,index){
					return row.actualFinishDate;
				}
			},				
		   {field:'deptNameCn',title:'确认交货时间',align:'center',width:80,
				formatter:function(value,row,index){
					return "";
				}
			}				
		 ] ]
	});
    
	//查询列表	
	datagridP = $('#datagridP').datagrid({
 		url : "${dynamicURL}/prepare/prepareOrderAction!printPrepareOrderDatagrid.do?orderNum="+ocode,
		//fit : true,
		fitColumns : true,
		nowrap : false,
		//border : false,
		idField : 'orderCode',
		columns : [ [ 	             	             	             
		   {field:'haierModer',title:'工厂型号',align:'center',width:80, 
				formatter:function(value,row,index){
					return row.haierModer;
				}
			},				
		   {field:'customerModel',title:'客户型号',align:'center',width:80,
				formatter:function(value,row,index){
					return row.customerModel;
				}
			},
			{field:'prodQuantity',title:'数量',align:'center',width:80,
				formatter:function(value,row,index){
					return row.prodQuantity;
				}
			},				
		   {field:'conditRate',title:'结算价',align:'center',width:80,
				formatter:function(value,row,index){
					return row.conditRate;
				}
			},
			{field:'cusName',title:'其中躺放',align:'center',width:80,
				formatter:function(value,row,index){
					return "";
				}
			},
		   {field:'orderTypeName',title:'装箱图号',align:'center',width:80,
				formatter:function(value,row,index){
					return "";
				}
			},				
		   {field:'contractcode',title:'该类型出口次国家此客户是否第一次',resizable:true,align:'center',width:80,
				formatter:function(value,row,index){
					return "n";
				}
			},				
		   {field:'addirmNum',title:'特殊技术要求确认单号',align:'center',width:80,
				formatter:function(value,row,index){
					return row.addirmNum;
				}
			},				
		   {field:'orderCustomDate',title:'出口产品可变项编号',align:'center',width:80,
				formatter:function(value,row,index){
					return "/";
				}
			},				
		   {field:'orderDealTypeName',title:'所属产品类型(注1)',align:'center',width:80,
				formatter:function(value,row,index){
					return "";
				}
			},				
		   {field:'orderShipDate',title:'要求出运期',align:'center',width:80,
				formatter:function(value,row,index){
					return row.orderShipDate.substring(0,10);
				}
			},				
		   {field:'orderpaymentsterms',title:'特殊检验类型',align:'center',width:80,
				formatter:function(value,row,index){
					return "/";
				}
			},				
		   {field:'salesOrgCodeName',title:'备货完成时应同时提供的文件',align:'center',width:80,
				formatter:function(value,row,index){
					return "";
				}
			},				
		   {field:'counName',title:'标准备货期',align:'center',width:80,
				formatter:function(value,row,index){
					return "0";
				}
			},				
		   {field:'actualFinishDate',title:'要求备妥货时间',align:'center',width:80,
				formatter:function(value,row,index){
					return row.actualFinishDate;
				}
			},				
		   {field:'deptNameCn',title:'确认交货时间',align:'center',width:80,
				formatter:function(value,row,index){
					return "";
				}
			}				
		 ] ]
	});
    //判断订单是否过了付款保障
    $.ajax({
		 url : "${dynamicURL}/tmod/actAction!getActQueryList.do",
 	     data:{
 	    		orderNum : ocode,
 	    		actId : 'payMoney'
 	    	  },
 	   	 dataType:"json",
 	  	 type:'post',
 	  	 async:false,
 	     success:function(data){
 	    	 if(null != payMoneyFlag){
 	    		payMoneyFlag = data.statusCode;
 	    	 }else{
 	    		payMoneyFlag = "end";
 	    	 }
 	     }
	});
	$.ajax({
		 url : "${dynamicURL}/prepare/prepareOrderAction!printPrepareOrderDatagrid.do",
 	     data:{
 	    		orderNum : ocode
 	    	  },
 	   	 dataType:"json",
 	  	 type:'post',
 	  	 async:false,
 	     success:function(data){
 	    	 if(payMoneyFlag == "end"){
 	    		$("#contractDetailFormBefore").hide();
 	    		$("#contractDetailForm").form('load',data[0]);
 	    	 }else{
 	    		$("#contractDetailForm").hide();
 	    		$('#contractDetailFormBefore').form('load',data[0]);
 	    	 }
 	     }
	});
	
	$.ajax({
		 url : "${dynamicURL}/prepare/prepareOrderAction!printPrepareOrderDatagridDetail.do",
	     data:{
	    		orderNum : ocode
	    	  },
	   	 dataType:"json",
	  	 type:'post',
	  	 async:false,
	     success:function(response){
	    	 if(payMoneyFlag == "end"){
	    		 $("#contractDetailForm").form('load',{
		   			 planDate1 : response[0].planDate1,
		   			 planDate2 : response[0].planDate2,
		   			 planDate3 : response[0].planDate3,
		   			 planDate4 : response[0].planDate4,
		   			 planDate5 : response[0].planDate5,
		   			 planDate6 : response[0].planDate6,
		   			 actualFinishDate1 : response[0].actualFinishDate1,
		   			 actualFinishDate2 : response[0].actualFinishDate2,
		   			 actualFinishDate3 : response[0].actualFinishDate3,
		   			 actualFinishDate4 : response[0].actualFinishDate4,
		   			 actualFinishDate5 : response[0].actualFinishDate5,
		   			 actualFinishDate6 : response[0].actualFinishDate6,
		   			 c1 : response[0].c1,
		   			 c2 : response[0].c2,
		   			 c3 : response[0].c3,
		   			 c4 : response[0].c4,
		   			 c5 : response[0].c5,
		   			 c6 : response[0].c6,
		   			 uName1 : response[0].uName1,
		   			 uName2 : response[0].uName2,
		   			 uName3 : response[0].uName3,
		   			 uName4 : response[0].uName4,
		   			 uName5 : response[0].uName5,
		   			 uName6 : response[0].uName6
		   		});
	 	    	 }else{
	 	    		$("#contractDetailFormBefore").form('load',{
	 		   			 planDate1 : response[0].planDate1,
	 		   			 planDate2 : response[0].planDate2,
	 		   			 planDate3 : response[0].planDate3,
	 		   			 planDate4 : response[0].planDate4,
	 		   			 planDate5 : response[0].planDate5,
	 		   			 planDate6 : response[0].planDate6,
	 		   			 actualFinishDate1 : response[0].actualFinishDate1,
	 		   			 actualFinishDate2 : response[0].actualFinishDate2,
	 		   			 actualFinishDate3 : response[0].actualFinishDate3,
	 		   			 actualFinishDate4 : response[0].actualFinishDate4,
	 		   			 actualFinishDate5 : response[0].actualFinishDate5,
	 		   			 actualFinishDate6 : response[0].actualFinishDate6,
	 		   			 c1 : response[0].c1,
	 		   			 c2 : response[0].c2,
	 		   			 c3 : response[0].c3,
	 		   			 c4 : response[0].c4,
	 		   			 c5 : response[0].c5,
	 		   			 c6 : response[0].c6,
	 		   			 uName1 : response[0].uName1,
	 		   			 uName2 : response[0].uName2,
	 		   			 uName3 : response[0].uName3,
	 		   			 uName4 : response[0].uName4,
	 		   			 uName5 : response[0].uName5,
	 		   			 uName6 : response[0].uName6
	 		   		});
	 	    	 }
	   		
	   		$("input.date").each(function(){
	   			var val = $(this).val();
	   			if(val.length>10){
	   				$(this).val(val.substring(0,10));
	   			}
	   		})
	     }
	});
});

function printReport(){
	 if(payMoneyFlag == "end"){
		 var print = $(".printBody1").clone();
		 lodopPrintFullWidth(gridToTable(print),"出口备货单跟踪表");
  	 }else{
  		var print = $(".printBody").clone();
  		lodopPrintFullWidth(gridToTable(print),"出口备料单跟踪表");
  	 }
}
</script>

</head>
<body>
<div><form id ="contractDetailFormBefore" class="printBody">
	<div style="width: 1151px; margin: 0 auto;">
		<div align="center" >
			<span>出口备料单跟踪表</span>
			<input id = "printButton" type="button" value="打  印" onclick="printReport(this.style.display='none')"style = "width: 60px;height: 22px;"/>
		</div>
		<div style="margin: 0 auto;" class='zoc'>
			<table class="reportTable">
				<tr>
					<td rowspan="3" colspan="2"
						style="height: 100%; border-right-width: 1px;"><img
						src="${staticURL}/style/images/logo_login.png"
						style="margin-left: 60px;" /></td>
					<td rowspan="3" colspan="2">
						<div align="center" id = "flga"
							style="font-family: '微软雅黑'; HEIGHT: 35px; FONT-SIZE: 19px; FONT-WEIGHT: bold">
							出口备料单跟踪表</div>
						<div align="center"
							style="font-family: '宋体'; HEIGHT: 14px; FONT-SIZE: 12px; line-height: 10px">
							(共3联，第1联：第一联：产品部存留)</div>
					</td>
					<td style="width: 220px;">表 号:</td>
				</tr>
				<tr>
					<td style="width: 220px;"><s:label
							name="agentcyBillQuery.agentcyBillCode">生效期:</s:label></td>
				</tr>
				<tr>
					<td style="width: 220px;">备货单号: <input id = "actPrepareCode" name = "actPrepareCode" type="text"></td>
				</tr>
				<tr>
					<td align="center" rowspan="11" style="width: 20px">订单要求</td>
					<td align="center">订单号</td>
					<td colspan="2"><input id = "orderNum" name = "orderNum" type="text"></input></td>
					<td rowspan="2">第   页 共    页</td>
				</tr>
				<tr>
					<td align="center">相应的备料通知单号</td>
					<td colspan="2" rowspan="1">□有 编号: <input id = "" name = "" type="text"></td>
				</tr>

				<tr>
					<td style="width: 150px;" align="center">产品经理</td>
					<td style="width: 170px;" id = "orderProdManager" ><input  id = "orderProdManager" name = "orderProdManager" type = "text" style = "border-right: 1px;"/></td>
					<td style="width: 170px;">出口国别</td>
					<td style="width: 170px;"><input  id = "counName" name = "counName" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">客户名称</td>
					<td style="width: 170px;"><input  id = "custname" name = "custname" type = "text"/></td>
					<td style="width: 170px;" style = "border-left: 1px;">是否需要ROHS认证</td>
					<td style="width: 170px;"><input  id = "rFlag" name = "rFlag" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">产品名称</td>
					<td style="width: 170px;"><input  id = "prodTypeName" name = "prodTypeName" type = "text"/></td>
					<td style="width: 170px;">合同或销售条件号</td>
					<td style="width: 170px;"><input  id = "contractCode" name = "contractCode" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">经营主体</td>
					<td colspan="3" align="center" ><input style = "width: 550px;" id = "deptname" name = "deptname" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">商检批次号</td>
					<td style="width: 170px;"><input  id = "checkCode" name = "checkCode" type = "text"/></td>
					<td style="width: 170px;">客户 PO NO</td>
					<td style="width: 170px;"><input  id = "orderPoCode" name = "orderPoCode" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">结算方式</td>
					<td style="width: 170px;" colspan="3" ></td>
				</tr>
				<tr>
					<td colspan="4" style="width: 1100px;">
						<table id ="datagrid"></table>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="height: 60px;" >
					<tt>编制:</tt>
					</td>
					<td colspan="2">审核:</td>
				</tr>
			</table>
			
			<table class="reportTable" style="width:100%">
				<tr>
					<td align="center" rowspan="9" style="width: 27px">订单执行</td>
					
				</tr>
				<tr>
					<td rowspan="2" style="width: 40px" align="center">序号</td>
					<td rowspan="8" style="width: 50px" align="center">生产进程【由产品部事业部订单经理负责】</td>
					<td rowspan="1"  style="width: 120px" align="center">加工工厂</td>
					<td colspan="6"><input style = "width: 450px;"  id = "itemName" name = "itemName" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 80px" align="center">活动</td>
					<td style="width: 80px" align="center">预算</td>
					<td style="width: 80px" align="center">实际</td>
					<td style="width: 80px" align="center">差异</td>
					<td style="width: 80px" align="center">责任位</td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">1</td>
					<td align="center">JIT</td>
					<td style="width: 80px" align="center"><input  id = "planDate1" name = "planDate1" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate1" name = "actualFinishDate1" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c1" name = "c1" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName1" name = "uName1" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center"></td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">2</td>
					<td align="center">首样</td>
					<td style="width: 80px" align="center"><input  id = "planDate2" name = "planDate2" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate2" name = "actualFinishDate2" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c2" name = "c2" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName2" name = "uName2" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">3</td>
					<td align="center">生产开始Tp</td>
					<td style="width: 80px" align="center"><input  id = "planDate3" name = "planDate3" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate3" name = "actualFinishDate3" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c3" name = "c3" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName3" name = "uName3" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">4</td>
					<td align="center">生产</td>
					<td style="width: 80px" align="center"><input  id = "planDate4" name = "planDate4" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate4" name = "actualFinishDate4" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c4" name = "c4" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName4" name = "uName4" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">5</td>
					<td align="center">商检</td>
					<td style="width: 80px" align="center"><input  id = "planDate5" name = "planDate5" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate5" name = "actualFinishDate5" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c5" name = "c5" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName5" name = "uName5" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">6</td>
					<td align="center">装箱</td>
					<td style="width: 80px" align="center"><input  id = "planDate6" name = "planDate6" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate6" name = "actualFinishDate6" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c6" name = "c6" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName6" name = "uName6" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
			</table>
			<table class="reportTable">
			<tr>
				<td>确认 ：工厂排产员  ：  </td>
			</tr>
			</table>
		</div>
		<div style = "">备注 1 : 产品类型代号分别为 A1  老产品,老客户； A2  老产品,新客户；新产品,改进系列；B1  不需新开模具,B2  新开注塑模，B3  新开钣金模；B4  系统匹配;B5  其它；新产品，新开系列；C1 不需新开模具，C2  新开注塑模, C3 新开钣金模，C4  系统匹配，C5  其它; </div>
		<div style = "margin-top: 10px; ">备注2：本批产品正式生产前3天首先进行原材料清查，并进性样机确认，其中首次出口需经海外推支持经理及检验公司同时确认，以后经检验公司确认，确认合格后方可生产；生产完毕并有检验公司出具合格报告后方可收货。 </div>
		<div style = "margin-top: 10px;">备注3：特殊检验是指客户要求的由第三方检测机构在每批发货之前进行的检验，业务经理必须在输入定单的同时，在“特殊检验要求”一栏内输入特殊检验的名称（如：尼日利亚的OMIC检、沙特的SASO检、孟加拉的ITS检、美国的SGS检等），产品部按特殊的要求进行备好货。 </div>
		<div style = "margin-top: 10px;"> 备注4：备货单各项均在网络上生成，手写无效。作为产品本部/直属事业部开始生产的依据。 </div>
		<div style = "margin-top: 10px;"> 备注5：该备货通知单 </div>
		<div style = "margin-left: 42px; ">第一联：产品部留存； </div>
		<div style = "margin-left: 42px; ">第二联：转产品财务部据此开发票并随同发票转海外推财务部； </div>
		<div style = "margin-left: 42px; ">第三联：加盖生产完毕确认章并经海外推备货员确认后转海外推业务经理据此开综合通知单。 
		</div>
	</div>
	</form>
	</div>
	<div>
		<form id ="contractDetailForm" class="printBody1">
		<div style="width: 1151px; margin: 0 auto;">
		<div align="center" >
			<span>出口备货单跟踪表</span>
			<input id = "printButton" type="button" value="打  印" onclick="printReport(this.style.display='none')"style = "width: 60px;height: 22px;"/>
		</div>
		<div style="margin: 0 auto;" class='zoc'>
			<table class="reportTable">
				<tr>
					<td rowspan="3" colspan="2"
						style="height: 100%; border-right-width: 1px;"><img
						src="${staticURL}/style/images/logo_login.png"
						style="margin-left: 60px;" /></td>
					<td rowspan="3" colspan="2">
						<div align="center" id = "flga"
							style="font-family: '微软雅黑'; HEIGHT: 35px; FONT-SIZE: 19px; FONT-WEIGHT: bold">
							出口备货单跟踪表</div>
						<div align="center"
							style="font-family: '宋体'; HEIGHT: 14px; FONT-SIZE: 12px; line-height: 10px">
							(共3联，第1联：第一联：产品部存留)</div>
					</td>
					<td style="width: 220px;">表 号:</td>
				</tr>
				<tr>
					<td style="width: 220px;"><s:label
							name="agentcyBillQuery.agentcyBillCode">生效期:</s:label></td>
				</tr>
				<tr>
					<td style="width: 220px;">备货单号: <input id = "actPrepareCode" name = "actPrepareCode" type="text"></td>
				</tr>
				<tr>
					<td align="center" rowspan="11" style="width: 20px">订单要求</td>
					<td align="center">订单号</td>
					<td colspan="2"><input id = "orderNum" name = "orderNum" type="text"></input></td>
					<td rowspan="2">第   页 共    页</td>
				</tr>
				<tr>
					<td align="center">相应的备料通知单号</td>
					<td colspan="2" rowspan="1">□有 编号: <input id = "" name = "" type="text"></td>
				</tr>

				<tr>
					<td style="width: 150px;" align="center">产品经理</td>
					<td style="width: 170px;" id = "orderProdManager" ><input  id = "orderProdManager" name = "orderProdManager" type = "text" style = "border-right: 1px;"/></td>
					<td style="width: 170px;">出口国别</td>
					<td style="width: 170px;"><input  id = "counName" name = "counName" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">客户名称</td>
					<td style="width: 170px;"><input  id = "custname" name = "custname" type = "text"/></td>
					<td style="width: 170px;" style = "border-left: 1px;">是否需要ROHS认证</td>
					<td style="width: 170px;"><input  id = "rFlag" name = "rFlag" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">产品名称</td>
					<td style="width: 170px;"><input  id = "prodTypeName" name = "prodTypeName" type = "text"/></td>
					<td style="width: 170px;">合同或销售条件号</td>
					<td style="width: 170px;"><input  id = "contractCode" name = "contractCode" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">经营主体</td>
					<td colspan="3" align="center" ><input style = "width: 550px;" id = "deptname" name = "deptname" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">商检批次号</td>
					<td style="width: 170px;"><input  id = "checkCode" name = "checkCode" type = "text"/></td>
					<td style="width: 170px;">客户 PO NO</td>
					<td style="width: 170px;"><input  id = "orderPoCode" name = "orderPoCode" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">结算方式</td>
					<td style="width: 170px;" colspan="3" ></td>
				</tr>
				<tr>
					<td colspan="4" style="width: 1100px;">
						<table id ="datagridP"></table>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="height: 60px;" >
					<tt>编制:</tt>
					</td>
					<td colspan="2">审核:</td>
				</tr>
			</table>
			
			<table class="reportTable" style="width:100%">
				<tr>
					<td align="center" rowspan="9" style="width: 27px">订单执行</td>
					
				</tr>
				<tr>
					<td rowspan="2" style="width: 40px" align="center">序号</td>
					<td rowspan="8" style="width: 50px" align="center">生产进程【由产品部事业部订单经理负责】</td>
					<td rowspan="1"  style="width: 120px" align="center">加工工厂</td>
					<td colspan="6"><input style = "width: 450px;"  id = "itemName" name = "itemName" type = "text"/></td>
				</tr>
				<tr>
					<td style="width: 80px" align="center">活动</td>
					<td style="width: 80px" align="center">预算</td>
					<td style="width: 80px" align="center">实际</td>
					<td style="width: 80px" align="center">差异</td>
					<td style="width: 80px" align="center">责任位</td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">1</td>
					<td align="center">JIT</td>
					<td style="width: 80px" align="center"><input  id = "planDate1" name = "planDate1" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate1" name = "actualFinishDate1" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c1" name = "c1" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName1" name = "uName1" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center"></td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">2</td>
					<td align="center">首样</td>
					<td style="width: 80px" align="center"><input  id = "planDate2" name = "planDate2" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate2" name = "actualFinishDate2" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c2" name = "c2" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName2" name = "uName2" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">3</td>
					<td align="center">生产开始Tp</td>
					<td style="width: 80px" align="center"><input  id = "planDate3" name = "planDate3" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate3" name = "actualFinishDate3" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c3" name = "c3" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName3" name = "uName3" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">4</td>
					<td align="center">生产</td>
					<td style="width: 80px" align="center"><input  id = "planDate4" name = "planDate4" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate4" name = "actualFinishDate4" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c4" name = "c4" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName4" name = "uName4" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">5</td>
					<td align="center">商检</td>
					<td style="width: 80px" align="center"><input  id = "planDate5" name = "planDate5" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate5" name = "actualFinishDate5" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c5" name = "c5" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName5" name = "uName5" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
				<tr>
					<td style="width: 50px" align="center">6</td>
					<td align="center">装箱</td>
					<td style="width: 80px" align="center"><input  id = "planDate6" name = "planDate6" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "actualFinishDate6" name = "actualFinishDate6" type = "text" class="date" /></td>
					<td style="width: 80px" align="center"><input  id = "c6" name = "c6" type = "text"/></td>
					<td style="width: 80px" align="center"><input  id = "uName6" name = "uName6" type = "text"/></td>
					<td style="width: 80px" align="center"></td>
					<td style="width: 80px" align="center">/</td>
				</tr>
			</table>
			<table class="reportTable">
			<tr>
				<td>确认 ：工厂排产员  ：  </td>
			</tr>
			</table>
		</div>
		<div style = "">备注 1 : 产品类型代号分别为 A1  老产品,老客户； A2  老产品,新客户；新产品,改进系列；B1  不需新开模具,B2  新开注塑模，B3  新开钣金模；B4  系统匹配;B5  其它；新产品，新开系列；C1 不需新开模具，C2  新开注塑模, C3 新开钣金模，C4  系统匹配，C5  其它; </div>
		<div style = "margin-top: 10px; ">备注2：本批产品正式生产前3天首先进行原材料清查，并进性样机确认，其中首次出口需经海外推支持经理及检验公司同时确认，以后经检验公司确认，确认合格后方可生产；生产完毕并有检验公司出具合格报告后方可收货。 </div>
		<div style = "margin-top: 10px;">备注3：特殊检验是指客户要求的由第三方检测机构在每批发货之前进行的检验，业务经理必须在输入定单的同时，在“特殊检验要求”一栏内输入特殊检验的名称（如：尼日利亚的OMIC检、沙特的SASO检、孟加拉的ITS检、美国的SGS检等），产品部按特殊的要求进行备好货。 </div>
		<div style = "margin-top: 10px;"> 备注4：备货单各项均在网络上生成，手写无效。作为产品本部/直属事业部开始生产的依据。 </div>
		<div style = "margin-top: 10px;"> 备注5：该备货通知单 </div>
		<div style = "margin-left: 42px; ">第一联：产品部留存； </div>
		<div style = "margin-left: 42px; ">第二联：转产品财务部据此开发票并随同发票转海外推财务部； </div>
		<div style = "margin-left: 42px; ">第三联：加盖生产完毕确认章并经海外推备货员确认后转海外推业务经理据此开综合通知单。 
		</div>
	</div>
	</form></div>
</body>
</html>