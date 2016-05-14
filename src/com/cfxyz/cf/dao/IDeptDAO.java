package com.cfxyz.cf.dao;

import java.util.List;

import com.cfxyz.cf.vo.Dept;

public interface IDeptDAO extends IDAO<Integer, Dept> {
	/**
	 * 实现全部部门完整信息的查询操作，包含的信息内容有：<br>
	 * <li>包含有部门的基础信息：deptno、dname、loc；
	 * <li>包含部门的统计信息：人数、平均工资、最高工资、最低工资、总工资
	 * @return 以List集合的方式返回，如果没有数据则集合长度为0(size()==0)
	 * @throws Exception
	 */
	public List<Dept> findAllByStat() throws Exception ;
	
	/**
	 * 查询单个部门的完整信息，包含的信息内容有：<br>
	 * <li>包含有部门的基础信息：deptno、dname、loc；
	 * <li>包含部门的统计信息：人数、平均工资、最高工资、最低工资、总工资
	 * @param id 部门编号
	 * @return 如果查询出此部门的信息，则以对象的形式返回，否则返回NULL
	 * @throws Exception
	 */
	public Dept findByIdDetails(Integer id) throws Exception ;
}
