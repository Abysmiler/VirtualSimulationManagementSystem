package cn.lyj.controller;

import cn.lyj.common.JwtTokenUtil;
import cn.lyj.common.Result;
import cn.lyj.entity.User;
import cn.lyj.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author 29324
 */
//告诉Springboot当前类是一个控制器，可以接收前端请求，交给Spring容器管理。

//@Controller //默认返回时会经过视图解析器
@RestController
@RequestMapping("/user")
@CrossOrigin
public class UserController {

    //    @ResponseBody //表示返回不经过视图解析器，而是经过json格式的数据

    @Autowired
    UserService userService;

    //    登录
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

//    //    注册
//    @PostMapping("/register")
//    public Result register(@RequestBody User user) {
//        //验证用户账户的合法性
//        //1.判断用户必要信息是否为空 （手机号、学号、姓名、用户名）
//        if (user.getName().isEmpty() ||
//                user.getUsername().isEmpty() ||
//                user.getPassword().isEmpty() ||
//                user.getEmail().isEmpty() ||
//                user.getPhone().isEmpty() ||
//                user.getUserType().isEmpty()) {
//            return Result.error("注册信息不完整");
//        }
//        //2.某些信息是否可以重复，如果不能重复的，需要判断是否已被使用
//        //判断手机号是否已被使用
//        //2.1根据手机号查询user表，如果存在该手机号的用户，那么提示前端该手机号已被注册
//        User dataBaseUser = userService.getUserByPhone(user.getPhone());
//        //2.2如果不存在，继续往后执行
//        if (dataBaseUser != null) {
//            return Result.error("该手机号已经注册");
//        }
//        user.setCreateTime(new Date());
//        Integer i = userService.add(user);
//        if (i == 1) {
//            //保存注册信息到用户表，返回成功给前端
//            return Result.success();
//        }
//        return Result.error("注册用户添加失败");
//        //3.检验两次密码输入是否一致，保证代码的健壮性
//    }

    // 注册
    @PostMapping("/register")
    public Result register(@RequestBody User user) {
        // 验证用户账户的合法性
        // 1. 判断用户必要信息是否为空（手机号、学号、姓名、用户名）
        if (user.getName() == null || user.getName().isEmpty() ||
                user.getUsername() == null || user.getUsername().isEmpty() ||
                user.getPassword() == null || user.getPassword().isEmpty() ||
                user.getEmail() == null || user.getEmail().isEmpty() ||
                user.getPhone() == null || user.getPhone().isEmpty() ||
                user.getUserType() == null || user.getUserType().isEmpty()) {
            return Result.error("注册信息不完整");
        }

        // 2. 某些信息是否可以重复，如果不能重复的，需要判断是否已被使用
        // 判断手机号是否已被使用
        // 2.1 根据手机号查询user表，如果存在该手机号的用户，那么提示前端该手机号已被注册
        User dataBaseUser = userService.getUserByPhone(user.getPhone());
        // 2.2 如果不存在，继续往后执行
        if (dataBaseUser != null) {
            return Result.error("该手机号已经注册");
        }

        user.setCreateTime(new Date());
        Integer i = userService.add(user);
        if (i != 1) {
            return Result.error("注册用户添加失败");
        }
        // 3. 检验两次密码输入是否一致，保证代码的健壮性
        // 保存注册信息到用户表，返回成功给前端
        return Result.success();
    }

    //    查询用户
    @GetMapping("/selectAll")
    public Result selectAll(String name, String phone) {
        List<User> user = userService.selectAll(name, phone);
        return Result.success(user);
    }


    //    删除某个用户
    @DeleteMapping("/del/{id}")
    public Result del(@PathVariable Integer id) {
        Integer i = userService.del(id);
        if (i != 1) {
            return Result.error();
        }
        return Result.success();
    }

    //    批量删除
    @GetMapping("/del/{ids}")
    public Result delByIds(@PathVariable int[] ids) {
        Integer i = userService.delByIds(ids);
        if (i == 0) {
            return Result.error();
        }
        return Result.success();
    }

    //    更新
    @PostMapping("/update")
    public Result update(@RequestBody User user) {
        Integer i = userService.updateById(user);
        if (i != 1) {
            return Result.error();
        } else {
            return Result.success(user);
        }
    }

    //    添加用户
    @PostMapping("/add")
    public Result add(@RequestBody User user) {
        Integer i = userService.add(user);
        if (i != 1) {
            return Result.error();
        }
        return Result.success();
    }

        @GetMapping("/selectAllSuper")
    public Result selectAllSuper(String name, String phone) {
        List<User> users = userService.selectAllSuper(name, phone);
        return Result.success(users);
    }

    @PostMapping("/findpassword")
    public Result findPassword(@RequestBody Map<String, String> requestMap) {
        String email = requestMap.get("email");//邮箱
        String newPassword = requestMap.get("newPassword");//新密码
        boolean updated = userService.updatePasswordByEmail(email, newPassword);//修改密码
        if (updated) {
            return Result.success();
        } else {
            return Result.error();
        }
    }
}
