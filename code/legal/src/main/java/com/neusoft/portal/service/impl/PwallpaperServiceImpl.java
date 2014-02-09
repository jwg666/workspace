package com.neusoft.portal.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.Pager;
import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.dao.PwallpaperDao;
import com.neusoft.portal.model.Pwallpaper;
import com.neusoft.portal.query.MemberQuery;
import com.neusoft.portal.query.PwallpaperQuery;
import com.neusoft.portal.service.MemberService;
import com.neusoft.portal.service.PwallpaperService;
@Service("pwallpaperService")
@Transactional
public class PwallpaperServiceImpl implements PwallpaperService{
	@Resource
	private PwallpaperDao pwallpaperDao;
	@Resource
	private	MemberService 	memberService;
	
	public void setPwallpaperDao(PwallpaperDao dao) {
		this.pwallpaperDao = dao;
	}

	@Override
	public DataGrid datagrid(PwallpaperQuery pwallpaperQuery) {
		DataGrid j = new DataGrid();
		Pager<Pwallpaper> pager  = find(pwallpaperQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<PwallpaperQuery> getQuerysFromEntitys(List<Pwallpaper> pwallpapers) {
		List<PwallpaperQuery> pwallpaperQuerys = new ArrayList<PwallpaperQuery>();
		if (pwallpapers != null && pwallpapers.size() > 0) {
			for (Pwallpaper tb : pwallpapers) {
				PwallpaperQuery b = new PwallpaperQuery();
				BeanUtils.copyProperties(tb, b);
				pwallpaperQuerys.add(b);
			}
		}
		return pwallpaperQuerys;
	}

	private Pager<Pwallpaper> find(PwallpaperQuery pwallpaperQuery) {
		return  pwallpaperDao.findPage(pwallpaperQuery);
		
	}
	


	@Override
	public void add(PwallpaperQuery pwallpaperQuery) {
		Pwallpaper t = new Pwallpaper();
		BeanUtils.copyProperties(pwallpaperQuery, t);
		pwallpaperDao.save(t);
		pwallpaperQuery.setTbid(t.getTbid());
	}

	@Override
	public void update(PwallpaperQuery pwallpaperQuery) {
		Pwallpaper t = pwallpaperDao.getById(pwallpaperQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(pwallpaperQuery, t);
		}
	    pwallpaperDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				Pwallpaper t = pwallpaperDao.getById(id);
				if (t != null) {
					pwallpaperDao.delete(t);
				}
			}
		}
	}

	@Override
	public Pwallpaper get(PwallpaperQuery pwallpaperQuery) {
		return pwallpaperDao.getById(Long.valueOf(pwallpaperQuery.getTbid()));
	}

	@Override
	public Pwallpaper get(String id) {
		return pwallpaperDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<PwallpaperQuery> listAll(PwallpaperQuery pwallpaperQuery) {
	    List<Pwallpaper> list = pwallpaperDao.findList(pwallpaperQuery);
		List<PwallpaperQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}

	@Override
	public Pwallpaper delete(String id) {
		MemberQuery memberQuery =memberService.getCurMemberQuery();
		Pwallpaper pwallpaper = get(id);
		if(pwallpaper != null && pwallpaper.getMemberId().longValue() == memberQuery.getTbid().longValue()){
			pwallpaperDao.delete(pwallpaper);
			memberQuery.setWallpaperstate(1);
			memberQuery.setWallpaperId(1);
			memberService.update(memberQuery);
			return pwallpaper;
		}else{
			return null;
		}
	}
	
	
}
