package com.btsandjjiao.service.impl;

import com.btsandjjiao.dao.DepartmentMapper;
import com.btsandjjiao.domain.Department;
import com.btsandjjiao.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {


    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getDepts() {
        //查出部门所有的信息
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
