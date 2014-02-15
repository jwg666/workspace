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
import com.neusoft.legal.domain.LegalApprove;
import com.neusoft.legal.query.LegalApproveQuery;
import com.neusoft.legal.service.LegalApproveService;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class LegalApproveAction extends BaseAction implements ModelDriven<LegalApproveQuery>{
	
	private static final long serialVersionUID = -2432695015365550511L;

	@Resource
	private LegalApproveService legalApproveService;
	
	private LegalApproveQuery legalApproveQuery = new LegalApproveQuery();
	private LegalApprove legalApprove;
	private DataGrid datagrid;
	private List<LegalApproveQuery>  legalApproveList = new ArrayList<LegalApproveQuery>();
	private Json json = new Json();
	
	/** 通过spring自动注入 */
	public void setLegalApproveService(LegalApproveService service) {
		this.legalApproveService = service;
	}	
	
	
	/**
	 * 跳转到LegalApprove管理页面
	 * 
	 * @return
	 */
	public String goLegalApprove() {
		return "legalApprove";
	}
	/**
	 * 跳转到查看desc页面
	 * 
	 * @return
	 */
	public String showDesc() {
		legalApprove = legalApproveService.get(legalApproveQuery);
		BeanUtils.copyProperties(legalApprove, legalApproveQuery);
		return "showDesc";
	}

	/**
	 * 获得pageHotel数据表格
	 */
	public String datagrid() {
		datagrid = legalApproveService.datagrid(legalApproveQuery);
		return "datagrid";
	}
	
	
	/**
	 * 获得无分页的所有数据
	 */
	public String  combox(){
		legalApproveList = legalApproveService.listAll(legalApproveQuery);
		return "legalApproveList";
	}

	/**
	 * 添加一个LegalApprove
	 */
	public String add() {
		legalApproveService.add(legalApproveQuery);
		json.setSuccess(true);
		json.setObj(legalApproveQuery);
		json.setMsg("添加成功！");
		return SUCCESS;
	}

	/**
	 * 编辑LegalApprove
	 */
	public String edit() {
		legalApproveService.update(legalApproveQuery);
		json.setSuccess(true);
		json.setObj(legalApproveQuery);
		json.setMsg("编辑成功！");
		return SUCCESS;
	}

	/**
	 * 删除LegalApprove
	 */
	public String delete() {
		legalApproveService.delete(legalApproveQuery.getIds());
		json.setSuccess(true);
		return SUCCESS;
	}

	@Override
	public LegalApproveQuery getModel() {
		return legalApproveQuery;
	}
	public LegalApproveQuery getLegalApproveQuery() {
		return legalApproveQuery;
	}
	public void setLegalApproveQuery(LegalApproveQuery  legalApproveQuery) {
		this.legalApproveQuery = legalApproveQuery;
	}
	
	
	public LegalApprove getLegalApprove() {
		return legalApprove;
	}
	public List<LegalApproveQuery> getLegalApproveList() {
		return legalApproveList;
	}
	public DataGrid getDatagrid() {
		return datagrid;
	}
	public Json getJson() {
		return json;
	}
	
}
