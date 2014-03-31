/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.query;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import java.io.Serializable;

import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.UserRole;
/**
 * database table: TB_USER_ROLE
 * database table comments: UserRole
 * 
 *
 * @author jiawg-贾伟光
 * @Email jiawg@neusoft.com
 *
 
 */
public class UserRoleQuery extends  SearchModel<UserRole> implements Serializable {
    
  private static final long serialVersionUID = 3148176768559230877L;
    
     private java.lang.Long[] ids;
	  /**
     * tbid       db_column: tbid 
     */	
	private java.lang.Long tbid;
	  /**
     * roleId       db_column: role_id 
     */	
	private java.lang.Long roleId;
	  /**
     * userId       db_column: user_id 
     */	
	private java.lang.Long userId;
	private String name;
	private String code;
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
	
	 /**
     * userId
     * @return userId
     */
	public java.lang.Long getUserId() {
		return this.userId;
	}
	 /**
     * userId
     * @param userId userId
     */
	public void setUserId(java.lang.Long userId) {
		this.userId = userId;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
}

