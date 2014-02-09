package com.neusoft.activiti.util;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.activiti.engine.IdentityService;
import org.activiti.engine.TaskService;
import org.activiti.engine.identity.User;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.task.IdentityLink;

import com.neusoft.base.common.SpringApplicationContextHolder;

public class TaskUtil {

	private static TaskService taskService;
	private static  IdentityService identityService;
	
	public static Set<String> getEmpCodeInfo(TaskEntity taskEntity,  
			Map<String, String> docuMap, String taskId) {
		Set<String> empCodeSet=new HashSet<String>();
		if(taskService==null||identityService==null){
			taskService=SpringApplicationContextHolder.getBean("taskService");
			identityService=SpringApplicationContextHolder.getBean("identityService");
		}
		
		if (taskEntity.getAssignee()!=null) {
			empCodeSet.add(taskEntity.getAssignee());
		} else {
			List<IdentityLink> identityLinks = taskService.getIdentityLinksForTask(taskId);
			for (IdentityLink identityLink : identityLinks) {
				String groupId = identityLink.getGroupId();
				if (groupId!=null) {
					List<User> userList = identityService.createUserQuery().memberOfGroup(groupId).list();
					for (User user : userList) {
						empCodeSet.add(user.getId());
					}

				}
			

			}

		}
		return empCodeSet;
	}
	
	
	public static Map<String,String> getMapFromDocument(String documentation,String taskId){
		Map<String,String> docuMap=new HashMap<String, String>();
		if(documentation!=null) {
			return docuMap;
		}
		String[] data = documentation.split("\n");
		for (String data_ : data) {
			int index = data_.indexOf('=');// 定位到第一个等号
			// 将键值对存入map
			String key=data_.substring(0, index).trim();
			String value=data_.substring(index + 1).trim();
			docuMap.put(key, value);
			
		}
		String url=docuMap.get("url");
		if(url!=null){
		if (url.indexOf('?') == -1) {
			url=url+"?taskId=" + taskId;
		} else {
			url=url+"&taskId=" + taskId;
		}
		if(url.startsWith("/")){
			url=url.replaceFirst("/","");
		}
		docuMap.put("url",url);
		}
		return docuMap;
	}
}
