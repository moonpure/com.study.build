<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>${springBootVersion}</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>${packageName}</groupId>
    <artifactId>${artifactId}</artifactId>
    <version>${projectVersion}</version>
    <name>${artifactName}</name>
    <description>${artifactName} project for Spring Boot</description>

    <properties>
        <java.version>1.8</java.version>
        <spring-cloud.version>${springCloudVersion}</spring-cloud.version>
    </properties>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <#noparse><version>${spring-cloud.version}</version></#noparse>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-webflux</artifactId>
        </dependency>

        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
            <exclusions>
                <exclusion>
                    <groupId>org.junit.vintage</groupId>
                    <artifactId>junit-vintage-engine</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
        <dependency>
            <groupId>io.projectreactor</groupId>
            <artifactId>reactor-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-boot-starter</artifactId>
            <version>3.3.1</version>
        </dependency>
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>3.9</version>
        </dependency>
    </dependencies>
    <profiles>
        <profile>
            <id>local</id>
            <properties>
                <maven.env>local</maven.env>
            </properties>
            <!--是否激活 -->
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
        </profile>
        <profile>
            <id>dev</id>
            <properties>
                <maven.env>dev</maven.env>
            </properties>
            <activation>
                <activeByDefault>false</activeByDefault>
            </activation>
        </profile>
        <profile>
            <id>test</id>
            <properties>
                <maven.env>test</maven.env>
            </properties>
            <activation>
                <activeByDefault>false</activeByDefault>
            </activation>
        </profile>

        <profile>
            <id>preprod</id>
            <properties>
                <maven.env>preprod</maven.env>
            </properties>
            <activation>
                <activeByDefault>false</activeByDefault>
            </activation>
        </profile>
        <profile>
            <id>prod</id>
            <properties>
                <maven.env>prod</maven.env>
            </properties>
            <activation>
                <activeByDefault>false</activeByDefault>
            </activation>
        </profile>
    </profiles>
    <repositories>
        <repository>
            <id>nexus-aliyun</id>
            <name>Nexus aliyun</name>
            <url>http://maven.aliyun.com/nexus/content/groups/public</url>
        </repository>
    </repositories>
    <build>
        <finalName>${artifactName}</finalName>
        <resources>
            <resource>
                <directory>src/main/resources</directory>
                <excludes>
                    <exclude>local/*</exclude>
                    <exclude>dev/*</exclude>
                    <exclude>test/*</exclude>
                    <exclude>preprod/*</exclude>
                    <exclude>prod/*</exclude>
                </excludes>
                <filtering>true</filtering>
            </resource>
            <resource>
                <#noparse><directory>src/main/resources/${maven.env}</directory></#noparse>
                <includes>
                    <include>*.yml</include>
                    <include>*.xml</include>
                    <include>*.properties</include>
                </includes>
                <filtering>true</filtering>
            </resource>
        </resources>
        <testResources>
            <testResource>
                <directory>src/main/resources</directory>
                <excludes>
                    <exclude>local/*</exclude>
                    <exclude>dev/*</exclude>
                    <exclude>test/*</exclude>
                    <exclude>preprod/*</exclude>
                    <exclude>prod/*</exclude>
                </excludes>
                <filtering>true</filtering>
            </testResource>
            <testResource>
                <#noparse><directory>src/main/resources/${maven.env}</directory></#noparse>
                <includes>
                    <include>*.yml</include>
                    <include>*.xml</include>
                    <include>*.properties</include>
                </includes>
                <filtering>true</filtering>
            </testResource>
        </testResources>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
