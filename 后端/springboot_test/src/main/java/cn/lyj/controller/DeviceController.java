package cn.lyj.controller;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import cn.lyj.common.Result;
import cn.lyj.entity.Device;
import cn.lyj.exception.CustomException;
import cn.lyj.service.DeviceService;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
@RequestMapping("/device")
public class DeviceController {

    @Autowired
    DeviceService deviceService;

    @GetMapping("/searchDevices")
    public Result searchDevices(String simulationDeviceName) {
        List<Device> devices = deviceService.searchDevice(simulationDeviceName);
        return Result.success(devices);
    }

    @PostMapping("/update")
    public Result updateDevice(@RequestBody Device device) {
        boolean updated = deviceService.updateDevice(device);
        if (updated) {
            return Result.success();
        } else {
            return Result.error();
        }
    }

    @DeleteMapping("/delete/{simulationDeviceId}")
    public Result deleteDevice(@PathVariable("simulationDeviceId") Integer simulationDeviceId) {
        boolean deleted = deviceService.deleteDevice(simulationDeviceId);
        if (deleted) {
            return Result.success();
        } else {
            return Result.error();
        }
    }

    @PostMapping("/addDevice")
    public Result addDevice(@RequestBody Device device) {
        boolean added = deviceService.addDevice(device);
        if (added) {
            return Result.success();
        } else {
            return Result.error("添加失败，设备ID已存在");
        }
    }

    @DeleteMapping("/deleteDevices/{simulationDeviceIds}")
    public Result deleteDevices(@PathVariable("simulationDeviceIds") String simulationDeviceIdsStr) {
        String[] simulationDeviceIdsArray = simulationDeviceIdsStr.split(",");
        List<Integer> simulationDeviceIds = new ArrayList<>();
        for (String idStr : simulationDeviceIdsArray) {
            simulationDeviceIds.add(Integer.parseInt(idStr));
        }
        boolean deleted = deviceService.deleteDevices(simulationDeviceIds);
        if (deleted) {
            return Result.success();
        } else {
            return Result.error();
        }
    }

    @GetMapping("/export")
    public Result export(HttpServletResponse response) throws IOException {

        // 一行一行的组装数据，放到一个List里面
        // 每一行数据，对应数据库表中的一行数据，也就是对应Java的一个实体类
        // 我们怎么知道它某一列就是对应某个表头呢？？需要映射数据，我们需要一个Map<key，value>，把这个map放到List里

        // 1.从数据库中查询出所有数据
        List<Device> all = deviceService.searchDevice();
        if (CollectionUtil.isEmpty(all)) {
            throw new CustomException("未找到数据");
        }

        // 2.定义一个List 和 Map<key,value>出来，存储处理之后的数据，用于放到List 里
        List<Map<String, Object>> list = new ArrayList<>(all.size());

        // 3.遍历每一条数据，然后封装到 Map<key,vaLue>里，把这个 map 塞到List 里
        for (Device device : all) {
            Map<String, Object> row = new HashMap<>();
            row.put("设备ID", device.getSimulationDeviceId());
            row.put("设备名称", device.getSimulationDeviceName());
            row.put("设备类型", device.getSimulationDeviceType());
            row.put("实验室ID", device.getSimulationDeviceLabId());
            row.put("设备状态", device.getSimulationDeviceStatus());
            row.put("设备描述", device.getSimulationDeviceDescription());
            list.add(row);
        }
        // 4.创建一个ExceLWriter，把List数据用这个writer写出来（生成出来）
        ExcelWriter wr = ExcelUtil.getWriter(true);
        wr.write(list, true);
        // 5.把这个excel下载下来
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename=device.xlsx");
        ServletOutputStream out = response.getOutputStream();
        wr.flush(out, true);
        wr.close();
        IoUtil.close(System.out);

        return Result.success();
    }

    @PostMapping("/upload")
    public Result upload(MultipartFile file) throws IOException {
        List<Device> infoList = ExcelUtil.getReader(file.getInputStream()).readAll(Device.class);
        if (!CollectionUtil.isEmpty(infoList)) {
            for (Device device : infoList) {
                try {
                    deviceService.addDevice(device);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return Result.success();
    }

}
