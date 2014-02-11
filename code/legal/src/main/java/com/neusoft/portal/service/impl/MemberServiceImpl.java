package com.neusoft.portal.service.impl;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neusoft.base.common.LoginContextHolder;
import com.neusoft.base.common.Pager;
import com.neusoft.base.common.PropertyUtils;
import com.neusoft.base.model.DataGrid;
import com.neusoft.portal.dao.MemberDao;
import com.neusoft.portal.model.Member;
import com.neusoft.portal.query.MemberQuery;
import com.neusoft.portal.service.MemberService;
import com.neusoft.security.dao.UserInfoDAO;
import com.neusoft.security.domain.User;
import com.neusoft.security.domain.UserInfo;
@Service("memberService")
@Transactional
public class MemberServiceImpl implements MemberService{
	@Resource
	private MemberDao memberDao;
	@Resource
	private UserInfoDAO userInfoDAO;
	
	public void setMemberDao(MemberDao dao) {
		this.memberDao = dao;
	}

	@Override
	public DataGrid datagrid(MemberQuery memberQuery) {
		DataGrid j = new DataGrid();
		Pager<Member> pager  = find(memberQuery);
		j.setRows(getQuerysFromEntitys(pager.getRecords()));
		j.setTotal(pager.getTotalRecords());
		return j;
	}

	private List<MemberQuery> getQuerysFromEntitys(List<Member> members) {
		List<MemberQuery> memberQuerys = new ArrayList<MemberQuery>();
		if (members != null && members.size() > 0) {
			for (Member tb : members) {
				MemberQuery b = new MemberQuery();
				BeanUtils.copyProperties(tb, b);
				memberQuerys.add(b);
			}
		}
		return memberQuerys;
	}

	private Pager<Member> find(MemberQuery memberQuery) {
		return  memberDao.findPage(memberQuery);
		
	}
	


	@Override
	public void add(MemberQuery memberQuery) {
		Member t = new Member();
		BeanUtils.copyProperties(memberQuery, t);
		memberDao.save(t);
		memberQuery.setTbid(t.getTbid());
	}

	@Override
	public void update(MemberQuery memberQuery) {
		Member t = memberDao.getById(memberQuery.getTbid());
	    if(t != null) {
	    	BeanUtils.copyProperties(memberQuery, t);
		}
	    memberDao.update(t);
	}

	@Override
	public void delete(java.lang.Long[] ids) {
		if (ids != null) {
			for(java.lang.Long id : ids){
				Member t = memberDao.getById(id);
				if (t != null) {
					memberDao.delete(t);
				}
			}
		}
	}

	@Override
	public Member get(MemberQuery memberQuery) {
//		if( memberQuery != null && memberQuery.getTbid()!=null && !"".equals(memberQuery.getTbid()) ){
			return memberDao.getById(Long.valueOf(memberQuery.getTbid()));
//		} else {
//			return null;
//		}
	}

	@Override
	public Member get(String id) {
		return memberDao.getById(Long.parseLong(id));
	}

	
	@Override
	public List<MemberQuery> listAll(MemberQuery memberQuery) {
	    List<Member> list = memberDao.findList(memberQuery);
		List<MemberQuery> listQuery =getQuerysFromEntitys(list) ;
		return listQuery;
	}

	@Override
	public Member getCurMember() {
		UserInfo user = userInfoDAO.get(LoginContextHolder.get().getUserId());
		if(user.getMemberId() == null){return null;}
		return get(user.getMemberId().toString());
	}

	@Override
	public MemberQuery getCurMemberQuery() {
		Member member = getCurMember();
		if(member == null){return null;}
		MemberQuery memberQuery = new MemberQuery(); 
		PropertyUtils.copyProperties(memberQuery,member );
		return memberQuery;
	}

	@Override
	public MemberQuery createDefault(MemberQuery memberQuery) {
		UserInfo user = userInfoDAO.get(LoginContextHolder.get().getUserId());
		MemberQuery tmpMemberQuery = memberQuery;
		if(tmpMemberQuery == null){
		    tmpMemberQuery = new MemberQuery();
		}
		tmpMemberQuery.setDockpos("right");
		tmpMemberQuery.setAppxy("x");
		tmpMemberQuery.setSkin("default");
//			memberQuery.setType(null)
		tmpMemberQuery.setWallpaperId(4);
		tmpMemberQuery.setWallpaperstate(1);
		tmpMemberQuery.setWallpapertype("pingpu");
		tmpMemberQuery.setDesknum(3);
		tmpMemberQuery.setDeskname1("桌面1");
		tmpMemberQuery.setDeskname2("桌面2");
		tmpMemberQuery.setDeskname3("桌面3");
		add(tmpMemberQuery);
		user.setMemberId(tmpMemberQuery.getTbid());
		userInfoDAO.update(user);
		return tmpMemberQuery;
	}
	
	
}
