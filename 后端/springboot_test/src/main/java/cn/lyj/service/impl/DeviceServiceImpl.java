package cn.lyj.service.impl;

import cn.lyj.entity.Device;
import cn.lyj.mapper.DeviceMapper;
import cn.lyj.service.DeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeviceServiceImpl implements DeviceService {

    @Autowired
    DeviceMapper deviceMapper;

    @Override
    public List<Device> searchDevice(String name) {
        List<Device> list = deviceMapper.searchDevices(name);
        return list;
    }

    @Override
    public boolean updateDevice(Device device) {
        int result = deviceMapper.updateDevice(device);
        return result > 0;
    }

    @Override
    public boolean deleteDevice(Integer id) {
        return deviceMapper.deleteDevice(id) > 0;
    }

    @Override
    public boolean addDevice(Device device) {
        //如果设备已存在，返回false
        if (checkDeviceExists(device.getSimulationDeviceId())) {
            return false;
        }
        //如果设备不存在，添加设备
        return deviceMapper.addDevice(device) > 0;
    }

    private boolean checkDeviceExists(Integer id) {
        // 检查设备是否存在
        Device device = deviceMapper.getDeviceById(id);
        // 如果设备存在，返回true
        return device != null;
    }
}