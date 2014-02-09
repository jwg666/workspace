<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var materialAddDialog;
	var materialAddForm;
	var cdescAdd;
	var materialEditDialog;
	var materialEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	var win_mdmDataLoad;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'materialAction!datagrid0.do',
			title : '物料主数据列表',
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
			idField : 'rowId',
			
			columns : [ [ 
			{field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.rowId;
						}
					},
			  {field:'rowId',title:'唯一标识',align:'center',sortable:true,hidden:true,
					formatter:function(value,row,index){
						return row.rowId;
					}
				},
				{field:'prodTypeName',title:'产品大类',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.prodTypeName;
					}
				},
				{field:'haierProductCode',title:'海尔型号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.haierProductCode;
					}
				},
			   {field:'prodCode',title:'客户型号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.prodCode;
					}
				},				
			   {field:'affirmCode',title:'特技单号',align:'center',sortable:true,width:170,
					formatter:function(value,row,index){
						return row.affirmCode;
					}
				},				
			   {field:'materialCode',title:'物料号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.materialCode;
					}
				},				
			   {field:'factoryName',title:'生产工厂',align:'center',sortable:true,width:160,
					formatter:function(value,row,index){
						return row.factoryName;
					}
				},				
			   				
			   {field:'bomCreateFlag',title:'是否有BOM',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.bomCreateFlag==1){
							return "是";
						}else{
							return "否";
						}
					}
				},
				{field:'length',title:'外包装长(mm)',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.length;
					}
				},
			   {field:'width',title:'外包装宽(mm)',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.width;
					}
				},								
			   {field:'height',title:'外包装高(mm)',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.height;
					}
				},				
			   {field:'botSideName',title:'侧放规格             ',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.botSideName;
					}
				},				
			   {field:'layNum',title:'堆码层数             ',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.layNum;
					}
				},				
			   {field:'botOrderName',title:'底置优先级          ',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.botOrderName;
					}
				},				
			   {field:'grossWeight',title:'毛重                    ',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.grossWeight;
					}
				},				
			   {field:'splitFlag',title:'是否套机 ',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						if(row.splitFlag==1){
							return "是";
						}else{
							return "否";
						}
					}
				},				
			   {field:'netWeight',title:'净重                  ',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.netWeight;
					}
				},				
			   {field:'netSizeString',title:'净尺寸               ',align:'center',sortable:true,hidden:true,
					formatter:function(value,row,index){
						return row.netSizeString;
					}
				},				
			   {field:'grossSize',title:'包装尺寸           ',align:'center',sortable:true,hidden:true,
					formatter:function(value,row,index){
						return row.grossSize;
					}
				},				
			   {field:'grossValue',title:'包装体积           ',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.grossValue;
					}
				},				
			   {field:'hrCode',title:'HR编码',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.hrCode;
					}
				},				
			   {field:'hrLimited',title:'HR编码有效期',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.hrLimited);
					}
				},				
			   {field:'plcStatus',title:'产品生命周期状态',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						return row.plcStatus;
					}
				},	/*			
			   {field:'activeFlag',title:'有效标识   1=有效，0=无效',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.activeFlag;
					}
				},				
			   {field:'createdBy',title:'createdBy',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.createdBy;
					}
				},				
			   {field:'created',title:'created',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.created);
					}
				},				
			   {field:'lastUpd',title:'lastUpd',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastUpd);
					}
				},				
			   {field:'lastUpdBy',title:'lastUpdBy',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.lastUpdBy;
					}
				},				
			   {field:'modificationNum',title:'modificationNum',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.modificationNum;
					}
				},				
			   {field:'ifDamager',title:'ifDamager',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.ifDamager;
					}
				},*/				
			   				
			   {field:'hsCode',title:'海关商品编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.hsCode;
					}
				},				
			   {field:'hsName',title:'海关商品名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.hsName;
					}
				},				
			   {field:'bookingCode',title:'订舱简码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.bookingCode;
					}
				},				
			   {field:'codeDescEn',title:'简码英文描述',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.codeDescEn;
					}
				},				
			   {field:'codeDescCn',title:'简码中文描述',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.codeDescCn;
					}
				},				
			   {field:'dryValue',title:'干衣量',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.dryValue;
					}
				},				
			   {field:'dryType',title:'干衣类型',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.dryType;
					}
				},				
			   {field:'ifAuto',title:'是否全自动',align:'center',sortable:true,
					formatter:function(value,row,index){
						if(row.ifAuto==1){
							return "是";
						}else{
							return "否";
						}
					}
				},				
			   {field:'actTarget',title:'作用对象',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.actTarget;
					}
				},				
			   {field:'comments',title:'备注',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.comments;
					}
				}				
			 ] ],
			toolbar : [ 
			    {
			    	text : 'MDM取数',
			    	iconCls : 'icon-add',
			    	handler : openWinmdmDataLoad
				}, '-'/*, {
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					add();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					del();
				}
			}, '-',  *//* {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, *//*  '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			},  '-'*/
			],
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

		materialAddForm = $('#materialAddForm').form({
			url : 'materialAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					materialAddDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		materialAddDialog = $('#materialAddDialog').show().dialog({
			title : '添加物料主数据',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					materialAddForm.submit();
				}
			} ]
		});
		
		
		

		materialEditForm = $('#materialEditForm').form({
			url : 'materialAction!edit.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					datagrid.datagrid('reload');
					materialEditDialog.dialog('close');
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});

		materialEditDialog = $('#materialEditDialog').show().dialog({
			title : '编辑物料主数据',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '编辑',
				handler : function() {
					materialEditForm.submit();
				}
			} ]
		});


		showCdescDialog = $('#showCdescDialog').show().dialog({
			title : '物料主数据描述',
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
		
		win_mdmDataLoad = $("#WIN_MdmDataLoad").show().dialog({
			title : 'MDM数据抓取',
			modal : true,
			closed : true,
			width : 300,
			height : 180,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-save',
				handler : loadMdmData
			}]
		});
	});

	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
		/* var rows=datagrid.datagrid('getRows');
		for(i=0;i<rows.length;i++){
			if(rows[i].bomCreateFlag==1){
				//alert("是");
				rows[i].bomCreateFlag="是";
				//rows[i].bomCreateFlag='是'
			}else{
				//rows[i].bomCreateFlag='否'
			}
			//alert("ss");
		} */
	}
	function cleanSearch() {
		searchForm.form('clear');
		datagrid.datagrid('load', {});
		//searchForm.find('input').val('');
	}
	function add() {
		materialAddForm.find('input,textarea').val('');
		$('div.validatebox-tip').remove();
		materialAddDialog.dialog('open');
	}
	function del() {
		var rows = datagrid.datagrid('getSelections');
		var ids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							ids=ids+"ids="+rows[i].rowId+"&";
						else ids=ids+"ids="+rows[i].rowId;
					}
					$.ajax({
						url : 'materialAction!delete.do',
						data : ids,
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'error');
		}
	}
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$.messager.progress({
				text : '数据加载中....',
				interval : 100
			});
			$.ajax({
				url : 'materialAction!showDesc.do',
				data : {
					rowId : rows[0].rowId
				},
				dataType : 'json',
				cache : false,
				success : function(response) {
					materialEditForm.find('input,textarea').val('');
					materialEditForm.form('load', response);
					$('div.validatebox-tip').remove();
					materialEditDialog.dialog('open');
					$.messager.progress('close');
				}
			});
		} else {
			$.messager.alert('提示', '请选择一项要编辑的记录！', 'error');
		}
	}
	function showCdesc(index) {
		var rows = datagrid.datagrid('getRows');
		var row = rows[index];
		$.messager.progress({
			text : '数据加载中....',
			interval : 100
		});
		$.ajax({
			url : 'materialAction!showDesc.do',
			data : {
				rowId : row.rowId
			},
			dataType : 'json',
			cache : false,
			success : function(response) {
				if (response && response.cdesc) {
					showCdescDialog.find('div[name=cdesc]').html(response.cdesc);
					showCdescDialog.dialog('open');
				} else {
					$.messager.alert('提示', '没有物料主数据描述！', 'error');
				}
				$.messager.progress('close');
			}
		});
		datagrid.datagrid('unselectAll');
	}
	
	function openWinmdmDataLoad(){
		win_mdmDataLoad.panel("open");
	}
	
	function loadMdmData(){
		if($("#mdmDataLoadForm").form("validate")){
			$.messager.progress({text:"数据抓取中，请稍等..."});
			$("#mdmDataLoadForm").form("submit",{
				url : "materialAction!loadMdmData.do",
				success : function(data){
					$.messager.progress("close");
					$("#mdmDataLoadForm").form("clear");
					win_mdmDataLoad.panel("close");
					datagrid.datagrid("reload");
				}
			});
		}
	}
