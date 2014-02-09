package com.neusoft.activiti.count;

/**
 * 获取节点任务数量
 * @author  秦焰培
 *
 */
public interface TaskCountService {
	
	/**
	 *根据用户的员工号 获取该任务节点的数量 
	 * @param empCode 员工号
	 * @return
	 */
	public Integer getTaskCount(String empCode);
	
	/**
	 * 获取该任务节点的key
	 * @return
	 */
	public String getTaskKey();
}
