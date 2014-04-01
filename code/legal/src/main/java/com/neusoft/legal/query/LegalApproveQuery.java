/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.base.model.SearchModel;
import com.neusoft.legal.domain.LegalApprove;
/**
 * database table: LE_LEGAL_APPROVE
 * database table comments: LegalApprove
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
public class LegalApproveQuery extends  SearchModel<LegalApprove> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    
     private java.lang.Long[] ids;
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
	
	
	private java.lang.String legalWord;
	private java.lang.String legalCode;
	private java.lang.String legalNo;
	private java.lang.String name;

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
     * caseId
     * @return caseId
     */
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

	public java.lang.String getApplicantReason() {
		return applicantReason;
	}
	public void setApplicantReason(java.lang.String applicantReason) {
		this.applicantReason = applicantReason;
	}
	public java.util.Date getApplicantTime() {
		return applicantTime;
	}
	public void setApplicantTime(java.util.Date applicantTime) {
		this.applicantTime = applicantTime;
	}
	public java.lang.String getEducationalBackground() {
		return educationalBackground;
	}
	public void setEducationalBackground(java.lang.String educationalBackground) {
		this.educationalBackground = educationalBackground;
	}
	public java.lang.String getEconomyLeval() {
		return economyLeval;
	}
	public void setEconomyLeval(java.lang.String economyLeval) {
		this.economyLeval = economyLeval;
	}
	public java.lang.String getKindOfCrowd() {
		return kindOfCrowd;
	}
	public void setKindOfCrowd(java.lang.String kindOfCrowd) {
		this.kindOfCrowd = kindOfCrowd;
	}
	public java.lang.String getCasesSource() {
		return casesSource;
	}
	public void setCasesSource(java.lang.String casesSource) {
		this.casesSource = casesSource;
	}
	public java.lang.String getApplication() {
		return application;
	}
	public void setApplication(java.lang.String application) {
		this.application = application;
	}
	public java.lang.String getAidMethods() {
		return aidMethods;
	}
	public void setAidMethods(java.lang.String aidMethods) {
		this.aidMethods = aidMethods;
	}
	public java.lang.String getApplyStage() {
		return applyStage;
	}
	public void setApplyStage(java.lang.String applyStage) {
		this.applyStage = applyStage;
	}
	public java.lang.String getExaminationOpinion() {
		return examinationOpinion;
	}
	public void setExaminationOpinion(java.lang.String examinationOpinion) {
		this.examinationOpinion = examinationOpinion;
	}
	public java.lang.String getExaminationOpinionTime() {
		return examinationOpinionTime;
	}
	public void setExaminationOpinionTime(java.lang.String examinationOpinionTime) {
		this.examinationOpinionTime = examinationOpinionTime;
	}
	public java.lang.String getTrialOpinion() {
		return trialOpinion;
	}
	public void setTrialOpinion(java.lang.String trialOpinion) {
		this.trialOpinion = trialOpinion;
	}
	public java.lang.String getTrialOpinionTime() {
		return trialOpinionTime;
	}
	public void setTrialOpinionTime(java.lang.String trialOpinionTime) {
		this.trialOpinionTime = trialOpinionTime;
	}
	
	public java.lang.String getIfLeval() {
		return ifLeval;
	}
	public void setIfLeval(java.lang.String ifLeval) {
		this.ifLeval = ifLeval;
	}
	public java.lang.String getIfHave() {
		return ifHave;
	}
	public void setIfHave(java.lang.String ifHave) {
		this.ifHave = ifHave;
	}
	
	public java.lang.String getCaseSurvey() {
		return caseSurvey;
	}
	public void setCaseSurvey(java.lang.String caseSurvey) {
		this.caseSurvey = caseSurvey;
	}
	
	
	public java.lang.String getLegalWord() {
		return legalWord;
	}
	public void setLegalWord(java.lang.String legalWord) {
		this.legalWord = legalWord;
	}
	public java.lang.String getLegalCode() {
		return legalCode;
	}
	public void setLegalCode(java.lang.String legalCode) {
		this.legalCode = legalCode;
	}
	public java.lang.String getLegalNo() {
		return legalNo;
	}
	public void setLegalNo(java.lang.String legalNo) {
		this.legalNo = legalNo;
	}
	public java.lang.String getName() {
		return name;
	}
	public void setName(java.lang.String name) {
		this.name = name;
	}
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

