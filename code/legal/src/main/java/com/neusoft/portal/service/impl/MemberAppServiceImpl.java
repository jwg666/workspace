package com.neusoft.portal.service.impl;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.dao.MemberAppDao;
import com.neusoft.portal.model.Member;
import com.neusoft.portal.model.MemberApp;
import com.neusoft.portal.query.MemberAppQuery;
import com.neusoft.portal.query.MemberQuery;
import com.neusoft.portal.service.MemberAppService;
import com.neusoft.portal.service.MemberService;
import com.neusoft.security.domain.ResourceInfo;
import com.neusoft.security.domain.ResourceTypeEnum;
import com.neusoft.security.service.ResourceInfoService;
@Service("memberAppService")
@Transactional
public class MemberAppServiceImpl implements MemberAppService{
	@Resource
	private MemberAppDao memberAppDao;
	@Resource
	private	MemberService 	memberService;
	@Resource
	private	ResourceInfoService resourceInfoService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public DataGrid datagrid(MemberAppQuery memberAppQuery) {
		DataGrid j = new DataGrid();
		Pager<MemberApp> pager  = find(memberAppQuery);
		List<MemberAppQuery> memberAppQueries = getQuerysFromEntitys(pager.getRecords());
		initLocalMsg(memberAppQueries);
		j.setRows(memberAppQueries);
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<MemberAppQuery> getQuerysFromEntitys(List<MemberApp> memberApps) {
		List<MemberAppQuery> memberAppQuerys = new ArrayList<MemberAppQuery>();
		if (memberApps != null && memberApps.size() > 0) {
			for (MemberApp tb : memberApps) {
				MemberAppQuery b = new MemberAppQuery();
				BeanUtils.copyProperties(tb, b);
				memberAppQuerys.add(b);
			}
		}
		return memberAppQuerys;
	}

	private Pager<MemberApp> find(MemberAppQuery memberAppQuery) {
		return  memberAppDao.findPage(memberAppQuery);
		
	}
	


	@Override
	public MemberApp add(MemberAppQuery memberAppQuery) {
		MemberApp t = new MemberApp();
		BeanUtils.copyProperties(memberAppQuery, t);
		memberAppDao.save(t);
		BeanUtils.copyProperties(t ,memberAppQuery);
		return t;
	}

	@Override
	public void update(MemberAppQuery memberAppQuery) {
		MemberApp t = memberAppDao.getById(memberAppQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(memberAppQuery, t);
		}
	    memberAppDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			MemberQuery memberQuery = memberService.getCurMemberQuery();
			for(java.lang.Long id : ids){
				MemberApp t = memberAppDao.getById(id);
				if (t != null && t.getMemberId().intValue() == memberQuery.getTbid().intValue()) {
					memberAppDao.delete(t);
				}
			}
		}
	}

	@Override
	public MemberApp get(MemberAppQuery memberAppQuery) {
		MemberApp memberApp = memberAppDao.getById(Long.valueOf(memberAppQuery.getTbid()));
		initLocalMsg(memberApp);
		return memberApp;
	}

	@Override
	public MemberApp get(String id) {
		MemberApp memberApp = memberAppDao.getById(Long.parseLong(id));
		initLocalMsg(memberApp);
		return memberApp;
	}

	
	@Override
	public List<MemberAppQuery> listAll(MemberAppQuery memberAppQuery) {
	    List<MemberApp> list = memberAppDao.findList(memberAppQuery);
		List<MemberAppQuery> listQuery =getQuerysFromEntitys(list) ;
		initLocalMsg(listQuery);
		return listQuery;
	}

