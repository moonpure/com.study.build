package ${package.ServiceImpl};

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import ${package.Entity}.${entity};
import ${package.Mapper}.${table.mapperName};
import com.baomidou.dynamic.datasource.annotation.DS;
import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.apache.ibatis.session.ResultHandler;
/**
 * <p>
 * ${table.comment!} 服务实现类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
@Service
<#if kotlin>
open class ${table.serviceImplName} : ${superServiceImplClass}<${table.mapperName}, ${entity}>(), ${table.serviceName} {

}
<#else>
@DS("${dbDataSource}")
public class ${table.serviceImplName} extends ${superServiceImplClass}<${table.mapperName}, ${entity}> implements ${superServiceClass}<${entity}> {
    public void listFlow(QueryWrapper<${entity}> wrapper, ResultHandler<${entity}> handler) {
        super.getBaseMapper().listFlow(wrapper,handler);
    }
}
</#if>
