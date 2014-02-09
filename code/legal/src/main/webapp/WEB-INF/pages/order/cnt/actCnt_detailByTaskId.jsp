<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
$(document).ready(function() {
	
})
</script>
<script type="text/javascript">
	var datagrid_contract_one;
	var datagrid_materialDetail;
	var datagrid_contract_two;
	var editIndex = undefined;
	var contractDetailForm;
	var searchMaterialDetailDialog;
	var taskId = '${taskId}';
	function rpInput_rowEdit_detail() {
	}
	$(function(){
		datagrid_contract_one = $('#datagrid_contract_one').datagrid({
			url : "${dynamicURL}/salesOrder/salesOrderAction!getActCntDetailParaByTaskId.do?taskId="+taskId,
			//pagination : true,
			//pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			height : 100,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'orderItemId',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.orderItemId;
				}
			}, {
				field : 'orderItemId',
				title : '序号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return ++index;
				}
			}, {
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderCode;
				}
			}, {
				field : 'orderItemLinecode',
				title : '订单行项目',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderItemLinecode;
				}
			}, {
				field : 'materialCode',
				title : '物料号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			}, {
				field : 'haierModel',
				title : '海尔型号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.haierModel;
				}
			}, {
				field : 'customerModel',
				title : '客户型号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.customerModel;
				}
			}, {
				field : 'affirmNum',
				title : '特技单号',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.affirmNum;
				}
			}, {
				field : 'container',
				title : '箱型箱量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.container;
				}
			},{
				field : 'orderQuatity',
				title : '订单数量',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderQuatity;
				}
			}, {
				field : 'orderNumber',
				title : '订单件数',
				align : 'center',
				sortable : true,
				formatter : function(value, row, index) {
					return row.orderNumber;
				}
			}, {
				field : 'budgetOrderNumber',
				title : '可预算件数',
				align : 'center',
				sortable : true,
				editor : {
					type : 'numberbox'
				},
				formatter : function(value, row, index) {
					return row.budgetOrderNumber;
				}
			} ] ],
			onDblClickRow : function(rowIndex, rowData) {
				materialDetail(rowData.contractLineCode, rowData.contractCode);
			}
		});

		//预算明细
		datagrid_contract_two = $('#datagrid_contract_two').datagrid({
			//url : "${dynamicURL}/contract/contractItemAction!datagrid.do",
			//pagination : true,
			//pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			//fit : true,
			height : 200,
			//fitColumns : true,
			checkOnSelect:false,
			selectOnCheck:false,
			singleSelect : true, 
			nowrap : true,
			border : false,
			idField : 'orderCode',
			
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				formatter : function(value, row, index) {
					return row.orderCode;
				}
			}, {
				field : 'orderItemId',
				title : '订单明细ID',
				align : 'center',
				sortable : true,
				hidden : true,
				width : 15,
				formatter : function(value, row, index) {
					return row.orderItemId;
				}
			},{
				field : 'actCntCode',
				title : '序号',
				align : 'center',
				sortable : true,
				width : 15,
				formatter : function(value, row, index) {
					return ++index;
				}
			}, {
				field : 'orderCode',
				title : '订单号',
				align : 'center',
				sortable : true,
				width : 40,
				formatter : function(value, row, index) {
					return row.orderCode;
				}
			}, {
				field : 'orderItemLinecode',
				title : '订单行项目',
				align : 'center',
				sortable : true,
				width : 40,
				formatter : function(value, row, index) {
					return row.orderItemLinecode;
				}
			}, {
				field : 'haierModel',
				title : '海尔型号',
				align : 'center',
				sortable : true,
				width : 40,
				formatter : function(value, row, index) {
					return row.haierModel;
				}
			}, {
				field : 'customerModel',
				title : '客户型号',
				align : 'center',
				sortable : true,
				width : 40,
				formatter : function(value, row, index) {
					return row.customerModel;
				}
			}, {
				field : 'affirmNum',
				title : '特技单号',
				align : 'center',
				sortable : true,
				width : 40,
				formatter : function(value, row, index) {
					return row.affirmNum;
				}
			}, {
				field : 'partMaterialCode',
				title : '分机物料号',
				align : 'center',
				sortable : true,
				width : 40,
				formatter : function(value, row, index) {
					if(row.splitFlag == 1){
						return row.partMaterialCode;
					}
					else{
						return row.materialCode;
					}
				}
			}, {
				field : 'budgetOrderQuatity',
				title : ' 剩余可预算数量',
				align : 'center',
				sortable : true,
				width : 50,
				formatter : function(value, row, index) {
					return row.budgetOrderQuatity;
				}
			}, {
				field : 'nowBudgetQuatity',
				title : '本次预算数量',
				align : 'center',
				sortable : true,
				width : 50,
				styler: function(value,row,index){
					return 'background-color:#ffee00;color:red;';
				},
				editor : {
					type : 'numberbox'
				},
				formatter : function(value, row, index) {
					return row.nowBudgetQuatity;
				}
			}, {
				field : 'nowBudgetNumber',
				title : '本次预算件数',
				align : 'center',
				sortable : true,
				width : 50,
				editor : {
					type : 'numberbox'
				},
				formatter : function(value, row, index) {
					return row.nowBudgetNumber;
				}
			}, {
				field : 'completeQuotiety',
				title : '成套系数',
				align : 'center',
				sortable : true,
				width : 40,
				formatter : function(value, row, index) {
					return row.completeQuotiety;
				}
			}, {
				field : 'materialCode',
				title : '套机物料号',
				align : 'center',
				sortable : true,
				width : 40,
				formatter : function(value, row, index) {
					return row.materialCode;
				}
			}, {
				field : 'grossWeight',
				title : '毛重',
				align : 'center',
				sortable : true,
				width : 20,
				formatter : function(value, row, index) {
					return row.grossWeight;
				}
			}, {
				field : 'outWidth',
				title : '外包装宽',
				align : 'center',
				sortable : true,
				width : 30,
				formatter : function(value, row, index) {
					return row.outWidth;
				}
			}, {
				field : 'outHeight',
				title : '外包装高',
				align : 'center',
				sortable : true,
				width : 30,
				formatter : function(value, row, index) {
					return row.outHeight;
				}
			}, {
				field : 'outLength',
				title : '外包装长',
				align : 'center',
				sortable : true,
				width : 30,
				formatter : function(value, row, index) {
					return row.outLength;
				}
			}, {
				field : 'botSide',
				title : '侧放规格',
				align : 'center',
				sortable : true,
				width : 30,
				formatter : function(value, row, index) {
					return row.botSide;
				}
			}, {
				field : 'layNum',
				title : '堆码层级',
				align : 'center',
				sortable : true,
				width : 30,
				formatter : function(value, row, index) {
					return row.layNum;
				}
			}, {
				field : 'botOrder',
				title : '底置优先级',
				align : 'center',
				sortable : true,
				width : 30,
				formatter : function(value, row, index) {
					return row.botOrder;
				}
			}
			] ],
			    onDblClickRow: function(index, rowData) {
				datagrid_contract_two.datagrid('endEdit', editIndex);
				datagrid_contract_two.datagrid('unselectAll');
			    },
			    onClickRow : function(index, rowData) {
			    	var rowss = datagrid_contract_two.datagrid('getRows');
			    	if(rowss.length > 1){
			    		 	//editIndex = undefined;
						if (editIndex != index) {
							if (endEditing()) {
								datagrid_contract_two.datagrid('selectRow', index).datagrid('beginEdit',index);
								editIndex = index;
							} else {
								datagrid_contract_two.datagrid('selectRow', editIndex);
							}
						}
						$("[field='nowBudgetQuatity']").find("input").keyup(function(){
							var quality = "";
							var nowBudgetQuatity = $(this).val();
							var row = datagrid_contract_two.datagrid('getSelected');
							var rows = datagrid_contract_one.datagrid('getRows');
							for(var k = 0; k < rows.length ; k++){
								var idx = datagrid_contract_one.datagrid('getRowIndex',rows[k]);
								if(rows[k].orderItemId == row.orderItemId){
									quality = rows[k].orderQuatity;
								}
							}
							if(parseInt(nowBudgetQuatity) < 0){
								$("[field='nowBudgetQuatity']").find("input").val('0');
							}else{
							if(parseInt(nowBudgetQuatity) > parseInt(row.budgetOrderQuatity)) {
 								$.messager.alert('提示', '所填写数量大于可预算数量！', 'error');
 								$("[field='nowBudgetQuatity']").find("input").val('0');
							}else{
	 							var ed = datagrid_contract_two.datagrid('getEditor',{index:index,field:'nowBudgetNumber'});
	 							//根据成套系数 得到件数
	 							if(row.completeQuotiety == 0 || row.completeQuotiety == null){
	 								row.completeQuotiety = 1;
	 							}
	 							$(ed.target).attr("readonly","true").val(nowBudgetQuatity*row.completeQuotiety);
	 							}
							    }
							  var editor_target = $('#datagrid_contract_two').datagrid('getEditor',{index: index,field:'nowBudgetNumber'}).target;
							  editor_target.attr("disabled",true)
							});
			    	}else{
			    		 editIndex = undefined;
						if (editIndex != index) {
							if (endEditing()) {
								datagrid_contract_two.datagrid('selectRow', index).datagrid('beginEdit',index);
								editIndex = index;
							} else {
								datagrid_contract_two.datagrid('selectRow', editIndex);
							}
						}
						$("[field='nowBudgetQuatity']").find("input").keyup(function(){
 							var quality = "";
							var nowBudgetQuatity = $(this).val();
							var row = datagrid_contract_two.datagrid('getSelected');
							var rows = datagrid_contract_one.datagrid('getRows');
							for(var k = 0; k < rows.length ; k++){
								var idx = datagrid_contract_one.datagrid('getRowIndex',rows[k]);
								if(rows[k].orderItemId == row.orderItemId){
									quality = rows[k].orderQuatity;
								}
							}
							if(parseInt(nowBudgetQuatity) < 0){
								$("[field='nowBudgetQuatity']").find("input").val('0');
							}else{
							if(parseInt(nowBudgetQuatity)>parseInt(row.budgetOrderQuatity)) {
 								$.messager.alert('提示', '所填写数量大于可预算数量！', 'error');
 								$("[field='nowBudgetQuatity']").find("input").val('0');
							}else{
	 							var ed = datagrid_contract_two.datagrid('getEditor',{index:index,field:'nowBudgetNumber'});
	 							//根据成套系数 得到件数
	 							if(row.completeQuotiety == 0 || row.completeQuotiety == null){
	 								row.completeQuotiety = 1;
	 							}
	 							$(ed.target).attr("readonly","true").val(nowBudgetQuatity*row.completeQuotiety);
	 							}
							}
				});
						var editor_target = $('#datagrid_contract_two').datagrid('getEditor',{index: index,field:'nowBudgetNumber'}).target;
						  editor_target.attr("disabled",true)
			}},
		});

		contractDetailForm = $('#contractDetailForm').form({
			url : 'contractAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					saveMaterial();
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});
	});

	//行编辑代码
	function endEditing() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#datagrid_contract_two').datagrid('validateRow', editIndex)) {
			$('#datagrid_contract_two').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}

	//text必须填写数字
	$(document).ready(function() {
		$(".validate-number").validatebox({
			required : true,
			validType : 'number'
		});

	});
	
	function byebye(){
		//代办刷新
		customWindow.reloaddata();
		//代办关闭
		parent.window.HROS.window.close(currentappid);
	}
	function changeFromOneToTwo(){
		//1秒不能连续点击按钮
		var link = document.getElementById("link");
	    link.disabled=true;
	    var str = 100;
	    setTimeout("doEnableLink();", 1000 * 1);
		
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		//删除以前数据重新加载
		var item = $('#datagrid_contract_two').datagrid('getRows');
		if (item) {
			for ( var i = item.length - 1; i >= 0; i--) {
				var index = $('#datagrid_contract_two').datagrid('getRowIndex', item[i]);
		$('#datagrid_contract_two').datagrid('deleteRow',index);}}
		//加载数据
		var rows = $('#datagrid_contract_one').datagrid('getChecked');
		if(rows.length == 0){
			$.messager.alert('提示', '请选择要操作的数据！', 'error');
			$.messager.progress('close');
		}
		for(var i = 0;i < rows.length;i++){
		$.ajax({
			url : "${dynamicURL}/salesOrder/salesOrderItemAction!datagridDetailFilterTwo.do",
			data : {
				orderCode : rows[i].orderCode,
				orderItemLinecode : rows[i].orderItemLinecode,
				materialCode : rows[i].materialCode
			},
			dataType : 'json',
			success : function(response) {
				if(response.length > 0){
				for(var j = 0;j < rows.length;j++){
					for(var k = 0;k < response.length;k++){
						if(response[k].orderCode == rows[j].orderCode && response[k].orderItemLinecode == rows[j].orderItemLinecode){
							response[k]['taskId'] = rows[j].taskId;
							$('#datagrid_contract_two').datagrid('appendRow',response[k]);
					}}
				}
				}else{
					$.messager.show({
						title : '提示',
						msg : '物料表中没有相关信息!'
					});
				}
			}
		});
		$.messager.progress('close');
		}
	}
	function saveLoadResult(){
			var f = "0";
			datagrid_contract_two.datagrid('endEdit', editIndex);
			datagrid_contract_two.datagrid('unselectAll');
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			var pa = "";
			var rows = datagrid_contract_two.datagrid('getRows');
			for(var m = 0;m < rows.length; m++){
				if(null == rows[m].nowBudgetNumber || rows[m].nowBudgetNumber == '0'){
					f = "1";
				}else{
					f = "0";
					break;
				}
			}
			if(f =="1"){
				$.messager.alert('提示', '请先填写装箱相应数量');
				$.messager.progress('close');
			}else{
			//ajax同步先生成预算批次号
			if(rows.length > 0){
				$.ajax({
					url : "${dynamicURL}/actCnt/loadInfoAction!returnBgCode.do",
					data : {
						orderNum : rows[0].orderCode, //订单号
						oemType : rows[0].customerModel,//客户型号
						affirmNum : rows[0].affirmNum,//特技单编号
						haierCode : rows[0].haierModel,//海尔型号
						prodQuantity : rows[0].nowBudgetQuatity,//产品数量
						quantity : rows[0].nowBudgetNumber,//产品件数
						jtCode : rows[0].partMaterialCode,//集团编码(分机级别)
						grossWeight : rows[0].grossWeight,//单件毛重
						width : rows[0].outWidth,//包装宽度(mm)
						length : rows[0].outLength,//包装深度(mm)
						height : rows[0].outHeight,//包装高度(mm)
						botSide : rows[0].botSide,//侧放规格
						layNum : rows[0].layNum,//堆码层数
						botOrder : rows[0].botOrder,//底置优先级
						splitQuantity : rows[0].splitFlag,//套台关系
						splitFlag : rows[0].splitFlag,//套机标志
						jtTaoCode : rows[0].materialCode,//套机集团编码
						salesOrderId : rows[0].orderCode,//订单主表ID
						salesOrderItemId : rows[0].orderItemId//订单明细ID
					},
					dataType : 'json',
					async : false,
					success : function(response) {
						pa = response.obj;
					}
				});
			}
			//保存2个单子装一个箱
	 		for(var i = 0;i < rows.length; i++){
			$.ajax({
				url : "${dynamicURL}/actCnt/loadInfoAction!addPload.do",
				data : {
					orderNum : rows[i].orderCode, //订单号
					oemType : rows[i].customerModel,//客户型号
					affirmNum : rows[i].affirmNum,//特技单编号
					haierCode : rows[i].haierModel,//海尔型号
					prodQuantity : rows[i].nowBudgetQuatity,//产品数量
					quantity : rows[i].nowBudgetNumber,//产品件数
					jtCode : rows[i].partMaterialCode,//集团编码(分机级别)
					grossWeight : rows[i].grossWeight,//单件毛重
					width : rows[i].outWidth,//包装宽度(mm)
					length : rows[i].outLength,//包装深度(mm)
					height : rows[i].outHeight,//包装高度(mm)
					botSide : rows[i].botSide,//侧放规格
					layNum : rows[i].layNum,//堆码层数
					botOrder : rows[i].botOrder,//底置优先级
					splitQuantity : rows[i].splitFlag,//套台关系
					splitFlag : rows[i].splitFlag,//套机标志
					jtTaoCode : rows[i].materialCode,//套机集团编码
					salesOrderId : rows[i].orderCode,//订单主表ID
					salesOrderItemId : rows[i].orderItemId,//订单明细ID
					cntNum : pa//预算批次号
				},
				dataType : 'json',
				async : false,
				success : function(response) {
//					pa = response.obj;
				}
			});
		  }
		$('#bgCode').val(pa);
			//调用装箱软件
			startPload(pa);
			$.messager.progress('close');
			}
	}
	
	//以下装箱软件 调用 -----
 function registPloadEvent(obj, name, func)
    {
        //alert("注册事件");
    	if (obj.attachEvent) {
            obj.attachEvent("on"+name, func);
        } else {
            obj.addEventListener(name, func, false); 
        }
    }        

	function startPload(val){		
		//alert("准备调用装箱，参数:"+val);
		var valEnvType = '${envType}';
		var plugin = document.getElementById('plugin0');
		registPloadEvent(plugin, 'pstart', function(){});
		if(valEnvType == "TEST"){
			valEnvType = "0";
		}else{
			valEnvType = "1";
		}
		try{
 			plugin.pstart(val,valEnvType);
//			plugin.pstart(val);
		}catch(error){
			$.messager.alert('提示', '请您去HROIS登录页面下载新版本的网页版本装箱软件!');
		}
	}
	//以上装箱软件 调用 -----
	
	//根据cntNum
	function saveActCnt(){
		var rowsBum = datagrid_contract_two.datagrid('getRows');
		var numT = 0;
		if(rowsBum.length > 0){
			for(var i = 0; i < rowsBum.length; i++){
				numT = parseInt(rowsBum[i].nowBudgetNumber) + parseInt(numT);
			}
		}
		var nNum = 0;
		var needNum = $('#bgCode').val();
		$.ajax({
			url : "${dynamicURL}/actCnt/loadResultAction!getTotalNums.do",
			data : {
				cntNum : needNum, //根据预算批次号 进行查询保存
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				nNum = JSON.stringify(data);
			}
		});
		//判断本次分配数量numT 是否等于     装箱P_LOAD_RESULT装箱的数量
		if(numT == nNum){
	 		$.messager.progress({
	 			text : '数据加载中....',
	 			interval : 100
	 		});
	 		var cc = $('#bgCode').val();
	 		if(cc == ""){
	 			$.messager.progress('close');
	 			$.messager.alert('提示', '先调用装箱软件生成预算批次号！', 'error');
	 		}else{
			
	 		var cc = $('#bgCode').val();
	 		var para = "";
	 		var rows = datagrid_contract_two.datagrid('getRows');
	 		var indexx = "0";
	 		for(var i= 0;i < rows.length;i++){
	 			if(null != rows[i].nowBudgetNumber){
	 			para =  rows[i].orderCode + "," +rows[i].orderItemLinecode + "," + rows[i].orderItemId + "," + rows[i].taskId + "," + rows[i].partMaterialCode + "," + para;
	 			}
	 			if((null == rows[i].nowBudgetNumber || parseInt(rows[i].nowBudgetNumber) < parseInt(rows[i].budgetOrderQuatity)) && rows[i].budgetOrderQuatity != "0"){
	 				indexx = "1";
	 			}
	 		}
	 		$.ajax({
	 			url : "${dynamicURL}/actCnt/loadInfoAction!saveActCnt.do",
	 			data : {
	 				cntNum : cc, //根据预算批次号 进行查询保存
	 				para : para
	 			},
	 			dataType : 'json',
	 			async : false,
	 			success : function(response) {
	 				$.messager.progress('close');
	 				$.messager.alert('提示', '保存成功！');
	 				if(indexx == "1"){
	 					parent.window.HROS.window.close(currentappid);
	 				}else{
	 					//代办刷新
	 					customWindow.reloaddata();
	 					//代办关闭
	 					parent.window.HROS.window.close(currentappid);
	 				}
	 			}
	 		});
	 		}
		}else{
			$.messager.alert('提示', '装箱有异常,请重新确认！', 'error');
		}
	}
	function byebye(){
		//代办关闭
		parent.window.HROS.window.close(currentappid);
	}

	function doEnableLink(id){   
	    document.getElementById("link").disabled=false;
	 }

	
