

package com.neusoft.portal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.model.Permission;
import com.neusoft.portal.query.PermissionQuery;
public interface PermissionService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(PermissionQuery permissionQuery);

	/**
	 * 添加
	 * 
	 * @param permissionQuery
	 */
	public void add(PermissionQuery permissionQuery);

	/**
	 * 修改
	 * 
	 * @param permissionQuery
	 */
	public void update(PermissionQuery permissionQuery) ;

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param Permission
	 * @return
	 */
	public Permission get(PermissionQuery permissionQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public Permission get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<PermissionQuery> listAll(PermissionQuery permissionQuery);

	
	
}
