package ${packageName}.service;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${packageName}.core.*;
import ${packageName}.dao.dbmodel.${entityName};
import ${packageName}.dao.dbservice.Db${entityName}Service;
import org.springframework.beans.factory.annotation.Autowired;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.ResultHandler;
import org.springframework.stereotype.Service;
import javax.servlet.http.HttpServletResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.OutputStream;
import java.net.URLEncoder;
import org.springframework.cache.annotation.*;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import java.time.LocalDateTime;
import org.springframework.data.redis.core.StringRedisTemplate;

@Service
@Slf4j
public class ${entityName}ServiceImpl {
    @Autowired
    Db${entityName}Service db${entityName}Service;
    @Autowired
    HttpServletResponse response;
    @Autowired
    ObjectMapper objectMapper;
    @Autowired
    StringRedisTemplate redisTemplate;
    @Caching(cacheable = {
        @Cacheable(cacheNames = "${artifactId}-${entityName}Save", key = "#entity.id"),
        @Cacheable(cacheNames = "${artifactId}-${entityName}Save", key = "#entity.name")})
    public Result<Boolean> save(${entityName} entity) {
        boolean bool = db${entityName}Service.save(entity);
        if (!bool) {
            return Result.createFailure(ResultCode.DATABASE_EDIT_FAILURE);
        }

        return Result.createBySuccess(bool);
    }
    @CacheEvict(value = "${artifactId}-${entityName}ById", key = "#entity.id")
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
    @Cacheable(cacheNames = "${artifactId}-${entityName}ById", key = "#id" , sync = true)
    public Result<${entityName}> getById(Long id) {
        if (id == null || id <= 0) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        return Result.createBySuccess(db${entityName}Service.getById(id));
    }

    @Cacheable(cacheNames = "${artifactId}-${entityName}ByName", key = "#name" , sync = true)
    public Result<${entityName}> getByName(String name) {
        if (StringUtils.isAllBlank(name)) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        ${entityName} entity =new ${entityName}();
        entity.setName(name);
        return getOne(entity);
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
    public void selectFlow(${entityName} entity, ResultHandler<${entityName}> handler) {
        QueryWrapper<${entityName}> queryWrapper = new QueryWrapper<>(entity);
        db${entityName}Service.listFlow(queryWrapper, handler);
    }
    public Boolean delByName(String name){
        if(StringUtils.isAllBlank(name)){
            return false;
        }
            return  redisTemplate.delete("${artifactId}-${entityName}ByName::"+name);
    }
    public void download(${entityName} entity) {
        // 配置文件下载
        response.setHeader("content-type", "application/octet-stream");
        response.setContentType("application/octet-stream");
        // 下载文件能正常显示中文, 可以导入 iRecorder Web IDE中的 .side 文件
        try {
            //String filename = URLEncoder.encode("testStream.side", "UTF-8");
            response.setHeader("Content-Disposition", "attachment;filename=${entityName}");
            OutputStream os = response.getOutputStream();
            QueryWrapper<${entityName}> queryWrapper = new QueryWrapper<>(entity);
            db${entityName}Service.listFlow(queryWrapper, resultContext -> {
                ${entityName} oneEntity = resultContext.getResultObject();
                try {
                //输出是一个一个的流对像，如要解析还需要处于理
                    byte[] outByte = objectMapper.writeValueAsBytes(oneEntity);
                    os.write(outByte);
                } catch (Exception ex) {
                    log.error(ex.toString());
                }
            });
        } catch (Exception ex) {
            log.error(ex.toString());
        }
    }
    public Result<List<${entityName}>> selectBetween(RequestBetween<${entityName}> entity) {
        if (entity == null) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }
        Page<${entityName}> pageEntity = new Page<>();
        pageEntity.setCurrent(entity.getCurrent());
        pageEntity.setSize(entity.getSize());
        pageEntity.setOrders(entity.getOrders());
        //优化，把id做大于条件
        Long id = null;
        if (entity != null && entity.getData() != null || entity.getData().getId() != null) {
            id = entity.getData().getId();
            entity.getData().setId(null);
        }
        QueryWrapper<${entityName}> query = new QueryWrapper(entity.getData());

        if (id != null) {
            query.lambda().ge(${entityName}::getId, id);
        }
        List<BetweenBase<Long>> longList = entity.getBetweenLong();
        if (longList != null && longList.size() > 0) {
            for (BetweenBase<Long> beLong : longList) {
                if (beLong == null) {
                    continue;
                }
                if (beLong.getBeginValue() != null) {
                    query.ge(beLong.getColumnName(), beLong.getBeginValue());
                }
                if (beLong.getEndValue() != null) {
                    query.lt(beLong.getColumnName(), beLong.getEndValue());
                }
            }
        }
        List<BetweenBase<LocalDateTime>> dateList = entity.getBetweenDate();
        if (dateList != null && dateList.size() > 0) {
            for (BetweenBase<LocalDateTime> beDate : dateList) {
                if (beDate == null) {
                    continue;
                }
                if (beDate.getBeginValue() != null) {
                     query.ge(beDate.getColumnName(), beDate.getBeginValue());
                }
                if (beDate.getEndValue() != null) {
                    query.lt(beDate.getColumnName(), beDate.getEndValue());
                }
            }
        }

        IPage<${entityName}> selectPage = db${entityName}Service.page(pageEntity, query);
        return Result.createBySuccess(selectPage.getRecords());
    }

    public <T> Result<List<${entityName}>> selectQuery(RequestQuery<${entityName}, T> entity) {
        if (entity == null) {
            return Result.createFailure(ResultCode.PARAM_IS_INVALID);
        }

        Page<${entityName}> pageEntity = new Page<>();
        pageEntity.setCurrent(entity.getCurrent());
        pageEntity.setSize(entity.getSize());
        pageEntity.setOrders(entity.getOrders());
        //优化，把id做大于条件
        Long id = null;
        if (entity != null && entity.getData() != null || entity.getData().getId() != null) {
            id = entity.getData().getId();
            entity.getData().setId(null);
        }
        QueryWrapper<${entityName}> query = new QueryWrapper(entity.getData());

        if (id != null) {
            query.lambda().ge(${entityName}::getId, id);
        }
        List<BetweenBase<Long>> longList = entity.getBetweenLong();
        if (longList != null && longList.size() > 0) {
            for (BetweenBase<Long> beLong : longList) {
                if (beLong == null) {
                    continue;
                }
                if (beLong.getBeginValue() != null) {
                    query.ge(beLong.getColumnName(), beLong.getBeginValue());
                }
                if (beLong.getEndValue() != null) {
                    query.lt(beLong.getColumnName(), beLong.getEndValue());
                }
            }
        }
        List<BetweenBase<LocalDateTime>> dateList = entity.getBetweenDate();
        if (dateList != null && dateList.size() > 0) {
            for (BetweenBase<LocalDateTime> beDate : dateList) {
                if (beDate == null) {
                    continue;
                }
                if (beDate.getBeginValue() != null) {
                    query.ge(beDate.getColumnName(), beDate.getBeginValue());
                }
                if (beDate.getEndValue() != null) {
                    query.lt(beDate.getColumnName(), beDate.getEndValue());
                }
            }
        }
        if (!StringUtils.isAllBlank(entity.getColumnName()) && entity.getInValues() != null && entity.getInValues().size() > 0) {
            query.in(entity.getColumnName(), entity.getInValues());
        }

        IPage<${entityName}> selectPage = db${entityName}Service.page(pageEntity, query);
        return Result.createBySuccess(selectPage.getRecords());
    }
}
