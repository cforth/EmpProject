package com.cfxyz.cf.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.cfxyz.cf.vo.Emp;

public interface IEmpService {
	public boolean insert(Emp vo) throws Exception ;
	
	public boolean update(Emp vo) throws Exception ;
	
	public boolean delete(Set<Integer> ids) throws Exception ;
	
	public List<Emp> list() throws Exception ;
	
	public Map<String,Object> list(String column, String keyWord,
			int currentPage, int lineSize) throws Exception ;
	
	/**
	 * 根据编号查看雇员信息
	 * @param id 雇员的编号
	 * @return 如果查询到数据以VO对象形式返回，否则返回null
	 * @throws Exception
	 */
	public Emp show(int id) throws Exception ;
	
	/**
	 * 表示在进行雇员增加前的准备操作，因为增加雇员前要查询所有的雇员和所有的部门数据
	 * @return 返回两组信息，一个是全部的雇员信息另外一个是全部的部门信息：<br>
	 * <li>key = allEmps , values = IEmpDAO.findAll()查询出所有的雇员</li>
	 * @throws Exception
	 */
	public Map<String,Object> insertPre() throws Exception ;
	
	/**
	 * 表示在进行雇员修改前的准备操作，因为修改雇员前要查询所有的雇员和所有的部门数据
	 * @return 返回三组信息：<br>
	 * <li>key = allEmps , values = IEmpDAO.findAll()查询出所有的雇员</li>
	 * <li>key = emp , values = IEmpDAO.findByIdDetails()查询雇员完整雇员</li>
	 * @throws Exception
	 */
	public Map<String,Object> updatePre(int id) throws Exception ;
	
	/**
	 * 使用详细列表的方式列出雇员的完整信息，要执行如下操作：<br>
	 * <li>调用IEmpDAO.findAllSplitDetails()方法详细列出雇员信息；</li>
	 * <li>调用IEmpDAO.getAllCount()方法详细列出详细的雇员人数，主要用于分页操作；</li>
	 * @param column
	 * @param keyWord
	 * @param currentPage
	 * @param lineSize
	 * @return 所有的内容以Map集合返回，返回的内容如下：<br>
	 * <li>key = allEmps, value = IEmpDAO.findAllSplitDetails()</li>
	 * <li>key = allCount, value = IEmpDAO.getAllCount()</li>
	 * @throws Exception
	 */
	public Map<String,Object> listDetails(String column, String keyWord,
			int currentPage, int lineSize) throws Exception ;
}
