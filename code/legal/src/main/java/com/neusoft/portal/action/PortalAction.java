package com.neusoft.portal.action;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.activiti.count.TaskCountService;
import com.neusoft.base.action.BaseAction;
import com.neusoft.base.common.LoginContext;
import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.model.DataGrid;
import com.neusoft.base.model.Json;
import com.neusoft.portal.model.Member;
import com.neusoft.portal.model.MemberApp;
import com.neusoft.portal.model.Pwallpaper;
import com.neusoft.portal.model.Wallpaper;
import com.neusoft.portal.query.MemberAppQuery;
import com.neusoft.portal.query.MemberQuery;
import com.neusoft.portal.query.PwallpaperQuery;
import com.neusoft.portal.query.WallpaperQuery;
import com.neusoft.portal.service.MemberAppService;
import com.neusoft.portal.service.MemberService;
import com.neusoft.portal.service.PwallpaperService;
import com.neusoft.portal.service.WallpaperService;
import com.neusoft.security.domain.ResourceInfo;
import com.neusoft.security.service.ResourceInfoService;
@Controller
@Scope("prototype")
public class PortalAction extends BaseAction {
	
	private static final long serialVersionUID = -810612427710534833L;

	public static final Map<String,String> serviceMap = new HashMap<String, String>();
	
//	@javax.annotation.ResourceInfo
//	private	AppService 	appService;
	@javax.annotation.Resource
	private	MemberAppService 	memberAppService;
	@javax.annotation.Resource
	private	MemberService 	memberService;
	@javax.annotation.Resource
	private	PwallpaperService	pwallpaperService;
	@javax.annotation.Resource
	private	WallpaperService 	wallpaperService;
	@javax.annotation.Resource
	private	ResourceInfoService 	resourceInfoService;
//	@javax.annotation.Resource
//	private TaskCountService taskCountService;
	
//	@javax.annotation.ResourceInfo
//	private FileUploadService fileUploadServiceImpl;
	private MemberQuery memberQuery = new MemberQuery();
	
	private List list = new ArrayList();
	private List<ResourceInfo> resourceInfoList = new ArrayList<ResourceInfo>();
	
	//文件接收
	private File upload;
	private String uploadContentType;
	private String uploadFileName;
	//文件备注
	private String remarks;
	
	
	//action
	private String ac;
	//壁纸状态 系统默认：1 , 上传：2 外部url：3
	private Integer wpstate;
	//拉伸、平铺....
	private String wptype;
	//wp 壁纸i的或者url
	private String wp;
	//应用码头位置  left or right
	private String dock;
	//应用图标 排列方式  x or y
	private String appxy;
	//folderid文件夹id
	private Integer folderid;
	
	private Long id;
	//桌面号
	private Integer desk;
	//桌面名称
	private String deskName;
	
	//移动后桌面号
	private Integer otherdesk;
	private String icon;
	private String name;
	//桌面号
	private Integer todesk;
	//移动到那个file (id) or 移动到后顺序
	private Integer to;
	//移动前顺序
	private Integer from;
	//移动的类型 
	private String movetype;
	//skin皮肤
	private String skin;
	
	/* ------新建私人应用-------*/
	private	String valIcon;
	private	String valName;
	private	String valUrl;
	private	Integer valWidth;
	private	Integer valHeight;
	private	String valType;
	private	Integer valIsresize;
	private	Integer valIsopenmax;
	private	Integer valIsflash;
	//是否为系统应用 1：是
	private Integer valIsapp=0;
	
	private DataGrid data;
	private Long page = 0l;
	private Long rows;
	private Integer apptype = 0;
	private String keyword;
	//应用市场tree
	private JSONArray appmarketLeftTree;
	
	//我的托管
//	private List<Grantor> grantorList;
	
	//资源ids
	private String resourceInfoIds;
	
	
	private Json json = new Json();	
	
