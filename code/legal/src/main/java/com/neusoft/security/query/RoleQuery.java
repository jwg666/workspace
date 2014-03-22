/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.query;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import java.io.Serializable;

import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.Role;
/**
 * database table: TB_ROLE
 * database table comments: Role
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
public class RoleQuery extends  SearchModel<Role> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    
     private java.lang.Long[] ids;
	  /**
     * id       db_column: ID 
     */	
	private java.lang.Long id;
	  /**
     * createBy       db_column: CREATE_BY 
     */	
	private java.lang.String createBy;
	  /**
     * deletedFlag       db_column: DELETED_FLAG 
     */	
	private java.lang.String deletedFlag;
	  /**
     * description       db_column: DESCRIPTION 
     */	
	private java.lang.String description;
	  /**
     * gmtCreate       db_column: GMT_CREATE 
     */	
	private java.util.Date gmtCreate;
	  /**
     * gmtCreateString       db_column: gmtCreateString 
     */	
	private java.lang.String gmtCreateString;
	  /**
     * gmtModified       db_column: GMT_MODIFIED 
     */	
	private java.util.Date gmtModified;
	  /**
     * gmtModifiedString       db_column: gmtModifiedString 
     */	
	private java.lang.String gmtModifiedString;
	  /**
     * lastModifiedBy       db_column: LAST_MODIFIED_BY 
     */	
	private java.lang.String lastModifiedBy;
	  /**
     * name       db_column: NAME 
     */	
	private java.lang.String name;
	  /**
     * usingFlag       db_column: USING_FLAG 
     */	
	private java.lang.String usingFlag;

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
     * createBy
     * @return createBy
     */
	public java.lang.String getCreateBy() {
		return this.createBy;
	}
	 /**
     * createBy
     * @param createBy createBy
     */
	public void setCreateBy(java.lang.String createBy) {
		this.createBy = createBy;
	}
	
	 /**
     * deletedFlag
     * @return deletedFlag
     */
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
     * gmtCreate
     * @return gmtCreate
     */
	public java.util.Date getGmtCreate() {
		return this.gmtCreate;
	}
	 /**
     * gmtCreate
     * @param gmtCreate gmtCreate
     */
	public void setGmtCreate(java.util.Date gmtCreate) {
		this.gmtCreate = gmtCreate;
	}
	
	 /**
     * gmtCreateString
     * @return gmtCreateString
     */
	public java.lang.String getGmtCreateString() {
		return this.gmtCreateString;
	}
	 /**
     * gmtCreateString
     * @param gmtCreateString gmtCreateString
     */
	public void setGmtCreateString(java.lang.String gmtCreateString) {
		this.gmtCreateString = gmtCreateString;
	}
	
	 /**
     * gmtModified
     * @return gmtModified
     */
	public java.util.Date getGmtModified() {
		return this.gmtModified;
	}
	 /**
     * gmtModified
     * @param gmtModified gmtModified
     */
	public void setGmtModified(java.util.Date gmtModified) {
		this.gmtModified = gmtModified;
	}
	
	 /**
     * gmtModifiedString
     * @return gmtModifiedString
     */
	public java.lang.String getGmtModifiedString() {
		return this.gmtModifiedString;
	}
	 /**
     * gmtModifiedString
     * @param gmtModifiedString gmtModifiedString
     */
	public void setGmtModifiedString(java.lang.String gmtModifiedString) {
		this.gmtModifiedString = gmtModifiedString;
	}
	
	 /**
     * lastModifiedBy
     * @return lastModifiedBy
     */
	public java.lang.String getLastModifiedBy() {
		return this.lastModifiedBy;
	}
	 /**
     * lastModifiedBy
     * @param lastModifiedBy lastModifiedBy
     */
	public void setLastModifiedBy(java.lang.String lastModifiedBy) {
		this.lastModifiedBy = lastModifiedBy;
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
     * usingFlag
     * @return usingFlag
     */
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

