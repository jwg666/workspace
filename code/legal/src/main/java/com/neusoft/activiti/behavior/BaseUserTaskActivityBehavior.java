package com.neusoft.activiti.behavior;

import org.activiti.engine.impl.bpmn.behavior.UserTaskActivityBehavior;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.activiti.engine.impl.task.TaskDefinition;
/**
 * 在任务节点之前进行拦截，判断该节点是否需要跳过
 * @author 秦焰培
 *
 */
public class BaseUserTaskActivityBehavior extends UserTaskActivityBehavior {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4156748871515286994L;

	public BaseUserTaskActivityBehavior(TaskDefinition taskDefinition) {
		super(taskDefinition);
		// 
	}
	@Override
	 public void execute(ActivityExecution execution) throws Exception {
		Boolean needSkip = DecideSkipBehavior.isNeedSkip(execution);
		if(needSkip){
			super.leave(execution);
		}else{
			super.execute(execution);
		}
	 }
}
