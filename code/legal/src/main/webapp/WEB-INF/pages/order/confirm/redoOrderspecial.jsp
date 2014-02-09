<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var specialCntDatagrid;
	var specialCntProd;
	var specialCntItem;
	var lastIndex;
	$(function() {
		//加载标准箱方案信息列表
		searchForm = $('#searchForm').form();
		specialCntDatagrid = $('#specialCntDatagrid').datagrid({
			url : '${dynamicURL}/specialschema/specialCntAction!datagrid.do',
			queryParams:{
				contractCode:'${contractCode}'
			},
			title : '<s:text name="orderConfirm.specialTitle">标准箱方案信息列表</s:text>',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 5,
			pageList : [ 5, 10, 15, 20 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'contractCode',
			
			singleSelect : true,
			columns : [ [
			{
				field : 'contractCode',
				title : '<s:text name="order.contract.contractCode">合同编号</s:text>',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.contractCode;
				}
			},
			{
				field : 'specialCntNum',
				title : '<s:text name="global.order.specialCode">标准箱方案号</s:text>',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.specialCntNum;
				}
			},
			{
				field : 'multipeOrder',
				title : '<s:text name="specialschema.specialMuitipe">方案倍数</s:text>',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.multipeOrder;
				},
				editor:{
					type:'numberbox'
                }
			}] ],
			toolbar : [{
				 text : '<s:text name="global.writeNum">填写倍数</s:text>',
				 iconCls : 'icon-edit',
				 handler : function(){
				   	userData();
				 }
			}]
		});
		//加载标准箱方案配载物料列表
		specialCntProd = $('#specialCntProd').datagrid({
			title : '<s:text name="specials.prodListTitle">标准箱方案配载物料列表</s:text>',
			fit : true,
			nowrap : true,
			border : false,
			columns : [ [
			{
				field : 'prodCode',
				title : '<s:text name="specialschema.haierModel">海尔型号</s:text>',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.prodCode;
				}
			},
			{
				field : 'oemType',
				title : '<s:text name="specialschema.oemType">客户型号</s:text>',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.oemType;
				}
			},
			{
				field : 'affirmNum',
				title : '<s:text name="specialschema.affirmNum">特技单号</s:text>',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.affirmNum;
				}
			},
			{
				field : 'minQuantity',
				title : '<s:text name="specials.minQuantity">配载数量</s:text>',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.minQuantity;
				}
			},
			{
				field : 'contrainType',
				title : '<s:text name="specialschema.contrainerType">箱型箱量</s:text>',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.contrainType;
				}
			},
			{
				field : 'packageQuantity',
				title : '<s:text name="specialschema.packageQuantity">最小包装数</s:text>',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.packageQuantity;
				}
			},
			{
				field : 'outerQuantity',
				title : '<s:text name="specialschema.outerQuantity">最外包装数</s:text>',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.outerQuantity;
				}
			}] ]
		});
		//方案应用结果列表
		specialCntItem = $('#specialCntItem').datagrid({
			title : '<s:text name="orderConfirm.specialResultTitle">方案应用结果列表</s:text>',
			fit : true,
			nowrap : true,
			border : false,
			columns : [ [
			{
				field : 'haierModel',
				title : '海尔型号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.haierModel;
				}
			},
			{
				field : 'customerModel',
				title : '客户型号',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.customerModel;
				}
			},
			{
				field : 'affirmNum',
				title : '特技单号',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.affirmNum;
				}
			},
			{
				field : 'multipeOrder',
				title : '配载倍数',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.multipeOrder;
				}
			},
			{
				field : 'prodQuantity',
				title : '订单数量',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.prodQuantity;
				}
			},
			{
				field : 'orderMinQuantity',
				title : '方案配载数量',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.orderMinQuantity;
				}
			},
			{
				field : 'typQua',
				title : '订单箱型箱量',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.typQua;
				}
			},
			{
				field : 'specialTypQua',
				title : '方案配载箱型箱量',
				align :'center',
				sortable : true,
				formatter : function(value, row, index){
					return row.specialTypQua;
				}
			}] ]
		});
	});
	//使用标准箱方案 
	function userSubmit(){
		endEdit();
		var rows = specialCntDatagrid.datagrid('getSelections');
		if(rows.length > 0){
			if(rows[0].multipeOrder != null && rows[0].multipeOrder != ''){
				//标准箱方案配载物料列表
				specialCntProd.datagrid({
					url:'${dynamicURL}/specialschema/specialCntProdAction!datagrid.do',
					queryParams:{
						specialCntId:rows[0].specialCntNum
					}
				});
				//方案应用结果列表
				specialCntItem.datagrid({
					url:'${dynamicURL}/salesOrder/salesOrderAction!specialCntItemByOrderCode.do',
					queryParams:{
						orderCode:'${orderCode}',
						specialCntId:rows[0].specialCntNum,
						multipeOrder:rows[0].multipeOrder
					}
				});
			}else{
				$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>',"<s:text name='orderConfirm.writeSpecialCodeInfo'>请填写标准箱号为：</s:text>"+rows[0].specialCntNum+"<s:text name='orderConfirm.specialNumInfo'>的倍数！</s:text>",'info');
			}
			
		}else{
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="global.info.selectData">请选择一条数据！</s:text>','info');
		}
		
	}
	//结束编辑方法
	function endEdit(){
	     var rowsSelect = $('#specialCntDatagrid').datagrid('getRows');
	     for ( var i = 0; i < rowsSelect.length; i++) {
	          $('#specialCntDatagrid').datagrid('endEdit', i);
	     }
	}
	 //查询
	function _search() {
		specialCntDatagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	//重置
	function cleanSearch() {
		specialCntDatagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	//比对标准箱物料信息和订单信息的海尔型号，特技单号，客户型号是否相等
	function checkSubmit(){
		//获取标准箱号
		var updated = specialCntDatagrid.datagrid("getSelections");
		var specialCntNum = updated[0].specialCntNum;
		var multipeOrder = updated[0].multipeOrder;
		//判断箱型箱量是否相等标识
		var typQuaFlag = true;
		//标准箱方案配载物料列表
		var specialCntRows = specialCntProd.datagrid('getRows');
		//方案应用结果列表
		var specialCntItemRows = specialCntItem.datagrid('getRows');
		var listSpecialOrder = new Array(); 
		//标准箱物料信息和方案应用结果信息相等的个数
		var total = 0;
		if(specialCntRows.length > specialCntItemRows.length){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.specialAvailInfo">该标准箱方案号无效,请重新选择！</s:text>','info');
			typQuaFlag = false;
		}else if(specialCntRows.length ==0 && specialCntItemRows.length == 0){
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="order.confirm.specialIssueInfo">该标准箱方案号有问题,请重新选择！</s:text>','info');
			typQuaFlag = false;
		}else{
			$.messager.progress({
				text : '<s:text name="the.data.load">数据加载中....</s:text>',
				interval : 100
			});
			for(var i = 0; i < specialCntItemRows.length; i++){
				if(specialCntItemRows[i].standardContainerId == "" || specialCntItemRows[i].standardContainerId == null){
					if(specialCntItemRows[i].multipeOrder != 0){
						//判断订单数量和方案配载数量是否相等
						if(specialCntItemRows[i].prodQuantity == specialCntItemRows[i].orderMinQuantity)
						{
							typQuaFlag = trunTypQua(specialCntItemRows[i].typQua, specialCntItemRows[i].specialTypQua);
							if(typQuaFlag){
								for(var i = 0; i < specialCntItemRows.length; i++){
									for(var j = 0; j < specialCntRows.length; j++){
										if(specialCntItemRows[i].haierModel == specialCntRows[j].prodCode
										   && specialCntItemRows[i].customerModel == specialCntRows[j].oemType
										   && specialCntItemRows[i].affirmNum == specialCntRows[j].affirmNum)
										{
											listSpecialOrder[total] =  specialCntItemRows[i];
											total++;
										}
									}
								}
								if(total >= specialCntRows.length){
									$.ajax({
										url:'${dynamicURL}/salesOrder/salesOrderItemAction!updateStarDardStatue.do',
										data:{
											'listParams': JSON.stringify(listSpecialOrder),
											'standardContainerId': specialCntNum,
											'standardNum': multipeOrder
										},
										dataType : 'json',
										type: 'post',
										async: false,
										success:function(data){
											//关闭当前页面
											if(data.success){
												customWindow.setRedoSpecialCntNum(specialCntNum, multipeOrder);
												parent.window.HROS.window.close(currentappid);
												$.messager.progress('close');
											}else{
												$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.confirmFailInfo">确定失败！</s:text>','info');
												$.messager.progress('close');
												typQuaFlag = false;
											}
										}
									});
									$.messager.progress('close');
								}else{
									$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>',"<s:text name='orderConfirm.comparIssueInfo'>标准箱方案配载和应用结果比对信息不符,请重新选择！</s:text>",'info');
									$.messager.progress('close');
									typQuaFlag = false;
								}
							}else{
								$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.haierModalInfo">海尔型号为：</s:text>'+specialCntItemRows[i].haierModel+"<s:text name='orderConfirm.customerModalInfo'>，客户型号为：</s:text>"+specialCntItemRows[i].customerModel+"<s:text name='orderConfirm.affirmNumInfo'>，特技单号为：</s:text>"+specialCntItemRows[i].affirmNum+"<s:text name='orderConfirm.specialTyquaDiffInfo'>的箱型箱量不相等或者为空,请检查！</s:text>",'info');
								$.messager.progress('close');
								typQuaFlag = false;
								break;
							}
						}else{
							$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.haierModalInfo">海尔型号为：</s:text>'+specialCntItemRows[i].haierModel+"<s:text name='orderConfirm.customerModalInfo'>，客户型号为：</s:text>"+specialCntItemRows[i].customerModel+"<s:text name='orderConfirm.affirmNumInfo'>，特技单号为：</s:text>"+specialCntItemRows[i].affirmNum+"<s:text name='orderConfirm.specialQuantityDiffInfo'>的订单数量和方案配载数量不相等,请检查！</s:text>",'info');
							$.messager.progress('close');
							typQuaFlag = false;
							break;
						}
					}
				}
			}
		}
		if(typQuaFlag){
			$.messager.progress('close');
			customWindow.setRedoSpecialCntNum(specialCntNum, multipeOrder);
			parent.window.HROS.window.close(currentappid);
		}
	}
	//截取箱型箱量
	function trunTypQua(orderTypQua, specialTypQua){
		//标识箱型箱量比对是否相等
		var typQua = true;
		if(orderTypQua == null || orderTypQua == "" ){
			typQua = false;
		}else if(specialTypQua == null || specialTypQua == ""){
			typQua = false;
		}else{
			var orderQuaString = orderTypQua.split(',');
			var specialQuaString = specialTypQua.split(',');
			for(var i = 0; i < orderQuaString.length; i++){
				/* for(var j = 0; j < specialQuaString.length; j++){
					var orderQua = orderQuaString[i].split('*');
					var specialQua = specialQuaString[j].split('*');
					//判断箱型是否相等
					if(orderQua[0] == specialQua[0]){
						if(Number(orderQua[1] != Number(specialQua[1]))){
							typQua = false;
							break;
						}
					}
				} */
				var orderQua = orderQuaString[i].split('*');
				var orderQuaInfo = orderQua[0]+"*"+Number(orderQua[1]);
				if(specialTypQua.indexOf(orderQuaInfo) < 0){
					typQua = false;
				}
				if(!typQua){
					break;
				}
			}
		}
		return typQua;
	}
	//填写倍数
	function userData(){
		var editRow = undefined;
		var rows = specialCntDatagrid.datagrid('getSelections');
		if(rows.length == 1){
			if (editRow != undefined) {
				specialCntDatagrid.datagrid('endEdit', editRow);
			}
			if (editRow == undefined) {
				editRow = specialCntDatagrid.datagrid("getRowIndex",rows[0]);
				specialCntDatagrid.datagrid('beginEdit', editRow);
			}
		}else{
			$.messager.alert('<s:text name="global.form.prompt" >提示</s:text>','<s:text name="orderConfirm.selectWriteDataInfo">请选择一条数据进行填写！</s:text>','info');
		}
	}

</script>
</head>
<body class="easyui-layout">
	<div region="north" border="false" class="zoc" collapsed="false"
		style="height: 100px; overflow: auto;" align="left">
		<form id="searchForm">
		    <input id="contractCode" name="contractCode"  type="hidden" value="${contractCode}" />
			<div class="navhead_zoc">
				<span><s:text name="orderConfirm.specialSelctText">标准箱方案查询</s:text></span>
			</div>
			<div class="part_zoc">
				<div class="partnavi_zoc">
					<span><s:text name="global.info.queriesAndoperations">查询与操作</s:text>：</span>
				</div>
				<div class="oneline">
					<div class="item33">
						<div class="itemleft100"><s:text name="global.order.specialCode">标准箱方案号</s:text>：</div>
						<div class="righttext">
							<input id="specialCntNum" name="specialCntNum"  type="text"  class="short80" />
						</div>
					</div>
					<div class="item33">
				        <div class="itemleft100"></div>
				        <div class="oprationbutt">
				             <input type="button" value="<s:text name="global.form.search">查  询</s:text>" onclick="_search();"/>
				             <input type="button" value="<s:text name="global.reset">重  置</s:text>"  onclick="cleanSearch();"/>
				        </div>
				    </div>
				</div>
			</div>
		</form>
	</div>

	<div region="center" border="false" >
		<table id="specialCntDatagrid"></table>
	</div>
	<div region="south" border="false"  style="height: 230px; overflow: auto">
	    <div  style="float: left;width: 550px;height:225px; overflow: auto;">
			<table id="specialCntProd"></table>
		</div>
 		<div style="float: left;margin-top:70px; width: 90px;">
 		    <div class="item33">
			    <input type="button" value="<s:text name="global.use">使  用</s:text>" onclick="userSubmit()"/>
			</div>
			&nbsp;<br />&nbsp;<br />&nbsp;<br /> 	
		    <div class="item33">
			    <input type="button" value="<s:text name="global.submit">确  认</s:text>" onclick="checkSubmit()"/>
			</div>
		</div> 
		<div style="float: left;   width: 620px;height:225px; overflow: auto; ">
			<table id="specialCntItem"></table>
		</div>
	</div>

</body>
</html>