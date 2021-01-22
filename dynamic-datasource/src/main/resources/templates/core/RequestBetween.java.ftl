package ${packageName}.core;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
public class RequestBetween<T> extends RequestPage<T> {
    List<BetweenBase<Long>> betweenLong;
    List<BetweenBase<LocalDateTime>> betweenDate;
}