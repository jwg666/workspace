package com.neusoft.activiti.taskdetail;

/*
 * 查询每一个任务的详细信息，不是必须存在
 */
public interface TaskDetailService {
	/**
	 * 加载任务实例详情
	 * @param proinstId 流程实例id
	 * @return
	 */
	public String loadTaskDetail(String proinstId); 

	public String getTaskKey();
	
}
