/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.security.domain.RoleResource;
import com.neusoft.security.query.RoleResourceQuery;
public interface RoleResourceService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(RoleResourceQuery roleResourceQuery);

	/**
	 * 添加
	 * 
	 * @param roleResourceQuery
	 */
	public void add(RoleResourceQuery roleResourceQuery);

	/**
	 * 修改
	 * 
	 * @param roleResourceQuery
	 */
	public void update(RoleResourceQuery roleResourceQuery) ;
	

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param RoleResource
	 * @return
	 */
	public RoleResource get(RoleResourceQuery roleResourceQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public RoleResource get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<RoleResourceQuery> listAll(RoleResourceQuery roleResourceQuery);

	
	
}
