package cn.lyj.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collection;
import java.util.Date;


/**
 * @author 29324
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    //用户ID
    private Integer id;
    //用户姓名
    private String name;
    //账户
    private String username;
    //密码
    private String password;
    //邮箱
    private String email;
    //介绍、简介
    private String intro;
    //手机号
    private String phone;
    //创建时间
    private Date createTime;
    //更新时间
    private Date updateTime;
    //用户类型
    private String userType;
    //Token
    private String token;
    //用户地址
    private String address;
    //年龄
    private String age;
    //性别
    private String sex;

}

