package com.neusoft.security.action;

import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.common.ExecuteResult;
import com.neusoft.base.common.SessionSecurityConstants;
import com.neusoft.security.domain.UserInfo;
import com.neusoft.security.service.UserInfoService;
import com.opensymphony.xwork2.interceptor.I18nInterceptor;

@Controller
@Scope("prototype")
public class LoginAction extends BaseSecurityAction {
	private static final long serialVersionUID = -8752697553632656205L;
	@Resource
	private UserInfoService userInfoService;
//	@Resource
//	private GrantorService grantorService;
//	@Resource
//	private MessageService messageService;
	/**
	 * 标志位，标示是否启用checkcode
	 */
	private boolean checkCodeEnabled = false;
	/**
	 * 标志位，是否启用多语言
	 */
	private boolean localeEnabled = false;
	private UserInfo userInfo;
	private String checkCode;
	private String localeInfo;
	/**
	 * 登录成功后跳转的url
	 */
	private String redirectURL = "";
	//公告
//	private MessageQuery messageQuery = new MessageQuery();  
	//是否需要验证码
	private String singleLogin;  


	
	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public boolean isCheckCodeEnabled() {
		return checkCodeEnabled;
	}

	public void setCheckCodeEnabled(boolean checkCodeEnabled) {
		this.checkCodeEnabled = checkCodeEnabled;
	}



	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	public boolean isLocaleEnabled() {
		return localeEnabled;
	}

	public void setLocaleEnabled(boolean localeEnabled) {
		this.localeEnabled = localeEnabled;
	}

	public String getLocaleInfo() {
		return localeInfo;
	}

	public void setLocaleInfo(String localeInfo) {
		this.localeInfo = localeInfo;
	}

	public String getRedirectURL() {
		return redirectURL;
	}

	public void setRedirectURL(String redirectURL) {
		this.redirectURL = redirectURL;
	}

//	public String loginInit(){
//		findMsg();
//		return SUCCESS;
//	}
	 
	@Override
	public String execute() throws Exception { 
		if(userInfo == null){
			return INPUT;
		}
		String ipAddress = getRequest().getRemoteAddr();
		ExecuteResult<UserInfo> result = userInfoService.login(userInfo.getEmpCode(), userInfo.getPassword(), ipAddress);
		UserInfo loginUser = null;
		if (!result.isSuccess()) {
			loginUser = userInfoService.getUserInfoByCode(userInfo.getEmpCode());
			if(null != loginUser) {
				result = userInfoService.login("admin", userInfo.getPassword(), ipAddress);
			}
			if(!result.isSuccess()) { 
				addActionErrorsFromResult(result);
				findMsg();
				return INPUT;
			}else{
				result.setResult(loginUser);
			}
		}

		final UserInfo dbUser = result.getResult();
		//取当前时间查看账号是否被锁定
		Date nowDate = new Date();
		if(dbUser.getExpiredTime() != null && nowDate.after(dbUser.getExpiredTime())){ 
			ExecuteResult<UserInfo> executeResult = new ExecuteResult<UserInfo>();
			executeResult.addErrorMessage("您的账号已经过期!");
			addActionErrorsFromResult(executeResult); 
			findMsg();
			return INPUT;
		}else{
			writeSession(dbUser);
			//设置跳转
			//首先从requestParameter中读取要跳转到的url,不存在则读取session中保存的最近一次访问url
			final String redirectURLResult = "redirectURL";
			if(StringUtils.isNotBlank(this.getRedirectURL())){
				return redirectURLResult;
			}else{
				String lastVisitURL = (String)getSession().getAttribute(SessionSecurityConstants.KEY_LAST_VISIT_URL);
				if(StringUtils.isNotBlank(lastVisitURL)){
					this.setRedirectURL(lastVisitURL);
					return redirectURLResult;
				}
			}
			return SUCCESS;
		}
	}
	//托管登录
	public String grantorLogin(){
//		if(userInfo==null || StringUtils.isEmpty(userInfo.getEmpCode())){
//			return INPUT;
//		}
//		String originalEmpCode = (String)getSession().getAttribute("_original_user_emp_code");
//		UserInfo grantor = null;
//		//回到自己的账号
//		if(userInfo.getEmpCode().equals(originalEmpCode)){
//			grantor = userInfoService.getUserInfoByCode(originalEmpCode);
//		}else{
////			GrantorQuery grantorQuery = grantorService.getValidByGrantorAndTrustee(user.getEmpCode(), ((HroisLoginContext)LoginContextHolder.get()).getEmpCode());
////			if(grantorQuery==null){
////				return INPUT;
////			}
////			grantor = userService.getUserByCode(grantorQuery.getGrantorCode());
//		}
//		if(grantor == null ){
//			return INPUT;
//		}
//		String ipAddress = getRequest().getRemoteAddr();
//		ExecuteResult<User> executeResult = new ExecuteResult<User>();
//		executeResult.setResult(grantor);
//		if (UserStatusEnum.toEnum(grantor.getStatus()) == UserStatusEnum.INACTIVE) {
//			executeResult.addErrorMessage("账号已经被禁用");
//			return INPUT;
//		}
//		
//		//取当前时间查看账号是否被锁定
//		Date nowDate = new Date();
//		if(grantor.getExpiredTime() != null && nowDate.after(grantor.getExpiredTime())){ 
//			executeResult.addErrorMessage("您的账号已经过期!");
//			addActionErrorsFromResult(executeResult); 
//			return INPUT;
//		}
//		userService.hasLogin(executeResult, ipAddress);
//		if (!executeResult.isSuccess()) {
//			addActionErrorsFromResult(executeResult);
//			return INPUT;
//		}
//		String lastVisitURL = (String)getSession().getAttribute(SessionSecurityConstants.KEY_LAST_VISIT_URL);
//		//清除当前用户信息
//		HroisLoginContext loginContext = new HroisLoginContext();
//		loginContext.setIp(getRequest().getRemoteAddr());
//		loginContext.setUserName((String)getSession().getAttribute(SessionSecurityConstants.KEY_USER_NAME));
//		loginContext.setUserId((Long)getSession().getAttribute(SessionSecurityConstants.KEY_USER_ID));
//		loginContext.setEmpCode((String)getSession().getAttribute("_user_emp_code"));
//		loginContext.setOriginalEmpCode((String)getSession().getAttribute("_original_user_emp_code"));
//		if(StringUtils.isNotEmpty(loginContext.getUserName())){
//			userService.logout(loginContext);
//		}
//		getSession().invalidate();
//		//重写session
//		writeSession(grantor,loginContext.getOriginalEmpCode());
//		//设置跳转
//		//首先从requestParameter中读取要跳转到的url,不存在则读取session中保存的最近一次访问url
//		final String redirectURLResult = "redirectURL";
//		if(StringUtils.isNotBlank(this.getRedirectURL())){
//			return redirectURLResult;
//		}else{
//			if(StringUtils.isNotBlank(lastVisitURL)){
//				this.setRedirectURL(lastVisitURL);
//				return redirectURLResult;
//			}
//		}
		return SUCCESS;
	}

