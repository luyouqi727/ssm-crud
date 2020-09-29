package com.ssm.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.crud.bean.Employee;
import com.ssm.crud.bean.EmployeeExample;
import com.ssm.crud.bean.EmployeeExample.Criteria;
import com.ssm.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工保存方法
	 */
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
		
	}

	/**
	 * 检查用户名是否可用
	 * @param empName
	 * @return true为可用，false为不可用
	 */
	public boolean checkEmpName(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 单个员工查询
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 * 员工更新
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	/**
	 * 单个删除
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	/**
	 * 批量删除
	 * @param ids
	 */
	public void deleteBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
		
	}

}
