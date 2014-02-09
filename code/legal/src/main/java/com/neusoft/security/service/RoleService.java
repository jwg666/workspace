package com.neusoft.security.service;

import java.util.List;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.Role;


/**
 * @author WangXuzheng
 *
 */
public interface RoleService {
	/**
	 * 创建角色
	 * @param role
	 * @return
	 */
	public ExecuteResult<Role> createRole(Role role);
	/**
	 * 更新角色
	 * @param role
	 * @return
	 */
	public ExecuteResult<Role> updateRole(Role role);
	
	/**
	 * 删除角色信息
	 * @param roleId
	 * @return
	 */
	public ExecuteResult<Role> deleteRole(Long roleId);
	
	/**
	 * 查询角色信息
	 * @param searchModel
	 * @return
	 */
	public Pager<Role> searchRoles(SearchModel searchModel);
	
	/**
	 * 通过角色id获取角色信息
	 * @param roleId
	 * @return
	 */
	public Role getRoleById(Long roleId);
	
	/**
	 * 获取系统所有角色列表
	 * @return
	 */
	public List<Role> getRoles();
	
	public Pager<Role> getRolesByGroupId(SearchModel model);
}
