
package com.neusoft.portal.query;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.neusoft.base.model.SearchModel;
import com.neusoft.portal.model.App;

public class AppQuery extends  SearchModel<App> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    

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

	public java.lang.Long getTbid() {
		return this.tbid;
	}
	
	public void setTbid(java.lang.Long value) {
		this.tbid = value;
	}
	
	public java.lang.String getName() {
		return this.name;
	}
	
	public void setName(java.lang.String value) {
		this.name = value;
	}
	
	public java.lang.String getIcon() {
		return this.icon;
	}
	
	public void setIcon(java.lang.String value) {
		this.icon = value;
	}
	
	public java.lang.String getUrl() {
		return this.url;
	}
	
	public void setUrl(java.lang.String value) {
		this.url = value;
	}
	
	public java.lang.String getType() {
		return this.type;
	}
	
	public void setType(java.lang.String value) {
		this.type = value;
	}
	
	public java.lang.Integer getKindid() {
		return this.kindid;
	}
	
	public void setKindid(java.lang.Integer value) {
		this.kindid = value;
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
	
	public java.lang.Integer getIsresize() {
		return this.isresize;
	}
	
	public void setIsresize(java.lang.Integer value) {
		this.isresize = value;
	}
	
	public java.lang.Integer getIsopenmax() {
		return this.isopenmax;
	}
	
	public void setIsopenmax(java.lang.Integer value) {
		this.isopenmax = value;
	}
	
	public java.lang.Integer getIssetbar() {
		return this.issetbar;
	}
	
	public void setIssetbar(java.lang.Integer value) {
		this.issetbar = value;
	}
	
	public java.lang.Integer getIsflash() {
		return this.isflash;
	}
	
	public void setIsflash(java.lang.Integer value) {
		this.isflash = value;
	}
	
	public java.lang.String getRemark() {
		return this.remark;
	}
	
	public void setRemark(java.lang.String value) {
		this.remark = value;
	}
	
	public java.lang.Long getUsecount() {
		return this.usecount;
	}
	
	public void setUsecount(java.lang.Long value) {
		this.usecount = value;
	}
	
	public Long getStarnum() {
		return this.starnum;
	}
	
	public void setStarnum(Long value) {
		this.starnum = value;
	}
	
	public java.util.Date getDt() {
		return this.dt;
	}
	
	public void setDt(java.util.Date value) {
		this.dt = value;
	}
	
	public java.lang.Long getIndexid() {
		return this.indexid;
	}
	
	public void setIndexid(java.lang.Long value) {
		this.indexid = value;
	}
	

	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

