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
    public Result searchLabs(String name) {
        List<Lab> labs = labService.searchLabs(name);
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

    @DeleteMapping("/delete/{id}")
    public Result deleteLab(@PathVariable("id") Integer id) {
        boolean deleted = labService.deleteLab(id);
        if (deleted) {
            return Result.success();
        } else {
            return Result.error();
        }
    }
}
