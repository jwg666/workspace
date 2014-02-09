package com.neusoft.security.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.activiti.engine.IdentityService;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.LoginContext;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PasswordUtil;
import com.neusoft.base.model.SearchModel;
import com.neusoft.security.dao.UserDAO;
import com.neusoft.security.domain.User;
import com.neusoft.security.service.UserService;

/**
 * @author WangXuzheng
 * @author lupeng
 */
@Service("UserService")
@Transactional
public class UserServiceImpl implements UserService {
//	private static final I18nResolver I18N_RESOLVER = I18nResolverFactory
//			.getDefaultI18nResolver(UserServiceImpl.class);
	private static final int PASSWORD_TIP_DAYS = 10;// 密码过期10天提前提醒
	private static final int DAY_MILLISECONDS = 24 * 60 * 60 * 1000;// 一天的毫秒数
	private UserDAO userDAO;
//	private ResourceDAO resourceDAO;
//	private CacheManager cacheManager;
//	private SendEmailService emailSender;
//	private EmailBuilder emailBuilder;
//	private GroupDAO groupDAO;
	@Resource
//	private DepartmentService departmentService;
//	@Resource
//	private UserDataConfigDao userDataConfigDao;

	private IdentityService identityService;

	public void setIdentityService(IdentityService identityService) {
		this.identityService = identityService;
	}


	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}


	@Override
	public ExecuteResult<User> createUser(User user) {
		ExecuteResult<User> executeResult = new ExecuteResult<User>();
		// 用户登录名重名检查
		User existedUser = userDAO.getByCodeIgnoreCase(StringUtils.trim(user
				.getEmpCode()));
		if (existedUser != null) {
//			executeResult.addErrorMessage(I18N_RESOLVER.getMessage(
//					"user.existed", user.getEmpCode()));
			executeResult.addErrorMessage(user.getEmpCode()+"不存在");
			return executeResult;
		}
		// 保存
		user.setEmpCode(StringUtils.trim(user.getEmpCode()));
		user.setName(user.getName());
		user.setGmtCreate(new Date());
		user.setGmtModified(new Date());
		user.setCreateBy(LoginContextHolder.get().getUserName());
		user.setLastModifiedBy(LoginContextHolder.get().getUserName());
		user.setPassword(PasswordUtil.encrypt(user.getPassword()));
		user.setLoginAttemptTimes(0);
		user.setPasswordExpireTime(calculatePasswordExpireDate());
		user.setPasswordModifiedFlag(0);
		userDAO.save(user);
		// 关联部门
//		resetUserDepartmentInfo(user, user);
		saveActivitiUser(user);
		return executeResult;
	}
	
    /**
     * 添加一个用户到Activiti {@link org.activiti.engine.identity.User}
     * @param user  用户对象, {@link User}
     */
    private void saveActivitiUser(User user) {
        String userId = user.getEmpCode();
        org.activiti.engine.identity.User activitiUser = identityService.newUser(userId);
        cloneAndSaveActivitiUser(user, activitiUser);
    }
    /**
     * 使用系统用户对象属性设置到Activiti User对象中
     * @param user          系统用户对象
     * @param activitiUser  Activiti User
     */
    private void cloneAndSaveActivitiUser(User user, org.activiti.engine.identity.User activitiUser) {
        activitiUser.setFirstName(user.getName());
        activitiUser.setLastName(StringUtils.EMPTY);
        activitiUser.setPassword(StringUtils.EMPTY);
        activitiUser.setEmail(user.getEmail());
        identityService.saveUser(activitiUser);
    }

	@Override
	public Pager<User> searchUser(SearchModel userSearchModel) {
		List<User> records = userDAO.searchUser(userSearchModel);
		long totalRecords = userDAO.searchUserCount(userSearchModel);
		return Pager.cloneFromPager(userSearchModel.getPager(), totalRecords,
				records);
	}

	@Override
	public User getUserById(Long id) {
		return userDAO.get(id);
	}

	@Override
	public ExecuteResult<?> deleteUser(Long userId) {
		ExecuteResult<?> result = new ExecuteResult<Object>();
		// 在activity中删除用户
		// 同步删除Activiti group
		
//		User user = userDAO.get(userId);
//		
//		List<UserGroup> userGroupList = groupDAO.getGroupByUserId(user.getId());
//		for (UserGroup uerGroup : userGroupList) {
//			identityService.deleteMembership(uerGroup.getUser().getEmpCode(), uerGroup
//					.getGroup().getId().toString());
//		}
		String empCode=userDAO.get(userId).getEmpCode();
		// 同步删除Activiti User
		identityService.deleteUser(empCode);
		userDAO.delete(userId);
		return result;
	}

	@Override
	public ExecuteResult<User> confirmUpdatePassword(String name,
			String encode, String password, String confirmpassword) {
		ExecuteResult<User> executeResult = new ExecuteResult<User>();
		User dbUser = userDAO.getUserByName(name);
		if (dbUser == null) {
			executeResult.addErrorMessage("用户名输入错误");
			return executeResult;
		}
		if (!password.equals(confirmpassword)) {
			executeResult.addErrorMessage("两次密码输入不一致");
			return executeResult;
		}
		if (!encode.equals(dbUser.getEncode())) {
			executeResult.addErrorMessage("修改密码链接失效");
			return executeResult;
		}
		if (!PasswordUtil.isValidPassword(password)) {
			executeResult.addErrorMessage("帐号密码至少8位，须符合大小写字母、数字、特殊字符四选三的要求.");
			return executeResult;
		} else {
			// 修改密码
			String newPassword = PasswordUtil.encrypt(confirmpassword);
			dbUser.setPassword(newPassword);
			dbUser.setEncode(null);// 清空验证码
			dbUser.setGmtModified(new Date());
			dbUser.setLastModifiedBy(name);
			dbUser.setPasswordExpireTime(calculatePasswordExpireDate());
			dbUser.setPasswordModifiedFlag(1);
			this.userDAO.update(dbUser);
			return executeResult;
		}
	}

	@Override
	public ExecuteResult<User> getUserEmailByName(String name, String email) {
		ExecuteResult<User> executeResult = new ExecuteResult<User>();
		User dbUser = userDAO.getUserByName(name);
		// 判断输入的邮箱和用户的邮箱是否相同
		if (dbUser == null) {
			executeResult.addErrorMessage("输入的用户名不存在");
			return executeResult;
		} else if (!StringUtils.equalsIgnoreCase(email, dbUser.getEmail())) {
			executeResult.addErrorMessage("输入的用户名和邮箱不匹配");
			return executeResult;
		} else {
			return executeResult;
		}
	}

	@Override
	public ExecuteResult<User> updateUserEncode(String name) {
		ExecuteResult<User> executeResult = new ExecuteResult<User>();
		User dbUser = userDAO.getUserByName(name);
		// 生成随机验证码
		String encode = UUID.randomUUID().toString();
		// 更新用户的验证码
		dbUser.setEncode(encode);// 修改验证码
		dbUser.setGmtModified(new Date());
		dbUser.setLastModifiedBy(name);
		dbUser.setPasswordExpireTime(calculatePasswordExpireDate());
		dbUser.setPasswordModifiedFlag(1);
		this.userDAO.update(dbUser);

		// 增加发送邮件方法后使用到的链接
//		String retirevepasswordurl = Env.getProperty(Env.APP_URL);
		// 组装对应的更改密码地址
		// 增加发送邮件方法后使用到的链接
//		String updatePwdUrl = retirevepasswordurl
//				+ "/security/toRetrieveUpdatePassword.action?encode=" + encode;
		// 调用发送邮件方法将地址发送给用户
//		Email email = new Email();
//		Recipient recipient = new Recipient();
//		recipient.setUserName("HopAdmin");
//		recipient.setEmailAddress(Env.getProperty(Env.APP_EAMIL.isEmpty()
//				|| Env.APP_EAMIL == null ? "" : Env.APP_EAMIL));
//		email.setSender(recipient);
//		Recipient toRecipient = new Recipient();
//		toRecipient.setUserName(name);
//		toRecipient.setEmailAddress(dbUser.getEmail());
//		List<Recipient> toRecipientList = new ArrayList<Recipient>();
//		toRecipientList.add(toRecipient);
//		email.setToRecipient(toRecipientList);
//		Map<String, String> parameters = new HashMap<String, String>();
//		parameters.put("appName", Env.getProperty(Env.APP_NAME.isEmpty()
//				|| Env.APP_NAME == null ? "" : Env.APP_NAME));
//		parameters.put("appUrl", updatePwdUrl);
//		emailBuilder.buildEmail("update_password_tip", email, parameters);
//		emailSender.sendEmail(email);
		return executeResult;
	}

	@Override
	public ExecuteResult<User> updateUser(User user) {
		ExecuteResult<User> result = new ExecuteResult<User>();
		User dbUser = userDAO.get(user.getId());
		if (dbUser == null) {
			result.addErrorMessage("该用户不存在或已经被删除。");
			return result;
		}
		// 重名检查
		if (!dbUser.getEmpCode().equals(user.getEmpCode())) {
			User namedUser = userDAO.getByCodeIgnoreCase(user.getEmpCode());
			if (namedUser != null) {
				result.addErrorMessage("用户登录名：" + user.getEmpCode() + "已经存在。");
				return result;
			}
		}
		// 关联部门
//		resetUserDepartmentInfo(user, dbUser);
		// 修改
		dbUser.setName(user.getName());
		dbUser.setEmpCode(user.getEmpCode());
		dbUser.setGmtModified(new Date());
		dbUser.setEmail(user.getEmail());
		dbUser.setLastModifiedBy(LoginContextHolder.get().getUserName());
		dbUser.setStatus(user.getStatus());
		dbUser.setExpiredTime(user.getExpiredTime());
		// dbUser.setPassword(PasswordUtil.encodePasswordMD5(user.getPassword()));
		userDAO.update(dbUser);
		result.setResult(user);
		return result;
	}

