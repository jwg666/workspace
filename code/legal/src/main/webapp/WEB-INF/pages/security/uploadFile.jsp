<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var searchForm;
	var datagrid;
	var upLoadLocalForm;
	var updateForm;
	var uploadDialog;
	var uploadLocalDialog;
	var updateDialog;
	$(function() {
	    //查询列表	
	    searchForm = $('#searchForm').form();
		datagrid = $('#datagrid').datagrid({
			url : '${dynamicURL}/portal/searchUploadFile.do',
			title : '文件列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			rownumbers : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			nowrap : true,
			border : false,
			idField : 'id',
			
			frozenColumns:[ [ 
				{field:'ck',checkbox:true},
				{field:'id',title:'主键',align:'left',width:60,
					formatter:function(value,row,index){
						var iconUrl = fmtIcon(row.contentType);
						if(!iconUrl){
							return row.id;
						}else{
							return row.id+'<img style="height:20px;" src="' + staticURL + iconUrl + '" />';
						}
					}
				},				
				{field:'download',title:'预览',align:'left',width:40,
					formatter:function(value,row,index){
						if(row.status!="1"){
							return '';
						}else if(row.contentType != null && row.contentType.indexOf("image")>-1){
							return '<a href="${dynamicURL}/portal/uploadFileAction/downloadImage.do?fileId=' + row.id + '" target="_blank"  ><img style="height:20px;" src="${dynamicURL}/portal/uploadFileAction/downloadImage.do?fileId='+ row.id +  '"/></a>';
						}else{
							return '<a href="${dynamicURL}/portal/fileUploadAction/downloadFile.do?fileId='+row.id+'" target="_blank" >下载 </a>';
							
						}
						var iconUrl = fmtIcon(row.contentType);
						if(!iconUrl){
							return row.id;
						}else{
							return row.id+'<img style="height:20px;" src="' + staticURL + iconUrl + '" />';
						}
					}
				},				
				{field:'fileName',title:'文件名',align:'center',width:200,
					formatter:function(value,row,index){
						if(row.contentType != null && row.contentType.indexOf("image")>-1){
							return '<a href="${dynamicURL}/portal/uploadFileAction/downloadImage.do?fileId=' + row.id + '" target="_blank"  >' + row.fileName + '</a>';
						}else{
							return row.fileName;
						}
					}
				},
				{field:'type',title:'文件存储地址',align:'center',width:90,
					formatter:function(value,row,index){
						if(row.type=="2"){
							return "文件服务器";
						}else if(row.type=="1") {
							return "web服务器";
						}
					}
				},
				{field:'remarks',title:'备注',align:'center',width:90,
					formatter:function(value,row,index){
						return value;
					}
				},
				{field:'status',title:'文件状态',align:'center',width:90,
					formatter:function(value,row,index){
						if(row.status=="1"){
							return "有效";
						}else{
							return "无效";
						}
					}
				}
			] ],
			columns : [ [ 
	            {field:'createBy',title:'创建人',align:'center',width:90,
					formatter:function(value,row,index){
						return row.createBy;
					}
				},				
			   {field:'createDate',title:'创建时间',align:'center',width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.createDate);
					}
				},
			   {field:'lastModifiedBy',title:'最后修改人',align:'center',width:100,
					formatter:function(value,row,index){
						return row.lastModifiedBy;
					}
				},				
			   {field:'lastupdDate',title:'最后修改时间',align:'center',width:100,
					formatter:function(value,row,index){
						return dateFormatYMD(row.lastupdDate);
					}
				},				
				{field:'contentType',title:'contentType',align:'center',width:250,
					formatter:function(value,row,index){
						return row.contentType;
					}
				},
				{field:'saveFileName',title:'实际保存的文件名',align:'center',width:250,
					formatter:function(value,row,index){
						return row.saveFileName;
					}
				},				
				{field:'filePath1',title:'文件保存路径',align:'center',width:300,
					formatter:function(value,row,index){
						return row.filePath1;
					}
				}
			 ] ],
			toolbar : [  {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					del();
				}
			}, '-', {
				text : '上传到文件服务器',
				iconCls : 'icon-add',
				handler : function() {
					upload();
				}
			}, '-',{
				text : '上传到web服务器',
				iconCls : 'icon-add',
				handler : function() {
					uploadLocal();
				}
			}, '-',{
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					update();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ]
		});

		
		uploadDialog = $('#uploadDialog').show().dialog({
	    	title : '上传',
	    	modal : true,
	    	closed : true,
	    	collapsible : true,
	    	buttons : [{
		    		text : '上传',
		    		handler : function() {
						upLoadForm.submit();
					}
	    		}]
	    });
		upLoadForm = $('#upLoadForm').form({
			url : '${dynamicURL}/portal/uploadFileAction/uplaodFile.do',
			success:function(data) {
				var json = $.parseJSON(data);
				var obj = json.obj;
				if (json && json.success) {
					$.messager.progress('close');
					$.messager.show({
						title : '成功',
						msg : '上传成功'
					});
					datagrid.datagrid('load');
					uploadDialog.dialog('close');
				} else {
					$.messager.progress('close');
					$.messager.show({
						title : '失败',
						msg : '上传失败'
					});
				}
			}
		});
		uploadLocalDialog = $('#uploadLocalDialog').show().dialog({
	    	title : '上传',
	    	modal : true,
	    	closed : true,
	    	collapsible : true,
	    	buttons : [{
		    		text : '上传',
		    		handler : function() {
						upLoadLocalForm.submit();
					}
	    		}]
	    });
		upLoadLocalForm = $('#upLoadLocalForm').form({
			url : '${dynamicURL}/portal/uploadFileAction/uplaodFileToLocal.do',
			success:function(data) {
				var json = $.parseJSON(data);
				var obj = json.obj;
				if (json && json.success) {
					$.messager.progress('close');
					$.messager.show({
						title : '成功',
						msg : '上传成功'
					});
					datagrid.datagrid('load');
					uploadLocalDialog.dialog('close');
				} else {
					$.messager.progress('close');
					$.messager.show({
						title : '失败',
						msg : '上传失败'
					});
				}
			}
		});
		updateDialog = $('#updateFileDialog').show().dialog({
	    	title : '上传',
	    	modal : true,
	    	closed : true,
	    	collapsible : true,
	    	buttons : [{
		    		text : '上传',
		    		handler : function() {
		    			updateForm.submit();
					}
	    		}]
	    });
		updateForm = $('#updateFileForm').form({
			url : '${dynamicURL}/portal/uploadFileAction/updateFile.do',
			success:function(data) {
				var json = $.parseJSON(data);
				var obj = json.obj;
				if (json && json.success) {
					$.messager.progress('close');
					$.messager.show({
						title : '成功',
						msg : '上传成功'
					});
					datagrid.datagrid('load');
					updateDialog.dialog('close');
				} else {
					$.messager.progress('close');
					$.messager.show({
						title : '失败',
						msg : '上传失败'
					});
				}
			}
		});
	});

	function _search() {
		datagrid.datagrid("unselectAll");
		datagrid.datagrid('load', sy.serializeObject(searchForm));
	}
	function cleanSearch() {
		datagrid.datagrid("unselectAll");
		datagrid.datagrid('load', {});
		searchForm.form('clear');
	}

	function del() {
		var rows = datagrid.datagrid('getSelections');
		var fileids = "";
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前文件？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						if(i!=rows.length-1)
							fileids=fileids+rows[i].id+",";
						else fileids=fileids+rows[i].id;
					}
					$.ajax({
						url : '${dynamicURL}/portal/uploadFileAction/deleteFile.do',
						data : {"fileids" : fileids},
						dataType : 'json',
						success : function(response) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的文件！', 'error');
		}
	}

	function upload() {
		upLoadForm.form("clear");
		uploadDialog.dialog('open');
	}
	function uploadLocal() {
		upLoadLocalForm.form("clear");
		uploadLocalDialog.dialog('open');
	}
	function update() {
		updateForm.form("clear");
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			$("#fileId").val(rows[0].id);
			$("#remarks_update").val(rows[0].remarks);
			updateDialog.dialog('open');
		} else {
			$.messager.alert('提示', '请选择一条记录', 'error');
		}
	}
	function fmtIcon(contentType){
		if(contentType!=null && contentType.length>0){
			if(contentType.indexOf('word') > -1 ||	contentType.indexOf('wps')>-1){
				return "/portal/img/ui/file_word.png";
			}else if(contentType.indexOf('excel') > -1){
				return "/portal/img/ui/file_excel.png";
			}else if(contentType.indexOf('pdf') > -1){
				return "/portal/img/ui/file_pdf.png";
			}else if(contentType.indexOf('powerpoint') > -1){
				return "/portal/img/ui/file_ppt.png";	
			}else if(contentType.indexOf('text/plain') > -1){
				return "/portal/img/ui/file_txt.png";
			/* }else if(contentType.indexOf('image') > -1){
				return "/portal/img/ui/file_image.png"; */
			}
		}
		return false;
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" class="zoc" border="false" title="过滤条件" collapsed="true"  style="height: 90px;overflow: hidden;" align="left">
		<form id="searchForm">
			<div class="partnavi_zoc"><span>查询与操作：</span></div>
	            <div class="oneline">
	                <div class="item25">
	                    <div class="itemleft60">文件名：</div>
	                    <div class="righttext">
	                    	 <input name="filename" type="text"/>
	                    </div>
	                </div>
	                <div class="item25">
	                    <div class="itemleft60">备注：</div>
	                    <div class="righttext">
	                    	 <select name="remarks">
	                    	 	<option value="">全部</option>
						    	<option value="wallpaper">壁纸</option>
						    	<option value="icon">图标</option>
						    	<option value="sign">印章</option>
						     </select>
	                    </div>
	                    
	                </div>
	                <div class="item25">
	                    <div class="itemleft60">文件存放位置：</div>
	                    <div class="righttext_easyui">
	                    	<select name="type" style="width:155px;">
								<option value="">全部</option>
								<option value="2">文件服务器</option>
								<option value="1">web服务器</option>	                    	
	                    	</select>
						</div>
	                </div>
	                <div class="item25">
	                   <div class="itemleft60">文件状态：</div>
	                   <div class="righttext_easyui">
					   		<select name="status" style="width:155px;" >
								<option value="">全部</option>
								<option value="1">有效</option>
								<option value="2">无效</option>	                    	
	                    	</select>
					   </div>
	                </div>
	                <div class="item25 lastitem">
				   		<div class="oprationbutt">
	                       <input type="button" onclick="_search()" value="过滤" />
	                       <input type="button" onclick="cleanSearch()" value="重置" />
		              	</div>
	                </div>
	             </div>
		</form>
	</div>
	<div region="center" border="false">
		<table id="datagrid"></table>
	</div>
	<div id="uploadDialog" style="display: none;width: 400px;height: 150px;" align="center">
		<form id="upLoadForm" method="post" enctype="multipart/form-data">
		    <table >
				<tr>
					<th>上传文件:</th>
					<td>
					    <s:file name="upload"></s:file>
					</td>
				</tr>
				<tr>
					<th>文件名称:</th>
					<td>
					    <s:textfield  name="fileName"></s:textfield >
					</td>
				</tr>
				<tr>
					<th>备注:</th>
					<td>
						<select name="remarks">
					    	<option value="wallpaper">壁纸</option>
					    	<option value="icon">图标</option>
					    	<option value="sign">印章</option>
					    </select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="uploadLocalDialog" style="display: none;width: 400px;height: 150px;" align="center">
		<form id="upLoadLocalForm" method="post" enctype="multipart/form-data">
		    <table >
				<tr>
					<th>上传文件:</th>
					<td>
					    <s:file name="upload"></s:file>
					</td>
				</tr>
				<tr>
					<th>文件名称:</th>
					<td>
					    <s:textfield  name="fileName"></s:textfield >
					</td>
				</tr>
				
				<tr>
					<th>备注:</th>
					<td>
						<select name="remarks">
					    	<option value="wallpaper">壁纸</option>
					    	<option value="icon">图标</option>
					    	<option value="sign">印章</option>
					    </select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="updateFileDialog" style="display: none;width: 400px;height: 150px;" align="center">
		<form id="updateFileForm" method="post" enctype="multipart/form-data">
		    <table >
				<tr>
					<th>上传文件:</th>
					<td>
						<input id="fileId" name="fileId" type="hidden" />
					    <s:file id="upload" name="upload"></s:file>
					</td>
				</tr>
				<tr>
					<th>文件名称:</th>
					<td>
					    <s:textfield  name="fileName" ></s:textfield >
					</td>
				</tr>
				<tr>
					<th>备注:</th>
					<td>
					    <select name="remarks">
					    	<option value="wallpaper">壁纸</option>
					    	<option value="icon">图标</option>
					    	<option value="sign">印章</option>
					    </select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>