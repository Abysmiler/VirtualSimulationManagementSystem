package cn.lyj.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import cn.lyj.common.Result;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

/**
 * @ClassName FilerController
 * @Description TODO
 * @Author 29324
 * @DATE 2024/7/8 上午8:26
 * @Version 1.0
 */

@CrossOrigin
@RestController
@RequestMapping("/files")
public class FilerController {
    //    文件上传存储路径
    private static final String filePath = System.getProperty("user.dir") + "/file/";

    //    文件上传
    @PostMapping("/upload")
    public Result upload(MultipartFile file) {
        synchronized (FilerController.class) {
            // 获取文件时间戳
            String flag = System.currentTimeMillis() + "";
            // 获取原始文件名
            String fileName = file.getOriginalFilename();
            try {
                // 如果没有file文件夹，会在项目根目录创建一个
                if (!FileUtil.isDirectory(filePath)) {
                    FileUtil.mkdir(filePath);
                }
                //文件存储形式：时间戳-文件名
                FileUtil.writeBytes(file.getBytes(), filePath + flag + "-" + fileName);
                System.out.println(fileName + "--上传成功");
                Thread.sleep(1L);
            } catch (Exception e) {
                System.err.println(fileName + "--文件上传失败");
            }
            return Result.success(flag);
        }
    }

    //获取文件
    @GetMapping("/{flag}")
    public void avatarPath(@PathVariable String flag, HttpServletResponse response) throws IOException {
        // 检查文件目录是否存在，如果不存在则创建该目录
        if (!FileUtil.isDirectory(filePath)) {
            FileUtil.mkdir(filePath);
        }
        OutputStream os;
        // 获取文件目录中的所有文件名列表
        List<String> fileNames = FileUtil.listFileNames(filePath);
        // 在文件名列表中查找包含`flag`的文件名
        String avatar = fileNames.stream().filter(name -> name.contains(flag)).findAny().orElse("");
        try {
            // 如果找到相应的文件名
            if (StrUtil.isNotEmpty(avatar)) {
                // 设置响应头，指定文件下载时的文件名
                response.addHeader("Content-Disposition", "attachment;filename=" +
                        URLEncoder.encode(avatar, "UTF-8"));
                response.setContentType("application/octet-stream");
                // 读取文件内容为字节数组
                byte[] bytes = FileUtil.readBytes(filePath + avatar);
                // 获取输出流
                os = response.getOutputStream();
                // 将文件内容写入输出流·
                os.write(bytes);
                os.flush();
                os.close();
            }
        } catch (Exception e) {
            // 捕获异常，打印错误信息
            System.out.println("文件下载失败");
        }
    }
}