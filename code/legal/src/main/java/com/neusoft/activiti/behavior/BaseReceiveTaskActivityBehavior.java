package com.neusoft.activiti.behavior;

import org.activiti.engine.impl.bpmn.behavior.ReceiveTaskActivityBehavior;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;

public class BaseReceiveTaskActivityBehavior extends
		ReceiveTaskActivityBehavior {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3285088765599438401L;
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
