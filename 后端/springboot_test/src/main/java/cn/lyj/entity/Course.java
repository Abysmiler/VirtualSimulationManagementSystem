package cn.lyj.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @ClassName Course
 * @Description TODO
 * @Author 29324
 * @DATE 2024/7/3 上午9:33
 * @Version 1.0
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Course {
    //实训课程ID
    private Integer courseId;
    //实训课程名称
    private String courseName;
    //授课教师的用户ID
    private Integer instructorId;
    //使用的实训资源ID
    private Integer resourceId;
    //学时
    private String creditHour;
    //记录创建时间
    private Date courseCreateTime;
    //记录更新时间
    private Date courseUpdateTime;
    //实训课程描述
    private String courseDescription;

}
