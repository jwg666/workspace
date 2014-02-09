package com.neusoft.portal.dwr;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.directwebremoting.Browser;
import org.directwebremoting.ScriptBuffer;
import org.directwebremoting.ScriptSession;
/**
 * 针对站内信,待办任务 催办的即时通知
 * @author 秦焰培
 *
 */
public class BaseMessageRunable extends BaseRunable {
	
	private Map<String,Object> message;

	public BaseMessageRunable(List<Long> userIdList,Map<String,Object> message){
		this.message=message;
		super.setUserIdList(userIdList);
	}
	
	@Override
	public void run() {
		// 
		 ScriptBuffer script = new ScriptBuffer();
			script.appendCall("addNotice", message);  
	        Collection<ScriptSession> sessions = Browser.getTargetSessions();  
	        for (ScriptSession scriptSession : sessions){  
	            scriptSession.addScript(script); 
	        }  
	}

}
