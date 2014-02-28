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
import org.apache.struts2.json.annotations.JSON;

import com.neusoft.base.model.SearchModel;
import com.neusoft.portal.model.MemberApp;
/**
 * database table: tb_member_app
 * database table comments: MemberApp
 */
public class MemberAppQuery extends  SearchModel<MemberApp> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    

	  /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
	  /**
     * 真实id       db_column: realid 
     */	
	private java.lang.Long realid;
	  /**
     * 图标名称       db_column: name 
     */	
	private java.lang.String name;
	  /**
     * 图标图片       db_column: icon 
     */	
	private java.lang.String icon;
	  /**
     * url       db_column: url 
     */	
	private java.lang.String url;
	  /**
     * 应用类型       db_column: type 
     */	
	private java.lang.String type;
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
	private Integer isresize;
	  /**
     * 是否打开直接最大化       db_column: isopenmax 
     */	
	private Integer isopenmax;
	  /**
     * 窗口是否有评分和介绍按钮       db_column: issetbar 
     */	
	private Integer issetbar;
	  /**
     * 是否为flash应用       db_column: isflash 
     */	
	private Integer isflash;
	  /**
     * 创建时间       db_column: dt 
     */	
	private java.util.Date dt;
	  /**
     * 最后修改时间       db_column: lastdt 
     */	
	private java.util.Date lastdt;
	  /**
     * 文件夹id       db_column: folder_id 
     */	
	private java.lang.Long folderId;
	  /**
     * 用户id       db_column: member_id 
     */	
	private java.lang.Long memberId;
	

	/**
     * 属于哪个页面（仅用于接受前台参数） 
     */
	private java.lang.Integer desk;
	
	//辅助字段 查询resource_info 表的url
	private java.lang.String resourceUrl;
	//辅助字段 查询code 国际化
    private java.lang.String code;
    private java.lang.String localName;
        
    public java.lang.Long getAppid() {
		return this.tbid;
	}
	
	public java.lang.Long getTbid() {
		return this.tbid;
	}
	
	public void setTbid(java.lang.Long value) {
		this.tbid = value;
	}
	
	public java.lang.Long getRealappid() {
		return this.realid;
	}
	
	public java.lang.Long getRealid() {
		return this.realid;
	}
	
	public void setRealid(java.lang.Long value) {
		this.realid = value;
	}
	@JSON(serialize=false)
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
	//判断是否是系统应用 是：返回resource_info  url 否：返回 url
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
	
	public Integer getIsresize() {
		return this.isresize;
	}
	
	public void setIsresize(Integer value) {
		this.isresize = value;
	}
	
	public Integer getIsopenmax() {
		return this.isopenmax;
	}
	
	public void setIsopenmax(Integer value) {
		this.isopenmax = value;
	}
	
	public Integer getIssetbar() {
		return this.issetbar;
	}
	
	public void setIssetbar(Integer value) {
		this.issetbar = value;
	}
	
	public Integer getIsflash() {
		return this.isflash;
	}
	
	public void setIsflash(Integer value) {
		this.isflash = value;
	}
	
	public java.util.Date getDt() {
		return this.dt;
	}
	
	public void setDt(java.util.Date value) {
		this.dt = value;
	}
	
	public java.util.Date getLastdt() {
		return this.lastdt;
	}
	
	public void setLastdt(java.util.Date value) {
		this.lastdt = value;
	}
	
	public java.lang.Long getFolderId() {
		return this.folderId;
	}
	
	public void setFolderId(java.lang.Long value) {
		this.folderId = value;
	}
	
	public java.lang.Long getMemberId() {
		return this.memberId;
	}
	
	public void setMemberId(java.lang.Long value) {
		this.memberId = value;
	}
	

	public java.lang.Integer getDesk() {
		return desk;
	}

	public void setDesk(java.lang.Integer desk) {
		this.desk = desk;
	}

	public java.lang.String getResourceUrl() {
		return resourceUrl;
	}

	public void setResourceUrl(java.lang.String resourceUrl) {
		this.resourceUrl = resourceUrl;
	}
	public java.lang.String getCode() {
                return code;
        }
	public void setCode(java.lang.String code) {
                this.code = code;
        }
	@JSON(name="name")
	public java.lang.String getLocalName() {
	    if(name==null || name.length()<1){
              return localName;
            }else{
              return name;
            }
        }

        public void setLocalName(java.lang.String localName) {
          this.localName = localName;
        }
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