</script>
</head>
<body class="easyui-layout zoc">
<%-- 	<div region="north" border="false" title="过滤条件" collapsed="true"  style="height: 110px;overflow: hidden;" align="left">
		<form id="searchForm">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
					<tr>
						<th>产品大类</th>
						<td><input name="prodType" class="easyui-combobox" style="width: 150px; "
							data-options="valueField:'prodTypeCode',textField:'prodType',url:'${dynamicURL}/basic/prodTypeAction!combox.do'" /></td>
						<th>物料号</th>
						<td><input type="text" name="materialCode" /></td>
						<th>生产工厂</th>
						<td><input name="factoryCode" class="easyui-combobox" style="width: 150px; "
							data-options="valueField:'deptCode',textField:'deptNameCn',url:'${dynamicURL}/security/departmentAction!combox.do?deptType=0'" /></td>
					</tr>
					<tr>
						<th>海尔型号</th>
						<td><input type="text" name="haierProductCode"  /></td>
						<th>客户型号</th>
						<td><input type="text" name="prodCode" /></td>
						<th>特技单号</th>
						<td><input type="text" name="affirmCode" style="width:150px; " /></td>
					</tr>
				<tr>
				    <th colspan="5"></th>
					<td><a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">过滤</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">取消</a></td>
				</tr>
			</table>
		</form>
	</div> --%>
	<div class="zoc" region="north" border="false" collapsed="false"
		style="height: 110px; overflow: hidden;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc">
				<span>物料查询：</span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">产品大类: </div>
					<div class="righttext">
						<input type="text" name="prodType" class="easyui-combobox" style="width: 160px; "
						  data-options="valueField:'prodTypeCode',textField:'prodType',url:'${dynamicURL}/basic/prodTypeAction!combox.do'"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">物料号: </div>
					<div class="righttext">
						<input type="text" name="materialCode" />
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft">生产工厂: </div>
					<div class="righttext">
						<input type="text" name="factoryCode" class="easyui-combobox" style="width: 190px; "
							data-options="valueField:'deptCode',textField:'deptNameCn',url:'${dynamicURL}/security/departmentAction!combox.do?deptType=0'" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">海尔型号: </div>
					<div class="righttext">
						<input type="text" name="haierProductCode"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">客户型号: </div>
					<div class="righttext">
						<input type="text" name="prodCode" />
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft">特技单号: </div>
					<div class="righttext">
						<input  type="text" name="affirmCode" style="width:180px; " />
					</div>
				</div>
			</div>
			<div class="oneline">
			<div class="item100 lastitem">
				<div class="oprationbutt">
					<input type="button" onclick="_search();" value="查  询" /> <input
						type="button" onclick="cleanSearch();" value="取消" />
				</div>
			</div>
			</div>
		</form>
	</div>
	
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="add();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>

	<div id="materialAddDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="materialAddForm" method="post">
			<table class="tableForm">
						<tr>
							<th>唯一标识</th>
							<td>
							<input name="rowId" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写唯一标识"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>客户型号</th>
							<td>
							<input name="prodCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写客户型号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>特技单号</th>
							<td>
							<input name="affirmCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写特技单号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>物料号</th>
							<td>
							<input name="materialCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写物料号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>生产工厂</th>
							<td>
							<input name="factoryCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写生产工厂"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>海尔型号</th>
							<td>
							<input name="haierProductCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写海尔型号"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>是否有BOM  1有，0无</th>
							<td>
							<input name="bomCreateFlag" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写是否有BOM  1有，0无"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>外包装宽度</th>
							<td>
							<input name="width" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写外包装宽度"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>外包装深度    </th>
							<td>
							<input name="length" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写外包装深度    "  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>外包装高度     </th>
							<td>
							<input name="height" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写外包装高度     "  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>侧放规格             </th>
							<td>
							<input name="botSide" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写侧放规格             "  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>堆码层数             </th>
							<td>
							<input name="layNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写堆码层数             "  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>底置优先级          </th>
							<td>
							<input name="botOrder" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写底置优先级          "  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>毛重                    </th>
							<td>
							<input name="grossWeight" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写毛重                    "  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>是否套机   1是，0不是</th>
							<td>
							<input name="splitFlag" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写是否套机   1是，0不是"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>净重                  </th>
							<td>
							<input name="netWeight" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写净重                  "  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>净尺寸               </th>
							<td>
							<input name="netSize" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写净尺寸               "  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>包装尺寸           </th>
							<td>
							<input name="grossSize" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写包装尺寸           "  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>包装体积           </th>
							<td>
							<input name="grossValue" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写包装体积           "  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>HR编码</th>
							<td>
							<input name="hrCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写HR编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>HR编码有效期</th>
							<td>
							<input name="hrLimited" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写HR编码有效期"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>产品生命周期状态</th>
							<td>
							<input name="plcStatus" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写产品生命周期状态"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>有效标识   1=有效，0=无效</th>
							<td>
							<input name="activeFlag" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写有效标识   1=有效，0=无效"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>createdBy</th>
							<td>
							<input name="createdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写createdBy"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>created</th>
							<td>
							<input name="created" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写created"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>lastUpd</th>
							<td>
							<input name="lastUpd" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写lastUpd"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>lastUpdBy</th>
							<td>
							<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写lastUpdBy"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>modificationNum</th>
							<td>
							<input name="modificationNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写modificationNum"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>ifDamager</th>
							<td>
							<input name="ifDamager" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写ifDamager"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>产品大类</th>
							<td>
							<input name="prodType" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写产品大类"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>海关商品编码</th>
							<td>
							<input name="hsCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写海关商品编码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>海关商品名称</th>
							<td>
							<input name="hsName" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写海关商品名称"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>订舱简码</th>
							<td>
							<input name="bookingCode" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写订舱简码"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>简码英文描述</th>
							<td>
							<input name="codeDescEn" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写简码英文描述"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>简码中文描述</th>
							<td>
							<input name="codeDescCn" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写简码中文描述"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>干衣量</th>
							<td>
							<input name="dryValue" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写干衣量"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>干衣类型</th>
							<td>
							<input name="dryType" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写干衣类型"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>是否全自动,0=否，1=是</th>
							<td>
							<input name="ifAuto" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写是否全自动,0=否，1=是"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>作用对象</th>
							<td>
							<input name="actTarget" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写作用对象"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
							<th>备注</th>
							<td>
							<input name="comments" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写备注"  style="width: 155px;"/>
							</td>
						</tr>
					
					
					
			</table>
		</form>
	</div>

	<div id="materialEditDialog" style="display: none;width: 500px;height: 300px;" align="center">
		<form id="materialEditForm" method="post">
			<table class="tableForm">
						<tr>
						<th>唯一标识</th>
							<td>
							<input name="rowId" type="text" readonly="readonly" style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>客户型号</th>
							<td>
