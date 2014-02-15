/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.base.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.domain.Dictionary;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.neusoft.base.query.DictionaryQuery;
import com.neusoft.base.service.DictionaryService;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class DictionaryAction extends BaseAction implements ModelDriven<DictionaryQuery>{
	
	@Resource
	private DictionaryService dictionaryService;
	
	private DictionaryQuery dictionaryQuery = new DictionaryQuery();
	private Dictionary dictionary;
	private DataGrid datagrid;
	private List<DictionaryQuery>  dictionaryList = new ArrayList<DictionaryQuery>();
	private Json json = new Json();
	
	/** 通过spring自动注入 */
	public void setDictionaryService(DictionaryService service) {
		this.dictionaryService = service;
	}	
	
	

//---------------------------------------------------------------
	
	/**
	 * 跳转到Dictionary管理页面
	 * 
	 * @return
	 */
	public String goDictionary() {
		return "dictionary";
	}
	/**
	 * 跳转到查看desc页面
	 * 
	 * @return
	 */
	public String showDesc() {
		dictionary = dictionaryService.get(dictionaryQuery);
		BeanUtils.copyProperties(dictionary, dictionaryQuery);
		return "showDesc";
	}

	/**
	 * 获得pageHotel数据表格
	 */
	public String datagrid() {
		datagrid = dictionaryService.datagrid(dictionaryQuery);
		return "datagrid";
	}
	
	
	/**
	 * 获得无分页的所有数据
	 */
	public String  combox(){
		dictionaryList = dictionaryService.listAll(dictionaryQuery);
		return "dictionaryList";
	}

	/**
	 * 添加一个Dictionary
	 */
	public String add() {
		dictionaryService.add(dictionaryQuery);
		json.setSuccess(true);
		json.setObj(dictionaryQuery);
		json.setMsg("添加成功！");
		return SUCCESS;
	}

	/**
	 * 编辑Dictionary
	 */
	public String edit() {
		dictionaryService.update(dictionaryQuery);
		json.setSuccess(true);
		json.setObj(dictionaryQuery);
		json.setMsg("编辑成功！");
		return SUCCESS;
	}

	/**
	 * 删除Dictionary
	 */
	public String delete() {
		dictionaryService.delete(dictionaryQuery.getIds());
		json.setSuccess(true);
		return SUCCESS;
	}

	//--------------------------------------------------------------
	@Override
	public DictionaryQuery getModel() {
		return dictionaryQuery;
	}
	public DictionaryQuery getDictionaryQuery() {
		return dictionaryQuery;
	}
	public void setDictionaryQuery(DictionaryQuery  dictionaryQuery) {
		this.dictionaryQuery = dictionaryQuery;
	}
	
	
	public Dictionary getDictionary() {
		return dictionary;
	}
	public List<DictionaryQuery> getDictionaryList() {
		return dictionaryList;
	}
	public DataGrid getDatagrid() {
		return datagrid;
	}
	public Json getJson() {
		return json;
	}
	
}
