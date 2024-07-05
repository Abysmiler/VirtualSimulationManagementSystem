package cn.lyj.controller;

import cn.lyj.common.Result;
import cn.lyj.entity.Resource;
import cn.lyj.service.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    ResourceService resourceService;

    @GetMapping("/searchResources")
    public Result searchResources(String resourceName) {
        List<Resource> resources = resourceService.searchResources(resourceName);
        return Result.success(resources);
    }

    @PostMapping("/update")
    public Result updateResource(@RequestBody Resource resource) {
        boolean updated = resourceService.updateResource(resource);
        if (updated) {
            return Result.success();
        } else {
            return Result.error();
        }
    }

    @DeleteMapping("/delete/{resourceId}")
    public Result deleteResource(@PathVariable("resourceId") Integer resourceId) {
        boolean deleted = resourceService.deleteResource(resourceId);
        if (deleted) {
            return Result.success();
        } else {
            return Result.error();
        }
    }

    @PostMapping("/addResource")
    public Result addResource(@RequestBody Resource resource) {
        boolean added = resourceService.addResource(resource);
        if (added) {
            return Result.success();
        } else {
            return Result.error();
        }
    }
}
