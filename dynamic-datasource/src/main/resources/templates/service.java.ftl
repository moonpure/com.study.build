package ${package.Service};

import ${package.Entity}.${entity};
import ${superServiceClassPackage};
import com.baomidou.dynamic.datasource.annotation.DS;
import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.apache.ibatis.session.ResultHandler;
/**
 * <p>
 * ${table.comment!} 服务类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if kotlin>
interface ${table.serviceName} : ${superServiceClass}<${entity}>
<#else>
 @DS("${dbDataSource}")
public interface ${table.serviceName} extends ${superServiceClass}<${entity}> {
    void listFlow(QueryWrapper<${entity}> wrapper, ResultHandler<${entity}> handler);
}
</#if>
