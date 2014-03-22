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
import com.neusoft.security.domain.UserRole;
import com.neusoft.security.query.UserRoleQuery;
import com.neusoft.security.service.UserRoleService;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class UserRoleAction extends BaseAction implements ModelDriven<UserRoleQuery>{
	
	@Resource
	private UserRoleService userRoleService;
	
	private UserRoleQuery userRoleQuery = new UserRoleQuery();
	private UserRole userRole;
	private DataGrid datagrid;
	private List<UserRoleQuery>  userRoleList = new ArrayList<UserRoleQuery>();
	private Json json = new Json();
		
	
	/**
	 * 跳转到UserRole管理页面
	 * 
	 * @return
	 */
	public String goUserRole() {
		return "userRole";
	}
	/**
	 * 跳转到查看desc页面
	 * 
	 * @return
	 */
	public String showDesc() {
		userRole = userRoleService.get(userRoleQuery);
		BeanUtils.copyProperties(userRole, userRoleQuery);
		return "showDesc";
	}

	/**
	 * 获得pageHotel数据表格
	 */
	public String datagrid() {
		datagrid = userRoleService.datagrid(userRoleQuery);
		return "datagrid";
	}
	
	
	/**
	 * 获得无分页的所有数据
	 */
	public String  combox(){
		userRoleList = userRoleService.listAll(userRoleQuery);
		return "userRoleList";
	}

	/**
	 * 添加一个UserRole
	 */
	public String add() {
		userRoleService.add(userRoleQuery);
		json.setSuccess(true);
		json.setObj(userRoleQuery);
		json.setMsg("添加成功！");
		return SUCCESS;
	}

	/**
	 * 编辑UserRole
	 */
	public String edit() {
		userRoleService.update(userRoleQuery);
		json.setSuccess(true);
		json.setObj(userRoleQuery);
		json.setMsg("编辑成功！");
		return SUCCESS;
	}

	/**
	 * 删除UserRole
	 */
	public String delete() {
		userRoleService.delete(userRoleQuery.getIds());
		json.setSuccess(true);
		return SUCCESS;
	}

	@Override
	public UserRoleQuery getModel() {
		return userRoleQuery;
	}
	public UserRoleQuery getUserRoleQuery() {
		return userRoleQuery;
	}
	public void setUserRoleQuery(UserRoleQuery  userRoleQuery) {
		this.userRoleQuery = userRoleQuery;
	}
	
	
	public UserRole getUserRole() {
		return userRole;
	}
	public List<UserRoleQuery> getUserRoleList() {
		return userRoleList;
	}
	public DataGrid getDatagrid() {
		return datagrid;
	}
	public Json getJson() {
		return json;
	}
	
}
