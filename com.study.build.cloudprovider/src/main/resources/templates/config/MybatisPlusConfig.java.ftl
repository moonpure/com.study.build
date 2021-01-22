package ${packageName}.config;

import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/*
* mybatis-plus分页插件
*
* */
@Configuration
public class MybatisPlusConfig {
/**
* mybatis-plus分页插件<br>
* 文档：http://mp.baomidou.com<br>
*/
@Bean
public PaginationInterceptor paginationInterceptor() {
PaginationInterceptor paginationInterceptor = new PaginationInterceptor();
return paginationInterceptor;
}


}
