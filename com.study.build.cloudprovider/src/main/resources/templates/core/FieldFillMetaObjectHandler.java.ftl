package com.study.build.cloudprovider.core;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.baomidou.mybatisplus.core.toolkit.Sequence;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class FieldFillMetaObjectHandler implements MetaObjectHandler {

@Autowired
    Sequence sequence;
    //新增填充
    @Override
    public void insertFill(MetaObject metaObject) {
        Object id = getFieldValByName("id", metaObject);
        if (id == null) {
            setFieldValByName("id", sequence.nextId(), metaObject); //mybatis-plus版本2.0.9+
        }
        Object createTime = getFieldValByName("createTime", metaObject);
        if (createTime == null) {
            setFieldValByName("createTime", LocalDateTime.now(), metaObject); //mybatis-plus版本2.0.9+
        }
        Object updateTime = getFieldValByName("updateTime", metaObject);
        if (updateTime == null) {
            setFieldValByName("updateTime", LocalDateTime.now(), metaObject); //mybatis-plus版本2.0.9+
        }
    }

    //更新填充
    @Override
    public void updateFill(MetaObject metaObject) {
        Object updateTime = getFieldValByName("updateTime", metaObject);
        if (updateTime == null) {
            setFieldValByName("updateTime", LocalDateTime.now(), metaObject); //mybatis-plus版本2.0.9+
        }

    }
}