<input name="prodCode" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>特技单号</th>
							<td>
<input name="affirmCode" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>物料号</th>
							<td>
<input name="materialCode" type="text"readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>生产工厂</th>
							<td>
<input name="factoryCode" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>海尔型号</th>
							<td>
<input name="haierProductCode" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>是否有BOM  1有，0无</th>
							<td>
<input name="bomCreateFlag" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>外包装宽度</th>
							<td>
<input name="width" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>外包装深度    </th>
							<td>
<input name="length" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>外包装高度     </th>
							<td>
<input name="height" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>侧放规格             </th>
							<td>
<input name="botSide" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>堆码层数             </th>
							<td>
<input name="layNum" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>底置优先级          </th>
							<td>
<input name="botOrder" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>毛重                    </th>
							<td>
<input name="grossWeight" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>是否套机   1是，0不是</th>
							<td>
<input name="splitFlag" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>净重                  </th>
							<td>
<input name="netWeight" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>净尺寸               </th>
							<td>
<input name="netSize" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>包装尺寸           </th>
							<td>
<input name="grossSize" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>包装体积           </th>
							<td>
<input name="grossValue" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HR编码</th>
							<td>
<input name="hrCode" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>HR编码有效期</th>
							<td>
<input name="hrLimited" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>产品生命周期状态</th>
							<td>
