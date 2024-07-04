package cn.lyj.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @ClassName Resource
 * @Description TODO
 * @Author 29324
 * @DATE 2024/7/3 下午2:28
 * @Version 1.0
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Resource {
   //实训资源ID
   private Integer resourceId;
   //实训资源名称
   private String resourceName;
   //实训资源类型（如：文档、视频等）
   private String resourceType;
   //实训资源内容
   private String resourceContent;
   //记录创建时间
   private Date resourceCreateTime;
   //记录更新时间
   private Date resourceUpdateTime;
   //实训资源描述
   private String resourceDescription;

}
