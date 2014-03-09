<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta charset="utf-8">
<title>编辑私人应用</title>
<jsp:include page="_portal_css.jsp"></jsp:include>
<link rel="stylesheet" href="${staticURL}/portal/img/ui/sys.css">
<style type="text/css">
.creatbox .middle{bottom:0}
.bottom-bar{height:42px}
.bottom-bar .con{height:28px;background:#fff}
</style>
</head>

<body>
<form action="papp.do" method="post" name="form" id="form">
<input type="hidden" name="ac" value="edit">
<input type="hidden" name="id" value="${json.obj.tbid}">
<input type="hidden" name="desk" value="${json.obj.desk}">
<div class="creatbox">
	<div class="middle">
		<div class="input-label">
			<label class="label-text">应用图标：</label>
			<div class="label-box form-inline control-group">
				<div class="shortcutbox">
				<s:if test="json.obj.icon != null">
					<div class="shortcut-addicon bgnone"><input type="file" id="uploadfilebtn" style="position:absolute;right:0;bottom:0;opacity:0;filter:alpha(opacity=0);display:block;width:200px;height:100px"><img src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=${json.obj.icon}"></div>
				</s:if>
				<s:else>
					<div class="shortcut-addicon"><input type="file" id="uploadfilebtn" style="position:absolute;right:0;bottom:0;opacity:0;filter:alpha(opacity=0);display:block;width:200px;height:100px"><img src=""></div>
				</s:else>
					<div class="shortcut-selicon">
						<a href="javascript:;"><img src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=2013" valsrc="2013"></a>
						<a href="javascript:;"><img src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=2014" valsrc="2014"></a>
						<a href="javascript:;"><img src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=2015" valsrc="2015"></a>
						<a href="javascript:;"><img src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=2016" valsrc="2016"></a>
						<a href="javascript:;"><img src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=2017" valsrc="2017"></a>
						<a href="javascript:;"><img src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=2018" valsrc="2018"></a>
						<a href="javascript:;"><img src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=2019" valsrc="2019"></a>
						<a href="javascript:;"><img src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=2020" valsrc="2020"></a>
						<a href="javascript:;"><img src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=2022" valsrc="2021"></a>
						<a href="javascript:;"><img src="${dynamicURL}/portal/fileUploadAction/downloadImage.do?fileId=2022" valsrc="2022"></a>
					</div>
				</div>
				<input type="hidden" name="valIcon" id="valIcon" value="${json.obj.icon }" datatype="*" nullmsg="请选择或上传应用图标">
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="input-label">
			<label class="label-text">应用名称：</label>
			<div class="label-box form-inline control-group">
				<input type="text" class="text" name="valName" value="${json.obj.name }" datatype="*" nullmsg="请输入应用名称">
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="input-label">
			<label class="label-text">应用地址：</label>
			<div class="label-box form-inline control-group">
				<input type="text" name="valUrl" value="${json.obj.url }" style="width:300px" datatype="*" nullmsg="请输入应用地址">
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="input-label">
			<label class="label-text">窗口大小：</label>
			<div class="label-box form-inline control-group">
				<div class="input-prepend input-append">
					<span class="add-on">宽</span><input type="text" name="valWidth" value="${json.obj.width }" style="width:40px" datatype="n" nullmsg="请输入应用宽高" errormsg="宽高数值不规范"><span class="add-on">px</span>
				</div>
				<div class="input-prepend input-append" style="margin-left:10px">
					<span class="add-on">高</span><input type="text" name="valHeight" value="${json.obj.height }" style="width:40px" datatype="n" nullmsg="请输入应用宽高" errormsg="宽高数值不规范"><span class="add-on">px</span>
				</div>
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="input-label">
			<label class="label-text">应用类型：</label>
			<div class="label-box form-inline">
				<label class="radio" style="margin-right:10px"><input type="radio" name="valType" value="papp" ${json.obj.type=="papp"?"checked":"" } >APP</label>
				<label class="radio"><input type="radio" name="valType" value="pwidget" ${json.obj.type=="pwidget"?"checked":"" }>挂件</label>
			</div>
		</div>
		<div class="input-label input-label-isresize" ${json.obj.type=="widget"?"style='display:none'":"" } >
			<label class="label-text">窗口是否拉伸：</label>
			<div class="label-box form-inline">
				<label class="radio" style="margin-right:10px"><input type="radio" name="valIsresize" value="1" ${json.obj.isresize==1?"checked":"" } >是</label>
				<label class="radio"><input type="radio" name="valIsresize" value="0" ${json.obj.isresize==0?"checked":"" } >否</label>
			</div>
		</div>
		<div class="input-label input-label-isopenmax" ${(json.obj.type=="widget" || json.obj.isresize==0) ?"style='display:none'":"" } >
			<label class="label-text">打开默认最大化：</label>
			<div class="label-box form-inline">
				<label class="radio" style="margin-right:10px"><input type="radio" name="valIsopenmax" value="1" ${json.obj.isopenmax==1?"checked":"" }>是</label>
				<label class="radio"><input type="radio" name="valIsopenmax" value="0" ${json.obj.isopenmax==0?"checked":"" }>否</label>
			</div>
		</div>
		<div class="input-label input-label-isflash" ${json.obj.type=="widget"?"style='display:none'":"" }  >
			<label class="label-text">是否为Flash：</label>
			<div class="label-box form-inline">
				<label class="radio" style="margin-right:10px"><input type="radio" name="valIsflash" value="1"  ${json.obj.isflash==1?"checked":"" }  >是</label>
				<label class="radio" style="margin-right:10px"><input type="radio" name="valIsflash" value="0" ${json.obj.isflash==0?"checked":"" } >否</label>
				<span class="txt">[<a href="javascript:;" rel="tooltip" title="如何设置为Flash应用，当窗口非当前窗口时，会显示遮罩层">?</a>]</span>
			</div>
		</div>
	</div>
</div>
<div class="bottom-bar">
	<div class="con">
		<a class="btn fr" href="javascript:window.parent.$.dialog.list['editdialog'].close();"><i class="icon-remove"></i> 关闭</a>
		<a class="btn btn-primary fr" id="btn-submit" href="javascript:;" style="margin-right:10px"><i class="icon-white icon-ok"></i> 确定</a>
	</div>
</div>
</form>
<jsp:include page="_portal_js.jsp"></jsp:include>
<script>
$(function(){
	$('#form').Validform({
		btnSubmit: '#btn-submit',
		postonce: false,
		showAllError: true,
		//msg：提示信息;
		//o:{obj:*,type:*,curform:*}, obj指向的是当前验证的表单元素（或表单对象），type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, curform为当前form对象;
		//cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
		tiptype: function(msg, o){
			if(!o.obj.is('form')){//验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
				var B = o.obj.parents('.control-group');
				var T = B.children('.help-inline');
				if(o.type == 2){
					B.removeClass('error');
					T.text('');
				}else{
					B.addClass('error');
					T.text(msg);
				}
			}
		},
		ajaxPost: true,
		callback: function(data){
			if(data.status == 'y'){
				window.parent.HROS.app.get();
				window.parent.$.dialog.list['editdialog'].close();
			}
		}
	});
	$('input[name="valType"]').change(function(){
		if($(this).val() == 'papp'){
			$('.input-label-isresize, .input-label-isopenmax, .input-label-isflash').slideDown();
		}else{
			$('input[name="valIsresize"]').each(function(){
				if($(this).val() == '1'){
					$(this).prop('checked', true);
				}
			});
			$('input[name="valIsopenmax"]').each(function(){
				if($(this).val() == '0'){
					$(this).prop('checked', true);
				}
			});
			$('input[name="valIsflash"]').each(function(){
				if($(this).val() == '0'){
					$(this).prop('checked', true);
				}
			});
			$('.input-label-isresize, .input-label-isopenmax, .input-label-isflash').slideUp();
		}
	});
	$('input[name="valIsresize"]').change(function(){
		if($(this).val() == '1'){
			$('.input-label-isopenmax').slideDown();
		}else{
			$('.input-label-isopenmax').slideUp();
		}
	});
	//选择图标
	$('.shortcut-selicon a').click(function(){
		$('.shortcut-addicon img').remove();
		$('.shortcut-addicon').addClass('bgnone').append($(this).html());
		$('#valIcon').val($(this).children('img').attr('valsrc')).focusout();
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
		fd.append('remarks', "pappicon");
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
						$('.shortcut-addicon img').remove();
						$('.shortcut-addicon').addClass('bgnone').append('<img src="' + window.parent.HROS.CONFIG.downloadImage+ result.obj.id + '" />');
						$('#valIcon').val(result.obj.id).focusout();
					}else{
						ZENG.msgbox.show(result.msg, 5, 2000);
					}
				}
			}, false);
			xhr.open('post', '${dynamicURL}/portal/fileUploadAction/uplaodFile.do', true);
			xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
			xhr.send(fd);
		}
	});
});
</script>
</body>
</html>