package com.bosscloud.dynamic.core;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "buildconfig")
@Getter
@Setter
public class ReadConfigServiceImpl {
    private String groupId= "com.build";
    private String packageName = "com.build.codege.demo";
    private String artifactName = "codegen-build";
    private String artifactId = "codegen-build";
    private String springBootVersion = "2.2.5.RELEASE";
    private String projectVersion = "1.0.0";
    private String saveDir = System.getProperty("user.dir");
    private String tableSchema = "information_schema";
    private String springCloudVersion = "Hoxton.SR3";
    private String appName="BosscoudIntelligence";
    private String dbDataSource="user";

}
