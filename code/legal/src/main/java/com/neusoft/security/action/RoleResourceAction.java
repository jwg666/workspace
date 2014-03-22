/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.neusoft.security.domain.RoleResource;
import com.neusoft.security.query.RoleResourceQuery;
import com.neusoft.security.service.RoleResourceService;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class RoleResourceAction extends BaseAction implements ModelDriven<RoleResourceQuery>{
	
	@Resource
	private RoleResourceService roleResourceService;
	
	private RoleResourceQuery roleResourceQuery = new RoleResourceQuery();
	private RoleResource roleResource;
	private DataGrid datagrid;
	private List<RoleResourceQuery>  roleResourceList = new ArrayList<RoleResourceQuery>();
	private Json json = new Json();
		
	
	/**
	 * 跳转到RoleResource管理页面
	 * 
	 * @return
	 */
	public String goRoleResource() {
		return "roleResource";
	}
	/**
	 * 跳转到查看desc页面
	 * 
	 * @return
	 */
	public String showDesc() {
		roleResource = roleResourceService.get(roleResourceQuery);
		BeanUtils.copyProperties(roleResource, roleResourceQuery);
		return "showDesc";
	}

	/**
	 * 获得pageHotel数据表格
	 */
	public String datagrid() {
		datagrid = roleResourceService.datagrid(roleResourceQuery);
		return "datagrid";
	}
	
	
	/**
	 * 获得无分页的所有数据
	 */
	public String  combox(){
		roleResourceList = roleResourceService.listAll(roleResourceQuery);
		return "roleResourceList";
	}

	/**
	 * 添加一个RoleResource
	 */
	public String add() {
		roleResourceService.add(roleResourceQuery);
		json.setSuccess(true);
		json.setObj(roleResourceQuery);
		json.setMsg("添加成功！");
		return SUCCESS;
	}

	/**
	 * 编辑RoleResource
	 */
	public String edit() {
		roleResourceService.update(roleResourceQuery);
		json.setSuccess(true);
		json.setObj(roleResourceQuery);
		json.setMsg("编辑成功！");
		return SUCCESS;
	}

	/**
	 * 删除RoleResource
	 */
	public String delete() {
		roleResourceService.delete(roleResourceQuery.getIds());
		json.setSuccess(true);
		return SUCCESS;
	}

	@Override
	public RoleResourceQuery getModel() {
		return roleResourceQuery;
	}
	public RoleResourceQuery getRoleResourceQuery() {
		return roleResourceQuery;
	}
	public void setRoleResourceQuery(RoleResourceQuery  roleResourceQuery) {
		this.roleResourceQuery = roleResourceQuery;
	}
	
	
	public RoleResource getRoleResource() {
		return roleResource;
	}
	public List<RoleResourceQuery> getRoleResourceList() {
		return roleResourceList;
	}
	public DataGrid getDatagrid() {
		return datagrid;
	}
	public Json getJson() {
		return json;
	}
	
}
