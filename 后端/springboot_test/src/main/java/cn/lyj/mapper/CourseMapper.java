package cn.lyj.mapper;

import cn.lyj.entity.Course;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CourseMapper {
    List<Course> selectAll(@Param("courseName") String courseName);

    int updateCourse(Course course);

    int addCourse(Course course);

    Course getCourseById(Integer id);

    int deleteCourse(Integer id);
}
