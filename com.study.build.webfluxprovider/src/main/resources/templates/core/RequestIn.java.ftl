package ${packageName}.core;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class RequestIn
<T,V> extends RequestBase
<T> {
    /**
    * in查询的列名
    */
    private String columnName;
    /**
    * in 值列表
    */
    private List
    <V> inValues;
        }
