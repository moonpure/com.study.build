package ${packageName};

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan({"${packageName}.dao.dbmapper"})
public class ${artifactName}Application {

    public static void main(String[] args) {
        SpringApplication.run(${artifactName}Application.class, args);
    }
}
