package cn.lyj.mapper;

import cn.lyj.entity.Lab;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LabMapper {
    List<Lab> searchLabs(@Param("labName") String labName);

    int updateLab(Lab lab);

    int addLab(Lab lab);

    int deleteLab(Integer labId);

    Lab getLabById(Integer labId);
}
