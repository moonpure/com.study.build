package com.bosscloud.dynamic.dao.dbmodel;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 *
 * </p>
 *
 * @author mybatis-plus-generator
 * @since 2020-03-18
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Tables implements Serializable {

    private static final long serialVersionUID = 1L;

    private String tableCatalog;

    private String tableSchema;

    private String tableName;

    private String tableType;

    private String engine;

    private Long version;

    private String rowFormat;

    private Long tableRows;

    private Long avgRowLength;

    private Long dataLength;

    private Long maxDataLength;

    private Long indexLength;

    private Long dataFree;

    private Long autoIncrement;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    private LocalDateTime checkTime;

    private String tableCollation;

    private Long checksum;

    private String createOptions;

    private String tableComment;

}
