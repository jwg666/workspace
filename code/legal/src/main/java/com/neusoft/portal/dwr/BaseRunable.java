package com.neusoft.portal.dwr;

import java.util.List;

import org.directwebremoting.Browser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;

public abstract class BaseRunable  implements Runnable {
	private Logger logger = LoggerFactory.getLogger(getClass());
	public BaseRunable(){
		SpringApplicationContextHolder.getApplicationContext().getAutowireCapableBeanFactory().autowireBean(this);
	}
	
	private List<Long> userIdList;
	private Long userId;
	public  Runnable getHroisRunable(){
		return this;
	}
	/**
	 * 执行
	 */
	public  void execute(){
			try {
				if(ValidateUtil.isValid(userIdList)){
					Browser.withAllSessionsFiltered(new BaseScriptSessionFilter(userIdList), getHroisRunable());
				}
				if(ValidateUtil.isValid(userId)){
					Browser.withAllSessionsFiltered(new BaseScriptSessionFilter(userId), getHroisRunable());
				}
			} catch (Exception e) {
				//logger.error("got exception--",e);
			}
	}
	
	public List<Long> getUserIdList() {
		return userIdList;
	}

	public void setUserIdList(List<Long> userIdList) {
		this.userIdList = userIdList;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	
	
	

}
