/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.domain;

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
@Table(name = "TB_ROLE")
public class Role  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "TB_ROLE";
	public static final String ALIAS_ID = "自增长ID";
	public static final String ALIAS_NAME = "角色名称";
	public static final String ALIAS_DESCRIPTION = "角色描述";
	public static final String ALIAS_GMT_CREATE = "创建时间";
	public static final String ALIAS_GMT_MODIFIED = "最后修改时间";
	public static final String ALIAS_CREATE_BY = "创建者";
	public static final String ALIAS_LAST_MODIFIED_BY = "最后修改者";
	public static final String ALIAS_DELETED_FLAG = "deletedFlag";
	public static final String ALIAS_USING_FLAG = "usingFlag";
	
    /**
     * 自增长ID       db_column: ID 
     */	
	private Long id;
    /**
     * 角色名称       db_column: NAME 
     */	
	private java.lang.String name;
    /**
     * 角色描述       db_column: DESCRIPTION 
     */	
	private java.lang.String description;
    /**
     * 创建时间       db_column: GMT_CREATE 
     */	
	private java.util.Date gmtCreate;
    /**
     * 最后修改时间       db_column: GMT_MODIFIED 
     */	
	private java.util.Date gmtModified;
    /**
     * 创建者       db_column: CREATE_BY 
     */	
	private java.lang.String createBy;
    /**
     * 最后修改者       db_column: LAST_MODIFIED_BY 
     */	
	private java.lang.String lastModifiedBy;
    /**
     * deletedFlag       db_column: DELETED_FLAG 
     */	
	private java.lang.String deletedFlag;
    /**
     * usingFlag       db_column: USING_FLAG 
     */	
	private java.lang.String usingFlag;
	//columns END

	public Role(){
	}

	public Role(
		Long id
	){
		this.id = id;
	}

		 /**
	     * 自增长ID
	     * @return 自增长ID
	     */
		@Id  
	    @GeneratedValue
		@Column(name="ID")
		public Long getId() {
			return this.id;
		}
		/**
	     * 自增长ID
	     * @param id 自增长ID
	     */
		public void setId(Long id) {
			this.id = id;
		}
		 /**
	     * 角色名称
	     * @return 角色名称
	     */
		@Column(name="NAME")
		public java.lang.String getName() {
			return this.name;
		}
		/**
	     * 角色名称
	     * @param name 角色名称
	     */
		public void setName(java.lang.String name) {
			this.name = name;
		}
		 /**
	     * 角色描述
	     * @return 角色描述
	     */
		@Column(name="DESCRIPTION")
		public java.lang.String getDescription() {
			return this.description;
		}
		/**
	     * 角色描述
	     * @param description 角色描述
	     */
		public void setDescription(java.lang.String description) {
			this.description = description;
		}
	    /**
	     * 创建时间
	     * @return 创建时间
	     */
	public String getGmtCreateString() {
		//return DateConvertUtils.format(getGmtCreate(), FORMAT_GMT_CREATE);
		return  DateUtils.format(DateUtils.FORMAT3,getGmtCreate());
	}
	 /**
     * 创建时间
     * @param gmtCreate 创建时间
     */
	public void setGmtCreateString(String gmtCreate) {
		setGmtCreate(DateUtils.parse(gmtCreate,DateUtils.FORMAT3,java.util.Date.class));
	}
	
		 /**
	     * 创建时间
	     * @return 创建时间
	     */
		@Column(name="GMT_CREATE")
		public java.util.Date getGmtCreate() {
			return this.gmtCreate;
		}
		/**
	     * 创建时间
	     * @param gmtCreate 创建时间
	     */
		public void setGmtCreate(java.util.Date gmtCreate) {
			this.gmtCreate = gmtCreate;
		}
	    /**
	     * 最后修改时间
	     * @return 最后修改时间
	     */
	public String getGmtModifiedString() {
		//return DateConvertUtils.format(getGmtModified(), FORMAT_GMT_MODIFIED);
		return  DateUtils.format(DateUtils.FORMAT3,getGmtModified());
	}
	 /**
     * 最后修改时间
     * @param gmtModified 最后修改时间
     */
	public void setGmtModifiedString(String gmtModified) {
		setGmtModified(DateUtils.parse(gmtModified,DateUtils.FORMAT3,java.util.Date.class));
	}
	
		 /**
	     * 最后修改时间
	     * @return 最后修改时间
	     */
		@Column(name="GMT_MODIFIED")
		public java.util.Date getGmtModified() {
			return this.gmtModified;
		}
		/**
	     * 最后修改时间
	     * @param gmtModified 最后修改时间
	     */
		public void setGmtModified(java.util.Date gmtModified) {
			this.gmtModified = gmtModified;
		}
		 /**
	     * 创建者
	     * @return 创建者
	     */
		@Column(name="CREATE_BY")
		public java.lang.String getCreateBy() {
			return this.createBy;
		}
		/**
	     * 创建者
	     * @param createBy 创建者
	     */
		public void setCreateBy(java.lang.String createBy) {
			this.createBy = createBy;
		}
		 /**
	     * 最后修改者
	     * @return 最后修改者
	     */
		@Column(name="LAST_MODIFIED_BY")
		public java.lang.String getLastModifiedBy() {
			return this.lastModifiedBy;
		}
		/**
	     * 最后修改者
	     * @param lastModifiedBy 最后修改者
	     */
		public void setLastModifiedBy(java.lang.String lastModifiedBy) {
			this.lastModifiedBy = lastModifiedBy;
		}
		 /**
	     * deletedFlag
	     * @return deletedFlag
	     */
		@Column(name="DELETED_FLAG")
		public java.lang.String getDeletedFlag() {
			return this.deletedFlag;
		}
		/**
	     * deletedFlag
	     * @param deletedFlag deletedFlag
	     */
		public void setDeletedFlag(java.lang.String deletedFlag) {
			this.deletedFlag = deletedFlag;
		}
		 /**
	     * usingFlag
	     * @return usingFlag
	     */
		@Column(name="USING_FLAG")
		public java.lang.String getUsingFlag() {
			return this.usingFlag;
		}
		/**
	     * usingFlag
	     * @param usingFlag usingFlag
	     */
		public void setUsingFlag(java.lang.String usingFlag) {
			this.usingFlag = usingFlag;
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
		if(obj instanceof Role == false) return false;
		if(this == obj) return true;
		Role other = (Role)obj;
		return new EqualsBuilder()
			.append(getId(),other.getId())
			.isEquals();
	}
}

