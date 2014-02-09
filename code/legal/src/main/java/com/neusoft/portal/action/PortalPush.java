package com.neusoft.portal.action;

import javax.servlet.ServletException;

import org.directwebremoting.Container;
import org.directwebremoting.ServerContextFactory;
import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.directwebremoting.event.ScriptSessionListener;
import org.directwebremoting.extend.ScriptSessionManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.neusoft.portal.dwr.BaseScriptSessionListener;


@RemoteProxy(name="portalPush")
public class PortalPush {
	private Logger logger = LoggerFactory.getLogger(getClass());

	
	@RemoteMethod
	public void onPageLoad() {  
	       try {  
	              init();  
	           }
	       catch (ServletException e) {  
	              logger.error("got exception--",e);  
	       }  
	  
	}
	private void init() throws ServletException {
		Container container = ServerContextFactory.get().getContainer();
		ScriptSessionManager manager = container.getBean(ScriptSessionManager.class);
		ScriptSessionListener listener = new BaseScriptSessionListener() ;
		manager.addScriptSessionListener(listener);
	}

}
