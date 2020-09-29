package com.ssm.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * ͨ�õķ��ص�lei
 * @author Administrator
 *
 */
public class Msg {
	
	//״̬��
	private int code;
	//��ʾ��Ϣ
	private String msg;
	
	//�û�Ҫ���ظ������������
	private Map<String, Object> extendManagedMap = new HashMap<String, Object>();
	
	public static Msg success() {
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("����ɹ�");
		return result;
	}
	
	public static Msg fail() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("����ʧ��");
		return result;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtendManagedMap() {
		return extendManagedMap;
	}

	public void setExtendManagedMap(Map<String, Object> extendManagedMap) {
		this.extendManagedMap = extendManagedMap;
	}

	public Msg add(String key, Object value) {
		this.getExtendManagedMap().put(key, value);
		return this;
	}
	
}