//	private void resetUserDepartmentInfo(User user, User dbUser) {
//		userDataConfigDao.deleteByEmpCode(dbUser.getEmpCode());
//		String departments = user.getDepartments();
//		if(!StringUtils.isEmpty(departments)){
//			String configs[] = departments.split(",");
//			for(String config : configs){
//				if(!StringUtils.isEmpty(config)){
//					String array [] = config.split("--");
//					UserDataConfig userDataConfig = new UserDataConfig();
//					userDataConfig.setConfigValue(array[0]);
//					userDataConfig.setConfigType(array[1]);
////					userDataConfig.setRowId(GenerateTableSeqUtil.generateTableSeq("USER_DATA_CONFIG"));
//					userDataConfig.setActiveFlag("1");
//					userDataConfig.setEmployeeCode(dbUser.getEmpCode());
//					saveUserDataConfig(userDataConfig);
//				}
//			}
//		}
//	}

//	private void saveUserDataConfig(UserDataConfig userDataConfig) {
//		if(userDataConfig.getConfigType().equals(userDataConfig.getConfigValue())){return;}
//		if("COMPANY".equals(userDataConfig.getConfigType()) || "FACTORY".equals(userDataConfig.getConfigType())){
//			if(departmentService.hasChildByCode(userDataConfig.getConfigValue())<1){
//				userDataConfigDao.save(userDataConfig);
//			}
//		}else{
//			userDataConfigDao.save(userDataConfig);
//		}
//	}

	@SuppressWarnings("unchecked")
	@Override
	public ExecuteResult<User> login(String userCode, String password,
			String ipAddress) {
		ExecuteResult<User> executeResult = new ExecuteResult<User>();
		//User userInfo = userDAO.getUserByName(userName);
		User userInfo = userDAO.getByCodeIgnoreCase(userCode);
		final String errorMsg = "用户名或密码错误，连续输错5次，账号会被禁用。";

		// 用户名和密码以及用户状态是否匹配
		if (userInfo == null) {
			executeResult.addErrorMessage(errorMsg);
			return executeResult;
		}
		/*//是否锁定或者过期
		if (UserStatusEnum.toEnum(userInfo.getStatus()) == UserStatusEnum.INACTIVE) {
			executeResult.addErrorMessage(errorMsg);
			return executeResult;
		}*/
		//是否有效
//		if (UserStatusEnum.toEnum(userInfo.getStatus()) != UserStatusEnum.ACTIVE) {
//			executeResult.addErrorMessage("账户已锁定，请联系管理员！");
//			return executeResult;
//		}
		if (!userInfo.getPassword().equals(PasswordUtil.encrypt(password))) {
			doPasswordNotMatch(userInfo);
			executeResult.addErrorMessage(errorMsg);
			return executeResult;
		}
		executeResult.setResult(userInfo);
		hasLogin(executeResult, ipAddress);
		return executeResult;
	}
	@Override
	public ExecuteResult<User> hasLogin(ExecuteResult<User> executeResult,String ipAddress){
//		User userInfo = executeResult.getResult();
//		// 不允许同一账号在多处同时登陆
//		Cache sessionCache = cacheManager
//				.getCache(CacheNames.CACHE_NAME_SESSION);
//		String key = MaxSessionUtil.generateMaxSessionKey(userInfo.getName());
//		ValueWrapper valueWrapper = sessionCache.get(key);
//		Map<String, Integer> sessionMap = null;
//		if (valueWrapper == null || valueWrapper.get() == null) {
//			sessionMap = new HashMap<String, Integer>();
//		} else {
//			sessionMap = (Map<String, Integer>) valueWrapper.get();
//		}
//		boolean localLogin = sessionMap.containsKey(ipAddress);
//		/*if ((localLogin && size > 1) || (!localLogin && size >= 1)) {// 在除本机外的其他多个地方登录过
//			executeResult.addErrorMessage("该账号已经在别处登录，请将其注销后再登录。");
//			return executeResult;
//		}*/
//		sessionMap.put(ipAddress, localLogin ? sessionMap.get(ipAddress) + 1
//				: 1);
//		sessionCache.put(key, sessionMap);
//
//		// 更新用户信息
//		userInfo.setLastLoginIp(userInfo.getCurrentLoginIp());
//		userInfo.setLastLoginTime(new Date());
//		userInfo.setLoginFaildTime(null);
//		userInfo.setLoginAttemptTimes(0);
//		userInfo.setCurrentLoginIp(ipAddress);
//		executeResult.setResult(userInfo);
//		this.userDAO.update(userInfo);
//		// 清理缓存
//		cacheManager.getCache(CacheNames.CACHE_NAME_USER).evict(
//				CacheNames.USER_KEY_PREFIX + userInfo.getId());
		return executeResult;
	}

	private void doPasswordNotMatch(User userInfo) {
//		final long accountLockTime = 60 * 60 * 1000L;// 登陆1小时内尝试5次
//		if (userInfo.getLoginFaildTime() == null) {
//			userInfo.setLoginFaildTime(new Date());
//		} else if (userInfo.getLoginFaildTime().getTime() + accountLockTime < System
//				.currentTimeMillis()) {
//			userInfo.setLoginFaildTime(new Date());
//			userInfo.setLoginAttemptTimes(0);
//		}
//		userInfo.setLoginAttemptTimes((userInfo.getLoginAttemptTimes() == null ? 0
//				: userInfo.getLoginAttemptTimes()) + 1);// 错误次数累加
//		final Integer loginTimes = 5;// 最多可以连续登陆5次密码错误
//		if (userInfo.getLoginAttemptTimes() >= loginTimes) {
//			userInfo.setStatus(UserStatusEnum.INACTIVE.getStatus());// 自动锁定
//		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public ExecuteResult<User> logout(LoginContext context) {
		// 清理用户资源缓存
//		List<String> moduleNames = resourceDAO.getmoduleNames();
//		for (String moduleName : moduleNames) {
//			if (moduleName != null && !moduleName.isEmpty()) {
//				cacheManager.getCache(CacheNames.CACHE_NAME_RESOURCE).evict(
//						Env.getProperty(Env.KEY_SERVER_NAME) + ":resource:"
//								+ context.getUserId() + ":" + moduleName);
//			}
//		}
		ExecuteResult<User> executeResult = new ExecuteResult<User>();
//		Cache sessionCache = cacheManager
//				.getCache(CacheNames.CACHE_NAME_SESSION);
//		String key = MaxSessionUtil
//				.generateMaxSessionKey(context.getUserName());
//		ValueWrapper valueWrapper = sessionCache.get(key);
//		if (valueWrapper == null) {
//			return executeResult;
//		}
//		Map<String, Integer> sessionMap = (Map<String, Integer>) valueWrapper
//				.get();
//		if (sessionMap != null) {
//			Integer sessions = sessionMap.get(context.getIp());
//			if (sessions == null || sessions <= 1) {
//				sessionMap.remove(context.getIp());
//			} else {
//				sessionMap.put(context.getIp(), sessions - 1);
//			}
//			sessionCache.put(key, sessionMap);
//		}
		return executeResult;
	}

	private Date calculatePasswordExpireDate() {
		Calendar clendar = Calendar.getInstance();
		clendar.add(Calendar.MONTH, 2);// 2个月后密码过期
		return clendar.getTime();
	}

	@Override
	public void updatePassword(Long userId, String password) {
		String newPassword = PasswordUtil.encrypt(password);
		User user = getUserById(userId);
		if (user == null) {
			return;
		}
		user.setPassword(newPassword);
		user.setGmtModified(new Date());
		user.setLastModifiedBy(LoginContextHolder.get().getUserName());
		user.setPasswordExpireTime(calculatePasswordExpireDate());
		user.setPasswordModifiedFlag(1);
		this.userDAO.update(user);
	}

	@Override
	public ExecuteResult<Boolean> shouldTipPassword(User user) {
		ExecuteResult<Boolean> executeResult = new ExecuteResult<Boolean>();
		Integer flag = user.getPasswordModifiedFlag();
		if (flag == null || flag == 0) {
			executeResult.addErrorMessage("首次登陆系统必须修改默认密码.");
			return executeResult;
		}
		// 密码是否即将过期，
		Date now = formatDate(new Date());
		Date expireDate = formatDate(user.getPasswordExpireTime());
		Date tipDay = DateUtils.addDays(expireDate, -PASSWORD_TIP_DAYS);
		long expiredTime = now.getTime() - tipDay.getTime();
		long exprireDays = expiredTime / DAY_MILLISECONDS;// 到期天数
		if (exprireDays >= 0) {
			if (exprireDays < PASSWORD_TIP_DAYS) {
				executeResult.addErrorMessage("您的密码还有"
						+ (PASSWORD_TIP_DAYS - exprireDays) + "天过期，请及时更改密码.");
			} else {
				executeResult.addErrorMessage("您的密码已经过期，请及时更改密码.");
			}
		}
		return executeResult;
	}

	// 去除时间中的时分秒和毫秒
	private Date formatDate(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}

	@Override
	public String getExpiredDate(User user) {
//		if (user.getExpiredTime() != null) {
//			SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMdd");
//			String expiredTime = dateFormat.format(user.getExpiredTime());
//			String nowTime = dateFormat.format(new Date());
//			long expiredDate = Long.parseLong(expiredTime)
//					- Long.parseLong(nowTime);
//			if (expiredDate > 0 && expiredDate < 7) {
//				String[] admin = Env.getProperty(Env.SYS_ADMIN).split(",");
//				StringBuffer result = new StringBuffer();
//				if (admin.length > 0) {
//					for (String ad : admin) {
//						User adminInfo = this.getUserByName(ad);
//						result = result.append("-" + adminInfo.getName()
//								+ "(邮箱:" + adminInfo.getEmail() + ");");
//					}
//					String info = "您的账号将会在" + expiredDate + "天后过期,请联系管理员:"
//							+ result.toString();
//					return info;
//				} else {
//					return null;
//				}
//			} else {
//				return null;
//			}
//		} else {
			return null;
//		}
	}

	@Override
	public User getUserByName(String name) {
		return userDAO.getUserByName(name);
	}

	@Override
	public List<User> getAll() {
		return userDAO.getAll();
	}

	@Override
	public ExecuteResult<User> updateExpiredUser(User user) {
		ExecuteResult<User> result = new ExecuteResult<User>();
		User dbUser = userDAO.get(user.getId());
		if (dbUser == null) {
			result.addErrorMessage("该用户不存在或已经被删除。");
			return result;
		}
		// 重名检查
		if (!dbUser.getName().equals(user.getName())) {
			User namedUser = userDAO.getUserByName(user.getName());
			if (namedUser != null) {
				result.addErrorMessage("用户名：" + user.getName() + "已经存在。");
				return result;
			}
		}
		// 关联部门
//		resetUserDepartmentInfo(user, dbUser);
		// 修改
		dbUser.setGmtModified(new Date());
		dbUser.setEmail(user.getEmail());
		dbUser.setName(user.getName());
		dbUser.setLastModifiedBy("ShowcaseQuartz");
		dbUser.setStatus(user.getStatus());
		dbUser.setExpiredTime(user.getExpiredTime());
		// dbUser.setPassword(PasswordUtil.encodePasswordMD5(user.getPassword()));
		userDAO.update(dbUser);
		result.setResult(user);
		return result;
	}

	@Override
	public Pager<User> getUsersByGroupId(SearchModel model) {
		List<User> users = userDAO.getUsersByGroupId(model);
		long size = userDAO.getUsersByGroupIdCount(model);
		return Pager.cloneFromPager(model.getPager(), size, users);
	}

	@Override
	public Long searchUserCount(SearchModel userSearchModel) {
		
		return userDAO.searchUserCount(userSearchModel);
	}

	@Override
	public User getUserByCode(String userCode) {
		// 
		return userDAO.getUserByCode(userCode);
	}
	@Override
	public long getCountByEmpCode(String empCode) {
		// 
		return userDAO.getCountByEmpCode(empCode);
	}

	@Override
	public List<User> queryUserByName(String qName) {
		// 
		return userDAO.queryUserByName(qName);
	}

	@Override
	public List<Long> getUserIdsByEmpCodes(List<String> userEmpCodeList) {
		// 
		return userDAO.getUserIdsByEmpCodes(userEmpCodeList);
	}

	@Override
	public List<User> getAllUser() {
		return userDAO.getAllUser();
	}
	

	@Override
	public List<User> getUserByEmpCodes(List<String> userEmpCodeList) {
		return userDAO.getUserByEmpCodes(userEmpCodeList);
	}

	@Override
	public Pager<Map<String,Object>> getUsersAndGroupByGroupId(SearchModel userSearchModel) {
		//getUsersAndGroupByGroupId
//		List<Map<String,Object>> users = userDAO.getUsersAndGroupByGroupId(userSearchModel.getMap());
//		for(Map<String,Object> map:users){
//			map.put("name", map.get("USER_NAME"));
//			map.put("empCode", map.get("EMP_CODE"));
//			map.put("groupName", map.get("GROUP_NAME"));
//			map.put("groupCode", map.get("GROUP_CODE"));
//			
//		}
//		long size = userDAO.getUsersAndGroupByGroupIdCount(userSearchModel.getMap());
//		return Pager.cloneFromPager(userSearchModel.getPager(), size, users);
		return null;
	}


	
}
