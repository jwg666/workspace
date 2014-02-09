package com.neusoft.base.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;


public class HBaseDAO<T> {
	@Resource
	private SessionFactory sessionFactory;
//	private Session session ;
	
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	public Long save(Object obj){		
		return (Long) getSession().save(obj);
	}
	
	public void saveOrUpdate(Object obj){
		getSession().saveOrUpdate(obj);
	}
	
	public void update(Object obj){
		getSession().update(obj);
	}
	@SuppressWarnings("unchecked")
	public List<T> findList(Class<T> claz){
		return getSession().createCriteria(claz).list();
	}
	@SuppressWarnings("unchecked")
	public List<T> findList(int begin, int pageSize,String hql){
		Query query = getSession().createQuery(hql);
		query.setFirstResult(begin);
		query.setMaxResults(pageSize);
		return query.list();
	}
	@SuppressWarnings("unchecked")
	public List<T> findList(int begin, int pageSize,String hql,Object[] params){
		Query q = getSession().createQuery(hql);
		if(params.length>0){
			for(int i=0;i<params.length;i++)
			q.setParameter(i, params[i]);
		}
		q.setFirstResult(begin);
		q.setMaxResults(pageSize);
		//log.warn(q.list().size());
		return q.list();
	}
	@SuppressWarnings("unchecked")
	public List<T> findList(String hql,int begin,int pageSize,Map<String,Object> params){
		Query q = getSession().createQuery(hql);
		if(params!=null&&params.size()>0){
			Iterator<Entry<String,Object>> it = params.entrySet().iterator();
			while (it.hasNext()) {
				Entry<String,Object> e = it.next();
				q.setParameter(e.getKey(), e.getValue());
			}
		}
		q.setFirstResult(begin);
		q.setMaxResults(pageSize);
		//log.warn(q.list().size());
		return q.list();
	}	
	public Criteria getCriteria(Class<T> claz){
		return getSession().createCriteria(claz);
	}
	public void delete(Object object){
		getSession().delete(object);
	}
	@SuppressWarnings("unchecked")
	public List<T> findList(Class<T> claz,Map<String,Object> map){
		Criteria c = getSession().createCriteria(claz);
		if(map!=null&&map.size()>0){
			Iterator<Entry<String,Object>> it = map.entrySet().iterator();
			while (it.hasNext()) {
				Entry<String,Object> e = it.next();
				c.add(Restrictions.eq(e.getKey(), e.getValue()));
			}
		}		
		return c.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<T> findList(Class<T> claz,Map<String,Object> map,int begin,int pageSize){
		Criteria c = getSession().createCriteria(claz);
		if(map!=null&&map.size()>0){
			Iterator<Entry<String,Object>> it = map.entrySet().iterator();
			while (it.hasNext()) {
				Entry<String,Object> e = it.next();
				c.add(Restrictions.eq(e.getKey(), e.getValue()));
			}
		}
		c.setFirstResult(begin);
		c.setMaxResults(pageSize);
		return c.list();
	}
	public  Object getById(Class<T> claz,Long id){
		return getSession().get(claz, id);
	}
	public  Object getById(Class<T> claz,Integer id){
		return getSession().get(claz, id);
	}
	public  Object getById(Class<T> claz,String id){
		return getSession().get(claz, id);
	}
	public long getTotalCount(Class<T> claz,Map map){
		Criteria c = getSession().createCriteria(claz);
		if(map!=null&&map.size()>0){
			Iterator<Entry<String,Object>> it = map.entrySet().iterator();
			while (it.hasNext()) {
				Entry<String,Object> e = it.next();
				c.add(Restrictions.eq(e.getKey(), e.getValue()));
			}
		}
		c.setProjection(Projections.rowCount());
		
		return (Long)c.uniqueResult();
	}
}
