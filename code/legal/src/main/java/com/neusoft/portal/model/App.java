
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
@Table(name = "tb_app")
public class App  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "App";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_NAME = "图标名称";
	public static final String ALIAS_ICON = "图标图片";
	public static final String ALIAS_URL = "图标链接";
	public static final String ALIAS_TYPE = "应用类型，参数有：app，widget";
	public static final String ALIAS_KINDID = "kindid";
	public static final String ALIAS_WIDTH = "窗口宽度";
	public static final String ALIAS_HEIGHT = "窗口高度";
	public static final String ALIAS_ISRESIZE = "是否能对窗口进行拉伸";
	public static final String ALIAS_ISOPENMAX = "是否打开直接最大化";
	public static final String ALIAS_ISSETBAR = "窗口是否有评分和介绍按钮";
	public static final String ALIAS_ISFLASH = "是否为flash应用";
	public static final String ALIAS_REMARK = "remark";
	public static final String ALIAS_USECOUNT = "使用人数";
	public static final String ALIAS_STARNUM = "评分";
	public static final String ALIAS_DT = "dt";
	public static final String ALIAS_INDEXID = "排序";
	
    /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
    /**
     * 图标名称       db_column: name 
     */	
	private java.lang.String name;
    /**
     * 图标图片       db_column: icon 
     */	
	private java.lang.String icon;
    /**
     * 图标链接       db_column: url 
     */	
	private java.lang.String url;
    /**
     * 应用类型，参数有：app，widget       db_column: type 
     */	
	private java.lang.String type;
    /**
     * kindid       db_column: kindid 
     */	
	private java.lang.Integer kindid;
    /**
     * 窗口宽度       db_column: width 
     */	
	private java.lang.Integer width;
    /**
     * 窗口高度       db_column: height 
     */	
	private java.lang.Integer height;
    /**
     * 是否能对窗口进行拉伸       db_column: isresize 
     */	
	private java.lang.Integer isresize;
    /**
     * 是否打开直接最大化       db_column: isopenmax 
     */	
	private java.lang.Integer isopenmax;
    /**
     * 窗口是否有评分和介绍按钮       db_column: issetbar 
     */	
	private java.lang.Integer issetbar;
    /**
     * 是否为flash应用       db_column: isflash 
     */	
	private java.lang.Integer isflash;
    /**
     * remark       db_column: remark 
     */	
	private java.lang.String remark;
    /**
     * 使用人数       db_column: usecount 
     */	
	private java.lang.Long usecount;
    /**
     * 评分       db_column: starnum 
     */	
	private Long starnum;
    /**
     * dt       db_column: dt 
     */	
	private java.util.Date dt;
    /**
     * 排序       db_column: indexid 
     */	
	private java.lang.Long indexid;
	//columns END

	public App(){
	}

	public App(
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
	public void setName(java.lang.String value) {
		this.name = value;
	}
	@Id  
    @GeneratedValue
	@Column(name="name")
	public java.lang.String getName() {
		return this.name;
	}
	public void setIcon(java.lang.String value) {
		this.icon = value;
	}
	@Id  
    @GeneratedValue
	@Column(name="icon")
	public java.lang.String getIcon() {
		return this.icon;
	}
	public void setUrl(java.lang.String value) {
		this.url = value;
	}
	@Id  
    @GeneratedValue
	@Column(name="url")
	public java.lang.String getUrl() {
		return this.url;
	}
	public void setType(java.lang.String value) {
		this.type = value;
	}
	@Id  
    @GeneratedValue
	@Column(name="type")
	public java.lang.String getType() {
		return this.type;
	}
	public void setKindid(java.lang.Integer value) {
		this.kindid = value;
	}
	@Id  
    @GeneratedValue
	@Column(name="kindid")
	public java.lang.Integer getKindid() {
		return this.kindid;
	}
	public void setWidth(java.lang.Integer value) {
		this.width = value;
	}
	@Id  
    @GeneratedValue
	@Column(name="width")
	public java.lang.Integer getWidth() {
		return this.width;
	}
	public void setHeight(java.lang.Integer value) {
		this.height = value;
	}
	@Id  
    @GeneratedValue
	@Column(name="height")
	public java.lang.Integer getHeight() {
		return this.height;
	}
	public void setIsresize(java.lang.Integer value) {
		this.isresize = value;
	}
	
	public java.lang.Integer getIsresize() {
		return this.isresize;
	}
	public void setIsopenmax(java.lang.Integer value) {
		this.isopenmax = value;
	}
	
	public java.lang.Integer getIsopenmax() {
		return this.isopenmax;
	}
	public void setIssetbar(java.lang.Integer value) {
		this.issetbar = value;
	}
	
	public java.lang.Integer getIssetbar() {
		return this.issetbar;
	}
	public void setIsflash(java.lang.Integer value) {
		this.isflash = value;
	}
	
	public java.lang.Integer getIsflash() {
		return this.isflash;
	}
	public void setRemark(java.lang.String value) {
		this.remark = value;
	}
	
	public java.lang.String getRemark() {
		return this.remark;
	}
	public void setUsecount(java.lang.Long value) {
		this.usecount = value;
	}
	
	public java.lang.Long getUsecount() {
		return this.usecount;
	}
	public void setStarnum(Long value) {
		this.starnum = value;
	}
	
	public Long getStarnum() {
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
	public void setIndexid(java.lang.Long value) {
		this.indexid = value;
	}
	
	public java.lang.Long getIndexid() {
		return this.indexid;
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
		if(!(obj instanceof App)){ return false;}
		if(this == obj){return true;}
		App other = (App)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

