package com.neusoft.activiti.service.impl;

import java.io.Serializable;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.interceptor.Command;
import org.activiti.engine.impl.interceptor.CommandContext;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.pvm.delegate.ActivityBehavior;
import org.activiti.engine.impl.pvm.process.ActivityImpl;

import com.neusoft.activiti.util.Constant;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;

/**
 * 当某个节点需要重新开始的时候，不结束当前的execution ，新建一个execution执行这个节点
 * 并且完成后 直接跳转到最后一个join 等待合并
 * @author Administrator
 *
 */
public class CreateTaskCmd implements Command<Void>, Serializable {

	private ExecutionEntity executionEntity;
	private ActivityImpl activityImpl;
	@Resource
	private RuntimeService runtimeService;
	
	
	public CreateTaskCmd(ExecutionEntity executionEntity,
			ActivityImpl activityImpl) {
		super();
		this.executionEntity = executionEntity;
		this.activityImpl = activityImpl;
		SpringApplicationContextHolder.getApplicationContext().getAutowireCapableBeanFactory().autowireBean(this);
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public Void execute(CommandContext commandContext) {
		// 
		// Context.setCommandContext(commandContext);
		 ExecutionEntity  newExecutionEntity =executionEntity.createExecution();
		 newExecutionEntity.setActivity(activityImpl);
		 newExecutionEntity.setScope(false);
		 newExecutionEntity.setConcurrent(true);
		// newExecutionEntity.set
		ActivityBehavior activityBehavior =activityImpl.getActivityBehavior();
		try {
			activityBehavior.execute(newExecutionEntity);
			/**
			 * 对手动起的活动进行计数，方便
			 * 
			 * 1.判断在流程变量里有无  手启动的活动
			 * manuallyExecutionIds 手启动的活动Id
			   manuallyExecutionCount 手启动的活动数量
			 *
			 */
			String parentExecutionId=newExecutionEntity.getParentId();
			Object manuallyExecutionCountObj=runtimeService.getVariable(parentExecutionId,Constant.MANUALLY_EXECUTION_COUNT);
			String manuallyExecutionIds=(String)runtimeService.getVariable(parentExecutionId,Constant.MANUALLY_EXECUTION_IDS);
			Integer manuallyExecutionCount=null;
			if(manuallyExecutionCountObj!=null){
				 manuallyExecutionCount=Integer.valueOf(manuallyExecutionCountObj.toString());
			}
	    	if(manuallyExecutionCount==null||!ValidateUtil.isValid(manuallyExecutionIds)){
	    		manuallyExecutionCount=1;
	    		manuallyExecutionIds=newExecutionEntity.getId();
	    	}else{
	    		manuallyExecutionCount=manuallyExecutionCount+1;
	    		manuallyExecutionIds=manuallyExecutionIds+","+newExecutionEntity.getId();
	    	}
	    	runtimeService.setVariable(parentExecutionId,Constant.MANUALLY_EXECUTION_COUNT, manuallyExecutionCount);
	    	runtimeService.setVariable(parentExecutionId, Constant.MANUALLY_EXECUTION_IDS, manuallyExecutionIds);
			} catch (Exception e) {
			// 
				throw new RuntimeException(e);
		}
		return null;
	}

}
