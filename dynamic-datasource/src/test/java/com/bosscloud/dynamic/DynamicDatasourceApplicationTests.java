package com.bosscloud.dynamic;

import com.bosscloud.dynamic.core.ReadConfigServiceImpl;
import com.bosscloud.dynamic.service.GeneratorServiceImpl;
import org.assertj.core.groups.Tuple;
import org.javatuples.Triplet;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

@SpringBootTest
class DynamicDatasourceApplicationTests {
    @Autowired
    GeneratorServiceImpl generatorService;
    @Autowired
    private ReadConfigServiceImpl readConfigService;
    @Test
    void contextLoads() {
        List<Triplet<String,String,String>> triplets=getDataBaseConfigOnece();
        if(triplets==null||triplets.size()<=0)
        {
            return;
        }
        for(var triplet:triplets) {
            readConfigService.setTableSchema(triplet.getValue0());
            readConfigService.setDbDataSource(triplet.getValue1());
            readConfigService.setMapperPrefix(triplet.getValue2());

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
    private List<Triplet<String,String,String>> getDataBaseConfigOnece()
    {
        List<Triplet<String,String,String>> dbconfig=new ArrayList<>();
        Triplet<String,String,String> triplet= triplet=new Triplet<>("bosscloud_user","bossuser","User");
        dbconfig.add(triplet);
        return dbconfig;
    }
    private List<Triplet<String,String,String>> getDataBaseConfig()
    {
        List<Triplet<String,String,String>> dbconfig=new ArrayList<>();
        Triplet<String,String,String> triplet=new Triplet<>("bosscloud_activity","bossactivity","Activity");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_business_message","bossbmessage","Bmessage");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_cms_auth","bossauth","Auth");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_commercial","bosscommercial","Commercial");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_information","bossinformation","Information");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_interact","bossinteract","Interact");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_live","bosslive","Live");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_message","bossmessage","Message");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_order","bossorder","Order");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_project","bossproject","Project");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_sundries_platform","bossplatform","Platform");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_user","bossuser","User");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_user_relation","bossrelation","Relation");
        dbconfig.add(triplet);
        triplet=new Triplet<>("bosscloud_video","bossvideo","Video");
        dbconfig.add(triplet);

        return dbconfig;
    }

}
