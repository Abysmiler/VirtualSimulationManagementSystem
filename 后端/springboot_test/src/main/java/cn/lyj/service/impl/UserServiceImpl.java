package cn.lyj.service.impl;

import cn.lyj.entity.User;
import cn.lyj.mapper.UserMapper;
import cn.lyj.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    @Override
    public List<User> selectAll(String name, String phone) {
        List<User> list = userMapper.selectAll(name,phone);
        return list;
    }

    @Override
    public Integer updateById(User user) {
        return userMapper.updateById(user);
    }

    @Override
    public Integer del(Integer id) {
        return userMapper.del(id);
    }

    @Override
    public Integer add(User user) {
        Integer i = userMapper.add(user);
        return i;
    }

    @Override
    public boolean updatePasswordByEmail(String email, String newPassword) {
        int rowsAffected = userMapper.updatePasswordByEmail(email, newPassword);//修改密码
        return rowsAffected > 0;//返回是否修改成功
    }

    @Override
    public List<User> selectAllSuper(String name, String phone) {
        List<User> list = userMapper.selectAllSuper(name,phone);
        return list;
    }

    @Override
    public User getUserByPhone(String phone) {
        return userMapper.getUserByPhone(phone);
    }

    @Override
    public User getUserByLoginInfo(User loginInfo) {
        return userMapper.getUserByLoginInfo(loginInfo);
    }

    @Override
    public User findById(Integer id) {
        return userMapper.findById(id);
    }
}
