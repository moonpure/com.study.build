package ${packageName}.controller;

import ${packageName}.core.*;
import ${packageName}.reactiveservice.entity.${entityName};
import ${packageName}.service.${entityName}ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;
import java.util.List;

@RestController
@RequestMapping("/${artifactName}/${entityNameLower}")
class ${entityName}Controller {
@Autowired
${entityName}ServiceImpl ${entityNameLower}Service;


@PostMapping("/save")
public Mono
<Result
<Boolean>> save(@RequestBody ${entityName} entity) {
    return ${entityNameLower}Service.save(entity);
    }

    @PostMapping("/updateid")
    public Mono
    <Result
    <Boolean>> updateById(@RequestBody ${entityName} entity) {
        return ${entityNameLower}Service.updateById(entity);
        }

        @PostMapping("/update")
        public Mono
        <Result
        <Boolean>> update(@RequestBody List<${entityName}> entities) {

            return ${entityNameLower}Service.update(entities);
            }

            @GetMapping("/getid/{id}")
            public Mono
            <Result
            <${entityName}>> getById(@PathVariable("id") Long id) {
            return ${entityNameLower}Service.getById(id);
            }

            @GetMapping("/getone/{name}")
            public Mono
            <Result
            <${entityName}>> getOne(@PathVariable("name") String name) {
            return ${entityNameLower}Service.getOne(name);
            }

            @PostMapping("/select")
            public Mono
            <Result
            <List
            <${entityName}>>> selectPage(@RequestBody RequestPage<${entityName}> entity) {
            return ${entityNameLower}Service.selectPage(entity);
            }

            @PostMapping("/selectin")
            public Mono
            <Result
            <List
            <${entityName}>>> selectIn(@RequestBody RequestIn<${entityName}, Long> entity) {
            return ${entityNameLower}Service.selectIn(entity);
            }
            }