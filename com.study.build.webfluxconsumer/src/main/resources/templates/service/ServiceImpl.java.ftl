package ${packageName}.service;

import ${packageName}.core.*;
import ${packageName}.reactiveservice.entity.${entityName};
import ${packageName}.reactiveservice.reactive.${entityName}Webflux;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import java.util.List;
@Service
public class ${entityName}ServiceImpl {
@Autowired
${entityName}Webflux ${entityNameLower}Webflux;

public Mono
<Result
<Boolean>> save(${entityName} entity) {
    return ${entityNameLower}Webflux.save(entity);
    }
    public Mono
    <Result
    <Boolean>> updateById(${entityName} entity) {
        return ${entityNameLower}Webflux.updateById(entity);
        }
        public Mono
        <Result
        <Boolean>> update(List<${entityName}> entities) {
            if (entities == null || entities.size() != 2) {
            return Mono.just(Result.createFailure(ResultCode.PARAM_IS_INVALID));
            }
            return ${entityNameLower}Webflux.update(entities);
            }
            public Mono
            <Result
            <${entityName}>> getById(Long id) {
            if (id == null || id <= 0) {
            return Mono.just(Result.createFailure(ResultCode.PARAM_IS_INVALID));
            }
            return ${entityNameLower}Webflux.getById(id);
            }

            public Mono
            <Result
            <${entityName}>> getOne(String name) {
            return ${entityNameLower}Webflux.getOne(name);
            }
            public Mono
            <Result
            <List
            <${entityName}>>> selectPage(RequestPage<${entityName}> entity) {
            if (entity == null ) {
            return Mono.just(Result.createFailure(ResultCode.PARAM_IS_INVALID));
            }
            return ${entityNameLower}Webflux.selectPage(entity);
            }
            public Mono
            <Result
            <List
            <${entityName}>>> selectIn(RequestIn<${entityName},Long> entity){
            return ${entityNameLower}Webflux.selectIn(entity);
            }
            public
            <T> T convertResult(Result
                <T> tResult) {
                    if(tResult==null||tResult.getCode()!=ResultCode.SUCCESS.getCode())
                    {
                    return null;
                    }
                    return tResult.getData();
                    }
                    }
