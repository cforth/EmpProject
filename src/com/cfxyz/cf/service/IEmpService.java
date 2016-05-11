package com.cfxyz.cf.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.cfxyz.cf.vo.Emp;

public interface IEmpService {
	public boolean insert(Emp vo) throws Exception ;
	
	public boolean update(Emp vo) throws Exception ;
	
	public Emp updatePre(int id) throws Exception ;
	
	public boolean delete(Set<Integer> ids) throws Exception ;
	
	public List<Emp> list() throws Exception ;
	
	public Map<String,Object> list(String column, String keyWord,
			int currentPage, int lineSize) throws Exception ;
	
}
