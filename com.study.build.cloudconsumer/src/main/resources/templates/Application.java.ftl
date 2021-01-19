package ${packageName};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
public class ${artifactName}Application {

public static void main(String[] args) {
SpringApplication.run(${artifactName}Application.class, args);
}
}
