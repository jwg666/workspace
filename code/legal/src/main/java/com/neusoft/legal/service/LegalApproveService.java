/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.legal.domain.LegalApprove;
import com.neusoft.legal.query.LegalApproveQuery;
public interface LegalApproveService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(LegalApproveQuery legalApproveQuery);

	/**
	 * 添加
	 * 
	 * @param legalApproveQuery
	 */
	public Long add(LegalApproveQuery legalApproveQuery);

	/**
	 * 修改
	 * 
	 * @param legalApproveQuery
	 */
	public void update(LegalApproveQuery legalApproveQuery) ;
	

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param LegalApprove
	 * @return
	 */
	public LegalApprove get(LegalApproveQuery legalApproveQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public LegalApprove get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<LegalApproveQuery> listAll(LegalApproveQuery legalApproveQuery);

	public List<LegalApproveQuery> getQueryList(Long caseId);
	public LegalApproveQuery getQuery(Long id);
	
}