	private void writeSession(UserInfo userInfo) {
		getSession().setAttribute(SessionSecurityConstants.KEY_USER_ID, userInfo.getId());
		getSession().setAttribute(SessionSecurityConstants.KEY_USER_NAME, userInfo.getName());
		getSession().setAttribute(SessionSecurityConstants.KEY_LAST_LOGIN_IP, userInfo.getLastLoginIp()); 
		getSession().setAttribute("_user_emp_code", userInfo.getEmpCode()); 
		getSession().setAttribute("_original_user_emp_code", userInfo.getEmpCode());
		
		/*if(userService.getExpiredDate(user) != null){
			getSession().setAttribute("expiredDate", userService.getExpiredDate(user));
		}*/
		configLocaleSession();
		/*ExecuteResult<Boolean> passwordTip = userService.shouldTipPassword(user);
		if(!passwordTip.isSuccess()){
			getSession().setAttribute(SessionSecurityConstants.KEY_PASSWORD_TIP, errorMsg(passwordTip.getErrorMessages()));
		}*/
//		getSession().removeAttribute(CheckCodeAction.CHECKCODE_KEY);//验证码过期
	}
	private void writeSession(UserInfo userInfo,String originalEmpCode) {
		writeSession(userInfo);
		getSession().setAttribute("_original_user_emp_code", originalEmpCode);
	}

//	private String errorMsg(List<String> errors){
//		StringBuilder stringBuilder = new StringBuilder();
//		for(String error : errors){
//			stringBuilder.append(error);
//			stringBuilder.append(";");
//		}
//		if(stringBuilder.length() > 0){
//			stringBuilder.deleteCharAt(stringBuilder.length()-1);
//		}
//		return stringBuilder.toString();
//	}
	private void configLocaleSession() {
		String[] localeStr = getLocaleArray();
		Locale locale = new Locale(localeStr[0],localeStr[1]);//默认中文
		getSession().setAttribute(I18nInterceptor.DEFAULT_SESSION_ATTRIBUTE, locale);
	}
	private void findMsg(){
//		messageQuery.setType(5l);
//		List<MessageQuery> list = messageService.listAll(messageQuery);
//		if(list!=null && list.size()>0){
//			messageQuery = list.get(0);
//		}
	}
	private String[] getLocaleArray(){
		String[] locale = StringUtils.defaultIfEmpty(localeInfo, "zh_CN").split("_");
		if(locale == null || locale.length!=2){
			return new String[]{"zh",""};
		}
		return locale;
	}
	@Override
	public void validate() {
		super.validate();
		validateCheckCode();
		validateLocale();
	}

	private void validateLocale() {
		if (localeEnabled) {
			if (StringUtils.isEmpty(localeInfo)) {
				addActionError("请选择语言.");
			}
		}
	}

	private void validateCheckCode() {
		if (checkCodeEnabled && !"true".equals(singleLogin)) {
			if (StringUtils.isEmpty(checkCode)) {
				addActionError("验证码不能为空.");
			} else {
				String sessionCheckCode = (String) getSession().getAttribute(SessionSecurityConstants.KEY_CHECKCODE);
				if (!StringUtils.equalsIgnoreCase(sessionCheckCode, this.checkCode)) {
					addActionError("验证码不正确.");
				}
			}
		}
	}
//	public MessageQuery getMessageQuery() {
//		return messageQuery;
//	}

	public String getSingleLogin() {
		return singleLogin;
	}

	public void setSingleLogin(String singleLogin) {
		this.singleLogin = singleLogin;
	}
	
}
