server:
port: 0
spring:
application:
name: ${artifactId}-dev
profiles:
active: @maven.env@
redis:
host: localhost
password:
port: 6379
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
feignconfig:
providename: codegen-provider-dev