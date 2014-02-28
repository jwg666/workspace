package com.neusoft.mongo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.data.mongodb.core.MongoOperations;

//import org.springframework.data.mongodb.core.MongoTemplate;









import com.neusoft.base.common.DateUtils;
import com.neusoft.mongo.model.MongoDBFile;

import base.BaseTestCase;

public class MongoSpringTest2 extends BaseTestCase{
	@Resource
	private MongoOperations mongoOperations;
//	public void 
	@Test
	public void testMongo(){
//		mongoOperations.createCollection("msg");
//		Msg msg = new Msg();	
//		msg.setId("111111");
//		msg.setTitle("第二条测试数据");
//		msg.setContent("大家好，欢迎大家");
//		mongoOperations.save(msg);
//		mongoOperations.createCollection(Msg.class);
		
//		Msg msg = mongoOperations.findById("111111", Msg.class);
//	    logger.debug(msg.getTitle()+"||"+msg.getContent());
		File tempFile = new File("E:/1.jpg");
		MongoDBFile file = new MongoDBFile();
		file.setId(UUID.randomUUID().toString());
		file.setCreateTime(DateUtils.format(DateUtils.FORMAT5, new Date()));
		file.setFileName(tempFile.getName());
		file.setDescription("image/png");
		
		FileInputStream fios;
		try {
			fios = new FileInputStream(tempFile);
			byte[] b = new byte[new Long(tempFile.length()).intValue()];
			fios.read(b);
			file.setContent(b);
			mongoOperations.save(file);
//			mongoOperations.s
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
