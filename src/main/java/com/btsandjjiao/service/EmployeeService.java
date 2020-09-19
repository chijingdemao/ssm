package com.btsandjjiao.service;

import com.btsandjjiao.domain.Employee;

import java.util.List;

public interface EmployeeService {

    List<Employee> getAll();

    void saveEmp(Employee employee);

    boolean checkUser(String empName);

    Employee getEmp(Integer id);

    void updateEmp(Employee employee);

    void deleteBatch(List<Integer> del_ids);

    void deleteEmp(Integer id);
}
