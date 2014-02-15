/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.base.service;

import java.util.List;

import com.neusoft.base.domain.Department;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.query.DepartmentQuery;
public interface DepartmentService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(DepartmentQuery departmentQuery);

	/**
	 * 添加
	 * 
	 * @param departmentQuery
	 */
	public void add(DepartmentQuery departmentQuery);

	/**
	 * 修改
	 * 
	 * @param departmentQuery
	 */
	public void update(DepartmentQuery departmentQuery) ;
	

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.String[] ids);

	/**
	 * 获得
	 * 
	 * @param Department
	 * @return
	 */
	public Department get(DepartmentQuery departmentQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public Department get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<DepartmentQuery> listAll(DepartmentQuery departmentQuery);

	
	
}
