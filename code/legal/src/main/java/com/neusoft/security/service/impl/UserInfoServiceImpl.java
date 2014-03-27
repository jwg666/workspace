package com.neusoft.security.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.activiti.engine.IdentityService;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.LoginContext;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PasswordUtil;
import com.neusoft.base.model.DataGrid;
import com.neusoft.security.dao.UserInfoDAO;
import com.neusoft.security.domain.UserInfo;
import com.neusoft.security.query.UserInfoQuery;
import com.neusoft.security.service.UserInfoService;

@Component("userInfoService")
@Transactional
public class UserInfoServiceImpl implements UserInfoService {
//	private static final I18nResolver I18N_RESOLVER = I18nResolverFactory
//			.getDefaultI18nResolver(UserInfoServiceImpl.class);
	private static final int PASSWORD_TIP_DAYS = 10;// 密码过期10天提前提醒
	private static final int DAY_MILLISECONDS = 24 * 60 * 60 * 1000;// 一天的毫秒数
	@Resource
	private UserInfoDAO userInfoDAO;
//	private ResourceDAO resourceDAO;
//	private CacheManager cacheManager;
//	private SendEmailService emailSender;
//	private EmailBuilder emailBuilder;
//	private GroupDAO groupDAO;
	
//	private DepartmentService departmentService;
//	@Resource
//	private UserInfoDataConfigDao UserInfoDataConfigDao;
	@Resource
	private IdentityService identityService;


	@Override
	public ExecuteResult<UserInfo> createUserInfo(UserInfo userInfo) {
		ExecuteResult<UserInfo> executeResult = new ExecuteResult<UserInfo>();
		// 用户登录名重名检查
		UserInfo existedUserInfo = userInfoDAO.getByCodeIgnoreCase(StringUtils.trim(userInfo.getEmpCode()));
		if (existedUserInfo != null) {
//			executeResult.addErrorMessage(I18N_RESOLVER.getMessage(
//					"UserInfo.existed", UserInfo.getEmpCode()));
			executeResult.addErrorMessage(userInfo.getEmpCode()+"不存在");
			return executeResult;
		}
		// 保存
		userInfo.setEmpCode(StringUtils.trim(userInfo.getEmpCode()));
		userInfo.setName(userInfo.getName());
		userInfo.setGmtCreate(new Date());
		userInfo.setGmtModified(new Date());
		userInfo.setCreateBy(LoginContextHolder.get().getUserName());
		userInfo.setLastModifiedBy(LoginContextHolder.get().getUserName());
		userInfo.setPassword(PasswordUtil.encrypt(userInfo.getPassword()));
//		userInfo.setLoginAttemptTimes(0);
		userInfo.setPasswordExpireTime(calculatePasswordExpireDate());
//		userInfo.setPasswordModifiedFlag(0);
		userInfoDAO.save(userInfo);
		// 关联部门
//		resetUserInfoDepartmentInfo(UserInfo, UserInfo);
		saveActivitiUserInfo(userInfo);
		return executeResult;
	}
	
    /**
     * 添加一个用户到Activiti {@link org.activiti.engine.identity.UserInfoQuery}
     * @param UserInfoQuery  用户对象, {@link UserInfo}
     */
    private void saveActivitiUserInfo(UserInfo userInfo) {
        String userInfoId = userInfo.getEmpCode();
        org.activiti.engine.identity.User activitiUserInfo = identityService.newUser(userInfoId);
        cloneAndSaveActivitiUser(userInfo, activitiUserInfo);
    }
    /**
     * 使用系统用户对象属性设置到Activiti UserInfo对象中
     * @param UserInfoQuery          系统用户对象
     * @param activitiUserInfo  Activiti UserInfo
     */
    private void cloneAndSaveActivitiUser(UserInfo userInfo, org.activiti.engine.identity.User activitiUser) {
    	activitiUser.setFirstName(userInfo.getName());
    	activitiUser.setLastName(StringUtils.EMPTY);
    	activitiUser.setPassword(StringUtils.EMPTY);
    	activitiUser.setEmail(userInfo.getEmail());
        identityService.saveUser(activitiUser);
    }

	@Override
	public Pager<UserInfo> searchUserInfo(UserInfoQuery userInfoQuery) {
		List<UserInfo> records = userInfoDAO.searchUserInfo(userInfoQuery);
		long totalRecords = userInfoDAO.searchUserInfoCount(userInfoQuery);
		return Pager.cloneFromPager(userInfoQuery.getPager(), totalRecords,
				records);
	}

