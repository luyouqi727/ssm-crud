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
 * 处理部门信息的相关请求
 * @author Administrator
 *
 */
@Controller		
public class DepartmentController {
	
	@Autowired
	private DepartmentService deptService;
	
	/**
	 * 返回所有部门信息
	 */
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> depts = deptService.getDepts();
		return Msg.success().add("depts", depts);
	}
}