	@Override
	public void addMyApp(MemberAppQuery memberAppQuery) {
		Date now = new Date();
		memberAppQuery.setDt(now);
		memberAppQuery.setLastdt(now);
		MemberQuery memberQuery = memberService.getCurMemberQuery();
		memberAppQuery.setMemberId(memberQuery.getTbid());
		ResourceInfo resource = null;
		if("folder".equals(memberAppQuery.getType())){
			memberAppQuery.setWidth(650);
			memberAppQuery.setHeight(400);
		}else if(!"pwidget".equals(memberAppQuery.getType()) &&  !"papp".equals(memberAppQuery.getType()) ){
			MemberAppQuery tempQuery = new MemberAppQuery();
			tempQuery.setMemberId(memberAppQuery.getMemberId());
			resource = resourceInfoService.getResourceInfoById(memberAppQuery.getTbid());
			//App app =appService.get(memberAppQuery.getTbid().toString());
			if(resource==null){
				return;
			}
			tempQuery.setRealid(resource.getId());
			List list = listAll(tempQuery);
			if(list!=null && list.size()>0){
				return;
			}
			//PropertyUtils.copyProperties(memberAppQuery, app);
			String icon = resource.getIconUrl();
			memberAppQuery.setIcon(StringUtils.isEmpty(icon)?"2067":icon);
			String url = resource.getUrl();
			if(url!=null){
				url = url.replaceAll("\\.action", ".do");
			}
			memberAppQuery.setUrl(url);
			memberAppQuery.setIsflash(0);
			//默认 打开最大化
			memberAppQuery.setIsopenmax(1);
			memberAppQuery.setIsresize(1);
			memberAppQuery.setIssetbar(1);
			memberAppQuery.setName(resource.getName());
			memberAppQuery.setWidth(resource.getWidth());
			memberAppQuery.setHeight(resource.getHeight());
//			memberAppQuery.setIcon(resource.getIconUrl());
			memberAppQuery.setFolderId(0l);
			memberAppQuery.setType("app");
			memberAppQuery.setRealid(resource.getId());
			memberAppQuery.setDt(now);
			memberAppQuery.setLastdt(now);
			memberAppQuery.setMemberId(memberQuery.getTbid());
		}
		add(memberAppQuery);
		Long appId = memberAppQuery.getTbid();
		if(appId!=null){
			if(resource!=null && ResourceTypeEnum.DESK_COMPONENT_RESOURCE.getType() == resource.getType().intValue()){
				String docks = memberQuery.getDock();
				docks = insertStrings(docks, -1, -1, appId);
				memberQuery.setDock(docks);
			}else{
				String [] desks = memberQuery.gotDesks();
				String desk = desks[memberAppQuery.getDesk()-1];
				desks[memberAppQuery.getDesk()-1] = insertStrings(desk, -1, -1, appId);
				memberQuery.importDesks(desks);
			}
			memberService.update(memberQuery);
		}
		
	}

