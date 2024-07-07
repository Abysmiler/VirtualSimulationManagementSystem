package cn.lyj.controller;

import cn.lyj.common.Result;
import cn.lyj.entity.Resource;
import cn.lyj.service.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    ResourceService resourceService;

    @Value("${file.upload-dir}")
    private String uploadDir;

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

    // 处理文件上传请求的POST方法
    @PostMapping("/upload")
    public ResponseEntity<String> handleFileUpload(@RequestParam("file") MultipartFile file) {
        try {
            // 获取项目根目录并解析相对路径
            String realPath = Paths.get(System.getProperty("user.dir"), uploadDir).toString();
            File uploadDirFile = new File(realPath);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            // 获取上传文件的文件名，并进行规范化处理
            String fileName = file.getOriginalFilename();
            if (fileName == null || fileName.isEmpty()) {
                return new ResponseEntity<>("文件名为空！", HttpStatus.BAD_REQUEST);
            }

            // 防止文件名冲突
            String filePath = Paths.get(uploadDirFile.getAbsolutePath(), System.currentTimeMillis() + "_" + fileName).toString();
            File destFile = new File(filePath);

            // 将文件保存到磁盘
            file.transferTo(destFile);

            return new ResponseEntity<>("文件上传成功！路径：" + filePath, HttpStatus.OK);
        } catch (IOException e) {
            return new ResponseEntity<>("文件上传失败：" + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
