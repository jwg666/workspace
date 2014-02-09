package com.neusoft.activiti.service;

import java.util.List;

import com.neusoft.activiti.domain.TransitionRecord;
import com.neusoft.activiti.query.TransitionRecordQuery;
import com.neusoft.base.model.DataGrid;
public interface TransitionRecordService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(TransitionRecordQuery transitionRecordQuery);

	/**
	 * 添加
	 * 
	 * @param transitionRecordQuery
	 */
	public TransitionRecord add(TransitionRecordQuery transitionRecordQuery);

	/**
	 * 修改
	 * 
	 * @param transitionRecordQuery
	 */
	public void update(TransitionRecordQuery transitionRecordQuery) ;
	

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.String[] ids);

	/**
	 * 获得
	 * 
	 * @param TransitionRecord
	 * @return
	 */
	public TransitionRecord get(TransitionRecordQuery transitionRecordQuery);
	
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public TransitionRecord get(String id);
	
	/**
	 * 获取所有数据
	 */
	public List<TransitionRecordQuery> listAll(TransitionRecordQuery transitionRecordQuery);

	/**
	 * 
	 * 记录审批意见
	 * 
	 * @param processInstanceId 流程实例ID
	 * @param sourceId 原流程ID
	 * @param destId   目标流程ID
	 * @param assgin   办理人
	 * @param attachment 附件ID
	 * @param comments   备注，审批意见
	 * @return
	 */
	public TransitionRecord add(String processInstanceId,String sourceId,String destId,String assgin,String attachment,String comments);
	
	/**
	 * 
	 * @param bussid     业务id(多个时用","隔开)
	 * @param sourceId   源节点ID
	 * @param destId     目标节点ID
	 * @param assgin     办理人
	 * @param attachment 附件ID
	 * @param comments   备注
	 */
	public void addByBussid(String bussid,String sourceId,String destId,String assgin,String attachment,String comments);
	
}
