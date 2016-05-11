package com.cfxyz.cf.service;

import java.util.List;
import java.util.Set;

import com.cfxyz.cf.vo.Dept;

public interface IDeptService {
	public boolean insert(Dept vo) throws Exception ;
	public boolean update(Dept vo) throws Exception ;
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
