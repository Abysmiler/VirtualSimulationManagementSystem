package cn.lyj.common;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import cn.lyj.entity.User;
import cn.lyj.service.UserService;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.Date;


public class JwtTokenUtil {
    public static UserService staticUserService;
    private static final Logger log = LoggerFactory.getLogger((JwtTokenUtil.class));

    @Resource
    private UserService userService;

    @PostConstruct
    public void setUserService() {
        staticUserService = userService;
    }

    /**
     * 生成token
     * @param userId
     * @param password
     * @return
     */
public static String getToken(String userId, String password) {
    return JWT.create()
            .withAudience(userId) //通过userId创建token,作为载荷
            .withExpiresAt(DateUtil.offsetHour(new Date(), 2))//    2小时过期
            .sign(Algorithm.HMAC512(password)); //以password作为token的密钥
}


public static User getCurrentUser() {
    String token = null;
    try {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        token = request.getHeader("token");
        if (StrUtil.isBlank(token)) {
            token = request.getParameter("token");
        }
        if (StrUtil.isBlank(token)) {
            log.error("获取当前登录的token失败,token:{}", token);
            return null;
        }
        //解析token,获取用户id
        String userId = JWT.decode(token).getAudience().get(0);
        return staticUserService.findById(Integer.valueOf(userId));
    } catch (Exception e) {
        log.error("获取当前登录的管理员信息失败,token={}", token, e);
        return null;
    }
}

}

