package cn.lyj.exception;

public class CustomException extends RuntimeException{

    static final long serialVersionUID = 11232L;

    private String msg;


    public CustomException(String msg) {
        this.msg = msg;
    }

    public String getMsg(){
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}


