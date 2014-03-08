<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>

<script type="text/javascript">
		var legalApplicantAddForm ;
		var legalCaseAddForm;
		var legalAgentAddForm;
		$(function(){			
			legalApplicantAddForm = $('#legalApplicantAddForm').form({
				url : 'legalApplicantAction!add.do',
				dataType:"json",
				type:"post",
				onSubmit: function(){
					var isValid = $(this).form('validate');
					if (!isValid){
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
						$("#applicantId").val(json.obj.id);
					} else {
						$.messager.show({
							title : '失败',
							msg : '操作失败！'
						});
					}
				  }
				});			
				$("#category").combobox({
				    url:'../basic/dictionaryAction!combox?parentCode=4',
				    valueField:'id',
				    textField:'dicValue'
				});
				$("#nationId").combobox({
				    url:'../basic/dictionaryAction!combox?parentCode=3',
				    valueField:'id',
				    textField:'dicValue'
				});
				$("#eduLevelId").combobox({
				    url:'../basic/dictionaryAction!combox?parentCode=7',
				    valueField:'id',
				    textField:'dicValue'
				});
				$('#name').validatebox({
				    required: true,
				    missingMessage:"申请人不能为空"
				});
				
				legalAgentAddForm = $('#legalAgentAddForm').form({
					url : 'legalAgentAction!add.do',
					success : function(data) {
						$.messager.progress('close');
						var json = $.parseJSON(data);
						if (json && json.success) {
						    $.messager.show({
								title : '成功',
								msg : json.msg								
							}); 
							$("#agentId").val(json.obj.id);
						} else {
							$.messager.show({
								title : '失败',
								msg : '操作失败！'
							});
						}
					}
				});
				legalCaseAddForm = $('#legalCaseAddForm').form({
					url : 'legalCaseAction!add.do',
					success : function(data) {
						$.messager.progress('close');
						var json = $.parseJSON(data);
						if (json && json.success) {
							$.messager.show({
								title : '成功',
								msg : json.msg
							});
							legalApplicantAddForm.form('clear');
							legalAgentAddForm.form('clear');
							legalCaseAddForm.form('clear');
						}else {
							$.messager.show({
								title : '失败',
								msg : '操作失败！'
							});
						}
					}
				});
				$('#description').validatebox({
				    required: true,
				    missingMessage:"案件描述不能为空"
				});
				$("#applyTypeId").combobox({
				    url:'../basic/dictionaryAction!combox?parentCode=5',
				    valueField:'id',
				    textField:'dicValue'
				});
				$("#caseFrom").combobox({
				    url:'../basic/dictionaryAction!combox?parentCode=9',
				    valueField:'id',
				    textField:'dicValue'
				});
			});
		
		function resetInfo(obj){
			obj.form('reset');
		}
		function submitLegalApplicant(){
			legalApplicantAddForm.submit();
			$.messager.progress({
				text : '数据处理中……',
				interval : 100
			});
		}
		function submitLegalAgent(){
			legalAgentAddForm.submit();
			$.messager.progress({
				text : '数据处理中……',
				interval : 100
			});
		}
		function submitLegalCase(){
			legalCaseAddForm.submit();
			$.messager.progress({
				text : '数据处理中……',
				interval : 100
			});
		}
	</script>
