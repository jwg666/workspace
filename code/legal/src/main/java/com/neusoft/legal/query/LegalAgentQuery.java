/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.base.model.SearchModel;
import com.neusoft.legal.domain.LegalAgent;
/**
 * database table: LE_LEGAL_AGENT
 * database table comments: LegalAgent
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
public class LegalAgentQuery extends  SearchModel<LegalAgent> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    
     private java.lang.Long[] ids;
	  /**
     * id       db_column: ID 
     */	
	private java.lang.Long id;
	/**
	 * applicantId db_column:applicant_id
	 */
	private java.lang.Long applicantId;
	  /**
     * name       db_column: name 
     */	
	private java.lang.String name;
	  /**
     * identifyid       db_column: identifyid 
     */	
	private java.lang.String identifyid;
	  /**
     * agentType       db_column: agent_type 
     */	
	private java.lang.String agentType;
	  /**
     * createTime       db_column: create_time 
     */	
	private java.util.Date createTime;
    /**
     * 手工输入的人的名字
     */
    private String agentWrite;
	 /**
     * id
     * @return id
     */
	public java.lang.Long getId() {
		return this.id;
	}
	 /**
     * id
     * @param id id
     */
	public void setId(java.lang.Long id) {
		this.id = id;
	}
	
	 /**
     * name
     * @return name
     */
	public java.lang.String getName() {
		return this.name;
	}
	 /**
     * name
     * @param name name
     */
	public void setName(java.lang.String name) {
		this.name = name;
	}
	
	 /**
     * identifyid
     * @return identifyid
     */
	public java.lang.String getIdentifyid() {
		return this.identifyid;
	}
	 /**
     * identifyid
     * @param identifyid identifyid
     */
	public void setIdentifyid(java.lang.String identifyid) {
		this.identifyid = identifyid;
	}
	
	 /**
     * agentType
     * @return agentType
     */
	public java.lang.String getAgentType() {
		return this.agentType;
	}
	 /**
     * agentType
     * @param agentType agentType
     */
	public void setAgentType(java.lang.String agentType) {
		this.agentType = agentType;
	}
	
	 /**
     * createTime
     * @return createTime
     */
	public java.util.Date getCreateTime() {
		return this.createTime;
	}
	 /**
     * createTime
     * @param createTime createTime
     */
	public void setCreateTime(java.util.Date createTime) {
		this.createTime = createTime;
	}
	
	
	public java.lang.Long[] getIds() {
		return ids;
	}
	
	public void setIds(java.lang.Long[] ids) {
		this.ids = ids;
	}

	public java.lang.Long getApplicantId() {
		return applicantId;
	}
	public void setApplicantId(java.lang.Long applicantId) {
		this.applicantId = applicantId;
	}
	
	public String getAgentWrite() {
		return agentWrite;
	}
	public void setAgentWrite(String agentWrite) {
		this.agentWrite = agentWrite;
	}
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

