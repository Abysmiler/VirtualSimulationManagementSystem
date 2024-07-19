package cn.lyj.service;

import cn.lyj.entity.User;

import java.util.List;

/**
 * @author 29324
 */
public interface UserService {

    List<User> selectAll(String name, String phone);

    User getUserByPhone(String phone);

    User getUserByLoginInfo(User loginInfo);

    User findById(Integer integer);

    Integer updateById(User user);

    Integer del(Integer id);

    Integer add(User user);

    boolean updatePasswordByEmail(String email, String newPassword);

    List<User> selectAllSuper(String name, String phone);

    User getUserByUsername(String name);
}
