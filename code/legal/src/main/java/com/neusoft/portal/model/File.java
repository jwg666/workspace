
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
@Table(name = "tb_file")
public class File  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "File";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_ICON = "图标地址";
	public static final String ALIAS_NAME = "文件名";
	public static final String ALIAS_EXT = "扩展名";
	public static final String ALIAS_SIZE = "文件大小";
	public static final String ALIAS_URL = "文件存放地址";
	public static final String ALIAS_MEMBER_ID = "memberId";
	public static final String ALIAS_DT = "dt";
	
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
	//columns END

	public File(){
	}

	public File(
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
	public void setIcon(java.lang.String value) {
		this.icon = value;
	}
	
	public java.lang.String getIcon() {
		return this.icon;
	}
	public void setName(java.lang.String value) {
		this.name = value;
	}
	
	public java.lang.String getName() {
		return this.name;
	}
	public void setExt(java.lang.String value) {
		this.ext = value;
	}
	
	public java.lang.String getExt() {
		return this.ext;
	}
	public void setSize(java.lang.Integer value) {
		this.size = value;
	}
	
	public java.lang.Integer getSize() {
		return this.size;
	}
	public void setUrl(java.lang.String value) {
		this.url = value;
	}
	
	public java.lang.String getUrl() {
		return this.url;
	}
	public void setMemberId(java.lang.Long value) {
		this.memberId = value;
	}
	
	public java.lang.Long getMemberId() {
		return this.memberId;
	}
	public String getDtString() {
		//return DateConvertUtils.format(getDt(), FORMAT_DT);
		return  DateUtils.format(DateUtils.FORMAT2,getDt());
	}
	public void setDtString(String value) {
		setDt(DateUtils.parse(value,DateUtils.FORMAT2,java.util.Date.class));
	}
	
	public void setDt(java.util.Date value) {
		this.dt = value;
	}
	
	public java.util.Date getDt() {
		return this.dt;
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
		if(!(obj instanceof File)){ return false;}
		if(this == obj){return true;}
		File other = (File)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

