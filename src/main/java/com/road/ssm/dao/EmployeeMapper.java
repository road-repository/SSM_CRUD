package com.road.ssm.dao;

import com.road.ssm.bean.Employee;
import com.road.ssm.bean.EmployeeExample;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    int countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);

    List<Employee> selectByExampleWithDept(EmployeeExample example);

    Employee selectByPrimaryKey(Integer empId);

    Employee selectByPrimaryKeyWithDept(Integer empId);

    /*自定义的多条件模糊查询*/
    List<Employee> selectByPrimaryLike(@Param("empName") String empName,@Param("empAge")Integer empAge,@Param("empGender")Integer empGender,@Param("dpId")Integer dpId);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);
}