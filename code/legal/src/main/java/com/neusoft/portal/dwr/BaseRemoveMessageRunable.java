package com.neusoft.portal.dwr;

import java.util.Collection;
import java.util.List;

import org.directwebremoting.Browser;
import org.directwebremoting.ScriptBuffer;
import org.directwebremoting.ScriptSession;
/**
 * 针对站内信,待办任务 催办的即时通知
 * @author 秦焰培
 *
 */
public class BaseRemoveMessageRunable extends BaseRunable {
	
	private List<String> taskIds;

	public BaseRemoveMessageRunable(List<Long> userIdList,List<String> taskIds){
		this.taskIds=taskIds;
		super.setUserIdList(userIdList);
	}
	
	@Override
	public void run() {
		// 
		 ScriptBuffer script = new ScriptBuffer();
			script.appendCall("removeNotice", taskIds);  
	        Collection<ScriptSession> sessions = Browser.getTargetSessions();  
	        for (ScriptSession scriptSession : sessions){  
	            scriptSession.addScript(script); 
	        }  
	}
}
