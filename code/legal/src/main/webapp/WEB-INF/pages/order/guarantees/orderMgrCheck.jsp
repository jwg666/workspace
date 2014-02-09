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
			url : '${dynamicURL}/guarantees/guaranteesAction!showDescOrderMgr.action?guarantees=${guarantees}',
			onLoadSuccess : function(data) {
				$("#docAuditOpenion").val('');
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
		guaranteesEditForm.form('load', '${dynamicURL}/guarantees/guaranteesAction!showDescOrderMgr.action?guarantees=${guarantees}');
	});
	function checkAgree() {
		if (!guaranteesEditForm.form('validate')) {
			return;
		}
		//审核通过
		$.ajax({
			url : '${dynamicURL}/guarantees/guaranteesAction!orderMgrCheckResult.action?checkResult=true',
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
			url : '${dynamicURL}/guarantees/guaranteesAction!orderMgrCheckResult.action?checkResult=false',
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
						<input name="guarantees" id="guarantees0" type="text"
							readonly="readonly" style="width: 155px;" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">受益人</div>
					<div class="righttext">
						<input name="beneficiaries" type="text" style="width: 155px;"
							readonly="readonly" />
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft">客户：</div>
					<div class="righttext">
						<input name="customerName" style="width: 155px;"
							readonly="readonly" id="customerCode0"></input>
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">开证行</div>
					<div class="righttext">
						<input name="bankName" type="text" style="width: 155px;"
							readonly="readonly" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">改证次数</div>
					<div class="righttext">
						<input name="modifyNum" type="text" style="width: 155px;"
							readonly="readonly" />
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft">类型</div>
					<div class="righttext">
						<!-- <input name="payType" type="text" style="width: 155px;"
							readonly="readonly" /> -->
							<div id="payType"></div>
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">币种</div>
					<div class="righttext">
						<input id="currency0" style="width: 155px;" name="currency"
							readonly="readonly" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">金额</div>
					<div class="righttext">
						<input name="amount" type="text" style="width: 155px;"
							readonly="readonly" />
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft">是否循环</div>
					<div class="righttext">
						<%-- <s:if test="cycleFlag eq '1'">是</s:if>
						<s:else>否</s:else> --%>
						<div id="cycleFlag"></div>
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">付款周期</div>
					<div class="righttext">
						<input name="payPeriod" type="text" style="width: 155px;"
							readonly="readonly" />
					</div>
				</div>
				<div class="item33">
					<div class="itemleft">单证交单期</div>
					<div class="righttext">
						<input name="docAgainstDay" type="text" style="width: 155px;"
							readonly="readonly" />
					</div>
				</div>
				<div class="item33 lastitem">
					<div class="itemleft">开证日</div>
					<div class="righttext">
						<input name="startDate" type="text" style="width: 155px;"
							readonly="readonly" />
					</div>
				</div>
			</div>
			<div class="oneline">
				<div class="item33">
					<div class="itemleft">到期日</div>
					<div class="righttext">
						<input name="endDate" type="text" style="width: 155px;"
							readonly="readonly" />
					</div>
				</div>
				<!-- <div class="item33 lastitem">
					<div class="itemleft">有效期</div>
					<div class="righttext">
						<input name="valid" type="text" style="width: 155px;"
							readonly="readonly" />
					</div>
				</div> -->
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
					<textarea name="docAuditOpenion" class="mod1 easyui-validatebox"
						id="docAuditOpenion" required="true" missingMessage="请输入审核意见"
						validType="length[0,200]"></textarea>
				</div>
				<div class="half_zoc" style="vertical-align: bottom;">
					<div class="halfstring_zoc">
						<span>签字:</span>
					</div>
					<input type="text" class="easyui-validatebox" required="true"
						missingMessage="请输入签名" name="docAuditCode" value="${empName }"></input>
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