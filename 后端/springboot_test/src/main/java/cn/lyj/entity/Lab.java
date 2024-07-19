package cn.lyj.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @ClassName laboratory
 * @Description TODO
 * @Author 29324
 * @DATE 2024/7/3 下午2:24
 * @Version 1.0
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Lab {
    //实验室ID
    private Integer labId;
    //实验室名称
    private String labName;
    //实验室位置
    private String labLocation;
    //实验室容量
    private Integer labCapacity;
    //记录创建时间
    private Date labCreateTime;
    //记录更新时间
    private Date labUpdateTime;
    //实验室描述
    private String labDescription;
    //管理员
    private String labManager;

}