	@Override
	public UserInfo getUserInfoById(Long id) {
		return userInfoDAO.get(id);
	}

	@Override
	public ExecuteResult<?> deleteUserInfo(Long userInfoId) {
		ExecuteResult<?> result = new ExecuteResult<Object>();
		// 在activity中删除用户
		// 同步删除Activiti group
		
//		UserInfo UserInfo = UserInfoDAO.get(UserInfoId);
//		
//		List<UserInfoGroup> UserInfoGroupList = groupDAO.getGroupByUserInfoId(UserInfo.getId());
//		for (UserInfoGroup uerGroup : UserInfoGroupList) {
//			identityService.deleteMembership(uerGroup.getUserInfo().getEmpCode(), uerGroup
//					.getGroup().getId().toString());
//		}
		String empCode=userInfoDAO.get(userInfoId).getEmpCode();
		// 同步删除Activiti UserInfo
		identityService.deleteUser(empCode);
		userInfoDAO.delete(userInfoId);
		return result;
	}

	@Override
	public ExecuteResult<UserInfo> confirmUpdatePassword(String name,
			String encode, String password, String confirmpassword) {
		ExecuteResult<UserInfo> executeResult = new ExecuteResult<UserInfo>();
		UserInfo dbUserInfo = userInfoDAO.getUserInfoByName(name);
		if (dbUserInfo == null) {
			executeResult.addErrorMessage("用户名输入错误");
			return executeResult;
		}
		if (!password.equals(confirmpassword)) {
			executeResult.addErrorMessage("两次密码输入不一致");
			return executeResult;
		}
		if (!encode.equals(dbUserInfo.getEncode())) {
			executeResult.addErrorMessage("修改密码链接失效");
			return executeResult;
		}
		if (!PasswordUtil.isValidPassword(password)) {
			executeResult.addErrorMessage("帐号密码至少8位，须符合大小写字母、数字、特殊字符四选三的要求.");
			return executeResult;
		} else {
			// 修改密码
			String newPassword = PasswordUtil.encrypt(confirmpassword);
			dbUserInfo.setPassword(newPassword);
			dbUserInfo.setEncode(null);// 清空验证码
			dbUserInfo.setGmtModified(new Date());
			dbUserInfo.setLastModifiedBy(name);
			dbUserInfo.setPasswordExpireTime(calculatePasswordExpireDate());
//			dbUserInfo.setPasswordModifiedFlag(1);
			this.userInfoDAO.update(dbUserInfo);
			return executeResult;
		}
	}

	@Override
	public ExecuteResult<UserInfo> getUserInfoEmailByName(String name, String email) {
		ExecuteResult<UserInfo> executeResult = new ExecuteResult<UserInfo>();
		UserInfo dbUserInfo = userInfoDAO.getUserInfoByName(name);
		// 判断输入的邮箱和用户的邮箱是否相同
		if (dbUserInfo == null) {
			executeResult.addErrorMessage("输入的用户名不存在");
			return executeResult;
		} else if (!StringUtils.equalsIgnoreCase(email, dbUserInfo.getEmail())) {
			executeResult.addErrorMessage("输入的用户名和邮箱不匹配");
			return executeResult;
		} else {
			return executeResult;
		}
	}

