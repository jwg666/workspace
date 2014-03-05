package com.neusoft.activiti.count.impl;

import org.springframework.stereotype.Component;

import com.neusoft.activiti.count.TaskCountService;
@Component("caseApproveTaskCountService")
public class CaseApproveTaskCountServiceImpl implements TaskCountService {

	@Override
	public Integer getTaskCount(String empCode) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getTaskKey() {
		return "caseApprove";
	}

}
