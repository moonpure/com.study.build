package ${packageName}.config;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import java.text.SimpleDateFormat;
import java.time.Duration;

@Configuration
@EnableCaching // 启动缓存
public class RedisCacheSerializeConfiguration {

    @Bean
    public RedisCacheManager cacheManager(RedisConnectionFactory connectionFactory) {
        RedisCacheConfiguration config = RedisCacheConfiguration.defaultCacheConfig().entryTtl(Duration.ofHours(5))
                .serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(keySerializer()))
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(valueSerializer()));
                //.disableCachingNullValues();
        RedisCacheManager redisCacheManager = RedisCacheManager.builder(connectionFactory).cacheDefaults(config)
                .transactionAware().build();
        return redisCacheManager;
    }

    private RedisSerializer<String> keySerializer() {
        return new StringRedisSerializer();
    }

    @Autowired
   JavaTimeModule javaTimeModule;

    private RedisSerializer<Object> valueSerializer() {
        ObjectMapper objectMapper=new ObjectMapper();
        //下面两个序要定义，但又不能用外面的，所以这新建了
        objectMapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
        objectMapper.activateDefaultTyping(LaissezFaireSubTypeValidator.instance, ObjectMapper.DefaultTyping.NON_FINAL);
        //sona扫描
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        objectMapper.registerModule(javaTimeModule);
        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);

        //反序列化的时候如果多了其他属性,不抛出异常
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
                //如果是空对象的时候,不抛异常
                .configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false)
                //如为空则不序列化
                .setSerializationInclusion(JsonInclude.Include.NON_NULL)
                //旧日期格式
                .setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
        return new GenericJackson2JsonRedisSerializer(objectMapper);
    }
}
