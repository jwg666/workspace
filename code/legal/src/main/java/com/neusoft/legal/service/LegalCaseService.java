/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.legal.domain.LegalCase;
import com.neusoft.legal.query.LegalCaseQuery;
public interface LegalCaseService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(LegalCaseQuery legalCaseQuery);

	/**
	 * 添加
	 * 
	 * @param legalCaseQuery
	 */
	public Long add(LegalCaseQuery legalCaseQuery);

	/**
	 * 修改
	 * 
	 * @param legalCaseQuery
	 */
	public void update(LegalCaseQuery legalCaseQuery) ;
	

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param LegalCase
	 * @return
	 */
	public LegalCase get(LegalCaseQuery legalCaseQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public LegalCase get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<LegalCaseQuery> listAll(LegalCaseQuery legalCaseQuery);

	public void startWorkFlow(LegalCaseQuery legalCaseQuery);

	
	
}
