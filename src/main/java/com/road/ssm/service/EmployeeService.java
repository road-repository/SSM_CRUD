package com.road.ssm.service;

import com.road.ssm.bean.Employee;
import com.road.ssm.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    /*获取所有的员工*/
    public List<Employee> getAll() {
        List<Employee> employeeList = employeeMapper.selectByExampleWithDept(null);
        return employeeList;
    }

    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /*添加员工*/
    public Integer addEmp(Employee emp) {
        return employeeMapper.insertSelective(emp);
    }

    /*修改员工*/
    public Integer editEmp(Employee employee) {
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /*删除员工*/
    public Integer deleteEmp(Integer id) {
        return employeeMapper.deleteByPrimaryKey(id);
    }

}
