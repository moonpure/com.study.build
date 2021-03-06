package ${packageName}.controller;

import com.baomidou.mybatisplus.core.toolkit.Sequence;
import com.fasterxml.jackson.databind.ObjectMapper;
import ${packageName}.dao.dbmodel.${entityName};
import org.junit.jupiter.api.Test;
import ${packageName}.core.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.RequestBuilder;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class ${entityName}ControllerTest {
    @Autowired
    private MockMvc mockMvc;
    @Autowired
    ObjectMapper objectMapper;
    @Autowired
    Sequence sequence;
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
        String requestBody =objectMapper.writeValueAsString(entity);
        //请求数据
        RequestBuilder request = null;

        request = post("/${entityNameLower}/save")
                .contentType(MediaType.APPLICATION_JSON)
                .content(requestBody)
                .accept(MediaType.APPLICATION_JSON);

        String retContent = mockMvc.perform(request)
                          .andDo(print())
                          .andExpect(status().isOk()) //状态吗是否相等
                          .andExpect(jsonPath("$.code").value(0))//返回成功状态码
                          .andReturn().getResponse().getContentAsString();
        System.out.println(retContent);
    }


    @Test
    void updateById() throws Exception {
         ${entityName} entity = new  ${entityName}();
<#list tableColumns as column>
         //entity.set${column.columnName}();
</#list>
         String requestBody = objectMapper.writeValueAsString(entity);
         //请求数据
         RequestBuilder request = null;

         request = post("/${entityNameLower}/updateid")
                 .contentType(MediaType.APPLICATION_JSON)
                 .content(requestBody)
                 .accept(MediaType.APPLICATION_JSON_UTF8);

         String retContent = mockMvc.perform(request)
                          .andDo(print())
                          .andExpect(status().isOk()) //状态吗是否相等
                          .andExpect(jsonPath("$.code").value(0))//返回成功状态码
                          .andReturn().getResponse().getContentAsString();
         System.out.println(retContent);
    }

    @Test
    void update() {
     }

    @Test
    void getById() throws Exception {
         //请求数据
         RequestBuilder request = null;
         Long id=0l;
         request = get("/${entityNameLower}/getid/"+id)
                 .accept(MediaType.APPLICATION_JSON_UTF8);

         String retContent = mockMvc.perform(request)
                           .andDo(print())
                           .andExpect(status().isOk()) //状态吗是否相等
                           .andExpect(jsonPath("$.code").value(0))//返回成功状态码
                           .andReturn().getResponse().getContentAsString();
         System.out.println(retContent);
    }
   @Test
    void getByName() throws Exception {
            //请求数据
            RequestBuilder request = null;
            String name="test";
            request = get("/${entityNameLower}/getname/"+name)
            .accept(MediaType.APPLICATION_JSON_UTF8);

            String retContent = mockMvc.perform(request)
            .andDo(print())
            .andExpect(status().isOk()) //状态吗是否相等
            .andExpect(jsonPath("$.code").value(0))//返回成功状态码
            .andReturn().getResponse().getContentAsString();
            System.out.println(retContent);
    }
    @Test
    void getOne() throws Exception {
         ${entityName} entity = new ${entityName}();
<#list tableColumns as column>
         //entity.set${column.columnName}();
</#list>
         String requestBody = objectMapper.writeValueAsString(entity);
         //请求数据
         RequestBuilder request = null;
         request = post("/${entityNameLower}/getone")
                 .contentType(MediaType.APPLICATION_JSON)
                 .content(requestBody)
                 .accept(MediaType.APPLICATION_JSON_UTF8);
         String retContent = mockMvc.perform(request)
                           .andDo(print())
                           .andExpect(status().isOk()) //状态吗是否相等
                           .andExpect(jsonPath("$.code").value(0))//返回成功状态码
                           .andReturn().getResponse().getContentAsString();
         System.out.println(retContent);
     }

     @Test
     void selectPage() throws Exception {
         RequestPage<${entityName}> entityPage = new RequestPage<>();
         ${entityName} entity = new ${entityName}();
<#list tableColumns as column>
         //entity.set${column.columnName}();
</#list>
         entityPage.setData(entity);

         String requestBody = objectMapper.writeValueAsString(entityPage);
         //请求数据
         RequestBuilder request = null;
         request = post("/${entityNameLower}/select")
                 .contentType(MediaType.APPLICATION_JSON)
                 .content(requestBody)
                 .accept(MediaType.APPLICATION_JSON_UTF8);
         String retContent = mockMvc.perform(request)
                           .andDo(print())
                           .andExpect(status().isOk()) //状态吗是否相等
                           .andExpect(jsonPath("$.code").value(0))//返回成功状态码
                           .andReturn().getResponse().getContentAsString();
         System.out.println(retContent);
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

         String requestBody = objectMapper.writeValueAsString(entityIn);
         //请求数据
         RequestBuilder request = null;
         request = post("/${entityNameLower}/selectin")
                 .contentType(MediaType.APPLICATION_JSON)
                 .content(requestBody)
                 .accept(MediaType.APPLICATION_JSON_UTF8);
         String retContent = mockMvc.perform(request)
                           .andDo(print())
                           .andExpect(status().isOk()) //状态吗是否相等
                           .andExpect(jsonPath("$.code").value(0))//返回成功状态码
                           .andReturn().getResponse().getContentAsString();
        System.out.println(retContent);
    }
    @Test
    void delById() throws Exception {
        RequestBuilder request = null;
        Long id=0l;
        request = put("/${entityNameLower}/delid/"+id)
            .accept(MediaType.APPLICATION_JSON_UTF8);

        String retContent = mockMvc.perform(request)
            .andDo(print())
            .andExpect(status().isOk()) //状态吗是否相等
            .andExpect(jsonPath("$.code").value(0))//返回成功状态码
            .andReturn().getResponse().getContentAsString();
        System.out.println(retContent);
    }
    @Test
    void delByIds() throws Exception{
        List<Long> ids=Arrays.asList(1l);
        String requestBody = objectMapper.writeValueAsString(ids);
        //请求数据
        RequestBuilder request = null;
        request = post("/${entityNameLower}/delids")
            .contentType(MediaType.APPLICATION_JSON)
            .content(requestBody)
            .accept(MediaType.APPLICATION_JSON_UTF8);
        String retContent = mockMvc.perform(request)
            .andDo(print())
            .andExpect(status().isOk()) //状态吗是否相等
            .andExpect(jsonPath("$.code").value(0))//返回成功状态码
            .andReturn().getResponse().getContentAsString();
        System.out.println(retContent);
    }
}