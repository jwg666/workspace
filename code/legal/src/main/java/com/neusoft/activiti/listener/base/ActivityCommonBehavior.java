package com.neusoft.activiti.listener.base;

import java.util.Map;

import org.activiti.engine.impl.persistence.entity.ExecutionEntity;

import com.neusoft.base.common.ValidateUtil;

/**
 * 
 * @author 为流程节点的任何节点 织入公共动作： 1. 判断是否应该执行
 * 
 */
public abstract class ActivityCommonBehavior {

	/**
	 * 判断当前流程节点是否直接跳过
	 * 
	 * @return
	 */
	@Deprecated
	public Boolean isNeedSkip(ExecutionEntity executionEntity,
			Map<String, Object> variables) {
		String activityId = executionEntity.getActivityId();
		String needSkipNodeIds = (String) variables.get("needSkipNodeIds");
		if (ValidateUtil.isValid(needSkipNodeIds)) {
			String[] needSkipNodeIdArray = needSkipNodeIds.split(",");
			for (int i = 0; i < needSkipNodeIdArray.length; i++) {
				if (activityId.equals(needSkipNodeIdArray[i])) {
					return true;
				}
			}
		}

		return false;
	}

}
