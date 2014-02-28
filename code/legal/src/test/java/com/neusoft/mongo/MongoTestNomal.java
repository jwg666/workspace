package com.neusoft.mongo;

import java.net.UnknownHostException;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

public class MongoTestNomal {
	private Logger logger = LoggerFactory.getLogger(getClass());
	private Mongo mongo;
	private DB db;
	@Before
	public void init(){
        try {			
	         mongo = new Mongo("115.28.33.228",27017);	
	         db = mongo.getDB("testdb");
		} catch (UnknownHostException e) {
			logger.error("无法连接mongodb",e);
		}
		
	}
	@Test
	public void testMongo(){		
		//查询所有的Database
		for (String name : mongo.getDatabaseNames()) {
            logger.debug("dbName: " + name);
        }
		 //查询所有的聚集集合		
        for (String name : db.getCollectionNames()) {
        	logger.debug("collectionName: " + name);
        }
		
		DBCollection dbc = db.getCollection("person");
		DBCursor cursor =  dbc.find();
		logger.debug("所有数据:"+cursor.count());

		DBObject dbObject = new BasicDBObject("id","000000000000000000001001");
		
		cursor =  dbc.find(dbObject);
		DBObject db2;
		while (cursor.hasNext()) {
			db2 = (DBObject) cursor.next();
			logger.debug(db2.get("id").toString());
		}
		
		cursor.close();
	}
	@After
	public void dispose(){
		if(mongo!=null){
			if(db!=null){
				db = null;
			}
			mongo.close();
			
		}
	}
}
