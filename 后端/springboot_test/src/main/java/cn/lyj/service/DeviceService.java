package cn.lyj.service;

import cn.lyj.entity.Device;

import java.util.List;

public interface DeviceService {
    List<Device> searchDevice(String simulationDeviceName);

    boolean updateDevice(Device device);

    boolean deleteDevice(Integer simulationDeviceId);

    boolean addDevice(Device device);
}
