package com.ssm.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ssm.crud.bean.Employee;
import com.ssm.crud.dao.DepartmentMapper;
import com.ssm.crud.dao.EmployeeMapper;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlsesson;
	/**
	 * 测试DepartmentMapper
	 */
	@Test
	public void testCRUD() {
		/*
		 * //1.创建SpringIOC容器 ApplicationContext ioc = new
		 * ClassPathXmlApplicationContext("applicationContext.xml"); 
		 * //2.从容器中获取mapper
		 * DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
		 */
		
		System.out.println(departmentMapper);
		
		//1.插入部门
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));
		
		//2.插入员工
//		employeeMapper.insertSelective(new Employee(null,"jack","M","jack@qq.com",1));
		
		//3.批量插入
		EmployeeMapper mapper = sqlsesson.getMapper(EmployeeMapper.class);
		for(int i=0; i<1000; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null, uid, "M" , uid+"@qq.com",1));
		}
	}
}
