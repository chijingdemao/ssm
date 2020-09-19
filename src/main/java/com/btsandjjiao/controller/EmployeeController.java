package com.btsandjjiao.controller;

import com.btsandjjiao.domain.Employee;
import com.btsandjjiao.domain.Msg;
import com.btsandjjiao.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /*
     * 删除员工信息
     * 批量删除和单个删除合二为一
     * 批量删除：1-2-3
     * 单个删除：1
     * */
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for(String string : str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    /*
     * 更新员工信息
     * */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /*
     * 按照员工id查找员工
     *
     * PathVariable:来自请求地址中的变量
     * */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }


    /*
     * 检查用户名是否可用
     * */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String empName) {

        //先判断用户名是否是合法的表达式
        String regex = "(^[A-Za-z0-9]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if (!empName.matches(regex)) {
            return Msg.fail().add("va_msg", "名字必须是2-5个中文或者3-16位英文数字组合");
        }

        //数据库用户校验
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名被占用");
        }
    }


    /*
    * 员工保存  要进行校验---jquery前端校验，ajax用户名重复校验，重要的数据都要进行后端校验（JSR303）
    *
    * 要支持JSR303校验，导入依赖hibernate-validator
    * */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败，应该返回失败，还是在模态框中显示错误的信息
            Map<String, Object> map = new HashMap<>();
            //提取错误信息
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名:"+fieldError.getField());
                System.out.println("错误的信息:"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }



    //直接返回的是json数据格式的数据
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        PageHelper.startPage(pn,5);
        List<Employee> employeeList=employeeService.getAll();
        PageInfo pageInfo = new PageInfo(employeeList, 5);
        //add的是用户携带的数据
        return Msg.success().add("pageInfo",pageInfo);
    }


    /*
    * 查询员工数据（分页查询）
    *
    * */
    //
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //引入pageHelper分页插件
        //在查询之前，只需要调用页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //紧跟着这个查询就是分页查询
        List<Employee> employeeList=employeeService.getAll();
        //使用PageInfo包装查询过的结果，只需要将PageInfo交给页面就行,5代表连续显示的页数
        PageInfo pageInfo = new PageInfo(employeeList, 5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }
}
