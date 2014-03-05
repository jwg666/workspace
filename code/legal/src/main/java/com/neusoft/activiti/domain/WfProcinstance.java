/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */

package com.neusoft.activiti.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
/**
 * database table: WF_PROCINSTANCE
 * database table comments: 表单在工作流中的状态
 */
@Entity
@Table(name = "WF_PROCINSTANCE")
public class WfProcinstance  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "表单在工作流中的状态";
	public static final String ALIAS_ROW_ID = "唯一标识";
	public static final String ALIAS_PROCESSINSTANCE_ID = "流程实例Id";
	public static final String ALIAS_PROCESSDEFINITION_KEY = "流程类型";
	public static final String ALIAS_BUSINFORM_ID = "业务表数据";
	public static final String ALIAS_BUSINFORM_TYPE = "业务表类型";
	
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
	 */
	private java.lang.String status;
	//columns END

	public WfProcinstance(){
	}


	public void setId(java.lang.Long value) {
		this.id = value;
	}
	@Id  
    @GeneratedValue
	@Column(name="ID")
	public java.lang.Long getId() {
		return this.id;
	}
	public void setProcessinstanceId(java.lang.String value) {
		this.processinstanceId = value;
	}
	@Column(name="process_instance_id")
	public java.lang.String getProcessinstanceId() {
		return this.processinstanceId;
	}
	public void setProcessdefinitionKey(java.lang.String value) {
		this.processdefinitionKey = value;
	}
	@Column(name="process_definition_key")
	public java.lang.String getProcessdefinitionKey() {
		return this.processdefinitionKey;
	}
	public void setBusinformId(java.lang.String value) {
		this.businformId = value;
	}
	@Column(name="businform_id")
	public java.lang.String getBusinformId() {
		return this.businformId;
	}
	public void setBusinformType(java.lang.String value) {
		this.businformType = value;
	}
	@Column(name="businform_type")
	public java.lang.String getBusinformType() {
		return this.businformType;
	}
	
	@Column(name="status")
	public java.lang.String getStatus() {
		return status;
	}

	public void setStatus(java.lang.String status) {
		this.status = status;
	}

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(!(obj instanceof WfProcinstance )) {return false;}
		if(this == obj) {return true;}
		WfProcinstance other = (WfProcinstance)obj;
		return new EqualsBuilder()
			.append(getId(),other.getId())
			.isEquals();
	}
	
}

