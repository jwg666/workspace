package com.neusoft.security.service;

import java.util.List;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.Role;
import com.neusoft.security.query.RoleQuery;


/**
 * @author WangXuzheng
 *
 */
public interface RoleService {
	
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
	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(RoleQuery roleQuery);

	/**
	 * 添加
	 * 
	 * @param roleQuery
	 */
	public void add(RoleQuery roleQuery);

	/**
	 * 修改
	 * 
	 * @param roleQuery
	 */
	public void update(RoleQuery roleQuery) ;
	

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param Role
	 * @return
	 */
	public Role get(RoleQuery roleQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public Role get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<RoleQuery> listAll(RoleQuery roleQuery);

	
}
