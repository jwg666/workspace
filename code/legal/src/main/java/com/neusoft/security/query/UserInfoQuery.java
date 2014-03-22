/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.query;

import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.UserInfo;


public class UserInfoQuery extends SearchModel<UserInfo>  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	private Long[] ids;
    /**
     * 自增主键ID       db_column: ID 
     */	
	private Long id;
    /**
     * 员工编码       db_column: EMP_CODE 
     */	
	private java.lang.String empCode;
    /**
     * 用户姓名       db_column: NAME 
     */	
	private java.lang.String name;
    /**
     * 密码       db_column: PASSWORD 
     */	
	private java.lang.String password;
    /**
     * 状态0:禁用，1：启用       db_column: STATUS 
     */	
	private java.lang.Long status;
    /**
     * 邮件地址       db_column: EMAIL 
     */	
	private java.lang.String email;
    /**
     * 类型0:普通账号，1：域账号       db_column: TYPE 
     */	
	private java.lang.Long type;
    /**
     * 上次登陆IP       db_column: LAST_LOGIN_IP 
     */	
	private java.lang.String lastLoginIp;
    /**
     * 当前登录IP       db_column: CURRENT_LOGIN_IP 
     */	
	private java.lang.String currentLoginIp;
    /**
     * 上次登录时间       db_column: LAST_LOGIN_TIME 
     */	
	private java.util.Date lastLoginTime;
    /**
     * 登录失败尝试次数       db_column: LOGIN_ATTEMPT_TIMES 
     */	
	private java.lang.Long loginAttemptTimes;
    /**
     * 第一次登陆失败时间       db_column: LOGIN_FAILD_TIME 
     */	
	private java.util.Date loginFaildTime;
    /**
     * 是否修改过默认密码0:未修改，1：修改过       db_column: PASSWORD_FIRST_MODIFIED_FLAG 
     */	
	private java.lang.Long passwordFirstModifiedFlag;
    /**
     * 密码到期时间       db_column: PASSWORD_EXPIRE_TIME 
     */	
	private java.util.Date passwordExpireTime;
    /**
     * 创建时间       db_column: GMT_CREATE 
     */	
	private java.util.Date gmtCreate;
    /**
     * 最后修改时间       db_column: GMT_MODIFIED 
     */	
	private java.util.Date gmtModified;
    /**
     * 创建人       db_column: CREATE_BY 
     */	
	private java.lang.String createBy;
    /**
     * 最后修改人       db_column: LAST_MODIFIED_BY 
     */	
	private java.lang.String lastModifiedBy;
    /**
     * 用户找回密码URL附加验证码       db_column: ENCODE 
     */	
	private java.lang.String encode;
    /**
     * 过期时间       db_column: EXPIRED_TIME 
     */	
	private java.util.Date expiredTime;
    /**
     * 语言编码       db_column: LANGUAGE_ID 
     */	
	private java.lang.Long languageId;
    /**
     * 语言编码       db_column: LANGUAGE_CODE 
     */	
	private java.lang.String languageCode;
    /**
     * 时区编码       db_column: TIMEZONE_ID 
     */	
	private java.lang.Long timezoneId;
    /**
     * 时区编码       db_column: TIMEZONE_CODE 
     */	
	private java.lang.String timezoneCode;
    /**
     * 删除标识       db_column: DELETED_FLAG 
     */	
	private java.lang.String deletedFlag;
    /**
     * 使用标识       db_column: USING_FLAG 
     */	
	private java.lang.String usingFlag;
    /**
     * 桌面配置       db_column: MEMBER_ID 
     */	
	private Long memberId;
	//columns END
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public java.lang.String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(java.lang.String empCode) {
		this.empCode = empCode;
	}
	public java.lang.String getName() {
		return name;
	}
	public void setName(java.lang.String name) {
		this.name = name;
	}
	public java.lang.String getPassword() {
		return password;
	}
	public void setPassword(java.lang.String password) {
		this.password = password;
	}
	public java.lang.Long getStatus() {
		return status;
	}
	public void setStatus(java.lang.Long status) {
		this.status = status;
	}
	public java.lang.String getEmail() {
		return email;
	}
	public void setEmail(java.lang.String email) {
		this.email = email;
	}
	public java.lang.Long getType() {
		return type;
	}
	public void setType(java.lang.Long type) {
		this.type = type;
	}
	public java.lang.String getLastLoginIp() {
		return lastLoginIp;
	}
	public void setLastLoginIp(java.lang.String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
	public java.lang.String getCurrentLoginIp() {
		return currentLoginIp;
	}
	public void setCurrentLoginIp(java.lang.String currentLoginIp) {
		this.currentLoginIp = currentLoginIp;
	}
	public java.util.Date getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(java.util.Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public java.lang.Long getLoginAttemptTimes() {
		return loginAttemptTimes;
	}
	public void setLoginAttemptTimes(java.lang.Long loginAttemptTimes) {
		this.loginAttemptTimes = loginAttemptTimes;
	}
	public java.util.Date getLoginFaildTime() {
		return loginFaildTime;
	}
	public void setLoginFaildTime(java.util.Date loginFaildTime) {
		this.loginFaildTime = loginFaildTime;
	}
	public java.lang.Long getPasswordFirstModifiedFlag() {
		return passwordFirstModifiedFlag;
	}
	public void setPasswordFirstModifiedFlag(
			java.lang.Long passwordFirstModifiedFlag) {
		this.passwordFirstModifiedFlag = passwordFirstModifiedFlag;
	}
	public java.util.Date getPasswordExpireTime() {
		return passwordExpireTime;
	}
	public void setPasswordExpireTime(java.util.Date passwordExpireTime) {
		this.passwordExpireTime = passwordExpireTime;
	}
	public java.util.Date getGmtCreate() {
		return gmtCreate;
	}
	public void setGmtCreate(java.util.Date gmtCreate) {
		this.gmtCreate = gmtCreate;
	}
	public java.util.Date getGmtModified() {
		return gmtModified;
	}
	public void setGmtModified(java.util.Date gmtModified) {
		this.gmtModified = gmtModified;
	}
	public java.lang.String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(java.lang.String createBy) {
		this.createBy = createBy;
	}
	public java.lang.String getLastModifiedBy() {
		return lastModifiedBy;
	}
	public void setLastModifiedBy(java.lang.String lastModifiedBy) {
		this.lastModifiedBy = lastModifiedBy;
	}
	public java.lang.String getEncode() {
		return encode;
	}
	public void setEncode(java.lang.String encode) {
		this.encode = encode;
	}
	public java.util.Date getExpiredTime() {
		return expiredTime;
	}
	public void setExpiredTime(java.util.Date expiredTime) {
		this.expiredTime = expiredTime;
	}
	public java.lang.Long getLanguageId() {
		return languageId;
	}
	public void setLanguageId(java.lang.Long languageId) {
		this.languageId = languageId;
	}
	public java.lang.String getLanguageCode() {
		return languageCode;
	}
	public void setLanguageCode(java.lang.String languageCode) {
		this.languageCode = languageCode;
	}
	public java.lang.Long getTimezoneId() {
		return timezoneId;
	}
	public void setTimezoneId(java.lang.Long timezoneId) {
		this.timezoneId = timezoneId;
	}
	public java.lang.String getTimezoneCode() {
		return timezoneCode;
	}
	public void setTimezoneCode(java.lang.String timezoneCode) {
		this.timezoneCode = timezoneCode;
	}
	public java.lang.String getDeletedFlag() {
		return deletedFlag;
	}
	public void setDeletedFlag(java.lang.String deletedFlag) {
		this.deletedFlag = deletedFlag;
	}
	public java.lang.String getUsingFlag() {
		return usingFlag;
	}
	public void setUsingFlag(java.lang.String usingFlag) {
		this.usingFlag = usingFlag;
	}
	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	public Long[] getIds() {
		return ids;
	}
	public void setIds(Long[] ids) {
		this.ids = ids;
	}
	
}

