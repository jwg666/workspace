/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.base.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

@Entity
@Table(name = "CD_DEPARTMENT")
public class Department  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "部门表";
	public static final String ALIAS_ID = "id";
	public static final String ALIAS_NAME = "名称";
	public static final String ALIAS_PARENT_ID = "上级ID";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	public static final String ALIAS_CREATE_BY = "创建人";
	public static final String ALIAS_DESCRIPTION = "描述";
	public static final String ALIAS_OFFICE_PLACE = "地点";
	public static final String ALIAS_OFFICE_PHONE = "电话";
	public static final String ALIAS_OFFICER = "负责人";
	public static final String ALIAS_OFFICE_PAGE = "主页";
	public static final String ALIAS_FAX = "传真";
	public static final String ALIAS_EMAIL = "公共邮箱";
	
    /**
     * id       db_column: ID 
     */	
	private java.lang.Long id;
    /**
     * name       db_column: name 
     */	
	private java.lang.String name;
    /**
     * parent       db_column: parent_id 
     */	

	private Department parent;
//	@OneToMany(targetEntity=Department.class,cascade=CascadeType.ALL)
//	@Fetch(FetchMode.JOIN)
//	//updatable=false很关键，如果没有它，在级联删除的时候就会报错(反转的问题)
//	@JoinColumn(name="parent_id",updatable=false)
//	private Set<Department> children = new HashSet<Department>();
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
	
	private Long lastUpdBy;
	
	private Date lastUpdTime;
	//columns END

	public Department(){
	}

	public Department(
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
	     * parentId
	     * @return parentId
	     */
//		@Column(name="parent_id")
//		public java.lang.Long getParentId() {
//			return this.parentId;
//		}
//		/**
//	     * parentId
//	     * @param parentId parentId
//	     */
//		public void setParentId(java.lang.Long parentId) {
//			this.parentId = parentId;
//		}
		
		 /**
	     * createTime
	     * @return createTime
	     */
		@Column(name="create_time")
		public java.util.Date getCreateTime() {
			return this.createTime;
		}
		//多对一，@JoinColumn与@column类似，指定映射的数据库字段
		@ManyToOne(targetEntity = Department.class)
		@JoinColumn(name="parent_id",updatable=false)
		public Department getParent() {
			return parent;
		}

		public void setParent(Department parent) {
			this.parent = parent;
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
		@Column(name="create_by")
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
		@Column(name="description")
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
		@Column(name="office_place")
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
		@Column(name="office_phone")
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
		@Column(name="officer")
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
		@Column(name="office_page")
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
		@Column(name="fax")
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
		@Column(name="email")
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
		@Column(name="last_upd_by")
		public Long getLastUpdBy() {
			return lastUpdBy;
		}

		public void setLastUpdBy(Long lastUpdBy) {
			this.lastUpdBy = lastUpdBy;
		}
		@Column(name="last_upd_time")
		public Date getLastUpdTime() {
			return lastUpdTime;
		}

		public void setLastUpdTime(Date lastUpdTime) {
			this.lastUpdTime = lastUpdTime;
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
		if(obj instanceof Department == false) return false;
		if(this == obj) return true;
		Department other = (Department)obj;
		return new EqualsBuilder()
			.append(getId(),other.getId())
			.isEquals();
	}
}

