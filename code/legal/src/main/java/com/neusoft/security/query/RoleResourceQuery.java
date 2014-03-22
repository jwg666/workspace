/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.query;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import java.io.Serializable;

import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.RoleResource;
/**
 * database table: TB_ROLE_RESOURCE
 * database table comments: RoleResource
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
public class RoleResourceQuery extends  SearchModel<RoleResource> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    
     private java.lang.Long[] ids;
	  /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
	  /**
     * resourceId       db_column: resource_id 
     */	
	private java.lang.Long resourceId;
	  /**
     * roleId       db_column: role_id 
     */	
	private java.lang.Long roleId;

	 /**
     * tbid
     * @return tbid
     */
	public java.lang.Long getTbid() {
		return this.tbid;
	}
	 /**
     * tbid
     * @param tbid tbid
     */
	public void setTbid(java.lang.Long tbid) {
		this.tbid = tbid;
	}
	
	 /**
     * resourceId
     * @return resourceId
     */
	public java.lang.Long getResourceId() {
		return this.resourceId;
	}
	 /**
     * resourceId
     * @param resourceId resourceId
     */
	public void setResourceId(java.lang.Long resourceId) {
		this.resourceId = resourceId;
	}
	
	 /**
     * roleId
     * @return roleId
     */
	public java.lang.Long getRoleId() {
		return this.roleId;
	}
	 /**
     * roleId
     * @param roleId roleId
     */
	public void setRoleId(java.lang.Long roleId) {
		this.roleId = roleId;
	}
	
	
	public java.lang.Long[] getIds() {
		return ids;
	}
	
	public void setIds(java.lang.Long[] ids) {
		this.ids = ids;
	}

	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}

