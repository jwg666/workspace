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
	////
	public static final String ALIAS_APPLICANT_REASON="案由";
	public static final String ALIAS_APPLICANT_TIME="申请日期";
	public static final String ALIAS_EDUCATIONAL_BACKGROUND="文化程度/受教育背景";
	public static final String ALIAS_ECONOMY_LEVAL="申请人及家庭经济状况";
	public static final String ALIAS_IF_LEVAL="是否符合法律援助经济困难标准";
	public static final String ALIAS_IF_HAVE="申请人及家庭经济状况";
	public static final String ALIAS_KIND_OF_CROWD="人群类别";
	public static final String ALIAS_CASES_SOURCE="案件来源";
	public static final String ALIAS_APPLICATION="申请事项";
	public static final String ALIAS_AID_METHODS="提供法律援助方式";
	public static final String ALIAS_APPLY_STAGE="申请事项所处阶段";
	public static final String ALIAS_CASE_SURVEY="案件概况";
	public static final String ALIAS_EXAMINATION_OPINION="审查意见";
	public static final String ALIAS_EXAMINATION_OPINION_TIME="审查意见时间";
	public static final String ALIAS_TRIAL_OPINION="审判意见";
	public static final String ALIAS_TRIAL_OPINION_TIME="审判意见时间";
	
	private java.lang.String applicantReason;
	private java.util.Date applicantTime;
	private java.lang.String educationalBackground;
	private java.lang.String economyLeval;
	private java.lang.String ifLeval;
	private java.lang.String ifHave;
	private java.lang.String kindOfCrowd;
	private java.lang.String casesSource;
	private java.lang.String application;
	private java.lang.String aidMethods;
	private java.lang.String applyStage;
	private java.lang.String caseSurvey;
	private java.lang.String examinationOpinion;
	private java.lang.String examinationOpinionTime;
	private java.lang.String trialOpinion;
	private java.lang.String trialOpinionTime;
	
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
		@Column(name="APPROVE_CONTENT",columnDefinition="text")
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
		@Column(name="APPLICANT_REASON")
	    public java.lang.String getApplicantReason() {
			return applicantReason;
		}
		public void setApplicantReason(java.lang.String applicantReason) {
			this.applicantReason = applicantReason;
		}
		@Column(name="APPLICANT_TIME")
		public java.util.Date getApplicantTime() {
			return applicantTime;
		}
		public void setApplicantTime(java.util.Date applicantTime) {
			this.applicantTime = applicantTime;
		}
		@Column(name="EDUCATIONAL_BACKGROUND")
		public java.lang.String getEducationalBackground() {
			return educationalBackground;
		}

		public void setEducationalBackground(java.lang.String educationalBackground) {
			this.educationalBackground = educationalBackground;
		}
		@Column(name="ECONOMY_LEVAL")
		public java.lang.String getEconomyLeval() {
			return economyLeval;
		}

		public void setEconomyLeval(java.lang.String economyLeval) {
			this.economyLeval = economyLeval;
		}
		@Column(name="KIND_OF_CROWD")
		public java.lang.String getKindOfCrowd() {
			return kindOfCrowd;
		}

		public void setKindOfCrowd(java.lang.String kindOfCrowd) {
			this.kindOfCrowd = kindOfCrowd;
		}
		@Column(name="CASES_SOURCE")
		public java.lang.String getCasesSource() {
			return casesSource;
		}

		public void setCasesSource(java.lang.String casesSource) {
			this.casesSource = casesSource;
		}
		@Column(name="APPLICATION")
		public java.lang.String getApplication() {
			return application;
		}

		public void setApplication(java.lang.String application) {
			this.application = application;
		}
		@Column(name="AID_METHODS")
		public java.lang.String getAidMethods() {
			return aidMethods;
		}

		public void setAidMethods(java.lang.String aidMethods) {
			this.aidMethods = aidMethods;
		}
		@Column(name="APPLY_STAGE")
		public java.lang.String getApplyStage() {
			return applyStage;
		}

		public void setApplyStage(java.lang.String applyStage) {
			this.applyStage = applyStage;
		}
		@Column(name="EXAMINATION_OPINION")
		public java.lang.String getExaminationOpinion() {
			return examinationOpinion;
		}

		public void setExaminationOpinion(java.lang.String examinationOpinion) {
			this.examinationOpinion = examinationOpinion;
		}
		@Column(name="EXAMINATION_OPINION_TIME")
		public java.lang.String getExaminationOpinionTime() {
			return examinationOpinionTime;
		}

		public void setExaminationOpinionTime(java.lang.String examinationOpinionTime) {
			this.examinationOpinionTime = examinationOpinionTime;
		}
		@Column(name="TRIAL_OPINION")
		public java.lang.String getTrialOpinion() {
			return trialOpinion;
		}

		public void setTrialOpinion(java.lang.String trialOpinion) {
			this.trialOpinion = trialOpinion;
		}
		@Column(name="TRIAL_OPINION_TIME")
		public java.lang.String getTrialOpinionTime() {
			return trialOpinionTime;
		}

		public void setTrialOpinionTime(java.lang.String trialOpinionTime) {
			this.trialOpinionTime = trialOpinionTime;
		}
		@Column(name="IF_LEVAL")
	    public java.lang.String getIfLeval() {
			return ifLeval;
		}

		public void setIfLeval(java.lang.String ifLeval) {
			this.ifLeval = ifLeval;
		}
		@Column(name="IF_HAVE")
		public java.lang.String getIfHave() {
			return ifHave;
		}

		public void setIfHave(java.lang.String ifHave) {
			this.ifHave = ifHave;
		}
		@Column(name="CASE_SURVEY")
	    public java.lang.String getCaseSurvey() {
			return caseSurvey;
		}

		public void setCaseSurvey(java.lang.String caseSurvey) {
			this.caseSurvey = caseSurvey;
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

