<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var hideFields = ['createDate','createBy','lastUpBy','lastUpDate'];
	var showFields = ['parentTypeCode'];
	var activeFlagMap = {'1':'有效','0':'无效'};
	var skipTaskMap = {'':'默认','1':'跳过节点一'};
	var typeTypeMap = {'edit':'修改','redo':'重做','complate':'结束','adjust':"调整T",'cancel':'取消'};
	var activeFlagData = [];
	var typeTypeData = [];
	var skipTaskData = [];
	var hasNodesLoad = false;
	for(var i in activeFlagMap ){
		var d = {label:activeFlagMap[i],value:i}
		activeFlagData.push(d);
	}
	for(var i in typeTypeMap ){
		var d = {label:typeTypeMap[i],value:i}
		typeTypeData.push(d);
	}
	for(var i in skipTaskMap ){
		var d = {label:skipTaskMap[i],value:i}
		skipTaskData.push(d);
	}
	
    var treegrid;
	var typeConfAddDialog;
	var typeConfAddForm;
    $(function() {
        //查询列表
        searchForm = $('#searchForm').form();
        treegrid = $('#datagrid').treegrid({
        	url : '${dynamicURL}/orderedit/typeConfAction!treegrid.do',
            title : '',
            iconCls : 'icon-save',
            rownumbers : true,
            fit : true,
            fitColumns : true,
            nowrap : true,
            border : false,
            idField : 'id',
            treeField:'typeName',
            singleSelect:true,
            columns : [ [ 
  			   {field:'typeName',title:'类别名称',align:'left',width:150,editor:'text',
  					formatter:function(value,row,index){
  						return row.typeName;
  					}
  				},				
  			   {field:'parentTypeCode',title:'上级类别',align:'center',hidden:true,width:120,editor:{
  				    type:'combobox',
  				 	options:{
	                    url:'${dynamicURL}/orderedit/typeConfAction!comboxWithHeader.do?firstLeve=true',
	                    editable:false,
						multiple:false,  
	                    valueField:'id',
	                    textField:'typeName',
	                    panelHeight:'auto'
  				 		}
  			   		},formatter:function(value,row,index){
  						return row.parentTypeName;
  					}
  				},				
  			   {field:'id',title:'类别编码',align:'center',width:120,
  					formatter:function(value,row,index){
  						return row.id;
  					}
  				},	
  			 /*  {field:'tmodel',title:'修改前T模式',align:'center',width:120,editor:{type:'combobox',options:{
  				   url:'${dynamicURL}/tmod/tmodConfigAction!combox.do?activeFlag=1',
  				   required:true,
  	               editable:false,
  				   multiple:false,  
  	               valueField:'configId',
  	               textField:'tmodName',
  	               panelHeight:'auto',
  	               onLoadSuccess:function(){
  	            	   var value = $(this).combobox("getValue");
  	            	   if(value!=null){
  	            		   //reloadNode(value);    		   
  	            	   }
  	               },
  	               onSelect:function(record){
  	            	   if(record.configId != null){
  	            		   reloadNode(record.configId);
  	            	   }
  	               }
  				   }},
  					formatter:function(value,row,index){
  						return row.tmodelName;
  					}
  				}, */
  				{field:'transactionMethod',title:'成交方式',align:'center',width:120,editor:{type:'combobox',options:{
  					   url:'${dynamicURL}/basic/sysLovAction!selectAllDealTypeInfo.do',
    	               editable:false,
    				   multiple:false,  
    	               valueField:'itemNameCn',
    	               textField:'itemNameCn',
    	               loadFilter:dealTypeFilter
  					}},
  				},
  				{field:'nodes',title:'需要重做的节点',align:'center',width:200,editor:{type:'multiplecombobox',options:{
  					   url:'${dynamicURL}/tmod/actSetAction!listAllAct.do',
	 	               editable:false,
	 				   multiple:true,  
	 	               valueField:'actId',
	 	               textField:'actName'
	 		  		 }},
	 				formatter:function(value,row,index){
	 					return row.nodeNames;
	 				}
 				},	
	  			{field:'typeType',title:'修改方式',align:'center',width:60,editor:{
	  				   		type:'combobox',
	  				 		options:{
								required:true,  
								multiple:false,
								editable:false,
								valueField: 'value',
								textField: 'label',
								data: typeTypeData,
								panelHeight:'auto'
	  						}
	  			   		},formatter:function(value,row,index){
	  						return typeTypeMap[row.typeType];
	  					}
	  			},
	  			/* {field:'busRoleItems',title:'业务评审人员',align:'center',width:200,editor:{type:'multiplecombobox',options:{
					   url:'${dynamicURL}/security/searchGroupAction/listAllGroup.do',	  				
	 	               editable:false,
	 				   multiple:true,  
	 	               valueField:'code',
	 	               textField:'name',
	 	               panelHeight:'auto'
	 		  		 }},
	 				formatter:function(value,row,index){
	 					return row.busRoleItemNames;
	 				}
				},	 */
	  			{field:'manager',title:'评审人员',align:'center',width:200,editor:{type:'combobox',options:{
					   url:'${dynamicURL}/security/searchGroupAction/listAllGroup.do',	  				
	 	               editable:false,
	 				   multiple:false,  
	 	               valueField:'code',
	 	               textField:'name'
	 		  		 }},
	 				formatter:function(value,row,index){
	 					return row.managerName;
	 				}
				},	
	  			{field:'switchRoleItems',title:'闸口评审人员',align:'center',width:200,editor:{type:'multiplecombobox',options:{
					   url:'${dynamicURL}/security/searchGroupAction/listAllGroup.do',	  				
	 	               editable:false,
	 				   multiple:true,  
	 	               valueField:'code',
	 	               textField:'name'
	 		  		 }},
	 				formatter:function(value,row,index){
	 					return row.switchRoleItemNames;
	 				}
				},	
				{
						field : 'activeFlag',
						title : '是否有效',
						align : 'center',
						width : 80,
						editor : {
							type : 'combobox',
							options : {
								required : true,
								multiple : false,
								editable : false,
								valueField : 'value',
								textField : 'label',
								data : activeFlagData,
								panelHeight : 'auto'
							}
						},
						formatter : function(value, row, index) {
							return activeFlagMap[row.activeFlag];
						}
				},
				{
						field : 'skipTask',
						title : '节点配置',
						align : 'center',
						width : 80,
						editor : {
							type : 'combobox',
							options : {
								required : true,
								multiple : false,
								editable : false,
								valueField : 'value',
								textField : 'label',
								data : skipTaskData,
								panelHeight : 'auto'
							}
						},
						formatter : function(value, row, index) {
							return skipTaskMap[row.skipTask==null?"":row.skipTask];
						}
				},
				{
					field : 'remark',
					title : '备注',
					align : 'center',
					width : 120,
					editor : 'textarea',
					formatter : function(value, row, index) {
						return row.remark;
					}
				},
				{
					field : 'createDate',
					title : '创建时间',
					align : 'center',
					width : 80,
					formatter : function(value, row, index) {
						return dateFormatYMD(row.createDate);
					}
				},
				{
					field : 'createBy',
					title : '创建人',
					align : 'center',
					width : 80,
					formatter : function(value, row, index) {
						return row.createBy;
					}
				},
				{
					field : 'lastUpBy',
					title : '修改人',
					align : 'center',
					width : 80,
					formatter : function(value, row, index) {
						return row.lastUpBy;
					}
				},
				{
					field : 'lastUpDate',
					title : '修改时间',
					align : 'center',
					width : 80,
					formatter : function(value, row, index) {
						return dateFormatYMD(row.lastUpDate);
					}
				} ] ],
			toolbar : [ {
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					treegrid.treegrid('unselectAll');
					add();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					del();
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, '-', {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					save();
				}
			}, '-', {
				text : '取消编辑',
				iconCls : 'icon-undo',
				handler : function() {
					cancel();
				}
			}, '-' ],
			onContextMenu : function(e, rowData) {
				e.preventDefault();
				$(this).treegrid('unselectAll');
				$(this).treegrid('select', rowData.id);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});

		typeConfAddForm = $('#typeConfAddForm').form({
			url : 'typeConfAction!add.do',
			onSubmit:function(){
				var isValid = $(this).form('validate');
				if (isValid){
					$.messager.progress({
						text : '数据提交中....',
						interval : 100
					});
				}
				return isValid;	
			},
			success : function(data) {
				$.messager.progress('close');
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					treegrid.treegrid('reload');
					typeConfAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		typeConfAddDialog = $('#typeConfAddDialog').show().dialog({
			title : '添加订单修改类别',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					typeConfAddForm.submit();
				}
			} ],
			onClose:function(){
				$('div.tooltip').hide();
			}
		});
	});
	function add() {
		var row = treegrid.treegrid('getSelected');
		var parentId = null;
		//var tmodel = null;
		if (row != null) {
			if (row.id == row.parentTypeCode) {
				parentId = row.id;
				tmodel = row.tmodel;
			} else {
				var parent = treegrid.treegrid('getParent', row.id);
				parentId = parent.id;
				//tmodel = parent.tmodel;
			}
		}
		typeConfAddForm.form("clear")
		$('div.tooltip').hide();
		typeConfAddDialog.dialog('open');
		if (parentId != null) {
			$("#parentTypeCodeId").combobox("setValue", parentId);
			//$("#tmodelId").combobox("setValue", tmodel);
		}
	}
	function copy() {
		var row = treegrid.treegrid('getSelected');
		var data={};
		var parentId = null;
		//var tmodel = null;
		if (row != null) {
			if (row.id == row.parentTypeCode) {
				parentId = row.id;
				//tmodel = row.tmodel;
			} else {
				var parent = treegrid.treegrid('getParent', row.id);
				parentId = parent.id;
				//tmodel = parent.tmodel;
			}
			data.typeType = row.typeType;
			data.transactionMethod = row.transactionMethod;
			data.nodes = row.nodes==null?[]:row.nodes.split(",");
			data.switchRoleItems = row.switchRoleItems==null?[]:row.switchRoleItems.split(",");;
			data.activeFlag = row.activeFlag;
			data.remark = row.remark;
			data.typeName = row.typeName+"-copy";
			data.parentTypeCode = parentId;
		}
		typeConfAddForm.form("clear")
		$('div.tooltip').hide();
		typeConfAddForm.form('load', data);
		typeConfAddDialog.dialog('open');
	}
	function del() {
		var rows = treegrid.treegrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if (i != rows.length - 1)
							ids = ids + "ids=" + rows[i].id + "&";
						else
							ids = ids + "ids=" + rows[i].id;
					}
					$.ajax({
						url : 'typeConfAction!delete.do',
						data : ids,
						dataType : 'json',
						success : function(json) {
							if(json.success){
								treegrid.treegrid('reload');
								treegrid.treegrid('unselectAll');
								$.messager.show({
									title : '提示',
									msg : '删除成功！'
								});
							}else{
								$.messager.show({
									title : '提示',
									msg : json.msg
								});
							}
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'error');
		}
	}

	var editingId;
	function edit() {
		if (editingId != undefined) {
			treegrid.treegrid('select', editingId);
			return;
		}
		var row = treegrid.treegrid('getSelected');
		if (row) {
			editingId = row.id;
			hasNodesLoad = false;
			treegrid.treegrid('beginEdit', editingId);
			onStartEdit();
		}
	}
	
	function save() {
		if (editingId != undefined) {
			treegrid.treegrid('endEdit', editingId);
			var row = treegrid.treegrid('find', editingId);
			var level = treegrid.treegrid("getLevel",row.id)
			if(level == 1){row.nodes = '';}
			$.messager.progress({
				text : '数据提交中....',
				interval : 100
			});
			$.ajax({
				url : '${dynamicURL}/orderedit/typeConfAction!edit.do',
				data : row,
				dataType : 'json',
				type : 'post',
				success : function(json) {
					$.messager.progress('close');
					onEndEdit();
					if (json.success) {
						editingId = undefined;
						treegrid.treegrid('reload');
						treegrid.treegrid('unselectAll');
						$.messager.show({
							title : '提示',
							msg : json.msg
						});
					} else {
						treegrid.treegrid('beginEdit', editingId);
						$.messager.show({
							title : '提示',
							msg : '保存失败！'
						});
					}
				}
			});
		}
	}
	function cancel() {
		if (editingId != undefined) {
			treegrid.treegrid('cancelEdit', editingId);
			editingId = undefined;
			onEndEdit();
		}
	}
	/* function reloadNode(configId){
		var eds = treegrid.treegrid('getEditors', editingId);
		for(var i = 0, l =eds.length;i<l;i++){
			var ed = eds[i];
			if(ed.field == 'nodes'){
				$(ed.target).combobox("reload","${dynamicURL}/tmod/tmodConfigAction!listNodes.do?configId="+configId);
				$(ed.target).combobox('setValues', []);
				break;
			}
		}
	} */
	
	function onStartEdit(){
		for(var i=0,l=showFields.length;i<l;i++){
			treegrid.treegrid('showColumn', showFields[i]);
		}
		for(var i=0,l=hideFields.length;i<l;i++){
			treegrid.treegrid('hideColumn', hideFields[i]);
		}
	}
	function onEndEdit(){
		for(var i=0,l=showFields.length;i<l;i++){
			treegrid.treegrid('hideColumn', showFields[i]);
		}
		for(var i=0,l=hideFields.length;i<l;i++){
			treegrid.treegrid('showColumn', hideFields[i]);
		}
	}
	function isArray(source) {
	    return '[object Array]' == Object.prototype.toString.call(source);
	}
	function dealTypeFilter(data){
		
	    if(isArray(data)){
	      /*  for(var i=0,l=data.length;i<l;i++){
	    	   data[i].itemNameCnVal=data[i].itemNameCn;
	       } */
 		   var o = {itemNameCn:"default",itemNameCn:"default"};
 		   data.unshift(o);
 	    }
		return data;
	}
</script>
</head>
<body class="easyui-layout zoc">
  <div class="zoc" region="north" border="false" collapsed="false"  style="height: 35px;overflow: auto;" align="left" >
        <form id="searchForm">
            <div class="navhead_zoc" style="min-width:0px"><span>订单修改类别配置</span></div>
        </form>
    </div> 
    <div region="center" border="false">
        <table id="datagrid"></table>
    </div>
    
	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
		<div onclick="copy();" iconCls="icon-add">复制</div>
	</div>
    
    <div id="typeConfAddDialog" style="display: none;width: 400px;height: 350px;" align="center" class="zoc">
		<form id="typeConfAddForm" method="post">
			<div class="oneline">
				<div class="item33 lastitem">
					<div class="itemleft80">类别名称</div>
					<div class="righttext">
						<input name="typeName" type="text" class="easyui-validatebox"
							data-options="required:true"  style="width: 155px;" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item50 lastitem">
					<div class="itemleft80">上级类别</div>
					<div class="righttext">
						<input class="easyui-combobox" name="parentTypeCode" id="parentTypeCodeId"
							data-options="
			                    url:'${dynamicURL}/orderedit/typeConfAction!comboxWithHeader.do?firstLeve=true',
  								multiple:false, 
  								editable:false, 
			                    valueField:'id',
			                    textField:'typeName',
			                    panelHeight:'auto'">
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item50 lastitem">
					<div class="itemleft80">成交方式</div>
					<div class="righttext">
						<input class="easyui-combobox" name="transactionMethod"
							data-options="
			                    url:'${dynamicURL}/basic/sysLovAction!selectAllDealTypeInfo.do',
  								multiple:false, 
  								editable:false,
  								required:true, 
			                    valueField:'itemNameCn',
  	               				textField:'itemNameCn',
  	               				loadFilter:dealTypeFilter">
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33 lastitem">
					<div class="itemleft80">修改方式</div>
					<div class="righttext">
						<input class="easyui-combobox" name="typeType"
									data-options="required:true,  
												multiple:false,
												editable:false,  
												valueField: 'value',
												textField: 'label',
												data: [{
													label: '修改',
													value: 'edit'
												},{
													label: '重做',
													value: 'redo'
												},{
													label: '结束',
													value: 'complate'
												}
												,{
													value: 'adjust',
													label: '调整T模式'
												},{
													value: 'cancel',
													label: '取消订单'
												}
												]" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item50 lastitem">
					<div class="itemleft80">需要重做的节点</div>
					<div class="righttext">
						<input class="easyui-combobox" name="nodes"
							data-options="
			                    url:'${dynamicURL}/tmod/actSetAction!listAllAct.do',
  								multiple:true, 
  								editable:false, 
			                    valueField:'actId',
  	               				textField:'actName'">
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item50 lastitem">
					<div class="itemleft80">闸口评审人员</div>
					<div class="righttext">
						<input class="easyui-combobox" name="switchRoleItems"
							data-options="
			                    url:'${dynamicURL}/security/searchGroupAction/listAllGroup.do',
  								editable:false,
			 				    multiple:true,  
			 	                valueField:'code',
			 	                textField:'name'">
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item50 lastitem">
					<div class="itemleft80">闸口评审人员</div>
					<div class="righttext">
						<input class="easyui-combobox" name="manager"
							data-options="
			                    url:'${dynamicURL}/security/searchGroupAction/listAllGroup.do',
  								editable:false,
			 				    multiple:false,  
			 	                valueField:'code',
			 	                textField:'name'">
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33 lastitem">
					<div class="itemleft80">有效标识</div>
					<div class="righttext">
						<input  name="activeFlag"  class="easyui-combobox" 
								data-options="required:true,  
											multiple:false,
											editable:false,  
											valueField: 'value',
											textField: 'label',
											data: [{
												label: '有效',
												value: '1'
											},{
												label: '无效',
												value: '0'
											}]" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33 lastitem">
					<div class="itemleft80">节点配置</div>
					<div class="righttext">
						<input  name="skipTask"  class="easyui-combobox" 
								data-options="required:true,  
											multiple:false,
											editable:false,  
											valueField: 'value',
											textField: 'label',
											data: [{
												label: '默认',
												value: ''
											},{
												label: '跳过节点一',
												value: '1'
											}]" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33 lastitem" style="height: 80px">
					<div class="itemleft80">备注</div>
					<div class="righttext"  style="height: 80px">
						<textarea name="remark"  style="height: 70px"></textarea>
					</div>
				</div>
			</div>
		</form>
	</div>
    
</body>
</html>