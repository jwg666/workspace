<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
var billcombox;
$(function(){
	$.extend($.fn.validatebox.defaults.rules, {
		positive_int:{  
	        validator:function(value,param){  
	            if (value){  
	                return /^[0-9]*[1-9][0-9]*$/.test(value);  
	            } else { 
	                return true;  
	            }
	        },  
	        message:'只能输入正整数!'  
	    }
	});
	//加载目的港信息
	$('#portEndCode').combogrid({
		url : '${dynamicURL}/basic/portAction!datagrid.action',
		idField : 'portCode',
		textField : 'portName',
		panelWidth : 500,
		panelHeight : 220,
		pagination : true,
		pagePosition : 'bottom',
		toolbar : '#_PORTEND',
		rownumbers : true,
		pageSize : 5,
		pageList : [ 5, 10 ],
		fit : true,
		fitColumns : true,
		//required:true,
		columns : [ [ {
			field : 'portCode',
			title : '目的港编码',
			width : 10
		}, {
			field : 'portName',
			title : '目的港名称',
			width : 10
		} ] ]
	});
	//运输公司
	$('#venderCode').combogrid({
		url : '${dynamicURL}/basic/vendorAction!datagrid0.do',
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
		//required:true,
		columns : [ [ {
			field : 'vendorCode',
			title : '船公司编号',
			width : 10
		}, {
			field : 'vendorNameCn',
			title : '船公司名称',
			width : 10
		} ] ]
	});
	billcombox=$('#billNumid').combogrid({
		url : '${dynamicURL}/shipOrder/billOrderAction!datagrid0.action',
		idField:'billNum',
		textField : 'billNum',
		panelWidth : 500,
		panelHeight : 220,
		toolbar : '#_BILLNUM',
		pagination : true,
		pagePosition : 'bottom',
		rownumbers : true,
		pageSize : 5,
		pageList : [ 5, 10 ],
		fit : true,
		fitColumns : true,
		nowrap : true,
		border : false,
		columns : [ [ 
		  {
			field : 'billNum',
			title : '提单号',
			width : 10
		},{
			field : 'shipName',
			title : '船公司',
			width : 10
		}] ],onChange:function(){
			var billNum=billcombox.combobox('getValue');
		    getbillorderinfromation(billNum);
		}
	});
	$('#billNumid').combogrid({
		url : '${dynamicURL}/shipOrder/billOrderAction!datagrid0.action?billNum=${shipOrderQuery.billNum}'
	});
	var billNum=billcombox.combobox('getValue');
    getbillorderinfromation(billNum);
    //自定义格式校验
	 /*  $('#rangeId').validatebox({
	      validType: 'positive_int["'+'请输入数字'+'"]'  
	  }); */
});
//获得提单的信息
function getbillorderinfromation(rbillnum){
	$.ajax({
		url:'${dynamicURL}/shipOrder/billOrderAction!findBillNum',
		dataType:'json',
		type:'POST',
		data:{
			billNum:rbillnum
		},
		success:function(data){
			if(data.success){
    			$("#addBillOrder").form('load',data.obj);
    			
    			$('#venderCode').combogrid({
    				url : '${dynamicURL}/basic/vendorAction!datagrid0.do?vendorCode='+data.obj.carrier
    			});
    			$('#venderCode').combogrid('setValue',data.obj.carrier);
    			$('#portEndCode').combogrid({
    				url : '${dynamicURL}/basic/portAction!datagrid.do?portCode='+data.obj.destPort
    			});
    			$('#portEndCode').combogrid('setValue',data.obj.destPort);
    			var shiporderTime=$('#shipdateid').datebox('getValue');
    			//alert(shiporderTime);
    			$('#chuyuntime').datebox('setValue',shiporderTime);
			}else{
				$.messager.alert('警告',data.msg,'error');
			}
		}
	});
}
function save(){
	/* var billNum =$('#billNumid').combogrid('getValue');
	var rangeIdvalue=$('#rangeId').val();
	var timechuyun=$('#chuyuntime').datetimebox('getValue');
	if(billNum==null||billNum==''){
		return;
	}
	if(timechuyun==null||timechuyun==''){
		return;
	}
	if (rangeIdvalue){  
        if(!(/^[0-9]*[1-9][0-9]*$/.test(rangeIdvalue))){
        	return;
        }
    } else { 
        return true;  
    } */
	$.messager.progress({
		text : '数据加载中....',
		interval : 100
	});
	 $('#addForm').form('submit',{
		 type:'POST',
		url:'${dynamicURL}/shipOrder/shipOrderAction!saveOrUpdateshipOrder.action',
		success:function(data){
			var dd=$.parseJSON(data);
			if(dd.success){
				$.messager.progress('close');
				$.messager.alert('提示',dd.msg,'info',function(){
					//代办刷新
					customWindow.reloaddata();
					//代办肯定
					parent.window.HROS.window.close(currentappid);
				});
			}else{
				$.messager.progress('close');
				$.messager.alert('警告',dd.msg,'error');
			}
		}
	}); 
}  
function chuyun(){
	/* var billNum =$('#billNumid').combogrid('getValue');
	var rangeIdvalue=$('#rangeId').val();
	var timechuyun=$('#chuyuntime').datetimebox('getValue');
	if(billNum==null||billNum==''){
		return;
	}
	if(timechuyun==null||timechuyun==''){
		return;
	}
	if (rangeIdvalue){  
        if(!(/^[0-9]*[1-9][0-9]*$/.test(rangeIdvalue))){
        	return;
        }
    } else { 
        return true;  
    } */
	$.messager.progress({
		text : '数据加载中....',
		interval : 100
	});
	$('#addForm').form('submit',{
		type:'POST',
		url:'${dynamicURL}/shipOrder/shipOrderAction!saveOrUpdateshipOrderandChuyun.action',
		success:function(data){
			var dd=$.parseJSON(data);
			if(dd.success){
				$.messager.progress('close');
				$.messager.alert('提示',dd.msg,'info',function(){
					//代办刷新
					customWindow.reloaddata();
					//代办肯定
					parent.window.HROS.window.close(currentappid);
				});
			}else{
				$.messager.progress('close');
				$.messager.alert('警告',dd.msg,'error');
/* 				$.messager.show({
					title:'警告',
					msg:dd.msg,
					icon:'error'
				}); */
			}
		}
	});
}
function xiugaichuyun(){
	/* var billNum =$('#billNumid').combogrid('getValue');
	var rangeIdvalue=$('#rangeId').val();
	var timechuyun=$('#chuyuntime').datetimebox('getValue');
	if(billNum==null||billNum==''){
		return;
	}
	if(timechuyun==null||timechuyun==''){
		return;
	}
	if (rangeIdvalue){  
        if(!(/^[0-9]*[1-9][0-9]*$/.test(rangeIdvalue))){
        	return;
        }
    } else { 
        return true;  
    } */
	$.messager.progress({
		text : '数据加载中....',
		interval : 100
	});
	$('#addForm').form('submit',{
		type:'POST',
		url:'${dynamicURL}/shipOrder/shipOrderAction!saveOrUpdateAfterChuyun.action',
		success:function(data){
			var dd=$.parseJSON(data);
			if(dd.success){
				$.messager.progress('close');
				$.messager.alert('提示',dd.msg,'info',function(){
					//代办刷新
					customWindow.reloaddata();
					//代办肯定
					parent.window.HROS.window.close(currentappid);
				});
			}else{
				$.messager.progress('close');
				$.messager.alert('警告',dd.msg,'error');
/* 				$.messager.show({
					title:'警告',
					msg:dd.msg,
					icon:'error'
				}); */
			}
		}
	});
}
function saveBillOrder(){
	$("#addBillOrder").form('submit',{
		url:'${dynamicURL}/shipOrder/billOrderAction!addOrUpdate.action',
		success:function(data){
			var dd=$.parseJSON(data);
			if(dd.success){
				$.messager.alert('提示',dd.msg,'info',function(){
					$('#billorderNumid').val(dd.obj.billNum);
					CCNMY('billorderNumid','shipNameid','billNumid')
					var num1=$('#billorderNumid').val();
					$('#billNumid').combogrid('setValue',num1);
					$('#chuyuntime').datebox('setValue',$('#shipdateid').datebox('getValue'));
					//$("#addBillOrder").form('load',dd.obj);
				})
			}else{
				$.messager.show({
					title:'警告',
					msg:dd.msg,
					icon:'error'
				});
			}
		}
	});
}
function saveBillOrderCheck(){
	var billnum=$('#billNumid1').val();
	if(billnum==null||billnum==''){
		$.messager.alert('提示','提单号不能为空','warring');
		return;
	}
	$.messager.progress({
		text : '数据加载中....',
		interval : 100
	});
	var billNum=$('#billNumid1').val();
	var oldBillNum=$('#oldBillNumid').val();
	var url ='${dynamicURL}/shipOrder/billOrderAction!getcount.action';
	$.ajax({
		url:url,
		data:{
			billNum : billNum,
			oldBillNum:oldBillNum
		},
		dataType:'json',
		success:function(data){
			if(data.success){
				$.messager.progress('close');
				saveBillOrder();
			}else{
				$.messager.progress('close');
				$.messager.alert('警告',data.msg,'error');
			}
		}
	});
}
//打开新增提单信息
function savetidan(){
	$("#addBillOrder").form('clear');
	var orderCode=$('#shipMentorderCodeId').val();
	var url='${dynamicURL}/shipOrder/billOrderAction!chushiBillorder.action';
	$.ajax({
		url:url,
		data:{
			orderCode : orderCode
		},
		dataType:'json',
		success:function(data){
			$("#addBillOrder").form('load',data.obj);
			if(data.obj.carrier!=null&&data.obj.carrier!=''){
				 $('#venderCode').combogrid({
						url : '${dynamicURL}/basic/vendorAction!datagrid0.do?vendorCode='+data.obj.carrier
					});
					$('#venderCode').combogrid('setValue',data.obj.carrier);
			}
            if(data.obj.destPort!=null&&data.obj.destPort!=''){
    			$('#portEndCode').combogrid({
    				url : '${dynamicURL}/basic/portAction!datagrid.do?portCode='+data.obj.destPort
    			});
    			$('#portEndCode').combogrid('setValue',data.obj.destPort); 
            }
		}
	});
	/* $('#venderCode').combogrid({
		url : '${dynamicURL}/basic/vendorAction!datagrid0.do?'
	});
	$('#portEndCode').combogrid({
		url : '${dynamicURL}/basic/portAction!datagrid.do'
	}); */
	$("#checkSearch").layout("expand","south");
	//$('#addBillOrder').form('clear');
}
//下拉框查询
function CCNMY(inputId,inputId2,selectId) {
	var _CCNTEMP = $('#' + inputId).val();
	var _CCNTEMP2 = $('#' + inputId2).val();
	var url = '${dynamicURL}/shipOrder/billOrderAction!datagrid0.action?billNum=' + _CCNTEMP;
	if("" != _CCNTEMP2) {
		url = url + '&shipName=' + _CCNTEMP2;
	}
	$('#' + selectId).combogrid({
		url : url
	});
}
//查询中标公司的下拉
function VENDOR_PORTMY(inputId, selectId) {
	var _CCNTEMP = $('#' + inputId).val()
	$('#' + selectId).combogrid({
		url : '${dynamicURL}/basic/vendorAction!datagrid0.do?vendorNameCn=' + _CCNTEMP
	});
	//$('#' + inputId).val(_CCNTEMP);
}
//模糊查询目的港下拉列表
function _PORTMY(inputId, selectId) {
	var _CCNTEMP = $('#' + inputId).val()
	$('#' + selectId).combogrid({
		url : '${dynamicURL}/basic/portAction!datagrid.do?portName=' + _CCNTEMP
	});
	//$('#' + inputId).val(_CCNTEMP);
}
//下载附件
function downLoad(){
	var fileId=$('#fileId').val();
	//var filePath='dd';
	var downloadfile=$('#downloadfile')
	//downloadfile[0].click();
	$.ajax({
		url : '${dynamicURL}/audit/auditMainAction!ifCanBeDownLoad.action',
		type:'post',
		data :{
			fileId : fileId
		},
		dataType : 'json',
		success : function(response){
			if(!response.success){
				$.messager.alert('提示',response.msg,'warning');
			}else if(response.success){
				var url1='${dynamicURL}/basic/downloadFile!downloadFile.action?fileId='+fileId;
				downloadfile.attr("href",url1);
				downloadfile[0].click();
			}
		}
		
	}); 
	
}
</script>

