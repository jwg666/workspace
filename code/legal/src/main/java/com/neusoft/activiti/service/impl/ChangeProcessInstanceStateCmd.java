package com.neusoft.activiti.service.impl;

import java.io.Serializable;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.interceptor.Command;
import org.activiti.engine.impl.interceptor.CommandContext;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.SuspensionState;

import com.neusoft.base.common.SpringApplicationContextHolder;

public class ChangeProcessInstanceStateCmd implements Command<Void>, Serializable {

	
	/**
	 *  SuspensionState ACTIVE = new SuspensionStateImpl(1, "active");
  	SuspensionState SUSPENDED = new SuspensionStateImpl(2, "suspended");
	 */
	private static final long serialVersionUID = 1L;

	
	private SuspensionState suspensionState;
	private String executionId;
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private TaskService taskService;
	
	
	/**
	 * 
	 * @param changeState 置为的状态
	 * @param executionId 流程实例的id
	 */
	public ChangeProcessInstanceStateCmd(SuspensionState suspensionState,String executionId){
		this.suspensionState=suspensionState;
		this.executionId=executionId;
		SpringApplicationContextHolder.getApplicationContext().getAutowireCapableBeanFactory().autowireBean(this);
	}
	
	@Override
	public Void execute(CommandContext commandContext) {
		// 
			ExecutionEntity executionEntity = commandContext.getExecutionEntityManager()
				      .findExecutionById(executionId);
			 if(suspensionState.getStateCode()!=executionEntity.getSuspensionState()){
				//如果是设置为活动（1）
				 if(suspensionState.getStateCode()==1){
					 runtimeService.activateProcessInstanceById(executionId);
				 }//如果是设置为挂起（2）
				 else if(suspensionState.getStateCode()==2){
					 runtimeService.suspendProcessInstanceById(executionId);
				 }
				 /*避免缓存不设置*/
			/*	 List<Task> tasks =taskService.createTaskQuery().executionId(executionId).list();
				    for (Task task : tasks) {
				    	TaskEntity taskEntity=(TaskEntity)task;
				      SuspensionStateUtil.setSuspensionState(taskEntity,suspensionState);
				    }*/
			 }
		return null;
	}

}
