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

import com.neusoft.base.common.DateUtils;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;


@Entity
@Table(name = "LE_LEGAL_AGENT")
public class LegalAgent  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "LegalAgent";
	public static final String ALIAS_ID = "id";
	public static final String ALIAS_NAME = "name";
	public static final String ALIAS_IDENTIFYID = "identifyid";
	public static final String ALIAS_AGENT_TYPE = "agentType";
	public static final String ALIAS_CREATE_TIME = "createTime";
	
    /**
     * id       db_column: ID 
     */	
	private java.lang.Long id;
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
	public String getCreateTimeString() {
		//return DateConvertUtils.format(getCreateTime(), FORMAT_CREATE_TIME);
		return  DateUtils.format(DateUtils.FORMAT3,getCreateTime());
	}
	 /**
     * createTime
     * @param createTime createTime
     */
	public void setCreateTimeString(String createTime) {
		setCreateTime(DateUtils.parse(createTime,DateUtils.FORMAT3,java.util.Date.class));
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

