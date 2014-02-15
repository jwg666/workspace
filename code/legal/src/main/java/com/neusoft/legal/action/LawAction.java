package com.neusoft.legal.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;

@Controller
@Scope("prototype")
public class LawAction extends BaseAction{

	private static final long serialVersionUID = 7046146514631754757L;

	public String index(){
		logger.debug("oooooooooooooooooooooooooooooooooooooooooooo");
		return null;
	}
}
