package com.neusoft.portal.dwr;

import java.util.ArrayList;
import java.util.List;

import org.directwebremoting.ScriptSession;
import org.directwebremoting.ScriptSessionFilter;

import com.neusoft.base.common.SessionSecurityConstants;

public class BaseScriptSessionFilter implements ScriptSessionFilter {
	private String keyUserId = SessionSecurityConstants.KEY_USER_ID;
	/**
	 * 要匹配的userId列表
	 */
	private List<Long> userIdList;
	
	public BaseScriptSessionFilter(List<Long> userIdList){
		this.userIdList=userIdList;
	}
	public BaseScriptSessionFilter(Long userId){
		this.userIdList=new ArrayList<Long>();
		this.userIdList.add(userId);
	}
	
	@Override
	public boolean match(ScriptSession session) {
		// 
		if (session.getAttribute(keyUserId) == null) {
			return false;  
		}else{
        	Object sessionKeyUserId=session.getAttribute(keyUserId);
        	if(sessionKeyUserId==null) {return false;}
             for(Long userId:userIdList){
            		 if(sessionKeyUserId.equals(userId)){
            			 return  true;
            		 }
            	 }
             }
        	return false;
        }
}
