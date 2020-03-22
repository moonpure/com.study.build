package ${packageName}.feignservice.entity;



import lombok.Data;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * ${tableComment}
 */
@Data
public class ${entityName}  {
<#list tableColumns as column>
  /**
   * ${column.columnComment}
   */
 private ${column.dataType} ${column.columnName};
</#list>

}