<input name="plcStatus" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>有效标识   1=有效，0=无效</th>
							<td>
<input name="activeFlag" type="text" readonly="readonly"   style="width: 155px;"/>
							</td>
						</tr>
<!-- 						<tr>
						<th>createdBy</th>
							<td>
<input name="createdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写createdBy"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>created</th>
							<td>
<input name="created" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写created"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>lastUpd</th>
							<td>
<input name="lastUpd" type="text" class="easyui-datebox" data-options="required:true" missingMessage="请填写lastUpd"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>lastUpdBy</th>
							<td>
<input name="lastUpdBy" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写lastUpdBy"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>modificationNum</th>
							<td>
<input name="modificationNum" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写modificationNum"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>ifDamager</th>
							<td>
<input name="ifDamager" type="text" class="easyui-validatebox" data-options="required:true" missingMessage="请填写ifDamager"  style="width: 155px;"/>
							</td>
						</tr> -->
						<tr>
						<th>产品大类</th>
							<td>
<input name="prodType"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>海关商品编码</th>
							<td>
<input name="hsCode" type="text"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>海关商品名称</th>
							<td>
<input name="hsName" type="text"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>订舱简码</th>
							<td>
<input name="bookingCode" type="text"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>简码英文描述</th>
							<td>
<input name="codeDescEn" type="text"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>简码中文描述</th>
							<td>
