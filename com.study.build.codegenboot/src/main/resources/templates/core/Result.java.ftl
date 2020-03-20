package ${packageName}.core;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.StringUtils;

import java.io.Serializable;


@Getter
@Setter
public class Result<T>   {
    //1.定义属性
    private Integer code;
    private String message;

    private T data;
    public Result() {
    }
    //2.定义构造函数
    private Result(int code) {
        this.code = code;
        this.message=ResultCode.getMessage(code);
    }

    private Result(int code, T data) {
        this.code = code;
        this.message=ResultCode.getMessage(code);
        this.data = data;
    }

    private Result(int code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    private Result(int code, String message) {
        this.code = code;
        this.message = message;
    }

    //3.getter方法
    public int getCode() {
        return code;
    }

    public T getData() {
        return data;
    }

    public String getMessage() {
        return message;
    }

    @JsonIgnore
    //使之不在json序列化结果当中
    //4.判断这个响应是不是一个正确的响应
    public boolean isSuccess() {
        return this.code == ResultCode.SUCCESS.getCode();
    }

    //5.定义返回对象的方法
    public static <T> Result<T> createBySuccess() {
        return new Result<T>(ResultCode.SUCCESS.getCode());
    }


    public static <T> Result<T> createBySuccess(T data) {
        return new Result<T>(ResultCode.SUCCESS.getCode(), data);
    }

    public static <T> Result<T> createBySuccess(String message, T data) {
        return new Result<T>(ResultCode.SUCCESS.getCode(), message, data);
    }

    public static <T> Result<T> createFailure() {
        return new Result<T>(ResultCode.FAILURE.getCode(), ResultCode.FAILURE.getMessage());
    }

    public static <T> Result<T> createFailure(ResultCode resultCode) {
        return new Result<T>(resultCode.getCode(), resultCode.getMessage());
    }
    //
    public static <T> Result<T> createFailure(String failureMessage) {
        if(StringUtils.isBlank(failureMessage))
        {
            return createFailure();
        }
        try {
            return new Result<T>(ResultCode.valueOf(failureMessage).getCode(), failureMessage);
        }
        catch (Exception ex)
        {
            return new Result<T>(ResultCode.FAILURE.getCode(), failureMessage);
        }
    }

    public static <T> Result<T> createFailure(int failureCode, String failureMessage) {
        return new Result<T>(failureCode, failureMessage);
    }

}
