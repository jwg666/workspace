<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var iframeDialog;
	function _CCNMY(inputId, selectId) {
		var _CCNTEMP = $('#' + inputId).val()
		$('#' + selectId).combogrid({
			url : '../basic/customerAction!datagrid0.action?name=' + _CCNTEMP
		});
		$('#' + inputId).val(_CCNTEMP);
	}
	$(function() {
		$('#hiscustCodeId').combogrid({
			url : '../basic/customerAction!datagrid0.action',
			idField : 'customerId',
			textField : 'name',
			panelWidth : 500,
			panelHeight : 220,
			toolbar : '#_CNNQUERYHISTORY',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			nowrap : true,
			border : false,
			columns : [ [ {
				field : 'customerId',
				title : '客户编号',
				width : 10
			}, {
				field : 'name',
				title : '客户名称',
				width : 10
			} ] ]
		});
		
		//加载国家信息
		$('#countryIdtask').combogrid({
			url:'${dynamicURL}/basic/countryAction!datagrid.do',
			textField : 'name',
			idField : 'countryCode',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_COUNTRY',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'countryCode',
				title : '国家编码',
				width : 20
			},{
				field : 'name',
				title : '国家名称',
				width : 20
			}  ] ]
		});
		
		//加载经营体信息
		$('#deptIdTask').combogrid({
			url:'${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=1',
			idField:'deptCode',  
		    textField:'deptNameCn',
			panelWidth : 500,
			panelHeight : 220,
			pagination : true,
			pagePosition : 'bottom',
			toolbar : '#_DEPT',
			rownumbers : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			fit : true,
			fitColumns : true,
			columns : [ [ {
				field : 'deptCode',
				title : '经营体编号',
				width : 20
			},{
				field : 'deptNameCn',
				title : '经营体名称',
				width : 20
			}  ] ]
		});
		 
		
		//加载目的港信息
		$('#endPortIdtask').combogrid({
		    url:'${dynamicURL}/basic/portAction!datagrid.action',
			idField:'portCode',  
		    textField:'portName',
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
			columns : [ [ {
				field : 'portCode',
				title : '目的港编码',
				width : 20
			},{
				field : 'englishName',
				title : '目的港名称',
				width : 20
			}  ] ]
		});
		
		
	    //查询列表	
	    searchForm = $('#searchForm').form();
	    //searchForm.form('clear');
		datagrid = $('#datagrid').datagrid({
			url : 'auditMainAction!selectDataGrid.action',
			title : '订单评审主表列表',
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
			singleSelect : true,
			//idField : 'rowId',
			
			frozenColumns : [ [ 
			   {field:'ORDER_CODE',title:'订单号',align:'center',sortable:true,width:100,
					formatter:function(value,row,index){
						//return row.ORDER_CODE;
						return "<a href='javascript:void(0)' style='color:blue' onclick='showdetail(\""
						+ row.ORDER_CODE
						+ "\")'> "
						+ row.ORDER_CODE + "</a>";
					}
				},				
				{
					field : 'CONTRACT_CODE',
					title : '合同编号',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.CONTRACT_CODE;
					}
				}, {
					field : 'ORDER_SHIP_DATE',
					title : '出运期',
					align : 'center',

					width : 90,
					formatter : function(value, row, index) {
						return dateFormatYMD(row.ORDER_SHIP_DATE);
					}
				}, {
					field : 'ORDER_CUSTOM_DATE',
					title : '要求到货期',
					align : 'center',

					width : 90,
					formatter : function(value, row, index) {
						return dateFormatYMD(row.ORDER_CUSTOM_DATE);
					}
				}, {
					field : 'CURRENCY',
					title : '币种',
					align : 'center',

					width : 50,
					formatter : function(value, row, index) {
						return row.CURRENCY;
					}
				}, {
					field : 'PAYMENT_ITEMS',
					title : '付款条件',
					align : 'center',

					width : 200,
					formatter : function(value, row, index) {
						return row.PAYMENT_ITEMS;
					}
				}				
			 ] ],
			 columns : [ [ {
					field : 'SALE_ORG_NAME',
					title : '销售组织',
					align : 'center',

					width : 130,
					formatter : function(value, row, index) {
						return row.SALE_ORG_NAME;
					}
				}, {
					field : 'ORDER_PO_CODE',
					title : '客户订单号',
					align : 'center',

					width : 150,
					formatter : function(value, row, index) {
						return row.ORDER_PO_CODE;
					}
				}, {
					field : 'DEPT_NAME',
					title : '经营体',
					align : 'center',

					width : 120,
					formatter : function(value, row, index) {
						return row.DEPT_NAME;
					}
				}, {
					field : 'CUSTOMER_MANAGER',
					title : '经营体长',
					align : 'center',

					width : 120,
					formatter : function(value, row, index) {
						return row.CUSTOMER_MANAGER;
					}
				}, {
					field : 'START_PORT',
					title : '始发港',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.START_PORT;
					}
				}, {
					field : 'END_PORT',
					title : '目的港',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.END_PORT;
					}
				}, {
					field : 'saleArea',
					title : '市场区域',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return '待定';
					}
				}, {
					field : 'CUSTOMER_NAME',
					title : '客户名称',
					align : 'center',
					width : 150,
					formatter : function(value, row, index) {
						return row.CUSTOMER_NAME;
					}
				}, {
					field : 'COUNTRY_NAME',
					title : '出口国家',
					align : 'center',

					width : 120,
					formatter : function(value, row, index) {
						return row.COUNTRY_NAME;
					}
				}, {
					field : 'DETAIL_TYPE',
					title : '成交方式',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.DETAIL_TYPE;
					}
				}, {
					field : 'EXECMANAGER_NAME',
					title : '订单执行经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.EXECMANAGER_NAME;
					}
				}, {
					field : 'PROD_NAME',
					title : '产品经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.PROD_NAME;
					}
				}, {
					field : 'TRANS_MANAGER',
					title : '储运经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.TRANS_MANAGER;
					}
				}, {
					field : 'DOC_MANAGER',
					title : '单证经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.DOC_MANAGER;
					}
				}, {
					field : 'REC_MANAGER',
					title : '收汇经理',
					align : 'center',

					width : 100,
					formatter : function(value, row, index) {
						return row.REC_MANAGER;
					}
				} ] ],
			 onDblClickRow :function(rowIndex,rowData){
				var code=rowData.ORDER_CODE;
				showdetail(code);
			}
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
	function _clean() {
		searchForm.form('clear');
		datagrid.datagrid('load', sy.serializeObject(searchForm));
		
	}
	function showdetail(code){
		var url='auditMainAction!showResultOfReview.action?orderNum='+code;
		$('#iframe').attr('src',url);
		dialog=$('#iframeDialog').show().dialog({
			title : "订单综合评审详细信息",
			modal : true,
			closed : true,
			minimizable : true,
			maximizable : true
		});
		$("#iframeDialog").dialog("open");
	}
	//刷新详细页面
	function showdetail1(code){
		var url='auditMainAction!showResultOfReview.action?orderNum='+code;
		$('#iframe').attr('src',url);
		dialog=$('#iframeDialog').show().dialog({
			title : "订单综合评审详细信息",
			modal : true,
			closed : true,
			minimizable : true,
			maximizable : true
		});
	}
	//模糊查询国家下拉列表
	function _CCNMY(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/customerAction!datagrid0.action?name='+ _CCNTEMP+'&countryCode='+_CCNCODE 
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询国家信息输入框
	function _CCNMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/countryAction!datagrid.do'
				});
	}
	//模糊查询目的港下拉列表
	function _PORTMY(inputId,inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/basic/portAction!datagrid.do?englishName=' + _CCNTEMP+'&portCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询目的港信息输入框
	function _PORTMYCLEAN(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId)
		.combogrid(
				{
					url : '${dynamicURL}/basic/portAction!datagrid.do'
				});
	}
	//模糊查询经营体下拉列表
	function _getDeptMent(inputId, inputName, selectId) {
		var _CCNCODE = $('#' + inputId).val();
		var _CCNTEMP = $('#' + inputName).val();
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=1&deptNameCn=' + _CCNTEMP+'&deptCode='+_CCNCODE
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
	//重置查询经营体下拉列表
	function _cleanDeptMent(inputId, inputName, selectId) {
		$('#'+inputId).val("");
		$('#'+inputName).val("");
		$('#' + selectId).combogrid({
			url : '${dynamicURL}/security/departmentAction!datagirdSelect.action?deptType=1'
		});
		//$('#' + inputId).val(_CCNTEMP);
	}
</script>
</head>
<body class="easyui-layout zoc">
	<div data-options="region:'north'"  border="false" class="zoc" collapsed="false"  style="height: 100px;width : 100%;overflow: auto;" align="left">
		<form id="searchForm">
		<div class="navhead_zoc"><span>订单综合评审</span></div>
			<div class="part_zoc" region="north">
				<div class="oneline">
				 <div class="item25">
				    <div class="itemleft80">
					    订单号
					</div>
					<div class="righttext">
					<input name="salseOrderCode" class="short50" type="text"  />
					</div>
				 </div>
<%-- 				 <div class="item25">
				     <div class="itemleft80">
					    审核状态
					</div>
					<div class="righttext">
					<select id="salseOrderAuditFlag" class="easyui-combobox" name="salseOrderAuditFlag" >  
                    <option value="">订单补录状态</option>
                    <option value="0">订单保存完成</option>
                    <option value="1">商务中心审核完成</option>
                    <option value="3">订单修改锁定</option>
                    <option value="4">订单过付款锁定</option>
                    </select>
					</div>
				 </div> --%>
				 <div class="item25">
				     <div class="itemleft80">
					    评审状态
					</div>
					<div class="righttext">
					<%-- <select id="salseOrderAuditFlag"  class="easyui-combobox short50"    name="ifquanbu" >  
                    <option value="2" >只显示评审阶段</option>
                    <option value="1">全部</option>
                    </select> --%>
                    <s:textfield  cssClass="easyui-combobox short50" type="text" name="ifquanbu" data-options="
			               valueField: 'label',
			               textField: 'value',
			              data: [{
				           label: '2',
				           value: '待评审'
			               },{
				           label: '3',
				           value: '已评审'
			               },{
				           label: '1',
				           value: '全部订单'
			               }]">
                    </s:textfield> 
                    	</div>	
				 </div>
				 <div class="item25">
						<div class="itemleft80">出口国家:</div>
						<div class="righttext_easyui">
							<input name="outPutCountry" type="text" id="countryIdtask"
								class="short50"
								 />
						</div>
				  </div>
				 <div class="item25 lastitem">
								<div class="itemleft80">经营体:</div>
								<div class="righttext_easyui">
									<input name="deptCode" type="text" id="deptIdTask"
										class="short50"
										 />
								</div>
				 </div>
                </div>
                <div class="oneline">
                
							<div class="item25">
								<div class="itemleft80">客户:</div>
								<div class="righttext_easyui">
									<input name="custmorCode" type="text" id="hiscustCodeId"
										class=" short50" />
								</div>
							</div>
				            <div class="item25">
								<div class="itemleft80">始发港:</div>
								<div class="righttext_easyui">
									<input name="startPort" type="text"
										class="easyui-combobox short50"
										data-options="valueField:'itemCode',textField:'itemNameCn',url:'${dynamicURL}/basic/sysLovAction!combox.do?itemType=17'" />
								</div>
							</div>
							<div class="item25">
								<div class="itemleft80">目的港:</div>
								<div class="righttext_easyui">
									<input name="endPort" type="text" id="endPortIdtask"
										class="short50"
										 />
								</div>
							</div>
                 <div class="item25 lastitem">
				 <div class="oprationbutt">
					<input type="button" value="查询" onclick="_search();"/>
					<input type="button" value="清空" onclick="_clean();"/>
				</div>
				</div>
                </div>

			</div>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
		
	<div id="iframeDialog" style="display: none;overflow: auto;width: 1300px;height: 500px;">
	<iframe name="iframe" id="iframe" src="#"  scrolling="auto" frameborder="0" style="width:100%;height:99%;">
    </iframe>
</div>
<div id="_CNNQUERYHISTORY">
		<div class="oneline">
			<div class="item25">
				<div class="itemleft60">客户名：</div>
				<div class="righttext">
					<input class="short60" id="_CNNINPUTHISTORY" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="righttext">
					<input type="button" value="查询"
						onclick="_CCNMY('_CNNINPUTHISTORY','hiscustCodeId')" />
				</div>
			</div>
		</div>
	</div>
	
	<!-- 国家下拉选 -->
	<div id="_COUNTRY">
		<div class="oneline">
		    <div class="item25">
				<div class="itemleft60">国家编号：</div>
				<div class="righttext">
					<input class="short50" id="_COUNTRYCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">国家名：</div>
				<div class="righttext">
					<input class="short60" id="_COUNTRYINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_CCNMY('_COUNTRYCODE','_COUNTRYINPUT','countryIdtask')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_CCNMYCLEAN('_COUNTRYCODE','_COUNTRYINPUT','countryIdtask')" />
				</div>
			</div>
		</div>
	</div>
	
	<!-- 经营体下拉信息 -->
	<div id="_DEPT">
	    <div class="oneline">
		    <div class="item25">
				<div class="itemleft100">经营体编号：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTCODE" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft100">经营体名称：</div>
				<div class="righttext">
					<input class="short50" id="_DEPTMENTNAME" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_getDeptMent('_DEPTMENTCODE','_DEPTMENTNAME','deptIdTask')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_cleanDeptMent('_DEPTMENTCODE','_DEPTMENTNAME','deptIdTask')" />
				</div>
			</div>
		</div>
	</div>
	
	<!-- 目的港下拉选信息 -->
	<div id="_PORTEND">
		<div class="oneline">
		     <div class="item25">
				<div class="itemleft100">目的港编号：</div>
				<div class="righttext">
					<input class="short50" id="_PORTCODEINPUT" type="text" />
				</div>
			</div>
			<div class="item25">
				<div class="itemleft60">目的港：</div>
				<div class="righttext">
					<input class="short60" id="_PORTINPUT" type="text" />
				</div>
			</div>
		</div>
		<div class="oneline">
			<div class="item25">
				<div align="right">
					<input type="button" value="查询"
						onclick="_PORTMY('_PORTCODEINPUT','_PORTINPUT','endPortIdtask')" />
				</div>
			</div>
			<div class="item25">
				<div class="lefttext">
					<input type="button" value="重置"
						onclick="_PORTMYCLEAN('_PORTCODEINPUT','_PORTINPUT','portEndCode')" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>