package cn.lyj.mapper;

import cn.lyj.entity.Resource;

import java.util.List;

public interface ResourceMapper {
    List<Resource> searchResources(String resourceName);

    int updateResource(Resource resource);

    int deleteResource(Integer resourceId);

    int addResource(Resource resource);

    Resource getResourceById(Integer resourceId);
}
