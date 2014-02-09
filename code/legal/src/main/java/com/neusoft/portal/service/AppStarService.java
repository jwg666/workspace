/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */

package com.neusoft.portal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.model.AppStar;
import com.neusoft.portal.query.AppStarQuery;

public interface AppStarService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(AppStarQuery appStarQuery);

	/**
	 * 添加
	 * 
	 * @param appStarQuery
	 */
	public void add(AppStarQuery appStarQuery);

	/**
	 * 修改
	 * 
	 * @param appStarQuery
	 */
	public void update(AppStarQuery appStarQuery) ;

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param AppStar
	 * @return
	 */
	public AppStar get(AppStarQuery appStarQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public AppStar get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<AppStarQuery> listAll(AppStarQuery appStarQuery);

	
	
}