	@Override
	public void updateMyApp(Long id,String movetype,Integer desk,Integer otherdesk, Integer from ,Integer to) {
		if(id==null){return;}
		String appId = id.toString();
		MemberApp memberApp = get(appId);
		if(memberApp==null){return;}
		MemberAppQuery memberAppQuery = new MemberAppQuery();
		PropertyUtils.copyProperties(memberAppQuery, memberApp);
		MemberQuery memberQuery = memberService.getCurMemberQuery();
		if("dock-folder".equals(movetype)){
			memberQuery.setDock(removeStrings(memberQuery.getDock(), appId));
			memberService.update(memberQuery);
			memberAppQuery.setFolderId(to.longValue());
			update(memberAppQuery);
		}else if("dock-dock".equals(movetype)){
			String dock = memberQuery.getDock();
			dock = insertStrings(dock,from,to,id);
			memberQuery.setDock(dock);
			memberService.update(memberQuery);
		}else if("dock-desk".equals(movetype)){
			if(desk.intValue() == 6){
				logger.error("home桌面不能放置应用！");
			}
			memberQuery.setDock(removeStrings(memberQuery.getDock(), appId));
			String[] desks = memberQuery.gotDesks();
			desks[desk-1] = insertStrings(desks[desk-1],-1,to,id);
			memberQuery.importDesks(desks);
			memberService.update(memberQuery);
		}else if("desk-folder".equals(movetype)){
			String[] desks = memberQuery.gotDesks();
			desks[desk-1] = removeStrings(desks[desk-1], appId);
			memberQuery.importDesks(desks);
			memberService.update(memberQuery);
			memberAppQuery.setFolderId(to.longValue());
			update(memberAppQuery);
		}else if("desk-dock".equals(movetype)){
			String[] desks = memberQuery.gotDesks();
			desks[desk-1] = removeStrings(desks[desk-1],appId);
			memberQuery.importDesks(desks);
			memberQuery.setDock(insertStrings(memberQuery.getDock(),-1,to, id));
			memberService.update(memberQuery);
		}else if("desk-desk".equals(movetype)){
			if(desk.intValue() == 6){
				logger.error("home桌面不能放置应用！");
			}
			String[] desks = memberQuery.gotDesks();
			desks[desk-1] = insertStrings(desks[desk-1],from,to,id);
			memberQuery.importDesks(desks);
			memberService.update(memberQuery);
		}else if("folder-folder".equals(movetype)){
			memberAppQuery.setFolderId(to.longValue());
			update(memberAppQuery);
		}else if("desk-otherdesk".equals(movetype)){
			if(otherdesk.intValue() == 6){
				logger.error("home桌面不能放置应用！");
			}
			String[] desks = memberQuery.gotDesks();
			desks[desk-1] = removeStrings(desks[desk-1],appId);
			desks[otherdesk-1] = insertStrings(desks[otherdesk-1],-1,to,id);
			memberQuery.importDesks(desks);
			memberService.update(memberQuery);
		}else if("folder-desk".equals(movetype)){
			if(desk.intValue() == 6){
				logger.error("home桌面不能放置应用！");
			}
			memberAppQuery.setFolderId(0l);
			update(memberAppQuery);
			String[] desks = memberQuery.gotDesks();
			desks[desk-1] = insertStrings(desks[desk-1],-1,to,id);
			memberQuery.importDesks(desks);
			memberService.update(memberQuery);
		}else if("folder-dock".equals(movetype)){
			memberAppQuery.setFolderId(0l);
			update(memberAppQuery);
			memberQuery.setDock(insertStrings(memberQuery.getDock(),-1,to, id));
			memberService.update(memberQuery);
		}else{
			String docks =  memberQuery.getDock();
			String desks[] =  memberQuery.gotDesks();
			boolean flag = false;
			if(docks!=null){
				docks = removeStrings(docks, appId);
				if(!docks.equals(memberQuery.getDock())){
					memberQuery.setDock(docks);
					flag = true;
				}
			}
			if(!flag){
				for(int i = 0; i<desks.length;i++){
					String ds = desks[i];
					if(ds!=null){
						String s = ds;
						ds = removeStrings(ds, appId);
						if(!s.equals(ds)){
							flag = true;
							desks[i] = ds;
							break;
						}
					}
				}
			}
			Integer todesk = otherdesk;
			todesk = todesk -1;
			desks[todesk] = (desks[todesk]==null || desks[todesk].length() == 0) ? appId : desks[todesk]+","+appId;
			memberQuery.importDesks(desks);
			memberService.update(memberQuery);
			if(!flag){
				memberAppQuery.setFolderId(0L);
				update(memberAppQuery);
			}
		}
		
	}
	
	@Override
	public void delApp(MemberAppQuery memberAppQuery) {
		MemberApp memberApp = get(memberAppQuery.getTbid().toString());
		MemberQuery memberQuery = memberService.getCurMemberQuery();
		String dock = memberQuery.getDock();
		String[] desks = memberQuery.gotDesks();
		if(memberApp!=null && memberApp.getMemberId().equals(memberQuery.getTbid())){
			if("folder".equals(memberApp.getType())){
				//删除文件夹中的app
				MemberAppQuery query = new MemberAppQuery();
				query.setFolderId(memberApp.getTbid());
				query.setMemberId(memberApp.getMemberId());
				List<MemberAppQuery> list = listAll(query);
				if(list!=null&&list.size()>0){
					Long[] ids = new Long[list.size()];
					for(int i = 0,l=list.size(); i<l;i++){
						ids[i]=list.get(i).getTbid();
					}
					delete(ids);
					for(Long appId : ids){
						dock = removeStrings(dock, appId.toString());
						for(int j = 0;j<desks.length;j++){
							desks[j]=removeStrings(desks[j], appId.toString());
						}
					}
				}
			}
			//删除当前app
			dock = removeStrings(dock, memberApp.getTbid().toString());
			for(int j = 0;j<desks.length;j++){
				desks[j]=removeStrings(desks[j],  memberApp.getTbid().toString());
			}
			memberQuery.setDock(dock);
			memberQuery.importDesks(desks);
			Long ids[] = new Long[1];
			ids[0]=memberApp.getTbid();
			delete(ids);
			memberService.update(memberQuery);
		}
		
		
	}
	
