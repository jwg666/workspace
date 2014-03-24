/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.base.model.SearchModel;
import com.neusoft.legal.domain.LegalCase;
/**
 * database table: LE_LEGAL_CASE
 * database table comments: LegalCase
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
public class LegalCaseQuery extends  SearchModel<LegalCase> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    
     private java.lang.Long[] ids;
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
	private Long legalId;//律师事务所
	//（$legalWord）援审字（$legalCode）第（$legalNo）号
	private String legalCode;
	private String legalNo;
	private String legalWord;
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
     * applicantId
     * @return applicantId
     */
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
	
	
	public java.lang.Long[] getIds() {
		return ids;
	}
	
	public void setIds(java.lang.Long[] ids) {
		this.ids = ids;
	}

	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	public Long getLegalId() {
		return legalId;
	}
	public void setLegalId(Long legalId) {
		this.legalId = legalId;
	}
	public String getLegalCode() {
		return legalCode;
	}
	public void setLegalCode(String legalCode) {
		this.legalCode = legalCode;
	}
	public String getLegalNo() {
		return legalNo;
	}
	public void setLegalNo(String legalNo) {
		this.legalNo = legalNo;
	}
	public String getLegalWord() {
		return legalWord;
	}
	public void setLegalWord(String legalWord) {
		this.legalWord = legalWord;
	}
	
}

