package cn.lyj.service;

import cn.lyj.entity.Device;

import java.util.List;

public interface DeviceService {
    List<Device> searchDevice(String name);

    boolean updateDevice(Device device);

    boolean deleteDevice(Integer id);

    boolean addDevice(Device device);
}
