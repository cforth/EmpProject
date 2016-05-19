package com.cfxyz.cf.service.impl;

import com.cfxyz.cf.dbc.DatabaseConnection;
import com.cfxyz.cf.factory.DAOFactory;
import com.cfxyz.cf.service.IAdminService;
import com.cfxyz.cf.vo.Admin;

public class AdminServiceImpl implements IAdminService {
	private DatabaseConnection dbc = new DatabaseConnection();
	@Override
	public boolean login(Admin vo) throws Exception {
		try {
			return DAOFactory.getIAdminDAOInstance(this.dbc.getConnection()).findLogin(vo) ;
		} catch (Exception e) {
			throw e ;
		} finally {
			this.dbc.close();
		}
	}

}