	// ---------------------------------辅助方法---------------------------------------
	private List<Long> stringsToList(String strings){
		List<Long> list = new ArrayList<Long>(); 
		if(strings!=null && strings.trim().length()>0){
			String[] array = strings.split(",");
			for(String s : array){
				if(s.trim().length()>0){
					list.add(Long.parseLong(s.trim()));
				}
			}
		}
		return list;
	}
	private String listToStrings(List list){
		StringBuffer buffer = new StringBuffer();
		if(list!=null && list.size()>0){
			for(Object o :list){
				buffer.append(o.toString()).append(",");
			}
		}
		String s = buffer.length()>0?buffer.substring(0, buffer.length()-1):"";
		return s;
	}
	private String removeStrings(String strings , String s){
		if(strings!=null){
			strings = ","+strings+",";
			strings = strings.replaceAll(","+s+",",",");
			if(strings.length()>1){
				strings = strings.substring(1, strings.length()-1);
			}else{
				strings = "";
			}
		}
		return strings;
	}
	private String insertStrings(String strings , int from, int to, long appId){
		List<Long> list = stringsToList(strings);
		if(from>-1){
			list.remove(from);
		}
		if(to>-1){
			if(list.size()<to){
				list.add(list.size(),appId);
			}else{
				list.add(to,appId);
			}
		}else{
			list.add(list.size(),appId);
		}
		return listToStrings(list);
	}
	// ---------------------------------辅助方法 结束---------------------------------------

	@Override
	public Map findMyApp() {
		Member member = memberService.getCurMember();
		MemberAppQuery memberAppQuery = new MemberAppQuery();
		memberAppQuery.setMemberId(member.getTbid());
		List<MemberAppQuery> list = listAll(memberAppQuery);
		MemberQuery memberQuery = new MemberQuery();
		PropertyUtils.copyProperties(memberQuery, member);
		String docks =  member.getDock();
		Map returnMap = new HashMap();
		List<MemberAppQuery> dockList = new ArrayList<MemberAppQuery>();
		String[] desks = memberQuery.gotDesks();
		for(Long l : stringsToList(docks)){
			 for(MemberAppQuery query:list){
				 if(l.longValue() == query.getRealid().longValue()){
					 initLocalMsg(query);
					 dockList.add(query);
					 break;
				 }
			 }
		}
		returnMap.put("dock", dockList);
		for(int i = 0 ; i < desks.length;i++){
			String apps = desks[i];
			List<MemberAppQuery> deskList = new ArrayList<MemberAppQuery>();
			List<Long> listApp = stringsToList(apps);
			for(Long l : listApp){
				for(MemberAppQuery query:list){
					if(l.longValue() == query.getTbid().longValue()){
						 initLocalMsg(query);
						deskList.add(query);
						break;
					}
				}
			}
			returnMap.put("desk"+(i+1), deskList);
		}
		return returnMap;
	}
	private void initLocalMsg(MemberAppQuery memberAppQuery){
		if(memberAppQuery!=null && memberAppQuery.getCode()!=null){
			//FIXME 国际化
//			memberAppQuery.setLocalName(HroisMessage.getMessage("res."+memberAppQuery.getCode(),memberAppQuery.getName()));
		}
	}
	private void initLocalMsg(MemberApp memberApp){
		if(memberApp!=null && memberApp.gotCode()!=null){
			//FIXME 国际化
//			memberApp.setLocalName(HroisMessage.getMessage("res."+memberApp.getCode(),memberApp.getName()));
		}
	}
	private void initLocalMsg(List<MemberAppQuery> memberAppQueries){
		if(memberAppQueries!=null){
			for(MemberAppQuery memberAppQuery:memberAppQueries){
				initLocalMsg(memberAppQuery);
			}
		}
	}
}
