package com.neusoft.legal.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;
import com.neusoft.base.query.DictionaryQuery;
import com.neusoft.base.service.DictionaryService;
import com.neusoft.legal.domain.LegalAgent;
import com.neusoft.legal.domain.LegalApplicant;
import com.neusoft.legal.domain.LegalCase;
import com.neusoft.legal.query.LegalAgentQuery;
import com.neusoft.legal.query.LegalApplicantQuery;
import com.neusoft.legal.query.LegalCaseQuery;
import com.neusoft.legal.service.LegalAgentService;
import com.neusoft.legal.service.LegalApplicantService;
import com.neusoft.legal.service.LegalCaseService;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class LegalAction extends BaseAction implements ModelDriven<LegalApplicantQuery>{
	private static final long serialVersionUID = 8032958721886686532L;
	@javax.annotation.Resource
	private	DictionaryService dictionaryService;
	@Resource
	private LegalApplicantService legalApplicantService;
	@Resource
	private LegalAgentService legalAgentService;
	@Resource
	private LegalCaseService legalCaseService;
	
	private LegalApplicant legalApplicant;
	private LegalAgent legalAgent;
	private LegalCase legalCase;
	
	private LegalAgentQuery legalAgentQuery;
	private LegalApplicantQuery legalApplicantQuery;
	private LegalCaseQuery legalCaseQuery;
	
	private List<DictionaryQuery> dictionaryInfoList = new ArrayList<DictionaryQuery>();
	public String stepOne(){
		try {
//			DictionaryQuery aa = new DictionaryQuery();
//			dictionaryInfoList = dictionaryService.listAll(aa);
//			System.out.println(">>>dictionaryInfoList:"+dictionaryInfoList.size()+"");
			return "legal";
		} catch (Exception e) {
			logger.debug(">>>>",e);
		}
		return null;
	}
	public String getEducation(){
		try {
//			DictionaryQuery aa = new DictionaryQuery();
//			aa.setParentCode("17");
//			dictionaryInfoList = dictionaryService.listAll(aa);
//			System.out.println(">>>dictionaryInfoList:"+dictionaryInfoList.size()+"");
			return "education";
		} catch (Exception e) {
			logger.error(">>>",e);
		}return null;
	}
	public String getLegalApprove(){
		try {
			logger.debug(">>>213>");
			legalApplicant = legalApplicantService.get("52");
			legalAgent = legalAgentService.get("1");
			legalCase = legalCaseService.get("7");
			logger.debug(">>>legalApplicant:"+legalApplicant);
			logger.debug(">>>legalAgent:"+legalAgent);
			logger.debug(">>>legalCase:"+legalCase);
			
			if(legalApplicantQuery==null)legalApplicantQuery = new LegalApplicantQuery();
			if(legalAgentQuery==null)legalAgentQuery = new LegalAgentQuery();
			if(legalCaseQuery==null)legalCaseQuery = new LegalCaseQuery();
			
			BeanUtils.copyProperties(legalApplicant, legalApplicantQuery);
			BeanUtils.copyProperties(legalAgent, legalAgentQuery);
			BeanUtils.copyProperties(legalCase, legalCaseQuery);
			return "legal_approve";
		} catch (Exception e) {
			logger.error(">>>异常：",e);
		}return null;
	}
//	-------------------------------------------
	@Override
	public LegalApplicantQuery getModel() {
		return legalApplicantQuery;
	}
	public LegalApplicantQuery getLegalApplicantQuery() {
		return legalApplicantQuery;
	}
	public void setLegalApplicantQuery(LegalApplicantQuery legalApplicantQuery) {
		this.legalApplicantQuery = legalApplicantQuery;
	}
	public LegalApplicant getLegalApplicant() {
		return legalApplicant;
	}
	public void setLegalApplicant(LegalApplicant legalApplicant) {
		this.legalApplicant = legalApplicant;
	}
	
	
	
	
}
