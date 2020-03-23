package ${packageName}.service;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${packageName}.core.RequestPage;
import ${packageName}.core.Result;
import ${packageName}.core.ResultCode;
import ${packageName}.core.RequestIn;
import ${packageName}.dao.dbmodel.${entityName};
import ${packageName}.dao.dbservice.Db${entityName}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.springframework.cache.annotation.*;
@Service
public class ${entityName}ServiceImpl {
    @Autowired
    Db${entityName}Service db${entityName}Service;
    @Autowired
    StringRedisTemplate redisTemplate;
    @Caching(cacheable = {
         @Cacheable(cacheNames = "${entityName}Save", key = "#entity.id"),
         @Cacheable(cacheNames = "${entityName}Save", key = "#entity.name")})
    public Result<Boolean> save(${entityName} entity) {
        boolean bool = db${entityName}Service.save(entity);
        if (!bool) {
            return Result.createFailure(ResultCode.DATABASE_EDIT_FAILURE);
        }

        return Result.createBySuccess(bool);
    }
    @Caching(evict = {
        @CacheEvict(value = "${entityName}ById", key = "#entity.id")})
    public Result<Boolean> updateById(${entityName} entity) {
        if(entity==null||entity.getId()==null){
        return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        ${entityName} entityDb=db${entityName}Service.getById(entity.getId());
        if(entityDb==null){
        return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        delByName(entityDb.getName());
        return Result.createBySuccess(db${entityName}Service.updateById(entity));
    }

    public Result<Boolean> update(List<${entityName}> entities) {
        if (entities == null || entities.size() != 2) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }

        boolean bool = db${entityName}Service.update(entities.get(0), new QueryWrapper<${entityName}>(entities.get(1)));
        if (!bool) {
            return Result.createFailure(ResultCode.DATABASE_EDIT_FAILURE);
        }
        return Result.createBySuccess(bool);
    }
    @Cacheable(cacheNames = "${entityName}ById", key = "#id" , sync = true)
    public Result<${entityName}> getById(Long id) {
        if (id == null || id <= 0) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        return Result.createBySuccess(db${entityName}Service.getById(id));
    }

    @Cacheable(cacheNames = "${entityName}ByName", key = "#name" , sync = true)
    public Result<${entityName}> getByName(String name) {
        if (StringUtils.isAllBlank(name)) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        ${entityName} entity =new ${entityName}();
        entity.setName(name);
        return getOne(entity);
    }
    public Result<${entityName}> getOne(${entityName} entity) {
        return Result.createBySuccess(db${entityName}Service.getOne(new QueryWrapper<${entityName}>(entity),false));
    }

    public Result<List<${entityName}>> selectPage(RequestPage<${entityName}> entity) {
        if (entity == null ) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        Page<${entityName}> pageEntity = new Page<>();
        pageEntity.setCurrent(entity.getCurrent());
        pageEntity.setSize(entity.getSize());
        pageEntity.setOrders(entity.getOrders());
        //优化，把id做大于条件
        Long id=null;
        if(entity!=null&&entity.getData()!=null||entity.getData().getId()!=null){
            id=entity.getData().getId();
            entity.getData().setId(null);
        }
        QueryWrapper<${entityName}> query=new QueryWrapper(entity.getData());
        if(id!=null) {
            query.lambda().ge(${entityName}::getId,id);
        }
        IPage<${entityName}> selectPage = db${entityName}Service.page(pageEntity,query);
        return Result.createBySuccess(selectPage.getRecords());
    }

    public <T> Result<List<${entityName}>> selectIn(RequestIn<${entityName},T> entity){
        QueryWrapper<${entityName}> queryWrapper = new QueryWrapper<${entityName}>(entity.getData());
        if(!StringUtils.isAllBlank(entity.getColumnName())&& entity.getInValues()!=null&&entity.getInValues().size()>0) {
            queryWrapper.in(entity.getColumnName(), entity.getInValues());
        }
        List<${entityName}> entitys= db${entityName}Service.list(queryWrapper);
        return Result.createBySuccess(entitys);
      }
    @CacheEvict(value = "${entityName}ById", key = "#id")
    public Result<Boolean> delById(Long id){
        if(id==null||id<=0){
        return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        ${entityName} entity =db${entityName}Service.getById(id);
        if(entity==null){
        return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        delByName(entity.getName());
        return Result.createBySuccess(db${entityName}Service.removeById(id));
    }
    public Result<Boolean> delByIds(List<Long> ids) {
        if (ids == null || ids.size() <= 0) {
        return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        return Result.createBySuccess(db${entityName}Service.removeByIds(ids));
    }
    public Boolean delByName(String name){
        if(StringUtils.isAllBlank(name))
        {
        return false;
        }
        return  redisTemplate.delete("${entityName}ByName::"+name);
    }
}
