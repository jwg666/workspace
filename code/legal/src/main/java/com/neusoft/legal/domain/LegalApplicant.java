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
@Table(name = "LE_LEGAL_APPLICANT")
public class LegalApplicant  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "法律援助申请人";
	public static final String ALIAS_ID = "id";
	public static final String ALIAS_NAME = "姓名";
	public static final String ALIAS_GENDER = "性别";
	public static final String ALIAS_BIRTHDAY = "生日";
	public static final String ALIAS_NATION_ID = "民族";
	public static final String ALIAS_IDENTIFYID = "证件号码";
	public static final String ALIAS_BIRTH_PLACE = "户口所在地";
	public static final String ALIAS_LIVE_PLACE = "目前居住地";
	public static final String ALIAS_POST_CODE = "邮政编码";
	public static final String ALIAS_PHONE = "电话号码";
	public static final String ALIAS_COMPANY = "工作单位";
	public static final String ALIAS_EDU_LEVEL_ID = "教育水平";
	public static final String ALIAS_AGENT_ID = "代理人";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	public static final String ALIAS_CATEGORY_ID = "申请人人群类别";
	public static final String ALIAS_IF_FINANCIAL_DIFFICULTY = "是否经济困难";
	
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
	private java.lang.String category;
    /**
     * ifFinancialDifficulty       db_column: if_financial_difficulty 
     */	
	private java.lang.String ifFinancialDifficulty;
	//columns END

	public LegalApplicant(){
	}

	public LegalApplicant(
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
		@Column(name="id")
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
	     * gender
	     * @return gender
	     */
		@Column(name="gender")
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
		@Column(name="birthday")
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
		@Column(name="nation_id")
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
	     * birthPlace
	     * @return birthPlace
	     */
		@Column(name="birth_place")
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
		@Column(name="live_place")
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
		@Column(name="post_code")
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
		@Column(name="phone")
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
		@Column(name="company")
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
		@Column(name="edu_level_id")
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
	     * categoryId
	     * @return categoryId
	     */
		@Column(name="category")
		public java.lang.String getCategory() {
			return this.category;
		}
		/**
	     * categoryId
	     * @param categoryId categoryId
	     */
		public void setCategory(java.lang.String category) {
			this.category = category;
		}
		 /**
	     * ifFinancialDifficulty
	     * @return ifFinancialDifficulty
	     */
		@Column(name="if_financial_difficulty")
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

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof LegalApplicant == false) return false;
		if(this == obj) return true;
		LegalApplicant other = (LegalApplicant)obj;
		return new EqualsBuilder()
			.append(getId(),other.getId())
			.isEquals();
	}
}

