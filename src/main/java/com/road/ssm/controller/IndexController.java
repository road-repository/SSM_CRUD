package com.road.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.cj.Session;
import com.road.ssm.bean.Department;
import com.road.ssm.bean.Employee;
import com.road.ssm.bean.JsonMsg;
import com.road.ssm.bean.User;
import com.road.ssm.service.DepartmentService;
import com.road.ssm.service.EmployeeService;
import com.road.ssm.service.UserServeice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {

    @Autowired
    EmployeeService employeeService;

    @Autowired
    DepartmentService departmentService;

    @Autowired
    UserServeice userServeice;

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


    @RequestMapping("/serachEmps")
    @ResponseBody
    public JsonMsg serachEmp(@RequestParam(value = "pn", defaultValue = "1") Integer pn,Employee employee) {
        System.out.println(employee);
        PageHelper.startPage(pn, 7);
        List<Employee> list = employeeService.Serach(employee);
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


    /**
     * 用来做记住密码的方法，把密码信息保存在cookie中
     */
    @ResponseBody
    @RequestMapping(value="/getCookie",method=RequestMethod.POST)
    public Map<String, String> initCookie(String userName, HttpServletRequest request){
        Cookie[] cookie = request.getCookies();
        Map<String, String> map = new HashMap<>();
        for(Cookie c : cookie) {
            if(c.getName().equals(userName)) {
                String password = c.getValue();
                map.put("userName", userName);
                map.put("password", password);
                return map;
            }
        }
        return null;
    }


    /**
     * 登录的时候此方法处理登录请求
     * */
    @RequestMapping("/logins")
    public String logins(User user, HttpServletRequest request,HttpServletResponse response) {
        User user1 = userServeice.getUser(user.getUserName(), user.getUserPassword());
        if (user1 == null) {
            request.setAttribute("msg", "账号或密码错误！");
            return "login";
        }

        HttpSession session = request.getSession();
        session.setAttribute("userName", user.getUserName());

        if (request.getParameter("rememb") != null) {
            addCookie(user.getUserName(), user.getUserPassword(), response, request);
        }

        if(request.getParameter("autoSubmit")!=null){
            addAutoSubmit(user.getUserName(), user.getUserPassword(),request,response);
        }

        return "redirect:list";
    }

    /**
     * 添加自动登录的方法
     * @return
     */
    public void addAutoSubmit(String userName,String passwrod,HttpServletRequest request,HttpServletResponse response){
        Cookie cookie=new Cookie("Auto_"+userName,userName+"_"+passwrod);
        cookie.setPath(request.getContextPath()+"/");
        //设置cookie保存的时间 单位：秒  时间是一周
        cookie.setMaxAge(7*24*60*60);
        //将cookie添加到响应
        response.addCookie(cookie);
    }

    /**/
    @ResponseBody
    @RequestMapping(value="/getAutoSubmit")
    public Map<String, String> autoSubmit(HttpServletRequest request){
        Cookie[] cookie = request.getCookies();
        Map<String, String> map = new HashMap<>();
        for(Cookie c : cookie) {
            if(c.getName().startsWith("Auto_")) {
                String user = c.getValue();
                String[] s = user.split("_");
                map.put("userName",s[0]);
                map.put("password",s[1]);
                return map;
            }
        }
        return null;
    }


    /**
     * 添加Cookie
     * @param userName
     * @param password
     * @param response
     * @param request
     * @throws UnsupportedEncodingException
     */
    public void addCookie(String userName, String password, HttpServletResponse response, HttpServletRequest request){
        //创建cookie
        Cookie nameCookie = new Cookie(userName, password);
        nameCookie.setPath(request.getContextPath()+"/");//设置cookie路径
        //设置cookie保存的时间 单位：秒  时间是一周
        nameCookie.setMaxAge(7*24*60*60);
        //将cookie添加到响应
        response.addCookie(nameCookie);
    }

    /**
     * 注册管理员用户的方法
     */
    @RequestMapping("/regins")
    public String regins(User user){
        try {
            userServeice.addUser(user);
            return "redirect:index.jsp";
        }catch(Exception e){
            return "regin";
        }

    }

    /**
     * 退出登录的方法
     */
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request,HttpServletResponse response){
        Cookie cookie = new Cookie("Auto_"+request.getSession().getAttribute("userName"),"");
        cookie.setPath(request.getContextPath()+"/");
        cookie.setMaxAge(0); //设置立即删除
        response.addCookie(cookie);
        HttpSession session = request.getSession();
        session.invalidate();
        return "redirect:index.jsp";
    }

    @RequestMapping("/list")
    public String list(HttpServletRequest request){
        HttpSession session = request.getSession();

        Object userName = session.getAttribute("userName");
        if(userName!=null){
            return "list";
        }else{
            request.setAttribute("msg", "你还没登录呢！");
            return "login";
        }

    }

    @RequestMapping("/body")
    public String body(){

        return "body";
    }
    @RequestMapping("/menu")
    public String menu(){

        return "menu";
    }
}
