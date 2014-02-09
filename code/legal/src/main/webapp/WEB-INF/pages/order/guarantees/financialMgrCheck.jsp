<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//单证经理审核保函的页面
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var searchForm;
	var datagrid;
	var guaranteesAddDialog;
	var guaranteesAddForm;
	var cdescAdd;
	var guaranteesEditDialog;
	var guaranteesEditForm;
	var cdescEdit;
	var showCdescDialog;
	var iframeDialog;
	$(function() {
		guaranteesEditForm = $('#guaranteesEditForm').form({
			url : '${dynamicURL}/guarantees/guaranteesAction!showDescFinMgr.action?guarantees=${guarantees}',
			onLoadSuccess : function(data) {
				$("#finAuditOpenion").val('');
				if(data.payType=='1'){
					$("#payType").html('保函');
				}else{
					$("#payType").html('备用信用证');
				}
				if(data.cycleFlag=='1'){
					$("#cycleFlag").html('是');
				}else{
					$("#cycleFlag").html('否');
				}
			}
		});
		guaranteesEditForm.form('load', '${dynamicURL}/guarantees/guaranteesAction!showDescFinMgr.action?guarantees=${guarantees}');

	});
	function checkAgree() {
		if (!guaranteesEditForm.form('validate')) {
			return;
		}
		//审核通过
		$.ajax({
			url : '${dynamicURL}/guarantees/guaranteesAction!financialMgrCheckResult.action?checkResult=true',
			data : guaranteesEditForm.serialize(),
			dataType : 'json',
			type : 'post',
			success : function(response) {
				if (response && response.success) {
					$.messager.alert('提示', response.msg, 'info', function() {
						//关闭当前页面，刷新数据列表
						customWindow.refreshDatagrid();
						parent.window.HROS.window.close(currentappid);
					});
				} else {
					$.messager.alert('提示', '数据保存失败', 'error', function() {
						//关闭当前页面，刷新数据列表
						customWindow.refreshDatagrid();
						parent.window.HROS.window.close(currentappid);
					});

				}
			}
		});
	}
	function checkDisagree() {
		//审核不通过
		if (!guaranteesEditForm.form('validate')) {
			return;
		}
		//审核通过
		$.ajax({
			url : '${dynamicURL}/guarantees/guaranteesAction!financialMgrCheckResult.action?checkResult=false',
			data : guaranteesEditForm.serialize(),
			dataType : 'json',
			type : 'post',
			success : function(response) {
				if (response && response.success) {
					$.messager.alert('提示', response.msg, 'info', function() {
						//关闭当前页面，刷新数据列表
						customWindow.refreshDatagrid();
						parent.window.HROS.window.close(currentappid);
					});
				} else {
					$.messager.alert('提示', '数据保存失败', 'error', function() {
						//关闭当前页面，刷新数据列表
						customWindow.refreshDatagrid();
						parent.window.HROS.window.close(currentappid);
					});

				}
			}
		});
	}
</script>
</head>
<body>
	<form id="guaranteesEditForm" method="post">
		<s:hidden name="taskId"></s:hidden>
		<div class="part_zoc">
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">保函号：</div>
					<div class="righttext">
						<s:textfield name="guarantees" id="guarantees0" readonly="true"
							style="width: 155px;"></s:textfield>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">受益人</div>
					<div class="righttext">
						<s:textfield name="guaranteesQuery.beneficiaries"
							style="width: 155px;" readonly="true"></s:textfield>
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft">客户：</div>
					<div class="righttext">
						<s:textfield name="guaranteesQuery.customerName"
							style="width: 155px;" readonly="true" id="customerCode0"></s:textfield>
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">开证行</div>
					<div class="righttext">
						<s:textfield name="guaranteesQuery.bankName" style="width: 155px;"
							readonly="true"></s:textfield>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">改证次数</div>
					<div class="righttext">
						<s:textfield name="guaranteesQuery.modifyNum"
							style="width: 155px;" readonly="true"></s:textfield>
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft">类型：</div>
					<div class="righttext">
						<div id="payType"></div>

					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">币种</div>
					<div class="righttext">
						<s:textfield id="currency0" style="width: 155px;"
							name="guaranteesQuery.currency" readonly="true"></s:textfield>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">金额</div>
					<div class="righttext">
						<s:textfield name="guaranteesQuery.amount" style="width: 155px;"
							readonly="true"></s:textfield>
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft">是否循环</div>
					<div class="righttext">
						<div id="cycleFlag"></div>
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">付款周期</div>
					<div class="righttext">
						<s:textfield name="guaranteesQuery.payPeriod"
							style="width: 155px;" readonly="true"></s:textfield>
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">单证交单期</div>
					<div class="righttext">
						<s:textfield name="guaranteesQuery.docAgainstDay"
							style="width: 155px;" readonly="true"></s:textfield>
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft">开证日</div>
					<div class="righttext">
						<s:textfield name="guaranteesQuery.startDate"
							style="width: 155px;" readonly="true"></s:textfield>
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">到期日</div>
					<div class="righttext">
						<s:textfield name="guaranteesQuery.endDate" style="width: 155px;"
							readonly="true"></s:textfield>
					</div>
				</div>
				<%-- <div class="item33 lastitem">
					<div class="itemleft">有效期</div>
					<div class="righttext">
						<s:textfield name="guaranteesQuery.valid" style="width: 155px;"
							readonly="true"></s:textfield>
					</div>
				</div> --%>
				<div class="item33">
					<div class="itemleft">通知行</div>
					<div class="righttext">
						<input type="text" name="notifyBank" class="easyui-validatebox"
							data-options="required:true" missingMessage="请填写通知行"
							style="width: 155px;"/>
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="half_zoc">
					<div class="halfstring_zoc">
						<span>审核意见：</span>
					</div>
					<textarea name="guaranteesQuery.finAuditOpenion"
						class="mod1 easyui-validatebox" id="finAuditOpenion"
						required="true" missingMessage="请输入审核意见" validType="length[0,200]"></textarea>
				</div>
				<div class="half_zoc" style="vertical-align: bottom;">
					<div class="halfstring_zoc">
						<span>签字:</span>
					</div>
					<s:textfield class="easyui-validatebox" required="true"
						missingMessage="请输入签名" name="guaranteesQuery.finAuditCode"></s:textfield>
				</div>
			</div>
			<div class="oneline">
				<div class="item100 lastitem">
					<div class="oprationbutt">
						<input type="button" onclick="checkAgree()" value="审核通过">
						</input> <input type="button" onclick="checkDisagree();" value="审核不通过">
						</input>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>