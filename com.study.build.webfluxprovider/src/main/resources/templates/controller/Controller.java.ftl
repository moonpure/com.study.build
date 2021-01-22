package ${packageName}.controller;

import ${packageName}.core.*;
import ${packageName}.dao.dbmodel.${entityName};
import ${packageName}.service.${entityName}ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.List;

@RestController
@RequestMapping("/${entityNameLower}")
class ${entityName}Controller {
@Autowired
${entityName}ServiceImpl ${entityNameLower}Service;


@PostMapping("/save")
public Mono
<Result
<Boolean>> save(@RequestBody ${entityName} entity) {
    return Mono.justOrEmpty(${entityNameLower}Service.save(entity));
    }

    @PostMapping("/updateid")
    public Mono
    <Result<Boolean>> updateById(@RequestBody ${entityName} entity) {
        return Mono.justOrEmpty(${entityNameLower}Service.updateById(entity));
        }

        @PostMapping("/update")
        public Mono
        <Result<Boolean>> update(@RequestBody List<${entityName}> entities) {

            return Mono.justOrEmpty(${entityNameLower}Service.update(entities));
            }

            @GetMapping("/getid/{id}")
            public Mono
            <Result<${entityName}>> getById(@PathVariable("id") Long id) {
            return Mono.justOrEmpty(${entityNameLower}Service.getById(id));
            }
            @GetMapping("/getname/{name}")
            public Mono
            <Result<${entityName}>> getByName(@PathVariable("name") String name) {

            return Mono.justOrEmpty(${entityNameLower}Service.getByName(name));
            }
            @PostMapping("/getone")
            public Mono
            <Result
            <${entityName}>> getOne(@RequestBody ${entityName} entity) {
            return Mono.justOrEmpty(${entityNameLower}Service.getOne(entity));
            }

            @PostMapping("/select")
            public Mono
            <Result
            <List
            <${entityName}>>> selectPage(@RequestBody RequestPage<${entityName}> entity) {
            return Mono.justOrEmpty(${entityNameLower}Service.selectPage(entity));
            }

            @PostMapping("/selectin")
            public Mono
            <Result
            <List
            <${entityName}>>> selectIn(@RequestBody RequestIn<${entityName}, Long> entity) {
            return Mono.justOrEmpty(${entityNameLower}Service.selectIn(entity));
            }
            @PutMapping("/delid/{id}")
            public Mono
            <Result
            <Boolean>> delById(@PathVariable("id") Long id) {
                return Mono.justOrEmpty(${entityNameLower}Service.delById(id));
                }
                @PostMapping("/delids")
                public Mono
                <Result
                <Boolean>> delByIds(@RequestBody List
                    <Long> ids) {
                        return Mono.justOrEmpty(${entityNameLower}Service.delByIds(ids));
                        }
                        }