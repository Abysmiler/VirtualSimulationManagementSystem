package cn.lyj.mapper;

import cn.lyj.entity.Device;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DeviceMapper {
    List<Device> searchDevices(@Param("simulationDeviceName") String simulationDeviceName);

    int updateDevice(Device device);

    int deleteDevice(Integer id);

    Device getDeviceById(Integer id);

    int addDevice(Device device);
}
