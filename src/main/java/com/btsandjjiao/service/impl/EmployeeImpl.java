package com.btsandjjiao.service.impl;

import com.btsandjjiao.dao.EmployeeMapper;
import com.btsandjjiao.domain.Employee;
import com.btsandjjiao.domain.EmployeeExample;
import com.btsandjjiao.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class EmployeeImpl implements EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /*查询所有员工*/
    @Override
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /*保存员工信息*/
    @Override
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /*校验员工名字是否可用*/
    @Override
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /*按照员工id查找员工*/
    @Override
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /*按照员工进行更新员工信息*/
    @Override
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }



    /*批量删除*/
    @Override
    public void deleteBatch(List<Integer> del_ids) {
        //按照条件删除
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from xxx where emp_id in (del_ids)
        criteria.andEmpIdIn(del_ids);
        employeeMapper.deleteByExample(example);
    }



    /*单个删除*/
    @Override
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }
}
