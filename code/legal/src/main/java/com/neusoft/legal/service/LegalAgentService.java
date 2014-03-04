/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.legal.domain.LegalAgent;
import com.neusoft.legal.query.LegalAgentQuery;
public interface LegalAgentService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(LegalAgentQuery legalAgentQuery);

	/**
	 * 添加
	 * 
	 * @param legalAgentQuery
	 */
	public Long add(LegalAgentQuery legalAgentQuery);

	/**
	 * 修改
	 * 
	 * @param legalAgentQuery
	 */
	public void update(LegalAgentQuery legalAgentQuery) ;
	

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param LegalAgent
	 * @return
	 */
	public LegalAgent get(LegalAgentQuery legalAgentQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public LegalAgent get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<LegalAgentQuery> listAll(LegalAgentQuery legalAgentQuery);

	
	
}
