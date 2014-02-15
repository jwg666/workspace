/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.base.model.SearchModel;
import com.neusoft.legal.domain.LegalApplicant;
/**
 * database table: LE_LEGAL_APPLICANT
 * database table comments: LegalApplicant
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
public class LegalApplicantQuery extends  SearchModel<LegalApplicant> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    
     private java.lang.Long[] ids;
	  /**
     * id       db_column: id 
     */	
	private java.lang.Long id;
	  /**
     * name       db_column: name 
     */	
	private java.lang.String name;
	  /**
     * gender       db_column: gender 
     */	
	private java.lang.String gender;
	  /**
     * birthday       db_column: birthday 
     */	
	private java.util.Date birthday;
	  /**
     * nationId       db_column: nation_id 
     */	
	private java.lang.Long nationId;
	  /**
     * identifyid       db_column: identifyid 
     */	
	private java.lang.String identifyid;
	  /**
     * birthPlace       db_column: birth_place 
     */	
	private java.lang.String birthPlace;
	  /**
     * livePlace       db_column: live_place 
     */	
	private java.lang.String livePlace;
	  /**
     * postCode       db_column: post_code 
     */	
	private java.lang.String postCode;
	  /**
     * phone       db_column: phone 
     */	
	private java.lang.String phone;
	  /**
     * company       db_column: company 
     */	
	private java.lang.String company;
	  /**
     * eduLevelId       db_column: edu_level_id 
     */	
	private java.lang.Long eduLevelId;
	  /**
     * agentId       db_column: agent_id 
     */	
	private java.lang.Long agentId;
	  /**
     * createTime       db_column: create_time 
     */	
	private java.util.Date createTime;
	  /**
     * categoryId       db_column: category_id 
     */	
	private java.lang.Long categoryId;
	  /**
     * ifFinancialDifficulty       db_column: if_financial_difficulty 
     */	
	private java.lang.String ifFinancialDifficulty;

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
     * gender
     * @return gender
     */
	public java.lang.String getGender() {
		return this.gender;
	}
	 /**
     * gender
     * @param gender gender
     */
	public void setGender(java.lang.String gender) {
		this.gender = gender;
	}
	
	 /**
     * birthday
     * @return birthday
     */
	public java.util.Date getBirthday() {
		return this.birthday;
	}
	 /**
     * birthday
     * @param birthday birthday
     */
	public void setBirthday(java.util.Date birthday) {
		this.birthday = birthday;
	}
	
	 /**
     * nationId
     * @return nationId
     */
	public java.lang.Long getNationId() {
		return this.nationId;
	}
	 /**
     * nationId
     * @param nationId nationId
     */
	public void setNationId(java.lang.Long nationId) {
		this.nationId = nationId;
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
     * birthPlace
     * @return birthPlace
     */
	public java.lang.String getBirthPlace() {
		return this.birthPlace;
	}
	 /**
     * birthPlace
     * @param birthPlace birthPlace
     */
	public void setBirthPlace(java.lang.String birthPlace) {
		this.birthPlace = birthPlace;
	}
	
	 /**
     * livePlace
     * @return livePlace
     */
	public java.lang.String getLivePlace() {
		return this.livePlace;
	}
	 /**
     * livePlace
     * @param livePlace livePlace
     */
	public void setLivePlace(java.lang.String livePlace) {
		this.livePlace = livePlace;
	}
	
	 /**
     * postCode
     * @return postCode
     */
	public java.lang.String getPostCode() {
		return this.postCode;
	}
	 /**
     * postCode
     * @param postCode postCode
     */
	public void setPostCode(java.lang.String postCode) {
		this.postCode = postCode;
	}
	
	 /**
     * phone
     * @return phone
     */
	public java.lang.String getPhone() {
		return this.phone;
	}
	 /**
     * phone
     * @param phone phone
     */
	public void setPhone(java.lang.String phone) {
		this.phone = phone;
	}
	
	 /**
     * company
     * @return company
     */
	public java.lang.String getCompany() {
		return this.company;
	}
	 /**
     * company
     * @param company company
     */
	public void setCompany(java.lang.String company) {
		this.company = company;
	}
	
	 /**
     * eduLevelId
     * @return eduLevelId
     */
	public java.lang.Long getEduLevelId() {
		return this.eduLevelId;
	}
	 /**
     * eduLevelId
     * @param eduLevelId eduLevelId
     */
	public void setEduLevelId(java.lang.Long eduLevelId) {
		this.eduLevelId = eduLevelId;
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
     * categoryId
     * @return categoryId
     */
	public java.lang.Long getCategoryId() {
		return this.categoryId;
	}
	 /**
     * categoryId
     * @param categoryId categoryId
     */
	public void setCategoryId(java.lang.Long categoryId) {
		this.categoryId = categoryId;
	}
	
	 /**
     * ifFinancialDifficulty
     * @return ifFinancialDifficulty
     */
	public java.lang.String getIfFinancialDifficulty() {
		return this.ifFinancialDifficulty;
	}
	 /**
     * ifFinancialDifficulty
     * @param ifFinancialDifficulty ifFinancialDifficulty
     */
	public void setIfFinancialDifficulty(java.lang.String ifFinancialDifficulty) {
		this.ifFinancialDifficulty = ifFinancialDifficulty;
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

