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
 * database table: tb_setting
 * database table comments: Setting
 */
@Entity
@Table(name = "tb_setting")
public class Setting  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "Setting";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_TITLE = "网站标题";
	public static final String ALIAS_DESCRIPTION = "网站描述";
	public static final String ALIAS_KEYWORDS = "网站关键字";
	
    /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
    /**
     * 网站标题       db_column: title 
     */	
	private java.lang.String title;
    /**
     * 网站描述       db_column: description 
     */	
	private java.lang.String description;
    /**
     * 网站关键字       db_column: keywords 
     */	
	private java.lang.String keywords;
	//columns END

	public Setting(){
	}

	public Setting(
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
	public void setDescription(java.lang.String value) {
		this.description = value;
	}
	
	public java.lang.String getDescription() {
		return this.description;
	}
	public void setKeywords(java.lang.String value) {
		this.keywords = value;
	}
	
	public java.lang.String getKeywords() {
		return this.keywords;
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
		if(!(obj instanceof Setting)){ return false;}
		if(this == obj){return true;}
		Setting other = (Setting)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

