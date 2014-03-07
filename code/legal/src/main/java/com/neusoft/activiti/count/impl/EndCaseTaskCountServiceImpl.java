package com.neusoft.activiti.count.impl;

import javax.annotation.Resource;

import org.activiti.engine.TaskService;
import org.springframework.stereotype.Component;

import com.neusoft.activiti.count.TaskCountService;
import com.neusoft.legal.LegalConstant;
@Component("endCaseTaskCountService")
public class EndCaseTaskCountServiceImpl implements TaskCountService {
	@Resource
	private TaskService taskService;
	@Override
	public Integer getTaskCount(String empCode) {
		Long count = taskService.createTaskQuery().taskDefinitionKey(LegalConstant.END_CASE_KEY).count();
		if (count!=null) {
			return count.intValue();
		}else{
			return 0;
		}
	}

	@Override
	public String getTaskKey() {
		return LegalConstant.END_CASE_KEY;
	}

}
