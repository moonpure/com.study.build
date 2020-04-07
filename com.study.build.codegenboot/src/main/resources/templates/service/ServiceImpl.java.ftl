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

import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;

import java.util.List;

@Service
public class ${entityName}ServiceImpl {
    @Autowired
    Db${entityName}Service db${entityName}Service;

    public Result<Boolean> save(${entityName} entity) {
        boolean bool = db${entityName}Service.save(entity);
        if (!bool) {
            return Result.createFailure(ResultCode.DATABASE_EDIT_FAILURE);
        }

        return Result.createBySuccess(bool);
    }

    public Result<Boolean> updateById(${entityName} entity) {
        boolean bool = db${entityName}Service.updateById(entity);
        if (!bool) {
            return Result.createFailure(ResultCode.DATABASE_EDIT_FAILURE);
        }

        return Result.createBySuccess(bool);
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

    public Result<${entityName}> getById(Long id) {
        if (id == null || id <= 0) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        return Result.createBySuccess(db${entityName}Service.getById(id));
    }

    public Result<${entityName}> getOne(${entityName} entity) {
        return Result.createBySuccess(db${entityName}Service.getOne(new QueryWrapper<${entityName}>(entity)));
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

    public <T> Result<List<${entityName}>> selectIn(RequestIn<${entityName},T> entity)
    {
        QueryWrapper<${entityName}> queryWrapper = new QueryWrapper<${entityName}>(entity.getData());
        queryWrapper.in(entity.getColumnName(),entity.getInValues());
        List<${entityName}> entitys= db${entityName}Service.list(queryWrapper);
        return Result.createBySuccess(entitys);
    }
}
