<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta charset="utf-8">
<title>桌面设置</title>
<jsp:include page="_portal_css.jsp"></jsp:include>
<link rel="stylesheet" href="${staticURL}/portal/img/ui/sys.css">
<style type="">
	.deskname{
		width: 200px;
		float:left;
		margin:0px 2px; 
		text-align: left;
		list-style-type: decimal ;
	}
	.deskname input.name{
		display:inline-block;
		width: 100px;
		border: #999999 1px solid; 
		overflow:hidden;
		white-space: nowrap;
		text-align: left;
	}
	#desknames li{
		line-height: 35px;
	}
	#desknames li a{
		/* display:inline-block; */
		margin-left: 5px;
	}
	#desknames li a.cancel,#desknames li a.save{
		display: none;
	}
	
</style>
</head>
<body>
	<div class="title">应用码头位置</div>
	<div class="dock_setting">
		<table>
			<!-- <tr>
				<td colspan="3">
					<div class="set_top"><label class="radio"><input type="radio" name="dockpos" value="top" >顶部</label></div>
				</td>
			</tr> -->
			<tr>
				<td width="75">
					<div class="set_left"><label class="radio"><input type="radio" name="dockpos" value="left" ${json.obj=='left'?"checked":""}>左部</label></div>
				</td>
				<td class="set_view set_view_${json.obj}"></td>
				<td width="75">
					<div class="set_right"><label class="radio"><input type="radio" name="dockpos" value="right" ${json.obj=='right'?"checked":""}>右部</label></div>
				</td>
			</tr>
		</table>
	</div>
	<div class="title">设置桌面名称</div>
	<ul id="desknames" style="text-align: center; margin-top: 5px;margin-left:20px; ">
	</ul>
	<ul id="template" style="display: none">
		<li class="deskname" id=""><input type="text" maxlength="10" class="name" readonly="readonly" /><input value="" class="hidden" type="hidden" ></input><a href="javascript:void(0)" class="rename" >重命名</a><a href="javascript:void(0)" class="delete" >删除</a><a href="javascript:void(0)" class="save" >保存</a><a href="javascript:void(0)" class="cancel" >取消</a></li>
	</ul>
<jsp:include page="_portal_js.jsp"></jsp:include>
<script>
var ajaxUrl = window.parent.ajaxUrl;
$(function(){
	$.ajaxSetup({
		type : 'POST',
		dataType:'json',
		cache: false
	});
	$('input[name="dockpos"]').change(function(){
		var pos = $('input[name="dockpos"]:checked').val();
		$('.set_view').removeClass('set_view_top').removeClass('set_view_left').removeClass('set_view_right');
		$('.set_view').addClass('set_view_'+pos);
		window.parent.HROS.dock.updatePos(pos,function(){
			//更新码头位置
			window.parent.HROS.dock.setPos();
			//更新图标位置
			window.parent.HROS.deskTop.appresize();
			//更新滚动条
			window.parent.HROS.app.getScrollbar();
		});
	});
	
	$("#desknames li .rename").live("click",function(){
		var par = $(this).parent();
		par.find("input.name").removeAttr("readonly");
		par.find(".delete").hide();
		par.find(".cancel").show();
		par.find(".save").show();
		$(this).hide();
	});
	$("#desknames li .delete").live("click",function(){
		var desk = $(this).parent().attr("id");
		$.getJSON(ajaxUrl + '?ac=removeDesk&desk='+desk, function(json){
			if(!json.success){
				alert(json.msg);
			}else{
				reloadDesk();
				window.parent.HROS.deskTop.reload();
			}			
		});
	});
	$("#desknames li .add").live("click",function(){
		$.getJSON(ajaxUrl + '?ac=addDesk', function(json){
			if(!json.success){
				alert(json.msg);
			}else{
				reloadDesk();
				window.parent.HROS.deskTop.reload();
			}			
		});
	});
	$("#desknames li .save").live("click",function(){
		var par = $(this).parent();
		var desk = par.attr("id");
		var deskName = par.find("input.name").val();
		if(!deskName || deskName.length<1 ){
			alert("桌面名称不能为空");
			return false;
		}
		if(deskName.length>10 ){
			alert("桌面名称长度不能超过10个字符");
			return false;
		}
		$.getJSON(ajaxUrl + '?ac=updateDesk&desk='+desk,{deskName:deskName},function(json){
			if(!json.success){
				alert(json.msg);
			}else{
				reloadDesk();
				window.parent.HROS.deskTop.reload();
			}			
		});
	});
	$("#desknames li .cancel").live("click",function(){
		var par = $(this).parent();
		var oldValue = par.find("input.hidden").val();  
		par.find("input.name").val(oldValue).attr("readonly","readonly");
		$(this).hide();
		par.find(".save").hide();
		par.find(".delete").show();
		par.find(".rename").show();
	});
	reloadDesk();
});
function reloadDesk(){
	$.getJSON(ajaxUrl + '?ac=loadDeskName', function(json){
		var array = json.obj;
		var desknames = $("#desknames").html("");
		var temp = $("#template li");
		for(var i=0,l=array.length;i<l;i++)
		{
			var li = temp.clone();
			li.attr("id",i+1);
			li.find("input.name").val(array[i]);
			li.find("input.hidden").val(array[i]);
			desknames.append(li);
		}
		if(array.length < 5){
			desknames.append('<li class="deskname"><a href="javascript:void(0)" class="add">增加新桌面</a> </li>');
		}
	});
	
}
</script>
</body>
</html>
