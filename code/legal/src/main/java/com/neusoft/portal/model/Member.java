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
@Table(name = "tb_member")
public class Member  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "Member";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_TYPE = "用户类型，0普通用户，1管理员";
	public static final String ALIAS_DOCK = "[应用码头]应用id，用','相连";
	public static final String ALIAS_DESK1 = "[桌面1]应用id，用','相连";
	public static final String ALIAS_DESK2 = "[桌面2]应用id，用','相连";
	public static final String ALIAS_DESK3 = "[桌面3]应用id，用','相连";
	public static final String ALIAS_DESK4 = "[桌面4]应用id，用','相连";
	public static final String ALIAS_DESK5 = "[桌面5]应用id，用','相连";
	public static final String ALIAS_DESK6 = "[桌面6]应用id，用','相连";
	public static final String ALIAS_DESKNAME1 = "[桌面名称1]";
	public static final String ALIAS_DESKNAME2 = "[桌面名称2]";
	public static final String ALIAS_DESKNAME3 = "[桌面名称3]";
	public static final String ALIAS_DESKNAME4 = "[桌面名称4]";
	public static final String ALIAS_DESKNAME5 = "[桌面名称5]";
	public static final String ALIAS_DESKNAME6 = "[桌面名称6]";
	public static final String ALIAS_APPXY = "图标排列方式";
	public static final String ALIAS_DOCKPOS = "应用码头位置，参数：top,left,right";
	public static final String ALIAS_WALLPAPER_ID = "wallpaperId";
	public static final String ALIAS_WALLPAPERWEBSITE = "wallpaperwebsite";
	public static final String ALIAS_WALLPAPERSTATE = "1系统壁纸、2自定义壁纸、3网络地址";
	public static final String ALIAS_WALLPAPERTYPE = "壁纸显示方式：tianchong,shiying,pingpu,lashen,juzhong";
	public static final String ALIAS_SKIN = "窗口皮肤";
	public static final String ALIAS_REGDT = "注册时间";
	public static final String ALIAS_LASTLOGINDT = "最后登入时间";
	public static final String ALIAS_LASTLOGINIP = "最后登入IP";
	
    /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
    /**
     * 用户类型，0普通用户，1管理员       db_column: type 
     */	
	private java.lang.Boolean type;
    /**
     * permissionId       db_column: permission_id 
     */	
	private java.lang.String dock;
    /**
     * [桌面1]应用id，用","相连       db_column: desk1 
     */	
	private java.lang.String desk1;
    /**
     * [桌面2]应用id，用","相连       db_column: desk2 
     */	
	private java.lang.String desk2;
    /**
     * [桌面3]应用id，用","相连       db_column: desk3 
     */	
	private java.lang.String desk3;
    /**
     * [桌面4]应用id，用","相连       db_column: desk4 
     */	
	private java.lang.String desk4;
    /**
     * [桌面5]应用id，用","相连       db_column: desk5 
     */	
	private java.lang.String desk5;
    /**
     * desk6       db_column: desk6 
     */	
	private java.lang.String desk6;
	/**
	 * [桌面1名称]       db_column: deskname1 
	 */	
	private java.lang.String deskname1;
	/**
	 * [桌面2名称]       db_column: deskname2 
	 */	
	private java.lang.String deskname2;
	/**
	 * [桌面3名称]       db_column: deskname3 
	 */	
	private java.lang.String deskname3;
	/**
	 * [桌面4名称]       db_column: deskname4 
	 */	
	private java.lang.String deskname4;
	/**
	 * [桌面5名称]       db_column: deskname5 
	 */	
	private java.lang.String deskname5;
	/**
	 * [桌面6名称]        db_column: deskname6 
	 */	
	private java.lang.String deskname6;
	/**
	 * desknum       db_column: desknum 
	 */	
	private java.lang.Integer desknum;
    /**
     * 图标排列方式       db_column: appxy 
     */	
	private java.lang.String appxy;
    /**
     * 应用码头位置，参数：top,left,right       db_column: dockpos 
     */	
	private java.lang.String dockpos;
    /**
     * wallpaperId       db_column: wallpaper_id 
     */	
	private java.lang.Integer wallpaperId;
    /**
     * wallpaperwebsite       db_column: wallpaperwebsite 
     */	
	private java.lang.String wallpaperwebsite;
    /**
     * 1系统壁纸、2自定义壁纸、3网络地址       db_column: wallpaperstate 
     */	
	private Integer wallpaperstate;
    /**
     * 壁纸显示方式：tianchong,shiying,pingpu,lashen,juzhong       db_column: wallpapertype 
     */	
	private java.lang.String wallpapertype;
    /**
     * 窗口皮肤       db_column: skin 
     */	
	private java.lang.String skin;
    /**
     * 注册时间       db_column: regdt 
     */	
	private java.util.Date regdt;
    /**
     * 最后登入时间       db_column: lastlogindt 
     */	
	private java.util.Date lastlogindt;
    /**
     * 最后登入IP       db_column: lastloginip 
     */	
	private java.lang.String lastloginip;
	//columns END

	public Member(){
	}

	public Member(
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
	public void setType(java.lang.Boolean value) {
		this.type = value;
	}
	
	public java.lang.Boolean getType() {
		return this.type;
	}
	public void setDock(java.lang.String value) {
		this.dock = value;
	}
	
	public java.lang.String getDock() {
		return this.dock;
	}
	public void setDesk1(java.lang.String value) {
		this.desk1 = value;
	}
	
	public java.lang.String getDesk1() {
		return this.desk1;
	}
	public void setDesk2(java.lang.String value) {
		this.desk2 = value;
	}
	
	public java.lang.String getDesk2() {
		return this.desk2;
	}
	public void setDesk3(java.lang.String value) {
		this.desk3 = value;
	}
	
	public java.lang.String getDesk3() {
		return this.desk3;
	}
	public void setDesk4(java.lang.String value) {
		this.desk4 = value;
	}
	
	public java.lang.String getDesk4() {
		return this.desk4;
	}
	public void setDesk5(java.lang.String value) {
		this.desk5 = value;
	}
	
	public java.lang.String getDesk5() {
		return this.desk5;
	}
	public void setDesk6(java.lang.String value) {
		this.desk6 = value;
	}
	
	public java.lang.String getDesk6() {
		return this.desk6;
	}
	
	public java.lang.String getDeskname1() {
		return deskname1;
	}

	public void setDeskname1(java.lang.String deskname1) {
		this.deskname1 = deskname1;
	}

	public java.lang.String getDeskname2() {
		return deskname2;
	}

	public void setDeskname2(java.lang.String deskname2) {
		this.deskname2 = deskname2;
	}

	public java.lang.String getDeskname3() {
		return deskname3;
	}

	public void setDeskname3(java.lang.String deskname3) {
		this.deskname3 = deskname3;
	}

	public java.lang.String getDeskname4() {
		return deskname4;
	}

	public void setDeskname4(java.lang.String deskname4) {
		this.deskname4 = deskname4;
	}

	public java.lang.String getDeskname5() {
		return deskname5;
	}

	public void setDeskname5(java.lang.String deskname5) {
		this.deskname5 = deskname5;
	}

	public java.lang.String getDeskname6() {
		return deskname6;
	}

	public void setDeskname6(java.lang.String deskname6) {
		this.deskname6 = deskname6;
	}

	public void setAppxy(java.lang.String value) {
		this.appxy = value;
	}
	
	public java.lang.String getAppxy() {
		return this.appxy;
	}
	public void setDockpos(java.lang.String value) {
		this.dockpos = value;
	}
	
	public java.lang.String getDockpos() {
		return this.dockpos;
	}
	public void setWallpaperId(java.lang.Integer value) {
		this.wallpaperId = value;
	}
	
	public java.lang.Integer getWallpaperId() {
		return this.wallpaperId;
	}
	public void setWallpaperwebsite(java.lang.String value) {
		this.wallpaperwebsite = value;
	}
	
	public java.lang.String getWallpaperwebsite() {
		return this.wallpaperwebsite;
	}
	public void setWallpaperstate(Integer value) {
		this.wallpaperstate = value;
	}
	
	public Integer getWallpaperstate() {
		return this.wallpaperstate;
	}
	public void setWallpapertype(java.lang.String value) {
		this.wallpapertype = value;
	}
	
	public java.lang.String getWallpapertype() {
		return this.wallpapertype;
	}
	public void setSkin(java.lang.String value) {
		this.skin = value;
	}
	
	public java.lang.String getSkin() {
		return this.skin;
	}
	public String getRegdtString() {
		//return DateConvertUtils.format(getRegdt(), FORMAT_REGDT);
		return  DateUtils.format(DateUtils.FORMAT2,getRegdt());
	}
	public void setRegdtString(String value) {
		setRegdt(DateUtils.parse(value,DateUtils.FORMAT2,java.util.Date.class));
	}
	
	public void setRegdt(java.util.Date value) {
		this.regdt = value;
	}
	
	public java.util.Date getRegdt() {
		return this.regdt;
	}
	public String getLastlogindtString() {
		//return DateConvertUtils.format(getLastlogindt(), FORMAT_LASTLOGINDT);
		return  DateUtils.format(DateUtils.FORMAT2,getLastlogindt());
	}
	public void setLastlogindtString(String value) {
		setLastlogindt(DateUtils.parse(value,DateUtils.FORMAT2,java.util.Date.class));
	}
	
	public void setLastlogindt(java.util.Date value) {
		this.lastlogindt = value;
	}
	
	public java.util.Date getLastlogindt() {
		return this.lastlogindt;
	}
	public void setLastloginip(java.lang.String value) {
		this.lastloginip = value;
	}
	
	public java.lang.String getLastloginip() {
		return this.lastloginip;
	}

	public java.lang.Integer getDesknum() {
		return desknum;
	}

	public void setDesknum(java.lang.Integer desknum) {
		this.desknum = desknum;
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
		if(!(obj instanceof Member)){ return false;}
		if(this == obj){return true;}
		Member other = (Member)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