	public String portal(){
		logger.debug("-------------------------------------------------------------------");
		Long userId= LoginContextHolder.get().getUserId();
		resourceInfoList = resourceInfoService.getParentResourceInfoTask(userId);
//		for(ResourceInfo r : resourceInfoList){
//			List<ResourceInfo> childList = resourceInfoService.getDescendantsTask(userId, r.getId());
//			if(childList==null || childList.size()==0){
//				resourceInfoList.remove(r);
//			}else if(childList.size()>1){
//				Set<ResourceInfo> set =new LinkedHashSet<ResourceInfo>(childList);
//				ResourceInfo f = childList.get(0);
//				String resName = r.getName();
//				String resLocalName = r.gotLocalName();
//				String iconUrl = r.getIconUrl();
//				PropertyUtils.copyProperties(r,f);
//				r.setName(resName);
//				r.setLocalName(resLocalName);
//				r.setIconUrl(iconUrl);
//				r.setChildResources(set);
//			}else{
//				resourceInfoList.set(resourceInfoList.indexOf(r), childList.get(0));
//			}
//		}
//		String originalEmpCode = ((LoginContext)LoginContextHolder.get()).getOriginalEmpCode();
//		String empCode = ((LoginContext)LoginContextHolder.get()).getEmpCode();
		
		
		memberQuery = memberService.getCurMemberQuery();
		if(memberQuery == null){
			memberQuery = new MemberQuery();
			memberQuery = memberService.createDefault(memberQuery);
		}
		return SUCCESS;
	}
	public String taskCount(){
		String empCode= ((LoginContext)LoginContextHolder.get()).getEmpCode();
		Map<String, Integer> taskCountMap = new HashMap<String, Integer>();
		if(StringUtils.isNotBlank(resourceInfoIds)){
			String resIds[] = resourceInfoIds.split(",");
			String countService;
			for(String resId : resIds){
				countService = serviceMap.get(resId);
				if(countService!=null && taskCountMap.get(resId)==null){
					try {
//						taskCountMap.put(resId, taskCountService.getTaskCount(empCode));
					} catch (NoSuchBeanDefinitionException e) {
						logger.error("got exception--",e);
						taskCountMap.put(resId, 0);
					} catch (Exception e) {
						logger.error("got exception--",e);
						taskCountMap.put(resId, 0);
					}
				}
			}
		}
		json.setObj(taskCountMap);
		json.setSuccess(true);
		return SUCCESS;
	}
	
