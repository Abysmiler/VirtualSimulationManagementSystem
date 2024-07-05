package cn.lyj.controller;

import cn.lyj.common.Result;
import cn.lyj.entity.Course;
import cn.lyj.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @ClassName CourseController
 * @Description TODO
 * @Author 29324
 * @DATE 2024/7/3 上午8:54
 * @Version 1.0
 */


@RestController
@RequestMapping("/course")
@CrossOrigin

public class CourseController {

    @Autowired
    CourseService courseService;

    //    查询全部课程
    @GetMapping("/selectAll")
    public Result selectAll(String courseName) {
        System.out.println(courseName);
        List<Course> courses = courseService.selectAll(courseName);
        return Result.success(courses);
    }

    @PostMapping("/update")
    public Result updateCourse(@RequestBody Course course) {
        boolean updated = courseService.updateCourse(course);
        if (updated) {
            return Result.success();
        } else {
            return Result.error();
        }
    }

    @PostMapping("/addCourse")
    public Result addCourse(@RequestBody Course course) {
        boolean added = courseService.addCourse(course);
        if (added) {
            return Result.success();
        } else {
            return Result.error("添加失败，课程ID已存在");
        }
    }

    @DeleteMapping("/delete/{courseId}")
    public Result deleteCourse(@PathVariable("courseId") Integer courseId) {
        boolean deleted = courseService.deleteCourse(courseId);
        if (deleted) {
            return Result.success();
        } else {
            return Result.error();
        }
    }


}
