package cn.lyj.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @ClassName Device
 * @Description TODO
 * @Author 29324
 * @DATE 2024/7/3 下午2:18
 * @Version 1.0
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Device {
    //仿真设备ID
    private Integer simulationDeviceId;
    //仿真设备名称
    private String simulationDeviceName;
    //仿真设备类型
    private String simulationDeviceType;
    //设备所在的实验室ID
    private Integer simulationDeviceLabId;
    //设备状态（如：可用、维修中等）
    private String simulationDeviceStatus;
    //记录创建时间
    private Date simulationDeviceCreateTime;
    //记录更新时间
    private Date simulationDeviceUpdateTime;
    //仿真设备描述
    private String simulationDeviceDescription;

}
