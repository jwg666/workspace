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
 * database table: tb_pwallpaper
 * database table comments: Pwallpaper
 */
@Entity
@Table(name = "tb_pwallpaper")
public class Pwallpaper  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "Pwallpaper";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_URL = "url";
	public static final String ALIAS_WIDTH = "width";
	public static final String ALIAS_HEIGHT = "height";
	public static final String ALIAS_MEMBER_ID = "memberId";
	
    /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
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
    /**
     * memberId       db_column: member_id 
     */	
	private java.lang.Long memberId;
	//columns END

	public Pwallpaper(){
	}

	public Pwallpaper(
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
	public void setMemberId(java.lang.Long value) {
		this.memberId = value;
	}
	
	public java.lang.Long getMemberId() {
		return this.memberId;
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
		if(!(obj instanceof Pwallpaper)){ return false;}
		if(this == obj){return true;}
		Pwallpaper other = (Pwallpaper)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

