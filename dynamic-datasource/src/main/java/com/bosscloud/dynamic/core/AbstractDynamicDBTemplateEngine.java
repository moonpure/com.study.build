package com.bosscloud.dynamic.core;

import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.FileOutConfig;
import com.baomidou.mybatisplus.generator.config.TemplateConfig;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.FileType;
import com.baomidou.mybatisplus.generator.engine.AbstractTemplateEngine;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public abstract class AbstractDynamicDBTemplateEngine  extends AbstractTemplateEngine{
   private Map<String, Object> appendMap=new HashMap<>();
   public void appendMap(String mapKey,Object mapValue)
   {
       appendMap.put(mapKey,mapValue);
   }
    @Override
   public AbstractTemplateEngine batchOutput() {
        try {
            List<TableInfo> tableInfoList = this.getConfigBuilder().getTableInfoList();
            Iterator var2 = tableInfoList.iterator();

            while(var2.hasNext()) {
                TableInfo tableInfo = (TableInfo)var2.next();
                Map<String, Object> objectMap = this.getObjectMap(tableInfo);
                Map<String, String> pathInfo = this.getConfigBuilder().getPathInfo();
                TemplateConfig template = this.getConfigBuilder().getTemplate();
                InjectionConfig injectionConfig = this.getConfigBuilder().getInjectionConfig();
                if (null != injectionConfig) {
                    injectionConfig.initTableMap(tableInfo);
                    objectMap.put("cfg", injectionConfig.getMap());
                    List<FileOutConfig> focList = injectionConfig.getFileOutConfigList();
                    if (CollectionUtils.isNotEmpty(focList)) {
                        Iterator var9 = focList.iterator();

                        while(var9.hasNext()) {
                            FileOutConfig foc = (FileOutConfig)var9.next();
                            if (this.isCreate(FileType.OTHER, foc.outputFile(tableInfo))) {
                                this.writer(objectMap, foc.getTemplatePath(), foc.outputFile(tableInfo));
                            }
                        }
                    }
                }

                if(appendMap!=null&&appendMap.size()>0)
                {
                    objectMap.putAll(appendMap);
                }

                String entityName = tableInfo.getEntityName();
                String controllerFile;
                if (null != entityName && null != pathInfo.get("entity_path")) {
                    controllerFile = String.format((String)pathInfo.get("entity_path") + File.separator + "%s" + this.suffixJavaOrKt(), entityName);
                    if (this.isCreate(FileType.ENTITY, controllerFile)) {
                        this.writer(objectMap, this.templateFilePath(template.getEntity(this.getConfigBuilder().getGlobalConfig().isKotlin())), controllerFile);
                    }
                }

                if (null != tableInfo.getMapperName() && null != pathInfo.get("mapper_path")) {
                    controllerFile = String.format((String)pathInfo.get("mapper_path") + File.separator + tableInfo.getMapperName() + this.suffixJavaOrKt(), entityName);
                    if (this.isCreate(FileType.MAPPER, controllerFile)) {
                        this.writer(objectMap, this.templateFilePath(template.getMapper()), controllerFile);
                    }
                }

                if (null != tableInfo.getXmlName() && null != pathInfo.get("xml_path")) {
                    controllerFile = String.format((String)pathInfo.get("xml_path") + File.separator + tableInfo.getXmlName() + ".xml", entityName);
                    if (this.isCreate(FileType.XML, controllerFile)) {
                        this.writer(objectMap, this.templateFilePath(template.getXml()), controllerFile);
                    }
                }

//                if (null != tableInfo.getServiceName() && null != pathInfo.get("service_path")) {
//                    controllerFile = String.format((String)pathInfo.get("service_path") + File.separator + tableInfo.getServiceName() + this.suffixJavaOrKt(), entityName);
//                    if (this.isCreate(FileType.SERVICE, controllerFile)) {
//                        this.writer(objectMap, this.templateFilePath(template.getService()), controllerFile);
//                    }
//                }

                if (null != tableInfo.getServiceImplName() && null != pathInfo.get("service_impl_path")) {
                    controllerFile = String.format((String)pathInfo.get("service_impl_path") + File.separator + tableInfo.getServiceImplName() + this.suffixJavaOrKt(), entityName);
                    if (this.isCreate(FileType.SERVICE_IMPL, controllerFile)) {
                        this.writer(objectMap, this.templateFilePath(template.getServiceImpl()), controllerFile);
                    }
                }

                if (null != tableInfo.getControllerName() && null != pathInfo.get("controller_path")) {
                    controllerFile = String.format((String)pathInfo.get("controller_path") + File.separator + tableInfo.getControllerName() + this.suffixJavaOrKt(), entityName);
                    if (this.isCreate(FileType.CONTROLLER, controllerFile)) {
                        this.writer(objectMap, this.templateFilePath(template.getController()), controllerFile);
                    }
                }
            }
        } catch (Exception var11) {
            logger.error("无法创建文件，请检查配置信息！", var11);
        }

        return this;
    }
}