package com.neusoft.activiti.count.impl;

import javax.annotation.Resource;

import org.activiti.engine.TaskService;
import org.springframework.stereotype.Component;

import com.neusoft.activiti.count.TaskCountService;
import com.neusoft.legal.LegalConstant;
@Component("caseApproveTaskCountService")
public class CaseApproveTaskCountServiceImpl implements TaskCountService {
	@Resource
	private TaskService taskService;
	@Override
	public Integer getTaskCount(String empCode) {
		Long count = taskService.createTaskQuery().taskDefinitionKey(LegalConstant.CASE_APPROVE_KEY).count();
		if (count!=null) {
			return count.intValue();
		}else{
			return 0;
		}
	}

	@Override
	public String getTaskKey() {
		return LegalConstant.CASE_APPROVE_KEY;
	}

}
