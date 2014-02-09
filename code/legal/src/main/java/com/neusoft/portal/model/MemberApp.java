
package com.neusoft.portal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.struts2.json.annotations.JSON;

import com.neusoft.base.common.DateUtils;

/**
 * database table: tb_member_app
 * database table comments: MemberApp
 */
@Entity
@Table(name = "tb_member_app")
public class MemberApp  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "MemberApp";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_REALID = "真实id";
	public static final String ALIAS_NAME = "图标名称";
	public static final String ALIAS_ICON = "图标图片";
	public static final String ALIAS_URL = "url";
	public static final String ALIAS_TYPE = "应用类型";
	public static final String ALIAS_WIDTH = "窗口宽度";
	public static final String ALIAS_HEIGHT = "窗口高度";
	public static final String ALIAS_ISRESIZE = "是否能对窗口进行拉伸";
	public static final String ALIAS_ISOPENMAX = "是否打开直接最大化";
	public static final String ALIAS_ISSETBAR = "窗口是否有评分和介绍按钮";
	public static final String ALIAS_ISFLASH = "是否为flash应用";
	public static final String ALIAS_DT = "创建时间";
	public static final String ALIAS_LASTDT = "最后修改时间";
	public static final String ALIAS_FOLDER_ID = "文件夹id";
	public static final String ALIAS_MEMBER_ID = "用户id";
	
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
	//columns END

	//辅助字段 查询resource_info 表的url 
	private java.lang.String resourceUrl;
	//辅助字段 查询code 国际化
	private java.lang.String code;
	private java.lang.String localName;
	
	public MemberApp(){
	}

	public MemberApp(
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
	public void setRealid(java.lang.Long value) {
		this.realid = value;
	}
	
	public java.lang.Long getRealid() {
		return this.realid;
	}
	public void setName(java.lang.String value) {
		this.name = value;
	}
	@JSON(serialize=false)
	public java.lang.String getName() {
		return this.name;
	}
	public void setIcon(java.lang.String value) {
		this.icon = value;
	}
	
	public java.lang.String getIcon() {
		return this.icon;
	}
	public void setUrl(java.lang.String value) {
		this.url = value;
	}
	//判断是否是系统应用 是：返回resource_info  url 否：返回 url
	public java.lang.String getUrl() {
		if(this.realid==null){
			return this.url;
		}else{
			return this.resourceUrl;
		}
	}
	public void setType(java.lang.String value) {
		this.type = value;
	}
	
	public java.lang.String getType() {
		return this.type;
	}
	public void setWidth(java.lang.Integer value) {
		this.width = value;
	}
	
	public java.lang.Integer getWidth() {
		return this.width;
	}
	public void setHeight(java.lang.Integer value) {
		this.height = value;
	}
	
	public java.lang.Integer getHeight() {
		return this.height;
	}
	public void setIsresize(Integer value) {
		this.isresize = value;
	}
	
	public Integer getIsresize() {
		return this.isresize;
	}
	public void setIsopenmax(Integer value) {
		this.isopenmax = value;
	}
	
	public Integer getIsopenmax() {
		return this.isopenmax;
	}
	public void setIssetbar(Integer value) {
		this.issetbar = value;
	}
	
	public Integer getIssetbar() {
		return this.issetbar;
	}
	public void setIsflash(Integer value) {
		this.isflash = value;
	}
	
	public Integer getIsflash() {
		return this.isflash;
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
	public String getLastdtString() {
		//return DateConvertUtils.format(getLastdt(), FORMAT_LASTDT);
		return  DateUtils.format(DateUtils.FORMAT2,getLastdt());
	}
	public void setLastdtString(String value) {
		setLastdt(DateUtils.parse(value,DateUtils.FORMAT2,java.util.Date.class));
	}
	
	public void setLastdt(java.util.Date value) {
		this.lastdt = value;
	}
	
	public java.util.Date getLastdt() {
		return this.lastdt;
	}
	public void setFolderId(java.lang.Long value) {
		this.folderId = value;
	}
	
	public java.lang.Long getFolderId() {
		return this.folderId;
	}
	public void setMemberId(java.lang.Long value) {
		this.memberId = value;
	}
	
	public java.lang.Long getMemberId() {
		return this.memberId;
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
		return ToStringBuilder.reflectionToString(this);
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getTbid())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(!(obj instanceof MemberApp)){ return false;}
		if(this == obj){return true;}
		MemberApp other = (MemberApp)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

