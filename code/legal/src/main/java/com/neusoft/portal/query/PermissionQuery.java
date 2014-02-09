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
import com.neusoft.portal.model.Permission;
/**
 * database table: tb_permission
 * database table comments: Permission
 */
public class PermissionQuery extends  SearchModel<Permission> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    

	  /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
	  /**
     * name       db_column: name 
     */	
	private java.lang.String name;
	  /**
     * appsId       db_column: apps_id 
     */	
	private java.lang.String appsId;

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
	
	public java.lang.String getAppsId() {
		return this.appsId;
	}
	
	public void setAppsId(java.lang.String value) {
		this.appsId = value;
	}
	

	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

