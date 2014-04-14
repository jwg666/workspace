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

	public DataGrid taskgrid(LegalCaseQuery legalCaseQuery);

	public LegalCaseQuery getQuery(Long id);

	public String completTask(LegalCaseQuery legalCaseQuery);
    /**
     * @param 添加信息并启动工作流
     */
    public void addAndStart(LegalCaseQuery legalCaseQuery);
	/**
	 * @param query
	 * @return 查询审核已办理任务
	 */
	public  DataGrid getyiban(LegalCaseQuery query);
	/**
	 * @param query
	 * @return 案件申请维护界面查询
	 */
	public DataGrid applicantDatagrid(LegalCaseQuery query);
	/**
	 * @param legalCaseQuery
	 * 将指派的律师事务所放到case表并将律师事务所的id存到工作流中
	 */
	public void completeTaskAndPutlegalIdToCase(LegalCaseQuery legalCaseQuery);
}
