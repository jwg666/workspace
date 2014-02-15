package com.neusoft.security.action;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.common.LoginContext;
import com.neusoft.base.common.SessionSecurityConstants;
import com.neusoft.portal.dwr.BaseScriptSessionListener;
import com.neusoft.security.service.UserInfoService;

@Controller
@Scope("prototype")
public class LogoutAction extends BaseSecurityAction {
	private static final long serialVersionUID = 7521641081600825642L;
	@Resource
	private UserInfoService userInfoService;
	@Override
	public String execute() throws Exception {
		Long userId=(Long)getSession().getAttribute(SessionSecurityConstants.KEY_USER_ID);
		BaseScriptSessionListener.onLineUserIdList.remove(userId);
//		UserInfo userInfo=userInfoService.getUserInfoById(userId);
//		List<UserGroup> groupList= groupService.getGroupByUserId(userId);
//		if(groupList!=null){
//			for(UserGroup userGroup:groupList){
//				Group group=userGroup.getGroup();
//				if(group!=null){
//					List<Map<String,Object>> userList= HroisScriptSessionListener.onLineUserMapList.get(group.getCode());
//					List<Map<String,Object>> copyUserList=new Vector<Map<String,Object>>(userList);
//					for(int i=0;i<copyUserList.size();i++){
//						Map<String,Object> map=copyUserList.get(i);
//						if(user.getId().equals(map.get("id"))){
//							System.out.println(userList.remove(map));
//						}
//					}
//					/*增加离线用户*/
//					//userList= subLineUserList.get(group.getCode());
//				}
//			}
//		}
		
		LoginContext loginContext = new LoginContext();
		loginContext.setIp(getRequest().getRemoteAddr());
		loginContext.setUserName((String)getSession().getAttribute(SessionSecurityConstants.KEY_USER_NAME));
		loginContext.setUserId((Long)getSession().getAttribute(SessionSecurityConstants.KEY_USER_ID));
		loginContext.setEmpCode((String)getSession().getAttribute("_user_emp_code"));
//		loginContext.setOriginalEmpCode((String)getSession().getAttribute("_original_user_emp_code"));
		if(StringUtils.isNotEmpty(loginContext.getUserName())){
			userInfoService.logout(loginContext);
		}
		getSession().invalidate();
		return SUCCESS;
	}
}
