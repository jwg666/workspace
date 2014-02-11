package com.neusoft.security.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import com.neusoft.base.domain.BaseDomain;

/**
 *  用户信息
 * @author WangXuzheng
 *
 */
public class User extends BaseDomain<Long>{
	private static final long serialVersionUID = -112280423769600328L;
	private Long tbid;
	private String name;
	private String password;
	private Integer status;
	private String email;
	private Integer type;
	private String lastLoginIp;
	private String currentLoginIp;
	private Date lastLoginTime;
	private Integer loginAttemptTimes;
	private Integer passwordModifiedFlag;//是否修改了系统初始化密码
	private Date passwordExpireTime;//密码到期时间
	private Date loginFaildTime;//登陆失败时间
	private String departments ;
	private String encode;//用户找回密码验证码
	private Date expiredTime;
	private String empCode;
	private Integer memberId;
	public Long getTbid() {
		return tbid;
	}
	public void setTbid(Long tbid) {
		this.tbid = tbid;
	}
	public Date getExpiredTime() {
		return expiredTime;
	}
	public void setExpiredTime(Date expiredTime) {
		this.expiredTime = expiredTime;
	}
	public String getEncode() {
		return encode;
	}
	public void setEncode(String encode) {
		this.encode = encode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getCurrentLoginIp() {
		return currentLoginIp;
	}
	public void setCurrentLoginIp(String currentLoginIp) {
		this.currentLoginIp = currentLoginIp;
	}
	public String getLastLoginIp() {
		return lastLoginIp;
	}
	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
	public Date getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public Integer getLoginAttemptTimes() {
		return loginAttemptTimes;
	}
	public void setLoginAttemptTimes(Integer loginAttemptTimes) {
		this.loginAttemptTimes = loginAttemptTimes;
	}
	public Date getLoginFaildTime() {
		return loginFaildTime;
	}
	public void setLoginFaildTime(Date loginFaildTime) {
		this.loginFaildTime = loginFaildTime;
	}
	public Integer getPasswordModifiedFlag() {
		return passwordModifiedFlag;
	}
	public void setPasswordModifiedFlag(Integer passwordModifiedFlag) {
		this.passwordModifiedFlag = passwordModifiedFlag;
	}
	public Date getPasswordExpireTime() {
		return passwordExpireTime;
	}
	public void setPasswordExpireTime(Date passwordExpireTime) {
		this.passwordExpireTime = passwordExpireTime;
	}
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public String getDepartments() {
		return departments;
	}
	public void setDepartments(String departments) {
		this.departments = departments;
	}
}
