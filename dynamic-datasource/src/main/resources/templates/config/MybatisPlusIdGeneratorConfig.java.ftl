package ${packageName}.config;

import com.baomidou.mybatisplus.core.toolkit.Sequence;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * id生成器
 */
@Configuration
public class MybatisPlusIdGeneratorConfig {
    @Bean
    public Sequence createSequence() {
        return new Sequence();
    }
}
