/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.portal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

@Entity
@Table(name = "TB_MEMBER")
public class Member  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "TB_MEMBER";
	public static final String ALIAS_TBID = "tbid";
	public static final String ALIAS_USERNAME = "username";
	public static final String ALIAS_APPXY = "图标排列方式";
	public static final String ALIAS_DOCKPOS = "应用码头位置，参数：top,left,right";
	public static final String ALIAS_WALLPAPER_ID = "wallpaperId";
	public static final String ALIAS_WALLPAPERSTATE = "1系统壁纸、2自定义壁纸、3网络地址";
	public static final String ALIAS_WALLPAPERTYPE = "壁纸显示方式：tianchong,shiying,pingpu,lashen,juzhong";
	public static final String ALIAS_SKIN = "窗口皮肤";
	public static final String ALIAS_DESKNUM = "个人桌面数量默认3";
	public static final String ALIAS_WALLPAPERWEBSITE = "壁纸网络地址";
	public static final String ALIAS_DOCK = "[应用码头]应用id，用,相连";
	public static final String ALIAS_DESK1 = "[桌面1]应用id，用,相连";
	public static final String ALIAS_DESK2 = "[桌面2]应用id，用,相连";
	public static final String ALIAS_DESK3 = "[桌面3]应用id，用,相连";
	public static final String ALIAS_DESK4 = "[桌面4]应用id，用,相连";
	public static final String ALIAS_DESK5 = "[桌面5]应用id，用,相连";
	public static final String ALIAS_DESK6 = "[桌面6]应用id，用,相连";
	public static final String ALIAS_DESKNAME1 = "[桌面1]名称";
	public static final String ALIAS_DESKNAME2 = "[桌面2]名称";
	public static final String ALIAS_DESKNAME3 = "[桌面3]名称";
	public static final String ALIAS_DESKNAME4 = "[桌面4]名称";
	public static final String ALIAS_DESKNAME5 = "[桌面5]名称";
	public static final String ALIAS_DESKNAME6 = "[桌面6]名称";
	
    /**
     * tbid       db_column: TBID 
     */	
	private Long tbid;
    /**
     * username       db_column: USERNAME 
     */	
	private java.lang.String username;
    /**
     * 图标排列方式       db_column: APPXY 
     */	
	private java.lang.String appxy;
    /**
     * 应用码头位置，参数：top,left,right       db_column: DOCKPOS 
     */	
	private java.lang.String dockpos;
    /**
     * wallpaperId       db_column: WALLPAPER_ID 
     */	
	private java.lang.Long wallpaperId;
    /**
     * 1系统壁纸、2自定义壁纸、3网络地址       db_column: WALLPAPERSTATE 
     */	
	private Integer wallpaperstate;
    /**
     * 壁纸显示方式：tianchong,shiying,pingpu,lashen,juzhong       db_column: WALLPAPERTYPE 
     */	
	private java.lang.String wallpapertype;
    /**
     * 窗口皮肤       db_column: SKIN 
     */	
	private java.lang.String skin;
    /**
     * 个人桌面数量默认3       db_column: DESKNUM 
     */	
	private Integer desknum;
    /**
     * 壁纸网络地址       db_column: WALLPAPERWEBSITE 
     */	
	private java.lang.String wallpaperwebsite;
    /**
     * [应用码头]应用id，用,相连       db_column: DOCK 
     */	
	private java.lang.String dock;
    /**
     * [桌面1]应用id，用,相连       db_column: DESK1 
     */	
	private java.lang.String desk1;
    /**
     * [桌面2]应用id，用,相连       db_column: DESK2 
     */	
	private java.lang.String desk2;
    /**
     * [桌面3]应用id，用,相连       db_column: DESK3 
     */	
	private java.lang.String desk3;
    /**
     * [桌面4]应用id，用,相连       db_column: DESK4 
     */	
	private java.lang.String desk4;
    /**
     * [桌面5]应用id，用,相连       db_column: DESK5 
     */	
	private java.lang.String desk5;
    /**
     * [桌面6]应用id，用,相连       db_column: DESK6 
     */	
	private java.lang.String desk6;
    /**
     * [桌面1]名称       db_column: DESKNAME1 
     */	
	private java.lang.String deskname1;
    /**
     * [桌面2]名称       db_column: DESKNAME2 
     */	
	private java.lang.String deskname2;
    /**
     * [桌面3]名称       db_column: DESKNAME3 
     */	
	private java.lang.String deskname3;
    /**
     * [桌面4]名称       db_column: DESKNAME4 
     */	
	private java.lang.String deskname4;
    /**
     * [桌面5]名称       db_column: DESKNAME5 
     */	
	private java.lang.String deskname5;
    /**
     * [桌面6]名称       db_column: DESKNAME6 
     */	
	private java.lang.String deskname6;
	//columns END

	public Member(){
	}

	public Member(
		Long tbid
	){
		this.tbid = tbid;
	}

		 /**
	     * tbid
	     * @return tbid
	     */
		@Id  
	    @GeneratedValue
		@Column(name="TBID")
		public Long getTbid() {
			return this.tbid;
		}
		/**
	     * tbid
	     * @param tbid tbid
	     */
		public void setTbid(Long tbid) {
			this.tbid = tbid;
		}
		 /**
	     * username
	     * @return username
	     */
		@Column(name="USERNAME")
		public java.lang.String getUsername() {
			return this.username;
		}
		/**
	     * username
	     * @param username username
	     */
		public void setUsername(java.lang.String username) {
			this.username = username;
		}
		 /**
	     * 图标排列方式
	     * @return 图标排列方式
	     */
		@Column(name="APPXY")
		public java.lang.String getAppxy() {
			return this.appxy;
		}
		/**
	     * 图标排列方式
	     * @param appxy 图标排列方式
	     */
		public void setAppxy(java.lang.String appxy) {
			this.appxy = appxy;
		}
		 /**
	     * 应用码头位置，参数：top,left,right
	     * @return 应用码头位置，参数：top,left,right
	     */
		@Column(name="DOCKPOS")
		public java.lang.String getDockpos() {
			return this.dockpos;
		}
		/**
	     * 应用码头位置，参数：top,left,right
	     * @param dockpos 应用码头位置，参数：top,left,right
	     */
		public void setDockpos(java.lang.String dockpos) {
			this.dockpos = dockpos;
		}
		 /**
	     * wallpaperId
	     * @return wallpaperId
	     */
		@Column(name="WALLPAPER_ID")
		public java.lang.Long getWallpaperId() {
			return this.wallpaperId;
		}
		/**
	     * wallpaperId
	     * @param wallpaperId wallpaperId
	     */
		public void setWallpaperId(java.lang.Long wallpaperId) {
			this.wallpaperId = wallpaperId;
		}
		 /**
	     * 1系统壁纸、2自定义壁纸、3网络地址
	     * @return 1系统壁纸、2自定义壁纸、3网络地址
	     */
		@Column(name="WALLPAPERSTATE")
		public Integer getWallpaperstate() {
			return this.wallpaperstate;
		}
		/**
	     * 1系统壁纸、2自定义壁纸、3网络地址
	     * @param wallpaperstate 1系统壁纸、2自定义壁纸、3网络地址
	     */
		public void setWallpaperstate(Integer wallpaperstate) {
			this.wallpaperstate = wallpaperstate;
		}
		 /**
	     * 壁纸显示方式：tianchong,shiying,pingpu,lashen,juzhong
	     * @return 壁纸显示方式：tianchong,shiying,pingpu,lashen,juzhong
	     */
		@Column(name="WALLPAPERTYPE")
		public java.lang.String getWallpapertype() {
			return this.wallpapertype;
		}
		/**
	     * 壁纸显示方式：tianchong,shiying,pingpu,lashen,juzhong
	     * @param wallpapertype 壁纸显示方式：tianchong,shiying,pingpu,lashen,juzhong
	     */
		public void setWallpapertype(java.lang.String wallpapertype) {
			this.wallpapertype = wallpapertype;
		}
		 /**
	     * 窗口皮肤
	     * @return 窗口皮肤
	     */
		@Column(name="SKIN")
		public java.lang.String getSkin() {
			return this.skin;
		}
		/**
	     * 窗口皮肤
	     * @param skin 窗口皮肤
	     */
		public void setSkin(java.lang.String skin) {
			this.skin = skin;
		}
		 /**
	     * 个人桌面数量默认3
	     * @return 个人桌面数量默认3
	     */
		@Column(name="DESKNUM")
		public Integer getDesknum() {
			return this.desknum;
		}
		/**
	     * 个人桌面数量默认3
	     * @param desknum 个人桌面数量默认3
	     */
		public void setDesknum(Integer desknum) {
			this.desknum = desknum;
		}
		 /**
	     * 壁纸网络地址
	     * @return 壁纸网络地址
	     */
		@Column(name="WALLPAPERWEBSITE")
		public java.lang.String getWallpaperwebsite() {
			return this.wallpaperwebsite;
		}
		/**
	     * 壁纸网络地址
	     * @param wallpaperwebsite 壁纸网络地址
	     */
		public void setWallpaperwebsite(java.lang.String wallpaperwebsite) {
			this.wallpaperwebsite = wallpaperwebsite;
		}
		 /**
	     * [应用码头]应用id，用,相连
	     * @return [应用码头]应用id，用,相连
	     */
		@Column(name="DOCK")
		public java.lang.String getDock() {
			return this.dock;
		}
		/**
	     * [应用码头]应用id，用,相连
	     * @param dock [应用码头]应用id，用,相连
	     */
		public void setDock(java.lang.String dock) {
			this.dock = dock;
		}
		 /**
	     * [桌面1]应用id，用,相连
	     * @return [桌面1]应用id，用,相连
	     */
		@Column(name="DESK1")
		public java.lang.String getDesk1() {
			return this.desk1;
		}
		/**
	     * [桌面1]应用id，用,相连
	     * @param desk1 [桌面1]应用id，用,相连
	     */
		public void setDesk1(java.lang.String desk1) {
			this.desk1 = desk1;
		}
		 /**
	     * [桌面2]应用id，用,相连
	     * @return [桌面2]应用id，用,相连
	     */
		@Column(name="DESK2")
		public java.lang.String getDesk2() {
			return this.desk2;
		}
		/**
	     * [桌面2]应用id，用,相连
	     * @param desk2 [桌面2]应用id，用,相连
	     */
		public void setDesk2(java.lang.String desk2) {
			this.desk2 = desk2;
		}
		 /**
	     * [桌面3]应用id，用,相连
	     * @return [桌面3]应用id，用,相连
	     */
		@Column(name="DESK3")
		public java.lang.String getDesk3() {
			return this.desk3;
		}
		/**
	     * [桌面3]应用id，用,相连
	     * @param desk3 [桌面3]应用id，用,相连
	     */
		public void setDesk3(java.lang.String desk3) {
			this.desk3 = desk3;
		}
		 /**
	     * [桌面4]应用id，用,相连
	     * @return [桌面4]应用id，用,相连
	     */
		@Column(name="DESK4")
		public java.lang.String getDesk4() {
			return this.desk4;
		}
		/**
	     * [桌面4]应用id，用,相连
	     * @param desk4 [桌面4]应用id，用,相连
	     */
		public void setDesk4(java.lang.String desk4) {
			this.desk4 = desk4;
		}
		 /**
	     * [桌面5]应用id，用,相连
	     * @return [桌面5]应用id，用,相连
	     */
		@Column(name="DESK5")
		public java.lang.String getDesk5() {
			return this.desk5;
		}
		/**
	     * [桌面5]应用id，用,相连
	     * @param desk5 [桌面5]应用id，用,相连
	     */
		public void setDesk5(java.lang.String desk5) {
			this.desk5 = desk5;
		}
		 /**
	     * [桌面6]应用id，用,相连
	     * @return [桌面6]应用id，用,相连
	     */
		@Column(name="DESK6")
		public java.lang.String getDesk6() {
			return this.desk6;
		}
		/**
	     * [桌面6]应用id，用,相连
	     * @param desk6 [桌面6]应用id，用,相连
	     */
		public void setDesk6(java.lang.String desk6) {
			this.desk6 = desk6;
		}
		 /**
	     * [桌面1]名称
	     * @return [桌面1]名称
	     */
		@Column(name="DESKNAME1")
		public java.lang.String getDeskname1() {
			return this.deskname1;
		}
		/**
	     * [桌面1]名称
	     * @param deskname1 [桌面1]名称
	     */
		public void setDeskname1(java.lang.String deskname1) {
			this.deskname1 = deskname1;
		}
		 /**
	     * [桌面2]名称
	     * @return [桌面2]名称
	     */
		@Column(name="DESKNAME2")
		public java.lang.String getDeskname2() {
			return this.deskname2;
		}
		/**
	     * [桌面2]名称
	     * @param deskname2 [桌面2]名称
	     */
		public void setDeskname2(java.lang.String deskname2) {
			this.deskname2 = deskname2;
		}
		 /**
	     * [桌面3]名称
	     * @return [桌面3]名称
	     */
		@Column(name="DESKNAME3")
		public java.lang.String getDeskname3() {
			return this.deskname3;
		}
		/**
	     * [桌面3]名称
	     * @param deskname3 [桌面3]名称
	     */
		public void setDeskname3(java.lang.String deskname3) {
			this.deskname3 = deskname3;
		}
		 /**
	     * [桌面4]名称
	     * @return [桌面4]名称
	     */
		@Column(name="DESKNAME4")
		public java.lang.String getDeskname4() {
			return this.deskname4;
		}
		/**
	     * [桌面4]名称
	     * @param deskname4 [桌面4]名称
	     */
		public void setDeskname4(java.lang.String deskname4) {
			this.deskname4 = deskname4;
		}
		 /**
	     * [桌面5]名称
	     * @return [桌面5]名称
	     */
		@Column(name="DESKNAME5")
		public java.lang.String getDeskname5() {
			return this.deskname5;
		}
		/**
	     * [桌面5]名称
	     * @param deskname5 [桌面5]名称
	     */
		public void setDeskname5(java.lang.String deskname5) {
			this.deskname5 = deskname5;
		}
		 /**
	     * [桌面6]名称
	     * @return [桌面6]名称
	     */
		@Column(name="DESKNAME6")
		public java.lang.String getDeskname6() {
			return this.deskname6;
		}
		/**
	     * [桌面6]名称
	     * @param deskname6 [桌面6]名称
	     */
		public void setDeskname6(java.lang.String deskname6) {
			this.deskname6 = deskname6;
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
		if(obj instanceof Member == false) return false;
		if(this == obj) return true;
		Member other = (Member)obj;
		return new EqualsBuilder()
			.append(getTbid(),other.getTbid())
			.isEquals();
	}
}

