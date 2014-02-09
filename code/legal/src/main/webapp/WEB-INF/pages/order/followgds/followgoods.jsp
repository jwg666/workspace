<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var datagrid_prepare;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/prepare/prepareOrderAction!selPrepareGrid.do',
			title : '小备单生成表列表',
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
			idField : 'actPrepareCode',
			
			singleSelect:true,
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.actPrepareCode;
						}
					},
			    {field:'actPrepareCode',title:'备单编号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.actPrepareCode;
					}
				},			
			   {field:'orderNum',title:'订单号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderNum;
					}
				},	
				
			   {field:'factoryProduceCode',title:'生产工厂编号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.factoryProduceCode;
					}
				},				
			   {field:'factorySettlementCode',title:'结算工厂',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.factorySettlementCode;
					}
				},				
			   {field:'salesOrgCode',title:'销售组织编号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.salesOrgCode;
					}
				},				
			   {field:'deptCode',title:'经营[主]体编号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.deptCode;
					}
				},				
			   {field:'firstSampleDate',title:'首样结束时间',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.firstSampleDate);
					}
				},				
			   {field:'manuStartDate',title:'生产计划开始时间',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.manuStartDate);
					}
				},				
			   {field:'manuEndDate',title:'生产计划结束时间',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.manuEndDate);
					}
				}			
			 ] ],
			
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},
			onClickRow:function(rowIndex, rowData){
				defineDatagrid(rowData.orderNum,rowData.actPrepareCode);
			}
		});
		
		$('#countryId').combobox({   
			url:'${dynamicURL}/basic/countryAction!combox.do',   
			valueField:'countryCode',   
			textField:'name'  
			}); 
		$('#factoryProduceId').combobox({   
			url:'${dynamicURL}/security/departmentAction!combox.do?deptType=0',   
			valueField:'deptCode',   
			textField:'deptNameCn'  
			}); 

	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function getOrder() {
		var rows = datagrid.datagrid('getChecked');
		if (rows.length == 1) {
			/* $.messager.progress({
				text : '数据加载中....',
				interval : 100
			}); */
			/* $.ajax({
				url : 'followgoodsAction!selOrder.do',
				data : {
					orderNum : rows[0].orderNum
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					//$.messager.progress('close');
					$.messager.show({
						title : '提示',
						msg : '获取完成！'
					});
					defineDatagrid();
				}
			}); */
			defineDatagrid(rows[0].orderNum,rows[0].actPrepareCode);
			$.messager.show({
				title : '提示',
				msg : '获取完成！'
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
		datagrid.datagrid('reload');
		//datagrid_prepare.datagrid('reload');
	}
	function defineDatagrid(orderNum,actPrepareCode){
		datagrid_prepare = $('#datagrid_prepare').datagrid({
			url : 'followgoodsAction!selOrder.do?orderNum='+orderNum+"&actPrepareOrderCode="+actPrepareCode,
			title : '明细',
			iconCls : 'icon-save',
			//pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			//height:300,
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			idField : 'rowId',
			
			columns : [ [ 
	           {field:'orderNum',title:'订单号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderNum;
					}
				},
			   {field:'actPrepareOrderCode',title:'备货单号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.actPrepareOrderCode;
					}
				},				
			   {field:'orderLinecode',title:'库存行',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderLinecode;
					}
				},				
			   {field:'materialCode',title:'物料号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.materialCode;
					}
				},				
			  
				{field:'quantity',title:'总备货数量',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.quantity;
					}
				},	
				
			   {field:'orderFinishedCount',title:'完工数量',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(null==row.orderFinishedCount){
							return '0';
						}
						return row.orderFinishedCount;
					}
				},
				{field:'flag',title:'是否完成跟踪备货',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if((row.orderFinishedCount!=0)&&(row.quantity<=row.orderFinishedCount)){
							return '是';
						}else{
							return '否';
						}
					   //return row.orderFinishedCount;
					}
				},	
			   {field:'orderHgvsCode',title:'HGVS销售订单号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.orderHgvsCode;
					}
				},
				  {field:'orderFinishDate',title:'生产结束日期',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.orderFinishDate);
					}
				}
			 ] ]
	    })
	}
</script>
</head>
<body >
	<div class="easyui-layout" style="height:550px;"  data-options="fit:true"> 
	 <div class="zoc" data-options="region:'north',split:false"  border="false" collapsed="false" 
		style="height: 110px; overflow: hidden;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc">
				<span>备货查询：</span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">订单号: </div>
					<div class="righttext">
						<input type="text" name="orderNum" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">开始时间: </div>
					<div class="righttext">
						<input type="text" name="manuStartDate" class="easyui-datebox"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">结束时间: </div>
					<div class="righttext">
						<input type="text" name="manuEndDate"  class="easyui-datebox"/>
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">国家: </div>
					<div class="righttext">
						<input type="text" id="countryId" name="countryCode" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">工厂: </div>
					<div class="righttext">
						<input type="text" id="factoryProduceId" style="width:180px" name="factoryProduceCode" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">是否完成备货：</div>
					<div class="righttext" >
						<select name="orderFlag" style="width:170px">
						 <option value="start">未完成</option>
						 <option value="end">已完成</option>
						</select>
					</div>
			</div>
			</div>
			<div class="item100 lastitem">
				<div class="oprationbutt">
					<input type="button" onclick="_search();" value="查  询" /> <input
						type="button" onclick="getOrder();" value="获取" />
				</div>
			</div>
		</form>
	</div>
	<!-- <div class="zoc" data-options="region:'north'"  style="height:150px;" collapsed="false"
		 overflow: auto;" align="left"></div>  -->
	<!-- <div  data-options="region:'center',split:true" style="height:400px;">
		<table id="datagrid"></table>
	</div>
	<div data-options="region:'south',split:true" style="height:300px;">
		<table id="datagrid_prepare"></table>
	</div> -->
	<!-- <div  data-options="region:'center',split:false" >
		<div  data-options="region:'center',split:false" style="height:400px;">
		   <table id="datagrid"></table>
	    </div>
	</div>
	<div data-options="region:'south',split:true" >
		<div data-options="region:'center',split:true" style="height:200px;">
		   <table id="datagrid_prepare"></table>
	    </div>
	 </div> -->
	
	 
	    <div  data-options="region:'center',split:false" style="height:500px;">
		   <table id="datagrid"></table>
	    </div>
	    <div data-options="region:'south',split:false" style="height:150px;">
	      <table id="datagrid_prepare"></table>
	    </div>  
	 </div>


</body>
</html>