package com.cfxyz.cf.dao;

import java.util.List;

import com.cfxyz.cf.vo.Emp;

public interface IEmpDAO extends IDAO<Integer, Emp> {
	/**
	 * 根据部门编号删除所有的雇员信息
	 * @param deptno 部门编号
	 * @throws Exception 执行的SQL异常
	 */
	public void doRemoveByDeptno(Integer deptno) throws Exception;
	
	/**
	 * 表示要查询一个雇员的完整信息，包括领导信息以及所在部门信息
	 * @param id 要查询的雇员编号
	 * @return 如果查询到内容返回VO对象，否则返回空
	 * @throws Exception
	 */
	public Emp findByIdDetails(Integer id) throws Exception ;
	
	/**
	 * 查询详细的雇员信息，包含有雇员的完整信息、领导信息、部门信息
	 * @param column
	 * @param keyWord
	 * @param currentPage
	 * @param lineSize
	 * @return 以List集合方式返回，如果没有数据返回集合长度为0(size == 0);
	 * @throws Exception
	 */
	public List<Emp> findAllSplitDetails(String column, String keyWord, int currentPage, int lineSize) throws Exception ;
}
