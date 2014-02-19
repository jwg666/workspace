package com.neusoft.mongo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.MongoDbFactory;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoDbFactory;

import com.mongodb.MongoClient;

@Configuration
public class SpringMongoConfig2 {
	public @Bean	MongoDbFactory mongoDbFactory() throws Exception {
		return new SimpleMongoDbFactory(new MongoClient("115.28.33.228",27017), "testdb");
	}
 
	public @Bean	MongoOperations mongoOperations() throws Exception { 
		MongoTemplate mongoTemplate = new MongoTemplate(mongoDbFactory()); 		
		return (MongoOperations)mongoTemplate; 
	}
}
