<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
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
						<div class="rightselect_easyui">性别：</div>
						<div class="righttext">
							<input id="gender" name="gender"  class="short50"/>
						</div>
				    </div>
				    <div class="item25">
						<div class="itemleft100">出生日期：</div>
						<div class="righttext">
							<input id="name" name="name"  style="width:100px"/>
						</div>
				    </div>
				    <div class="item25" lastitem>
						<div class="itemleft100">民族：</div>
						<div class="rightselect_easyui">
							<input id="nationId" name="name"  style="width:100px"/>
						</div>
				    </div>
				</div>
				
			</form>	
		</div>
	</div>

	
</div>
</body>
</html>