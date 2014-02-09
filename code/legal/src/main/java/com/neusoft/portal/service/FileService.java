

package com.neusoft.portal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.model.File;
import com.neusoft.portal.query.FileQuery;
public interface FileService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(FileQuery fileQuery);

	/**
	 * 添加
	 * 
	 * @param fileQuery
	 */
	public void add(FileQuery fileQuery);

	/**
	 * 修改
	 * 
	 * @param fileQuery
	 */
	public void update(FileQuery fileQuery) ;

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param File
	 * @return
	 */
	public File get(FileQuery fileQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public File get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<FileQuery> listAll(FileQuery fileQuery);

	
	
}