<input name="codeDescCn" type="text"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>干衣量</th>
							<td>
<input name="dryValue" type="text"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>干衣类型</th>
							<td>
<input name="dryType" type="text"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>是否全自动,0=否，1=是</th>
							<td>
<input name="ifAuto" type="text"  style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>作用对象</th>
							<td>
<input name="actTarget" type="text"   style="width: 155px;"/>
							</td>
						</tr>
						<tr>
						<th>备注</th>
							<td>
<input name="comments" type="text"   style="width: 155px;"/>
							</td>
						</tr>
			</table>
		</form>
	</div>

	<div id="showCdescDialog" style="display: none;overflow: auto;width: 500px;height: 400px;">
		<div name="cdesc"></div>
	</div>
	
	<div id="iframeDialog" style="display: none;overflow: auto;width: 600px;height: 400px;">
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:100%;">
    </iframe>
    
    <div id="WIN_MdmDataLoad" style="display: none;">
        <form id="mdmDataLoadForm" method="post">
            <div style="height: 32px; margin-top:20px;">
                <span style="padding:10px;">物料编号:</span><input name="materialCode" type="text" style="width:149px;" class="easyui-validatebox" data-options="required:true"/>
			</div>
<!--             <div style="height: 32px;"> -->
<!--                 <span style="padding:10px;">开始时间:</span><input name="lastUpd" class="easyui-datebox" editable="false"/> -->
<!-- 			</div> -->
        </form>
    </div>
</div>
</body>
</html>