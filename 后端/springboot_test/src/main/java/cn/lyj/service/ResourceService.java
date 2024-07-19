package cn.lyj.service;

import cn.lyj.entity.Resource;

import java.util.List;

public interface ResourceService {
    List<Resource> searchResources(String resourceName);

    boolean updateResource(Resource resource);

    boolean deleteResource(Integer resourceId);

    boolean addResource(Resource resource);
}
