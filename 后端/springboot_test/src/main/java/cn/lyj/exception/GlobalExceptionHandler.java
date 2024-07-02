package cn.lyj.exception;

import cn.lyj.common.Result;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @ClassName GlobalExceptionHandler
 * @Description 全局异常处理器  作用：捕获程序运行时的错误
 * @Author 29324
 * @DATE 2024/6/27 下午3:25
 * @Version 1.0
 */
@ControllerAdvice(basePackages = "cn.lyj.controller")
public class GlobalExceptionHandler {
    //打印日志
    public static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    //统一异常处理@ExceptionHandler，主要用于捕获所有controller的Exception
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result error(HttpServletRequest request, Exception e) {
        log.error("异常信息",e);
        return Result.error("系统异常");
    }

    //捕获自定义异常
    @ExceptionHandler(CustomException.class)
    @ResponseBody
    public Result customError(HttpServletRequest request, CustomException e) {

        return Result.error(e.getMsg());
    }
}


