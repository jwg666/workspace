package com.neusoft.portal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.model.Wallpaper;
import com.neusoft.portal.query.WallpaperQuery;
public interface WallpaperService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(WallpaperQuery wallpaperQuery);

	/**
	 * 添加
	 * 
	 * @param wallpaperQuery
	 */
	public void add(WallpaperQuery wallpaperQuery);

	/**
	 * 修改
	 * 
	 * @param wallpaperQuery
	 */
	public void update(WallpaperQuery wallpaperQuery) ;

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param Wallpaper
	 * @return
	 */
	public Wallpaper get(WallpaperQuery wallpaperQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public Wallpaper get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<WallpaperQuery> listAll(WallpaperQuery wallpaperQuery);

	
	
}
