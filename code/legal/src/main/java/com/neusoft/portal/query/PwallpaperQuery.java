/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 * Since 2008 - 2013
 */

package com.neusoft.portal.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.base.model.SearchModel;
import com.neusoft.portal.model.Pwallpaper;
/**
 * database table: tb_pwallpaper
 * database table comments: Pwallpaper
 */
public class PwallpaperQuery extends  SearchModel<Pwallpaper> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    

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

	public java.lang.Long getTbid() {
		return this.tbid;
	}
	
	public void setTbid(java.lang.Long value) {
		this.tbid = value;
	}
	
	public java.lang.String getUrl() {
		return this.url;
	}
	
	public void setUrl(java.lang.String value) {
		this.url = value;
	}
	
	public java.lang.Integer getWidth() {
		return this.width;
	}
	
	public void setWidth(java.lang.Integer value) {
		this.width = value;
	}
	
	public java.lang.Integer getHeight() {
		return this.height;
	}
	
	public void setHeight(java.lang.Integer value) {
		this.height = value;
	}
	
	public java.lang.Long getMemberId() {
		return this.memberId;
	}
	
	public void setMemberId(java.lang.Long value) {
		this.memberId = value;
	}
	

	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

