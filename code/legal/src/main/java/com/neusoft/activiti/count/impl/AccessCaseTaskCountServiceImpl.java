package com.neusoft.activiti.count.impl;

import org.springframework.stereotype.Component;

import com.neusoft.activiti.count.TaskCountService;
@Component("accessCaseTaskCountService")
public class AccessCaseTaskCountServiceImpl implements TaskCountService {

	@Override
	public Integer getTaskCount(String empCode) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getTaskKey() {
		return "accessCase";
	}

}