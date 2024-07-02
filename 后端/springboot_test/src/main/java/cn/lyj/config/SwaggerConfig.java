package cn.lyj.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration //声明当前类是一个配置类，交给spring容器管理
public class SwaggerConfig {
    @Bean
    public OpenAPI springShopOpenAPI() {
        return new OpenAPI()
                .info(new Info().title("SpringBoot+Swagger Test")
                        .description("SpringBoot+Vue Test Swagger debugging")
                        .version("v1"));
    }
}

