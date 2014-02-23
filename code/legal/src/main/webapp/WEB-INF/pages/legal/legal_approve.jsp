<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
$("document").ready(function(){
	
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
		    <div class="partnavi_zoc">
				<span>申请人基本信息</span>
			</div>
			<div class="oneline">
			    <div class="item25">
					<div class="itemleft100">姓名：</div>
					<div class="righttext">
						123
					</div>
			    </div>				    
			    <div class="item25">
					<div class="itemleft100">性别：</div>
					<div class="rightselect_easyui">
						男
					</div>
			    </div>
			    <div class="item25">
					<div class="itemleft100">出生日期：</div>
					<div class="righttext">
						1990-2-2
					</div>
			    </div>
			    <div class="item25 lastitem">
					<div class="itemleft100">民族：</div>
					<div class="rightselect_easyui">
						汉
					</div>
			    </div>
			</div>
			
			<div class="oneline">
			    <div class="item25">
					<div class="itemleft100">文化程度：</div>
					<div class="righttext">
						大学
					</div>
			    </div>				    
			    <div class="item25">
					<div class="itemleft100">人群类别：</div>
					<div class="rightselect_easyui">
						大学
					</div>
			    </div>
			    <div class="item25">
					<div class="itemleft100">证件号码：</div>
					<div class="righttext">
						123
					</div>
			    </div>
			    <div class="item25 lastitem" >
					<div class="itemleft100">是否符合法律援助经常困难标准：</div>
					<div class="rightselect_easyui">
						否
					</div>
			    </div>
			</div>
			<div class="oneline">
			    <div class="item25 lastitem" >
					<div class="itemleft100">户籍所在地：</div>
					<div class="righttext">
						请问而官方
					</div>
			    </div>
		   </div>
			<div class="oneline">
			    <div class="item25 lastitem" >
					<div class="itemleft100">住所地：</div>
					<div class="righttext">
						请问而官方
					</div>
			    </div>
		   </div>
		   <div class="oneline">
			    <div class="item25">
					<div class="itemleft100">邮编：</div>
					<div class="righttext">
						266000
					</div>
			    </div>
			     <div class="item25">
					<div class="itemleft100">电话：</div>
					<div class="righttext">
						123
					</div>
			    </div>
			    <div class="item25 lastitem">
					<div class="itemleft100">工作所在地：</div>
					<div class="righttext">
						请问而官方
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
						不过
					</div>
			    </div>
			     <div class="item25">
					<div class="itemleft100">代理类别：</div>
					<div class="righttext">
						突然
					</div>
			    </div>
			    <div class="item25 lastitem">
					<div class="itemleft100">身份证号：</div>
					<div class="righttext">
						123
					</div>
			    </div>
		   </div>	
			<!-- 代理人 结束-->
			<!-- 案件信息开始 -->
			<div class="partnavi_zoc">
					<span>案件信息</span>
			</div>
			<div class='oneline'>								
				<div class="half_zoc">
					<table>
						<tr>
							<td>案件描述</td>
							<td>
								<textarea id="description" readonly="readonly" name="description"  style="width:100%;height:150px">123</textarea>
							</td>
						</tr>
					</table>  
			    </div>
			    <div class="half_zoc">					    
					<table>
						<tr>
							<td>签名</td>
							<td>
								<textarea name="approveContent" id="description" readonly="readonly" name="description" style="width:100%;height:150px">123</textarea>
							</td>
						</tr>
					</table>
			    </div>
			</div>
			<!-- 案件信息结束 -->
			<!-- 案件审批 -->
			<div class="partnavi_zoc">
				<span>案件审批</span>
			</div>
			<div class='oneline'>								
				<form action="" id="legalApproveAction" method="post">
					<div align="center">
						<table style="width: 96%">
							<tr>
								<td align="center">
									<textarea id="approveContent" name="approveContent"  style="width:87%;height:150px">123</textarea>
								</td>
							</tr>
						</table>  
				    </div>
				</form>
			    <div class="item100" style="width: 100%;padding: 10px;">
			        <div class="oprationbutt">
				        <input type="button" value="提交" onclick="submitInfo()"/>
				        <input type="button" value="重置"  onclick="resetInfo()"/>
			       </div>
		        </div>
			</div>
			<!-- 案件审批 -->
		</div>
	</div>
</div>
<div style="display: none;">
	<script type="text/javascript">
		function submitInfo(){
			$('#legalApproveAction').form('submit',{
				url : 'legalApproveAction!add.do',
				//dataType:"json",
				type:"post",
				onSubmit: function(){
					/* var str = null;
					var strValue = false;
					str = $("#name").val();
					strValue = checkInfo(str);
					if(strValue){
						alert("姓名不能为空！");
						$("#name").focus();
						return false;
					}
					str = $("#identifyid").val();
					strValue = checkInfo(str);
					if(strValue){
						alert("证件号不能为空！");
						$("#identifyid").focus();
						return false;
					}
					str = $("#birthPlace").val();
					strValue = checkInfo(str);
					if(strValue){
						alert("户籍所在地不能为空！");
						$("#birthPlace").focus();
						return false;
					}
					str = $("#livePlace").val();
					strValue = checkInfo(str);
					if(strValue){
						alert("住所不能为空！");
						$("#livePlace").focus();
						return false;
					}
					str = $("#phone").val();
					strValue = checkInfo(str);
					if(strValue){
						alert("电话不能为空！");
						$("#phone").focus();
						return false;
					}
					str = $("#description").text();
					strValue = checkInfo(str);
					if(strValue){
						alert("案件描述不能为空！");
						$("#description").focus();
						return false;
					} */
				},
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
		}
		function resetInfo(){
			$("#name").val("");
			$("#birthday").val("");
			$("#nationId").val("");
			$("#eduLevelId").val("");
			$("#category").val("");
			$("#identifyid").val("");
			$("#birthPlace").val("");
			$("#livePlace").val("");
			$("#postCode").val("");
			$("#phone").val("");
			$("#company").val("");
			$("#agentName").val("");
			$("#agentType").val("");
			$("#dl_identifyid").val("");
			$("#righttext").html("");
			$("#description").html("");
			$("#qm_description").html("");
		}
		function checkInfo(str){
			if(str==null||str=="")return true;
			else return false;
		}
		function getEducation(){
			/* $('#eduLevelId').combobox({
		    url:'../basic/dictionaryAction!combox.do',
		    valueField:'id',
		    textField:'dicValue'
		}); */
		}
	</script>
</div>
</body>
</html>