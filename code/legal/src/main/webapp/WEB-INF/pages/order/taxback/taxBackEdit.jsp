<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : 'taxBackInfoAction!datagrid.do',
			title : '预申报列表',
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
			onClickRow:onClickRow,
			columns : [ [ 
			/* {field:'ck',checkbox:true,
						formatter:function(value,row,index){
							return row.rowId;
						}
					},
			   {field:'rowId',title:'rowId',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.rowId;
					}
				},				
			   {field:'applyCode',title:'正式申报编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.applyCode;
					}
				},				
			   {field:'applyDate',title:'正式申报日期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.applyDate);
					}
				},	 */
				{field:'mergeFalg',title:'是否合票',align:'center',sortable:true,
					editor : {
						type : 'checkbox',
						options: {
					        on: 1,
					        off: 0
					    }
					},
					formatter:function(value,row,index){
						//var editor_mergeFalg = $('#datagrid').datagrid('getEditor',{index:index,field:'mergeFalg'}).target;
						if(row.mergeFalg==1){
							//editor_mergeFalg.combobox('setValue', 'checked');
							//editCheck(index);
							return "是";
						}else{
							return "否";
						}
					}
				},				
			   {field:'mergeValue',title:'  合票值   ',align:'center',sortable:true,
					editor : {
						type : 'numberbox',
						options : {
							max:99,
							min:0,
							precision:0
						}
				       },
					formatter:function(value,row,index){
						return row.mergeValue;
					}
				},
			   {field:'createDate',title:'所属月份',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.createDate);
					}
				},				
			   {field:'orderCode',title:'订单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.orderCode;
					}
				},				
			   {field:'compreeCode',title:'综合通知单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.compreeCode;
					}
				},				
			   {field:'invoiceCompany',title:'结算公司',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.invoiceCompany;
					}
				},				
			   {field:'productCode',title:'产品大类',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.productCode;
					}
				},				
			   {field:'haierModel',title:'海尔型号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.haierModel;
					}
				},				
			   {field:'unit',title:'计量单位',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.unit;
					}
				},				
			   {field:'amount',title:'数量',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.amount;
					}
				},				
			   {field:'moneyType',title:'原币币种',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.moneyType;
					}
				},				
			   {field:'price',title:'原币单价',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.price;
					}
				},				
			   {field:'exportAmount',title:'出口总额',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.exportAmount;
					}
				},				
			   {field:'shipFee',title:'运费保费',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.shipFee;
					}
				},				
			   {field:'fobAmount',title:'FOB出口总额',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.fobAmount;
					}
				},				
			   {field:'usdExchangeRate',title:'美元兑人民币汇率',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.usdExchangeRate;
					}
				},				
			   {field:'applyAmount',title:'应退税申报额',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.applyAmount;
					}
				},				
			   {field:'prepareFactory',title:'备货厂家',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.prepareFactory;
					}
				},				
			   {field:'customDate',title:'报关日期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.customDate);
					}
				},				
			   {field:'agencyBillCode',title:'代理清单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.agencyBillCode;
					}
				},				
			   {field:'customCode',title:'报关单号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.customCode;
					}
				},				
			   {field:'exportInvoiceCode',title:'出口发票号',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.exportInvoiceCode;
					}
				},				
			   {field:'originalUsdRate',title:'原币兑美元汇率',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.originalUsdRate;
					}
				},				
			   {field:'productFactory',title:'工厂编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.productFactory;
					}
				},				
			   {field:'customGoodsName',title:'海关商品名称',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.customGoodsName;
					}
				},				
			   {field:'customGoodsCode',title:'海关商品编码',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.customGoodsCode;
					}
				}/* ,				
			   		
			   {field:'taxBackFalg',title:'退税活动完成标志',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.taxBackFalg;
					}
				},				
			   {field:'taxBackDate',title:'退税活动结束日期',align:'center',sortable:true,
					formatter:function(value,row,index){
						return dateFormatYMD(row.taxBackDate);
					}
				},				
			   {field:'activeFlag',title:'有效标识',align:'center',sortable:true,
					formatter:function(value,row,index){
						return row.activeFlag;
					}
				}				 */
			 ] ],
			toolbar : [  {
				text : '导出预申报材料',
				iconCls : 'icon-edit',
				handler : function() {
					exceloutput();
				}
			}, '-', {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					saveEdit();
				}
			}, '-'/*, {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' */ ],
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
		$('#productFactoryId').combobox({   
			url:'${dynamicURL}/security/departmentAction!combox.do?deptType=0',   
			valueField:'deptCode',   
			textField:'deptNameCn'  
			}); 
		$('#productCodeId').combobox({   
			url:'${dynamicURL}/basic/prodTypeAction!combox.do',   
			valueField:'prodTypeCode',   
			textField:'prodType'  
			});
	});

	function saveEdit(index){
		endEditing();
		var updateRows = datagrid.datagrid('getChanges');//获取被改变的记录
		if(updateRows.length>0){
			var jsonArray = new Array();
			for(var i = 0,l=updateRows.length;i<l;i++){
				var json= {};
				json.rowId=updateRows[i].rowId;
				json.mergeFalg= updateRows[i].mergeFalg;
				json.mergeValue= updateRows[i].mergeValue;
				jsonArray.push(json);
			}
			var jsonStr = JSON.stringify(jsonArray);//将被改变的记录 转化成json形式   
			//var jsonStr = JSON.stringify(updateRows);//将被改变的记录 转化成json形式
			$.ajax({
				url:"taxBackInfoAction!saveUpdate.do",
				type:"post",
				data :{
					taxBackList:jsonStr
			     }, 
				success:function(response) {
					datagrid.datagrid('load');
					datagrid.datagrid('unselectAll');
					$.messager.show({
						title : '提示',
						msg : '保存成功！'
					});
				}
		  });
		}
	}
	
	function _search() {
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		searchForm.find('input').val('');
	}
	function exceloutput(){
		endEditing();
		var updateRows = datagrid.datagrid('getChanges');//获取被改变的记录
		if(updateRows.length>0){//如果有改变的记录未保存 提示用户保存数据
			alert("更改记录未保存,请先保存再导出");
		    return false;
		}
		$("#searchForm").attr("action", "taxBackInfoAction!execelOutputFormal.action");
		$("#searchForm").submit();
	}
	var editIndex = undefined;  
	function endEditing(){  
	    if (editIndex == undefined){return true}  
	    if ($('#datagrid').datagrid('validateRow', editIndex)){  
	        $('#datagrid').datagrid('endEdit', editIndex);  
	        editIndex = undefined;  
	        return true;  
	    } else {  
	        return false;  
	    }  
	}  
	function onClickRow(index){  
	    if (editIndex != index){  
	        if (endEditing()){  
	            $('#datagrid').datagrid('selectRow', index)  
	                    .datagrid('beginEdit', index);  
	            editIndex = index;  
	            $('#datagrid').datagrid('unselectAll');
	        } else {  
	            $('#datagrid').datagrid('selectRow', editIndex);        
	        }  
	    }  
	}
</script>
</head>
<body class="easyui-layout">
	<div class="zoc"  data-options="region:'north'" border="false"  collapsed="true"  style="height: 110px;overflow: hidden;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc">
				<span>备货查询：</span>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">工厂: </div>
					<div class="righttext">
						<input type="text" id="productFactoryId" name="productFactory" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">产品组: </div>
					<div class="righttext">
						<input type="text" id="productCodeId" name="productCode" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">合同号: </div>
					<div class="righttext">
						<input type="text"  name="contractCode"/>
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">订单号: </div>
					<div class="righttext">
						<input type="text"  name="orderCode" />
					</div>
				</div>
			   <div class="item33">
					<div class="itemleft">打印时间-开始: </div>
					<div class="righttext">
						<input type="text" name="printDateStart" class="easyui-datebox"/>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">打印时间-结束: </div>
					<div class="righttext">
						<input type="text" name="printDateEnd"  class="easyui-datebox"/>
					</div>
				</div>
			</div>
			<div class="item100 lastitem">
				<div class="oprationbutt">
					<input type="button" onclick="_search();" value="查  询" /> 
				</div>
			</div>
		</form>
	</div>
	<div border="false" data-options="region:'center'">
		<table id="datagrid"></table>
	</div>
</body>
</html>