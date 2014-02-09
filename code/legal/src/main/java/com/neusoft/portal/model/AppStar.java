
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
@Table(name = "tb_app_star")
public class AppStar  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "AppStar";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_APP_ID = "appId";
	public static final String ALIAS_MEMBER_ID = "memberId";
	public static final String ALIAS_STARNUM = "starnum";
	public static final String ALIAS_DT = "dt";
	
    /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
    /**
     * appId       db_column: app_id 
     */	
	private java.lang.Long appId;
    /**
     * memberId       db_column: member_id 
     */	
	private java.lang.Long memberId;
    /**
     * starnum       db_column: starnum 
     */	
	private java.lang.Integer starnum;
    /**
     * dt       db_column: dt 
     */	
	private java.util.Date dt;
	//columns END

	public AppStar(){
	}

	public AppStar(
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
	public void setAppId(java.lang.Long value) {
		this.appId = value;
	}
	
	public java.lang.Long getAppId() {
		return this.appId;
	}
	public void setMemberId(java.lang.Long value) {
		this.memberId = value;
	}
	
	public java.lang.Long getMemberId() {
		return this.memberId;
	}
	public void setStarnum(java.lang.Integer value) {
		this.starnum = value;
	}
	
	public java.lang.Integer getStarnum() {
		return this.starnum;
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
		if(!(obj instanceof AppStar)){ return false;}
		if(this == obj){return true;}
		AppStar other = (AppStar)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

