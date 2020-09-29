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
 * ����Ա��crud����
 * @author Administrator
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
		
	
	/**
	 * ����ɾ��
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/deleteEmp/{Id}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("Id") String ids) {
		if(ids.contains("-")) {
			//����ɾ��
			List<Integer> list = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			//��װid����
			for (String id : str_ids) {
				list.add(Integer.parseInt(id));
			}
			employeeService.deleteBatch(list);
			
		}else {
			//����ɾ��
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}
	
	/**
	 * �����޸ķ���
	 * ajax��ֱ�ӷ���put����tomcat�޷�������ȡ�������е����ݣ���Ҫ����HttpPutFormContentFilter������
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
	 * ����Ա��id��ѯԱ����Ϣ
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
	 * ����û����Ƿ����
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkEmpName")
	@ResponseBody
	public Msg checkEmpName(@RequestParam("empName") String empName) {
		//����û����Ƿ����
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		if(!empName.matches(regx)) {
			return Msg.fail().add("check_res", "�û���������2-5λ���Ļ�6-16λӢ�Ļ�����");
		}
		
		//���ݿ��û���У��
		boolean res = employeeService.checkEmpName(empName);
		if(res) {
			return Msg.success();
		}else {
			return Msg.fail().add("check_res", "�û���������");
		}
	}
	
	/**
	 * ����Ա��
	 * @param employee
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/saveEmp" ,method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		//���У����
		if(result.hasErrors()) {
			Map<String, Object> map = new HashMap<String, Object>();
			//У��ʧ�ܣ����ش�����Ϣ
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError fieldError : fieldErrors) {
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorField", map);
		}else {
			//У��ɹ�������Ա��
			employeeService.saveEmp(employee);
			return Msg.success();
		}
		
	}
	
	/**
	 * ��ѯԱ����Ϣ����ҳ��
	 * @ResponseBody����������Ҫ����jackson��
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn) {
		//�����ҳ���:����ҳ���ÿҳ������
				PageHelper.startPage(pn, 5);
				//��ѯ����
				List<Employee> emps = employeeService.getAll();
			
				//ʹ��pageinfo��װ���ݽ��
				PageInfo page = new PageInfo(emps,5);
				return Msg.success().add("pageInfo",page);
	}

	/**
	 * ��ѯԱ����Ϣ����ҳ��
	 * @param pn
	 * @param model
	 * @return
	 */
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model) {
		
		//�����ҳ���:����ҳ���ÿҳ������
		PageHelper.startPage(pn, 5);
		//��ѯ����
		List<Employee> emps = employeeService.getAll();
		//ʹ��pageinfo��װ���ݽ��
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		
		return "list";
	}
}
