package com.neusoft.portal.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.base.model.SearchModel;
import com.neusoft.portal.model.Calendar;
/**
 * database table: tb_calendar
 * database table comments: Calendar
 * This file is generated by <tt>dalgen</tt>, a DAL (Data Access Layer)
 *  
 */
public class CalendarQuery extends  SearchModel<Calendar> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    

	  /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
	  /**
     * 标题       db_column: title 
     */	
	private java.lang.String title;
	  /**
     * 详细内容       db_column: content 
     */	
	private java.lang.String content;
	  /**
     * 超链接       db_column: url 
     */	
	private java.lang.String url;
	  /**
     * 开始时间       db_column: startdt 
     */	
	private java.util.Date startdt;
	  /**
     * 结束时间       db_column: enddt 
     */	
	private java.util.Date enddt;
	  /**
     * 是否属于全天任务       db_column: isallday 
     */	
	private java.lang.Boolean isallday;
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
	
	public java.lang.String getTitle() {
		return this.title;
	}
	
	public void setTitle(java.lang.String value) {
		this.title = value;
	}
	
	public java.lang.String getContent() {
		return this.content;
	}
	
	public void setContent(java.lang.String value) {
		this.content = value;
	}
	
	public java.lang.String getUrl() {
		return this.url;
	}
	
	public void setUrl(java.lang.String value) {
		this.url = value;
	}
	
	public java.util.Date getStartdt() {
		return this.startdt;
	}
	
	public void setStartdt(java.util.Date value) {
		this.startdt = value;
	}
	
	public java.util.Date getEnddt() {
		return this.enddt;
	}
	
	public void setEnddt(java.util.Date value) {
		this.enddt = value;
	}
	
	public java.lang.Boolean getIsallday() {
		return this.isallday;
	}
	
	public void setIsallday(java.lang.Boolean value) {
		this.isallday = value;
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

