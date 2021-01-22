package com.bosscloud.dynamic.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.bosscloud.dynamic.core.ReadConfigServiceImpl;
import com.bosscloud.dynamic.dao.dbmodel.Columns;
import com.bosscloud.dynamic.dao.dbmodel.Tables;
import com.bosscloud.dynamic.dao.dbservice.DbColumnsServiceImpl;
import com.bosscloud.dynamic.dao.dbservice.DbTablesServiceImpl;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Component
public class GeneratorServiceImpl {

    @Autowired
    FreeMarkerServiceImpl freeMarkerServicel;
    @Autowired
    DbTablesServiceImpl dbTablesService;
    @Autowired
    DbColumnsServiceImpl dbColumnsService;
    @Autowired
    MybatisPlusGeneratorServiceImpl mybatisPlusGeneratorService;
    @Getter
    public static String srcDir = "src" + File.separator + "main" + File.separator + "java";
    @Getter
    public static String srcTestDir = "src" + File.separator + "test" + File.separator + "java";
    @Getter
    public static String mapperDir = "src" + File.separator + "main" + File.separator + "resources" + File.separator + "mapper";
    @Getter
    public static String resourcesDir = "src" + File.separator + "main" + File.separator + "resources";
    @Autowired
    private ReadConfigServiceImpl configService;

    public void buildCodegen() {
        buildCodegen(configService);
    }

    public void buildCodegen(ReadConfigServiceImpl readConfigService) {
        buildPom(readConfigService);
        buildApplication(readConfigService);
        buildConfigyml(readConfigService);
        buildCore(readConfigService);
        buildConfig(readConfigService);
        buildDataBase(readConfigService);
        buildService(readConfigService);
        buildController(readConfigService);
        buildTest(readConfigService);
    }

    /**
     * 生成pom
     *
     * @param readConfigService
     */
    public void buildPom(ReadConfigServiceImpl readConfigService) {
        //封装参数
        Map<String, Object> root = new HashMap<>();
        root.put("packageName", readConfigService.getPackageName());
        root.put("basePackageUrl", readConfigService.getPackageName());
        root.put("groupId",readConfigService.getGroupId());
        //表参数
        root.put("artifactName", readConfigService.getArtifactName());
        root.put("artifactId", readConfigService.getArtifactId());
        root.put("springBootVersion", readConfigService.getSpringBootVersion());
        root.put("projectVersion", readConfigService.getProjectVersion());
        root.put("springCloudVersion", readConfigService.getSpringCloudVersion());

        String rootDirectory = readConfigService.getSaveDir();
        // 生成bean
        freeMarkerServicel.generate(root, "pom.xml.ftl", rootDirectory, "pom.xml");
        freeMarkerServicel.generate(root, ".gitignore.ftl", rootDirectory, ".gitignore");
    }

    /**
     * 生成启动类
     *
     * @param readConfigService
     */
    public void buildApplication(ReadConfigServiceImpl readConfigService) {
        //封装参数
        Map<String, Object> root = new HashMap<>();
        root.put("packageName", readConfigService.getPackageName());
        root.put("basePackageUrl", readConfigService.getPackageName());
        //表参数
        root.put("artifactName", readConfigService.getArtifactName());
        root.put("artifactId", readConfigService.getArtifactId());
        root.put("springBootVersion", readConfigService.getSpringBootVersion());
        root.put("projectVersion", readConfigService.getProjectVersion());
        root.put("appName", readConfigService.getAppName());

        String packageUrl = freeMarkerServicel.getPath(srcDir, readConfigService.getPackageName());
        Path path = Paths.get(readConfigService.getSaveDir(), packageUrl);
        // 生成bean
        freeMarkerServicel.generate(root, "Application.java.ftl", path.toString(), readConfigService.getArtifactName() + "Application.java");
    }

    /**
     * 生成项目中通用
     *
     * @param readConfigService
     */
    public void buildCore(ReadConfigServiceImpl readConfigService) {
        //封装参数
        Map<String, Object> root = new HashMap<>();
        root.put("packageName", readConfigService.getPackageName());

        String packageUrl = freeMarkerServicel.getPath(srcDir, readConfigService.getPackageName(), "core");
        Path path = Paths.get(readConfigService.getSaveDir(), packageUrl);
        // 生成bean
        freeMarkerServicel.generate(root, "core/ResultCode.java.ftl", path.toString(), "ResultCode.java");
        freeMarkerServicel.generate(root, "core/AdviceHandler.java.ftl", path.toString(), "AdviceHandler.java");
        freeMarkerServicel.generate(root, "core/RequestBase.java.ftl", path.toString(), "RequestBase.java");
        freeMarkerServicel.generate(root, "core/RequestIn.java.ftl", path.toString(), "RequestIn.java");
        freeMarkerServicel.generate(root, "core/RequestPage.java.ftl", path.toString(), "RequestPage.java");
        freeMarkerServicel.generate(root, "core/Result.java.ftl", path.toString(), "Result.java");
        freeMarkerServicel.generate(root, "core/FieldFillMetaObjectHandler.java.ftl", path.toString(), "FieldFillMetaObjectHandler.java");
        freeMarkerServicel.generate(root, "core/BetweenBase.java.ftl", path.toString(), "BetweenBase.java");
        freeMarkerServicel.generate(root, "core/RequestBetween.java.ftl", path.toString(), "RequestBetween.java");
        freeMarkerServicel.generate(root, "core/RequestQuery.java.ftl", path.toString(), "RequestQuery.java");
    }

