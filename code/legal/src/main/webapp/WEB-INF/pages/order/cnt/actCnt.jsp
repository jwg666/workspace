<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var actCntAddDialog;
	var actCntAddForm;
	var cdescAdd;
	var actCntEditDialog;
	var actCntEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	var actCntAppid = null;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : "${dynamicURL}/salesOrder/salesOrderAction!datagridFilter.do",
			title : '装箱活动表列表',
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
							return row.actCntCode;
						}
					},
			   {field:'actCntCode',title:'序号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return ++index;
					}
				},				
			   {field:'orderCode',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},
				{field:'portNameBegin',title:'始发港',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.portNameBegin;
					}
				},				
			   {field:'portNameEnd',title:'目的港',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.portNameEnd;
					}
				},
				{field:'cusName',title:'客户',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.cusName;
					}
				},
			   {field:'orderTypeName',title:'订单类型',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderTypeName;
					}
				},				
			   {field:'contractcode',title:'合同编号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.contractcode;
					}
				},				
			   {field:'orderShipDate',title:'出运期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.orderShipDate);
					}
				},				
			   {field:'orderCustomDate',title:'要求到货期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.orderCustomDate);
					}
				},				
			   {field:'orderDealTypeName',title:'成交方式',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderDealTypeName;
					}
				},				
			   {field:'currencyName',title:'币种',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.currencyName;
					}
				},				
			   {field:'orderpaymentsterms',title:'付款条件',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderpaymentsterms;
					}
				},				
			   {field:'salesOrgCodeName',title:'销售组织',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.salesOrgCodeName;
					}
				},				
			   {field:'counName',title:'国家',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.counName;
					}
				},				
			   {field:'orderPoCode',title:'客户订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderPoCode;
					}
				},				
			   {field:'deptNameCn',title:'经营体',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.deptNameCn;
					}
				},				
			   {field:'vendorNameCn',title:'船公司',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.vendorNameCn;
					}
				},{
					field : 'dueDate',
					title : '计划完成时间',
					align : 'center',
					sortable : true,
					formatter : function(value, row, index) {
						return row.dueDate;
									}
								}				
			 ] ],			
			toolbar : [ {
				iconCls : 'icon-edit',
				text : '预算',
				handler : function() {
					addNewBudget();
				}
			}, '-'],
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

		actCntAddForm = $('#actCntAddForm').form({
			url : 'actCntAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					actCntAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		actCntAddDialog = $('#actCntAddDialog').show().dialog({
			title : '装箱预算办理',
			modal : true,
			closed : true,
			maximizable : true,
			maximized : true,
			collapsible : true
		});
		
		actCntEditForm = $('#actCntEditForm').form({
			url : 'actCntAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					actCntEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		actCntEditDialog = $('#actCntEditDialog').show().dialog({
			title : '编辑装箱活动表',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					actCntEditForm.submit();
				}
			} ]
		});

		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '装箱活动表描述',
			modal : true,
			closed : true,
			maximizable : true
		});

		iframeDialog = $('#iframeDialog').show().dialog({
			title : 'POP弹出页面',
			modal : true,
			closed : true,
			maximizable : true
		});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}
	function add() {
		actCntAddForm.form("clear");
		$('div.validatebox-tip').remove();
		actCntAddDialog.dialog('open');
	}

	function showCdesc(index) {
		var rows = datagrid.datagrid('getRows');
		var row = rows[index];
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中</s:text>',
			interval : 100
		});
		$.ajax({
			url : 'actCntAction!showDesc.do',
			data : {
				actCntCode : row.actCntCode
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.actcnt.description">没有装箱活动表描述！</s:text>', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	
	function goBudget() {
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中</s:text>',
			interval : 100
		});
		var rows = datagrid.datagrid('getChecked');
		if(rows.length == 0 ){
			$.messager.progress('close');
		}
		var f ="0";
		if(rows.length ==1 ){
			f = "1";
		}
		//判断订单号是否能装箱  出运期，目的港，始发港，客户 相同	
		if(rows.length > 1){
		for(var n = 0;n < rows.length -1;n++){
			for(var m = n+1 ;m < rows.length ;m++){
				if(rows[n].portNameBegin == rows[m].portNameBegin && rows[n].portNameEnd == rows[m].portNameEnd && rows[n].cusName == rows[m].cusName){
				f = "1";
				}else{
				f = "0";
				}
			}
		}}
		if(f == "1"){
		var codes = "";
		for(var i = 0;i < rows.length;i++){
			codes = rows[i].orderCode + ","+ codes;
		}
		$.ajax({
			url : "${dynamicURL}/salesOrder/salesOrderAction!datagridDetailFilter.do",
			data : {
				codes : codes
			},
			dataType : 'json',
			success : function(response) {
				for(var j = 0;j < rows.length;j++){
					for(var k = 0;k < response.length;k++){
						if(response[k].orderCode == rows[j].orderCode){
							response[k]['taskId'] = rows[j].taskId;
					}
					}
				}
				$('#datagrid_contract_one').datagrid('loadData',response);
				//清除 datagrid_contract_two 中的数据
				var item = $('#datagrid_contract_two').datagrid('getRows');
				if (item) {
					for ( var i = item.length - 1; i >= 0; i--) {
						var index = $('#datagrid_contract_two').datagrid('getRowIndex', item[i]);
				$('#datagrid_contract_two').datagrid('deleteRow',index);}}
			}
		});
		rpInput_rowEdit_detail();
		actCntAddForm.form("clear");
		$('div.validatebox-tip').remove();
		actCntAddDialog.dialog('open');
		$.messager.progress('close');
		}else{
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="global.actcnt.date">选择装箱数据,确认所选内容是否符合装箱规则!</s:text>', 'error');
			$.messager.progress('close');
		}
	}
	
	function addNewBudget() {
		$.messager.progress({
			text : '<s:text name="the.data.load">数据加载中</s:text>',
			interval : 100
		});
		var rows = datagrid.datagrid('getChecked');
		if(rows.length == 0 ){
			$.messager.progress('close');
		}
		var f ="0";
		if(rows.length ==1 ){
			f = "1";
		}
		//判断订单号是否能装箱  出运期，目的港，始发港，客户 相同	
		if(rows.length > 1){
		for(var n = 0;n < rows.length -1;n++){
			for(var m = n+1 ;m < rows.length ;m++){
				if(rows[n].portNameBegin == rows[m].portNameBegin && rows[n].portNameEnd == rows[m].portNameEnd && rows[n].cusName == rows[m].cusName){
				f = "1";
				}else{
				f = "0";
				}
			}
		}}
		if(f == "1"){	
			var para = "";
			for(var i = 0;i < rows.length ; i++){
				para = para + rows[i].orderCode + "," +rows[i].taskId + ",";
			}
			actCntAppid = parent.window.HROS.window.createTemp({
			appid:actCntAppid,
			title:"装箱预算",
			url:"${dynamicURL}/salesOrder/salesOrderAction!getActCntDetail.do?para="+para,
			width:800,height:400,isresize:true,isopenmax:true,isflash:false,customWindow : window
			});
			$.messager.progress('close');
		}else{
			$.messager.alert('<s:text name="global.form.prompt">提示</s:text>', '<s:text name="actcnt.same.contract">拼箱时 必须符合 同客户,同始发港,同目的港！</s:text>', 'error');
			$.messager.progress('close');
		}
		}
	
	//刷新代办和已完成代办
	function reloaddata() {
		datagrid.datagrid('unselectAll');
		datagrid.datagrid('reload');
		top.window.showTaskCount();
	}
</script>
</head>
<body class="easyui-layout">
<jsp:include page="actCnt_detail.jsp" />
<div region="north" border="false" collapsible="true" collapsed="true" class="zoc" title="查询条件"
		style="height: 150px; overflow: auto;">
	<form id="searchForm">
	<div class="navhead_zoc"><span>装箱预算</span>
	</div>
	<div class="part_zoc">
		<div class="partnavi_zoc"><span>查询与操作：</span></div>
	<div class="oneline">	
		<div class="item25">
			<div class="itemleft80">订单号 ：</div>
			<div class="righttext">
			    <input type="text" class="short50" name="orderCode" id = "orderCode"/>
			</div>
		</div>
		<div class="item25">
			<div class="itemleft80">始发港 ：</div>
			<div class="righttext">
				<input type="text" class="short50" name="portNameBegin" id="portNameBegin"/>
			</div>
		</div>
		<div class="item25">
			<div class="itemleft80">目的港 ：</div>
			<div class="righttext">
			    <input type="text" class="short50" name="portNameEnd" id = "portNameEnd"/>
			</div>
		</div>
	</div>
	<div class="oneline">

		<div class="item25">
			<div class="itemleft80">客户 ：</div>
			<div class="righttext">
			<input type="text" class="short50" name="cusName" id="cusName"/>
			</div>
		</div>
				<div class="item25">
			<div class="oprationbutt">
				<input type="button" onclick="_search();" value="查  询" />
				<input type="button" onclick="cleanSearch();" value="重置" />
			</div>
		</div>
	</div>
	</div>
</form>
</div>
	<div region="center" border="false"   class="zoc">
		<table id="datagrid"></table>
	</div>	
</body>
</html>