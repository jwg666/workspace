package com.neusoft.mongo;

import javax.annotation.Resource;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import com.neusoft.mongo.config.SpringMongoConfig2;

public class MongoTest{
	private Logger logger = LoggerFactory.getLogger(getClass());
	private MongoOperations mongoOperations;
	private ApplicationContext ctx;
	@Before
	public void init(){
		ctx = new AnnotationConfigApplicationContext(SpringMongoConfig2.class);  
		mongoOperations = (MongoOperations)ctx.getBean("mongoOperations"); 
	}
	@Test
	public void testMongo(){
//		mongoOperations.createCollection("person");
		logger.debug("-----------------");
		long begin = System.currentTimeMillis();
//		Person p  = new Person();
//		mongoOperations.createCollection(p.getClass());
//	    p.setId("1001");
//	    p.setName("张三");
//		for(int i=1;i<100000;i++){
//			Person p  = new Person();
//		    p.setId("1"+i);
//		    p.setName("张三"+i);
//			mongoOperations.save(p);
//		}
//		Query query = new Query();
//		query.addCriteria(Criteria.where(""));
//		Person person = mongoOperations.findById("1001", Person.class);
//		if(person!=null){
//			logger.debug("==="+person.getName());
//		}
//		Person person = new Person();
//		person.setName("李四");
//		mongoOperations.save(person);
//		
//	    long end = System.currentTimeMillis();
//		logger.debug("----------------");
//		logger.debug("执行命令所用时间:"+(end-begin));
	}
	@After
	public void dispose(){
		mongoOperations = null;
		ctx = null;		
	}
}
