package cn.lyj.mapper;

import cn.lyj.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

    List<User> selectAll(String name, String phone);

    Integer del(Integer id);

    Integer add(User user);

    User getUserByPhone(String phone);

    User getUserByLoginInfo(User loginInfo);

    User findById(Integer id);

    Integer updateById(@Param("user") User user);

    Integer delByIds(int[] ids);

    int updatePasswordByEmail(String email, String newPassword);

    List<User> selectAllSuper(String name, String phone);
}
