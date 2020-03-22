package com.study.build.cloudconsumer.core;

import lombok.Data;

@Data
public class OrderItem {
    private String column;
    private boolean asc = true;
}
