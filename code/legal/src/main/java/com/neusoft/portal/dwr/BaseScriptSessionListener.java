package com.neusoft.portal.dwr;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.directwebremoting.ScriptSession;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.event.ScriptSessionEvent;
import org.directwebremoting.event.ScriptSessionListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.neusoft.base.common.SessionSecurityConstants;
import com.neusoft.base.common.SpringApplicationContextHolder;
import com.neusoft.base.common.ValidateUtil;
import com.neusoft.security.domain.User;
import com.neusoft.security.domain.UserInfo;
import com.neusoft.security.service.UserInfoService;

public class BaseScriptSessionListener implements ScriptSessionListener {

	private String keyUserId = SessionSecurityConstants.KEY_USER_ID;
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Resource
	private UserInfoService userInfoService;
//	@Resource
//	private GroupService groupService;

	public BaseScriptSessionListener() {
		SpringApplicationContextHolder.getApplicationContext()
				.getAutowireCapableBeanFactory().autowireBean(this);
	}

	/* 当前在线用户 */
	public static List<Map<String, Object>> onLineUserList = new Vector<Map<String, Object>>();
	public static Map<String, List<Map<String, Object>>> onLineUserMapList = new Hashtable<String, List<Map<String, Object>>>();
	public static List<Long> onLineUserIdList = new Vector<Long>();
	static{
		onLineUserIdList.add(1L);
	}

	@Override
	public void sessionCreated(ScriptSessionEvent scriptSessionEvent) {
		try {
			WebContext webContext = WebContextFactory.get();
			HttpSession session = webContext.getSession(true);
			ScriptSession scriptSession = scriptSessionEvent.getSession();
			Long userId = (Long) session.getAttribute(keyUserId);
//			List<UserGroup> groupList = groupService
//					.getGroupByUserId(userId);
//			if(groupList==null){
//				return;
//			}
//			Boolean isAdmin=false;
//			for (UserGroup userGroup : groupList) {
//				Group group=userGroup.getGroup();
//				if(group!=null&&"SYS_MANAGER".equals(group.getCode())){
//					isAdmin=true;
//				}
//				
//			}
			if (userId != null && !onLineUserIdList.contains(userId)) {
				onLineUserIdList.add(userId);
				UserInfo user = userInfoService.getUserInfoById(userId);
			
//				for (UserGroup userGroup : groupList) {
//					Group group = userGroup.getGroup();
//					if (group != null) {
//						List<Map<String, Object>> userList = onLineUserMapList
//								.get(group.getCode());
//						Map<String, Object> map = new Hashtable<String, Object>();
//						map.put("name", user.getName());
//						map.put("code", user.getEmpCode());
//						map.put("email", user.getEmail());
//						map.put("id", user.getId());
//						map.put("groupCode", group.getCode());
//						/* 在线用户增加 */
//						userList.add(map);
//					}
//				}
			}
			logger.debug(userId + "a ScriptSession is created!");
			scriptSession.setAttribute(keyUserId, userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void sessionDestroyed(ScriptSessionEvent scriptSessionEvent) {
		try {
			WebContext webContext = WebContextFactory.get();
			if (webContext != null) {

				HttpSession session = webContext.getSession(true);
				Long userId = (Long) session.getAttribute(keyUserId);
				if (ValidateUtil.isValid(userId)) {
					onLineUserIdList.remove(userId);
					UserInfo user = userInfoService.getUserInfoById(userId);
//					List<UserGroup> groupList = groupService
//							.getGroupByUserId(userId);
//					for (UserGroup userGroup : groupList) {
//						Group group = userGroup.getGroup();
//						if (group != null) {
//							List<Map<String, Object>> userList = onLineUserMapList
//									.get(group.getCode());
//							List<Map<String, Object>> copyUserList = new Vector<Map<String, Object>>(
//									userList);
//							for (int i = 0; i < copyUserList.size(); i++) {
//								Map<String, Object> map = copyUserList.get(i);
//								if (user.getId().equals(map.get("id"))) {
//									userList.remove(map);
//									System.out.println(group.getName()
//											+ "移除用户：" + map + "数量为"
//											+ userList.size());
//								}
//							}
//						}
//					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.debug("a ScriptSession is distroyed");
	}

}
