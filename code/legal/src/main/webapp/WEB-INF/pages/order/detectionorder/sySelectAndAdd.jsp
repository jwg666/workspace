<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	/**
	 *订单的物料实测信息
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var addOrUpdateForm;
	var datagrid;
	var lastIndex;
	$(function() {
		addOrUpdateForm = $('#addOrUpdateForm').form();
		//查询列表	
		datagrid = $('#datagrid').datagrid({
			url : '../salesOrder/salesOrderItemAction!syDataGrid.action?orderCode=${orderCode}',
			title : '订单物料明细表列表',
			iconCls : 'icon-save',
			//pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			//pageSize : 10,
			//pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'ORDERITEMLINECODE',
			
			singleSelect: true,
			columns : [ [ 
		    {
				field : 'ORDERCODE',
				title : '订单编号',
				align : 'center',
				sortable : true
			}, 
			 {
				field : 'ORDERITEMLINECODE',
				title : '行项目号',
				align : 'center',
				sortable : true
			},
			{
				field : 'HAIERMODEL',
				title : '海尔型号',
				align : 'center',
				sortable : true
			}, {
				field : 'CUSTOMERMODEL',
				title : '客户型号',
				align : 'center',
				sortable : true
			}, {
				field : 'AFFIRMNUM',
				title : '特技单号',
				align : 'center',
				sortable : true
			}, {
				field : 'MATERIALCODE',
				title : '套机物料号',
				align : 'center',
				sortable : true
			}, {
				field : 'FENJICODE',
				title : '分机物料号',
				align : 'center',
				sortable : true
			}, {
				field : 'SPLITFLAG',
				title : '套机标识',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					if(row.SPLITFLAG==null||row.SPLITFLAG==0){
						return '否';
					}else if(row.SPLITFLAG==1){
						return '是';
					}else{
						return row.SPLITFLAG;
					}
				}
			},{
				field : 'PRODQUANTITY',
				title : '数量',
				align : 'center',
				sortable : true
			},{
				field : 'COMPLETE_QUOTIETY',
				title : '成套系数',
				align : 'center',
				sortable : true
			},
			{
				field : 'ALLJZ',
				title : '总净重',
				align : 'center',
				sortable : true
			}, {
				field : 'DETEALLJZ',
				title : '实测总净重',
				align : 'center',
				sortable : true,
				editor:{  
	                type:'numberbox',
	                options:{  
	                    required:true  
	                }  
	            } 
			}, {
				field : 'ALLMZ',
				title : '总毛重',
				align : 'center',
				sortable : true
			}, {
				field : 'DETEALLMZ',
				title : '实测总毛重',
				align : 'center',
				sortable : true,
				editor:{  
	                type:'numberbox',
	                options:{  
	                    required:true  
	                }  
	            }
			}, {
				field : 'ALLTJ',
				title : '总体积',
				align : 'center',
				sortable : true
			}, {
				field : 'DETEALLTJ',
				title : '实测总体积',
				align : 'center',
				sortable : true,
				editor:{  
	                type:'numberbox',
	                options:{  
	                    required:true  
	                }  
	            }
			} ] ]
			<s:if test="ifBz=='no'">
			,
			onClickRow : function(i, d) {
				if (i != lastIndex) {
					datagrid.datagrid('beginEdit', i);
					datagrid.datagrid('endEdit', lastIndex);
				} else {
					datagrid.datagrid('beginEdit', i);
				}
				lastIndex = i;
			}

			</s:if>
			<s:if test="ifBz=='yes'">
			,
			//点击录入实测信息
			onClickRow : function(rowIndex,rowData) {
				//订单号
				var orderCode=rowData.ORDERCODE;
				//订单明细表行项目号
				var lineCode=rowData.ORDERITEMLINECODE;
				//套机物料号
				var materialCode=rowData.MATERIALCODE;
				//分机物料号
				var fenjiCode=rowData.FENJICODE;
				//物料数目
				var count=rowData.PRODQUANTITY
				//判断分机物料号是否为空，如果为空，表示物料不为套机，用套机物料code，如果不为空表示为套机，用分机物料编号
				if(rowData.FENJICODE!=null&&rowData.FENJICODE!=''){
					showInformation(orderCode,lineCode,fenjiCode,count);
				}else if(rowData.FENJICODE==null||rowData.FENJICODE==''){
					showInformation(orderCode,lineCode,materialCode,count);
				}
				
			}
			</s:if>
		});
	});
	//将实测信息存入数据库中
function addOrUpdate(){
		//任务id
		var taskId='${taskId}';
		//分配者code
		var assignee='${assignee}';
		$('#taskId1').val(taskId);
		$('#assignee1').val(assignee);
	<s:if test="ifBz=='yes'">
	//判断净重是否大于毛重
	var jingzhong=parseInt($("#detectionNetWeightSingle").val()==''?'0':$("#detectionNetWeightSingle").val());
	var maozhong=parseInt($("#detectionGrossWeightSingle").val()==''?'0':$("#detectionGrossWeightSingle").val());
	if(jingzhong>maozhong){
		$.messager.alert('提示','净重不能大于毛重','info');
		return;
	}
	//标准订单的信息录入
	$('#addOrUpdateForm').form('submit',{
		url:'${dynamicURL}/materialActualDetection/materialActualDetectionAction!addOrUpdate.do?taskId='+taskId+'&assignee='+assignee,
		//dataType: 'json',
		success:function(data){
			$.messager.progress('close');
			var data = $.parseJSON(data);
		    if(data.success){
		    	$.messager.show({
					title : '成功',
					msg : data.msg
				});
		    	datagrid.datagrid('reload');
		    }else{
		    	$.messager.show({
					title : '失败',
					msg : data.msg
				});
		    }
		    //更新物料实测和默认信息
		    var rowData=datagrid.datagrid('getSelections')[0];
			//订单号
			var orderCode=rowData.ORDERCODE;
			//订单明细表行项目号
			var lineCode=rowData.ORDERITEMLINECODE;
			//套机物料号
			var materialCode=rowData.MATERIALCODE;
			//分机物料号
			var fenjiCode=rowData.FENJICODE;
			//物料数目
			var count=rowData.PRODQUANTITY
			//判断分机物料号是否为空，如果为空，表示物料不为套机，用套机物料code，如果不为空表示为套机，用分机物料编号
			if(rowData.FENJICODE!=null&&rowData.FENJICODE!=''){
				showInformation(orderCode,lineCode,fenjiCode,count);
			}else if(rowData.FENJICODE==null||rowData.FENJICODE==''){
				showInformation(orderCode,lineCode,materialCode,count);
			}
			
		},
		onSubmit:function(){
			$.messager.progress();
		}
	});
	</s:if>
	<s:if test="ifBz=='no'">
	   // $.messager.alert('开始','开始提交了','info');
	   //备件或散件订单的实测信息录入
	   datagrid.datagrid('endEdit',lastIndex);
	    var updateRows = datagrid.datagrid("getChanges");
	    //alert(datagrid.datagrid('validateRow',0));
	    var ul= updateRows.length;
	    for(var i=0;i<ul;i++){
	    	var amz=updateRows[i].ALLMZ;
	    	var ajz=updateRows[i].ALLJZ;
	    	if(ajz>amz){
	    		$.messager.alert('提示','总净重不能大于总毛重','info');
	    		return;
	    	}
	    }
	    var jsonStr = JSON.stringify(updateRows);
	    $.ajax({
			type : 'post',
			url : '${dynamicURL}/materialActualDetection/materialActualDetectionAction!addOrUpdate1.action?taskId='+taskId+'&assignee='+assignee,
			data : "mapList="+jsonStr,
			dataType:'json',
			success : function(response){
				$.messager.progress('close');
				if(response.success){
					$.messager.show({
						title:'提示',
						msg: response.msg
					});
					datagrid.datagrid('reload');
				}else{
					$.messager.alert('提示',response.msg,'error');
				}
				
			},
			beforeSend:function(){
				$.messager.progress();
			}
		}); 
	</s:if>
};
//显示物料预估信息或实测信息
function showInformation(orderCode,lineCode,materialCode,count){
	//alert(orderCode+' : '+lineCode+' : '+materialCode+" : "+count);
	$("#addOrUpdateForm").form('clear');
	$("#countOfMateriaId").val(count);
	$.ajax({
		   type: "POST",
		   url: "${dynamicURL}/detectionOrder/detectionOrderAction!showDetailOfWL.action",
		   data: {
			   orderCode : orderCode,
			   linceCode : lineCode,
			   materialCode : materialCode
			   
		   },
		   success: function(json){
		   		var data = $.parseJSON(json);
		   		if(data.success){
		   			$("#addOrUpdateForm").form('load',data.obj);
		   		}else{
		   			$.messager.alert('提示',data.msg,'error');
		   		}
		   		computeDiffence();
		   }
	   });
}
//计算实测体积
function computColume(){
	var high=($("#detectionHigh").val()=='')?'0':$("#detectionHigh").val();
	var length=($("#detectionLenth").val()=='')?'0':$("#detectionLenth").val();
	var width=($("#detectionWidth").val()=='')?'0':$("#detectionWidth").val();
	var highN=parseInt(high);
	var lengthN=parseInt(length);
	var widthN=parseInt(width);
	$("#detectionColume").val(highN*lengthN*widthN);
	//$("#detectionColume").val(high*length*width);
	computeDiffence();
}

//计算差异
function computeDiffence(){
	var allDataName=new Array('detectionNetWeightSingle','detectionGrossWeightSingle',
			'detectionWidth','detectionLenth',
			'detectionHigh','detectionColume');
	for(var index in allDataName){
		var dataName=allDataName[index];
		var shiceString=($("#"+dataName).val()=='')?'0':$("#"+dataName).val();
		var mdmString=($("#"+dataName+"1id").val()=='')?'0':$("#"+dataName+"1id").val();
		var shiceDouble=parseFloat(shiceString);
		var mdmDouble=parseFloat(mdmString);
		var chayi= Math.abs((shiceDouble-mdmDouble)/mdmDouble)*100;
		$("#"+dataName+"chayi").html(chayi.toFixed(3)+"%");
	}
	
}
</script>
</head>
<body class="easyui-layout zoc">
	<div region="center" border="false" style="heigth: 300px;">
		<table id="datagrid"></table>
	</div>
	<div region=south border="false"<s:if test="ifBz=='yes'"> title="单台信息"</s:if> style="height: 350px;"
		align="left">

		<div class="oneline">
			<div class="item100">
				<div class="oprationbutt" style="text-align: left;">
					<input type="button" value="保存" onclick="addOrUpdate();" />
				</div>
			</div>
		</div>


	<s:if test="ifBz=='yes'">
		<div data-options="region:'south'" border="false" class="zoc"
			collapsed="false" style="height: 290px; width: 100%; overflow: auto;"
			align="left">
			<form id="addOrUpdateForm">
				<input name="actMaterialDetectionCode" type="hidden" /> <input
					name="orderNum" type="hidden" /> <input name="orderLinecode"
					type="hidden" /> <input name="materialCode" type="hidden" /> <input
					name="countOfMateria" id="countOfMateriaId" type="hidden" /> <input
					name="taskId" id="taskId1" type="hidden" /> <input name="assignee"
					id="assignee1" type="hidden" />
				<div class="part_zoc" region="north">
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">物料净重(kg)</div>
							<div class="righttext">
								<input name="detectionNetWeightSingle1" id="detectionNetWeightSingle1id" precision="3" readonly="readonly" type="text" class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">实测净重(kg)</div>
							<div class="righttext">
								<input id="detectionNetWeightSingle" name="detectionNetWeightSingle" onblur="computColume();" precision="3" class="easyui-numberbox" type="text" class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">差异：</div>
							<div class="righttext" id="detectionNetWeightSinglechayi">
								
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">物料毛重(kg)</div>
							<div class="righttext">
								<input name="detectionGrossWeightSingle1" id="detectionGrossWeightSingle1id" precision="3"  readonly="readonly" type="text"
									class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">实测毛重(kg)</div>
							<div class="righttext">
								<input id="detectionGrossWeightSingle" name="detectionGrossWeightSingle" onblur="computColume();" precision="3" type="text" class="easyui-numberbox"
									class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">差异：</div>
							<div class="righttext" id="detectionGrossWeightSinglechayi">
								
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">物料外包装宽(mm)</div>
							<div class="righttext">
								<input name="detectionWidth1" id="detectionWidth1id" type="text" readonly="readonly" class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">实测外包装宽(mm)</div>
							<div class="righttext">
								<input name="detectionWidth" class="easyui-numberbox" id="detectionWidth"
									onblur="computColume();" type="text" class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">差异：</div>
							<div class="righttext" id="detectionWidthchayi">
								
							</div>
						</div>
					</div>

					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">物料外包装深(mm)</div>
							<div class="righttext">
								<input name="detectionLenth1" id="detectionLenth1id" type="text" readonly="readonly" class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">实测外包装深(mm)</div>
							<div class="righttext">
								<input name="detectionLenth" class="easyui-numberbox" id="detectionLenth"
									onblur="computColume();" type="text" class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">差异：</div>
							<div class="righttext" id="detectionLenthchayi">
								
							</div>
						</div>
					</div>

					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">物料外包装高(mm)</div>
							<div class="righttext">
								<input name="detectionHigh1" id="detectionHigh1id" type="text" readonly="readonly" class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">实测外包装高(mm)</div>
							<div class="righttext">
								<input name="detectionHigh" class="easyui-numberbox" id="detectionHigh"
									onblur="computColume();" type="text" class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">差异：</div>
							<div class="righttext" id="detectionHighchayi">
								
							</div>
						</div>
					</div>
					<div class="oneline">
						<div class="item33">
							<div class="itemleft100">物料体积(mm<SUP>3</SUP>)</div>
							<div class="righttext">
								<input name="detectionColume1" id="detectionColume1id" readonly="readonly" type="text" class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">实测体积(mm<SUP>3</SUP>)</div>
							<div class="righttext">
								<input name="detectionColume" readonly="readonly" type="text" id="detectionColume"
									class="long" />
							</div>
						</div>
						<div class="item33">
							<div class="itemleft100">差异：</div>
							<div class="righttext" id="detectionColumechayi">
								
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</s:if>
	</div>
</body>
</html>