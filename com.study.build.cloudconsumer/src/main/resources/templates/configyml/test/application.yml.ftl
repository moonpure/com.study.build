server:
  port: 0
spring:
  application:
    name: ${artifactId}-test
  profiles:
    active: @maven.env@
  redis:
    host: localhost
    password:
    port: 6379
  datasource:
    driverClassName: com.mysql.cj.jdbc.Driver
    name: ${tableSchema}
    url: jdbc:mysql://localhost:3306/${tableSchema}?serverTimezone=UTC&characterEncoding=utf8&useUnicode=true&useSSL=false&serverTimezone=Asia/Shanghai
    username: root
    password:
#配置mybatis
mybatisPlus:
  #打印日志
  configuration:
     logImpl: org.apache.ibatis.logging.stdout.StdOutImpl
eureka:
   client:
      service-url:
         defaultZone: http://localhost:8100/eureka/
feignconfig:
   providename: codegen-build-cloudprovider-test