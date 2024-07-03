package cn.lyj.controller;

import cn.lyj.common.JwtTokenUtil;
import cn.lyj.common.Result;
import cn.lyj.entity.User;
import cn.lyj.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * @author 29324
 */
//告诉Springboot当前类是一个控制器，可以接收前端请求，交给Spring容器管理。

//@Controller //默认返回时会经过视图解析器
@RestController
@RequestMapping("/user")
@CrossOrigin
public class UserController {
    //要做什么事，具体的功能是什么

//    @ResponseBody //表示返回不经过视图解析器，而是经过json格式的数据

    @Autowired
    UserService userService;

    //    查询全部用户
    @GetMapping("/selectAll")
    public Result selectAll() {
        List<User> users = userService.selectAll();
        return Result.success(users);
//        return Result.error("别看了，啥也没有");
    }

    //    查询某个用户
    @GetMapping("/selectOne")
    public Result selectOne(String name, String phone) {
        System.out.println(name);
        System.out.println(phone);
        List<User> user = userService.selectOne(name, phone);
        return Result.success(user);
    }


    @DeleteMapping("/del/{id}")
    public Result delById(@PathVariable Integer id) {
        Integer i = userService.delById(id);
        if (i != 1) {
            return Result.error();
        }
        return Result.success();
    }

//    //批量删除
//    @DeleteMapping("/delBatch/{ids}")
//    public Result delByIds(@PathVariable int[] ids) {
//        Integer i = userService.delByIds(ids);
//        if (i == 0) {
//            return Result.error();
//        }
//        return Result.success();
//    }

    @PostMapping("/register")
    public Result register(@RequestBody User user) {
        //验证用户账户的合法性
        //1.判断用户必要信息是否为空 （手机号、学号、姓名、用户名）
        if (user.getName().isEmpty() ||
                user.getUsername().isEmpty() ||
                user.getPassword().isEmpty() ||
                user.getEmail().isEmpty() ||
                user.getPhone().isEmpty() ||
                user.getType().isEmpty()) {
            return Result.error("注册信息不完整");
        }
        //2.某些信息是否可以重复，如果不能重复的，需要判断是否已被使用
        //判断手机号是否已被使用
        //1.根据手机号查询user表，如果存在该手机号的用户，那么提示前端该手机号已被注册
        User dataBaseUser = userService.getUserByPhone(user.getPhone());
        //2.如果不存在，继续往后执行
        if (dataBaseUser != null) {
            return Result.error("该手机号已经注册");
        }
        user.setCreateTime(new Date());
        Integer i = userService.addUser(user);
        if (i == 1) {
            //保存注册信息到用户表，返回成功给前端
            return Result.success();
        }
        return Result.error("注册用户添加失败");
        //3.检验两次密码输入是否一致，保证代码的健壮性
    }

    @PostMapping("/login")
    public Result login(@RequestBody User loginInfo) {
        //根据提交的登录信息查询数据库
        User user = userService.getUserByLoginInfo(loginInfo);
        if (user == null) {
            return Result.error("请输入正确的账户或密码");
        }
//       如果查询到了用户，说明账户和密码都正确，那么生成Token返回前端
        String token = JwtTokenUtil.getToken(String.valueOf(user.getId()), user.getPassword());
        user.setToken(token);
        return Result.success(user);
    }

    /*
     * @Author 29324
     * @Description 信息更新
     * @Date 上午8:45 2024/6/29
     * @Param
     * @return cn.lyj.common.Result
     **/
    @PostMapping("/update")
    public Result update( @RequestBody User user) {
        Integer i = userService.updateById(user);
        if (i != 1) {
            return Result.error();
        } else {
            return Result.success(user);
        }
    }
}
