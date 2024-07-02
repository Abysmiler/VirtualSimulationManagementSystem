package cn.lyj.service;

import cn.lyj.entity.User;

import java.util.List;

/**
 * @author 29324
 */
public interface UserService {

    List<User> selectAll();

    List<User> selectOne(String name, String phone);

    Integer addUser(User user);

    User getUserByPhone(String phone);

    User getUserByLoginInfo(User loginInfo);

    User findById(Integer integer);

    Integer updateById(User user);

    Integer delById(Integer id);
}
