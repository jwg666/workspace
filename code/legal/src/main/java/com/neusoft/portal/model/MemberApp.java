/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.portal.model;

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
@Table(name = "TB_MEMBER_APP")
public class MemberApp  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "TB_MEMBER_APP";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_REALID = "真实id";
	public static final String ALIAS_NAME = "图标名称";
	public static final String ALIAS_TYPE = "应用类型";
	public static final String ALIAS_WIDTH = "窗口宽度";
	public static final String ALIAS_HEIGHT = "窗口高度";
	public static final String ALIAS_ISRESIZE = "是否能对窗口进行拉伸";
	public static final String ALIAS_ISOPENMAX = "是否打开直接最大化";
	public static final String ALIAS_ISSETBAR = "窗口是否有评分和介绍按钮";
	public static final String ALIAS_ISFLASH = "是否为flash应用";
	public static final String ALIAS_DT = "创建时间";
	public static final String ALIAS_LASTDT = "最后修改时间";
	public static final String ALIAS_FOLDER_ID = "文件夹id";
	public static final String ALIAS_MEMBER_ID = "用户id";
	public static final String ALIAS_ICON = "图标图片";
	public static final String ALIAS_URL = "URL 链接";
	
    /**
     * tbid       db_column: TBID 
     */	
	private Long tbid;
    /**
     * 真实id       db_column: REALID 
     */	
	private Long realid;
    /**
     * 图标名称       db_column: NAME 
     */	
	private java.lang.String name;
    /**
     * 应用类型       db_column: TYPE 
     */	
	private java.lang.String type;
    /**
     * 窗口宽度       db_column: WIDTH 
     */	
	private java.lang.Integer width;
    /**
     * 窗口高度       db_column: HEIGHT 
     */	
	private java.lang.Long height;
    /**
     * 是否能对窗口进行拉伸       db_column: ISRESIZE 
     */	
	private Integer isresize;
    /**
     * 是否打开直接最大化       db_column: ISOPENMAX 
     */	
	private Integer isopenmax;
    /**
     * 窗口是否有评分和介绍按钮       db_column: ISSETBAR 
     */	
	private Integer issetbar;
    /**
     * 是否为flash应用       db_column: ISFLASH 
     */	
	private Integer isflash;
    /**
     * 创建时间       db_column: DT 
     */	
	private java.util.Date dt;
    /**
     * 最后修改时间       db_column: LASTDT 
     */	
	private java.util.Date lastdt;
    /**
     * 文件夹id       db_column: FOLDER_ID 
     */	
	private Long folderId;
    /**
     * 用户id       db_column: MEMBER_ID 
     */	
	private Long memberId;
    /**
     * 图标图片       db_column: ICON 
     */	
	private java.lang.String icon;
    /**
     * URL 链接       db_column: URL 
     */	
	private java.lang.String url;
	//columns END
	//辅助字段 查询resource_info 表的url 
	private java.lang.String resourceUrl;
	//辅助字段 查询code 国际化
	private java.lang.String code;
	private java.lang.String localName;
	
	public MemberApp(){
	}

	public MemberApp(
		Long tbid
	){
		this.tbid = tbid;
	}

		 /**
	     * tbid
	     * @return tbid
	     */
		@Id  
	    @GeneratedValue
		@Column(name="TBID")
		public Long getTbid() {
			return this.tbid;
		}
		/**
	     * tbid
	     * @param tbid tbid
	     */
		public void setTbid(Long tbid) {
			this.tbid = tbid;
		}
		 /**
	     * 真实id
	     * @return 真实id
	     */
		@Column(name="REALID")
		public Long getRealid() {
			return this.realid;
		}
		/**
	     * 真实id
	     * @param realid 真实id
	     */
		public void setRealid(Long realid) {
			this.realid = realid;
		}
		 /**
	     * 图标名称
	     * @return 图标名称
	     */
		@Column(name="NAME")
		public java.lang.String getName() {
			return this.name;
		}
		/**
	     * 图标名称
	     * @param name 图标名称
	     */
		public void setName(java.lang.String name) {
			this.name = name;
		}
		 /**
	     * 应用类型
	     * @return 应用类型
	     */
		@Column(name="TYPE")
		public java.lang.String getType() {
			return this.type;
		}
		/**
	     * 应用类型
	     * @param type 应用类型
	     */
		public void setType(java.lang.String type) {
			this.type = type;
		}
		 /**
	     * 窗口宽度
	     * @return 窗口宽度
	     */
		@Column(name="WIDTH")
		public java.lang.Integer getWidth() {
			return this.width;
		}
		/**
	     * 窗口宽度
	     * @param width 窗口宽度
	     */
		public void setWidth(java.lang.Integer width) {
			this.width = width;
		}
		 /**
	     * 窗口高度
	     * @return 窗口高度
	     */
		@Column(name="HEIGHT")
		public java.lang.Long getHeight() {
			return this.height;
		}
		/**
	     * 窗口高度
	     * @param height 窗口高度
	     */
		public void setHeight(java.lang.Long height) {
			this.height = height;
		}
		 /**
	     * 是否能对窗口进行拉伸
	     * @return 是否能对窗口进行拉伸
	     */
		@Column(name="ISRESIZE")
		public Integer getIsresize() {
			return this.isresize;
		}
		/**
	     * 是否能对窗口进行拉伸
	     * @param isresize 是否能对窗口进行拉伸
	     */
		public void setIsresize(Integer isresize) {
			this.isresize = isresize;
		}
		 /**
	     * 是否打开直接最大化
	     * @return 是否打开直接最大化
	     */
		@Column(name="ISOPENMAX")
		public Integer getIsopenmax() {
			return this.isopenmax;
		}
		/**
	     * 是否打开直接最大化
	     * @param isopenmax 是否打开直接最大化
	     */
		public void setIsopenmax(Integer isopenmax) {
			this.isopenmax = isopenmax;
		}
		 /**
	     * 窗口是否有评分和介绍按钮
	     * @return 窗口是否有评分和介绍按钮
	     */
		@Column(name="ISSETBAR")
		public Integer getIssetbar() {
			return this.issetbar;
		}
		/**
	     * 窗口是否有评分和介绍按钮
	     * @param issetbar 窗口是否有评分和介绍按钮
	     */
		public void setIssetbar(Integer issetbar) {
			this.issetbar = issetbar;
		}
		 /**
	     * 是否为flash应用
	     * @return 是否为flash应用
	     */
		@Column(name="ISFLASH")
		public Integer getIsflash() {
			return this.isflash;
		}
		/**
	     * 是否为flash应用
	     * @param isflash 是否为flash应用
	     */
		public void setIsflash(Integer isflash) {
			this.isflash = isflash;
		}
	    /**
	     * 创建时间
	     * @return 创建时间
	     */
	public String getDtString() {
		//return DateConvertUtils.format(getDt(), FORMAT_DT);
		return  DateUtils.format(DateUtils.FORMAT3,getDt());
	}
	 /**
     * 创建时间
     * @param dt 创建时间
     */
	public void setDtString(String dt) {
		setDt(DateUtils.parse(dt,DateUtils.FORMAT3,java.util.Date.class));
	}
	
		 /**
	     * 创建时间
	     * @return 创建时间
	     */
		@Column(name="DT")
		public java.util.Date getDt() {
			return this.dt;
		}
		/**
	     * 创建时间
	     * @param dt 创建时间
	     */
		public void setDt(java.util.Date dt) {
			this.dt = dt;
		}
	    /**
	     * 最后修改时间
	     * @return 最后修改时间
	     */
	public String getLastdtString() {
		//return DateConvertUtils.format(getLastdt(), FORMAT_LASTDT);
		return  DateUtils.format(DateUtils.FORMAT3,getLastdt());
	}
	 /**
     * 最后修改时间
     * @param lastdt 最后修改时间
     */
	public void setLastdtString(String lastdt) {
		setLastdt(DateUtils.parse(lastdt,DateUtils.FORMAT3,java.util.Date.class));
	}
	
		 /**
	     * 最后修改时间
	     * @return 最后修改时间
	     */
		@Column(name="LASTDT")
		public java.util.Date getLastdt() {
			return this.lastdt;
		}
		/**
	     * 最后修改时间
	     * @param lastdt 最后修改时间
	     */
		public void setLastdt(java.util.Date lastdt) {
			this.lastdt = lastdt;
		}
		 /**
	     * 文件夹id
	     * @return 文件夹id
	     */
		@Column(name="FOLDER_ID")
		public Long getFolderId() {
			return this.folderId;
		}
		/**
	     * 文件夹id
	     * @param folderId 文件夹id
	     */
		public void setFolderId(Long folderId) {
			this.folderId = folderId;
		}
		 /**
	     * 用户id
	     * @return 用户id
	     */
		@Column(name="MEMBER_ID")
		public Long getMemberId() {
			return this.memberId;
		}
		/**
	     * 用户id
	     * @param memberId 用户id
	     */
		public void setMemberId(Long memberId) {
			this.memberId = memberId;
		}
		 /**
	     * 图标图片
	     * @return 图标图片
	     */
		@Column(name="ICON")
		public java.lang.String getIcon() {
			return this.icon;
		}
		/**
	     * 图标图片
	     * @param icon 图标图片
	     */
		public void setIcon(java.lang.String icon) {
			this.icon = icon;
		}
		 /**
	     * URL 链接
	     * @return URL 链接
	     */
		@Column(name="URL")
		public java.lang.String getUrl() {
			return this.url;
		}
		/**
	     * URL 链接
	     * @param url URL 链接
	     */
		public void setUrl(java.lang.String url) {
			this.url = url;
		}
		
		
	public java.lang.String gotResourceUrl() {
			return resourceUrl;
		}

		public void setResourceUrl(java.lang.String resourceUrl) {
			this.resourceUrl = resourceUrl;
		}

		public java.lang.String gotCode() {
			return code;
		}

		public void setCode(java.lang.String code) {
			this.code = code;
		}

		public java.lang.String gotLocalName() {
			return localName;
		}

		public void setLocalName(java.lang.String localName) {
			this.localName = localName;
		}

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getTbid())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof MemberApp == false) return false;
		if(this == obj) return true;
		MemberApp other = (MemberApp)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

