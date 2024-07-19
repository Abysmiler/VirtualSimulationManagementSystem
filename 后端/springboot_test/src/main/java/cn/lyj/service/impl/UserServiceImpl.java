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
    public List<User> selectAll() {
        List<User> list = userMapper.selectAll();
        return list;
    }

    @Override
    public List<User> selectOne(String name,String phone) {
        List<User> list = userMapper.selectOne(name,phone);
        return list;
    }

    @Override
    public Integer delById(Integer id) {
        return userMapper.deleteById(id);

    }

//    @Override
//    public Integer delByIds(int[] ids) {
//        return userMapper.deleteByIds(ids);
//    }
//
    @Override
    public Integer updateById(User user) {
        return userMapper.updateById(user);
    }

    @Override
    public Integer addUser(User user) {
        return userMapper.addUser(user);
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
