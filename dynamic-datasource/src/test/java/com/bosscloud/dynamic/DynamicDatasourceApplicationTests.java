package com.bosscloud.dynamic;

import com.bosscloud.dynamic.core.ReadConfigServiceImpl;
import com.bosscloud.dynamic.service.GeneratorServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DynamicDatasourceApplicationTests {
    @Autowired
    GeneratorServiceImpl generatorService;
    @Autowired
    private ReadConfigServiceImpl readConfigService;
    @Test
    void contextLoads() {
        generatorService.buildPom(readConfigService);
        generatorService.buildApplication(readConfigService);
        generatorService.buildConfigyml(readConfigService);
        generatorService.buildCore(readConfigService);
        generatorService.buildConfig(readConfigService);
        generatorService.buildDataBase(readConfigService);
//        generatorService.buildService(readConfigService);
//        generatorService.buildController(readConfigService);
//        generatorService. buildTest(readConfigService);
    }

}
