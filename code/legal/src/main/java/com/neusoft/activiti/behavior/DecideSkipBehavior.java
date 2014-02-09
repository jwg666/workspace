package com.neusoft.activiti.behavior;

import java.util.Collection;

import org.activiti.engine.impl.pvm.delegate.ActivityExecution;

import com.neusoft.activiti.util.Constant;


/**
 * 决策判断当前节点是否需要跳过
 * @author 秦焰培
 *
 */
public class DecideSkipBehavior {

	@SuppressWarnings("unchecked")
	public static Boolean isNeedSkip(ActivityExecution execution) {
		String activityId=execution.getActivity().getId();
		Collection<String> needSkipNodeIdList = (Collection<String>)execution.getVariable(Constant.NEED_SKIP_NODE_IDS);
		Boolean needSkip=false;
		if (needSkipNodeIdList!=null) {
			for (String needSkipNodeId:needSkipNodeIdList) {
				if (activityId.equals(needSkipNodeId)) {
					needSkip=true;
					break;
				}
			}
		}
		
		
		return needSkip;
	}
}
