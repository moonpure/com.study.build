package ${packageName}.reactiveservice.entity;



import lombok.Data;
import java.io.Serializable;
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * ${tableComment}
 */
@Data
public class ${entityName}  {
<#list tableColumns as column>
  /**
   * ${column.columnComment}
   */
   <#if (column.dataType = "LocalDateTime") >
       @JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss")
      private ${column.dataType} ${column.columnName};
   <#else>
       private ${column.dataType} ${column.columnName};
   </#if>
</#list>

}
