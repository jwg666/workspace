package com.neusoft.mongo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.config.AbstractMongoConfiguration;

import com.mongodb.Mongo;
import com.mongodb.MongoClient;
@Configuration
public class SpringMongoConfig1 extends AbstractMongoConfiguration{

	@Override
	protected String getDatabaseName() {		
		return "testdb";
	}

	@Override
	@Bean
	public Mongo mongo() throws Exception {
		return new MongoClient("115.28.33.228",27017);
	}
	
}
