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
	private List<LegalCaseQuery>  legalCaseList = new ArrayList<LegalCaseQuery>();

	
	
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
		logger.debug(">>>datagrid:"+datagrid.getRows().size());
		return "datagrid";
	}
	public String taskgrid() {
		datagrid = legalCaseService.taskgrid(legalCaseQuery);
		return "datagrid";
	}
	public String getyiban(){
		datagrid=legalCaseService.getyiban(legalCaseQuery);
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
		legalCaseQuery.setCreateTime(new Date());
		Long id = legalCaseService.add(legalCaseQuery);
		legalCaseQuery.setId(id);
		json.setSuccess(true);
		json.setObj(legalCaseQuery);
		json.setMsg("添加成功！");
		if(null!=id&&!id.equals(0)){
			//FIXME 启动工作流
			legalCaseService.startWorkFlow(legalCaseQuery);
			
			logger.debug("工作流启动成功");
		}
		return SUCCESS;
	}
    /**
     * @return  保存并启动工作流
     */
    public String addAndStart(){
    	try{
    		legalCaseService.addAndStart(legalCaseQuery);
    		json.setSuccess(true);
    		json.setMsg("保存成功");
    		json.setObj(legalCaseQuery);
    	}catch(Exception e){
    		json.setSuccess(false);
    		json.setMsg("存储信息或启动审批流程失败");
    	}
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
	public String dock(){
		
		return "dock";
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
	
}
