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
@Table(name = "LE_LEGAL_APPROVE")
public class LegalApprove  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "审批";
	public static final String ALIAS_ID = "id";
	public static final String ALIAS_CASE_ID = "案件ID";
	public static final String ALIAS_APPROVE_ID = "审批人ID";
	public static final String ALIAS_APPROVE_CONTENT = "审批内容";
	public static final String ALIAS_SIGNITURE_PATH = "签字路径";
	public static final String ALIAS_APPROVE_TIME = "审批时间";
	public static final String ALIAS_WORK_TIME = "生效时间";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	
    /**
     * id       db_column: ID 
     */	
	private java.lang.Long id;
    /**
     * caseId       db_column: CASE_ID 
     */	
	private java.lang.Long caseId;
    /**
     * approveId       db_column: APPROVE_ID 
     */	
	private java.lang.Long approveId;
    /**
     * approveContent       db_column: APPROVE_CONTENT 
     */	
	private java.lang.String approveContent;
    /**
     * signiturePath       db_column: SIGNITURE_PATH 
     */	
	private java.lang.String signiturePath;
    /**
     * approveTime       db_column: APPROVE_TIME 
     */	
	private java.util.Date approveTime;
    /**
     * workTime       db_column: WORK_TIME 
     */	
	private java.util.Date workTime;
    /**
     * createTime       db_column: CREATE_TIME 
     */	
	private java.util.Date createTime;
	//columns END

	public LegalApprove(){
	}

	public LegalApprove(
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
	     * caseId
	     * @return caseId
	     */
		@Column(name="CASE_ID")
		public java.lang.Long getCaseId() {
			return this.caseId;
		}
		/**
	     * caseId
	     * @param caseId caseId
	     */
		public void setCaseId(java.lang.Long caseId) {
			this.caseId = caseId;
		}
		 /**
	     * approveId
	     * @return approveId
	     */
		@Column(name="APPROVE_ID")
		public java.lang.Long getApproveId() {
			return this.approveId;
		}
		/**
	     * approveId
	     * @param approveId approveId
	     */
		public void setApproveId(java.lang.Long approveId) {
			this.approveId = approveId;
		}
		 /**
	     * approveContent
	     * @return approveContent
	     */
		@Column(name="APPROVE_CONTENT")
		public java.lang.String getApproveContent() {
			return this.approveContent;
		}
		/**
	     * approveContent
	     * @param approveContent approveContent
	     */
		public void setApproveContent(java.lang.String approveContent) {
			this.approveContent = approveContent;
		}
		 /**
	     * signiturePath
	     * @return signiturePath
	     */
		@Column(name="SIGNITURE_PATH")
		public java.lang.String getSigniturePath() {
			return this.signiturePath;
		}
		/**
	     * signiturePath
	     * @param signiturePath signiturePath
	     */
		public void setSigniturePath(java.lang.String signiturePath) {
			this.signiturePath = signiturePath;
		}
	    /**
	     * approveTime
	     * @return approveTime
	     */
	public String getApproveTimeString() {
		//return DateConvertUtils.format(getApproveTime(), FORMAT_APPROVE_TIME);
		return  DateUtils.format(DateUtils.FORMAT3,getApproveTime());
	}
	 /**
     * approveTime
     * @param approveTime approveTime
     */
	public void setApproveTimeString(String approveTime) {
		setApproveTime(DateUtils.parse(approveTime,DateUtils.FORMAT3,java.util.Date.class));
	}
	
		 /**
	     * approveTime
	     * @return approveTime
	     */
		@Column(name="APPROVE_TIME")
		public java.util.Date getApproveTime() {
			return this.approveTime;
		}
		/**
	     * approveTime
	     * @param approveTime approveTime
	     */
		public void setApproveTime(java.util.Date approveTime) {
			this.approveTime = approveTime;
		}
	    /**
	     * workTime
	     * @return workTime
	     */
	public String getWorkTimeString() {
		//return DateConvertUtils.format(getWorkTime(), FORMAT_WORK_TIME);
		return  DateUtils.format(DateUtils.FORMAT3,getWorkTime());
	}
	 /**
     * workTime
     * @param workTime workTime
     */
	public void setWorkTimeString(String workTime) {
		setWorkTime(DateUtils.parse(workTime,DateUtils.FORMAT3,java.util.Date.class));
	}
	
		 /**
	     * workTime
	     * @return workTime
	     */
		@Column(name="WORK_TIME")
		public java.util.Date getWorkTime() {
			return this.workTime;
		}
		/**
	     * workTime
	     * @param workTime workTime
	     */
		public void setWorkTime(java.util.Date workTime) {
			this.workTime = workTime;
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
		@Column(name="CREATE_TIME")
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
		if(obj instanceof LegalApprove == false) return false;
		if(this == obj) return true;
		LegalApprove other = (LegalApprove)obj;
		return new EqualsBuilder()
			.append(getId(),other.getId())
			.isEquals();
	}
}