</script>
<body>
<div id="actCntAddDialog">
	<div class="part_zoc zoc">
		<div class="partnavi_zoc">
			<span>订单明细</span>
		</div>
		<div class="oneline">
			<div class="item100">
				<div>
					<input id = "link" type="button" value="选  择" onclick="changeFromOneToTwo()" /> <input
						type="button" value="退  回" onclick="byebye()" />
				</div>
			</div>
		</div>
		<div style = "height: 200px;">
			<table id="datagrid_contract_one"></table>
		</div>
	</div>
	<div class="part_zoc zoc">
		<div class="partnavi_zoc">
			<span>预算明细</span>
		</div>
		<div class="oneline"  style = "height: 200px;">
			<table id="datagrid_contract_two"></table>
		</div>
		<div class="oneline">
			<div class="item33">
				<div class="itemleft">预算批次号</div>
				<div class="righttext">
					<input id= "bgCode" name="bgCode" type="text"
						data-options="required:true" readonly="readonly"/>
				</div>
			</div>
			<div class="item100">
				<div>
					<input type="button" value="调用装箱图" onclick="saveLoadResult()" /> 
					<input type="button" value="保  存" onclick="saveActCnt()" /> 
					<input type="button" value="退  出" onclick="byebye()" />
				</div>
			</div>
		</div>
	</div>
</div>
<div>
<object id="plugin0" type="application/x-pload"  style="width:0;height:0" >
    <param name="onload" value="pluginLoaded" />
</object><br /></div>
</body>