    /**
     * 生成一些配置been
     *
     * @param readConfigService
     */
    public void buildConfig(ReadConfigServiceImpl readConfigService) {
        //封装参数
        Map<String, Object> root = new HashMap<>();
        root.put("packageName", readConfigService.getPackageName());

        String packageUrl = freeMarkerServicel.getPath(srcDir, readConfigService.getPackageName(), "config");
        Path path = Paths.get(readConfigService.getSaveDir(), packageUrl);
        // 生成bean
        //freeMarkerServicel.generate(root, "config/FeignBeanFactoryPostProcessor.java.ftl", path.toString(), "FeignBeanFactoryPostProcessor.java");
        freeMarkerServicel.generate(root, "config/MybatisPlusConfig.java.ftl", path.toString(), "MybatisPlusConfig.java");
        freeMarkerServicel.generate(root, "config/ObjectMappterConfig.java.ftl", path.toString(), "ObjectMappterConfig.java");
        freeMarkerServicel.generate(root, "config/RedisCacheSerializeConfiguration.java.ftl", path.toString(), "RedisCacheSerializeConfiguration.java");
        //freeMarkerServicel.generate(root, "config/WebMvcConfig.java.ftl", path.toString(), "WebMvcConfig.java");
        freeMarkerServicel.generate(root, "config/MybatisPlusIdGeneratorConfig.java.ftl", path.toString(), "MybatisPlusIdGeneratorConfig.java");
    }

    public List<Tables> getTables(ReadConfigServiceImpl readConfigService) {
        QueryWrapper<Tables> tablesQueryWrapper = new QueryWrapper<>();
        tablesQueryWrapper.lambda().eq(Tables::getTableSchema, readConfigService.getTableSchema());
        return dbTablesService.list(tablesQueryWrapper);
    }

    public List<Columns> getColumns(String tableName) {
        QueryWrapper<Columns> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(Columns::getTableName, tableName);
        return dbColumnsService.list(queryWrapper);
    }

    /**
     * 生成mybatis-plus数据库操作类
     *
     * @param readConfigService
     */
    public void buildDataBase(ReadConfigServiceImpl readConfigService) {
        List<Tables> tables = getTables(readConfigService);
        if (tables == null || tables.size() <= 0) {
            return;
        }
        List<String> tableNames = tables.stream().map(Tables::getTableName).collect(Collectors.toList());
        String[] str = tableNames.toArray(new String[tableNames.size()]);
        mybatisPlusGeneratorService.buildDbMapper(readConfigService, tableNames);
    }

    /**
     * 生成service类
     *
     * @param readConfigService
     */
    public void buildService(ReadConfigServiceImpl readConfigService) {
        List<Tables> tables = getTables(readConfigService);
        if (tables == null || tables.size() <= 0) {
            return;
        }
        List<String> tableNames = tables.stream().map(Tables::getTableName).distinct().filter(Objects::nonNull).collect(Collectors.toList());
        //封装参数
        Map<String, Object> root = new HashMap<>();
        root.put("packageName", readConfigService.getPackageName());
        root.put("artifactId", freeMarkerServicel.getEntityName(readConfigService.getArtifactId()));

        String packageUrl = freeMarkerServicel.getPath(srcDir, readConfigService.getPackageName(), "service");
        Path path = Paths.get(readConfigService.getSaveDir(), packageUrl);

        for (String tableName : tableNames) {
            String entityName = freeMarkerServicel.getEntityName(tableName);
            root.put("entityName", entityName);
            freeMarkerServicel.generate(root, "service/ServiceImpl.java.ftl", path.toString(), entityName + "ServiceImpl.java");
        }

    }

