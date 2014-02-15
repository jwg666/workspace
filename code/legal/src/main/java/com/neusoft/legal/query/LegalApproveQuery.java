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

	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

