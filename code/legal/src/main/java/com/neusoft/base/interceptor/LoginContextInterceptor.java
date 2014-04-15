package com.neusoft.base.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.neusoft.base.common.LoginContext;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.SessionSecurityConstants;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LoginContextInterceptor extends AbstractInterceptor{
	private Logger logger = LoggerFactory.getLogger(getClass());
	private static final long serialVersionUID = -2622192412895411710L;
	/**
	 * 用户session中的用户表示
	 */
	private String keyUserName = SessionSecurityConstants.KEY_USER_NAME;
	private String keyUserId = SessionSecurityConstants.KEY_USER_ID;
	
	public void setKeyUserName(String keyUserName) {
		this.keyUserName = keyUserName;
	}

	public void setKeyUserId(String keyUserId) {
		this.keyUserId = keyUserId;
	}

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		
		logger.debug("==============================");
		HttpServletRequest httpServletRequest = ServletActionContext.getRequest();
		HttpSession httpSession = httpServletRequest.getSession();
		Long userId = (Long)httpSession.getAttribute(keyUserId);
		String userName = (String)httpSession.getAttribute(keyUserName);
		if(userName == null){
			//仅仅记住get请求的链接
			if(StringUtils.equalsIgnoreCase(httpServletRequest.getMethod(),"GET")){
				HttpSession session = httpServletRequest.getSession();
				String servletPath = httpServletRequest.getServletPath();
				String fullURL = new StringBuffer(servletPath).append(toParameterString(httpServletRequest)).toString();
				session.setAttribute(SessionSecurityConstants.KEY_LAST_VISIT_URL, fullURL);
			}
			return Action.LOGIN;
		}
		// 将当前登陆者信息保存到线程上线问中
		LoginContext loginContext = new LoginContext();
		loginContext.setUserId(userId);
		loginContext.setUserName(userName);
		loginContext.setIp(ServletActionContext.getRequest().getRemoteAddr());
		LoginContextHolder.put(loginContext);
		String result = invocation.invoke();
		LoginContextHolder.clear();
		return result;
	}
	
	private String toParameterString(HttpServletRequest httpServletRequest){
		Enumeration<String> paramEnumeration = httpServletRequest.getParameterNames();
		if(!paramEnumeration.hasMoreElements()){
			return "";
		}
		StringBuffer stringBuffer = new StringBuffer();
		while(paramEnumeration.hasMoreElements()){
			String paramName = paramEnumeration.nextElement();
			stringBuffer.append("&");
			stringBuffer.append(paramName);
			stringBuffer.append("=");
			stringBuffer.append(httpServletRequest.getParameter(paramName));
		}
		stringBuffer.replace(0, 1, "?");
		return stringBuffer.toString();
	}
}
