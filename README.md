## 目标:  
生成真接可运行项目  
## 功能:  
1.生成springboot  
2.生成springcloud provider  
3.生成springcloud consumer  
使用模板引擎(freemarker)、mybatis-plus生成java完整项目(springboot、springcloud),包括pom、Application、controller、service、yml,
mybatis-plus的mapper、entity、dbservice、mapper.xml.  
## 实现原理
通过模板引擎(freemarker)读取模板文件写指定文件到指定目录(根据项目文件组织型式),主要实再类是 'FreeMarkerServiceImpl' 读、写。如写文件目录
不正确，请调整文件目录结构。为了简化，数据库操作部份用mybatis-plus-generator生成，其它项目文件使用 'FreeMarkerServiceImpl' 生成.  
## 项目组成
git有以下独立项目(可分别独立使用),只是把项目合到一git管理.  
--com.study.build.    
-----com.study.build.codegenboot 生成springboot项目.   
-----com.study.build.cloudprovider 生成springcloud provider项目.   
-----com.study.build.cloudconsumer 生成springcloud consumer项目.  
-----com.study.build.cloudeureka  注册中心
## 项目使用
GeneratorServiceImpl类包含了生成方法，buildCodegen()方法会生成整个项目，里面分别调用不同项目文件生成.
## 项目逻辑
1.项目本身使用springboot,mybatis-plus,本身的ORM也由mybatis-plus-generator生成,表结构信息通过mysql的information_schema库查询，两个实体Tables,Columns
对应information_schema中的表，如mysql版本表结构不同，则可做对应修改.  
2.项目配置，项目中ReadConfigServiceImpl读取配置使用. 数据库配置读取information_schema中表结构信息。  
--buildconfig:  
-----packageName: 包名  
-----artifactName: CodegenBuildBoot  
-----artifactId: codegen-build-boot  
-----springBootVersion: springboot版本号  
-----projectVersion: 生成项目版本号  
-----saveDir: 生成项目保存目录   
-----tableSchema: 数据库架构名(库名)  
3.项目结构  
--src.main  
-----java.com.study.build.codegenboot  
--------core 通用、工具目录  
--------dao  mybatis-plus-generator生成的数据库操作目录mapper,dbmodel,dbservice  
--------service 项目逻目录  
-----service  
--------mapper  数据库mapper.xml目录  
--------templates 项目模板   
4.运行逻辑  
GeneratorServiceImpl类中生成方法,mybatis-plus-generator生成通过MybatisPlusGeneratorServiceImpl类实现，
项目的其它实现使用FreeMarkerServiceImpl.
## 二次开发
项目使用FreeMarker模板引擎，其它模板引擎参考FreeMarkerServiceImpl实现。也可参考mybatis-plus-generator生成逻辑。  
生成项目的组织架构更改参考GeneratorServiceImpl。  
项目中以简单为主，实现不足、建义、交流
# ---tag功能---
项目中通过tag区分项目板本及功能列表
## tag 1.0.0
1.springboot 项目生成.   
2.数库增、删、改、分页查询.   
3.优化mysql分页查询，传入上次最大id，查询大于id(如传入). 
## tag 1.1.0
1.springcloud provider  项目生成  
2.增加cloudeureka 注册中心，方便测式cloud
## tag 1.2.0
1. springcloud consumer 项目生成  
2. springcloud consumer entity生成
## tag 1.3.0
1. springcloud provider 生成test
2. springcloud provider 使用mybatis id生成器
## tag 1.4.0
1. springcloud consumer 生成test
2. springcloud provider 使用spring cache
