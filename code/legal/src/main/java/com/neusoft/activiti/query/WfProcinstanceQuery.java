/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */

package com.neusoft.activiti.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.activiti.domain.WfProcinstance;
import com.neusoft.base.model.SearchModel;
/**
 * database table: WF_PROCINSTANCE
 * database table comments: 表单在工作流中的状态
 */
public class WfProcinstanceQuery extends  SearchModel<WfProcinstance> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    

	  /**
     * 唯一标识       db_column: ROW_ID 
     */	
	private java.lang.Long id;
	  /**
     * 流程实例Id       db_column: PROCESSINSTANCE_ID 
     */	
	private java.lang.String processinstanceId;
	  /**
     * 流程类型       db_column: PROCESSDEFINITION_KEY 
     */	
	private java.lang.String processdefinitionKey;
	  /**
     * 业务表数据       db_column: BUSINFORM_ID 
     */	
	private java.lang.String businformId;
	  /**
     * 业务表类型       db_column: BUSINFORM_TYPE 
     */	
	private java.lang.String businformType;
	/**
	 * 状态 是否结束 
	 * 0：已经结束
	 * 1：正在进行
	 *
	 */
	private java.lang.String status="1";
	
	public WfProcinstanceQuery(){
	  
	}
	
	

	public WfProcinstanceQuery(String processdefinitionKey, String businformId,
			String businformType) {
		super();
		this.processdefinitionKey = processdefinitionKey;
		this.businformId = businformId;
		this.businformType = businformType;
	}



	public WfProcinstanceQuery(String processinstanceId,
			String processdefinitionKey, String businformId,
			String businformType) {
		super();
		this.processinstanceId = processinstanceId;
		this.processdefinitionKey = processdefinitionKey;
		this.businformId = businformId;
		this.businformType = businformType;
	}

	
	
	public java.lang.Long getId() {
		return id;
	}



	public void setId(java.lang.Long id) {
		this.id = id;
	}



	public java.lang.String getProcessinstanceId() {
		return this.processinstanceId;
	}
	
	public void setProcessinstanceId(java.lang.String value) {
		this.processinstanceId = value;
	}
	
	public java.lang.String getProcessdefinitionKey() {
		return this.processdefinitionKey;
	}
	
	public void setProcessdefinitionKey(java.lang.String value) {
		this.processdefinitionKey = value;
	}
	
	public java.lang.String getBusinformId() {
		return this.businformId;
	}
	
	public void setBusinformId(java.lang.String value) {
		this.businformId = value;
	}
	
	public java.lang.String getBusinformType() {
		return this.businformType;
	}
	
	public void setBusinformType(java.lang.String value) {
		this.businformType = value;
	}
	

	
	public java.lang.String getStatus() {
		return status;
	}



	public void setStatus(java.lang.String status) {
		this.status = status;
	}



	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

