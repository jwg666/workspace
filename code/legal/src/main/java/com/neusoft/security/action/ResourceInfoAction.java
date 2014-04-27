package com.neusoft.security.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.security.domain.ResourceInfo;
import com.neusoft.security.query.ResourceInfoQuery;
import com.neusoft.security.service.ResourceInfoService;
import com.opensymphony.xwork2.ModelDriven;

@Controller
@Scope("prototype")
public class ResourceInfoAction extends BaseSecurityAction implements ModelDriven<ResourceInfoQuery>{
	private static final long serialVersionUID = 4341140340687999810L;
	@Resource
	private ResourceInfoService resourceInfoService;
	private String state;
	private ResourceInfoQuery resourceInfoQuery = new ResourceInfoQuery();
	
	
	public String goResourceInfo(){
		return "goResourceInfo";
	}
	public String treegrid(){
		datagrid = resourceInfoService.datagrid(resourceInfoQuery);
		return "datagrid";
	}
	public String save(){
		Long id = resourceInfoService.saveOrUpdate(resourceInfoQuery);
		resourceInfoQuery.setId(id);
		json.setObj(resourceInfoQuery);
		json.setMsg("成功");
		json.setSuccess(true);
		return "json";
	}
	public String delete(){
		ExecuteResult<ResourceInfo> result = resourceInfoService.deleteResourceInfo(resourceInfoQuery.getId());
		if(result.getWarningMessages().size()<=0||result.getErrorMessages().size()<=0){
			json.setObj(result);
			json.setMsg("成功");
			json.setSuccess(true);
		}else{
			json.setObj(result);
			json.setMsg("失败");
			json.setSuccess(false);
		}
		
		return "json";
	}
	@Override
	public ResourceInfoQuery getModel() {
		return resourceInfoQuery;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
}