</head>
<body class="easyui-layout">
	<div region="north" split="true" style="height:10px;"  collapsed="false" border="false">
		 <div class="part_zoc" style="margin:0px 0px 0px 0px;" >
			 <div class="partnavi_zoc">
						<span>法律援助申请</span>
			</div>
			<div class="oneline">
				
			</div>
		</div>
	</div>
	
	<div region="center" border="false">
		<div class="part_zoc" style="margin:0px 0px 0px 0px;">
				<form id="legalApplicantAddForm">
			    <div class="partnavi_zoc">
					<span>第一步：填写申请人基本信息</span>
				</div>
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100">姓名：</div>
						<div class="righttext">
							<input id="name" name="name" class="easyui-validatebox" data-options="required:true" type="text" style="width:100px"/>
						</div>
				    </div>				    
				    <div class="item25">
						<div class="itemleft100">性别：</div>
						<div class="rightselect_easyui">
							<select id="gender" name="gender"  class="short50">
								<option value="m">男</option>
								<option value="f">女</option>
							</select>
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">出生日期：</div>
						<div class="righttext">
							<input id="birthday" name="birthday"  style="width:100px" class="easyui-datebox"/>
						</div>
				    </div>
				    <div class="item25 lastitem">
						<div class="itemleft100">民族：</div>
						<div class="rightselect_easyui">
							<input id="nationId" name="nationId"  style="width:100px"/>
						</div>
				    </div>
				</div>
				
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100">文化程度：</div>
						<div class="righttext">
							<input id="eduLevelId" name="eduLevelId" style="width:100px"/>
						</div>
				    </div>				    
				    <div class="item25">
						<div class="itemleft100">人群类别：</div>
						<div class="rightselect_easyui">
							<input id="category" name="category"  style="width:100px"/>
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">证件号码：</div>
						<div class="righttext">
							<input id="identifyid" name="identifyid"  style="width:100px"/>
						</div>
				    </div>
				    <div class="item25 lastitem" >
						<div class="itemleft100">是否符合法律援助经常困难标准：</div>
						<div class="rightselect_easyui">
							<select id="ifFinancialDifficulty" name="ifFinancialDifficulty"  class="short50">
								<option value="0">否</option>
								<option value="1">是</option>
							</select>
						</div>
				    </div>
				</div>
				<div class="oneline">
				    <div class="item25 lastitem" >
						<div class="itemleft100">户籍所在地：</div>
						<div class="righttext">
							<input id="birthPlace" name="birthPlace"  style="width:100px"/>
						</div>
				    </div>
			   </div>
				<div class="oneline">
				    <div class="item25 lastitem" >
						<div class="itemleft100">住所地：</div>
						<div class="righttext">
							<input id="livePlace" name="livePlace"  style="width:100px"/>
						</div>
				    </div>
			   </div>
			   <div class="oneline">
				    <div class="item25">
						<div class="itemleft100">邮编：</div>
						<div class="righttext">
							<input id="postCode" name="postCode"  style="width:100px"/>
						</div>
				    </div>
				     <div class="item25">
						<div class="itemleft100">电话：</div>
						<div class="righttext">
							<input id="phone" name="phone"  style="width:100px"/>
						</div>
				    </div>
				    <div class="item25 lastitem">
						<div class="itemleft100">工作所在地：</div>
						<div class="righttext">
							<input id="company" name="company"  style="width:100px"/>
						</div>
				    </div>				    
			   </div>
			   <div class="oneline">	
			   	   <div class="item100">
				       <div class="oprationbutt">
					        <input type="button" value="确认进行第二步" onclick="submitLegalApplicant()"/>
					        <input type="button" value="填写有误重新填写"  onclick="resetInfo(this)"/>
				       </div>
			       </div>	
			   </div>
			</form>	
			<!-- 代理人 开始-->
			<div class="partnavi_zoc">
					<span>第二步：代理人信息</span>
			</div>			
			<form id="legalAgentAddForm">
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100">姓名：</div>
						<div class="righttext">
							<input id="agentName" name="name"  style="width:100px"/>
						</div>
				    </div>
				     <div class="item25">
						<div class="itemleft100">代理类别：</div>
						<div class="righttext">
							<select id="agentType" name="agentType">
								<option value="1">法定代理人</option>
								<option value="2">委托代理人</option>
							</select>
						</div>
				    </div>
				    <div class="item25 lastitem">
						<div class="itemleft100">身份证号：</div>
						<div class="righttext">
							<input id="identifyid" name="identifyid"  style="width:100px"/>
						</div>
				    </div>
			   </div>
			    <div class="oneline">	
			   	   <div class="item100">
				       <div class="oprationbutt">
					        <input type="button" value="确认进行第三步" onclick="submitLegalAgent()"/>
					        <input type="button" value="填写有误重新填写"  onclick="resetInfo(this)"/>
				       </div>
			       </div>	
			   </div>	
			</form>
			<!-- 代理人 结束-->
			<!-- 案件信息开始 -->
			<div class="partnavi_zoc">
					<span>第三步：案件信息录入</span>
			</div>
			<form id="legalCaseAddForm">
				<input type="hidden" id="applicantId"name="applicantId">
				<input type="hidden" id="agentId"name="agentId">
				<div class="oneline">				    
				     <div class="item25">
						<div class="itemleft100">案件来源：</div>
						<div class="righttext">
							<input id="caseFrom" name="caseFrom"  style="width:120px"/>
						</div>
				    </div>
				    <div class="item25 lastitem">
						<div class="itemleft100">申请事项：</div>
						<div class="righttext">
							<input id="applyTypeId" name="applyTypeId"  style="width:120px"/>
						</div>
				    </div>
			   </div>
				<div class='oneline'>								
					<div class="half_zoc">
						<table>
							<tr>
								<td>案件描述</td>
								<td>
									<textarea id="description" name="description"  style="width:300px;height:150px"></textarea>
								</td>
							</tr>
						</table>  
				    </div>
				    <div class="half_zoc">					    
						<table>
							<tr>
								<td>签名</td>
								<td>
									<textarea id="" name=""  style="width:300px;height:150px"></textarea>
								</td>
							</tr>
						</table>
				    </div>
				   	<div class="item100">
				        <div class="oprationbutt">
					        <input type="button" value="提交申请" onclick="submitLegalCase()"/>
					        <input type="button" value="重置"  onclick="resetInfo(this)"/>
				       </div>
			        </div>
				</div>
			</form>
			<!-- 案件信息结束 -->
		</div>
	</div>
</div>

</body>
</html>