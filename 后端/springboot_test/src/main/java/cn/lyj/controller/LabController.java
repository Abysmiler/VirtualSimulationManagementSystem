package cn.lyj.controller;

import cn.lyj.common.Result;
import cn.lyj.entity.Lab;
import cn.lyj.service.LabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/lab")
public class LabController {

    @Autowired
    LabService labService;

    @GetMapping("/searchLabs")
    public Result searchLabs(String labName) {
        List<Lab> labs = labService.searchLabs(labName);
        return Result.success(labs);
    }

    @PostMapping("/update")
    public Result updateLab(@RequestBody Lab lab) {
        boolean updated = labService.updateLab(lab);
        if (updated) {
            return Result.success();
        } else {
            return Result.error();
        }
    }

    @PostMapping("/addLab")
    public Result addLab(@RequestBody Lab lab) {
        boolean added = labService.addLab(lab);
        if (added) {
            return Result.success();
        } else {
            return Result.error("添加失败，实验室ID已存在");
        }
    }

    @DeleteMapping("/delete/{labId}")
    public Result deleteLab(@PathVariable("labId") Integer labId) {
        boolean deleted = labService.deleteLab(labId);
        if (deleted) {
            return Result.success();
        } else {
            return Result.error();
        }
    }
}
