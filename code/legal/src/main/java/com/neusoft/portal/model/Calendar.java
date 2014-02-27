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
@Table(name = "TB_CALENDAR")
public class Calendar  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "TB_CALENDAR";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_TITLE = "标题";
	public static final String ALIAS_CONTENT = "详细内容";
	public static final String ALIAS_URL = "超链接";
	public static final String ALIAS_STARTDT = "开始时间";
	public static final String ALIAS_ENDDT = "结束时间";
	public static final String ALIAS_ISALLDAY = "是否属于全天任务";
	public static final String ALIAS_MEMBER_ID = "memberId";
	
    /**
     * tbid       db_column: TBID 
     */	
	private Long tbid;
    /**
     * 标题       db_column: TITLE 
     */	
	private java.lang.String title;
    /**
     * 详细内容       db_column: CONTENT 
     */	
	private java.lang.String content;
    /**
     * 超链接       db_column: URL 
     */	
	private java.lang.String url;
    /**
     * 开始时间       db_column: STARTDT 
     */	
	private java.util.Date startdt;
    /**
     * 结束时间       db_column: ENDDT 
     */	
	private java.util.Date enddt;
    /**
     * 是否属于全天任务       db_column: ISALLDAY 
     */	
	private Integer isallday;
    /**
     * memberId       db_column: MEMBER_ID 
     */	
	private Long memberId;
	//columns END

	public Calendar(){
	}

	public Calendar(
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
	     * 标题
	     * @return 标题
	     */
		@Column(name="TITLE")
		public java.lang.String getTitle() {
			return this.title;
		}
		/**
	     * 标题
	     * @param title 标题
	     */
		public void setTitle(java.lang.String title) {
			this.title = title;
		}
		 /**
	     * 详细内容
	     * @return 详细内容
	     */
		@Column(name="CONTENT")
		public java.lang.String getContent() {
			return this.content;
		}
		/**
	     * 详细内容
	     * @param content 详细内容
	     */
		public void setContent(java.lang.String content) {
			this.content = content;
		}
		 /**
	     * 超链接
	     * @return 超链接
	     */
		@Column(name="URL")
		public java.lang.String getUrl() {
			return this.url;
		}
		/**
	     * 超链接
	     * @param url 超链接
	     */
		public void setUrl(java.lang.String url) {
			this.url = url;
		}

	
		 /**
	     * 开始时间
	     * @return 开始时间
	     */
		@Column(name="STARTDT")
		public java.util.Date getStartdt() {
			return this.startdt;
		}
		/**
	     * 开始时间
	     * @param startdt 开始时间
	     */
		public void setStartdt(java.util.Date startdt) {
			this.startdt = startdt;
		}

	
		 /**
	     * 结束时间
	     * @return 结束时间
	     */
		@Column(name="ENDDT")
		public java.util.Date getEnddt() {
			return this.enddt;
		}
		/**
	     * 结束时间
	     * @param enddt 结束时间
	     */
		public void setEnddt(java.util.Date enddt) {
			this.enddt = enddt;
		}
		 /**
	     * 是否属于全天任务
	     * @return 是否属于全天任务
	     */
		@Column(name="ISALLDAY")
		public Integer getIsallday() {
			return this.isallday;
		}
		/**
	     * 是否属于全天任务
	     * @param isallday 是否属于全天任务
	     */
		public void setIsallday(Integer isallday) {
			this.isallday = isallday;
		}
		 /**
	     * memberId
	     * @return memberId
	     */
		@Column(name="MEMBER_ID")
		public Long getMemberId() {
			return this.memberId;
		}
		/**
	     * memberId
	     * @param memberId memberId
	     */
		public void setMemberId(Long memberId) {
			this.memberId = memberId;
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
		if(obj instanceof Calendar == false) return false;
		if(this == obj) return true;
		Calendar other = (Calendar)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

