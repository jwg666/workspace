/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.neusoft.security.domain.Role;
import com.neusoft.security.query.RoleQuery;
import com.neusoft.security.service.RoleService;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class RoleAction extends BaseAction implements ModelDriven<RoleQuery>{
	
	@Resource
	private RoleService roleService;
	
	private RoleQuery roleQuery = new RoleQuery();
	private Role role;
	private DataGrid datagrid;
	private List<RoleQuery>  roleList = new ArrayList<RoleQuery>();
	private Json json = new Json();
		
	
	/**
	 * 跳转到Role管理页面
	 * 
	 * @return
	 */
	public String goRole() {
		return "role";
	}
	/**
	 * 跳转到查看desc页面
	 * 
	 * @return
	 */
	public String showDesc() {
		role = roleService.get(roleQuery);
		BeanUtils.copyProperties(role, roleQuery);
		return "showDesc";
	}

	/**
	 * 获得pageHotel数据表格
	 */
	public String datagrid() {
		datagrid = roleService.datagrid(roleQuery);
		return "datagrid";
	}
	
	
	/**
	 * 获得无分页的所有数据
	 */
	public String  combox(){
		roleList = roleService.listAll(roleQuery);
		return "roleList";
	}

	/**
	 * 添加一个Role
	 */
	public String add() {
		roleService.add(roleQuery);
		json.setSuccess(true);
		json.setObj(roleQuery);
		json.setMsg("添加成功！");
		return SUCCESS;
	}

	/**
	 * 编辑Role
	 */
	public String updateRole() {
/*		role = roleService.get(roleQuery);
		List<Resource> resources = resourceService.getResourceByRole(new Long[]{roleQuery.getId()});
		Set<Resource> resourceSet = new HashSet<Resource>(resources);
		role.setResources(resourceSet);*/
		return "updateRole";
	}

	/**
	 * 删除Role
	 */
	public String delete() {
		roleService.delete(roleQuery.getIds());
		json.setSuccess(true);
		return SUCCESS;
	}

	@Override
	public RoleQuery getModel() {
		return roleQuery;
	}
	public RoleQuery getRoleQuery() {
		return roleQuery;
	}
	public void setRoleQuery(RoleQuery  roleQuery) {
		this.roleQuery = roleQuery;
	}
	
	
	public Role getRole() {
		return role;
	}
	public List<RoleQuery> getRoleList() {
		return roleList;
	}
	public DataGrid getDatagrid() {
		return datagrid;
	}
	public Json getJson() {
		return json;
	}
	
}
