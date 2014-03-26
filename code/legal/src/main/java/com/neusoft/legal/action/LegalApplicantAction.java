/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;
import com.neusoft.legal.domain.LegalApplicant;
import com.neusoft.legal.query.LegalApplicantQuery;
import com.neusoft.legal.service.LegalApplicantService;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class LegalApplicantAction extends BaseAction implements ModelDriven<LegalApplicantQuery>{
	
	private static final long serialVersionUID = -180594501649022070L;

	@Resource
	private LegalApplicantService legalApplicantService;
	
	private LegalApplicantQuery legalApplicantQuery = new LegalApplicantQuery();
	private LegalApplicant legalApplicant;
	private List<LegalApplicantQuery>  legalApplicantList = new ArrayList<LegalApplicantQuery>();
	
	/**
	 * 跳转到LegalApplicant管理页面
	 * 
	 * @return
	 */
	public String goLegalApplicant() {
		return "legalApplicant";
	}
	/**
	 * 跳转到查看desc页面
	 * 
	 * @return
	 */
	public String showDesc() {
		legalApplicant = legalApplicantService.get(legalApplicantQuery);
		BeanUtils.copyProperties(legalApplicant, legalApplicantQuery);
		return "showDesc";
	}

	/**
	 * 获得pageHotel数据表格
	 */
	public String datagrid() {
		datagrid = legalApplicantService.datagrid(legalApplicantQuery);
		logger.debug(">>>datagrid:"+datagrid.getRows().size());
		logger.debug(">>>datagrid:"+datagrid.getTotal());
		return "datagrid";
	}
	
	
	/**
	 * 获得无分页的所有数据
	 */
	public String  combox(){
		legalApplicantList = legalApplicantService.listAll(legalApplicantQuery);
		return "legalApplicantList";
	}

	/**
	 * 添加一个LegalApplicant
	 */
	public String add() {
		try{
			legalApplicantQuery.setCreateTime(new Date());
			Long id = legalApplicantService.add(legalApplicantQuery);
			legalApplicantQuery.setId(id);
			json.setSuccess(true);
			json.setObj(legalApplicantQuery);
			json.setMsg("添加成功！");
			//json.toString();
		}catch(Exception e){
			json.setSuccess(false);
			json.setObj(legalApplicantQuery);
			json.setMsg("录入申请人信息时出现异常！");
		}

		return SUCCESS;
	}

	/**
	 * 编辑LegalApplicant
	 */
	public String edit() {
		legalApplicantService.update(legalApplicantQuery);
		json.setSuccess(true);
		json.setObj(legalApplicantQuery);
		json.setMsg("编辑成功！");
		return SUCCESS;
	}

	/**
	 * 删除LegalApplicant
	 */
	public String delete() {
		legalApplicantService.delete(legalApplicantQuery.getIds());
		json.setSuccess(true);
		return SUCCESS;
	}

	@Override
	public LegalApplicantQuery getModel() {
		return legalApplicantQuery;
	}
	public LegalApplicantQuery getLegalApplicantQuery() {
		return legalApplicantQuery;
	}
	public void setLegalApplicantQuery(LegalApplicantQuery  legalApplicantQuery) {
		this.legalApplicantQuery = legalApplicantQuery;
	}
	
	
	public LegalApplicant getLegalApplicant() {
		return legalApplicant;
	}
	public List<LegalApplicantQuery> getLegalApplicantList() {
		return legalApplicantList;
	}
	
}
