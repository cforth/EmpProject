package com.cfxyz.cf.factory;

import com.cfxyz.cf.service.IDeptService;
import com.cfxyz.cf.service.IEmpService;
import com.cfxyz.cf.service.impl.DeptServiceImpl;
import com.cfxyz.cf.service.impl.EmpServiceImpl;

public class ServiceFactory {
	public static IDeptService getIDeptServiceInstance() {
		return new DeptServiceImpl();
	}
	
	public static IEmpService getIEmpServiceInstance() {
		return new EmpServiceImpl() ;
	}
}
