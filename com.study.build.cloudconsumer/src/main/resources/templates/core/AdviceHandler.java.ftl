package ${packageName}.core;

import org.springframework.beans.ConversionNotSupportedException;
import org.springframework.beans.TypeMismatchException;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.HttpMediaTypeNotAcceptableException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@ControllerAdvice
public class AdviceHandler {

    //空指针异常
    @ExceptionHandler(NullPointerException.class)
    @ResponseBody
    public Result nullPointerExceptionHandler(NullPointerException ex) {
        ex.printStackTrace();
        return Result.createFailure(ex.toString());
    }

    //类型转换异常
    @ExceptionHandler(ClassCastException.class)
    @ResponseBody
    public Result classCastExceptionHandler(ClassCastException ex) {
        ex.printStackTrace();
        return Result.createFailure(ex.toString());
    }

    //IO异常
    @ExceptionHandler(IOException.class)
    @ResponseBody
    public Result iOExceptionHandler(IOException ex) {
        ex.printStackTrace();
        return Result.createFailure(ex.toString());
    }

    //未知方法异常
    @ExceptionHandler(NoSuchMethodException.class)
    @ResponseBody
    public Result noSuchMethodExceptionHandler(NoSuchMethodException ex) {
        ex.printStackTrace();
        return Result.createFailure(ex.toString());
    }

    //数组越界异常
    @ExceptionHandler(IndexOutOfBoundsException.class)
    @ResponseBody
    public Result indexOutOfBoundsExceptionHandler(IndexOutOfBoundsException ex) {
        ex.printStackTrace();
        return Result.createFailure(ex.toString());
    }

    //400错误
    @ExceptionHandler({HttpMessageNotReadableException.class})
    @ResponseBody
    public Result requestNotReadable(HttpMessageNotReadableException ex) {
        // System.out.println("400..requestNotReadable");
        ex.printStackTrace();
        return Result.createFailure(400,ex.toString());

    }

    //400错误
    @ExceptionHandler({TypeMismatchException.class})
    @ResponseBody
    public Result requestTypeMismatch(TypeMismatchException ex) {
        // System.out.println("400..TypeMismatchException");
        ex.printStackTrace();
        return Result.createFailure(400,ex.toString());
    }

    //400错误
    @ExceptionHandler({MissingServletRequestParameterException.class})
    @ResponseBody
    public Result requestMissingServletRequest(MissingServletRequestParameterException ex) {
        //  System.out.println("400..MissingServletRequest");
        ex.printStackTrace();
        return Result.createFailure(400,ex.toString());
    }

    //405错误
    @ExceptionHandler({HttpRequestMethodNotSupportedException.class})
    @ResponseBody
    public Result request405(HttpRequestMethodNotSupportedException ex) {
        return Result.createFailure(405,ex.toString());
    }

    //406错误
    @ExceptionHandler({HttpMediaTypeNotAcceptableException.class})
    @ResponseBody
    public Result request406(HttpMediaTypeNotAcceptableException ex) {

        return Result.createFailure(406,ex.toString());
    }

    //500错误
    @ExceptionHandler({ConversionNotSupportedException.class, HttpMessageNotWritableException.class})
    @ResponseBody
    public Result server500(RuntimeException runtimeException) {

        return Result.createFailure(500,runtimeException.toString());
    }

    @ExceptionHandler(BindException.class)
    @ResponseBody
    public Result validBindExceptionHandler(BindException bindException) {

        return parameterException(bindException.getBindingResult().getFieldErrors());
    }
    @ExceptionHandler(ConstraintViolationException.class)
    @ResponseBody
    public Result validConstraintViolationException(ConstraintViolationException bindException) {
        List<String> errors = new ArrayList<>();
        Set<ConstraintViolation<?>> violations = bindException.getConstraintViolations();
        for (ConstraintViolation<?> item : violations) {
            errors.add(item.getMessage());
        }
        return Result.createFailure(ResultCode.PARAM_NOT_FORMAT.getCode(), errors.toString());
    }

    /**
     * 统一处理验证错误
     *
     * @param bindException
     * @return
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseBody
    public Result validMethodArgumentNotValidExceptionHandler(MethodArgumentNotValidException bindException) {
        return parameterException(bindException.getBindingResult().getFieldErrors());
    }

    public Result parameterException(List<FieldError> fieldErrors) {
        List<String> errors = new ArrayList<>();

        //  List<FieldError> fieldErrors = bindException.getBindingResult().getFieldErrors();
        for (FieldError fieldError : fieldErrors) {
            errors.add(fieldError.getField() + ":" + fieldError.getDefaultMessage());
        }
        return Result.createFailure(ResultCode.PARAM_NOT_FORMAT.getCode(), errors.toString());
    }
    //运行时异常
    @ExceptionHandler(RuntimeException.class)
    @ResponseBody
    public Result runtimeExceptionHandler(RuntimeException runtimeException) {

        return Result.createFailure(runtimeException.toString());
    }

}
