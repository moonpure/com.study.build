server:
  port: 0
spring:
  application:
    name: ${artifactId}-preprod
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
feignconfig:
   providename: codegen-provider-preprod