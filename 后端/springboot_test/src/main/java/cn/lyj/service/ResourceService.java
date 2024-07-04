package cn.lyj.service;

import cn.lyj.entity.Resource;

import java.util.List;

public interface ResourceService {
    List<Resource> searchResources(String name);

    boolean updateResource(Resource resource);

    boolean deleteResource(Integer id);

    boolean addResource(Resource resource);
}
