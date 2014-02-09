<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="p" uri="/pagination-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="hop" uri="/hoptree-tags" %>
<%@ taglib prefix="security" uri="/security-tags" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改资源</title>
<link rel="stylesheet" href="${staticURL}/style/hopCss/hop.css" type="text/css">
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
		<h3>修改资源</h3>
	</dt>
	<dd class="tab1">
		<jsp:include page="/common/messages.jsp" />
		<s:form action="updateResource" namespace="/security" method="post">
			<s:hidden name="resource.id" />
			<table class="form_table">
				<tr>
					<th>名称<span class="star">*</span>:</th>
					<td><s:textfield name="resource.name" size="54" />
					</td>
				</tr>
				<tr>
	                <th>父资源:</th>
	                <td>
						<hop:tree url="${dynamicURL}/security/expandingResourceTree.do?id=0&expandId=${resource.id}"
								expandUrl="${dynamicURL}/security/expandingResourceTree.do" 
								async="true" 
								chkType="radio" 
								id="depTree"
								setting="{check: {enable: true, chkStyle: 'radio', radioType: 'all'}, data: {simpleData: { enable: true}}, async: {enable:true, url: getTreeExpandUrl},callback:{onCheck: zTreeOnCheck} };"
								>
						</hop:tree>
	                	<s:hidden name="resource.parent.id" id="parent_menu_id"/>
	                </td>
	            </tr>
	            <tr>
	                <th>所在模块<span class="star">*</span>:</th>
	                <td>
	                	<s:select name="resource.moduleName" list="modules"/><label>模块名与链接的namespace保持一致</label>
	                </td>
	            </tr>
				<tr>
					<th>链接:</th>
					<td><s:textfield name="resource.url" size="54" />
					</td>
				</tr>
				<tr>
					<th>是否在左侧菜单展示<span class="star">*</span>:</th>
					<td><s:select name="resource.status" list="#{1:'是',0:'否'}" />
						<label>只有状态为显示并且类型为URL资源的资源才可以展示在左侧菜单中</label>
					</td>
				</tr>
				<tr>
					<th>类型<span class="star">*</span>:</th>
					<td><s:select name="resource.type" disabled="true"
							list="#{0:'URL资源',1:'页面组件资源',2:'待办资源',3:'桌面组件'}" />
					</td>
				</tr>
				<tr>
					<th>标示码:</th>
					<td><s:textfield name="resource.code" size="54" disabled="true"/>
						<s:hidden name="resource.code"/>
						<label>为每个资源定义唯一的code(身份证)</label>
					</td>
				</tr>
				<tr>
					<th>配置项:</th>
					<td><s:textarea name="resource.configuration" rows="5"
							cols="45"></s:textarea></td>
				</tr>
				<tr>
					<th>描述:</th>
					<td><s:textarea name="resource.description" rows="5" cols="45"></s:textarea>
					</td>
				</tr>
				<tr>
					<th>序号:</th>
					<td><s:textfield name="resource.orderIndex" size="54"></s:textfield>
					<label>排序号越小的资源显示越靠前</label>
					</td>
				</tr>
				<tr>
					<th>创建时间:</th>
					<td><s:date name="resource.gmtCreate" format="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
				<tr>
					<th>创建者:</th>
					<td><s:property value="resource.createBy"/></td>
				</tr>
				<tr>
					<th>最后修改时间:</th>
					<td><s:date name="resource.gmtModified" format="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
				<tr>
					<th>最后修改者:</th>
					<td><s:property value="resource.lastModifiedBy"/></td>
				</tr>
				<tr>
				    <th>资源属性<span class="star">*</span>:</th>
				    <td>
				        <label>宽度</label>
				        <s:textfield name="resource.width" value="%{resource.width}" size="20"></s:textfield>&nbsp;&nbsp;&nbsp;
				        <label>高度</label>
				        <s:textfield name="resource.height" value="%{resource.height}" size="20"></s:textfield>
				        <label>用于设置桌面窗口大小</label>
				    </td>
				</tr>
                <tr>
            	<th>资源图标:</th>
            	<td>
            	    <input name="resource.iconUrl" value="${resource.iconUrl}" size="54" readonly="readonly">
            	    <button id="uploadImg">选择图片</button>
            		<label>用于设置应用桌面显示图标</label>
            	</td>
				<tr>
					<td colspan="2"><sj:submit value="保存" id="submit"
							targets="formResult" 
							onCompleteTopics="handleResult" cssClass="abn db l" />
					</td>
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
	function findNode(nodes, pId) {
		if(nodes != null) {
			for (var i = 0; i < nodes.length; i++){
				if (nodes[i].id == pId) {
					return nodes[i];
				} else {
					var children = nodes[i].children;
					var found = findNode(children, pId);
					if(found != null) {
						return found;
					}
				}
			}
		}
		return null;
	}
	
	// 选中上级目录
 	$(function () {
		var resourceId = "<s:property value='resource.parent.id'/>";
		var treeObj = $.fn.zTree.getZTreeObj("depTree");
		var nodes = treeObj.getNodes();
		var prt = findNode(nodes, resourceId);	// 查找父节点
		treeObj.checkNode(prt, true);	// 选中父节点
		treeObj.selectNode(prt);	// 选择（高亮显示）节点 
		treeObj.expandNode(prt, true);	// 展开节点
		
    }); 

	$(document).ready(function(){
		new AjaxUpload('uploadImg', {
	        action: '${dynamicURL}/basic/fileUploadAction/uplaodFile.do',
	        name:'upload',
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
<script type="text/javascript" src="${staticURL}/scripts/hop.js"></script>
<script src="${staticURL}/scripts/ajaxfileupload_.js"></script>
</body>
</html>
</page:apply-decorator>