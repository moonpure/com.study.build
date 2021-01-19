package ${package.Mapper};

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import ${package.Entity}.${entity};
import ${superMapperClassPackage};
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.mapping.ResultSetType;
import org.apache.ibatis.session.ResultHandler;
/**
* <p>
    * ${table.comment!} Mapper 接口
    * </p>
*
* @author ${author}
* @since ${date}
*/
<#if kotlin>
    interface ${table.mapperName} : ${superMapperClass}<${entity}>
<#else>
    public interface ${table.mapperName} extends ${superMapperClass}<${entity}> {
    @Select("select * from ${table.name}  <#noparse>${ew.customSqlSegment}</#noparse>")
    @Options(resultSetType = ResultSetType.FORWARD_ONLY, fetchSize = 100)
    @ResultType(${entity}.class)
    void listFlow(@Param(Constants.WRAPPER) QueryWrapper<${entity}> wrapper, ResultHandler<${entity}> handler);
    }
</#if>
