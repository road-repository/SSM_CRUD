package com.road.ssm.test;

import com.github.pagehelper.PageInfo;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.road.ssm.bean.Department;
import com.road.ssm.bean.Employee;
import com.road.ssm.dao.DepartmentMapper;
import com.road.ssm.dao.EmployeeMapper;
import com.road.ssm.service.DepartmentService;
import com.road.ssm.service.EmployeeService;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class ControllerTest {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    WebApplicationContext webApplicationContext;

    private MockMvc mockMvc;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    DepartmentMapper departmentMapper;

    @Test
    public void TestMethod() throws Exception {

        //查看Bean的生命周期
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
        ComboPooledDataSource pool = (ComboPooledDataSource) ctx.getBean("dataSource");
        System.out.println(pool.getConnection());
        ctx.close();
    }

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    public void testPage() throws Exception {

        MvcResult pn = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();

        MockHttpServletRequest request = pn.getRequest();

        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");

        System.out.println("当前页码" + pageInfo.getPageNum());

        System.out.println("总页码" + pageInfo.getPages());

        System.out.println("总记录数" + pageInfo.getTotal());

        System.out.println("需要连续显示的页码");
        int[] navigatepageNums = pageInfo.getNavigatepageNums();

        for (int x : navigatepageNums) {
            System.out.println(x);
        }

        System.out.println("获取员工数据");
        List<Employee> list = pageInfo.getList();

        for (Employee emp : list) {
            System.out.println(emp);
        }
    }

    @Test
    public void CreateGenerator() throws Exception {
        List<String> warnings = new ArrayList<String>();
        boolean overwrite = true;
        File configFile = new File("generatorConfig.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
    }

    @Test
    public void CreateData() {

        SqlSession sqlSession = sqlSessionTemplate.getSqlSessionFactory().openSession(ExecutorType.BATCH, false);
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);

//        (数据类型)(最小值+Math.random()*(最大值-最小值+1))
        for (int i = 0; i < 1000; i++) {
            String subName = UUID.randomUUID().toString().substring(0, 4);
            int gender = (int) ((10 * Math.random())) % 2;
            int age = (int) (10 + Math.random() * (40 - 10 + 1));
            int dp = (int) (1 + Math.random() * (5 - 1 + 1));
            Employee employee = new Employee(null, subName, gender, age, null, dp,null,null);
            mapper.insertSelective(employee);
            System.out.println(employee);
            i++;
        }
        sqlSession.commit();
    }


}
