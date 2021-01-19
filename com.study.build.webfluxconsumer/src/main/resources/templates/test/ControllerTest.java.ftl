package ${packageName}.controller;

import ${packageName}.reactiveservice.entity.${entityName};
import org.junit.jupiter.api.Test;
import ${packageName}.core.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import reactor.core.publisher.Mono;
import org.springframework.test.web.reactive.server.WebTestClient;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class ${entityName}ControllerTest {
@Autowired
Sequence sequence;
@Autowired
WebTestClient webTestClient;
@Test
void save() throws Exception {
${entityName} entity =new ${entityName}();
<#list tableColumns as column>
    <#if (column.columnName = "Id") >
        entity.set${column.columnName}(sequence.nextId());
    <#elseif  (column.columnName = "Name")>
        entity.set${column.columnName}("Name"+sequence.nextId());
    <#else>
        entity.set${column.columnName}(${column.columnDefault});
    </#if>
</#list>
webTestClient.post().uri("/${artifactName}/${entityNameLower}/save")
.body(Mono.just(entity), entity.getClass())
.exchange()
.expectStatus().isOk()
.expectBody().jsonPath("$.code").isEqualTo(0);
}


@Test
void updateById() throws Exception {
${entityName} entity = new  ${entityName}();
<#list tableColumns as column>
    //entity.set${column.columnName}();
</#list>
webTestClient.post().uri("/${artifactName}/${entityNameLower}/updateid")
.body(Mono.just(entity), entity.getClass())
.exchange()
.expectStatus().isOk()
.expectBody().jsonPath("$.code").isEqualTo(0);
}

@Test
void update() {
}

@Test
void getById() throws Exception {
Long id = 112345l;
webTestClient.get().uri("/${artifactName}/${entityNameLower}/getid/" + id)
.exchange()
.expectStatus().isOk()
.expectBody().jsonPath("$.code").isEqualTo(0);
}
@Test
void getByName() throws Exception {
String name="test";
webTestClient.get().uri("/${artifactName}/${entityNameLower}/getname/" + name)
.exchange()
.expectStatus().isOk()
.expectBody().jsonPath("$.code").isEqualTo(0);
}
@Test
void getOne() throws Exception {
${entityName} entity = new ${entityName}();
<#list tableColumns as column>
    //entity.set${column.columnName}();
</#list>
webTestClient.post().uri("/${artifactName}/${entityNameLower}/getone")
.body(Mono.just(entity), entity.getClass())
.exchange()
.expectStatus().isOk()
.expectBody().jsonPath("$.code").isEqualTo(0);
}

@Test
void selectPage() throws Exception {
RequestPage<${entityName}> entityPage = new RequestPage<>();
${entityName} entity = new ${entityName}();
<#list tableColumns as column>
    //entity.set${column.columnName}();
</#list>
entityPage.setData(entity);
webTestClient.post().uri("/${artifactName}/${entityNameLower}/select")
.body(Mono.just(entityPage), entityPage.getClass())
.exchange()
.expectStatus().isOk()
.expectBody().jsonPath("$.code").isEqualTo(0);
}

@Test
void selectIn() throws Exception {
RequestIn<${entityName}, Long> entityIn = new RequestIn<>();
//entityIn.setColumnName("id");
//entityIn.setInValues(Arrays.asList(0l));
${entityName} entity = new ${entityName}();
<#list tableColumns as column>
    //entity.set${column.columnName}();
</#list>
entityIn.setData(entity);

webTestClient.post().uri("/${artifactName}/${entityNameLower}/selectin")
.body(Mono.just(entityIn), entityIn.getClass())
.exchange()
.expectStatus().isOk()
.expectBody().jsonPath("$.code").isEqualTo(0);
}
@Test
void delById() throws Exception {
Long id=0l;
webTestClient.put().uri("/${artifactName}/${entityNameLower}/delid/" + id)
.exchange()
.expectStatus().isOk()
.expectBody().jsonPath("$.code").isEqualTo(0);
}
@Test
void delByIds() throws Exception{
List
<Long> ids=Arrays.asList(1l);
    webTestClient.post().uri("/${artifactName}/${entityNameLower}/delids")
    .body(Mono.just(ids), ids.getClass())
    .exchange()
    .expectStatus().isOk()
    .expectBody().jsonPath("$.code").isEqualTo(0);
    }
    }