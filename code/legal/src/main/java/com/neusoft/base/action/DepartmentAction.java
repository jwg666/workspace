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

import com.neusoft.base.domain.Department;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.neusoft.base.query.DepartmentQuery;
import com.neusoft.base.service.DepartmentService;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class DepartmentAction extends BaseAction implements ModelDriven<DepartmentQuery>{
	private static final long serialVersionUID = -4463997519956688660L;

	@Resource
	private DepartmentService departmentService;
	
	private DepartmentQuery departmentQuery = new DepartmentQuery();
	private Department department;
	private DataGrid datagrid;
	private List<DepartmentQuery>  departmentList = new ArrayList<DepartmentQuery>();
	private Json json = new Json();
	
	/** 通过spring自动注入 */
	public void setDepartmentService(DepartmentService service) {
		this.departmentService = service;
	}	
	
	

//---------------------------------------------------------------
	
	/**
	 * 跳转到Department管理页面
	 * 
	 * @return
	 */
	public String goDepartment() {
		return "department";
	}
	/**
	 * 跳转到查看desc页面
	 * 
	 * @return
	 */
	public String showDesc() {
		department = departmentService.get(departmentQuery);
		BeanUtils.copyProperties(department, departmentQuery);
		return "showDesc";
	}

	/**
	 * 获得pageHotel数据表格
	 */
	public String datagrid() {
		datagrid = departmentService.datagrid(departmentQuery);
		return "datagrid";
	}
	
	
	/**
	 * 获得无分页的所有数据
	 */
	public String  combox(){
		departmentList = departmentService.listAll(departmentQuery);
		return "departmentList";
	}

	/**
	 * 添加一个Department
	 */
	public String add() {
		departmentService.add(departmentQuery);
		json.setSuccess(true);
		json.setObj(departmentQuery);
		json.setMsg("添加成功！");
		return SUCCESS;
	}

	/**
	 * 编辑Department
	 */
	public String edit() {
		departmentService.update(departmentQuery);
		json.setSuccess(true);
		json.setObj(departmentQuery);
		json.setMsg("编辑成功！");
		return SUCCESS;
	}

	/**
	 * 删除Department
	 */
	public String delete() {
		departmentService.delete(departmentQuery.getIds());
		json.setSuccess(true);
		return SUCCESS;
	}

	//--------------------------------------------------------------
	@Override
	public DepartmentQuery getModel() {
		return departmentQuery;
	}
	public DepartmentQuery getDepartmentQuery() {
		return departmentQuery;
	}
	public void setDepartmentQuery(DepartmentQuery  departmentQuery) {
		this.departmentQuery = departmentQuery;
	}
	
	
	public Department getDepartment() {
		return department;
	}
	public List<DepartmentQuery> getDepartmentList() {
		return departmentList;
	}
	public DataGrid getDatagrid() {
		return datagrid;
	}
	public Json getJson() {
		return json;
	}
	
}
