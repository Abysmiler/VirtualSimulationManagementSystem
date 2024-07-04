package cn.lyj.controller;

import cn.lyj.common.Result;
import cn.lyj.entity.Device;
import cn.lyj.service.DeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/device")
public class DeviceController {

    @Autowired
    DeviceService deviceService;

    @GetMapping("/searchDevices")
    public Result searchDevices(String name) {
        List<Device> devices = deviceService.searchDevice(name);
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

    @DeleteMapping("/delete/{id}")
    public Result deleteDevice(@PathVariable("id") Integer id) {
        boolean deleted = deviceService.deleteDevice(id);
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
}
