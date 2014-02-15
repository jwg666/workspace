/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.base.service;

import java.util.List;

import com.neusoft.base.domain.Dictionary;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.query.DictionaryQuery;
public interface DictionaryService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(DictionaryQuery dictionaryQuery);

	/**
	 * 添加
	 * 
	 * @param dictionaryQuery
	 */
	public void add(DictionaryQuery dictionaryQuery);

	/**
	 * 修改
	 * 
	 * @param dictionaryQuery
	 */
	public void update(DictionaryQuery dictionaryQuery) ;
	

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.String[] ids);

	/**
	 * 获得
	 * 
	 * @param Dictionary
	 * @return
	 */
	public Dictionary get(DictionaryQuery dictionaryQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public Dictionary get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<DictionaryQuery> listAll(DictionaryQuery dictionaryQuery);

	
	
}
