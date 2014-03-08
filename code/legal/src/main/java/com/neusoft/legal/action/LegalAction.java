package com.neusoft.legal.action;

import javax.annotation.Resource;

import org.activiti.engine.TaskService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.service.DictionaryService;
import com.neusoft.legal.query.LegalAgentQuery;
import com.neusoft.legal.query.LegalApplicantQuery;
import com.neusoft.legal.query.LegalCaseQuery;
import com.neusoft.legal.service.LegalAgentService;
import com.neusoft.legal.service.LegalApplicantService;
import com.neusoft.legal.service.LegalCaseService;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class LegalAction extends BaseAction{
	private static final long serialVersionUID = 8032958721886686532L;
	@javax.annotation.Resource
	private	DictionaryService dictionaryService;
	@Resource
	private LegalApplicantService legalApplicantService;
	@Resource
	private LegalAgentService legalAgentService;
	@Resource
	private LegalCaseService legalCaseService;
	private LegalCaseQuery legalCaseQuery;
	private LegalApplicantQuery legalApplicantQuery;
	private LegalAgentQuery legalAgentQuery;
	@Resource
	private TaskService taskService;
	
	public String stepOne(){
		
		return "legal";
	}
	public String asignLegalOfficeTaskList(){
		
		return "asignLegalOfficeTaskList";
	}
	public String goAsignLegalOffice(){
		legalCaseQuery = legalCaseService.getQuery(legalCaseQuery.getId());
		legalApplicantQuery = legalApplicantService.getQuery(legalCaseQuery.getApplicantId());
		legalAgentQuery = legalAgentService.getQuery(legalCaseQuery.getAgentId());
		return "goAsignLegalOffice";
	}
	public String asignLegalOffice(){
		legalCaseQuery.setDefinitionKey("asignLegalOffice");
		legalCaseService.completTask(legalCaseQuery);	
		return "json";
	}
	public String accessCaseTaskList(){
		return "accessCaseTaskList";
	}
	public String goAccessCase(){
		legalCaseQuery = legalCaseService.getQuery(legalCaseQuery.getId());
		legalApplicantQuery = legalApplicantService.getQuery(legalCaseQuery.getApplicantId());
		legalAgentQuery = legalAgentService.getQuery(legalCaseQuery.getAgentId());
		return "goAccessCase";
	}
	public String accessCase(){
		legalCaseQuery.setDefinitionKey("accessCase");
		legalCaseService.completTask(legalCaseQuery);	
		return "json";
	}
	public String endCaseTaskList(){
		return "endCaseTaskList";
	}
	public String goEndCase(){
		legalCaseQuery = legalCaseService.getQuery(legalCaseQuery.getId());
		legalApplicantQuery = legalApplicantService.getQuery(legalCaseQuery.getApplicantId());
		legalAgentQuery = legalAgentService.getQuery(legalCaseQuery.getAgentId());
		return "goEndCase";
	}
	public String endCase(){
		legalCaseQuery.setDefinitionKey("endCase");
		legalCaseService.completTask(legalCaseQuery);	
		return "json";
	}
	public LegalCaseQuery getLegalCaseQuery() {
		return legalCaseQuery;
	}
	public void setLegalCaseQuery(LegalCaseQuery legalCaseQuery) {
		this.legalCaseQuery = legalCaseQuery;
	}
	public LegalApplicantQuery getLegalApplicantQuery() {
		return legalApplicantQuery;
	}
	public void setLegalApplicantQuery(LegalApplicantQuery legalApplicantQuery) {
		this.legalApplicantQuery = legalApplicantQuery;
	}
	public LegalAgentQuery getLegalAgentQuery() {
		return legalAgentQuery;
	}
	public void setLegalAgentQuery(LegalAgentQuery legalAgentQuery) {
		this.legalAgentQuery = legalAgentQuery;
	}
	
}
