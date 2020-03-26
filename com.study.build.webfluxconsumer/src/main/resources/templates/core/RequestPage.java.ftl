package ${packageName}.core;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class RequestPage<T> extends RequestBase<T> {
    private long size=10;//每页大小
    private long current;//当前页数
    private List<OrderItem> orders;
}
