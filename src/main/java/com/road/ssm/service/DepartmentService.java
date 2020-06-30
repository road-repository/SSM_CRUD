package com.road.ssm.service;

import com.road.ssm.bean.Department;
import com.road.ssm.bean.DepartmentExample;
import com.road.ssm.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    /*获取所有的部门信息*/
    public List<Department> getDepartments() {
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }


}
