package com.bosscloud.dynamic.service;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.po.TableFill;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import com.bosscloud.dynamic.core.FreemarkerDynamicDBTemplateEngine;
import com.bosscloud.dynamic.core.ReadConfigServiceImpl;
import com.zaxxer.hikari.HikariConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;

@Component
public class MybatisPlusGeneratorServiceImpl {
    @Autowired
    DataSource dataSource;


    public void buildDbMapper(ReadConfigServiceImpl readConfigService, List<String> tableNames) {


        // 自定义需要填充的字段
        List<TableFill> tableFillList = new ArrayList<TableFill>();
        TableFill sysCreateTime = new TableFill("create_time", FieldFill.INSERT);
        TableFill sysUpdateTime = new TableFill("update_time", FieldFill.INSERT_UPDATE);
        tableFillList.add(sysCreateTime);
        tableFillList.add(sysUpdateTime);
        tableFillList.add(new TableFill("id", FieldFill.INSERT));

        StrategyConfig strategyConfig = new StrategyConfig();
        strategyConfig.setCapitalMode(true)
                .setEntityLombokModel(true)
                .setColumnNaming(NamingStrategy.underline_to_camel)
                .setNaming(NamingStrategy.underline_to_camel)
                .setVersionFieldName("version")
                .setLogicDeleteFieldName("deleted")
                //.setTableFillList(tableFillList)
                .setInclude(tableNames.toArray(new String[tableNames.size()]));//修改替换成你需要的表名，多个表名传数组


        GlobalConfig config = new GlobalConfig();
        config.setActiveRecord(false)
                .setAuthor("mybatisplusAutogenerator")
                .setOutputDir(readConfigService.getSaveDir() + "/" + GeneratorServiceImpl.getSrcDir() + "/")
                .setFileOverride(true)
                .setOpen(false)
                .setBaseResultMap(false)
                .setBaseColumnList(false)
               // .setServiceName("Db%sService")
                .setServiceImplName("Db%sServiceImpl")

                // .setControllerName("%sController")
                .setIdType(IdType.INPUT);
//        if (!serviceNameStartWithI) {
//            config.setServiceName("%sService");
//        }

//        InjectionConfig injectionConfig = new InjectionConfig() {
//            @Override
//            public void initMap() {
//            }
//        };
        // 调整 xml 生成目录
//        List<FileOutConfig> focList = new ArrayList<FileOutConfig>();
//        focList.add(new FileOutConfig("/templates/mapper.xml.ftl") {
//            @Override
//            public String outputFile(TableInfo tableInfo) {
//                return readConfigService.getSaveDir()+"/"+ GeneratorServiceImpl.getMapperDir() +"/"+tableInfo.getEntityName() + "Mapper.xml";
//            }
//        });
//        injectionConfig.setFileOutConfigList(focList);

        // 关掉默认的xml生成脚本
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setXml(null);
        templateConfig.setController(null);

        FreemarkerDynamicDBTemplateEngine freemarkerTemplateEngine = new FreemarkerDynamicDBTemplateEngine();
        freemarkerTemplateEngine.appendMap("dbDataSource",readConfigService.getDbDataSource());


        HikariConfig hikariConfig = (HikariConfig) dataSource;
        DataSourceConfig dataSourceConfig = new DataSourceConfig();
        dataSourceConfig.setDbType(DbType.MYSQL)
                .setUrl(hikariConfig.getJdbcUrl().replace("information_schema", readConfigService.getTableSchema()))
                .setUsername(hikariConfig.getUsername())
                .setPassword(hikariConfig.getPassword())
                .setDriverName(hikariConfig.getDriverClassName());


        PackageConfig packageConfig = getPackageConfig(readConfigService.getPackageName(),readConfigService);

        AutoGenerator autoGenerator = new AutoGenerator().setGlobalConfig(config)
                .setDataSource(dataSourceConfig)
                .setStrategy(strategyConfig)
                .setPackageInfo(packageConfig)
                // .setCfg(injectionConfig)
                .setTemplate(templateConfig)
                .setTemplateEngine(freemarkerTemplateEngine);
        autoGenerator.execute();

    }

    /**
     * 设置包名
     *
     * @param packageName 父路径包名
     * @param packageName 模块名
     * @return PackageConfig 包名配置
     * @author Terry
     */
    private PackageConfig getPackageConfig(String packageName,ReadConfigServiceImpl readConfigService) {
        return new PackageConfig()
                .setParent(packageName)
                .setXml("mapper.xml")
                .setMapper("dao.dbmapper."+readConfigService.getDbDataSource())//改名，加模快
                // .setController("controller")
                .setService("")
             //   .setService("dao.dbservice."+readConfigService.getDbDataSource())
                .setServiceImpl("dao.dbservice."+readConfigService.getDbDataSource())
                .setEntity("dao.dbmodel."+readConfigService.getDbDataSource());
    }
}


