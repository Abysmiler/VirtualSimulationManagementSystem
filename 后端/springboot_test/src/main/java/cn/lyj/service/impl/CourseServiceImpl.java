package cn.lyj.service.impl;

import cn.lyj.entity.Course;
import cn.lyj.mapper.CourseMapper;
import cn.lyj.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseServiceImpl implements CourseService{

    @Autowired
    CourseMapper courseMapper;

    public List<Course> selectAll(String courseName) {
        List<Course> list = courseMapper.selectAll(courseName);
        return list;
    }

    @Override
    public boolean updateCourse(Course course) {
        int result = courseMapper.updateCourse(course);
        return result > 0;
    }

    @Override
    public boolean addCourse(Course course) {
        //如果课程已存在，返回false
        if (checkCourseExists(course.getCourseId())) {
            return false;
        }
        //如果课程不存在，添加课程
        return courseMapper.addCourse(course) > 0;
    }

    @Override
    public boolean deleteCourse(Integer courseId) {
        return courseMapper.deleteCourse(courseId) > 0;
    }

    private boolean checkCourseExists(Integer id) {
        Course course = courseMapper.getCourseById(id);
        return course != null;
    }

}
