/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.security.domain.UserRole;
import com.neusoft.security.query.UserRoleQuery;
public interface UserRoleService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(UserRoleQuery userRoleQuery);

	/**
	 * 添加
	 * 
	 * @param userRoleQuery
	 */
	public void add(UserRoleQuery userRoleQuery);

	/**
	 * 修改
	 * 
	 * @param userRoleQuery
	 */
	public void update(UserRoleQuery userRoleQuery) ;
	

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param UserRole
	 * @return
	 */
	public UserRole get(UserRoleQuery userRoleQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public UserRole get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<UserRoleQuery> listAll(UserRoleQuery userRoleQuery);

	
	
}
