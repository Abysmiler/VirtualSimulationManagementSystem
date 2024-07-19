package cn.lyj.service.impl;

import cn.lyj.entity.Resource;
import cn.lyj.mapper.ResourceMapper;
import cn.lyj.service.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ResourceServiceImpl implements ResourceService {

    @Autowired
    ResourceMapper resourceMapper;

    @Override
    public List<Resource> searchResources(String resourceName) {
        List<Resource> list = resourceMapper.searchResources(resourceName);
        return list;
    }

    @Override
    public boolean updateResource(Resource resource) {
        return resourceMapper.updateResource(resource) > 0;
    }

    @Override
    public boolean deleteResource(Integer resourceId) {
        return resourceMapper.deleteResource(resourceId) > 0;
    }

    @Override
    public boolean addResource(Resource resource) {
        if (checkResourceExists(resource.getResourceId())) {
            return false;
        }
        return resourceMapper.addResource(resource) > 0;
    }

    private boolean checkResourceExists(Integer resourceId) {
        Resource resource = resourceMapper.getResourceById(resourceId);
        return resource != null;
    }
}
