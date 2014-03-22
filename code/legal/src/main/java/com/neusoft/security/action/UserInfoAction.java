/*
 * Powered By neusoft 
 * Since 2008 - 2014
 */

package com.neusoft.security.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.neusoft.security.domain.UserInfo;
import com.neusoft.security.query.UserInfoQuery;
import com.neusoft.security.service.UserInfoService;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class UserInfoAction extends BaseAction implements ModelDriven<UserInfoQuery>{
	
	@Resource
	private UserInfoService userInfoService;
	
	private UserInfoQuery userInfoQuery = new UserInfoQuery();
	private UserInfo userInfo;
	private DataGrid datagrid;
	private List<UserInfoQuery>  userInfoList = new ArrayList<UserInfoQuery>();
	private Json json = new Json();
		
	
	/**
	 * 跳转到UserInfo管理页面
	 * 
	 * @return
	 */
	public String goUserInfo() {
		return "userInfo";
	}
	/**
	 * 跳转到查看desc页面
	 * 
	 * @return
	 */
	public String showDesc() {
		userInfo = userInfoService.get(userInfoQuery);
		BeanUtils.copyProperties(userInfo, userInfoQuery);
		return "showDesc";
	}

	/**
	 * 获得pageHotel数据表格
	 */
	public String datagrid() {
		datagrid = userInfoService.datagrid(userInfoQuery);
		return "datagrid";
	}
	
	
	/**
	 * 获得无分页的所有数据
	 */
	public String  combox(){
		userInfoList = userInfoService.listAll(userInfoQuery);
		return "userInfoList";
	}

	/**
	 * 添加一个UserInfo
	 */
	public String add() {
		userInfoService.add(userInfoQuery);
		json.setSuccess(true);
		json.setObj(userInfoQuery);
		json.setMsg("添加成功！");
		return SUCCESS;
	}

	/**
	 * 编辑UserInfo
	 */
	public String edit() {
		userInfoService.update(userInfoQuery);
		json.setSuccess(true);
		json.setObj(userInfoQuery);
		json.setMsg("编辑成功！");
		return SUCCESS;
	}

	/**
	 * 删除UserInfo
	 */
	public String delete() {
		userInfoService.delete(userInfoQuery.getIds());
		json.setSuccess(true);
		return SUCCESS;
	}

	@Override
	public UserInfoQuery getModel() {
		return userInfoQuery;
	}
	public UserInfoQuery getUserInfoQuery() {
		return userInfoQuery;
	}
	public void setUserInfoQuery(UserInfoQuery  userInfoQuery) {
		this.userInfoQuery = userInfoQuery;
	}
	
	
	public UserInfo getUserInfo() {
		return userInfo;
	}
	public List<UserInfoQuery> getUserInfoList() {
		return userInfoList;
	}
	public DataGrid getDatagrid() {
		return datagrid;
	}
	public Json getJson() {
		return json;
	}
	
}
