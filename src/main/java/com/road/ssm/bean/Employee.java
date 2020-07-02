package com.road.ssm.bean;

import java.util.Date;

public class Employee {
    public Employee() {
    }

    public Employee(Integer empId, String empName, Integer empGender, Integer empAge, Date empDateonboard, Integer dpId, Integer verison, Integer logicFlag) {
        this.empId = empId;
        this.empName = empName;
        this.empGender = empGender;
        this.empAge = empAge;
        this.empDateonboard = empDateonboard;
        this.dpId = dpId;
        this.verison = verison;
        this.logicFlag = logicFlag;
    }

    private Integer empId;

    private String empName;

    private Integer empGender;

    private Integer empAge;

    private Date empDateonboard;

    private Integer dpId;

    private Integer verison;

    private Integer logicFlag;

    private Department department;

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public Integer getEmpGender() {
        return empGender;
    }

    public void setEmpGender(Integer empGender) {
        this.empGender = empGender;
    }

    public Integer getEmpAge() {
        return empAge;
    }

    public void setEmpAge(Integer empAge) {
        this.empAge = empAge;
    }

    public Date getEmpDateonboard() {
        return empDateonboard;
    }

    public void setEmpDateonboard(Date empDateonboard) {
        this.empDateonboard = empDateonboard;
    }

    public Integer getDpId() {
        return dpId;
    }

    public void setDpId(Integer dpId) {
        this.dpId = dpId;
    }

    public Integer getVerison() {
        return verison;
    }

    public void setVerison(Integer verison) {
        this.verison = verison;
    }

    public Integer getLogicFlag() {
        return logicFlag;
    }

    public void setLogicFlag(Integer logicFlag) {
        this.logicFlag = logicFlag;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", empGender=" + empGender +
                ", empAge=" + empAge +
                ", empDateonboard=" + empDateonboard +
                ", dpId=" + dpId +
                ", verison=" + verison +
                ", logicFlag=" + logicFlag +
                ", department=" + department +
                '}';
    }
}