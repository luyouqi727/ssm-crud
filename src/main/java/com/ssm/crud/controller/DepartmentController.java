package com.ssm.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssm.crud.bean.Department;
import com.ssm.crud.bean.Msg;
import com.ssm.crud.service.DepartmentService;


/**
 * ��������Ϣ���������
 * @author Administrator
 *
 */
@Controller		
public class DepartmentController {
	
	@Autowired
	private DepartmentService deptService;
	
	/**
	 * �������в�����Ϣ
	 */
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> depts = deptService.getDepts();
		return Msg.success().add("depts", depts);
	}
}
