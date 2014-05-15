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
import com.neusoft.legal.domain.LegalAgent;
import com.neusoft.legal.query.LegalAgentQuery;
import com.neusoft.legal.service.LegalAgentService;
import com.opensymphony.xwork2.ModelDriven;
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
	private List<LegalAgentQuery>  legalAgentList = new ArrayList<LegalAgentQuery>();
		
	
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
    public String getDesc(){
    	try{
    		legalAgent = legalAgentService.get(legalAgentQuery);
    		BeanUtils.copyProperties(legalAgent, legalAgentQuery);
    		json.setSuccess(true);
    		json.setObj(legalAgentQuery);
    	}catch(Exception e){
    		logger.error("加载代理人信息失败",e);
    		json.setMsg("加载代理人信息失败");
    		json.setSuccess(false);
    	}
		return SUCCESS;
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
		try{
			legalAgentQuery.setCreateTime(new Date());
			Long id = legalAgentService.add(legalAgentQuery);
			legalAgentQuery.setId(id);
			json.setSuccess(true);
			json.setObj(legalAgentQuery);
			json.setMsg("添加成功！");
		}catch(Exception e){
			logger.error("加载代理人信息失败",e);
			json.setMsg("保存代理人信息出错");
			json.setSuccess(false);
		}

		return SUCCESS;
	}
	/**
	 * 添加或修改一个LegalAgent
	 */
	public String addorupdate() {
		try{
			if(legalAgentQuery.getId()!=null){
				legalAgentService.update(legalAgentQuery);
			}else{
				legalAgentQuery.setCreateTime(new Date());
				Long id = legalAgentService.add(legalAgentQuery);
				legalAgentQuery.setId(id);
			}
			json.setSuccess(true);
			json.setObj(legalAgentQuery);
			json.setMsg("保存成功！");
		}catch(Exception e){
			logger.error("加载代理人信息失败",e);
			json.setMsg("保存代理人信息出错");
			json.setSuccess(false);
		}
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
	
}
