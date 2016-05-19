package com.cfxyz.cf.factory;

import com.cfxyz.cf.service.IAdminService;
import com.cfxyz.cf.service.IDeptService;
import com.cfxyz.cf.service.IEmpService;
import com.cfxyz.cf.service.impl.AdminServiceImpl;
import com.cfxyz.cf.service.impl.DeptServiceImpl;
import com.cfxyz.cf.service.impl.EmpServiceImpl;

public class ServiceFactory {
	public static IDeptService getIDeptServiceInstance() {
		return new DeptServiceImpl();
	}
	
	public static IEmpService getIEmpServiceInstance() {
		return new EmpServiceImpl() ;
	}
	
	public static IAdminService getIAdminServiceInstance() {
		return new AdminServiceImpl() ;
	}
}
