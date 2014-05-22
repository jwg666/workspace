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
@Table(name = "LE_LEGAL_CASE")
public class LegalCase  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "案件";
	public static final String ALIAS_ID = "id";
	public static final String ALIAS_APPLICANT_ID = "申请人ID";
	public static final String ALIAS_AGENT_ID = "代理人ID";
	public static final String ALIAS_DESCRIPTION = "描述描述";
	public static final String ALIAS_REASON_ID = "申请原因";
	public static final String ALIAS_SIGNITURE_PATH = "签名路径";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	public static final String ALIAS_CREATE_BY = "创建人";
	public static final String ALIAS_CASE_FROM = "案件来源";
	public static final String ALIAS_APPLY_DATE = "申请时间";
	public static final String ALIAS_APPLY_TYPE_ID = "申请事项";
	public static final String ALIAS_APPLY_TYPE_PROCESS = "申请事项所得阶段";
	
    /**
     * id       db_column: ID 
     */	
	private java.lang.Long id;
    /**
     * applicantId       db_column: applicant_id 
     */	
	private java.lang.Long applicantId;
    /**
     * agentId       db_column: agent_id 
     */	
	private java.lang.Long agentId;
    /**
     * description       db_column: description 
     */	
	private java.lang.String description;
    /**
     * reasonId       db_column: reason_id 
     */	
	private java.lang.Long reasonId;
    /**
     * signiturePath       db_column: signiture_path 
     */	
	private java.lang.String signiturePath;
    /**
     * createTime       db_column: create_time 
     */	
	private java.util.Date createTime;
    /**
     * createBy       db_column: create_by 
     */	
	private java.lang.Long createBy;
    /**
     * caseFrom       db_column: case_from 
     */	
	private java.lang.Long caseFrom;
    /**
     * applyDate       db_column: apply_date 
     */	
	private java.util.Date applyDate;
    /**
     * applyTypeId       db_column: apply_type_id 
     */	
	private java.lang.Long applyTypeId;
    /**
     * applyTypeProcess       db_column: apply_type_process 
     */	
	private java.lang.Long applyTypeProcess;
	//columns END
	private Long legalId;//律师事务所
	
	//（$legalWord）援审字（$legalCode）第（$legalNo）号
	private String legalCode;
	private String legalNo;
	private String legalWord;
	private String year;
	private String month;
	private String day;
	private String agentWriteName;
	private Long signId;//签名ＩＤ
	private Long yinzhId;//印章ＩＤ
	private Long agentSignId;//代理签名ID
	public LegalCase(){
	}

	public LegalCase(
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
	     * applicantId
	     * @return applicantId
	     */
		@Column(name="applicant_id")
		public java.lang.Long getApplicantId() {
			return this.applicantId;
		}
		/**
	     * applicantId
	     * @param applicantId applicantId
	     */
		public void setApplicantId(java.lang.Long applicantId) {
			this.applicantId = applicantId;
		}
		 /**
	     * agentId
	     * @return agentId
	     */
		@Column(name="agent_id")
		public java.lang.Long getAgentId() {
			return this.agentId;
		}
		/**
	     * agentId
	     * @param agentId agentId
	     */
		public void setAgentId(java.lang.Long agentId) {
			this.agentId = agentId;
		}
		 /**
	     * description
	     * @return description
	     */
		@Column(name="description",columnDefinition="text")
		public java.lang.String getDescription() {
			return this.description;
		}
		/**
	     * description
	     * @param description description
	     */
		public void setDescription(java.lang.String description) {
			this.description = description;
		}
		 /**
	     * reasonId
	     * @return reasonId
	     */
		@Column(name="reason_id")
		public java.lang.Long getReasonId() {
			return this.reasonId;
		}
		/**
	     * reasonId
	     * @param reasonId reasonId
	     */
		public void setReasonId(java.lang.Long reasonId) {
			this.reasonId = reasonId;
		}
		 /**
	     * signiturePath
	     * @return signiturePath
	     */
		@Column(name="signiture_path")
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
	     * createBy
	     * @return createBy
	     */
		@Column(name="create_by")
		public java.lang.Long getCreateBy() {
			return this.createBy;
		}
		/**
	     * createBy
	     * @param createBy createBy
	     */
		public void setCreateBy(java.lang.Long createBy) {
			this.createBy = createBy;
		}
		 /**
	     * caseFrom
	     * @return caseFrom
	     */
		@Column(name="case_from")
		public java.lang.Long getCaseFrom() {
			return this.caseFrom;
		}
		/**
	     * caseFrom
	     * @param caseFrom caseFrom
	     */
		public void setCaseFrom(java.lang.Long caseFrom) {
			this.caseFrom = caseFrom;
		}
	  
		 /**
	     * applyDate
	     * @return applyDate
	     */
		@Column(name="apply_date")
		public java.util.Date getApplyDate() {
			return this.applyDate;
		}
		/**
	     * applyDate
	     * @param applyDate applyDate
	     */
		public void setApplyDate(java.util.Date applyDate) {
			this.applyDate = applyDate;
		}
		 /**
	     * applyTypeId
	     * @return applyTypeId
	     */
		@Column(name="apply_type_id")
		public java.lang.Long getApplyTypeId() {
			return this.applyTypeId;
		}
		/**
	     * applyTypeId
	     * @param applyTypeId applyTypeId
	     */
		public void setApplyTypeId(java.lang.Long applyTypeId) {
			this.applyTypeId = applyTypeId;
		}
		 /**
	     * applyTypeProcess
	     * @return applyTypeProcess
	     */
		@Column(name="apply_type_process")
		public java.lang.Long getApplyTypeProcess() {
			return this.applyTypeProcess;
		}
		/**
	     * applyTypeProcess
	     * @param applyTypeProcess applyTypeProcess
	     */
		public void setApplyTypeProcess(java.lang.Long applyTypeProcess) {
			this.applyTypeProcess = applyTypeProcess;
		}
		@Column(name="legal_id")
		public Long getLegalId() {
				return legalId;
			}
	
		public void setLegalId(Long legalId) {
			this.legalId = legalId;
		}
		@Column(name="legal_code")	
		public String getLegalCode() {
			return legalCode;
		}

		public void setLegalCode(String legalCode) {
			this.legalCode = legalCode;
		}
		@Column(name="legal_no")
		public String getLegalNo() {
			return legalNo;
		}

		public void setLegalNo(String legalNo) {
			this.legalNo = legalNo;
		}
		@Column(name="legal_word")
		public String getLegalWord() {
			return legalWord;
		}

		public void setLegalWord(String legalWord) {
			this.legalWord = legalWord;
		}
		@Column(name="_year")
		public String getYear() {
			return year;
		}

		public void setYear(String year) {
			this.year = year;
		}
		@Column(name="_month")
		public String getMonth() {
			return month;
		}

		public void setMonth(String month) {
			this.month = month;
		}
		@Column(name="_day")
		public String getDay() {
			return day;
		}

		public void setDay(String day) {
			this.day = day;
		}
		@Column(name="agent_write_name")
		public String getAgentWriteName() {
			return agentWriteName;
		}

		public void setAgentWriteName(String agentWriteName) {
			this.agentWriteName = agentWriteName;
		}
		
		
		@Column(name="sign_id")
		public Long getSignId() {
			return signId;
		}

		public void setSignId(Long signId) {
			this.signId = signId;
		}
		@Column(name="yinzh_id")
		public Long getYinzhId() {
			return yinzhId;
		}

		public void setYinzhId(Long yinzhId) {
			this.yinzhId = yinzhId;
		}
		
		@Column(name="agent_sign_id")
		public Long getAgentSignId() {
			return agentSignId;
		}

		public void setAgentSignId(Long agentSignId) {
			this.agentSignId = agentSignId;
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
		if(obj instanceof LegalCase == false) return false;
		if(this == obj) return true;
		LegalCase other = (LegalCase)obj;
		return new EqualsBuilder()
			.append(getId(),other.getId())
			.isEquals();
	}
}

