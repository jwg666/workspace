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
@Table(name = "TB_WALLPAPER")
public class Wallpaper  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "TB_WALLPAPER";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_TITLE = "title";
	public static final String ALIAS_WIDTH = "width";
	public static final String ALIAS_HEIGHT = "height";
	public static final String ALIAS_URL = "url";
	
    /**
     * tbid       db_column: TBID 
     */	
	private Long tbid;
    /**
     * title       db_column: TITLE 
     */	
	private java.lang.String title;
    /**
     * width       db_column: WIDTH 
     */	
	private java.lang.Integer width;
    /**
     * height       db_column: HEIGHT 
     */	
	private java.lang.Integer height;
    /**
     * url       db_column: URL 
     */	
	private java.lang.String url;
	//columns END

	public Wallpaper(){
	}

	public Wallpaper(
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
	     * title
	     * @return title
	     */
		@Column(name="TITLE")
		public java.lang.String getTitle() {
			return this.title;
		}
		/**
	     * title
	     * @param title title
	     */
		public void setTitle(java.lang.String title) {
			this.title = title;
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
		if(obj instanceof Wallpaper == false) return false;
		if(this == obj) return true;
		Wallpaper other = (Wallpaper)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

