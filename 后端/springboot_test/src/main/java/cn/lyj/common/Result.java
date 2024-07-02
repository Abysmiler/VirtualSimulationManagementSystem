package cn.lyj.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor


public class Result {
    //定义静态常量/也可以定义枚举类型
    public static final String SUCCESS = "0";
    public static final String ERROR = "-1";

    //存放成功与否的表示
    private String code;
    //错误信息
    private String msg;
    //数据
    private Object data;

    //为什么要定义静态方法,因为可以直接使用类名.方法,而不再需要实例化对象
    //只返回成功标识
    public static Result success() {
        Result result = new Result();
        result.setCode(SUCCESS);
        return result;
    }

    //返回成功标识及数据
    public static Result success(Object data) {
        Result result = new Result();
        result.setCode(SUCCESS);
        result.setData(data);
        return result;
    }

    //返回错误标识及错误信息
    public static Result error(String msg) {
        Result result = new Result();
        result.setCode(ERROR);
        result.setMsg(msg);
        result.setData(msg);
        return result;
    }

    public static Result error() {
        Result result = new Result();
        result.setCode(ERROR);
        return result;
    }

}
