package cn.lyj.mapper;

import cn.lyj.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

    List<User> selectAll();

    List<User> selectOne(String name, String phone);

    Integer deleteById(Integer id);
//
//    Integer deleteByIds(int[] ids);

    Integer addUser(User user);

    User getUserByPhone(String phone);

    User getUserByLoginInfo(User loginInfo);

    User findById(Integer id);

    Integer updateById(@Param("user") User user);
}
