/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;


@Entity
@Table(name = "LE_LEGAL_AGENT")
public class LegalAgent  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "代理人";
	public static final String ALIAS_ID = "id";
	public static final String APPLICANT_ID ="applicantId";
	public static final String ALIAS_NAME = "name";
	public static final String ALIAS_IDENTIFYID = "identifyid";
	public static final String ALIAS_AGENT_TYPE = "agentType";
	public static final String ALIAS_CREATE_TIME = "createTime";
	
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
	//columns END
    /**
     * 手工输入的人的名字
     */
    private String agentWrite;
	public LegalAgent(){
	}

	public LegalAgent(
		java.lang.Long id
	){
		this.id = id;
	}

		 /**
	     * id
	     * @return id
	     */
		@Id  
	    @GeneratedValue
		@Column(name="ID")
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
		@Column(name="name")
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
		@Column(name="identifyid")
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
		@Column(name="agent_type")
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
		@Column(name="create_time")
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
		
		 /**
	     * createTime
	     * @return createTime
	     */
		@Column(name="applicant_id")
	   public java.lang.Long getApplicantId() {
			return applicantId;
		}

		public void setApplicantId(java.lang.Long applicantId) {
			this.applicantId = applicantId;
		}
		/**
		 * @time 2014-4-28 上午2:46:30
		 * @return
		 * @author 门光耀
		 * @description 手动输入的律师名字
		 */
		@Column(name="agent_write")
	    public String getAgentWrite() {
			return agentWrite;
		}

		public void setAgentWrite(String agentWrite) {
			this.agentWrite = agentWrite;
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
		if(obj instanceof LegalAgent == false) return false;
		if(this == obj) return true;
		LegalAgent other = (LegalAgent)obj;
		return new EqualsBuilder()
			.append(getId(),other.getId())
			.isEquals();
	}
}

