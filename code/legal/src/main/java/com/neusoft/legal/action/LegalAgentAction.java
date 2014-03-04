/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.legal.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.neusoft.base.action.BaseAction;
import com.neusoft.base.model.Json;
import com.neusoft.base.model.DataGrid;
import org.springframework.beans.BeanUtils;
import com.opensymphony.xwork2.ModelDriven;
import org.springframework.stereotype.Controller;
import org.springframework.context.annotation.Scope;
import com.neusoft.legal.service.LegalAgentService;
import com.neusoft.legal.domain.LegalAgent;
import com.neusoft.legal.query.LegalAgentQuery;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class LegalAgentAction extends BaseAction implements ModelDriven<LegalAgentQuery>{
	
	private static final long serialVersionUID = 195558324270895638L;

	@Resource
	private LegalAgentService legalAgentService;
	
	private LegalAgentQuery legalAgentQuery = new LegalAgentQuery();
	private LegalAgent legalAgent;
	private DataGrid datagrid;
	private List<LegalAgentQuery>  legalAgentList = new ArrayList<LegalAgentQuery>();
	private Json json = new Json();
		
	
	/**
	 * 跳转到LegalAgent管理页面
	 * 
	 * @return
	 */
	public String goLegalAgent() {
		return "legalAgent";
	}
	/**
	 * 跳转到查看desc页面
	 * 
	 * @return
	 */
	public String showDesc() {
		legalAgent = legalAgentService.get(legalAgentQuery);
		BeanUtils.copyProperties(legalAgent, legalAgentQuery);
		return "showDesc";
	}

	/**
	 * 获得pageHotel数据表格
	 * 
	 */
	public String datagrid() {
		datagrid = legalAgentService.datagrid(legalAgentQuery);
		return "datagrid";
	}
	
	
	/**
	 * 获得无分页的所有数据
	 */
	public String  combox(){
		legalAgentList = legalAgentService.listAll(legalAgentQuery);
		return "legalAgentList";
	}

	/**
	 * 添加一个LegalAgent
	 */
	public String add() {
		legalAgentQuery.setCreateTime(new Date());
		Long id = legalAgentService.add(legalAgentQuery);
		legalAgentQuery.setId(id);
		json.setSuccess(true);
		json.setObj(legalAgentQuery);
		json.setMsg("添加成功！");
		return SUCCESS;
	}

	/**
	 * 编辑LegalAgent
	 */
	public String edit() {
		legalAgentService.update(legalAgentQuery);
		json.setSuccess(true);
		json.setObj(legalAgentQuery);
		json.setMsg("编辑成功！");
		return SUCCESS;
	}

	/**
	 * 删除LegalAgent
	 */
	public String delete() {
		legalAgentService.delete(legalAgentQuery.getIds());
		json.setSuccess(true);
		return SUCCESS;
	}

	@Override
	public LegalAgentQuery getModel() {
		return legalAgentQuery;
	}
	public LegalAgentQuery getLegalAgentQuery() {
		return legalAgentQuery;
	}
	public void setLegalAgentQuery(LegalAgentQuery  legalAgentQuery) {
		this.legalAgentQuery = legalAgentQuery;
	}
	
	
	public LegalAgent getLegalAgent() {
		return legalAgent;
	}
	public List<LegalAgentQuery> getLegalAgentList() {
		return legalAgentList;
	}
	public DataGrid getDatagrid() {
		return datagrid;
	}
	public Json getJson() {
		return json;
	}
	
}
