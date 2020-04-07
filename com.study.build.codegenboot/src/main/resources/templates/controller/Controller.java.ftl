package ${packageName}.controller;

import ${packageName}.core.*;
import ${packageName}.dao.dbmodel.${entityName};
import ${packageName}.service.${entityName}ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/${entityNameLower}")
class ${entityName}Controller {
    @Autowired
   ${entityName}ServiceImpl ${entityNameLower}Service;


    @PostMapping("/save")
    public Result<Boolean> save(@RequestBody ${entityName} entity) {
        return ${entityNameLower}Service.save(entity);
    }

    @PostMapping("/updateid")
    public Result<Boolean> updateById(@RequestBody ${entityName} entity) {
        return ${entityNameLower}Service.updateById(entity);
    }

    @PostMapping("/update")
    public Result<Boolean> update(@RequestBody List<${entityName}> entities) {

        return ${entityNameLower}Service.update(entities);
    }

    @GetMapping("/getid/{id}")
    public Result<${entityName}> getById(@PathVariable("id") Long id) {
        return ${entityNameLower}Service.getById(id);
    }

    @PostMapping("/getone")
    public Result<${entityName}> getOne(@RequestBody ${entityName} entity) {
        return ${entityNameLower}Service.getOne(entity);
    }

    @PostMapping("/select")
    public Result<List<${entityName}>> selectPage(@RequestBody RequestPage<${entityName}> entity) {
        return ${entityNameLower}Service.selectPage(entity);
    }

    @PostMapping("/selectin")
    public Result<List<${entityName}>> selectIn(@RequestBody RequestIn<${entityName}, Long> entity) {
        return ${entityNameLower}Service.selectIn(entity);
    }
}