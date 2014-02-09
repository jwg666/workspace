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

import com.neusoft.base.model.SearchModel;
import com.neusoft.portal.model.Member;
/**
 * database table: tb_member
 * database table comments: Member
 */
public class MemberQuery extends  SearchModel<Member> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    

	  /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
	  /**
     * 用户类型，0普通用户，1管理员       db_column: type 
     */	
	private java.lang.Boolean type;
	  /**
     * [应用码头]应用id，用","相连       db_column: dock 
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

	public java.lang.Long getTbid() {
		return this.tbid;
	}
	
	public void setTbid(java.lang.Long value) {
		this.tbid = value;
	}
	
	
	public java.lang.Boolean getType() {
		return this.type;
	}
	
	public void setType(java.lang.Boolean value) {
		this.type = value;
	}
	
	public java.lang.String getDock() {
		return this.dock;
	}
	
	public void setDock(java.lang.String value) {
		this.dock = value==null?"":value;
	}
	
	public java.lang.String getDesk1() {
		return this.desk1;
	}
	
	public void setDesk1(java.lang.String value) {
		this.desk1 = value;
	}
	
	public java.lang.String getDesk2() {
		return this.desk2;
	}
	
	public void setDesk2(java.lang.String value) {
		this.desk2 = value;
	}
	
	public java.lang.String getDesk3() {
		return this.desk3;
	}
	
	public void setDesk3(java.lang.String value) {
		this.desk3 = value;
	}
	
	public java.lang.String getDesk4() {
		return this.desk4;
	}
	
	public void setDesk4(java.lang.String value) {
		this.desk4 = value;
	}
	
	public java.lang.String getDesk5() {
		return this.desk5;
	}
	
	public void setDesk5(java.lang.String value) {
		this.desk5 = value;
	}
	
	public java.lang.String getDesk6() {
		return this.desk6;
	}
	
	public void setDesk6(java.lang.String value) {
		this.desk6 = value;
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

	public java.lang.String getAppxy() {
		return this.appxy;
	}
	
	public void setAppxy(java.lang.String value) {
		this.appxy = value;
	}
	
	public java.lang.String getDockpos() {
		return this.dockpos;
	}
	
	public void setDockpos(java.lang.String value) {
		this.dockpos = value;
	}
	
	public java.lang.Integer getWallpaperId() {
		return this.wallpaperId;
	}
	
	public void setWallpaperId(java.lang.Integer value) {
		this.wallpaperId = value;
	}
	
	public java.lang.String getWallpaperwebsite() {
		return this.wallpaperwebsite;
	}
	
	public void setWallpaperwebsite(java.lang.String value) {
		this.wallpaperwebsite = value;
	}
	
	public Integer getWallpaperstate() {
		return this.wallpaperstate;
	}
	
	public void setWallpaperstate(Integer value) {
		this.wallpaperstate = value;
	}
	
	public java.lang.String getWallpapertype() {
		return this.wallpapertype;
	}
	
	public void setWallpapertype(java.lang.String value) {
		this.wallpapertype = value;
	}
	
	public java.lang.String getSkin() {
		return this.skin;
	}
	
	public void setSkin(java.lang.String value) {
		this.skin = value;
	}
	
	public java.util.Date getRegdt() {
		return this.regdt;
	}
	
	public void setRegdt(java.util.Date value) {
		this.regdt = value;
	}
	
	public java.util.Date getLastlogindt() {
		return this.lastlogindt;
	}
	
	public void setLastlogindt(java.util.Date value) {
		this.lastlogindt = value;
	}
	
	public java.lang.String getLastloginip() {
		return this.lastloginip;
	}
	
	public void setLastloginip(java.lang.String value) {
		this.lastloginip = value;
	}
	
	public java.lang.Integer getDesknum() {
		return desknum;
	}

	public void setDesknum(java.lang.Integer desknum) {
		this.desknum = desknum;
	}

	
	
	public String[] gotDesks(){
		String[] desks = new String[6];
		desks[0] = this.desk1;
		desks[1] = this.desk2;
		desks[2] = this.desk3;
		desks[3] = this.desk4;
		desks[4] = this.desk5;
		desks[5] = this.desk6;
		return desks;
	}
	public boolean importDesks(String[] desks){
		if(desks!=null && desks.length == 6){
			this.desk1 = desks[0]==null?"":desks[0].trim();
			this.desk2 = desks[1]==null?"":desks[1].trim();
			this.desk3 = desks[2]==null?"":desks[2].trim();
			this.desk4 = desks[3]==null?"":desks[3].trim();
			this.desk5 = desks[4]==null?"":desks[4].trim();
			this.desk6 = desks[5]==null?"":desks[5].trim();
		}
		return false;
	}
	
	public String[] getDesknames(){
		String[] desknames = new String[6];
		desknames[0] = this.deskname1;
		desknames[1] = this.deskname2;
		desknames[2] = this.deskname3;
		desknames[3] = this.deskname4;
		desknames[4] = this.deskname5;
		desknames[5] = this.deskname6;
		return desknames;
	}
	public boolean importDesknames(String[] desknames){
		if(desknames!=null && desknames.length == 6){
			this.deskname1 = desknames[0]==null?"":desknames[0].trim();
			this.deskname2 = desknames[1]==null?"":desknames[1].trim();
			this.deskname3 = desknames[2]==null?"":desknames[2].trim();
			this.deskname4 = desknames[3]==null?"":desknames[3].trim();
			this.deskname5 = desknames[4]==null?"":desknames[4].trim();
			this.deskname6 = desknames[5]==null?"":desknames[5].trim();
		}
		return false;
	}
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

