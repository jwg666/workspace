
package com.neusoft.portal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.model.Setting;
import com.neusoft.portal.query.SettingQuery;
public interface SettingService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(SettingQuery settingQuery);

	/**
	 * 添加
	 * 
	 * @param settingQuery
	 */
	public void add(SettingQuery settingQuery);

	/**
	 * 修改
	 * 
	 * @param settingQuery
	 */
	public void update(SettingQuery settingQuery) ;

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param Setting
	 * @return
	 */
	public Setting get(SettingQuery settingQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public Setting get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<SettingQuery> listAll(SettingQuery settingQuery);

	
	
}
