package com.neusoft.portal.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.base.model.SearchModel;
import com.neusoft.portal.model.File;
/**
 * database table: tb_file
 * database table comments: File
 */
public class FileQuery extends  SearchModel<File> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    

	  /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
	  /**
     * 图标地址       db_column: icon 
     */	
	private java.lang.String icon;
	  /**
     * 文件名       db_column: name 
     */	
	private java.lang.String name;
	  /**
     * 扩展名       db_column: ext 
     */	
	private java.lang.String ext;
	  /**
     * 文件大小       db_column: size 
     */	
	private java.lang.Integer size;
	  /**
     * 文件存放地址       db_column: url 
     */	
	private java.lang.String url;
	  /**
     * memberId       db_column: member_id 
     */	
	private java.lang.Long memberId;
	  /**
     * dt       db_column: dt 
     */	
	private java.util.Date dt;

	public java.lang.Long getTbid() {
		return this.tbid;
	}
	
	public void setTbid(java.lang.Long value) {
		this.tbid = value;
	}
	
	public java.lang.String getIcon() {
		return this.icon;
	}
	
	public void setIcon(java.lang.String value) {
		this.icon = value;
	}
	
	public java.lang.String getName() {
		return this.name;
	}
	
	public void setName(java.lang.String value) {
		this.name = value;
	}
	
	public java.lang.String getExt() {
		return this.ext;
	}
	
	public void setExt(java.lang.String value) {
		this.ext = value;
	}
	
	public java.lang.Integer getSize() {
		return this.size;
	}
	
	public void setSize(java.lang.Integer value) {
		this.size = value;
	}
	
	public java.lang.String getUrl() {
		return this.url;
	}
	
	public void setUrl(java.lang.String value) {
		this.url = value;
	}
	
	public java.lang.Long getMemberId() {
		return this.memberId;
	}
	
	public void setMemberId(java.lang.Long value) {
		this.memberId = value;
	}
	
	public java.util.Date getDt() {
		return this.dt;
	}
	
	public void setDt(java.util.Date value) {
		this.dt = value;
	}
	

	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

