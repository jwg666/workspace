package com.neusoft.activiti.service;

import java.util.List;
import java.util.Map;

import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;

import com.neusoft.activiti.domain.WfProcinstance;
import com.neusoft.activiti.query.WfProcinstanceQuery;
import com.neusoft.base.model.DataGrid;
public interface WfProcinstanceService{

	/**
	 * 获得数据表格
	 * 
	 * @param bug
	 * @return
	 */
	public DataGrid datagrid(WfProcinstanceQuery wfProcinstanceQuery);

	/**
	 * 添加
	 * 
	 * @param wfProcinstanceQuery
	 */
	public WfProcinstance add(WfProcinstanceQuery wfProcinstanceQuery);

	/**
	 * 修改
	 * 
	 * @param wfProcinstanceQuery
	 */
	public void update(WfProcinstanceQuery wfProcinstanceQuery) ;
	

	/**
	 * 删除
	 * 
	 * @param ids
	 */
	public void delete(java.lang.String[] ids);

	/**
	 * 获得
	 * 
	 * @param WfProcinstance
	 * @return
	 */
	public WfProcinstance get(WfProcinstanceQuery wfProcinstanceQuery);
	
	/**
	 * 
	 *作者：罗琦
	 * @param businFormId
	 * @return
	 */
	public WfProcinstance findProidByBusid(Map map);
	/**
	 * @author huangxq
	 * @param businformId 业务表单Id
	 * @param businformType 业务表单类型
	 * @param processdefinitionKey 流程定义Key（）
	 * @param status 流程状态 1：正在进行 0：已经结束
	 * @date 2013-7-10
	 */
	public String findProcinstanceId(String businformId,String businformType,String processdefinitionKey,String status);
	
	/**
	 * 获得
	 * 
	 * @param obid
	 * @return
	 */
	public WfProcinstance get(String id);
	
	/**
	 * 根据业务表单Id查询流程实例
	 * @param businformId 业务表单Id
	 * @param businformType 业务表单类型
	 * @param processdefinitionKey 流程定义Key（）
	 * @return
	 */
	public ProcessInstance getTaskFromBusinId(String businformId,String businformType,String processdefinitionKey);
	/**
	 * 根据业务表单Id查询任务
	 * @param businformId 业务表单Id
	 * @param businformType 业务表单类型
	 * @param processdefinitionKey 流程定义Key（）
	 * @param userId 用户id
	 * @param taskDefinitionKey 任务节点Id
	 * @return
	 */
	public Task getTaskFromBusinId(String businformId,String businformType,String processdefinitionKey,Long userId,String taskDefinitionKey);
	/**
	 * 根据业务表单Id查询任务
	 * @param businformId 业务表单Id
	 * @param businformType 业务表单类型
	 * @param processdefinitionKey 流程定义Key（）
	 * @param userId 用户Code
	 * @param taskDefinitionKey 任务节点Id
	 * @return
	 */
	public Task getTaskByBusinId(String businformId, String businformType,
			String processdefinitionKey, String userCode,String taskDefinitionKey );
	/**
	 * 再未知任务节点的情况下，根据表单Id查询任务
	 * @param businformId
	 * @param businformType
	 * @param processdefinitionKey
	 * @param userId
	 * @return
	 */
	public Task getTaskFromBusinId(String businformId,String businformType,String processdefinitionKey,Long userId);
	
	/**
	 * 获取所有数据
	 */
	public List<WfProcinstanceQuery> listAll(WfProcinstanceQuery wfProcinstanceQuery);
	/**
	 * 根据业务表单Id查询用户组任务
	 * @param businformId 业务表单Id
	 * @param businformType 业务表单类型
	 * @param processdefinitionKey 流程定义Key（）
	 * @param groupId 组id
	 * @param taskDefinitionKey 任务节点Id
	 * @return
	 */
	public Task getGroupTaskFromBusinId(String businformId, String businformType,
			String processdefinitionKey, Long groupId,String taskDefinitionKey );
	
}
