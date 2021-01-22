package com.bosscloud.dynamic;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan({"com.bosscloud.dynamic.dao.dbmapper"})
public class DynamicDataSourceApplication {
    public static void main(String[] args) {
        SpringApplication.run(DynamicDataSourceApplication.class, args);
    }
}
