package com.neusoft.activiti.listener.base;

import java.util.Map;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
/**
 * 
 * ReceiveTask 结束统一处理事件
 * @author 秦焰培
 *
 */
public abstract class ReceiveTaskStartEndRefactorListener extends ActivityCommonBehavior  implements ExecutionListener   {

	/**
	 * 
	 */
	private static final long serialVersionUID = 265996712262081079L;

	@Override
	public void notify(DelegateExecution execution) throws Exception {
		// 
		ExecutionEntity executionEntity=(ExecutionEntity)execution;
		if(ExecutionListener.EVENTNAME_START.equals(executionEntity.getEventName())){
			start(executionEntity,execution.getVariables());
		}else if(ExecutionListener.EVENTNAME_END.equals(executionEntity.getEventName())){
			end(executionEntity,execution.getVariables());
		}
	}
	
	public void end(ExecutionEntity executionEntity,
			Map<String, Object> variables) {
		// 
		afterEnd(executionEntity,variables);
		commonEnd(executionEntity,variables);
	}

	protected abstract  void commonEnd(ExecutionEntity executionEntity,
			Map<String, Object> variables);

	protected abstract void afterEnd(ExecutionEntity executionEntity,
			Map<String, Object> variables) ;

	public void start(ExecutionEntity executionEntity,Map<String, Object> variables){
		afterStart(executionEntity,variables);
		commonStart(executionEntity,variables);
	}

	protected abstract void commonStart(ExecutionEntity executionEntity,
			Map<String, Object> variables);
	protected abstract void afterStart(ExecutionEntity executionEntity,
			Map<String, Object> variables);
	
	

}
