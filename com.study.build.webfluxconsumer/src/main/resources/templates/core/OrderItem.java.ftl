package ${packageName}.core;

import lombok.Data;

@Data
public class OrderItem {
    private String column;
    private boolean asc = true;
}
