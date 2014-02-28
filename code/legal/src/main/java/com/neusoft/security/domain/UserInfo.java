/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.domain;

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
@Table(name = "TB_USER_INFO")
public class UserInfo  implements java.io.Serializable{
	private static final long serialVersionUID = 5454155825314635342L;
	
	//alias
	public static final String TABLE_ALIAS = "USER_INFO";
	public static final String ALIAS_ID = "自增主键ID";
	public static final String ALIAS_EMP_CODE = "员工编码";
	public static final String ALIAS_NAME = "用户姓名";
	public static final String ALIAS_PASSWORD = "密码";
	public static final String ALIAS_STATUS = "状态0:禁用，1：启用";
	public static final String ALIAS_EMAIL = "邮件地址";
	public static final String ALIAS_TYPE = "类型0:普通账号，1：域账号";
	public static final String ALIAS_LAST_LOGIN_IP = "上次登陆IP";
	public static final String ALIAS_CURRENT_LOGIN_IP = "当前登录IP";
	public static final String ALIAS_LAST_LOGIN_TIME = "上次登录时间";
	public static final String ALIAS_LOGIN_ATTEMPT_TIMES = "登录失败尝试次数";
	public static final String ALIAS_LOGIN_FAILD_TIME = "第一次登陆失败时间";
	public static final String ALIAS_PASSWORD_FIRST_MODIFIED_FLAG = "是否修改过默认密码0:未修改，1：修改过";
	public static final String ALIAS_PASSWORD_EXPIRE_TIME = "密码到期时间";
	public static final String ALIAS_GMT_CREATE = "创建时间";
	public static final String ALIAS_GMT_MODIFIED = "最后修改时间";
	public static final String ALIAS_CREATE_BY = "创建人";
	public static final String ALIAS_LAST_MODIFIED_BY = "最后修改人";
	public static final String ALIAS_ENCODE = "用户找回密码URL附加验证码";
	public static final String ALIAS_EXPIRED_TIME = "过期时间";
	public static final String ALIAS_LANGUAGE_ID = "语言编码";
	public static final String ALIAS_LANGUAGE_CODE = "语言编码";
	public static final String ALIAS_TIMEZONE_ID = "时区编码";
	public static final String ALIAS_TIMEZONE_CODE = "时区编码";
	public static final String ALIAS_DELETED_FLAG = "删除标识";
	public static final String ALIAS_USING_FLAG = "使用标识";
	public static final String ALIAS_MEMBER_ID = "桌面配置";
	
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

	public UserInfo(){
	}

	public UserInfo(
		Long id
	){
		this.id = id;
	}

