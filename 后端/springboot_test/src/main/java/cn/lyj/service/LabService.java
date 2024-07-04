package cn.lyj.service;

import cn.lyj.entity.Lab;

import java.util.List;

public interface LabService {
    List<Lab> searchLabs(String name);

    boolean updateLab(Lab lab);

    boolean addLab(Lab lab);

    boolean deleteLab(Integer id);

    boolean checkLabExists(Integer id);
}
