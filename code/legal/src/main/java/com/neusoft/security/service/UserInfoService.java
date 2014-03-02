package com.neusoft.security.service;

import java.util.List;
import java.util.Map;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.LoginContext;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.UserInfo;
import com.neusoft.security.query.UserInfoQuery;

/**
 * @author WangXuzheng
 *
 */
public interface UserInfoService {
	/**
	 * 创建用户信息
	 * @param UserInfoQuery
	 * @return
	 */
	public ExecuteResult<UserInfo> createUserInfo(UserInfo userInfo);
	
	/**
	 * 根据用户id获取用户信息
	 * @param id
	 * @return
	 */
	public UserInfo getUserInfoById(Long id);
	
	/**
	 * 查询用户信息
	 * @param UserInfoSearchModel
	 * @return
	 */
	public Pager<UserInfo> searchUserInfo(UserInfoQuery userInfoQuery);
	
	/**
	 * 删除用户信息
	 * @param UserInfoId 用户id，不允许为空
	 * @return
	 */
	public ExecuteResult<?> deleteUserInfo(Long userInfoId); 
	
	/**
	 * 更新用户信息
	 * @param UserInfoQuery
	 * @return
	 */
	public ExecuteResult<UserInfo> updateUserInfo(UserInfo userInfo);
	
	/**
	 * 用户登录操作
	 * @param UserInfoName
	 * @param password
	 * @return
	 */
	public ExecuteResult<UserInfo> login(String userInfoName,String password,String ipAddress);
	/**
	 * 更新密码
	 * @param UserInfoId
	 * @param password
	 */
	public void updatePassword(Long userInfoId,String password);
	
	/**
	 * 判断用户密码是否需要提醒
	 * @param UserInfoQuery
	 * @return
	 */
	public ExecuteResult<Boolean> shouldTipPassword(UserInfo userInfo);
	
	/**
	 * 用户登出操作
	 * @param context
	 * @return
	 */
	public ExecuteResult<UserInfo> logout(LoginContext context);
	/**
	 * 检测用户输入的用户名、邮箱是否对应
	 * @param name
	 * @return
	 */
	public ExecuteResult<UserInfo> getUserInfoEmailByName(String name,String email);
	/**
	 * 检测用户找回密码的URL是否正常
	 * @param name 
	 * @param encode
	 * @return
	 */
	public ExecuteResult<UserInfo> confirmUpdatePassword(String name,String encode,String password,String confirmpassword);
	/**
	 * 更新用户的Ecode
	 * @param name
	 * @return
	 */
	public ExecuteResult<UserInfo> updateUserInfoEncode(String name);
	/**
	 * 获取用户还有多少天过期
	 * @param UserInfoQuery
	 * @return
	 */
	public String getExpiredDate(UserInfo userInfo); 
	/**
	 * 根据用户名获取用户信息
	 * @param UserInfoQuery
	 * @return
	 */
	public UserInfo getUserInfoByName(String name);
	/**
	 * 获取所有用户信息
	 * @param UserInfoQuery
	 * @return
	 */
	public List<UserInfo> getAll();
	/**
	 * 更新失效账号信息
	 * @param UserInfoQuery
	 * @return
	 */
	public ExecuteResult<UserInfo> updateExpiredUserInfo(UserInfo userInfo);
	/**
	 * 根据组ID查询组内用户
	 * @param
	 * @return
	 */
	public Pager<UserInfo> getUserInfosByGroupId(UserInfoQuery userInfoQuery);
	/**
	 * 获取用户数量
	 * @param
	 * @return
	 */
	public Long searchUserInfoCount(UserInfoQuery  userInfoQuery);
	/*
	 * 查询用户列表
	 * */
	public UserInfo getUserInfoByCode(String userInfoCode);
	public long getCountByEmpCode(String empCode);

	/**
	 * 根据用户名模糊查询用户
	 * @param qName
	 * @return
	 */
	public List<UserInfo> queryUserInfoByName(String qName);
   /**
    * 传入用户empCode  返回UserInfoId
    * @param UserInfoEmpCodeList
    * @return
    */
	public List<Long> getUserInfoIdsByEmpCodes(List<String> UserInfoEmpCodeList);
	/*判断是否已登录*/
	public ExecuteResult<UserInfo> hasLogin(ExecuteResult<UserInfo> executeResult, String ipAddress);
	public List<UserInfo> getAllUserInfo();

	public List<UserInfo> getUserInfoByEmpCodes(List<String> UserInfoEmpCodeList);

	public Pager<Map<String,Object>> getUserInfosAndGroupByGroupId(UserInfoQuery userInfoQuery);
}
