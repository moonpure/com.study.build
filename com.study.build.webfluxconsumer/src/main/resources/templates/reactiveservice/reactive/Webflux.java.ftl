package ${packageName}.reactiveservice.reactive;

import ${packageName}.core.*;
import ${packageName}.reactiveservice.entity.${entityName};
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.List;

@Service
public class ${entityName}Webflux {
    @Value(<#noparse>"${serviceconfig.providename}"</#noparse>)
    private String serviceName;
    @Autowired
    WebClient.Builder webClientBuilder;
    public Mono<Result<Boolean>> save(${entityName} entity) {
        return   webClientBuilder.build().post().uri("http://"+serviceName+"/${entityNameLower}/save")
                .body(Mono.just(entity), entity.getClass())
                .retrieve().bodyToMono(new ParameterizedTypeReference<Result<Boolean>>(){});
    }

    public Mono<Result<Boolean>> updateById(${entityName} entity) {
        return   webClientBuilder.build().post().uri("http://"+serviceName+"/${entityNameLower}/updateid")
                .body(Mono.just(entity), entity.getClass())
                .retrieve().bodyToMono(new ParameterizedTypeReference<Result<Boolean>>(){});
    }

    public Mono<Result<Boolean>> update(List<${entityName}> entities) {
        return   webClientBuilder.build().post().uri("http://"+serviceName+"/${entityNameLower}/update")
                .body(Mono.just(entities), entities.getClass())
                .retrieve().bodyToMono(new ParameterizedTypeReference<Result<Boolean>>(){});
    }

    public Mono<Result<${entityName}>> getById(Long id) {
        return   webClientBuilder.build().get().uri("http://"+serviceName+"/${entityNameLower}/getid/"+id)
                .retrieve().bodyToMono(new ParameterizedTypeReference<Result<${entityName}>>(){});
    }

    public Mono<Result<${entityName}>> getOne(String name) {
        return   webClientBuilder.build().get().uri("http://"+serviceName+"/${entityNameLower}/getone/"+name)
                .retrieve().bodyToMono(new ParameterizedTypeReference<Result<${entityName}>>(){});
    }

    public Mono<Result<List<${entityName}>>> selectPage(RequestPage<${entityName}> entity) {
        return   webClientBuilder.build().post().uri("http://"+serviceName+"/${entityNameLower}/select")
                .body(Mono.just(entity), entity.getClass())
                .retrieve().bodyToMono(new ParameterizedTypeReference<Result<List<${entityName}>>>(){});
    }

    public Mono<Result<List<${entityName}>>> selectIn(RequestIn<${entityName}, Long> entity) {
        return   webClientBuilder.build().post().uri("http://"+serviceName+"/${entityNameLower}/selectin")
                .body(Mono.just(entity), entity.getClass())
                .retrieve().bodyToMono(new ParameterizedTypeReference<Result<List<${entityName}>>>(){});
    }
}
