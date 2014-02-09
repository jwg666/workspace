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
@Table(name = "tb_calendar")
public class Calendar  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "Calendar";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_TITLE = "标题";
	public static final String ALIAS_CONTENT = "详细内容";
	public static final String ALIAS_URL = "超链接";
	public static final String ALIAS_STARTDT = "开始时间";
	public static final String ALIAS_ENDDT = "结束时间";
	public static final String ALIAS_ISALLDAY = "是否属于全天任务";
	public static final String ALIAS_MEMBER_ID = "memberId";
	
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
	//columns END

	public Calendar(){
	}

	public Calendar(
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
	public void setContent(java.lang.String value) {
		this.content = value;
	}
	
	public java.lang.String getContent() {
		return this.content;
	}
	public void setUrl(java.lang.String value) {
		this.url = value;
	}
	
	public java.lang.String getUrl() {
		return this.url;
	}
	public String getStartdtString() {
		//return DateConvertUtils.format(getStartdt(), FORMAT_STARTDT);
		return  DateUtils.format(DateUtils.FORMAT2,getStartdt());
	}
	public void setStartdtString(String value) {
		setStartdt(DateUtils.parse(value,DateUtils.FORMAT2,java.util.Date.class));
	}
	
	public void setStartdt(java.util.Date value) {
		this.startdt = value;
	}
	
	public java.util.Date getStartdt() {
		return this.startdt;
	}
	public String getEnddtString() {
		//return DateConvertUtils.format(getEnddt(), FORMAT_ENDDT);
		return  DateUtils.format(DateUtils.FORMAT2,getEnddt());
	}
	public void setEnddtString(String value) {
		setEnddt(DateUtils.parse(value,DateUtils.FORMAT2,java.util.Date.class));
	}
	
	public void setEnddt(java.util.Date value) {
		this.enddt = value;
	}
	
	public java.util.Date getEnddt() {
		return this.enddt;
	}
	public void setIsallday(java.lang.Boolean value) {
		this.isallday = value;
	}
	
	public java.lang.Boolean getIsallday() {
		return this.isallday;
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
		if(!(obj instanceof Calendar)){ return false;}
		if(this == obj){return true;}
		Calendar other = (Calendar)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

