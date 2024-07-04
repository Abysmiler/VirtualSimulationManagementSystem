package cn.lyj.service.impl;

import cn.lyj.entity.Lab;
import cn.lyj.mapper.LabMapper;
import cn.lyj.service.LabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LabServiceImpl implements LabService {

    @Autowired
    LabMapper labMapper;

    @Override
    public List<Lab> searchLabs(String name) {
        List<Lab> list = labMapper.searchLabs(name);
        return list;
    }

    @Override
    public boolean updateLab(Lab lab) {
        return labMapper.updateLab(lab) > 0;
    }

    @Override
    public boolean addLab(Lab lab) {
        if (checkLabExists(lab.getLabId())) {
            return false;
        }
        return labMapper.addLab(lab) > 0;
    }

    @Override
    public boolean deleteLab(Integer id) {
        return labMapper.deleteLab(id) > 0;
    }

    @Override
    public boolean checkLabExists(Integer id) {
        Lab lab = labMapper.getLabById(id);
        return lab != null;
    }
}
