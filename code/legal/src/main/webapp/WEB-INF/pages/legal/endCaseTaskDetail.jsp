<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var endCaseForm;	
	$(function() {
		endCaseForm = $('#endCaseForm').form({
			url : 'legalAction!endCase.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
					//customWindow.reloaddata();
					parent.window.HROS.window.close(currentappid);
					top.window.showTaskCount();
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});
	});
	function submitCase(){
		endCaseForm.submit();
	}
	function resetInfo(obj){
		obj.form('reset');
	}
</script>
</head>
<body class="easyui-layout">	
	<div region="center" border="false">
		<div class="part_zoc" style="margin:0px 0px 0px 0px;">
			    <div class="partnavi_zoc">
					<span>申请人基本信息</span>
				</div>
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100">姓名：</div>
						<div class="righttext">
							<input id="applicantName" type="text" style="width:100px" value="${legalApplicantQuery.name}" readonly="readonly"/>
							
						</div>
				    </div>				    
				    <div class="item25">
						<div class="itemleft100">性别：</div>
						<div class="righttext">
							<s:if test="legalApplicantQuery.gender==\"m\"">
								<input id="applicantGender" type="text" style="width:30px" value="男" readonly="readonly"/>
							</s:if>
							<s:else>
								<input id="applicantGender" type="text" style="width:30px" value="女" readonly="readonly"/>
							</s:else>
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">出生日期：</div>
						<div class="righttext">
							<s:date  name="legalApplicantQuery.birthday"   format="yyyy-mm-dd" />
						</div>
				    </div>
				    <div class="item25 lastitem">
						<div class="itemleft100">民族：</div>
						<div class="rightselect_easyui">
							<input id="nationId" name="nationId"  style="width:100px" readonly="readonly"/>
						</div>
				    </div>
				</div>
				
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100">文化程度：</div>
						<div class="righttext">
							<input id="eduLevelId" name="eduLevelId" style="width:100px" readonly="readonly"/>
						</div>
				    </div>				    
				    <div class="item25">
						<div class="itemleft100">人群类别：</div>
						<div class="rightselect_easyui">
							<input id="category" name="category"  style="width:100px" readonly="readonly"/>
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">证件号码：</div>
						<div class="righttext">
							<input id="identifyid" name="identifyid"  style="width:100px" value="${legalApplicantQuery.identifyid}" readonly="readonly"/>
						</div>
				    </div>
				    <div class="item25 lastitem" >
						<div class="itemleft100">是否符合法律援助经常困难标准：</div>
						<div class="rightselect_easyui">
							<s:if test="legalApplicantQuery.ifFinancialDifficulty==\"0\"">
								<input id="applicantGender" type="text" style="width:30px" value="是" readonly="readonly"/>
							</s:if>
							<s:else>
								<input id="applicantGender" type="text" style="width:30px" value="否" readonly="readonly"/>
							</s:else>							
						</div>
				    </div>
				</div>
				<div class="oneline">
				    <div class="item25 lastitem" >
						<div class="itemleft100">户籍所在地：</div>
						<div class="righttext">
							<input id="birthPlace" name="birthPlace"  style="width:100px" value="${legalApplicantQuery.birthPlace}" readonly="readonly"/>
						</div>
				    </div>
			   </div>
				<div class="oneline">
				    <div class="item25 lastitem" >
						<div class="itemleft100">住所地：</div>
						<div class="righttext">
							<input id="livePlace" name="livePlace"  style="width:100px" value="${legalApplicantQuery.livePlace}" readonly="readonly"/>
						</div>
				    </div>
			   </div>
			   <div class="oneline">
				    <div class="item25">
						<div class="itemleft100">邮编：</div>
						<div class="righttext">
							<input id="postCode" name="postCode"  style="width:100px" value="${legalApplicantQuery.postCode}" readonly="readonly"/>
						</div>
				    </div>
				     <div class="item25">
						<div class="itemleft100">电话：</div>
						<div class="righttext">
							<input id="phone" name="phone"  style="width:100px"value="${legalApplicantQuery.phone}" readonly="readonly"/>
						</div>
				    </div>
				    <div class="item25 lastitem">
						<div class="itemleft100">工作所在地：</div>
						<div class="righttext">
							<input id="company" name="company"  style="width:100px"value="${legalApplicantQuery.company}" readonly="readonly"/>
						</div>
				    </div>				    
			   </div>
			<!-- 代理人 开始-->
			<div class="partnavi_zoc">
					<span>代理人信息</span>
			</div>			
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100">姓名：</div>
						<div class="righttext">
							<input id="agentName" name="name"  style="width:100px" value="${legalAgentQuery.name}" readonly="readonly"/>
						</div>
				    </div>
				     <div class="item25">
						<div class="itemleft100">代理类别：</div>
						<div class="righttext">
							<s:if test="legalAgentQuery.agentType==\"1\"">
								<input id="agentType" type="text" class="short80" value="法定代理人" readonly="readonly"/>
							</s:if>
							<s:else>
								<input id="agentType" type="text" class="short80" value="委托代理人" readonly="readonly"/>
							</s:else>
						</div>
				    </div>
				    <div class="item25 lastitem">
						<div class="itemleft100">身份证号：</div>
						<div class="righttext">
							<input id="identifyid" name="identifyid"  style="width:100px"value="${legalAgentQuery.identifyid}" readonly="readonly"/>
						</div>
				    </div>
			   </div>
			<!-- 代理人 结束-->
			<!-- 案件信息开始 -->
			<div class="partnavi_zoc">
					<span>案件信息</span>
			</div>
				<div class="oneline">				    
				     <div class="item25">
						<div class="itemleft100">案件来源：</div>
						<div class="righttext">
							<input id="caseFrom" name="caseFrom"  style="width:120px" value="${legalCaseQuery.caseFrom}"readonly="readonly"/>
						</div>
				    </div>
				    <div class="item25 lastitem">
						<div class="itemleft100">申请事项：</div>
						<div class="righttext">
							<input id="applyTypeId" name="applyTypeId"  style="width:120px"value="${legalCaseQuery.applyTypeId}" readonly="readonly"/>
						</div>
				    </div>
			   </div>
				<div class='oneline'>								
					<div class="half_zoc">
						<table>
							<tr>
								<td>案件描述</td>
								<td >
									<textarea name="description" id="description" style="width:300px;height:100px">
										${legalCaseQuery.description}
									</textarea>
								</td>
							</tr>
						</table>  
				    </div>
				    <div class="half_zoc">
						<table>
							<tr>
								<td>审核意见</td>
								<td>
									<textarea name="approveContent" id="approveContent" style="width:300px;height:100px"></textarea>
								</td>
							</tr>
						</table>  
				    </div>
				</div>
			<!-- 案件信息结束 -->
			<!-- 审核开始 -->
			<div class="partnavi_zoc">
				<span>接收案件操作</span>
			</div>
			<form id="endCaseForm">
			<input type="hidden" id="caseId" name="legalCaseQuery.id" value="${legalCaseQuery.id}"/>
						
			<div class="item100">
		        <div class="oprationbutt">
			        <input type="button" value="确定" onclick="submitCase()"/>
			        <input type="button" value="重置"  onclick="resetInfo(this)"/>
		       </div>
	        </div>
	        </form>
	        <!-- 审核结束 -->
		</div>
	</div>	
</body>
</html>