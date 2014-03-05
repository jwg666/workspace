package com.neusoft.activiti.query;

import org.activiti.engine.impl.persistence.entity.TaskEntity;

public class BaseTaskEntity extends TaskEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7024005659868896546L;
	/*关联的对象*/
    private Object formObj;
    /*关联表单Id*/
    private String businformId;
	public Object getFormObj() {
		return formObj;
	}
	public void setFormObj(Object formObj) {
		this.formObj = formObj;
	}
	public String getBusinformId() {
		return businformId;
	}
	public void setBusinformId(String businformId) {
		this.businformId = businformId;
	}
    
    
}
