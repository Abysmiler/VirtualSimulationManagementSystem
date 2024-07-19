package cn.lyj.mapper;

import cn.lyj.entity.Device;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DeviceMapper {
    List<Device> searchDevices(@Param("simulationDeviceName") String simulationDeviceName);

    List<Device> searchDevices();

    int updateDevice(Device device);

    int deleteDevice(Integer simulationDeviceId);

    Device getDeviceById(Integer simulationDeviceId);

    int addDevice(Device device);

    int deleteDevices(int[] simulationDeviceIds);
}
