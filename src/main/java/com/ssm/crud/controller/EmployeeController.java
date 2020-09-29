package com.ssm.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.crud.bean.Employee;
import com.ssm.crud.bean.Msg;
import com.ssm.crud.service.EmployeeService;

/**
 * 处理员工crud请求
 * @author Administrator
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
		
	
	/**
	 * 单个删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/deleteEmp/{Id}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("Id") String ids) {
		if(ids.contains("-")) {
			//批量删除
			List<Integer> list = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			//组装id集合
			for (String id : str_ids) {
				list.add(Integer.parseInt(id));
			}
			employeeService.deleteBatch(list);
			
		}else {
			//单个删除
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}
	
	/**
	 * 保存修改方法
	 * ajax若直接发送put请求tomcat无法正常获取请求体中的数据，需要配置HttpPutFormContentFilter过滤器
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/updateEmp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee){
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 根据员工id查询员工信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	/**
	 * 检查用户名是否可用
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkEmpName")
	@ResponseBody
	public Msg checkEmpName(@RequestParam("empName") String empName) {
		//检查用户名是否可用
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		if(!empName.matches(regx)) {
			return Msg.fail().add("check_res", "用户名可以是2-5位中文或6-16位英文或数字");
		}
		
		//数据库用户名校验
		boolean res = employeeService.checkEmpName(empName);
		if(res) {
			return Msg.success();
		}else {
			return Msg.fail().add("check_res", "用户名不可用");
		}
	}
	
	/**
	 * 保存员工
	 * @param employee
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/saveEmp" ,method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		//检查校验结果
		if(result.hasErrors()) {
			Map<String, Object> map = new HashMap<String, Object>();
			//校验失败，返回错误信息
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError fieldError : fieldErrors) {
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorField", map);
		}else {
			//校验成功，保存员工
			employeeService.saveEmp(employee);
			return Msg.success();
		}
		
	}
	
	/**
	 * 查询员工信息（分页）
	 * @ResponseBody正常工作需要导入jackson包
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn) {
		//引入分页插件:传入页码和每页数据数
				PageHelper.startPage(pn, 5);
				//查询数据
				List<Employee> emps = employeeService.getAll();
			
				//使用pageinfo包装数据结果
				PageInfo page = new PageInfo(emps,5);
				return Msg.success().add("pageInfo",page);
	}

	/**
	 * 查询员工信息（分页）
	 * @param pn
	 * @param model
	 * @return
	 */
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model) {
		
		//引入分页插件:传入页码和每页数据数
		PageHelper.startPage(pn, 5);
		//查询数据
		List<Employee> emps = employeeService.getAll();
		//使用pageinfo包装数据结果
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		
		return "list";
	}
}
