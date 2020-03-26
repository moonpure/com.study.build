package ${packageName}.feignservice.feign;

import ${packageName}.core.*;
import ${packageName}.feignservice.entity.${entityName};
import ${packageName}.feignservice.fallback.${entityName}Fallback;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import java.util.List;

@FeignClient(name = <#noparse>"${feignconfig.providename}"</#noparse>, path = "${entityNameLower}",contextId ="${entityNameLower}",fallback = ${entityName}Fallback.class)
public interface ${entityName}Feign {
    @PostMapping("/save")
    Result<Boolean> save(@RequestBody ${entityName} entity);

    @PostMapping("/updateid")
    Result<Boolean> updateById(@RequestBody ${entityName} entity);

    @PostMapping("/update")
    Result<Boolean> update(@RequestBody List<${entityName}> entities);

    @GetMapping("/getid/{id}")
    Result<${entityName}> getById(@PathVariable("id") Long id);

    @PostMapping("/getone/{name}")
    Result<${entityName}> getOne(@PathVariable("name") String name);

    @PostMapping("/select")
    Result<List<${entityName}>> selectPage(@RequestBody RequestPage<${entityName}> entity);
    @PostMapping("/selectin")
     Result<List<${entityName}>> selectIn(@RequestBody RequestIn<${entityName}, Long> entity);
}
