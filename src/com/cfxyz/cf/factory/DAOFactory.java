package com.cfxyz.cf.factory;

import java.sql.Connection;

import com.cfxyz.cf.dao.IAdminDAO;
import com.cfxyz.cf.dao.IDeptDAO;
import com.cfxyz.cf.dao.IEmpDAO;
import com.cfxyz.cf.dao.impl.AdminDAOImpl;
import com.cfxyz.cf.dao.impl.DeptDAOImpl;
import com.cfxyz.cf.dao.impl.EmpDAOImpl;

public class DAOFactory {
	public static IDeptDAO getIDeptDAOInstance(Connection conn) {
		return new DeptDAOImpl(conn);
	}
	
	public static IEmpDAO getIEmpDAOInstance(Connection conn) {
		return new EmpDAOImpl(conn);
	}
	
	public static IAdminDAO getIAdminDAOInstance(Connection conn) {
		return new AdminDAOImpl(conn);
	}
}
