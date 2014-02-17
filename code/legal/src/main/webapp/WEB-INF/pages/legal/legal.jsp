<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
$("document").ready(function(){
});
var legalApplicantAddForm = $("#legalApplicantAddForm");
$(function() {
		legalApplicantAddForm = $('#legalApplicantAddForm').form({
			url : 'legalApplicantAction!add.do',
			success : function(data) {
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
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
				var json = $.parseJSON(data);
				if (json && json.success) {
					$.messager.show({
						title : '成功',
						msg : json.msg
					});
				} else {
					$.messager.show({
						title : '失败',
						msg : '操作失败！'
					});
				}
			}
		});		
});
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
					<span>申请人基本信息</span>
				</div>
				<div class="oneline">
				    <div class="item25">
						<div class="itemleft100">姓名：</div>
						<div class="righttext">
							<input id="name" name="name"  style="width:100px"/>
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
							<input id="eduLevelId" name="eduLevelId"  style="width:100px"/>
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
			</form>	
			<!-- 代理人 开始-->
			<div class="partnavi_zoc">
					<span>代理人信息</span>
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
							<input id="agentType" name="agentType"  style="width:100px"/>
						</div>
				    </div>
				    <div class="item25 lastitem">
						<div class="itemleft100">身份证号：</div>
						<div class="righttext">
							<input id="identifyid" name="identifyid"  style="width:100px"/>
						</div>
				    </div>
			   </div>	
			</form>
			<!-- 代理人 结束-->
			<!-- 案件信息开始 -->
			<div class="partnavi_zoc">
					<span>案件信息</span>
			</div>
			<form id="legalCaseAddForm">
				<div class='oneline'>								
					<div class="half_zoc">
						<table>
							<tr>
								<td>案件描述</td>
								<td>
									<textarea id="description" name="description"  style="width:500px;height:250px"></textarea>
								</td>
							</tr>
						</table>  
				    </div>				    
				    <div class="half_zoc">					    
						<table>
							<tr>
								<td>签名</td>
								<td>
									<textarea id="description" name="description"  style="width:500px;height:250px"></textarea>
								</td>
							</tr>
						</table>
				    </div>
				   	
				</div>
			</form>
			<!-- 案件信息结束 -->
			
		</div>
	</div>

	
</div>
</body>
</html>