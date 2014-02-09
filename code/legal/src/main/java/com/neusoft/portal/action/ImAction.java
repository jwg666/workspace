package com.neusoft.portal.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;
import com.neusoft.base.common.LoginContext;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.portal.dwr.BaseChartRunable;
import com.neusoft.portal.dwr.BaseScriptSessionListener;
import com.neusoft.security.service.UserService;

@Controller
@Scope("prototype")
public class ImAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1741338874362015501L;
	
	private String toUserId;
	private String toUserName;
	private String message;
	
	@Resource
	private UserService userService;
	
	public String refreshOnlinUser(){
		return "onlineUser";
	}
	public String toChart(){
		
		
		return "toChart";
	}
	public String goIm(){
		return "goIm";
	}
	
	public String sendMessage(){
		Map<String,Object> messageMap=new HashMap<String, Object>();
		
		LoginContext loginContext=(LoginContext)LoginContextHolder.get();
		messageMap.put("sendUsercode",loginContext.getEmpCode() );
		messageMap.put("sendUserName", LoginContextHolder.get().getUserName());
		messageMap.put("content", message);
		messageMap.put("sendUserId",loginContext.getUserId());
		//User toUser= userService.getUserByCode(toUserId);
		new BaseChartRunable(Long.parseLong(toUserId), messageMap).execute();
		return null;
	}
	
	
	
	
	
	public Map<String, List<Map<String, Object>>> getOnlineUser(){
		return BaseScriptSessionListener.onLineUserMapList;
	}
	public List<Map<String, Object>> getOnLineUserList() {
		return BaseScriptSessionListener.onLineUserList;
	}
	public String getToUserId() {
		return toUserId;
	}
	public void setToUserId(String toUserId) {
		this.toUserId = toUserId;
	}
	public String getToUserName() {
		return toUserName;
	}
	public void setToUserName(String toUserName) {
		this.toUserName = toUserName;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	

}