	//ajax 请求转发请求
	public String ajax(){
		if("getWallpaper".equals(ac)){
			findWallpaper();
		}else if("getSkin".equals(ac)){
			findSkin();
		}else if("getDockPos".equals(ac)){
			findDockPos();
		}else if("getAppXY".equals(ac)){
			findAppXY();
		}else if("getMyFolderApp".equals(ac)){
			findMyFolderApp();
		}else if("getMyApp".equals(ac)){
			findMyApp();
		}else if("getMyAppById".equals(ac)){
			findMyAppById();
		}else if("setWallpaper".equals(ac)){
			updateWallpaper();
		}else if("setDockPos".equals(ac)){
			updateDockPos();
		}else if("setAppXY".equals(ac)){
			updateAppXY();
		}else if("getAppStar".equals(ac)){
//			findAppStar();
		}else if("updateDockPos".equals(ac)){
			updateDockPos();
		}else if("updateAppXY".equals(ac)){
			updateAppXY();
		}else if("addMyApp".equals(ac)){
			addMyApp();
		}else if("delMyApp".equals(ac)){
			delMyApp();
		}else if("moveMyApp".equals(ac)){
			moveMyApp();
		}else if("updateMyApp".equals(ac)){
			updateMyApp();
		}else if("addFolder".equals(ac)){
			addFolder();
		}else if("updateFolder".equals(ac)){
			updateFolder();
		}else if("addDesk".equals(ac)){
			return addDesk();
		}else if("removeDesk".equals(ac)){
			return removeDesk();
		}else if("updateDesk".equals(ac)){
			return updateDesk();
		}else if("loadDeskName".equals(ac)){
			return loadDeskName();
		}else if("deleteWallpaper".equals(ac)){
			return deleteWallpaper();
		}
		return SUCCESS;
	}
	//壁纸管理action
	public String wallpaper(){
		this.memberQuery = memberService.getCurMemberQuery();
		List<WallpaperQuery>  wallList= wallpaperService.listAll(new WallpaperQuery());
		this.list = wallList;
		return SUCCESS;
	}
	//自定义壁纸管理action
	public String wallpaperCustom(){
		this.memberQuery = memberService.getCurMemberQuery();
		PwallpaperQuery pwallpaperQuery = new PwallpaperQuery();
		pwallpaperQuery.setMemberId(this.memberQuery.getTbid());
		List<PwallpaperQuery>  wallList= pwallpaperService.listAll(pwallpaperQuery);
		this.list = wallList;
		return SUCCESS;
	}
	//桌面设置管理action
	public String desksetting(){
		Member member = memberService.getCurMember();
		json.setObj(member.getDockpos());
		return SUCCESS;
	}
	//皮肤管理action
	public String skin(){
		if("update".equals(ac)){
			MemberQuery curMemberQuery = memberService.getCurMemberQuery();
			curMemberQuery.setSkin(skin);
			memberService.update(curMemberQuery);
		}else{
			String contextPath = ServletActionContext.getServletContext().getRealPath("/cms");
			String uri = contextPath + File.separator + "assets" + File.separator + "portal" + File.separator + "img" + File.separator + "skins";
			File file = new File(uri); 
			if(file.exists()){
				File[] files = file.listFiles();
				for(File f:files){
					if(f.isFile() && f.getName().endsWith(".css")){
						Map<String,String> map = new HashMap<String, String>();
						map.put("name", f.getName().replaceAll(".css", ""));
						map.put("img", "portal/img/skins/"+f.getName().replaceAll(".css", "")+"/preview.png");
						list.add(map);
					}
				}
			}
		}
		return SUCCESS;
	}
	//新建私人应用action(暂时不需要)
	public String papp(){
		MemberQuery curMemberQuery = memberService.getCurMemberQuery();
		if("edit".equals(ac)){
			MemberAppQuery memberAppQuery = new MemberAppQuery();
			memberAppQuery.setMemberId(curMemberQuery.getTbid());
			if(id!=null){
				MemberApp memberApp = memberAppService.get(id.toString());
				if(memberApp.getMemberId().longValue() == curMemberQuery.getTbid().longValue()){
					PropertyUtils.copyProperties(memberAppQuery, memberApp);
				}else{
					json.setSuccess(false);
					return "";
				}
			}
			memberAppQuery.setIcon(valIcon);
			memberAppQuery.setName(valName);
			memberAppQuery.setWidth(valWidth);
			memberAppQuery.setHeight(valHeight);
			if(valIsapp.intValue()!=1){
				memberAppQuery.setType(valType);
				memberAppQuery.setUrl(valUrl);
			}
			memberAppQuery.setIsresize(valIsresize);
			memberAppQuery.setIsopenmax(valIsopenmax);
			memberAppQuery.setIsflash(valIsflash);
			if(memberAppQuery.getTbid()==null){
				memberAppQuery.setDesk(desk);
				memberAppService.addMyApp(memberAppQuery);
			}else{
				memberAppService.update(memberAppQuery);
			}
			Map<String, String> map = new HashMap<String, String>();
			map.put("info","");
			map.put("status", "y");
			json.setObj(map);
			return SUCCESS;
		}else{
			Member member = memberService.getCurMember();
			MemberAppQuery memberAppQuery = new MemberAppQuery();
			if(id!=null){
				memberAppQuery.setTbid(id);
				memberAppQuery.setMemberId(member.getTbid());
				List<MemberAppQuery> memberAppList = memberAppService.listAll(memberAppQuery);
				if(memberAppList!=null&&memberAppList.size()>0){
					json.setObj(memberAppList.get(0));
				}
			}else{
				memberAppQuery.setIcon("913");
				memberAppQuery.setType("papp");
				memberAppQuery.setIsflash(0);
				memberAppQuery.setIsresize(1);
				memberAppQuery.setIsopenmax(0);
				memberAppQuery.setDesk(desk);
				json.setObj(memberAppQuery);
			}
			if(valIsapp.intValue()==1){
				return "realapp";
			}else{
				return INPUT;
			}
		}
	}
	//应用市场
	public String appmarket(){
		
		if("getList".equals(ac)){
			Pager<ResourceInfo> pager = null;
			Member member = memberService.getCurMember();
			MemberAppQuery memberAppQuery = new MemberAppQuery();
			memberAppQuery.setMemberId(member.getTbid());
			if(apptype!=null && -1 == apptype.intValue()){//我的应用
				memberAppQuery.setPage(page);
				memberAppQuery.setRows(rows);
				memberAppQuery.setName(keyword);
				data = memberAppService.datagrid(memberAppQuery);
			}else{//通过tab加载子应用
				pager = new Pager<ResourceInfo>();
				pager.setCurrentPage(page);
				pager.setPageSize(rows);
				ResourceInfo res = new ResourceInfo();
				res.setName(keyword);
				if(apptype!=null){
					res.setId(Long.valueOf(apptype));
				}				
				res.setMemberId(member.getTbid());
				data = resourceInfoService.datagrid(pager, res);
			}
			return "json";
		}else{
			List<ResourceInfo> rs = resourceInfoService.getUserDisplayResourceInfo();
			for(ResourceInfo r:rs){
				if(r.getId().compareTo(r.getParentId())==0){
					r.setParentId(Long.valueOf(0));
				}
			}
			ResourceInfo allRes = new ResourceInfo();
			allRes.setId(Long.valueOf(0));
			allRes.setName("应用超市");
			rs.add(allRes);
			ResourceInfo myRes = new ResourceInfo();
			myRes.setId(Long.valueOf(-1));
			myRes.setParentId(Long.valueOf(-1));
			myRes.setName("我的应用");
			rs.add(myRes);
			appmarketLeftTree = JSONArray.fromObject(rs);
			return SUCCESS;
		}
	}
	
