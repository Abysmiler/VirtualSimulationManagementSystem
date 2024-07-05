package cn.lyj.service;

import cn.lyj.entity.Course;

import java.util.List;

public interface CourseService {

    List<Course> selectAll(String courseName);

    boolean updateCourse(Course course);

    boolean addCourse(Course course);

    boolean deleteCourse(Integer courseId);
}
