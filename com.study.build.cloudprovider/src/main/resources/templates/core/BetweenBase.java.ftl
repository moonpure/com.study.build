package ${packageName}.core;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BetweenBase<T> {
    /**
     * Between查询的列名
     */
    private String columnName;
    /**
     * between开始值，闭值
     */
    private T beginValue;
    /**
     * between结束值，开值
     */
    private T endValue;
}
