package com.neusoft.security.service;

import java.util.List;
import java.util.Map;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.LoginContext;
import com.neusoft.base.common.Pager;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.domain.User;

/**
 * @author WangXuzheng
 *
 */
public interface UserService {
	/**
	 * 创建用户信息
	 * @param user
	 * @return
	 */
	public ExecuteResult<User> createUser(User user);
	
	/**
	 * 根据用户id获取用户信息
	 * @param id
	 * @return
	 */
	public User getUserById(Long id);
	
	/**
	 * 查询用户信息
	 * @param userSearchModel
	 * @return
	 */
	public Pager<User> searchUser(SearchModel<User> userSearchModel);
	
	/**
	 * 删除用户信息
	 * @param userId 用户id，不允许为空
	 * @return
	 */
	public ExecuteResult<?> deleteUser(Long userId); 
	
	/**
	 * 更新用户信息
	 * @param user
	 * @return
	 */
	public ExecuteResult<User> updateUser(User user);
	
	/**
	 * 用户登录操作
	 * @param userName
	 * @param password
	 * @return
	 */
	public ExecuteResult<User> login(String userName,String password,String ipAddress);
	/**
	 * 更新密码
	 * @param userId
	 * @param password
	 */
	public void updatePassword(Long userId,String password);
	
	/**
	 * 判断用户密码是否需要提醒
	 * @param user
	 * @return
	 */
	public ExecuteResult<Boolean> shouldTipPassword(User user);
	
	/**
	 * 用户登出操作
	 * @param context
	 * @return
	 */
	public ExecuteResult<User> logout(LoginContext context);
	/**
	 * 检测用户输入的用户名、邮箱是否对应
	 * @param name
	 * @return
	 */
	public ExecuteResult<User> getUserEmailByName(String name,String email);
	/**
	 * 检测用户找回密码的URL是否正常
	 * @param name 
	 * @param encode
	 * @return
	 */
	public ExecuteResult<User> confirmUpdatePassword(String name,String encode,String password,String confirmpassword);
	/**
	 * 更新用户的Ecode
	 * @param name
	 * @return
	 */
	public ExecuteResult<User> updateUserEncode(String name);
	/**
	 * 获取用户还有多少天过期
	 * @param user
	 * @return
	 */
	public String getExpiredDate(User user); 
	/**
	 * 根据用户名获取用户信息
	 * @param user
	 * @return
	 */
	public User getUserByName(String name);
	/**
	 * 获取所有用户信息
	 * @param user
	 * @return
	 */
	public List<User> getAll();
	/**
	 * 更新失效账号信息
	 * @param user
	 * @return
	 */
	public ExecuteResult<User> updateExpiredUser(User user);
	/**
	 * 根据组ID查询组内用户
	 * @param
	 * @return
	 */
	public Pager<User> getUsersByGroupId(SearchModel<User> model);
	/**
	 * 获取用户数量
	 * @param
	 * @return
	 */
	public Long searchUserCount(SearchModel<User> userSearchModel);
	/*
	 * 查询用户列表
	 * */
	public User getUserByCode(String userCode);
	public long getCountByEmpCode(String empCode);

	/**
	 * 根据用户名模糊查询用户
	 * @param qName
	 * @return
	 */
	public List<User> queryUserByName(String qName);
   /**
    * 传入用户empCode  返回userId
    * @param userEmpCodeList
    * @return
    */
	public List<Long> getUserIdsByEmpCodes(List<String> userEmpCodeList);
	/*判断是否已登录*/
	public ExecuteResult<User> hasLogin(ExecuteResult<User> executeResult, String ipAddress);
	public List<User> getAllUser();

	public List<User> getUserByEmpCodes(List<String> userEmpCodeList);

	public Pager<Map<String,Object>> getUsersAndGroupByGroupId(SearchModel userSearchModel);
}
