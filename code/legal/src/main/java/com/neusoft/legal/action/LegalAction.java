package com.neusoft.legal.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class LegalAction extends BaseAction{
	private static final long serialVersionUID = 8032958721886686532L;
	public String stepOne(){
		
		return "legal";
	}
}
