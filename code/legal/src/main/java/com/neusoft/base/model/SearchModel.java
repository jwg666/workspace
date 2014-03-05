package com.neusoft.base.model;

import java.io.Serializable;




import com.neusoft.base.common.Pager;
import com.neusoft.base.common.ValidateUtil;


public  class SearchModel<T> implements Serializable {
	
	
	private static final long serialVersionUID = -4792529174794922096L;
	/**
	 * 我的个人待办任务
	 */
	public final static  String TASK_TYPE_MY="my";
	public final static  String TASK_TYPE_GROUP="group";
	/**
	 * 节点流程ID
	 */
	protected String definitionKey;
	/**
	 * 
	 */
	protected Pager<T> pager = new Pager<T>();
	
	/**
	 * 任务类型
	 * my 个人任务
	 * group 未分配的组任务
	 */
	private java.lang.String taskType;	

	private Long  page=1L;	
	private Long  rows=20L;
	private String  sort;
	
	  /*
	   * 任务id的数组
	   * */
	protected String[] taskIds;
	  /*
	   * 任务id
	   * */
	protected String taskId;
	
	public Long getPage() {
		return page;
	}
	public void setPage(Long page) {
		if(!ValidateUtil.isValid(page)){
			page=Long.valueOf(1);
		}
		getPager().setCurrentPage(page);
		this.page = page;
	}
	public Long getRows() {		
		return rows;
	}
	public void setRows(Long rows) {
		if(!ValidateUtil.isValid(rows)){
			rows=Long.valueOf(10);
		}
		getPager().setPageSize(rows);
		this.rows = rows;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		if(ValidateUtil.isValid(sort)){
			getPager().setOrderProperty(sort);
		}
		this.sort = sort;
	}
	public java.lang.String getTaskType() {
		return taskType;
	}
	public void setTaskType(java.lang.String taskType) {
		this.taskType = taskType;
	}
	public Pager<T> getPager() {
		return pager;
	}
	public void setPager(Pager<T> pager) {
		this.pager = pager;
	}
	public String[] getTaskIds() {
		return taskIds;
	}
	public void setTaskIds(String[] taskIds) {
		this.taskIds = taskIds;
	}
	public String getTaskId() {
		return taskId;
	}
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	public String getDefinitionKey() {
		return definitionKey;
	}
	public void setDefinitionKey(String definitionKey) {
		this.definitionKey = definitionKey;
	}
	
	
	
}
