package com.cfxyz.cf.vo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

@SuppressWarnings("serial")
public class Dept implements Serializable {
	private Integer deptno ;
	private String dname ;
	private String loc ;
	private List<Emp> emps ; //描述多个雇员
	private Map<String,Object> stat ; //保存所有的统计信息
	public Map<String, Object> getStat() {
		return stat;
	}
	public void setStat(Map<String, Object> stat) {
		this.stat = stat;
	}
	public List<Emp> getEmps() {
		return emps;
	}
	public void setEmps(List<Emp> emps) {
		this.emps = emps;
	}
	public Integer getDeptno() {
		return deptno;
	}
	public void setDeptno(Integer deptno) {
		this.deptno = deptno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
}
