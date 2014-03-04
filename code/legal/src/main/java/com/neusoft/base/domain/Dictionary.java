/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.base.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.neusoft.base.common.DateUtils;

@Entity
@Table(name = "CD_DICTIONARY")
public class Dictionary  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "数据字典";
	public static final String ALIAS_ID = "id";
	public static final String ALIAS_DIC_CODE = "编码";
	public static final String ALIAS_DIC_VALUE = "值";
	public static final String ALIAS_PARENT_CODE = "上级编码";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	public static final String ALIAS_CREATE_BY = "创建人";
	public static final String ALIAS_DESCRIPTION = "描述";
	
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

	public Dictionary(){
	}

	public Dictionary(
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
	     * dicCode
	     * @return dicCode
	     */
		@Column(name="DIC_CODE")
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
		@Column(name="DIC_VALUE")
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
		@Column(name="PARENT_CODE")
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
		 /**
	     * createBy
	     * @return createBy
	     */
		@Column(name="CREATE_BY")
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
		@Column(name="DESCRIPTION")
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

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof Dictionary == false) return false;
		if(this == obj) return true;
		Dictionary other = (Dictionary)obj;
		return new EqualsBuilder()
			.append(getId(),other.getId())
			.isEquals();
	}
}