	//获得头像
	public void findAvatar(){
		
	}
	//获得主题
	public void findWallpaper(){
		Member member = memberService.getCurMember();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("wallpaperstate", member.getWallpaperstate());
		if(member.getWallpaperstate().intValue() == 3){
			map.put("wallpaperwebsite", member.getWallpaperwebsite());
			json.setObj(map);
		}else{
			map.put("wallpapertype", member.getWallpapertype());
			if(member.getWallpaperstate().intValue() == 2){
				Pwallpaper pwallpaper = pwallpaperService.get(member.getWallpaperId().toString());
				map.put("url", pwallpaper.getUrl());
				map.put("width", pwallpaper.getWidth());
				map.put("height", pwallpaper.getHeight());
			}else{
				Wallpaper wallpaper = wallpaperService.get(member.getWallpaperId().toString());
				map.put("url", wallpaper.getUrl());
				map.put("width", wallpaper.getWidth());
				map.put("height", wallpaper.getHeight());
			}
		} 
		json.setObj(map);
	}
	//删除自定义主题
	public String deleteWallpaper(){
		if(id!=null){
			Pwallpaper pwallpaper = pwallpaperService.delete(id.toString());
			if(pwallpaper!=null){
//				fileUploadServiceImpl.deleteFileByIds(pwallpaper.getUrl());
				json.setSuccess(true);
			}
		}
		return "json";
	}
	//更新主题
	public void updateWallpaper(){
		MemberQuery curMemberQuery =memberService.getCurMemberQuery();
		curMemberQuery.setWallpapertype(wptype);
		if(0 != wpstate.intValue()){
			curMemberQuery.setWallpaperstate(wpstate);
			if(3 == wpstate.intValue()){
				curMemberQuery.setWallpaperwebsite(wp);
			}else{
				curMemberQuery.setWallpaperId(Integer.parseInt(wp));
			}
		}
		memberService.update(curMemberQuery);
	}
	//获得窗口皮肤
	public void findSkin(){
		Member member = memberService.getCurMember();
		json.setObj(member.getSkin());
	}
	//获得应用码头位置
	public void findDockPos(){
		Member member = memberService.getCurMember();
		json.setObj(member.getDockpos());
		
	}
	//更新应用码头位置
	public void updateDockPos(){
		MemberQuery curMemberQuery =memberService.getCurMemberQuery();
		curMemberQuery.setDockpos(dock);
		memberService.update(curMemberQuery);
	}
	//获得图标排列方式
	public void findAppXY(){
		Member member = memberService.getCurMember();
		json.setObj(member.getAppxy());
		
	}
	//更新图标排列方式
	public void updateAppXY(){
		MemberQuery curMemberQuery =memberService.getCurMemberQuery();
		curMemberQuery.setAppxy(appxy);
		memberService.update(curMemberQuery);
	}
	//获得文件夹内图标
	public void findMyFolderApp(){
		Member member = memberService.getCurMember();
		MemberAppQuery memberAppQuery = new MemberAppQuery();
		memberAppQuery.setMemberId(member.getTbid());
		memberAppQuery.setFolderId(folderid.longValue());
		List<MemberAppQuery> memberAppList = memberAppService.listAll(memberAppQuery);
		json.setObj(memberAppList);
	}
	//获得桌面图标
	public void findMyApp(){
		json.setObj(memberAppService.findMyApp());
	}
	//根据id获取图标
	public void findMyAppById(){
		Member member = memberService.getCurMember();
		MemberAppQuery memberAppQuery = new MemberAppQuery();
		memberAppQuery.setMemberId(member.getTbid());
		memberAppQuery.setTbid(id);
		MemberApp memberApp = memberAppService.get(memberAppQuery);
		if(memberApp!=null){
			PropertyUtils.copyProperties(memberAppQuery, memberApp);
			json.setSuccess(true);
			json.setObj(memberAppQuery);
		}
	}
	//添加桌面图标
	public void addMyApp(){
		MemberAppQuery memberAppQuery = new MemberAppQuery();
		memberAppQuery.setType("");
		memberAppQuery.setTbid(id);
		memberAppQuery.setDesk(desk);
		memberAppService.addMyApp(memberAppQuery);
	}
	
