package com.neusoft.activiti.behavior;

import java.util.List;

import org.activiti.engine.impl.bpmn.helper.ClassDelegate;
import org.activiti.engine.impl.bpmn.parser.FieldDeclaration;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;

public class BaseClassDelegate extends ClassDelegate {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5669200647983309229L;

	public BaseClassDelegate(Class<?> clazz,
			List<FieldDeclaration> fieldDeclarations) {
		super(clazz, fieldDeclarations);
		// 
	}

	public BaseClassDelegate(String className,
			List<FieldDeclaration> fieldDeclarations) {
		super(className, fieldDeclarations);
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
