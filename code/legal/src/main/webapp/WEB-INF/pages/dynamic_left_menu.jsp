<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!--我的应用-->
<dl>
<dd class="user-app">
<s:iterator value="resources" var="resource">
<s:if test="#resource.type==0 && #resource.status==1"><!-- 仅显示菜单类资源;并且状态为非隐藏 -->
		<h2><s class="ico-1"></s><a href="${dynamicURL}<s:property value="url"/>"><s:property value="name"/></a></h2>
</s:if>
</s:iterator>
</dd>
</dl>
<script type="text/javascript">
$(document).ready(function () {
	highlightLeftMenu();
});
</script>
