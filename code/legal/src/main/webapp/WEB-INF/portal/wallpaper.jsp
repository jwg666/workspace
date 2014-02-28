<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta charset="utf-8">
<title>壁纸设置</title>
<jsp:include page="_portal_css.jsp"></jsp:include>
<link rel="stylesheet" href="${staticURL}/portal/img/ui/sys.css">
</head>

<body>
	<div class="title">
		<ul>
			<li class="focus">壁纸设置</li>
			<li><a href="skin.do">皮肤设置</a></li>
		</ul>
	</div>
	<div class="wallpapertype form-inline">
		<div class="btn-group fl">
			<a class="btn disabled">系统壁纸</a><a class="btn" href="wallpaperCustom.do">自定义</a>
		</div>
		<div class="fr">
			<label>显示方式：</label>
			<s:select name="wallpapertype" id="wallpapertype" cssStyle="width:100px" list="#{'tianchong':'填充','shiying':'适应','pingpu':'平铺','lashen':'拉伸','juzhong':'居中'}" value="memberQuery.wallpapertype" />
		</div>
	</div>
	<ul class="wallpaper">
		<s:iterator id="l" value="list" status='st'>
			<s:if test="%{#st.index % 3 ==2}">
				<li class="three" wpid='<s:property value="#l.tbid" />'>
			</s:if>
			<s:else>
				<li wpid='<s:property value="#l.tbid" />'>
			</s:else>
			<img style="width:150px;height:84px" src='${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=<s:property value="#l.url" />'>
			<div><s:property value="#l.title" /></div>
			</li>
		</s:iterator>
	</ul>
<jsp:include page="_portal_js.jsp"></jsp:include>
<script>
$(function(){
	$("#wallpapertype").on('change',function(){
		window.parent.HROS.wallpaper.update(0, $('#wallpapertype').val(),'');
	});
	$('.wallpaper li').on('click',function(){
		window.parent.HROS.wallpaper.update(1, $('#wallpapertype').val(), $(this).attr('wpid'));
	});
});
</script>
</body>
</html>