</head>
<body >
     <div id="checkSearch"  class="easyui-layout" fit="true">
	       <div class=" zoc" title="录入出运信息" region="north" border="false" collapsible="true"
			collapsed="false" style="height: 110px; overflow: hidden;">
			<form id="addForm">
			           <%--  <s:hidden name="assignee"></s:hidden>
			            <s:hidden name="orderCode"></s:hidden>
			            <s:hidden name="shipCode"></s:hidden> --%>
			            <s:hidden name="assignee" ></s:hidden>
			            <s:hidden name="orderCode" id="shipMentorderCodeId"></s:hidden>
			            <s:hidden name="taskId"></s:hidden>
			            <s:hidden name="shipOrderQuery.shipCode" ></s:hidden>
			            <s:hidden name="shipOrderQuery.modificationNum"></s:hidden>
						<div class="oneline">
						<div class="item25">
								<div class="itemleft80">提单号:</div>
								<div class="righttext_easyui">
									<s:textfield name="shipOrderQuery.billNum" id="billNumid" type="text" cssClass="short50 "  editable="false"></s:textfield>
								</div>
						</div>
						<div class="item25">
								<div class="itemleft80">出运时间:</div>
								<div class="righttext_easyui">
									<s:textfield id="chuyuntime" name="shipOrderQuery.actualShipDate" type="text" cssClass="easyui-datebox short50" 
									editable="false"></s:textfield>
								</div>
						</div>
						<div class="item25">
								<div class="itemleft80">航程天数:</div>
								<div class="righttext_easyui">
									 <s:textfield id="rangeId" name="shipOrderQuery.range"  cssClass="easyui-numberbox short50" type="text" >
									</s:textfield>
								</div>
						</div>
						<div class="item25 lastitem">
								<div class="oprationbutt">
								<s:if test='taskId!=null&&task!=""'>
								<input type="button" onclick="save();" value="暂存" /> 
								<input type="button" onclick="chuyun();" value="提交" /> 
								</s:if>
								<s:else>
								<input type="button" onclick="xiugaichuyun();" value="提交" /> 
								</s:else>
								</div>
						</div>
			           </div>
			           <div class="oneline">
			           	     <div class="item33 lastitem">
			           	        <!-- <div class="itemleft80">维护提单:</div> -->
								<div class="oprationbutt">
							<%-- 	<s:if test='taskId!=null&&task!=""'>
								<input type="button"  onclick="savetidan();" value="新增提单" /> 
								</s:if> --%>
								<input type="button"  onclick="savetidan();" value="新增提单" /> 
								</div>
						     </div>
			           </div>
			</form>
	 </div>
	 <div region="center" style="height: 0px;"></div>
	 <div id="div1" region="south" class=" zoc" title="录入提单信息"  border="false" collapsible="true"
			collapsed="true" style="height: 330px; overflow: hidden;">
	     <form id="addBillOrder" method="post" enctype="multipart/form-data">
	     <input  name="billCode"  type="hidden"/>
	     <input id="oldBillNumid" name="oldBillNum" type="hidden"/>
	     <input  name="modificationNum" type="hidden"/>
	     <input  name="attachments" type="hidden" id="fileId"/>
	     
	     <div class="oneline">
						<div class="item25">
								<div class="itemleft80">提单号:</div>
								<div class="righttext_easyui">
									<input id="billNumid1" name="billNum" type="text" class="short50 " />
								    
								</div>
						</div>
						<div class="item25">
								<div class="itemleft80">始发港:</div>
								<div class="righttext_easyui">
									<input name="startPort" type="text" class="easyui-combobox short50"
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!comboxStartPort.do'" />
								    
								</div>
						</div>
						<div class="item25">
								<div class="itemleft80">目的港:</div>
								<div class="righttext_easyui">
									<input id="portEndCode" name="destPort" type="text" class="short50"
										 />
								   
								</div>
						</div>
						
		</div>
		             <div class="oneline">
		              <div class="item25">
								<div class="itemleft80">船公司:</div>
								<div class="righttext_easyui">
								<input id="venderCode" name="carrier" type="text" class="easyui-combobox short50"
										 />
								   
								</div>
					 </div>
					 <div class="item25">
								<div class="itemleft80">出运时间:</div>
								<div class="righttext_easyui">
									<input id="shipdateid" name="shipDate" type="text"  editable="false" class="easyui-datebox short50" />
								    
								</div>
					 </div>
					 <!-- <div class="item25">
								<div class="itemleft80">箱型箱量:</div>
								<div class="righttext_easyui">
									<input name="contrainDesc" class=" short50"  type="text"  />
								    
								</div>
					 </div> -->
					 <div class="item25">
								<div class="itemleft80">提单回收时间:</div>
								<div class="righttext_easyui">
									<input name="takeBillDate" class="easyui-datebox short50"  type="text"  />
								    
								</div>
					 </div>
					 
		</div>
		<!-- <div class="oneline">
		    <div class="item25">
								<div class="itemleft80">提单回收时间:</div>
								<div class="righttext_easyui">
									<input name="takeBillDate" class="easyui-datebox short50"  type="text"  />
								    
								</div>
					 </div>
		</div> -->
		<div class="oneline">
		             <div class="item25">
								<div class="itemleft80">附件:</div>
								<div class="righttext_easyui">
								   <s:file id="uploadid" name="upload"  style="width:140px" />
								</div>
					 </div>
		             <div class="item50">
								<div class="itemleft80">附件名称:</div>
								<div class="righttext_easyui">
								   <input  name="fileName" readonly="readonly" id="fileNameId" class=" short50"/>
								   <%-- <s:file id="uploadid" name="upload"  style="width:140px" /> --%>
								</div>
					 </div>
		    
		</div>
		
		<div class="oneline">
		                        <div class="item25 lastitem">
			           	        <!-- <div class="itemleft80">维护提单:</div> -->
								<div class="oprationbutt">
								<%-- <s:if test='taskId!=null&&task!=""'>
								<input type="button"  onclick="saveBillOrderCheck();" value="保存" />
								</s:if>  --%>
								<input type="button"  onclick="saveBillOrderCheck();" value="保存提单信息" />
								<!-- <input type="button"  onclick="upfujian();" value="上传附件" /> -->
								<!-- <input type="button"  onclick="downloadfujian();" value="下载附件" /> -->
								</div>
								</div>
								<div class="item25 lastitem">
							            <div class="righttext">
											   <a href="${dynamicURL}/basic/downloadFile!downloadFile.action" id="downloadfile"></a> 
											<div class="oprationbutt">
												  <input type="button" value="下载附件" onclick="downLoad();"/>
											</div>
								        </div>
				                </div>
						     
		</div>
	    </form>
	 </div>
	 </div>
	 <div id="_BILLNUM">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">提单号：</div>
				<div class="righttext">
					<input class="short50" id="billorderNumid" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">船公司名称：</div>
				<div class="righttext">
					<input class="short50" id="shipNameid" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div class="oprationbutt">
					<input type="button" value="查询"
						onclick="CCNMY('billorderNumid','shipNameid','billNumid')" />
				</div>
			</div>
		</div>
	</div>
	<div id="_VENDER">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">船公司：</div>
				<div class="righttext">
					<input class="short60" id="VENDOR_PORTINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="VENDOR_PORTMY('VENDOR_PORTINPUT','venderCode')" />
				</div>
				
			</div>
		</div>
	</div>
	<!-- 目的港下拉选信息 -->
	<div id="_PORTEND">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">目的港：</div>
				<div class="righttext">
					<input class="short60" id="_PORTINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_PORTMY('_PORTINPUT','portEndCode')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>