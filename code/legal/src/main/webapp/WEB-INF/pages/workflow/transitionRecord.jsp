<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
    textarea { font-size:13px;}
</style>
</head>
<body>

<script src="${staticURL}/scripts/ajaxfileupload_.js"></script>
<script type="text/javascript">
new AjaxUpload('uploadFile', {
    action: '${dynamicURL}/basic/fileUploadAction/uplaodFile.do',
    name:'upload',
    data: {remarks:'appicon'},
    responseType:'json',
	onSubmit : function(file , ext){
        // Allow only images. You should add security check on the server-side.
		if (ext && !/^(exe|bat)$/.test(ext)){
			/* Setting data */
		} else {					
			// extension is not allowed
			$.messager.alert("系统警告",'非法文件禁止上传！');
			// cancel upload
			return false;				
		}		
	},
	onComplete : function(file,data){
		$("#attachment").val(data.obj.id);
		$("#fileName").text(file);				
	}		
});
</script>
<form id="transitionRecord" action="${dynamicURL}/workflow/transitionRecordAction!record.do">
  <div>
      <textarea class="easyui-validatebox" data-options="required:true"  name="comments" rows="5" cols="46" style="font-size:13px"></textarea>
  </div>
  <div>
      <input id="attachment" type="hidden" style="vertical-align: middle;"/>
      <label id="fileName">可上传附件</label>
      <a href="#" id="uploadFile" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'"></a>
  </div>
</form>
</body>
</html>