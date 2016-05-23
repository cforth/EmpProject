package com.cfxyz.cf.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.cfxyz.cf.dbc.DatabaseConnection;
import com.cfxyz.cf.factory.DAOFactory;
import com.cfxyz.cf.service.IDeptService;
import com.cfxyz.cf.vo.Dept;

public class DeptServiceImpl implements IDeptService {
	private DatabaseConnection dbc = new DatabaseConnection();
	
	@Override
	public boolean insert(Dept vo) throws Exception {
		try {
			if(DAOFactory.getIDeptDAOInstance(this.dbc.getConnection()).findById(vo.getDeptno()) == null) {
				return DAOFactory.getIDeptDAOInstance(this.dbc.getConnection()).doCreate(vo);
			}
			return false;
		} catch (Exception e) {
			throw e;
		} finally {
			this.dbc.close();
		}
	}

	@Override
	public boolean update(Dept vo) throws Exception {
		try {
			return DAOFactory.getIDeptDAOInstance(this.dbc.getConnection()).doUpdate(vo);
		} catch (Exception e) {
			throw e;
		} finally {
			this.dbc.close();
		}
	}

	@Override
	public Map<String,Object> delete(Set<Integer> ids) throws Exception {
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			//查询出所有部门中的雇员照片
			Set<String> photos = DAOFactory.getIEmpDAOInstance(this.dbc.getConnection()).findAllPhotoByDeptno(ids);
			//1、取消掉事务的自动提交
			this.dbc.getConnection().setAutoCommit(false);
			boolean flag = false ; //表示最终是否成功的标记
			//2.删除所有雇员
			Iterator<Integer> iter = ids.iterator();
			while(iter.hasNext()) {
				//根据部门编号删除每一个部门的所有雇员信息
				DAOFactory.getIEmpDAOInstance(this.dbc.getConnection()).doRemoveByDeptno(iter.next());
			}
			//3、删除所有的部门信息
			flag = DAOFactory.getIDeptDAOInstance(this.dbc.getConnection()).doRemoveBatch(ids);
			map.put("flag", flag);
			if(flag) { //表示数据正常删除
				map.put("allPhotos", photos);
			}
			this.dbc.getConnection().commit();
			return map ;
		} catch (Exception e) {
			this.dbc.getConnection().rollback();
			throw e;
		} finally {
			this.dbc.close();
		}
	}

	@Override
	public Dept updatePre(Integer id) throws Exception {
		try {
			return DAOFactory.getIDeptDAOInstance(this.dbc.getConnection()).findById(id) ;
		} catch (Exception e) {
			throw e;
		} finally {
			this.dbc.close();
		}
	}

	@Override
	public List<Dept> list() throws Exception {
		try {
			return DAOFactory.getIDeptDAOInstance(this.dbc.getConnection()).findAll();
		} catch (Exception e) {
			throw e;
		} finally {
			this.dbc.close();
		}
	}

	@Override
	public List<Dept> listDetails() throws Exception {
		try {
			return DAOFactory.getIDeptDAOInstance(this.dbc.getConnection()).findAllByStat();
		} catch (Exception e) {
			throw e;
		} finally {
			this.dbc.close();
		}
	}

	@Override
	public Dept show(Integer id, String column, String keyWord,
			int currentPage, int lineSize) throws Exception {
		try {
			Dept dept = DAOFactory.getIDeptDAOInstance(this.dbc.getConnection()).findByIdDetails(id) ;
			if(dept != null) { //有这个部门信息
				dept.setEmps(DAOFactory.getIEmpDAOInstance(this.dbc.getConnection()).findAllByDeptno(id, column, keyWord, currentPage, lineSize));
			}
			return dept;
		} catch (Exception e) {
			throw e;
		} finally {
			this.dbc.close();
		}
	}

}
