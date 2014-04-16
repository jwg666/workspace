package com.neusoft.legal.action;

import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.TaskService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;
import com.neusoft.legal.query.LegalAgentQuery;
import com.neusoft.legal.query.LegalApplicantQuery;
import com.neusoft.legal.query.LegalApproveQuery;
import com.neusoft.legal.query.LegalCaseQuery;
import com.neusoft.legal.service.LegalAgentService;
import com.neusoft.legal.service.LegalApplicantService;
import com.neusoft.legal.service.LegalApproveService;
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
	@Resource
	private LegalApplicantService legalApplicantService;
	@Resource
	private LegalAgentService legalAgentService;
	@Resource
	private LegalCaseService legalCaseService;
	@Resource
	private LegalApproveService legalApproveService;
	private LegalCaseQuery legalCaseQuery;
	private LegalApplicantQuery legalApplicantQuery;
	private LegalAgentQuery legalAgentQuery;
	private List<LegalApproveQuery> legalApproveList;
	//备注信息id
	private Long caseId;
	//申请人信息id
	private Long applicantId;
	//代理人信息id
	private Long agentId;
	@Resource
	private TaskService taskService;
	
	public String stepOne(){
		return "legal";
	}
	public String stepTwo(){
		return "legalTwo";
	}
	public String asignLegalOfficeTaskList(){
		
		return "asignLegalOfficeTaskList";
	}
	
	public String goShenqingStart(){
		return "shenqingstart";
	}
	
	public String goAsignLegalOffice(){
		legalCaseQuery = legalCaseService.getQuery(legalCaseQuery.getId());
		legalApplicantQuery = legalApplicantService.getQuery(legalCaseQuery.getApplicantId());
		legalAgentQuery = legalAgentService.getQuery(legalCaseQuery.getAgentId());
		legalApproveList = legalApproveService.getQueryList(legalCaseQuery.getId());
		return "goAsignLegalOffice";
	}
	public String showdetail(){
		legalCaseQuery = legalCaseService.getQuery(legalCaseQuery.getId());
		legalApplicantQuery = legalApplicantService.getQuery(legalCaseQuery.getApplicantId());
		legalAgentQuery = legalAgentService.getQuery(legalCaseQuery.getAgentId());
		legalApproveList = legalApproveService.getQueryList(legalCaseQuery.getId());
		return "showdetail";
	}
	public String asignLegalOffice(){
		legalCaseQuery.setDefinitionKey("asignLegalOffice");
		legalCaseService.completTask(legalCaseQuery);	
		json.setMsg("处理成功");
		json.setSuccess(true);
		return "json";
	}
	
	/**
	 * @time 2014-4-16 下午10:54:07
	 * @return
	 * @author 门光耀
	 * @description 分配事务所并将律师事务所的id放到case表中
	 */
	public String completeTaskAndPutlegalIdToCase(){
		try{
			legalCaseService.completeTaskAndPutlegalIdToCase(legalCaseQuery);
			json.setSuccess(true);
			json.setMsg("分配成功");
		}catch(Exception e){
			json.setSuccess(false);
			json.setMsg("分配律师事务所失败，请联系管理员");
		}
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
	public List<LegalApproveQuery> getLegalApproveList() {
		return legalApproveList;
	}
	public void setLegalApproveList(List<LegalApproveQuery> legalApproveList) {
		this.legalApproveList = legalApproveList;
	}
	public Long getCaseId() {
		return caseId;
	}
	public void setCaseId(Long caseId) {
		this.caseId = caseId;
	}
	public Long getApplicantId() {
		return applicantId;
	}
	public void setApplicantId(Long applicantId) {
		this.applicantId = applicantId;
	}
	public Long getAgentId() {
		return agentId;
	}
	public void setAgentId(Long agentId) {
		this.agentId = agentId;
	}
	
}
