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

@Entity
@Table(name = "TB_PWALLPAPER")
public class Pwallpaper  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "TB_PWALLPAPER";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_WIDTH = "width";
	public static final String ALIAS_HEIGHT = "height";
	public static final String ALIAS_MEMBER_ID = "memberId";
	public static final String ALIAS_URL = "url";
	
    /**
     * tbid       db_column: TBID 
     */	
	private Long tbid;
    /**
     * width       db_column: WIDTH 
     */	
	private java.lang.Integer width;
    /**
     * height       db_column: HEIGHT 
     */	
	private java.lang.Integer height;
    /**
     * memberId       db_column: MEMBER_ID 
     */	
	private Long memberId;
    /**
     * url       db_column: URL 
     */	
	private java.lang.String url;
	//columns END

	public Pwallpaper(){
	}

	public Pwallpaper(
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
	     * width
	     * @return width
	     */
		@Column(name="WIDTH")
		public java.lang.Integer getWidth() {
			return this.width;
		}
		/**
	     * width
	     * @param width width
	     */
		public void setWidth(java.lang.Integer width) {
			this.width = width;
		}
		 /**
	     * height
	     * @return height
	     */
		@Column(name="HEIGHT")
		public java.lang.Integer getHeight() {
			return this.height;
		}
		/**
	     * height
	     * @param height height
	     */
		public void setHeight(java.lang.Integer height) {
			this.height = height;
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

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getTbid())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof Pwallpaper == false) return false;
		if(this == obj) return true;
		Pwallpaper other = (Pwallpaper)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

