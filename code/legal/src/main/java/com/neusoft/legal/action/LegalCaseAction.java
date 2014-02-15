/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.neusoft.legal.domain.LegalCase;
import com.neusoft.legal.query.LegalCaseQuery;
import com.neusoft.legal.service.LegalCaseService;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class LegalCaseAction extends BaseAction implements ModelDriven<LegalCaseQuery>{
	private static final long serialVersionUID = -2966718217670390552L;

	@Resource
	private LegalCaseService legalCaseService;
	
	private LegalCaseQuery legalCaseQuery = new LegalCaseQuery();
	private LegalCase legalCase;
	private DataGrid datagrid;
	private List<LegalCaseQuery>  legalCaseList = new ArrayList<LegalCaseQuery>();
	private Json json = new Json();
	
	/** 通过spring自动注入 */
	public void setLegalCaseService(LegalCaseService service) {
		this.legalCaseService = service;
	}	
	
	
	/**
	 * 跳转到LegalCase管理页面
	 * 
	 * @return
	 */
	public String goLegalCase() {
		return "legalCase";
	}
	/**
	 * 跳转到查看desc页面
	 * 
	 * @return
	 */
	public String showDesc() {
		legalCase = legalCaseService.get(legalCaseQuery);
		BeanUtils.copyProperties(legalCase, legalCaseQuery);
		return "showDesc";
	}

	/**
	 * 获得pageHotel数据表格
	 */
	public String datagrid() {
		datagrid = legalCaseService.datagrid(legalCaseQuery);
		return "datagrid";
	}
	
	
	/**
	 * 获得无分页的所有数据
	 */
	public String  combox(){
		legalCaseList = legalCaseService.listAll(legalCaseQuery);
		return "legalCaseList";
	}

	/**
	 * 添加一个LegalCase
	 */
	public String add() {
		legalCaseService.add(legalCaseQuery);
		json.setSuccess(true);
		json.setObj(legalCaseQuery);
		json.setMsg("添加成功！");
		return SUCCESS;
	}

	/**
	 * 编辑LegalCase
	 */
	public String edit() {
		legalCaseService.update(legalCaseQuery);
		json.setSuccess(true);
		json.setObj(legalCaseQuery);
		json.setMsg("编辑成功！");
		return SUCCESS;
	}

	/**
	 * 删除LegalCase
	 */
	public String delete() {
		legalCaseService.delete(legalCaseQuery.getIds());
		json.setSuccess(true);
		return SUCCESS;
	}

	@Override
	public LegalCaseQuery getModel() {
		return legalCaseQuery;
	}
	public LegalCaseQuery getLegalCaseQuery() {
		return legalCaseQuery;
	}
	public void setLegalCaseQuery(LegalCaseQuery  legalCaseQuery) {
		this.legalCaseQuery = legalCaseQuery;
	}
	
	
	public LegalCase getLegalCase() {
		return legalCase;
	}
	public List<LegalCaseQuery> getLegalCaseList() {
		return legalCaseList;
	}
	public DataGrid getDatagrid() {
		return datagrid;
	}
	public Json getJson() {
		return json;
	}
	
}
