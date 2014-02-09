

package com.neusoft.portal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.model.Pwallpaper;
import com.neusoft.portal.query.PwallpaperQuery;
public interface PwallpaperService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(PwallpaperQuery pwallpaperQuery);

	/**
	 * 添加
	 * 
	 * @param pwallpaperQuery
	 */
	public void add(PwallpaperQuery pwallpaperQuery);

	/**
	 * 修改
	 * 
	 * @param pwallpaperQuery
	 */
	public void update(PwallpaperQuery pwallpaperQuery) ;

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param Pwallpaper
	 * @return
	 */
	public Pwallpaper get(PwallpaperQuery pwallpaperQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public Pwallpaper get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<PwallpaperQuery> listAll(PwallpaperQuery pwallpaperQuery);
	/**
	 * 删除自定义主题
	 */
	public Pwallpaper delete(String id);
	
	
}
