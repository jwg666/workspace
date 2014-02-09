package com.neusoft.activiti.behavior;

import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.bpmn.behavior.ParallelGatewayActivityBehavior;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.neusoft.activiti.util.Constant;
import com.neusoft.base.common.SpringApplicationContextHolder;

/***
 * 
 * @author Administrator
 *
 */
public class BaseParallelGatewayActivityBehavior extends
		ParallelGatewayActivityBehavior {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8193836261349487900L;

	private static Logger log = LoggerFactory
			.getLogger(ParallelGatewayActivityBehavior.class);
	@Resource
	private RuntimeService runtimeService;

	public BaseParallelGatewayActivityBehavior(){
		SpringApplicationContextHolder.getApplicationContext().getAutowireCapableBeanFactory().autowireBean(this);
	}
	
	@Override
	public void execute(ActivityExecution execution) throws Exception {

		// Join
		PvmActivity activity = execution.getActivity();
		List<PvmTransition> outgoingTransitions = execution.getActivity()
				.getOutgoingTransitions();

		execution.inactivate();
		lockConcurrentRoot(execution);

		List<ActivityExecution> joinedExecutions = execution
				.findInactiveConcurrentExecutions(activity);
		int nbrOfExecutionsToJoin = execution.getActivity()
				.getIncomingTransitions().size();
		int nbrOfExecutionsJoined = joinedExecutions.size();
		// 如果是约定的结束之前的join节点，需要特殊的判断
		if (Constant.PARALLEL_GATEWAY_END.equals(activity.getId())) {
			String executionId = execution.getId();
			Object manuallyExecutionCountObj = runtimeService.getVariable(
					executionId, Constant.MANUALLY_EXECUTION_COUNT);
			Integer manuallyExecutionCount = 0;
			if (manuallyExecutionCountObj != null) {
				manuallyExecutionCount = Integer.valueOf(runtimeService
						.getVariable(executionId,
								Constant.MANUALLY_EXECUTION_COUNT).toString());
				nbrOfExecutionsToJoin = nbrOfExecutionsToJoin
						+ manuallyExecutionCount;
				// 判断是否由临时节点跳转过来的
				String manuallyExecutionIds = (String) runtimeService
						.getVariable(executionId,
								Constant.MANUALLY_EXECUTION_IDS);
				String[] manuallyExecutionIdArray = manuallyExecutionIds
						.split(",");
				for (String id : manuallyExecutionIdArray) {
					if (executionId.equals(id)) {
						nbrOfExecutionsToJoin = nbrOfExecutionsToJoin - 1;
					}
				}
			}
		}

		if (nbrOfExecutionsJoined == nbrOfExecutionsToJoin) {

			// Fork
			if (log.isDebugEnabled()) {
				log.debug("parallel gateway '{}' activates: {} of {} joined",
						activity.getId(), nbrOfExecutionsJoined,
						nbrOfExecutionsToJoin);
			}
			execution.takeAll(outgoingTransitions, joinedExecutions);

		} else{
			if (log.isDebugEnabled()) {
				log.debug("if source activti is shipment", activity.getId(),
						nbrOfExecutionsJoined, nbrOfExecutionsToJoin);
			}
			if (execution.getProcessDefinitionId() != null
					&& execution.getProcessDefinitionId().indexOf("orderTrace") != -1) {

				/* 如果 parallel不该合并 并且是由装箱过来 则抛出异常 */
				String processInstanceId = execution.getProcessInstanceId();
				ExecutionEntity executionEntity = (ExecutionEntity) runtimeService
						.createExecutionQuery()
						.processInstanceId(processInstanceId)
						.activityId("shipMent").singleResult();
				if (executionEntity != null
						&& executionEntity.getId().equals(execution.getId())) {
					throw new Exception("ohter execution not end");
				}
			}
		}
	}
}
