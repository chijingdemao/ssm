package com.btsandjjiao.test;

import com.btsandjjiao.dao.DepartmentMapper;
import com.btsandjjiao.dao.EmployeeMapper;
import com.btsandjjiao.domain.Department;
import com.btsandjjiao.domain.Employee;
import com.github.pagehelper.PageInfo;
import jdk.nashorn.internal.objects.NativeUint16Array;
import org.apache.ibatis.session.SqlSession;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;
import java.util.UUID;

/* Spring单元测试
* 1.@ContextConfiguration指定spring配置文件的位置
* @WebAppConfiguration
* */

@RunWith(SpringJUnit4ClassRunner.class)

@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:dispatcherServlet.xml"})
public class MapperTest {
//    @Autowired
//    WebApplicationContext context;
//
//    MockMvc mockMvc;
//
//    @Before
//    public void initMockMvc(){
//        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
//    }
//
//    @Test
//    public void testPage() throws Exception {
//        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "3"))
//                .andReturn();
//
//        MockHttpServletRequest request = result.getRequest();
//        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
//        System.out.println("当前页码："+pi.getPageNum());
//        System.out.println("总页码："+pi.getPages());
//        System.out.println("总记录数："+pi.getTotal());
//        System.out.println("连续显示的页码：");
//        int[] nums = pi.getNavigatepageNums();
//        for (int i : nums){
//            System.out.print(" "+i);
//        }
//
//        List<Employee> list = pi.getList();
//        for (Employee employee : list){
//            System.out.println("ID:"+employee.getEmpId()+"==>Name:"+employee.getEmpName());
//        }
//    }


    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testMVC(){
        System.out.println(departmentMapper);
        //2.插入几个部分
        //departmentMapper.insertSelective(new Department(null,"研发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));
        //3.生成员工插入
        //employeeMapper.insertSelective(new Employee(null,"jimin","M","jimin@163.com",1));
        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i <1000 ; i++) {
            String uid=UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
        }

    }
}
