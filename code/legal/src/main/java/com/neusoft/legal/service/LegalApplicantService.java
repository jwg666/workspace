/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.service;

import java.util.List;

import com.neusoft.base.model.DataGrid;
import com.neusoft.legal.domain.LegalApplicant;
import com.neusoft.legal.query.LegalApplicantQuery;
public interface LegalApplicantService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(LegalApplicantQuery legalApplicantQuery);

	/**
	 * 添加
	 * 
	 * @param legalApplicantQuery
	 */
	public Long add(LegalApplicantQuery legalApplicantQuery);

	/**
	 * 修改
	 * 
	 * @param legalApplicantQuery
	 */
	public void update(LegalApplicantQuery legalApplicantQuery) ;
	

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.Long[] ids);

	/**
	 * 获得
	 * 
	 * @param LegalApplicant
	 * @return
	 */
	public LegalApplicant get(LegalApplicantQuery legalApplicantQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public LegalApplicant get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<LegalApplicantQuery> listAll(LegalApplicantQuery legalApplicantQuery);

	public LegalApplicantQuery getQuery(Long applicantId);

	
	
}
