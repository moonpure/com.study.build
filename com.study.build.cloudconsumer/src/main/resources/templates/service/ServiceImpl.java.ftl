package ${packageName}.service;

import ${packageName}.core.*;
import ${packageName}.feignservice.entity.${entityName};
import ${packageName}.feignservice.feign.${entityName}Feign;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ${entityName}ServiceImpl {
    @Autowired
    ${entityName}Feign ${entityNameLower}Feign;

    public Result<Boolean> save(${entityName} entity) {
      return ${entityNameLower}Feign.save(entity);
    }
    public Result<Boolean> updateById(${entityName} entity) {
       return ${entityNameLower}Feign.updateById(entity);
    }
    public Result<Boolean> update(List<${entityName}> entities) {
        if (entities == null || entities.size() != 2) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        return ${entityNameLower}Feign.update(entities);
    }
    public Result<${entityName}> getById(Long id) {
        if (id == null || id <= 0) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        return ${entityNameLower}Feign.getById(id);
    }

    public Result<${entityName}> getOne(String name) {
        return ${entityNameLower}Feign.getOne(name);
    }
    public Result<List<${entityName}>> selectPage(RequestPage<${entityName}> entity) {
        if (entity == null ) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        return ${entityNameLower}Feign.selectPage(entity);
    }
    public <T> Result<List<${entityName}>> selectIn(RequestIn<${entityName},Long> entity){
        return ${entityNameLower}Feign.selectIn(entity);
    }
    public <T> T convertResult(Result<T> tResult) {
        if(tResult==null||tResult.getCode()!=ResultCode.SUCCESS.getCode())
        {
        return null;
        }
        return tResult.getData();
    }
}
