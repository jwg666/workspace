package com.neusoft.activiti.service.impl;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.springframework.stereotype.Service;

import com.neusoft.activiti.service.CounterSignedService;

/**
 * 
 * 会签相关的业务类
 * @author 秦焰培
 *
 */
@Service("counterSignedService")
public class CounterSignedServiceImpl implements CounterSignedService {

	@Resource
	private RuntimeService runtimeService;
	
	@Override
	public boolean isComplete(ActivityExecution execution) {
		//Boolean isCompleted=false;
		//实例总数  BX-GCJSC_reslut  true false	
		String assignee=(String)execution.getVariable("assignee");
		/**
		 * 获取父流程的 流程实例id
		 */
		String proninstId= execution.getParentId();
		/**
		 * 获取当前用户的审核意见
		 * true：同意
		 * false: 不同意
		 * 
		 */
		Boolean checkResult=(Boolean)execution.getVariable(assignee+"_result");
		if(!checkResult){
			runtimeService.setVariable(proninstId, "result", false);
			return true;
		}
		Integer totalCount=(Integer)execution.getVariable("nrOfInstances");
		Integer finshedCount=(Integer)execution.getVariable("nrOfCompletedInstances");
		if(finshedCount.equals(totalCount)){
			runtimeService.setVariable(proninstId, "result", true);
			return true;
		}
		return false;
	}


}
