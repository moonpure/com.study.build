package ${packageName}.core;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class RequestQuery<T, V> extends RequestBetween<T> {
    /**
     * in查询的列名
     */
    private String columnName;
    /**
     * in 值列表
     */
    private List<V> inValues;
}