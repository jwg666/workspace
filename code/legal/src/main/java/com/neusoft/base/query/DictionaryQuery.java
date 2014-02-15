/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.base.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.base.domain.Dictionary;
import com.neusoft.base.model.SearchModel;
/**
 * database table: CD_DICTIONARY
 * database table comments: Dictionary
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
public class DictionaryQuery extends  SearchModel<Dictionary> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    
  	private String[] ids;
	public String[] getIds() {
		return ids;
	}
	public void setIds(String[] ids) {
		this.ids = ids;
	}


	/**
     * id       db_column: ID 
     */	
	private java.lang.Long id;
	  /**
     * dicCode       db_column: DIC_CODE 
     */	
	private java.lang.String dicCode;
	  /**
     * dicValue       db_column: DIC_VALUE 
     */	
	private java.lang.String dicValue;
	  /**
     * parentCode       db_column: PARENT_CODE 
     */	
	private java.lang.String parentCode;
	  /**
     * createTime       db_column: CREATE_TIME 
     */	
	private java.util.Date createTime;
	  /**
     * createBy       db_column: CREATE_BY 
     */	
	private java.lang.Long createBy;
	  /**
     * description       db_column: DESCRIPTION 
     */	
	private java.lang.String description;
	  /**
     * 1地区 2.民族 3.人群类别 4.申请事项 5.处理阶段 6.文化程度 7.案件理由       db_column: DIC_TYPE 
     */	
	private java.lang.String dicType;

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
     * dicCode
     * @return dicCode
     */
	public java.lang.String getDicCode() {
		return this.dicCode;
	}
	 /**
     * dicCode
     * @param dicCode dicCode
     */
	public void setDicCode(java.lang.String dicCode) {
		this.dicCode = dicCode;
	}
	
	 /**
     * dicValue
     * @return dicValue
     */
	public java.lang.String getDicValue() {
		return this.dicValue;
	}
	 /**
     * dicValue
     * @param dicValue dicValue
     */
	public void setDicValue(java.lang.String dicValue) {
		this.dicValue = dicValue;
	}
	
	 /**
     * parentCode
     * @return parentCode
     */
	public java.lang.String getParentCode() {
		return this.parentCode;
	}
	 /**
     * parentCode
     * @param parentCode parentCode
     */
	public void setParentCode(java.lang.String parentCode) {
		this.parentCode = parentCode;
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
     * 1地区 2.民族 3.人群类别 4.申请事项 5.处理阶段 6.文化程度 7.案件理由
     * @return 1地区 2.民族 3.人群类别 4.申请事项 5.处理阶段 6.文化程度 7.案件理由
     */
	public java.lang.String getDicType() {
		return this.dicType;
	}
	 /**
     * 1地区 2.民族 3.人群类别 4.申请事项 5.处理阶段 6.文化程度 7.案件理由
     * @param dicType 1地区 2.民族 3.人群类别 4.申请事项 5.处理阶段 6.文化程度 7.案件理由
     */
	public void setDicType(java.lang.String dicType) {
		this.dicType = dicType;
	}
	

	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