    /**
     * 生成contrller
     *
     * @param readConfigService
     */
    public void buildController(ReadConfigServiceImpl readConfigService) {
        List<Tables> tables = getTables(readConfigService);
        if (tables == null || tables.size() <= 0) {
            return;
        }
        List<String> tableNames = tables.stream().map(Tables::getTableName).distinct().filter(Objects::nonNull).collect(Collectors.toList());
        //封装参数
        Map<String, Object> root = new HashMap<>();
        root.put("packageName", readConfigService.getPackageName());


        String packageUrl = freeMarkerServicel.getPath(srcDir, readConfigService.getPackageName(), "controller");
        Path path = Paths.get(readConfigService.getSaveDir(), packageUrl);

        for (String tableName : tableNames) {
            String entityName = freeMarkerServicel.getEntityName(tableName);
            root.put("entityName", entityName);
            root.put("entityNameLower", freeMarkerServicel.getEntityNameLower(tableName));
            freeMarkerServicel.generate(root, "controller/Controller.java.ftl", path.toString(), entityName + "Controller.java");
        }

    }

    /**
     * 生成yml配置文件
     *
     * @param readConfigService
     */

    public void buildConfigyml(ReadConfigServiceImpl readConfigService) {
        //封装参数
        Map<String, Object> root = new HashMap<>();
        root.put("artifactId", readConfigService.getArtifactId());
        root.put("tableSchema", readConfigService.getTableSchema());
        root.put("artifactName", readConfigService.getArtifactName());
        String packageUrl = freeMarkerServicel.getPath(resourcesDir, "local");
        Path path = Paths.get(readConfigService.getSaveDir(), packageUrl);
        freeMarkerServicel.generate(root, "configyml/local/application.yml.ftl", path.toString(), "application.yml");
        freeMarkerServicel.generate(root, "configyml/local/log4j2.xml.ftl", path.toString(), "log4j2.xml");

        packageUrl = freeMarkerServicel.getPath(resourcesDir, "dev");
        path = Paths.get(readConfigService.getSaveDir(), packageUrl);
        freeMarkerServicel.generate(root, "configyml/dev/application.yml.ftl", path.toString(), "application.yml");
        freeMarkerServicel.generate(root, "configyml/dev/log4j2.xml.ftl", path.toString(), "log4j2.xml");

        packageUrl = freeMarkerServicel.getPath(resourcesDir, "test");
        path = Paths.get(readConfigService.getSaveDir(), packageUrl);
        freeMarkerServicel.generate(root, "configyml/test/application.yml.ftl", path.toString(), "application.yml");
        freeMarkerServicel.generate(root, "configyml/test/log4j2.xml.ftl", path.toString(), "log4j2.xml");

        packageUrl = freeMarkerServicel.getPath(resourcesDir, "preprod");
        path = Paths.get(readConfigService.getSaveDir(), packageUrl);
        freeMarkerServicel.generate(root, "configyml/preprod/application.yml.ftl", path.toString(), "application.yml");
        freeMarkerServicel.generate(root, "configyml/preprod/log4j2.xml.ftl", path.toString(), "log4j2.xml");

        packageUrl = freeMarkerServicel.getPath(resourcesDir, "prod");
        path = Paths.get(readConfigService.getSaveDir(), packageUrl);
        freeMarkerServicel.generate(root, "configyml/prod/application.yml.ftl", path.toString(), "application.yml");
        freeMarkerServicel.generate(root, "configyml/prod/log4j2.xml.ftl", path.toString(), "log4j2.xml");
    }

    public void buildTest(ReadConfigServiceImpl readConfigService) {
        //封装参数
        Map<String, Object> root = new HashMap<>();
        root.put("packageName", readConfigService.getPackageName());
        root.put("artifactName", readConfigService.getArtifactName());

        String path = freeMarkerServicel.buildPath(readConfigService.getSaveDir(), srcTestDir, readConfigService.getPackageName());
        // 生成bean
        freeMarkerServicel.generate(root, "test/ApplicationTests.java.ftl", path, readConfigService.getArtifactName() + "ApplicationTests.java");
        List<Tables> tables = getTables(readConfigService);
        if (tables == null || tables.size() <= 0) {
            return;
        }
        path = freeMarkerServicel.buildPath(readConfigService.getSaveDir(), srcTestDir, readConfigService.getPackageName(), "controller");
        //
        for (Tables table : tables) {
            String entityName = freeMarkerServicel.getEntityName(table.getTableName());
            root.put("entityName", entityName);
            root.put("entityNameLower", freeMarkerServicel.getEntityNameLower(table.getTableName()));
            root.put("tableComment", table.getTableComment());
            //取出列集合
            List<Columns> columns = getColumns(table.getTableName());
            if (columns == null || columns.size() < 0) {
                continue;
            }
            columns.parallelStream().forEach(p -> {
                p.setColumnName(freeMarkerServicel.getEntityName(p.getColumnName()));
                p.setColumnDefault(freeMarkerServicel.convertToValue(p.getDataType().toUpperCase()));
                //p.setDataType(freeMarkerServicel.convertToJava(p.getDataType().toUpperCase()));
            });
            root.put("tableColumns", columns);
            freeMarkerServicel.generate(root, "test/ControllerTest.java.ftl", path, entityName + "ControllerTest.java");
        }

    }
}