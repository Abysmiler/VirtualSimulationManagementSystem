package cn.lyj.mapper;

import cn.lyj.entity.Resource;

import java.util.List;

public interface ResourceMapper {
    List<Resource> searchResources(String name);

    int updateResource(Resource resource);

    int deleteResource(Integer id);

    int addResource(Resource resource);

    Resource getResourceById(Integer id);
}
