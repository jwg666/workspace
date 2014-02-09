package com.neusoft.activiti.service.impl;

import java.util.Map;

import org.activiti.engine.impl.RuntimeServiceImpl;
import org.springframework.stereotype.Service;

@Service("runtimeService")
public class BaseRuntimeService extends RuntimeServiceImpl {

	@Override
	public Map<String, Object> getVariables(String executionId) {
		// 
		return super.getVariables(executionId);
	}

	@Override
	public Object getVariable(String executionId, String variableName) {
		// 
		 try {
			return super.getVariable(executionId, variableName);
		} catch (Exception e) {
			// 
			//logger.error("got exception--",e);
		}
		 return null;
	}

	
}
