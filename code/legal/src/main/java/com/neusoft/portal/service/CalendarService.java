/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */

package com.neusoft.portal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.model.Calendar;
import com.neusoft.portal.query.CalendarQuery;

public interface CalendarService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(CalendarQuery calendarQuery);

	/**
	 * 添加
	 * 
	 * @param calendarQuery
	 */
	public void add(CalendarQuery calendarQuery);

	/**
	 * 修改
	 * 
	 * @param calendarQuery
	 */
	public void update(CalendarQuery calendarQuery) ;

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param Calendar
	 * @return
	 */
	public Calendar get(CalendarQuery calendarQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public Calendar get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<CalendarQuery> listAll(CalendarQuery calendarQuery);

	
	
}
