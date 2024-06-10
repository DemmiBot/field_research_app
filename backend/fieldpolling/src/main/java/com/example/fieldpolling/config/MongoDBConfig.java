package com.example.fieldpolling.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.MongoDatabaseFactory;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoClientDatabaseFactory;

@Configuration
public class MongoDBConfig {
    
    public MongoDatabaseFactory mongoConfigure() {
        return new SimpleMongoClientDatabaseFactory("{MONGO_URI}");
    }

    public MongoTemplate mongoTemplate(){
        return new MongoTemplate(mongoConfigure());
    }
}
