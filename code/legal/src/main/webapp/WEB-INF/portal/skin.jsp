<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta charset="utf-8">
<title>皮肤设置</title>
<jsp:include page="_portal_css.jsp"></jsp:include>
<link rel="stylesheet" href="${staticURL}/portal/img/ui/sys.css">
</head>

<body>
	<div class="title">
		<ul>
			<li><a href="wallpaper.do">壁纸设置</a></li>
			<li class="focus">皮肤设置</li>
		</ul>
	</div>
	<ul class="skin">
		<s:iterator id="l" value="list" status='st'>
			<li skin='<s:property value="#l.name" />'><img src='${staticURL}/<s:property value="#l.img" />' style="width:256px;height:156px"></li>
		</s:iterator>
	</ul>
<jsp:include page="_portal_js.jsp"></jsp:include>
<script>
$(function(){
	$('.skin li').on('click', function(){
		var skin = $(this).attr('skin');
		$.ajax({
			url : 'skin.do',
			data : 'ac=update&skin=' + skin,
			success : function(){
				window.parent.ZENG.msgbox.show("设置成功，正在切换皮肤，如果长时间没更新，请刷新页面", 4, 5000);
				window.parent.HROS.base.getSkin(function(){
					window.parent.ZENG.msgbox._hide();
				});
			}
		});
	});
});
</script>
</body>
</html>
