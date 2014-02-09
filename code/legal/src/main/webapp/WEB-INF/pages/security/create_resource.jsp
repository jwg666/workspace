<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="hop" uri="/hoptree-tags" %>
<%@ taglib prefix="security" uri="/security-tags" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.thd">
<page:apply-decorator name="content">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>创建资源</title>
<link rel="stylesheet" href="${staticURL}/style/hopCss/hop.css" type="text/css">
<script type="text/javascript" src="${staticURL}/scripts/hop.js"></script>
<script type="text/javascript" src="${staticURL}/scripts/jquery.ztree.all-3.5.js"></script>
<script>
$.ajaxSetup({
	dataType : 'json'
});
//此函数为ztree中callback函数，请确保该函数定义在hop:tree之前，一般定义在<head>的<script>中即可
function zTreeOnCheck(event, treeId, treeNode) {
	$("#parent_menu_id").val(treeNode.id);
}
</script>
</head>
<body>
<dt>
	<h3>创建资源</h3>
</dt>
<dd class="tab1">
<jsp:include page="/common/messages.jsp"/>
	<s:form action="createResource" namespace="/security" method="post" id="createResource">
        <table class="form_table">
            <tr>
                <th>资源名称<span class="star">*</span>:</th>
                <td><s:textfield name="resource.name" size="54" /></td>
            </tr>
            <tr>
                <th>父资源:</th>
                <td>
                	<s:hidden name="resource.parent.id" id="parent_menu_id"/>
                	<hop:tree url="${dynamicURL}/security/resourceTree.do?id=0"
						expandUrl="${dynamicURL}/security/resourceTree.do" 
						async="true" 
						chkType="radio" 
						id="resourceTree"
						setting="{check: {enable: true, chkStyle: 'radio', radioType: 'all'}, data: {simpleData: { enable: true}}, async: {enable:true, url: getTreeExpandUrl},callback:{onCheck: zTreeOnCheck} };"
						>
					</hop:tree>
                </td>
            </tr>
            <tr>
                <th>所在模块<span class="star">*</span>:</th>
                <td>
                	<s:select name="resource.moduleName" list="modules"/><label>模块名与链接的namespace保持一致</label>
                </td>
            </tr>
            <tr>
                <th>访问链接:</th>
                <td><s:textfield name="resource.url" size="54"/></td>
            </tr>
            <tr>
                <th>是否在左侧菜单展示<span class="star">*</span>:</th>
                <td><s:select name="resource.status" list="#{1:'是',0:'否'}"/>
                	<label>只有状态为显示并且类型为URL资源的资源才可以展示在左侧菜单中</label>
                </td>
            </tr>
            <tr>
                <th>资源类型<span class="star">*</span>:</th>
                <td><s:select name="resource.type" list="#{0:'URL资源',1:'组件资源',2:'待办资源',3:'桌面组件'}"/></td>
            </tr>
            <tr>
                <th>标示码:</th>
                <td><s:textfield name="resource.code" size="54"/>
                	<label>为每个资源定义唯一的code(身份证)</label>
                </td>
            </tr>
            <tr>
                <th>配置项:</th>
                <td>
                	<s:textarea name="resource.configuration" rows="5" cols="45"></s:textarea>
                </td>
            </tr>
            <tr>
                <th>描述:</th>
                <td>
                	<s:textarea name="resource.description" rows="5" cols="45"></s:textarea>
                </td>
            </tr>
            <tr>
            	<th>序号<span class="star">*</span>:</th>
            	<td>
            		<s:textfield name="resource.orderIndex" size="54"></s:textfield>
            		<label>排序号越小的资源显示越靠前</label>
            	</td>
            </tr>
            <tr>
            	<th>资源属性<span class="star">*</span>:</th>
            	<td>
            	    <label>宽度</label>
            	    <s:textfield name="resource.width" size="20"></s:textfield>&nbsp;&nbsp;&nbsp;
            	    <label>高度</label>
            	    <s:textfield name="resource.height" size="20"></s:textfield>
            	    <label>用于设置桌面窗口大小</label>
            	</td>
            </tr>
            <tr>
            	<th>资源图标:</th>
            	<td>
            		<input name="resource.iconUrl" size="54" readonly="readonly">
            	    <button id="uploadImg">选择图片</button>
            		<label>用于设置应用桌面显示图标</label>
            	</td>
            </tr>
            <tr>
                <td colspan="2"><sj:submit value="创建" id="submit"
							targets="formResult" 
							onCompleteTopics="handleResult" cssClass="abn"/><input type="reset" value="重置" class="abn"/></td>
            </tr>
        </table>
	</s:form>
</dd>
<script type="text/javascript">
	$.subscribe('handleResult',function(event, data) {
		handleErrors(event,data,{
			onSuccess : function() {
				window.location.href = '${dynamicURL}/security/searchResource.do';
			}
		});
	});

	$(document).ready(function(){
		new AjaxUpload('uploadImg', {
	        action: '${dynamicURL}/basic/fileUploadAction/uplaodFile.do',
	        name:'upload',
	        data: {remarks:'appicon'},
	        responseType:'json',
			onSubmit : function(file , ext){
	            // Allow only images. You should add security check on the server-side.
				if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)){
					/* Setting data */
					this.setData({
						'remarks' : "appicon"//备注
					}); 					
				} else {					
					// extension is not allowed
					alert('Error: only images are allowed');
					// cancel upload
					return false;				
				}		
			},
			onComplete : function(file,data){
				$("[name='resource.iconUrl']").val(data.obj.id);				
			}		
		});
	});
</script>
<script src="${staticURL}/scripts/ajaxfileupload_.js"></script>
</body>
</html>
</page:apply-decorator>