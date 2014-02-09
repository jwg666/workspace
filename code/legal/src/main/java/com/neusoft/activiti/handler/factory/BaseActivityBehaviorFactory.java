package com.neusoft.activiti.handler.factory;

import org.activiti.bpmn.model.ParallelGateway;
import org.activiti.bpmn.model.ReceiveTask;
import org.activiti.bpmn.model.ServiceTask;
import org.activiti.bpmn.model.SubProcess;
import org.activiti.bpmn.model.UserTask;
import org.activiti.engine.impl.bpmn.behavior.ParallelGatewayActivityBehavior;
import org.activiti.engine.impl.bpmn.behavior.ReceiveTaskActivityBehavior;
import org.activiti.engine.impl.bpmn.behavior.SubProcessActivityBehavior;
import org.activiti.engine.impl.bpmn.behavior.UserTaskActivityBehavior;
import org.activiti.engine.impl.bpmn.helper.ClassDelegate;
import org.activiti.engine.impl.bpmn.parser.factory.DefaultActivityBehaviorFactory;
import org.activiti.engine.impl.task.TaskDefinition;

import com.neusoft.activiti.behavior.BaseClassDelegate;
import com.neusoft.activiti.behavior.BaseParallelGatewayActivityBehavior;
import com.neusoft.activiti.behavior.BaseReceiveTaskActivityBehavior;
import com.neusoft.activiti.behavior.BaseSubProcessActivityBehavior;
import com.neusoft.activiti.behavior.BaseUserTaskActivityBehavior;

public class BaseActivityBehaviorFactory extends DefaultActivityBehaviorFactory {

	@Override
	public ParallelGatewayActivityBehavior createParallelGatewayActivityBehavior(
			ParallelGateway parallelGateway) {
		return new BaseParallelGatewayActivityBehavior();
	}

	@Override
	public UserTaskActivityBehavior createUserTaskActivityBehavior(
			UserTask userTask, TaskDefinition taskDefinition) {
			return new BaseUserTaskActivityBehavior(taskDefinition);
	}

	@Override
	public ReceiveTaskActivityBehavior createReceiveTaskActivityBehavior(
			ReceiveTask receiveTask) {
		// 
		return new BaseReceiveTaskActivityBehavior();
	}

	@Override
	public ClassDelegate createClassDelegateServiceTask(ServiceTask serviceTask) {
		//   BaseClassDelegate
		return new BaseClassDelegate(serviceTask.getImplementation(), createFieldDeclarations(serviceTask.getFieldExtensions()));
	}

	@Override
	public SubProcessActivityBehavior createSubprocActivityBehavior(
			SubProcess subProcess) {
		// 
		return new BaseSubProcessActivityBehavior();
	}
	
	
	

}
