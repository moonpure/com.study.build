package ${packageName}.feignservice.fallback;

import ${packageName}.core.*;
import ${packageName}.feignservice.entity.${entityName};
import ${packageName}.feignservice.feign.${entityName}Feign;
import org.springframework.stereotype.Component;
import java.util.List;

@Component
public class ${entityName}Fallback implements ${entityName}Feign {
    @Override
    public Result<Boolean> save( ${entityName} entity) {
        return null;
    }

    @Override
    public Result<Boolean> updateById( ${entityName} entity) {
        return null;
    }

    @Override
    public Result<Boolean> update(List<${entityName}> entities) {
        return null;
    }

    @Override
    public Result<${entityName}> getById(Long id) {
        return null;
    }

    @Override
    public Result<${entityName}> getOne(${entityName} entity) {
        return null;
    }

    @Override
    public Result<List<${entityName}>> selectPage(RequestPage<${entityName}> entity) {
        return null;
    }
    @Override
    public Result<List<${entityName}>> selectIn(RequestIn<${entityName}, Long> entity) {
        return null;
    }
}
