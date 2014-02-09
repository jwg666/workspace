package com.neusoft.portal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * database table: tb_wallpaper
 * database table comments: Wallpaper
 */
@Entity
@Table(name = "tb_wallpaper")
public class Wallpaper  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "Wallpaper";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_TITLE = "title";
	public static final String ALIAS_URL = "url";
	public static final String ALIAS_WIDTH = "width";
	public static final String ALIAS_HEIGHT = "height";
	
    /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
    /**
     * title       db_column: title 
     */	
	private java.lang.String title;
    /**
     * url       db_column: url 
     */	
	private java.lang.String url;
    /**
     * width       db_column: width 
     */	
	private java.lang.Integer width;
    /**
     * height       db_column: height 
     */	
	private java.lang.Integer height;
	//columns END

	public Wallpaper(){
	}

	public Wallpaper(
		java.lang.Long tbid
	){
		this.tbid = tbid;
	}

	public void setTbid(java.lang.Long value) {
		this.tbid = value;
	}
	@Id  
    @GeneratedValue
	@Column(name="tbid")
	public java.lang.Long getTbid() {
		return this.tbid;
	}
	public void setTitle(java.lang.String value) {
		this.title = value;
	}
	
	public java.lang.String getTitle() {
		return this.title;
	}
	public void setUrl(java.lang.String value) {
		this.url = value;
	}
	
	public java.lang.String getUrl() {
		return this.url;
	}
	public void setWidth(java.lang.Integer value) {
		this.width = value;
	}
	
	public java.lang.Integer getWidth() {
		return this.width;
	}
	public void setHeight(java.lang.Integer value) {
		this.height = value;
	}
	
	public java.lang.Integer getHeight() {
		return this.height;
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
		if(!(obj instanceof Wallpaper)){ return false;}
		if(this == obj){return true;}
		Wallpaper other = (Wallpaper)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

