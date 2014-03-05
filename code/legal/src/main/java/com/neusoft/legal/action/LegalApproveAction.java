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
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.neusoft.legal.domain.LegalApprove;
import com.neusoft.legal.domain.LegalCase;
import com.neusoft.legal.query.LegalAgentQuery;
import com.neusoft.legal.query.LegalApproveQuery;
import com.neusoft.legal.query.LegalCaseQuery;
import com.neusoft.legal.service.LegalAgentService;
import com.neusoft.legal.service.LegalApproveService;
import com.neusoft.legal.service.LegalCaseService;
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
	@Resource
	private LegalCaseService legalCaseService;
	@Resource
	private LegalAgentService legalAgentService;
	private LegalApproveQuery legalApproveQuery = new LegalApproveQuery();
	private LegalApprove legalApprove;
	private DataGrid datagrid;
	private List<LegalApproveQuery>  legalApproveList = new ArrayList<LegalApproveQuery>();
	private Json json = new Json();
	private LegalCaseQuery legalCaseQuery;
	private LegalAgentQuery legalAgentQuery;
	
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
		legalApproveQuery.setCreateTime(new Date());
		Long id = legalApproveService.add(legalApproveQuery);
		legalApproveQuery.setId(id);
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
	
	public String goTaskList(){
		return "taskList";
	}
	public String taskDetail(){
		legalCaseQuery = legalCaseService.getQuery(legalApproveQuery.getCaseId());
		legalAgentQuery = legalAgentService.getQuery(legalCaseQuery.getAgentId());
		return "taskDetail";
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
	public void setLegalApprove(LegalApprove legalApprove) {
		this.legalApprove = legalApprove;
	}
	public LegalCaseQuery getLegalCaseQuery() {
		return legalCaseQuery;
	}
	public void setLegalCaseQuery(LegalCaseQuery legalCaseQuery) {
		this.legalCaseQuery = legalCaseQuery;
	}
	public LegalAgentQuery getLegalAgentQuery() {
		return legalAgentQuery;
	}
	public void setLegalAgentQuery(LegalAgentQuery legalAgentQuery) {
		this.legalAgentQuery = legalAgentQuery;
	}
	public void setDatagrid(DataGrid datagrid) {
		this.datagrid = datagrid;
	}
	public void setLegalApproveList(List<LegalApproveQuery> legalApproveList) {
		this.legalApproveList = legalApproveList;
	}
	public void setJson(Json json) {
		this.json = json;
	}
	
	
}