	@Override
	public ExecuteResult<UserInfo> updateUserInfoEncode(String name) {
		ExecuteResult<UserInfo> executeResult = new ExecuteResult<UserInfo>();
		UserInfo dbUserInfo = userInfoDAO.getUserInfoByName(name);
		// 生成随机验证码
		String encode = UUID.randomUUID().toString();
		// 更新用户的验证码
		dbUserInfo.setEncode(encode);// 修改验证码
		dbUserInfo.setGmtModified(new Date());
		dbUserInfo.setLastModifiedBy(name);
		dbUserInfo.setPasswordExpireTime(calculatePasswordExpireDate());
//		dbUserInfo.setPasswordModifiedFlag(1);
		this.userInfoDAO.update(dbUserInfo);

		// 增加发送邮件方法后使用到的链接
//		String retirevepasswordurl = Env.getProperty(Env.APP_URL);
		// 组装对应的更改密码地址
		// 增加发送邮件方法后使用到的链接
//		String updatePwdUrl = retirevepasswordurl
//				+ "/security/toRetrieveUpdatePassword.action?encode=" + encode;
		// 调用发送邮件方法将地址发送给用户
//		Email email = new Email();
//		Recipient recipient = new Recipient();
//		recipient.setUserInfoName("HopAdmin");
//		recipient.setEmailAddress(Env.getProperty(Env.APP_EAMIL.isEmpty()
//				|| Env.APP_EAMIL == null ? "" : Env.APP_EAMIL));
//		email.setSender(recipient);
//		Recipient toRecipient = new Recipient();
//		toRecipient.setUserInfoName(name);
//		toRecipient.setEmailAddress(dbUserInfo.getEmail());
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
	public ExecuteResult<UserInfo> updateUserInfo(UserInfo userInfo) {
		ExecuteResult<UserInfo> result = new ExecuteResult<UserInfo>();
		UserInfo dbUserInfo = userInfoDAO.get(userInfo.getId());
		if (dbUserInfo == null) {
			result.addErrorMessage("该用户不存在或已经被删除。");
			return result;
		}
		// 重名检查
		if (!dbUserInfo.getEmpCode().equals(userInfo.getEmpCode())) {
			UserInfo namedUserInfo = userInfoDAO.getByCodeIgnoreCase(userInfo.getEmpCode());
			if (namedUserInfo != null) {
				result.addErrorMessage("用户登录名：" + userInfo.getEmpCode() + "已经存在。");
				return result;
			}
		}
		// 关联部门
//		resetUserInfoDepartmentInfo(UserInfo, dbUserInfo);
		// 修改
		dbUserInfo.setName(userInfo.getName());
		dbUserInfo.setEmpCode(userInfo.getEmpCode());
		dbUserInfo.setGmtModified(new Date());
		dbUserInfo.setEmail(userInfo.getEmail());
		dbUserInfo.setLastModifiedBy(LoginContextHolder.get().getUserName());
		dbUserInfo.setStatus(userInfo.getStatus());
		dbUserInfo.setExpiredTime(userInfo.getExpiredTime());
		// dbUserInfo.setPassword(PasswordUtil.encodePasswordMD5(UserInfo.getPassword()));
		userInfoDAO.update(dbUserInfo);
		result.setResult(userInfo);
		return result;
	}

//	private void resetUserInfoDepartmentInfo(UserInfo UserInfo, UserInfo dbUserInfo) {
//		UserInfoDataConfigDao.deleteByEmpCode(dbUserInfo.getEmpCode());
//		String departments = UserInfo.getDepartments();
//		if(!StringUtils.isEmpty(departments)){
//			String configs[] = departments.split(",");
//			for(String config : configs){
//				if(!StringUtils.isEmpty(config)){
//					String array [] = config.split("--");
//					UserInfoDataConfig UserInfoDataConfig = new UserInfoDataConfig();
//					UserInfoDataConfig.setConfigValue(array[0]);
//					UserInfoDataConfig.setConfigType(array[1]);
////					UserInfoDataConfig.setRowId(GenerateTableSeqUtil.generateTableSeq("UserInfo_DATA_CONFIG"));
//					UserInfoDataConfig.setActiveFlag("1");
//					UserInfoDataConfig.setEmployeeCode(dbUserInfo.getEmpCode());
//					saveUserInfoDataConfig(UserInfoDataConfig);
//				}
//			}
//		}
//	}

//	private void saveUserInfoDataConfig(UserInfoDataConfig UserInfoDataConfig) {
//		if(UserInfoDataConfig.getConfigType().equals(UserInfoDataConfig.getConfigValue())){return;}
//		if("COMPANY".equals(UserInfoDataConfig.getConfigType()) || "FACTORY".equals(UserInfoDataConfig.getConfigType())){
//			if(departmentService.hasChildByCode(UserInfoDataConfig.getConfigValue())<1){
//				UserInfoDataConfigDao.save(UserInfoDataConfig);
//			}
//		}else{
//			UserInfoDataConfigDao.save(UserInfoDataConfig);
//		}
//	}

	@Override
	public ExecuteResult<UserInfo> login(String userInfoCode, String password,
			String ipAddress) {
		ExecuteResult<UserInfo> executeResult = new ExecuteResult<UserInfo>();
		//UserInfo UserInfoInfo = UserInfoDAO.getUserInfoByName(UserInfoName);
		UserInfo UserInfo = userInfoDAO.getUserInfoByCode(userInfoCode);
		final String errorMsg = "用户名或密码错误，连续输错5次，账号会被禁用。";

		// 用户名和密码以及用户状态是否匹配
		if (UserInfo == null) {
			executeResult.addErrorMessage(errorMsg);
			return executeResult;
		}
		/*//是否锁定或者过期
		if (UserInfoStatusEnum.toEnum(UserInfoInfo.getStatus()) == UserInfoStatusEnum.INACTIVE) {
			executeResult.addErrorMessage(errorMsg);
			return executeResult;
		}*/
		//是否有效
//		if (UserInfoStatusEnum.toEnum(UserInfoInfo.getStatus()) != UserInfoStatusEnum.ACTIVE) {
//			executeResult.addErrorMessage("账户已锁定，请联系管理员！");
//			return executeResult;
//		}
		if (!UserInfo.getPassword().equals(PasswordUtil.encrypt(password))) {
			doPasswordNotMatch(UserInfo);
			executeResult.addErrorMessage(errorMsg);
			return executeResult;
		}
		executeResult.setResult(UserInfo);
		hasLogin(executeResult, ipAddress);
		return executeResult;
	}
	@Override
	public ExecuteResult<UserInfo> hasLogin(ExecuteResult<UserInfo> executeResult,String ipAddress){
//		UserInfo UserInfoInfo = executeResult.getResult();
//		// 不允许同一账号在多处同时登陆
//		Cache sessionCache = cacheManager
//				.getCache(CacheNames.CACHE_NAME_SESSION);
//		String key = MaxSessionUtil.generateMaxSessionKey(UserInfoInfo.getName());
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
//		UserInfoInfo.setLastLoginIp(UserInfoInfo.getCurrentLoginIp());
//		UserInfoInfo.setLastLoginTime(new Date());
//		UserInfoInfo.setLoginFaildTime(null);
//		UserInfoInfo.setLoginAttemptTimes(0);
//		UserInfoInfo.setCurrentLoginIp(ipAddress);
//		executeResult.setResult(UserInfoInfo);
//		this.UserInfoDAO.update(UserInfoInfo);
//		// 清理缓存
//		cacheManager.getCache(CacheNames.CACHE_NAME_UserInfo).evict(
//				CacheNames.UserInfo_KEY_PREFIX + UserInfoInfo.getId());
		return executeResult;
	}

	private void doPasswordNotMatch(UserInfo userInfo) {
//		final long accountLockTime = 60 * 60 * 1000L;// 登陆1小时内尝试5次
//		if (UserInfoInfo.getLoginFaildTime() == null) {
//			UserInfoInfo.setLoginFaildTime(new Date());
//		} else if (UserInfoInfo.getLoginFaildTime().getTime() + accountLockTime < System
//				.currentTimeMillis()) {
//			UserInfoInfo.setLoginFaildTime(new Date());
//			UserInfoInfo.setLoginAttemptTimes(0);
//		}
//		UserInfoInfo.setLoginAttemptTimes((UserInfoInfo.getLoginAttemptTimes() == null ? 0
//				: UserInfoInfo.getLoginAttemptTimes()) + 1);// 错误次数累加
//		final Integer loginTimes = 5;// 最多可以连续登陆5次密码错误
//		if (UserInfoInfo.getLoginAttemptTimes() >= loginTimes) {
//			UserInfoInfo.setStatus(UserInfoStatusEnum.INACTIVE.getStatus());// 自动锁定
//		}
	}

	@Override
	public ExecuteResult<UserInfo> logout(LoginContext context) {
		// 清理用户资源缓存
//		List<String> moduleNames = resourceDAO.getmoduleNames();
//		for (String moduleName : moduleNames) {
//			if (moduleName != null && !moduleName.isEmpty()) {
//				cacheManager.getCache(CacheNames.CACHE_NAME_RESOURCE).evict(
//						Env.getProperty(Env.KEY_SERVER_NAME) + ":resource:"
//								+ context.getUserInfoId() + ":" + moduleName);
//			}
//		}
		ExecuteResult<UserInfo> executeResult = new ExecuteResult<UserInfo>();
//		Cache sessionCache = cacheManager
//				.getCache(CacheNames.CACHE_NAME_SESSION);
//		String key = MaxSessionUtil
//				.generateMaxSessionKey(context.getUserInfoName());
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
	public void updatePassword(Long userInfoId, String password) {
		String newPassword = PasswordUtil.encrypt(password);
		UserInfo userInfo = getUserInfoById(userInfoId);
		if (userInfo == null) {
			return;
		}
		userInfo.setPassword(newPassword);
		userInfo.setGmtModified(new Date());
		userInfo.setLastModifiedBy(LoginContextHolder.get().getUserName());
		userInfo.setPasswordExpireTime(calculatePasswordExpireDate());
//		UserInfo.setPasswordModifiedFlag(1);
		this.userInfoDAO.update(userInfo);
	}

	@Override
	public ExecuteResult<Boolean> shouldTipPassword(UserInfo userInfo) {
		ExecuteResult<Boolean> executeResult = new ExecuteResult<Boolean>();
		Integer flag = 0;//UserInfo.getPasswordModifiedFlag();
		if (flag == null || flag == 0) {
			executeResult.addErrorMessage("首次登陆系统必须修改默认密码.");
			return executeResult;
		}
		// 密码是否即将过期，
		Date now = formatDate(new Date());
		Date expireDate = formatDate(userInfo.getPasswordExpireTime());
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
	public String getExpiredDate(UserInfo userInfo) {
//		if (UserInfo.getExpiredTime() != null) {
//			SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMdd");
//			String expiredTime = dateFormat.format(UserInfo.getExpiredTime());
//			String nowTime = dateFormat.format(new Date());
//			long expiredDate = Long.parseLong(expiredTime)
//					- Long.parseLong(nowTime);
//			if (expiredDate > 0 && expiredDate < 7) {
//				String[] admin = Env.getProperty(Env.SYS_ADMIN).split(",");
//				StringBuffer result = new StringBuffer();
//				if (admin.length > 0) {
//					for (String ad : admin) {
//						UserInfo adminInfo = this.getUserInfoByName(ad);
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
	public UserInfo getUserInfoByName(String name) {
		return userInfoDAO.getUserInfoByName(name);
	}

	@Override
	public List<UserInfo> getAll() {
		return userInfoDAO.getAll();
	}

	@Override
	public ExecuteResult<UserInfo> updateExpiredUserInfo(UserInfo userInfo) {
		ExecuteResult<UserInfo> result = new ExecuteResult<UserInfo>();
		UserInfo dbUserInfo = userInfoDAO.get(userInfo.getId());
		if (dbUserInfo == null) {
			result.addErrorMessage("该用户不存在或已经被删除。");
			return result;
		}
		// 重名检查
		if (!dbUserInfo.getName().equals(userInfo.getName())) {
			UserInfo namedUserInfo = userInfoDAO.getUserInfoByName(userInfo.getName());
			if (namedUserInfo != null) {
				result.addErrorMessage("用户名：" + userInfo.getName() + "已经存在。");
				return result;
			}
		}
		// 关联部门
//		resetUserInfoDepartmentInfo(UserInfo, dbUserInfo);
		// 修改
		dbUserInfo.setGmtModified(new Date());
		dbUserInfo.setEmail(userInfo.getEmail());
		dbUserInfo.setName(userInfo.getName());
		dbUserInfo.setLastModifiedBy("job");
		dbUserInfo.setStatus(userInfo.getStatus());
		dbUserInfo.setExpiredTime(userInfo.getExpiredTime());
		// dbUserInfo.setPassword(PasswordUtil.encodePasswordMD5(UserInfo.getPassword()));
		userInfoDAO.update(dbUserInfo);
		result.setResult(userInfo);
		return result;
	}

	@Override
	public Pager<UserInfo> getUserInfosByGroupId(UserInfoQuery  userInfoQuery) {
		List<UserInfo> UserInfos = userInfoDAO.getUserInfosByGroupId(userInfoQuery);
		long size = userInfoDAO.getUserInfosByGroupIdCount(userInfoQuery);
		return Pager.cloneFromPager(userInfoQuery.getPager(), size, UserInfos);
	}

	@Override
	public Long searchUserInfoCount(UserInfoQuery userInfoQuery) {
		
		return userInfoDAO.searchUserInfoCount(userInfoQuery);
	}

	@Override
	public UserInfo getUserInfoByCode(String userInfoCode) {
		// 
		return userInfoDAO.getUserInfoByCode(userInfoCode);
	}
	@Override
	public long getCountByEmpCode(String empCode) {
		// 
		return userInfoDAO.getCountByEmpCode(empCode);
	}

	@Override
	public List<UserInfo> queryUserInfoByName(String qName) {
		// 
		return userInfoDAO.queryUserInfoByName(qName);
	}

	@Override
	public List<Long> getUserInfoIdsByEmpCodes(List<String> UserInfoEmpCodeList) {
		// 
		return userInfoDAO.getUserInfoIdsByEmpCodes(UserInfoEmpCodeList);
	}

	@Override
	public List<UserInfo> getAllUserInfo() {
		return userInfoDAO.getAllUserInfo();
	}
	

	@Override
	public List<UserInfo> getUserInfoByEmpCodes(List<String> UserInfoEmpCodeList) {
		return userInfoDAO.getUserInfoByEmpCodes(UserInfoEmpCodeList);
	}

	@Override
	public Pager<Map<String,Object>> getUserInfosAndGroupByGroupId(UserInfoQuery  userInfoQuery) {
		//getUserInfosAndGroupByGroupId
//		List<Map<String,Object>> UserInfos = UserInfoDAO.getUserInfosAndGroupByGroupId(UserInfoSearchModel.getMap());
//		for(Map<String,Object> map:UserInfos){
//			map.put("name", map.get("UserInfo_NAME"));
//			map.put("empCode", map.get("EMP_CODE"));
//			map.put("groupName", map.get("GROUP_NAME"));
//			map.put("groupCode", map.get("GROUP_CODE"));
//			
//		}
//		long size = UserInfoDAO.getUserInfosAndGroupByGroupIdCount(UserInfoSearchModel.getMap());
//		return Pager.cloneFromPager(UserInfoSearchModel.getPager(), size, UserInfos);
		return null;
	}
	@Override
	public DataGrid datagrid(UserInfoQuery userInfoQuery) {
		DataGrid j = new DataGrid();
		Pager<UserInfo> pager  = userInfoDAO.findPage(userInfoQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<UserInfoQuery> getQuerysFromEntitys(List<UserInfo> userInfos) {
		List<UserInfoQuery> userInfoQuerys = new ArrayList<UserInfoQuery>();
		if (userInfos != null && userInfos.size() > 0) {
			for (UserInfo tb : userInfos) {
				UserInfoQuery b = new UserInfoQuery();
				BeanUtils.copyProperties(tb, b);
				userInfoQuerys.add(b);
			}
		}
		return userInfoQuerys;
	}

	


	@Override
	public void add(UserInfoQuery userInfoQuery) {
		UserInfo t = new UserInfo();
		BeanUtils.copyProperties(userInfoQuery, t);
		t.setCreateBy(LoginContextHolder.get().getEmpCode());
		t.setLastModifiedBy(LoginContextHolder.get().getEmpCode());
		t.setGmtCreate(new Date());
		t.setGmtModified(new Date());
		userInfoDAO.save(t);
	}

	@Override
	public void update(UserInfoQuery userInfoQuery) {
		UserInfo t = userInfoDAO.getById(userInfoQuery.getId());
	    if(t != null) {
	    	BeanUtils.copyProperties(userInfoQuery, t);
	    	t.setName(userInfoQuery.getName());
	    	t.setEmpCode(userInfoQuery.getEmpCode());
	    	t.setEmail(userInfoQuery.getEmail());
	    	t.setType(userInfoQuery.getType());
	    	t.setExpiredTime(userInfoQuery.getExpiredTime());
	    	t.setGmtModified(new Date());
		}
	    userInfoDAO.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				UserInfo t = userInfoDAO.getById(id);
				if (t != null) {
					userInfoDAO.delete(t);
				}
			}
		}
	}

	@Override
	public UserInfo get(UserInfoQuery userInfoQuery) {
		return userInfoDAO.getById(userInfoQuery.getId());
	}

	@Override
	public UserInfo get(String id) {
		return userInfoDAO.getById(Long.parseLong(id));
	}

	
	@Override
	public List<UserInfoQuery> listAll(UserInfoQuery userInfoQuery) {
	    List<UserInfo> list = userInfoDAO.findList(userInfoQuery);
		List<UserInfoQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}

	
}
