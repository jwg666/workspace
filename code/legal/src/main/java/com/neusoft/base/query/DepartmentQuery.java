/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.base.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.base.domain.Department;
import com.neusoft.base.model.SearchModel;
/**
 * database table: CD_DEPARTMENT
 * database table comments: Department
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
public class DepartmentQuery extends  SearchModel<Department> implements Serializable {
    
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
     * name       db_column: name 
     */	
	private java.lang.String name;
	  /**
     * parentId       db_column: parent_id 
     */	
	private java.lang.Long parentId;
	  /**
     * createTime       db_column: create_time 
     */	
	private java.util.Date createTime;
	  /**
     * createBy       db_column: create_by 
     */	
	private java.lang.Long createBy;
	  /**
     * description       db_column: description 
     */	
	private java.lang.String description;
	  /**
     * officePlace       db_column: office_place 
     */	
	private java.lang.String officePlace;
	  /**
     * officePhone       db_column: office_phone 
     */	
	private java.lang.String officePhone;
	  /**
     * officer       db_column: officer 
     */	
	private java.lang.Long officer;
	  /**
     * officePage       db_column: office_page 
     */	
	private java.lang.String officePage;
	  /**
     * fax       db_column: fax 
     */	
	private java.lang.String fax;
	  /**
     * email       db_column: email 
     */	
	private java.lang.String email;

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
     * parentId
     * @return parentId
     */
	public java.lang.Long getParentId() {
		return this.parentId;
	}
	 /**
     * parentId
     * @param parentId parentId
     */
	public void setParentId(java.lang.Long parentId) {
		this.parentId = parentId;
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
     * officePlace
     * @return officePlace
     */
	public java.lang.String getOfficePlace() {
		return this.officePlace;
	}
	 /**
     * officePlace
     * @param officePlace officePlace
     */
	public void setOfficePlace(java.lang.String officePlace) {
		this.officePlace = officePlace;
	}
	
	 /**
     * officePhone
     * @return officePhone
     */
	public java.lang.String getOfficePhone() {
		return this.officePhone;
	}
	 /**
     * officePhone
     * @param officePhone officePhone
     */
	public void setOfficePhone(java.lang.String officePhone) {
		this.officePhone = officePhone;
	}
	
	 /**
     * officer
     * @return officer
     */
	public java.lang.Long getOfficer() {
		return this.officer;
	}
	 /**
     * officer
     * @param officer officer
     */
	public void setOfficer(java.lang.Long officer) {
		this.officer = officer;
	}
	
	 /**
     * officePage
     * @return officePage
     */
	public java.lang.String getOfficePage() {
		return this.officePage;
	}
	 /**
     * officePage
     * @param officePage officePage
     */
	public void setOfficePage(java.lang.String officePage) {
		this.officePage = officePage;
	}
	
	 /**
     * fax
     * @return fax
     */
	public java.lang.String getFax() {
		return this.fax;
	}
	 /**
     * fax
     * @param fax fax
     */
	public void setFax(java.lang.String fax) {
		this.fax = fax;
	}
	
	 /**
     * email
     * @return email
     */
	public java.lang.String getEmail() {
		return this.email;
	}
	 /**
     * email
     * @param email email
     */
	public void setEmail(java.lang.String email) {
		this.email = email;
	}
	

	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

