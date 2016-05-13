package com.cfxyz.cf.dao;

import com.cfxyz.cf.vo.Emp;

public interface IEmpDAO extends IDAO<Integer, Emp> {
	/**
	 * 根据部门编号删除所有的雇员信息
	 * @param deptno 部门编号
	 * @throws Exception 执行的SQL异常
	 */
	public void doRemoveByDeptno(Integer deptno) throws Exception;
}