	//删除桌面图标
	public void delMyApp(){
		MemberAppQuery memberAppQuery = new MemberAppQuery();
		memberAppQuery.setTbid(id);
		memberAppService.delApp(memberAppQuery);
	}
	//更新桌面图标
	public void moveMyApp(){
		memberAppService.updateMyApp(id, null, desk, todesk, null, null);
	}
	public void updateMyApp(){
		memberAppService.updateMyApp(id, movetype, desk, otherdesk, from, to);
	}
	//新建文件夹
	public void addFolder(){
		MemberAppQuery memberAppQuery = new MemberAppQuery();
		memberAppQuery.setType("folder");
		memberAppQuery.setDesk(desk);
		memberAppQuery.setIcon(icon);
		memberAppQuery.setName(name);
		memberAppService.addMyApp(memberAppQuery);
	}
	//文件夹重命名
	public void updateFolder(){
		MemberApp memberApp = memberAppService.get(id.toString());
		MemberAppQuery memberAppQuery = new MemberAppQuery();
		PropertyUtils.copyProperties(memberAppQuery, memberApp);
		memberAppQuery.setName(name);
		memberAppQuery.setIcon(icon);
		memberAppService.update(memberAppQuery);
	}
	//获得应用评分
//	public void findAppStar(){
//		AppQuery appQuery = new AppQuery();
//		appQuery.setTbid(id);
//		App app = appService.get(appQuery);
//		json.setObj(app.getStarnum());
//	}
	//上传文件
	public String uploadImg(){
		/**
		Long memberId = memberService.getCurMember().getTbid();
		if(upload!=null){
//			UploadFile uploadFile = null;
//			ExecuteResult<UploadFile> result = null;
			try {
				if(StringUtils.isBlank(remarks)){
//					result = fileUploadServiceImpl.fileUpload(upload, uploadFileName,uploadContentType);
				}else{
//					result = fileUploadServiceImpl.fileUpload(upload, uploadFileName,uploadContentType,remarks);
				}
//				uploadFile = result.getResult();
			} catch (IOException e) {
				LOG.error(e.getMessage(), e);
				json.setMsg(e.getMessage());
				return SUCCESS;
			}
			if(result.isSuccess()){
				//判断是不是上传壁纸
				if("custom".equals(ac)){
					PwallpaperQuery query = new PwallpaperQuery();
					query.setMemberId(memberId);
					ImageInfo ii = new ImageInfo();
					try {
						ii.setInput(new FileInputStream(upload));
					} catch (FileNotFoundException e) {
						LOG.error(e.getMessage(), e);
						json.setMsg(e.getMessage());
						return SUCCESS;
					}
					if(ii.check()){
						query.setHeight(ii.getHeight());
						query.setWidth(ii.getWidth());
					}
					query.setUrl(uploadFile.getId().toString());
					pwallpaperService.add(query);
					json.setSuccess(true);
					json.setObj(query);
				}else{
					json.setObj(uploadFile);
				}
			}else{
				json.setObj(result.getErrorMessages());
			}
		}
		**/
		return SUCCESS;		
	}
	//更新应用评分(暂时用不上)
	public void updateAppStar(){}
	
