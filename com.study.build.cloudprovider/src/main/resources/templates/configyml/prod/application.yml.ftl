server:
port: 0
spring:
application:
name: ${artifactId}
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
eureka:
client:
service-url:
defaultZone: http://localhost:8100/eureka/