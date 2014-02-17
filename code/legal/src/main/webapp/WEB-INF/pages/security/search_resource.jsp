<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="p" uri="/pagination-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="security" uri="/security-tags" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<page:apply-decorator name="content">
<html>
<head>
<title>资源查询</title>
<script type="text/javascript">
	//删除
	function delStation(id) {
		if (!confirm("确定要删除吗？")) {
			return;
		}
		window.location.href = "${dynamicURL}/security/deleteResource.do?resourceId="+ id;
	}
	function creatUser(){
		window.location.href = "${dynamicURL}/security/createResourceInit.do";
	}
</script>
</head>
<body>
	<dt>
		<h3>资源列表</h3>
	</dt>
	<dd class="tab1">
	<jsp:include page="/common/messages.jsp"/>
		<s:form action="searchResource" namespace="/security" method="post"
			id="searchResourceForm">
			<table class="form_table" >
				<tr>
					<th>资源名称：</th>
					<td><s:textfield name="resource.name" />
					</td>
					<th>资源类型：</th>
					<td><select id="typeSL" name="resource.type">
							<option value="">全部</option>
							<option value="0">URL资源</option>
							<option value="1">组件资源</option>
							<option value="2">待办资源</option>
							<option value="3">桌面组件</option>
					</select>
					</td>
					<td><input type="submit" value="查询" class="abn db" />
					&nbsp;&nbsp;<input type="button" value="新建" onclick="creatUser()" class="abn db" />
					</td>
				</tr>
			</table>
		</s:form>
		<br/>
		<s:set name="displayDeleteButton" value="false"/>
		<security:auth code="SECURITY_DELETE_RESOURCE">
			<s:set name="displayDeleteButton" value="true"/>
		</security:auth>
		<table class="color_table">
			<thead>
				<tr>
					<th>资源名称</th>
					<th>资源描述</th>
					<th>标识码</th>
					<th>类型</th>
					<th>状态</th>
					<th>创建时间</th>
					<th>最后修改时间</th>
					<s:if test="#displayDeleteButton==true"><th>操作</th></s:if>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="pager.records" var="resource" status="status">
					<tr>
						<td><a
							href='${dynamicURL}/security/updateResourceInit.do?resource.id=<s:property value="id"/>'>
								<s:property value="name" /> </a>
						</td>
						<td><s:property value="description" />
						</td>
						<td><s:property value="code" />
						</td>
						<td><s:property
								value="@com.neusoft.security.domain.enu.ResourceTypeEnum@toEnum(type).description" />
						</td>
						<td><s:property
								value="@com.neusoft.security.domain.enu.ResourceStatusEnum@toEnum(status).description" />
						</td>
						<td><s:date name="gmtCreate" format="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td><s:date name="gmtModified" format="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<s:if test="#displayDeleteButton==true">
						<td><img
							border="0" title="" alt="" src="${staticURL}/images/trash.png" onclick="delStation(<s:property value="id"/>)">
						</td>
						</s:if>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</dd>
	<dd class="dd-fd">
		<p:pagination pager="pager" formId="searchResourceForm"></p:pagination>
	</dd>
</body>
</html>
</page:apply-decorator>