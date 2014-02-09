/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */

package com.neusoft.portal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.model.App;
import com.neusoft.portal.query.AppQuery;

public interface AppService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(AppQuery appQuery);

	/**
	 * 添加
	 * 
	 * @param appQuery
	 */
	public void add(AppQuery appQuery);

	/**
	 * 修改
	 * 
	 * @param appQuery
	 */
	public void update(AppQuery appQuery) ;

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param App
	 * @return
	 */
	public App get(AppQuery appQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public App get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<AppQuery> listAll(AppQuery appQuery);

	
	
}
