server:
  port: 0
spring:
  application:
    name: ${artifactId}-dev
  profiles:
    active: @maven.env@
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
management:
  endpoints:
    jmx:
      exposure:
        include: "*"
    web:
      exposure:
        include: "*"