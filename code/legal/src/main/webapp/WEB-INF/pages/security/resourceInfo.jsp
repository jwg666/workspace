<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源管理</title>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript">
    var searchForm;
    var resourceAddDialog;
    var resourceAddForm;
	var treegrid;
	var lastIndex;
	var editId;
	var types = [  
	       {typeId:0,typeName:'应用资源'},  
	       {typeId:1,typeName:'桌面组件'},  
	       {typeId:2,typeName:'待办'}  
	 ];


	$(function(){
		treegrid = $("#treegrid").treegrid({
			loadFilter:function(data){
				return buildTree(data,"parentId","id","name");
			},
		    url:'resourceInfo!findAll.do',
		    idField:'id',
		    treeField:'name',
		    rownumbers: true,
			animate:true,
			collapsible:true,
			fitColumns:true,
			fit:true,
		    columns:[[	
				{field:'ck',checkbox:true,
					formatter:function(value,row,index){
						return row.id;
					}
				},
				{field:'id',title:'ID',width:20},
		        {field:'name',title:'名称',width:100,editor:{type:'text',options:{ required:true}}},
		        {field:'url',title:'URL',width:200,editor:'text'},
		        {field:'code',title:'CODE',width:200,editor:{type:'text',options:{required:true}}},
		        {field:'type',title:'类型',width:200,
		        	editor:{type:'combobox',options:{valueField:'typeId',textField:'typeName',data:types}},
			        formatter:function(value,row,index){
			        	   for(var i=0; i<types.length; i++){  
			        	          if (types[i].typeId == value){
			        	        	  return types[i].typeName; 
			        	          } 
			        	   }  
			        	   return types[0].typeName;        
					}
		        }
		    ]],
            toolbar: [{
                text:'增加',
                iconCls: 'icon-add',
                handler: function(){
                    add();
                }
            },'-',{
                text:'编辑',
                iconCls: 'icon-edit',
                handler: function(){
                    alert('编辑按钮')
                }
            }],
            onContextMenu : function(e, rowIndex) {
				e.preventDefault();				
				$(this).treegrid('select', rowIndex.id);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},
		    onClickRow:function(row){//运用单击事件实现一行的编辑结束，在该事件触发前会先执行onAfterEdit事件  
		        var rowIndex = row.id;  
		        $('#treegrid').treegrid('find', lastIndex);
		        if (lastIndex != rowIndex){  
		         $('#treegrid').treegrid('endEdit', lastIndex);  
		        }  
		    },
		    onDblClickRow:function(row){//运用双击事件实现对一行的编辑  
		        var rowIndex = row.id;  
		        if (lastIndex != rowIndex){  
		         $('#treegrid').treegrid('endEdit', lastIndex);  
		         $('#treegrid').treegrid('beginEdit', rowIndex);  
		         lastIndex = rowIndex;  
		        }  
		    },
		    onBeforeEdit:function(row){  
		              beforEditRow(row);//这里是功能实现的主要步骤和代码  
		    },
		    onAfterEdit:function(row,changes){  
		    	  $.ajax({  
			             url:"resourceInfo!save.do" ,  
			             data: row,  
			             success: function(text){  
			            	$.messager.alert('提示信息',text.msg,'info'); 
			            	treegrid.treegrid('reload');
			             }  
			        }); 
		    }
		});

        resourceAddDialog = $('#resourceAddDialog').show().dialog({
            title : '添加角色',
            modal : true,
            closed : true,
            maximizable : true,
            buttons : [ {
                text : '添加',
                handler : function() {
                    resourceAddForm.submit();
                }
            } ]
        });

    });
	function beforEditRow(row){
		
	}
	function append(){	
		if (editId != undefined){
			$('#treegrid').treegrid('select', editId);
			return;
		}
		var node = $('#treegrid').treegrid('getSelected');
	    $.ajax({  
             url:"resourceInfo!save.do" ,  
             data:{name:"新建记录",parentId:node.id},  
             success: function(response){  
            	 if(response.success){
             		 $('#treegrid').treegrid('append',{
             			parent: response.obj.parentId,
             			data: [{	
             				parentId:response.obj.parentId,
             				name:response.obj.name,
             				id:response.obj.id
             			}]
             		 });
             		 lastIndex = response.obj.id;
             		 $('#treegrid').treegrid('beginEdit', response.obj.id);    
            	 }else{
            		 $.messager.alert('错误信息',response,'error');
            	 }
             }  
        }); 
		
	}
	function removeIt(){
		if (editId != undefined){
			$('#treegrid').treegrid('select', editId);
			return;
		}
		var node = treegrid.treegrid('getSelected');
		if(node){
			$.ajax({  
	            url:"resourceInfo!delete.do" ,  
	            data: {id:node.id},
	            success: function(text){  
	            	treegrid.treegrid('reload');
	             }  
	        });	
		}
	}
	function buildTree(data,parentField,idField,textFiled){
        var i, l, treeData = [], tmpMap = [];
        for (i = 0, l = data.length; i < l; i++) {
            tmpMap[data[i][idField]] = data[i];
            data[i]['text'] = data[i][textFiled];
        }
        for (i = 0, l = data.length; i < l; i++) {
            if (tmpMap[data[i][parentField]] && data[i][idField] != data[i][parentField]) {
                if (!tmpMap[data[i][parentField]]['children']){
                    tmpMap[data[i][parentField]]['children'] = [];
                }
                tmpMap[data[i][parentField]]['children'].push(data[i]);
            } else {
                treeData.push(data[i]);
            }
        }
        return treeData;
    }
    function add(){
        resourceAddForm.form("clear");
        $('div.validatebox-tip').remove();
        resourceAddDialog.dialog('open');
    }
</script>
</head>
<body class="easyui-layout"  data-options="fit:true">
	<div region="center" border="false" >
		<table id="treegrid"></table>
	</div>
	<div id="menu" class="easyui-menu" style="width:120px;">
		<div onclick="append()" data-options="iconCls:'icon-add'">添加</div>
		<div onclick="removeIt()" data-options="iconCls:'icon-remove'">删除</div>
		
	</div>
    <div id="resourceAddDialog" style="display: none;width: 600px;height: 300px;" align="center">
        <form id="resourceAddForm" method="post">
            <div style="width: 500px; height: 160px; margin-left: 20px;">
                <div class="part_popover_zoc" style="width: 500px;">
                    <div class="oneline">
                        <div class="itemleft60">资源名称：</div>
                        <div class="righttext">
                            <input name="name" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写资源名称"  style="width: 155px;"/>
                        </div>
                    </div>
                    <div class="oneline">
                        <div class="itemleft60">url：</div>
                        <div class="righttext">
                            <input name="url" type="text" class="easyui-validatebox" data-options="" missingMessage="请填写资源URL"  style="width: 155px;"/>
                        </div>
                    </div>
                    <div class="oneline">
                        <div class="itemleft60">类型：</div>
                        <div class="righttext">
                            <input name="type" type="text" class="easyui-validatebox" data-options="" missingMessage="请选择资源类型"  style="width: 155px;"/>
                        </div>
                    </div>
                    <div class="oneline">
                        <div class="itemleft60" style="vertical-align: top;">资源描述：</div>
                        <div align="left" style="display: inline-block;width: 300px">
                            <textarea name="description" rows="5"  cols="200" data-options="" missingMessage="请填写资源描述"  style="width: 155px;"/>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>