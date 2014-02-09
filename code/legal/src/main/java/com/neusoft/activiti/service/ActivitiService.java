package com.neusoft.activiti.service;

import java.util.Map;

import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;

public interface ActivitiService {
	
	/**
	 * execution 推进
	 * @param executionId
	 */
	public void signalExecution(String executionId,String empCode);

	/**
	 * 发送催办
	 * @param processInstanceId
	 * @param taskKey
	 */
	public void sendReminders(String processInstanceId, String taskKey);
	/**
	 * 更新节点所属人
	 * @param proinstId
	 * @param orderCode
	 */
	public void updateAssgin(String proinstId,String orderCode);
	
	/**
	 * 将重做任务设置已完成
	 * @param executionEntity
	 * @param variables
	 */
	public void updateHasRodoIds(ExecutionEntity executionEntity,Map<String, Object> variables);
	
	
	/**
	 * 升级对应部署包中对应的流程旧版本任务实例(只能更换相同的流程定义key)
	 * @param deployment
	 * @throws Exception
	 */
	public void instanceUpgrade(Deployment deployment) ;
	/**
	 * 为该流程实例更换流程图（可以更换成任意的流程定义key）
	 * @param proinstaceId
	 * @param processDefinitionId
	 */
	public void instanceUpgrade(String proinstaceId,String processDefinitionId);
	/**
	 * 指定把某一个流程的定义升级成某个版本（只能更换相同的流程定义key）
	 * @param oldProcessDefinition 老的流程定义
	 * @param newProcessDefinitionId 新的流程定义id
	 */
	public void instanceUpgrade(ProcessDefinition oldProcessDefinition,String newProcessDefinitionId);

}
