package com.btsandjjiao.test;
/*
* 使用spring测试配置提供的测试请求功能，测试curd请求的正确性
*
* */
import com.btsandjjiao.domain.Employee;
import com.github.pagehelper.PageInfo;
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

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:dispatcherServlet.xml"})
public class MvcTest {
    @Autowired
    WebApplicationContext context;

    //虚拟Mvc请求，获取请求结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求，获取返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "99"))
                .andReturn();

        //请求成功之后，请求域中获取pageInfo
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码："+pi.getPageNum());
        System.out.println("总页码："+pi.getPages());
        System.out.println("总记录数："+pi.getTotal());
        System.out.println("连续显示的页码：");
        int[] nums = pi.getNavigatepageNums();
        for (int i : nums){
            System.out.print(" "+i);
        }
        System.out.println("=================================");

        List<Employee> list = pi.getList();
        for (Employee employee : list){
            System.out.println("ID:"+employee.getEmpId()+"==>Name:"+employee.getEmpName());
        }
    }
}