		 /**
	     * 自增主键ID
	     * @return 自增主键ID
	     */
		@Id  
	    @GeneratedValue
		@Column(name="ID")
		public Long getId() {
			return this.id;
		}
		/**
	     * 自增主键ID
	     * @param id 自增主键ID
	     */
		public void setId(Long id) {
			this.id = id;
		}
		 /**
	     * 员工编码
	     * @return 员工编码
	     */
		@Column(name="EMP_CODE")
		public java.lang.String getEmpCode() {
			return this.empCode;
		}
		/**
	     * 员工编码
	     * @param empCode 员工编码
	     */
		public void setEmpCode(java.lang.String empCode) {
			this.empCode = empCode;
		}
		 /**
	     * 用户姓名
	     * @return 用户姓名
	     */
		@Column(name="NAME")
		public java.lang.String getName() {
			return this.name;
		}
		/**
	     * 用户姓名
	     * @param name 用户姓名
	     */
		public void setName(java.lang.String name) {
			this.name = name;
		}
		 /**
	     * 密码
	     * @return 密码
	     */
		@Column(name="PASSWORD")
		public java.lang.String getPassword() {
			return this.password;
		}
		/**
	     * 密码
	     * @param password 密码
	     */
		public void setPassword(java.lang.String password) {
			this.password = password;
		}
		 /**
	     * 状态0:禁用，1：启用
	     * @return 状态0:禁用，1：启用
	     */
		@Column(name="STATUS")
		public java.lang.Long getStatus() {
			return this.status;
		}
		/**
	     * 状态0:禁用，1：启用
	     * @param status 状态0:禁用，1：启用
	     */
		public void setStatus(java.lang.Long status) {
			this.status = status;
		}
		 /**
	     * 邮件地址
	     * @return 邮件地址
	     */
		@Column(name="EMAIL")
		public java.lang.String getEmail() {
			return this.email;
		}
		/**
	     * 邮件地址
	     * @param email 邮件地址
	     */
		public void setEmail(java.lang.String email) {
			this.email = email;
		}
		 /**
	     * 类型0:普通账号，1：域账号
	     * @return 类型0:普通账号，1：域账号
	     */
		@Column(name="TYPE")
		public java.lang.Long getType() {
			return this.type;
		}
		/**
	     * 类型0:普通账号，1：域账号
	     * @param type 类型0:普通账号，1：域账号
	     */
		public void setType(java.lang.Long type) {
			this.type = type;
		}
		 /**
	     * 上次登陆IP
	     * @return 上次登陆IP
	     */
		@Column(name="LAST_LOGIN_IP")
		public java.lang.String getLastLoginIp() {
			return this.lastLoginIp;
		}
		/**
	     * 上次登陆IP
	     * @param lastLoginIp 上次登陆IP
	     */
		public void setLastLoginIp(java.lang.String lastLoginIp) {
			this.lastLoginIp = lastLoginIp;
		}
		 /**
	     * 当前登录IP
	     * @return 当前登录IP
	     */
		@Column(name="CURRENT_LOGIN_IP")
		public java.lang.String getCurrentLoginIp() {
			return this.currentLoginIp;
		}
		/**
	     * 当前登录IP
	     * @param currentLoginIp 当前登录IP
	     */
		public void setCurrentLoginIp(java.lang.String currentLoginIp) {
			this.currentLoginIp = currentLoginIp;
		}
	
	
		 /**
	     * 上次登录时间
	     * @return 上次登录时间
	     */
		@Column(name="LAST_LOGIN_TIME")
		public java.util.Date getLastLoginTime() {
			return this.lastLoginTime;
		}
		/**
	     * 上次登录时间
	     * @param lastLoginTime 上次登录时间
	     */
		public void setLastLoginTime(java.util.Date lastLoginTime) {
			this.lastLoginTime = lastLoginTime;
		}
		 /**
	     * 登录失败尝试次数
	     * @return 登录失败尝试次数
	     */
		@Column(name="LOGIN_ATTEMPT_TIMES")
		public java.lang.Long getLoginAttemptTimes() {
			return this.loginAttemptTimes;
		}
		/**
	     * 登录失败尝试次数
	     * @param loginAttemptTimes 登录失败尝试次数
	     */
		public void setLoginAttemptTimes(java.lang.Long loginAttemptTimes) {
			this.loginAttemptTimes = loginAttemptTimes;
		}

	
		 /**
	     * 第一次登陆失败时间
	     * @return 第一次登陆失败时间
	     */
		@Column(name="LOGIN_FAILD_TIME")
		public java.util.Date getLoginFaildTime() {
			return this.loginFaildTime;
		}
		/**
	     * 第一次登陆失败时间
	     * @param loginFaildTime 第一次登陆失败时间
	     */
		public void setLoginFaildTime(java.util.Date loginFaildTime) {
			this.loginFaildTime = loginFaildTime;
		}
		 /**
	     * 是否修改过默认密码0:未修改，1：修改过
	     * @return 是否修改过默认密码0:未修改，1：修改过
	     */
		@Column(name="PASSWORD_FIRST_MODIFIED_FLAG")
		public java.lang.Long getPasswordFirstModifiedFlag() {
			return this.passwordFirstModifiedFlag;
		}
		/**
	     * 是否修改过默认密码0:未修改，1：修改过
	     * @param passwordFirstModifiedFlag 是否修改过默认密码0:未修改，1：修改过
	     */
		public void setPasswordFirstModifiedFlag(java.lang.Long passwordFirstModifiedFlag) {
			this.passwordFirstModifiedFlag = passwordFirstModifiedFlag;
		}
	  
	
		 /**
	     * 密码到期时间
	     * @return 密码到期时间
	     */
		@Column(name="PASSWORD_EXPIRE_TIME")
		public java.util.Date getPasswordExpireTime() {
			return this.passwordExpireTime;
		}
		/**
	     * 密码到期时间
	     * @param passwordExpireTime 密码到期时间
	     */
		public void setPasswordExpireTime(java.util.Date passwordExpireTime) {
			this.passwordExpireTime = passwordExpireTime;
		}
	
	
		 /**
	     * 创建时间
	     * @return 创建时间
	     */
		@Column(name="GMT_CREATE")
		public java.util.Date getGmtCreate() {
			return this.gmtCreate;
		}
		/**
	     * 创建时间
	     * @param gmtCreate 创建时间
	     */
		public void setGmtCreate(java.util.Date gmtCreate) {
			this.gmtCreate = gmtCreate;
		}
	 
	
		 /**
	     * 最后修改时间
	     * @return 最后修改时间
	     */
		@Column(name="GMT_MODIFIED")
		public java.util.Date getGmtModified() {
			return this.gmtModified;
		}
		/**
	     * 最后修改时间
	     * @param gmtModified 最后修改时间
	     */
		public void setGmtModified(java.util.Date gmtModified) {
			this.gmtModified = gmtModified;
		}
		 /**
	     * 创建人
	     * @return 创建人
	     */
		@Column(name="CREATE_BY")
		public java.lang.String getCreateBy() {
			return this.createBy;
		}
		/**
	     * 创建人
	     * @param createBy 创建人
	     */
		public void setCreateBy(java.lang.String createBy) {
			this.createBy = createBy;
		}
		 /**
	     * 最后修改人
	     * @return 最后修改人
	     */
		@Column(name="LAST_MODIFIED_BY")
		public java.lang.String getLastModifiedBy() {
			return this.lastModifiedBy;
		}
		/**
	     * 最后修改人
	     * @param lastModifiedBy 最后修改人
	     */
		public void setLastModifiedBy(java.lang.String lastModifiedBy) {
			this.lastModifiedBy = lastModifiedBy;
		}
		 /**
	     * 用户找回密码URL附加验证码
	     * @return 用户找回密码URL附加验证码
	     */
		@Column(name="ENCODE")
		public java.lang.String getEncode() {
			return this.encode;
		}
		/**
	     * 用户找回密码URL附加验证码
	     * @param encode 用户找回密码URL附加验证码
	     */
		public void setEncode(java.lang.String encode) {
			this.encode = encode;
		}
	
	
		 /**
	     * 过期时间
	     * @return 过期时间
	     */
		@Column(name="EXPIRED_TIME")
		public java.util.Date getExpiredTime() {
			return this.expiredTime;
		}
		/**
	     * 过期时间
	     * @param expiredTime 过期时间
	     */
		public void setExpiredTime(java.util.Date expiredTime) {
			this.expiredTime = expiredTime;
		}
		 /**
	     * 语言编码
	     * @return 语言编码
	     */
		@Column(name="LANGUAGE_ID")
		public java.lang.Long getLanguageId() {
			return this.languageId;
		}
		/**
	     * 语言编码
	     * @param languageId 语言编码
	     */
		public void setLanguageId(java.lang.Long languageId) {
			this.languageId = languageId;
		}
		 /**
	     * 语言编码
	     * @return 语言编码
	     */
		@Column(name="LANGUAGE_CODE")
		public java.lang.String getLanguageCode() {
			return this.languageCode;
		}
		/**
	     * 语言编码
	     * @param languageCode 语言编码
	     */
		public void setLanguageCode(java.lang.String languageCode) {
			this.languageCode = languageCode;
		}
		 /**
	     * 时区编码
	     * @return 时区编码
	     */
		@Column(name="TIMEZONE_ID")
		public java.lang.Long getTimezoneId() {
			return this.timezoneId;
		}
		/**
	     * 时区编码
	     * @param timezoneId 时区编码
	     */
		public void setTimezoneId(java.lang.Long timezoneId) {
			this.timezoneId = timezoneId;
		}
		 /**
	     * 时区编码
	     * @return 时区编码
	     */
		@Column(name="TIMEZONE_CODE")
		public java.lang.String getTimezoneCode() {
			return this.timezoneCode;
		}
		/**
	     * 时区编码
	     * @param timezoneCode 时区编码
	     */
		public void setTimezoneCode(java.lang.String timezoneCode) {
			this.timezoneCode = timezoneCode;
		}
		 /**
	     * 删除标识
	     * @return 删除标识
	     */
		@Column(name="DELETED_FLAG")
		public java.lang.String getDeletedFlag() {
			return this.deletedFlag;
		}
		/**
	     * 删除标识
	     * @param deletedFlag 删除标识
	     */
		public void setDeletedFlag(java.lang.String deletedFlag) {
			this.deletedFlag = deletedFlag;
		}
		 /**
	     * 使用标识
	     * @return 使用标识
	     */
		@Column(name="USING_FLAG")
		public java.lang.String getUsingFlag() {
			return this.usingFlag;
		}
		/**
	     * 使用标识
	     * @param usingFlag 使用标识
	     */
		public void setUsingFlag(java.lang.String usingFlag) {
			this.usingFlag = usingFlag;
		}
		 /**
	     * 桌面配置
	     * @return 桌面配置
	     */
		@Column(name="MEMBER_ID")
		public Long getMemberId() {
			return this.memberId;
		}
		/**
	     * 桌面配置
	     * @param memberId 桌面配置
	     */
		public void setMemberId(Long memberId) {
			this.memberId = memberId;
		}

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof UserInfo == false) return false;
		if(this == obj) return true;
		UserInfo other = (UserInfo)obj;
		return new EqualsBuilder()
			.append(getId(),other.getId())
			.isEquals();
	}
}

