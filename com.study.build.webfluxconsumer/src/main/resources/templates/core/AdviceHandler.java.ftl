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
import lombok.extern.slf4j.Slf4j;
import reactor.core.publisher.Mono;

@ControllerAdvice
@Slf4j
public class AdviceHandler {

//空指针异常
@ExceptionHandler(NullPointerException.class)
@ResponseBody
public Mono
<Result> nullPointerExceptionHandler(NullPointerException ex) {
    log.error(ex.toString());
    return Mono.just(Result.createFailure(ex.toString()));
    }

    //类型转换异常
    @ExceptionHandler(ClassCastException.class)
    @ResponseBody
    public Mono
    <Result> classCastExceptionHandler(ClassCastException ex) {
        log.error(ex.toString());
        return Mono.just(Result.createFailure(ex.toString()));
        }

        //IO异常
        @ExceptionHandler(IOException.class)
        @ResponseBody
        public Mono
        <Result> iOExceptionHandler(IOException ex) {
            log.error(ex.toString());
            return Mono.just(Result.createFailure(ex.toString()));
            }

            //未知方法异常
            @ExceptionHandler(NoSuchMethodException.class)
            @ResponseBody
            public Mono
            <Result> noSuchMethodExceptionHandler(NoSuchMethodException ex) {
                log.error(ex.toString());
                return Mono.just(Result.createFailure(ex.toString()));
                }

                //数组越界异常
                @ExceptionHandler(IndexOutOfBoundsException.class)
                @ResponseBody
                public Mono
                <Result> indexOutOfBoundsExceptionHandler(IndexOutOfBoundsException ex) {
                    log.error(ex.toString());
                    return Mono.just(Result.createFailure(ex.toString()));
                    }

                    //400错误
                    @ExceptionHandler({HttpMessageNotReadableException.class})
                    @ResponseBody
                    public Mono
                    <Result> requestNotReadable(HttpMessageNotReadableException ex) {
                        log.error(ex.toString());
                        return Mono.just(Result.createFailure(400,ex.toString()));

                        }

                        //400错误
                        @ExceptionHandler({TypeMismatchException.class})
                        @ResponseBody
                        public Mono
                        <Result> requestTypeMismatch(TypeMismatchException ex) {
                            log.error(ex.toString());
                            return Mono.just(Result.createFailure(400,ex.toString()));
                            }

                            //400错误
                            //@ExceptionHandler({MissingServletRequestParameterException.class})
                            //@ResponseBody
                            // public Result requestMissingServletRequest(MissingServletRequestParameterException ex) {
                            // log.error(ex.toString());
                            // return Result.createFailure(400,ex.toString());
                            // }

                            //405错误
                            // @ExceptionHandler({HttpRequestMethodNotSupportedException.class})
                            //@ResponseBody
                            //public Result request405(HttpRequestMethodNotSupportedException ex) {
                            // log.error(ex.toString());
                            // return Result.createFailure(405,ex.toString());
                            // }

                            //406错误
                            // @ExceptionHandler({HttpMediaTypeNotAcceptableException.class})
                            // @ResponseBody
                            // public Result request406(HttpMediaTypeNotAcceptableException ex) {
                            // log.error(ex.toString());
                            // return Result.createFailure(406,ex.toString());
                            //}

                            //500错误
                            @ExceptionHandler({ConversionNotSupportedException.class,
                            HttpMessageNotWritableException.class})
                            @ResponseBody
                            public Mono
                            <Result> server500(RuntimeException ex) {
                                log.error(ex.toString());
                                return Mono.just(Result.createFailure(500,ex.toString()));
                                }

                                @ExceptionHandler(BindException.class)
                                @ResponseBody
                                public Mono
                                <Result> validBindExceptionHandler(BindException ex) {
                                    return parameterException(ex.getBindingResult().getFieldErrors());
                                    }
                                    @ExceptionHandler(ConstraintViolationException.class)
                                    @ResponseBody
                                    public Mono
                                    <Result> validConstraintViolationException(ConstraintViolationException ex) {
                                        List
                                        <String> errors = new ArrayList<>();
                                            Set
                                            <ConstraintViolation
                                            <?>> violations = ex.getConstraintViolations();
                                            for (ConstraintViolation<?> item : violations) {
                                            errors.add(item.getMessage());
                                            }
                                            log.error(errors.toString());
                                            return Mono.just(Result.createFailure(ResultCode.PARAM_NOT_FORMAT.getCode(),
                                            errors.toString()));
                                            }

                                            /**
                                            * 统一处理验证错误
                                            *
                                            * @param bindException
                                            * @return
                                            */
                                            @ExceptionHandler(MethodArgumentNotValidException.class)
                                            @ResponseBody
                                            public Mono
                                            <Result>
                                                validMethodArgumentNotValidExceptionHandler(MethodArgumentNotValidException
                                                bindException) {
                                                return
                                                parameterException(bindException.getBindingResult().getFieldErrors());
                                                }

                                                public Mono
                                                <Result> parameterException(List
                                                    <FieldError> fieldErrors) {
                                                        List
                                                        <String> errors = new ArrayList<>();

                                                            // List
                                                            <FieldError> fieldErrors =
                                                                bindException.getBindingResult().getFieldErrors();
                                                                for (FieldError fieldError : fieldErrors) {
                                                                errors.add(fieldError.getField() + ":" +
                                                                fieldError.getDefaultMessage());
                                                                }
                                                                log.error(errors.toString());
                                                                return
                                                                Mono.just(Result.createFailure(ResultCode.PARAM_NOT_FORMAT.getCode(),
                                                                errors.toString()));
                                                                }
                                                                //运行时异常
                                                                @ExceptionHandler(RuntimeException.class)
                                                                @ResponseBody
                                                                public Mono
                                                                <Result> runtimeExceptionHandler(RuntimeException ex) {
                                                                    log.error(ex.toString());
                                                                    return
                                                                    Mono.just(Result.createFailure(ex.toString()));
                                                                    }
                                                                    }
