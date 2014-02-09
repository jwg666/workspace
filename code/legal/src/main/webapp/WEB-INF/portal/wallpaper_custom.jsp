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
			<a class="btn" href="wallpaper.do" >系统壁纸</a><a class="btn disabled">自定义</a>
		</div>
		<div class="fr">
			<label>显示方式：</label>
			<s:select name="wallpapertype" id="wallpapertype" cssStyle="width:100px" list="#{'tianchong':'填充','shiying':'适应','pingpu':'平铺','lashen':'拉伸','juzhong':'居中'}" value="memberQuery.wallpapertype" />
		</div>
	</div>
	<div class="wapppapercustom">
		<div class="tip">
			<a class="btn btn-mini fr" style="overflow:hidden;position:relative">上传壁纸<input type="file" id="uploadfilebtn" style="position:absolute;right:0;bottom:0;opacity:0;filter:alpha(opacity=0);display:block;width:200px;height:100px"></a>
			<strong>自定义壁纸：</strong>壁纸大小不超过1M
		</div>
		<div class="view">
			<ul>
				<s:iterator id="l" value="list" status='st'>
					<s:if test="%{#st.index % 3 ==2}">
						<li class="three" id='<s:property value="#l.tbid" />' >
					</s:if>
					<s:else>
						<li id='<s:property value="#l.tbid" />' >
					</s:else>
						<img style="width:100;height:100%" src='${dynamicURL}/basic/fileUploadAction/downloadImage.do?fileId=<s:property value="#l.url" />'><a href="javascript:;">删 除</a></li>
				</s:iterator>
			</ul>
		</div>
	</div>
	<div class="wapppaperwebsite form-inline">
		<label>网络壁纸：</label>
		<div class="input-append">
			<input type="text" id="wallpaperurl" style="width:350px" placeholder="请输入一个URL地址（地址以 jpg, jpeg, png, gif, html, htm 结尾）" value="${memberQuery.wallpaperwebsite}"><button type="button" class="btn">应用</button>
		</div>
	</div>
<jsp:include page="_portal_js.jsp"></jsp:include>
<script>
$(function(){
	$('#wallpapertype').on('change', function(){
		window.parent.HROS.wallpaper.update(0, $('#wallpapertype').val(), '');
	});
	$('.wapppapercustom .view').on('click', 'li', function(){
		window.parent.HROS.wallpaper.update(2, $('#wallpapertype').val(), $(this).attr('id'));
	});
	$('.wapppapercustom .view').on('click', 'li a', function(){
		var id = $(this).parent().attr('id');
		$.ajax({
			type : 'POST',
			url : '${dynamicURL}/basic/portalAction/ajax.do',
			data : 'ac=deleteWallpaper&id=' + id,
			dataType : "json",
			success : function(data){
				if(data.success){
					$('#' + id).remove();
				}
			}
		});
		return false;
	});
	$('.wapppaperwebsite button').on('click', function(){
		if($('#wallpaperurl').val().length>0){
			window.parent.HROS.wallpaper.update(3, $('#wallpapertype').val(), $('#wallpaperurl').val());
		}
	});
	$('#uploadfilebtn').on('change', function(e){
		var files = e.target.files || e.dataTransfer.files;
		if(files.length == 0){
			return;
		}
		//检测文件是不是图片
		if(files[0].type.indexOf('image') === -1){
			alert('请上传图片');
			return false;
		}
		//检测文件大小是否超过1M
		if(files[0].size > 1024*1024){
			alert('图片大小超过1M');
			return;
		}
		var fd = new FormData();
		fd.append('upload', files[0]);
		fd.append('remarks', "pwallpaper");
		var xhr = new XMLHttpRequest();
		if(xhr.upload){
			$.dialog({
				id: 'uploadImg',
				title: '正在上传',
				content: '<div id="imgProgress" class="progress progress-striped active" style="width:200px;margin-bottom:0"><div class="bar"></div></div>',
				cancel: false
			});
			xhr.upload.addEventListener('progress', function(e){
				if(e.lengthComputable){
					var loaded = Math.ceil(e.loaded / e.total * 100);
					$('#imgProgress .bar').css({
						width: loaded + '%'
					});
				}
			}, false);
			xhr.addEventListener('load', function(e){
				$('#uploadfilebtn').val('');
				$.dialog.list['uploadImg'].close();
				if(xhr.readyState == 4 && xhr.status == 200){
					var result = jQuery.parseJSON(e.target.responseText);
					if(result.success){
						var wapppaper = $("#"+result.obj.tbid);
						if(wapppaper.length>0){
							wapppaper.attr("style",'background:url('+window.parent.HROS.CONFIG.basicStaticUrl+ '/' + result.obj.url + ')');
						}else{
							$('.wapppapercustom .view ul').append('<li id="'+result.obj.tbid+'" > <img style="width:100;height:100%" src=' + window.parent.HROS.CONFIG.downloadImage + result.obj.url + ' /><a href="javascript:;">删 除</a></li>');
						}
						window.parent.HROS.wallpaper.update(2, $('#wallpapertype').val(), result.obj.tbid);
					}else{
						ZENG.msgbox.show(result.msg, 5, 2000);
					}
				}
			}, false);
			xhr.open('post', '${dynamicURL}/basic/portalAction/uploadImg.do?ac=custom', true);
			xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
			xhr.send(fd);
		}
	});
});
</script>
</body>
</html>