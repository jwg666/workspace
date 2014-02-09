package com.neusoft.activiti.behavior;

import org.activiti.engine.impl.bpmn.behavior.SubProcessActivityBehavior;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;

public class BaseSubProcessActivityBehavior extends SubProcessActivityBehavior {

	/**
	 * 
	 */
	private static final long serialVersionUID = -87008404285996503L;

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