	//	增加桌面
	public String addDesk(){
		MemberQuery curMemberQuery =memberService.getCurMemberQuery();
		if(curMemberQuery.getDesknum()>=5){
			json.setMsg("桌面最多支持5个！不允许再增加！");
		}else{
			int desknum = curMemberQuery.getDesknum();
			String desknames[] = curMemberQuery.getDesknames();
			desknames[desknum] = "桌面"+(desknum+1);
			curMemberQuery.setDesknum(desknum+1);
			curMemberQuery.importDesknames(desknames);
			memberService.update(curMemberQuery);
			json.setSuccess(true);
		}
		return "json";
	}
	// 删除桌面
	public String removeDesk(){
		if(desk!=null && desk > 0){
			MemberQuery curMemberQuery =memberService.getCurMemberQuery();
			int desknum = curMemberQuery.getDesknum();
			if(desknum<desk){
				json.setMsg("桌面不存在！");
				return "json";
			}
			if(desknum<=1){
				json.setMsg("至少保留一个桌面！");
				return "json";
			}
			String desks[] = curMemberQuery.gotDesks();
			logger.debug(""+desks[desk-1]);
			if(StringUtils.isNotEmpty(desks[desk-1])){
				json.setMsg("请先移除该桌面上的应用后再删除！");
				return "json";
			}
			String desknames[] = curMemberQuery.getDesknames();
			//从删除桌面开始 用后面的桌面 覆盖前一桌面；
			for(int i = desk-1;i<5;i++){
				desks[i]=desks[i+1];
				desknames[i]=desknames[i+1];
			}
			curMemberQuery.importDesks(desks);
			curMemberQuery.importDesknames(desknames);
			//桌面数减一
			curMemberQuery.setDesknum(desknum-1);
			memberService.update(curMemberQuery);
			json.setSuccess(true);
		}else{
			json.setMsg("参数有误！");
		}
		return "json";
	}
	//更新桌面
	public String updateDesk(){
		if(desk!=null && desk > 0 && StringUtils.isNotEmpty(deskName)){
			MemberQuery curMemberQuery =memberService.getCurMemberQuery();
			int desknum = curMemberQuery.getDesknum();
			if(desknum<desk){
				json.setMsg("桌面不存在！");
				return "json";
			}
			String desknames[] = curMemberQuery.getDesknames();
			desknames[desk-1] = deskName;
			curMemberQuery.importDesknames(desknames);
			memberService.update(curMemberQuery);
			json.setSuccess(true);
		}else{
			json.setMsg("参数有误！");
		}
		return "json";
	}
	//加载桌面名称
	public String loadDeskName(){
		MemberQuery curMemberQuery =memberService.getCurMemberQuery();
		String desks[] = new String[curMemberQuery.getDesknum()];
		String desknames[] = curMemberQuery.getDesknames();
		for(int i=0;i<curMemberQuery.getDesknum();i++){
			desks[i] = desknames[i];
		}
		json.setSuccess(true);
		json.setObj(desks);
		return "json";
	}
	
	
	
	
	public void setAc(String ac) {
		this.ac = ac;
	}
	public void setWpstate(Integer wpstate) {
		this.wpstate = wpstate;
	}
	public void setWptype(String wptype) {
		this.wptype = wptype;
	}
	public void setWp(String wp) {
		this.wp = wp;
	}
	public void setDock(String dock) {
		this.dock = dock;
	}
	public void setAppxy(String appxy) {
		this.appxy = appxy;
	}
	public void setFolderid(Integer folderid) {
		this.folderid = folderid;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public void setDesk(Integer desk) {
		this.desk = desk;
	}
	public void setDeskName(String deskName) {
		this.deskName = deskName;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setTodesk(Integer todesk) {
		this.todesk = todesk;
	}

	public void setMovetype(String movetype) {
		this.movetype = movetype;
	}
	
	public void setOtherdesk(Integer otherdesk) {
		this.otherdesk = otherdesk;
	}

	public void setTo(Integer to) {
		this.to = to;
	}

	public void setFrom(Integer from) {
		this.from = from;
	}
	public void setSkin(String skin) {
		this.skin = skin;
	}

	
	
	public void setValIcon(String valIcon) {
		this.valIcon = valIcon;
	}
	public void setValName(String valName) {
		this.valName = valName;
	}
	public void setValUrl(String valUrl) {
		this.valUrl = valUrl;
	}
	public void setValWidth(Integer valWidth) {
		this.valWidth = valWidth;
	}
	public void setValHeight(Integer valHeight) {
		this.valHeight = valHeight;
	}
	public void setValType(String valType) {
		this.valType = valType;
	}
	public void setValIsresize(Integer valIsresize) {
		this.valIsresize = valIsresize;
	}
	public void setValIsopenmax(Integer valIsopenmax) {
		this.valIsopenmax = valIsopenmax;
	}
	public void setValIsflash(Integer valIsflash) {
		this.valIsflash = valIsflash;
	}
	public void setValIsapp(Integer valIsapp) {
		this.valIsapp = valIsapp;
	}
	public void setPage(Long page) {
		this.page = page;
	}
	public void setApptype(Integer apptype) {
		this.apptype = apptype;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Json getJson() {
		return json;
	}
	
	public MemberQuery getMemberQuery() {
		return memberQuery;
	}
	
	public List getList() {
		return list;
	}
	
	public List<ResourceInfo> getResourceInfoList() {
		return resourceInfoList;
	}
	public void setUpload(File upload) {
		this.upload = upload;
	}
	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public void setRows(Long rows) {
		this.rows = rows;
	}
	public DataGrid getData() {
		return data;
	}
	public JSONArray getAppmarketLeftTree() {
		return appmarketLeftTree;
	}
	public void setAppmarketLeftTree(JSONArray appmarketLeftTree) {
		this.appmarketLeftTree = appmarketLeftTree;
	}
	
	public String getResourceInfoIds() {
		return resourceInfoIds;
	}
	public void setResourceInfoIds(String resourceInfoIds) {
		this.resourceInfoIds = resourceInfoIds;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
}
