package com.road.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.road.ssm.bean.Department;
import com.road.ssm.bean.Employee;
import com.road.ssm.bean.JsonMsg;
import com.road.ssm.service.DepartmentService;
import com.road.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class IndexController {

    @Autowired
    EmployeeService employeeService;

    @Autowired
    DepartmentService departmentService;

    /**
     * 解析员工列表信息的解析器
     *
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public JsonMsg getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 7);
        List<Employee> list = employeeService.getAll();
        PageInfo page = new PageInfo(list, 5);

        return JsonMsg.success().addData("pageInfo", page);
    }

    /**
     * 获取所有部门信息的视图
     *
     * @return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public JsonMsg getDept() {
        List<Department> departments = departmentService.getDepartments();
        return JsonMsg.success().addData("depts", departments);
    }

    /**
     * 添加员工
     *
     * @param emp
     * @return
     */
    @RequestMapping(value = "/addemp", method = RequestMethod.POST)
    public String addEmp(Employee emp) {
        employeeService.addEmp(emp);
        return "../../index";
    }

    /**
     * 修改员工
     *
     * @param emp
     * @return
     */
    @RequestMapping("/editEmp")
    public String editEmp(Employee emp) {
        Integer editReturned = employeeService.editEmp(emp);
        return "../../index";
    }

    /**
     * 删除员工
     *
     * @param id
     * @return
     */
    @RequestMapping("/delEmp")
    @ResponseBody
    public JsonMsg delEmp(@RequestParam Integer id) {
        Integer delReturned = employeeService.deleteEmp(id);
        return JsonMsg.success().addData("delReturned", delReturned);
    }

    /**
     * 删除一页的数据
     *
     * @param id
     * @return
     */

    @RequestMapping("/delPageEmp")
    @ResponseBody
    public JsonMsg delEmps(@RequestParam Integer delPage) {

        try {
            boolean retu = true;

            try {
                PageHelper.startPage(delPage, 7);
                List<Employee> list = employeeService.getAll();
                PageInfo page = new PageInfo(list, 5);
                List<Employee> pages = page.getList();

                for (int x = 0; x < pages.size(); x++) {
                    Employee emp = pages.get(x);
                    Integer delReturned = employeeService.deleteEmp(emp.getEmpId());
                }
            } catch (Exception e) {
                retu=false;
            }
            if (retu == true) {
                return JsonMsg.success().addData("delReturned", "删除成功");
            } else {
                return JsonMsg.success().addData("delReturned", "删除失败");
            }
        } catch (Exception e) {
            return JsonMsg.success().addData("delReturned", "删除失败");
        }
    }

    @RequestMapping("/getEmp")
    @ResponseBody
    public JsonMsg getEmp(@RequestParam Integer id) {
        Employee empReturned = employeeService.getEmp(id);
        return JsonMsg.success().addData("empReturned", empReturned);
    }

    @RequestMapping("/login")
    public String string(){
        return "login";
    }

}
