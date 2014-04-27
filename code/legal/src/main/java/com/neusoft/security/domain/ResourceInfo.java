/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.domain;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name = "TB_RESOURCE_INFO")
public class ResourceInfo  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "RESOURCE_INFO";
	public static final String ALIAS_ID = "id";
	public static final String ALIAS_NAME = "name";
	public static final String ALIAS_DESCRIPTION = "description";
	public static final String ALIAS_URL = "url";
	public static final String ALIAS_TYPE = "0 URL  1 组件 2 待办";
	public static final String ALIAS_STATUS = "0  不可见  1 可见";
	public static final String ALIAS_CODE = "code";
	public static final String ALIAS_CONFIGURATION = "configuration";
	public static final String ALIAS_MODULE_NAME = "moduleName";
	public static final String ALIAS_GMT_CREATE = "gmtCreate";
	public static final String ALIAS_GMT_MODIFIED = "gmtModified";
	public static final String ALIAS_CREATE_BY = "createBy";
	public static final String ALIAS_LAST_MODIFIED_BY = "lastModifiedBy";
	public static final String ALIAS_ORDER_INDEX = "orderIndex";
	public static final String ALIAS_PARENT_ID = "parentId";
	public static final String ALIAS_NAME_EN = "nameEn";
	public static final String ALIAS_ICON_URL = "图标地址";
	public static final String ALIAS_WIDTH = "桌面打开应用窗口宽度";
	public static final String ALIAS_HEIGHT = "桌面打开应用窗口高度";
	
    /**
     * id       db_column: ID 
     */	
	private Long id;
    /**
     * name       db_column: NAME 
     */	
	private java.lang.String name;
    /**
     * description       db_column: DESCRIPTION 
     */	
	private java.lang.String description;
    /**
     * url       db_column: URL 
     */	
	private java.lang.String url;
    /**
     * 0 URL  1 组件 2 待办       db_column: TYPE 
     */	
	private java.lang.Integer type;
    /**
     * 0  不可见  1 可见       db_column: STATUS 
     */	
	private java.lang.Integer status;
    /**
     * code       db_column: CODE 
     */	
	private java.lang.String code;
    /**
     * configuration       db_column: CONFIGURATION 
     */	
	private java.lang.String configuration;
    /**
     * moduleName       db_column: MODULE_NAME 
     */	
	private java.lang.String moduleName;
    /**
     * gmtCreate       db_column: GMT_CREATE 
     */	
	private java.util.Date gmtCreate;
    /**
     * gmtModified       db_column: GMT_MODIFIED 
     */	
	private java.util.Date gmtModified;
    /**
     * createBy       db_column: CREATE_BY 
     */	
	private java.lang.String createBy;
    /**
     * lastModifiedBy       db_column: LAST_MODIFIED_BY 
     */	
	private java.lang.String lastModifiedBy;
    /**
     * orderIndex       db_column: ORDER_INDEX 
     */	
	private java.lang.Long orderIndex;
    /**
     * parentId       db_column: PARENT_ID 
     */	
	private Long parentId;
    /**
     * nameEn       db_column: NAME_EN 
     */	
	private java.lang.String nameEn;
    /**
     * 图标地址       db_column: ICON_URL 
     */	
	private java.lang.String iconUrl;
    /**
     * 桌面打开应用窗口宽度       db_column: WIDTH 
     */	
	private Integer width;
    /**
     * 桌面打开应用窗口高度       db_column: HEIGHT 
     */	
	private Integer height;
	//columns END
	//private Long memberId;
	//辅助字段 国家化
	//private String localName;
	private Set<ResourceInfo> children = new HashSet<ResourceInfo>();
	/*public Long gotMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	*/
	@OneToMany(targetEntity=ResourceInfo.class,cascade=CascadeType.ALL)
	@Fetch(FetchMode.JOIN)
	//updatable=false很关键，如果没有它，在级联删除的时候就会报错(反转的问题)
	@JoinColumn(name="PARENT_ID",updatable=false)
	public Set<ResourceInfo> getChildren() {
		return children;
	}

	public void setChildren(Set<ResourceInfo> children) {
		this.children = children;
	}

	/*public String gotLocalName() {
		return localName;
	}

	public void setLocalName(String localName) {
		this.localName = localName;
	}*/

	public ResourceInfo(){
	}

	public ResourceInfo(
		Long id
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
		public Long getId() {
			return this.id;
		}
		/**
	     * id
	     * @param id id
	     */
		public void setId(Long id) {
			this.id = id;
		}
		 /**
	     * name
	     * @return name
	     */
		@Column(name="NAME")
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
		 /**
	     * url
	     * @return url
	     */
		@Column(name="URL")
		public java.lang.String getUrl() {
			return this.url;
		}
		/**
	     * url
	     * @param url url
	     */
		public void setUrl(java.lang.String url) {
			this.url = url;
		}
		 /**
	     * 0 URL  1 组件 2 待办
	     * @return 0 URL  1 组件 2 待办
	     */
		@Column(name="TYPE")
		public java.lang.Integer getType() {
			return this.type;
		}
		/**
	     * 0 URL  1 组件 2 待办
	     * @param type 0 URL  1 组件 2 待办
	     */
		public void setType(java.lang.Integer type) {
			this.type = type;
		}
		 /**
	     * 0  不可见  1 可见
	     * @return 0  不可见  1 可见
	     */
		@Column(name="STATUS")
		public java.lang.Integer getStatus() {
			return this.status;
		}
		/**
	     * 0  不可见  1 可见
	     * @param status 0  不可见  1 可见
	     */
		public void setStatus(java.lang.Integer status) {
			this.status = status;
		}
		 /**
	     * code
	     * @return code
	     */
		@Column(name="CODE")
		public java.lang.String getCode() {
			return this.code;
		}
		/**
	     * code
	     * @param code code
	     */
		public void setCode(java.lang.String code) {
			this.code = code;
		}
		 /**
	     * configuration
	     * @return configuration
	     */
		@Column(name="CONFIGURATION")
		public java.lang.String getConfiguration() {
			return this.configuration;
		}
		/**
	     * configuration
	     * @param configuration configuration
	     */
		public void setConfiguration(java.lang.String configuration) {
			this.configuration = configuration;
		}
		 /**
	     * moduleName
	     * @return moduleName
	     */
		@Column(name="MODULE_NAME")
		public java.lang.String getModuleName() {
			return this.moduleName;
		}
		/**
	     * moduleName
	     * @param moduleName moduleName
	     */
		public void setModuleName(java.lang.String moduleName) {
			this.moduleName = moduleName;
		}
	
		 /**
	     * gmtCreate
	     * @return gmtCreate
	     */
		@Column(name="GMT_CREATE")
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
	     * gmtModified
	     * @return gmtModified
	     */
		@Column(name="GMT_MODIFIED")
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
	     * createBy
	     * @return createBy
	     */
		@Column(name="CREATE_BY")
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
	     * lastModifiedBy
	     * @return lastModifiedBy
	     */
		@Column(name="LAST_MODIFIED_BY")
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
	     * orderIndex
	     * @return orderIndex
	     */
		@Column(name="ORDER_INDEX")
		public java.lang.Long getOrderIndex() {
			return this.orderIndex;
		}
		/**
	     * orderIndex
	     * @param orderIndex orderIndex
	     */
		public void setOrderIndex(java.lang.Long orderIndex) {
			this.orderIndex = orderIndex;
		}
		 /**
	     * parentId
	     * @return parentId
	     */
		@Column(name="PARENT_ID")
		public Long getParentId() {
			return this.parentId;
		}
		/**
	     * parentId
	     * @param parentId parentId
	     */
		public void setParentId(Long parentId) {
			this.parentId = parentId;
		}
		 /**
	     * nameEn
	     * @return nameEn
	     */
		@Column(name="NAME_EN")
		public java.lang.String getNameEn() {
			return this.nameEn;
		}
		/**
	     * nameEn
	     * @param nameEn nameEn
	     */
		public void setNameEn(java.lang.String nameEn) {
			this.nameEn = nameEn;
		}
		 /**
	     * 图标地址
	     * @return 图标地址
	     */
		@Column(name="ICON_URL")
		public java.lang.String getIconUrl() {
			return this.iconUrl;
		}
		/**
	     * 图标地址
	     * @param iconUrl 图标地址
	     */
		public void setIconUrl(java.lang.String iconUrl) {
			this.iconUrl = iconUrl;
		}
		 /**
	     * 桌面打开应用窗口宽度
	     * @return 桌面打开应用窗口宽度
	     */
		@Column(name="WIDTH")
		public Integer getWidth() {
			return this.width;
		}
		/**
	     * 桌面打开应用窗口宽度
	     * @param width 桌面打开应用窗口宽度
	     */
		public void setWidth(Integer width) {
			this.width = width;
		}
		 /**
	     * 桌面打开应用窗口高度
	     * @return 桌面打开应用窗口高度
	     */
		@Column(name="HEIGHT")
		public Integer getHeight() {
			return this.height;
		}
		/**
	     * 桌面打开应用窗口高度
	     * @param height 桌面打开应用窗口高度
	     */
		public void setHeight(Integer height) {
			this.height = height;
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
		if(obj instanceof ResourceInfo == false) return false;
		if(this == obj) return true;
		ResourceInfo other = (ResourceInfo)obj;
		return new EqualsBuilder()
			.append(getId(),other.getId())
			.isEquals();
	}
}

