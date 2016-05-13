package com.cfxyz.cf.service;

import java.util.List;
import java.util.Set;

import com.cfxyz.cf.vo.Dept;

public interface IDeptService {
	public boolean insert(Dept vo) throws Exception ;
	public boolean update(Dept vo) throws Exception ;
	/**
	 * 批量删除部门数据，此方法有两个操作:
	 * <li>首先要删除此部门的所有雇员数据，调用IEmpDAO.doRemoveByDeptno()方法；</li>
	 * <li>之后要删除本部门的所有数据，调用IDeptDAO.doRemoveBatch()方法；</li>
	 * @param ids 所有要删除的部门编号
	 * @return 如果删除成功返回true，否则返回false
	 * @throws Exception
	 */
	public boolean delete(Set<Integer> ids) throws Exception ;
	public List<Dept> list() throws Exception ;
	/**
	 * 是更新前的数据查询操作，与get()类似
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Dept updatePre(Integer id) throws Exception ;
}
