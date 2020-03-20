## 目标:  
生成真接可运行项目  
## 功能:  
使用模板引擎(freemarker)、mybatis-plus生成java完整项目(springboot、springcloud),包括pom、Application、controller、service、yml,
mybatis-plus的mapper、entity、dbservice、mapper.xml.  
## 实现原理
通过模板引擎(freemarker)读取模板文件写指定文件到指定目录(根据项目文件组织型式),主要实再类是 'FreeMarkerServiceImpl' 读、写。如写文件目录
不正确，请调整文件目录结构。为了简化，数据库操作部份用mybatis-plus-generator生成，其它项目文件使用 'FreeMarkerServiceImpl' 生成.  
## 项目组成
git下有三个独立项目(可分别独立使用),只是把三个项目合到一git管理.  
--com.study.build.    
-----com.study.build.codegenboot 生成springboot项目.   
-----com.study.build.cloudprovider 生成springcloud provider项目.   
-----com.study.build.cloudconsumer 生成springcloud consumer项目.   
## 项目使用
GeneratorServiceImpl类包含了生成方法，buildCodegen()方法会生成整个项目，里面分别调用不同项目文件生成.
## 项目逻辑
## 二次开发
# ---tag功能---
项目中通过tag区分项目板本及功能列表
## tag 1.0.0
1.springboot 项目生成.   
2.数库增、删、改、分页查询.   
3.优化mysql分页查询，传入上次最大id，查询大于id(如传入id).  
