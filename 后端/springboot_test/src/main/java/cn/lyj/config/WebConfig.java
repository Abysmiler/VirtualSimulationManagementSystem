package cn.lyj.config;

import cn.lyj.common.JwtInterceptor;
import jakarta.annotation.Resource;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration //声明当前类是一个配置类，在Spring容器启动时自动注册
public class WebConfig implements WebMvcConfigurer {

    @Resource
    JwtInterceptor jwtInterceptor;

    //设置自定义JWT拦截器 并配置拦截规则
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(jwtInterceptor)
                .addPathPatterns("/api/**")
                //放行登录、注册，不校验token
                .excludePathPatterns("/api/user/login")
                .excludePathPatterns("/api/user/register")
                .excludePathPatterns("/api/user/findpassword")
                .excludePathPatterns("/api/files/**")
                .excludePathPatterns("/api/device/**");
    }

    //拦截路径
    @Override
    public void configurePathMatch(PathMatchConfigurer configurer) {
        //添加路径前缀为 /api
        configurer.addPathPrefix("/api", clazz -> clazz.isAnnotationPresent(RestController.class));
    }
}

